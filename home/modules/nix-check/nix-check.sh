#!/usr/bin/env bash
set -euo pipefail

# ── colours ────────────────────────────────────────────────────────────────
BOLD='\033[1m'
CYAN='\033[0;36m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
RED='\033[0;31m'
DIM='\033[2m'
RESET='\033[0m'

# ── helpers ─────────────────────────────────────────────────────────────────
box_line() { printf "│ %-*s │\n" "$BOX_WIDTH" "$1"; }

box_top() { printf "╭─%s─╮\n" "$(printf '─%.0s' $(seq 1 $BOX_WIDTH))"; }
box_bottom() { printf "╰─%s─╯\n" "$(printf '─%.0s' $(seq 1 $BOX_WIDTH))"; }
box_sep() { printf "├─%s─┤\n" "$(printf '─%.0s' $(seq 1 $BOX_WIDTH))"; }

# strip ANSI codes for length calculation
strip_ansi() {
  local s="$1"
  while [[ "$s" =~ $'\x1b'\[[0-9\;]*m ]]; do
    s="${s//${BASH_REMATCH[0]}/}"
  done
  echo "$s"
}

# print a coloured line inside the box, padding correctly
box_coloured() {
  local raw
  raw=$(strip_ansi "$1")
  local pad=$((BOX_WIDTH - ${#raw}))
  ((pad < 0)) && pad=0
  printf "│ %b%*s │\n" "$1" "$pad" ""
}

BOX_WIDTH=58

# ── locate flake.lock ────────────────────────────────────────────────────────
find_flake_lock() {
  local candidates=(
    "$HOME/dotfiles/flake.lock"
    "$HOME/.config/nixos/flake.lock"
    "/etc/nixos/flake.lock"
  )
  for f in "${candidates[@]}"; do
    [[ -f "$f" ]] && echo "$f" && return
  done
  # fallback: walk up from current dir
  local dir="$PWD"
  while [[ "$dir" != "/" ]]; do
    [[ -f "$dir/flake.lock" ]] && echo "$dir/flake.lock" && return
    dir=$(dirname "$dir")
  done
  echo ""
}

# ── parse flake.lock ─────────────────────────────────────────────────────────
get_lock_info() {
  local lock="$1"
  # extract nixpkgs node — handles "nixpkgs", "nixpkgs_2", etc.
  local node
  node=$(jq -r '
    .nodes |
    to_entries[] |
    select(.key | test("^nixpkgs")) |
    .key
  ' "$lock" | head -1)

  [[ -z "$node" ]] && echo "" && return

  local rev branch
  rev=$(jq -r ".nodes[\"$node\"].locked.rev // empty" "$lock")
  # lastModified as fallback date
  local last_mod
  last_mod=$(jq -r ".nodes[\"$node\"].locked.lastModified // empty" "$lock")

  # try to infer branch from the original flakeref
  branch=$(jq -r ".nodes[\"$node\"].original.ref // empty" "$lock")
  [[ -z "$branch" ]] && branch="nixos-unstable" # sensible default

  echo "$rev|$branch|$last_mod"
}

# ── fetch latest nixpkgs commit from github ──────────────────────────────────
get_latest_rev() {
  local branch="$1"
  # git/refs endpoint returns an object (or array if ambiguous) with .object.sha
  local api_url="https://api.github.com/repos/NixOS/nixpkgs/git/refs/heads/${branch}"
  local resp
  resp=$(curl -sf \
    -H "Accept: application/vnd.github.v3+json" \
    "$api_url" 2>/dev/null) || {
    echo ""
    return
  }
  # returns either an object or array depending on ref ambiguity — handle both
  jq -r 'if type == "array" then .[0].object.sha else .object.sha end // empty' <<<"$resp"
}

# ── get version of a package in a given nixpkgs rev ──────────────────────────
get_pkg_version() {
  local nixpkgs_ref="$1" # e.g. github:NixOS/nixpkgs/abc123
  local pkg="$2"
  nix eval --raw "${nixpkgs_ref}#${pkg}.version" 2>/dev/null || echo ""
}

# ── get installed packages from current profile ───────────────────────────────
get_installed_packages() {
  nix profile list --json 2>/dev/null |
    jq -r '.elements | to_entries[] | .value.attrPath // empty' |
    sed 's/^legacyPackages\.x86_64-linux\.//' |
    sort -u
}

# ── main info box ─────────────────────────────────────────────────────────────
show_info() {
  local lock_file="$1"

  # nix version
  local nix_ver
  nix_ver=$(nix --version 2>/dev/null | awk '{print $NF}')

  box_top
  box_coloured "${BOLD}${CYAN}  nix-check${RESET}"
  box_sep

  box_coloured "  ${DIM}Nix binary${RESET}    ${BOLD}${nix_ver}${RESET}"

  if [[ -z "$lock_file" ]]; then
    box_coloured "  ${YELLOW}⚠ No flake.lock found${RESET}"
    box_bottom
    return
  fi

  local info
  info=$(get_lock_info "$lock_file")
  if [[ -z "$info" ]]; then
    box_coloured "  ${YELLOW}⚠ No nixpkgs input found in flake.lock${RESET}"
    box_bottom
    return
  fi

  local cur_rev branch last_mod
  IFS='|' read -r cur_rev branch last_mod <<<"$info"

  local short_rev="${cur_rev:0:10}"
  local lock_date=""
  if [[ -n "$last_mod" ]]; then
    lock_date=$(date -d "@$last_mod" "+%Y-%m-%d" 2>/dev/null ||
      date -r "$last_mod" "+%Y-%m-%d" 2>/dev/null ||
      echo "")
  fi

  box_coloured "  ${DIM}nixpkgs branch${RESET} ${BOLD}${branch}${RESET}"
  box_coloured "  ${DIM}locked rev${RESET}     ${BOLD}${short_rev}${RESET}  ${DIM}${lock_date}${RESET}"
  box_coloured "  ${DIM}lock file${RESET}      ${DIM}${lock_file}${RESET}"
  box_sep

  # fetch latest
  printf "│ %-*s │\r" "$BOX_WIDTH" "  checking upstream…"
  local latest_rev
  latest_rev=$(get_latest_rev "$branch")

  if [[ -z "$latest_rev" ]]; then
    box_coloured "  ${YELLOW}⚠ Could not reach GitHub API${RESET}"
  elif [[ "$latest_rev" == "$cur_rev" ]]; then
    box_coloured "  ${GREEN}✓ nixpkgs is up to date${RESET}"
  else
    local short_latest="${latest_rev:0:10}"
    box_coloured "  ${YELLOW}↑ nixpkgs update available${RESET}"
    box_coloured "    ${DIM}current ${RESET}${short_rev}"
    box_coloured "    ${DIM}latest  ${RESET}${GREEN}${short_latest}${RESET}"
    box_coloured "  ${DIM}run: nix flake update${RESET}"
  fi

  box_bottom
}

# ── package update checker ────────────────────────────────────────────────────
show_updates() {
  local lock_file="$1"
  shift
  local pkg_filter=("$@") # optional: specific packages to check

  if [[ -z "$lock_file" ]]; then
    echo -e "${RED}error:${RESET} no flake.lock found"
    exit 1
  fi

  local info
  info=$(get_lock_info "$lock_file")
  if [[ -z "$info" ]]; then
    echo -e "${RED}error:${RESET} no nixpkgs input in flake.lock"
    exit 1
  fi

  local cur_rev branch _
  IFS='|' read -r cur_rev branch _ <<<"$info"

  echo -e "\n${BOLD}fetching latest nixpkgs rev for ${CYAN}${branch}${RESET}${BOLD}…${RESET}"
  local latest_rev
  latest_rev=$(get_latest_rev "$branch")

  if [[ -z "$latest_rev" ]]; then
    echo -e "${RED}error:${RESET} could not reach GitHub API"
    exit 1
  fi

  if [[ "$latest_rev" == "$cur_rev" ]]; then
    echo -e "${GREEN}✓ already on latest nixpkgs — nothing to show${RESET}\n"
    return
  fi

  local cur_nixpkgs="github:NixOS/nixpkgs/${cur_rev}"
  local new_nixpkgs="github:NixOS/nixpkgs/${latest_rev}"

  # decide which packages to check
  local packages=()
  if [[ ${#pkg_filter[@]} -gt 0 ]]; then
    packages=("${pkg_filter[@]}")
  else
    echo -e "${DIM}reading installed packages…${RESET}"
    mapfile -t packages < <(get_installed_packages)
    if [[ ${#packages[@]} -eq 0 ]]; then
      echo -e "${YELLOW}⚠ no packages found via nix profile — try passing package names manually${RESET}"
      echo -e "${DIM}  usage: nix-check --updates pkg1 pkg2 …${RESET}\n"
      return
    fi
  fi

  echo -e "${DIM}checking ${#packages[@]} package(s) — this may take a moment…${RESET}\n"

  local updated_count=0
  local checked_count=0

  BOX_WIDTH=62
  box_top
  box_coloured "${BOLD}  Package Updates  ${DIM}(${branch})${RESET}"
  box_sep

  for pkg in "${packages[@]}"; do
    local cur_ver new_ver
    cur_ver=$(get_pkg_version "$cur_nixpkgs" "$pkg")
    new_ver=$(get_pkg_version "$new_nixpkgs" "$pkg")
    ((checked_count++)) || true

    [[ -z "$cur_ver" || -z "$new_ver" ]] && continue
    [[ "$cur_ver" == "$new_ver" ]] && continue

    local line
    line=$(printf "  %-22s  ${DIM}v%s${RESET}  →  ${GREEN}v%s${RESET}" \
      "$pkg" "$cur_ver" "$new_ver")
    box_coloured "$line"
    ((updated_count++)) || true
  done

  box_sep
  if [[ $updated_count -eq 0 ]]; then
    box_coloured "  ${GREEN}✓ all packages up to date${RESET}"
  else
    box_coloured "  ${YELLOW}${updated_count} update(s) available${RESET}  ${DIM}run: nix flake update${RESET}"
  fi
  box_bottom
  echo ""
}

# ── entry point ───────────────────────────────────────────────────────────────
usage() {
  echo -e "${BOLD}Usage:${RESET}"
  echo -e "  nix-check                    — show nix + nixpkgs status"
  echo -e "  nix-check --updates          — check all installed packages"
  echo -e "  nix-check --updates pkg …   — check specific packages"
  echo -e "  nix-check --help"
}

LOCK_FILE=$(find_flake_lock)

case "${1:-}" in
--updates | -u)
  shift
  show_info "$LOCK_FILE"
  echo ""
  show_updates "$LOCK_FILE" "$@"
  ;;
--help | -h)
  usage
  ;;
"")
  show_info "$LOCK_FILE"
  echo ""
  ;;
*)
  echo -e "${RED}unknown flag: $1${RESET}"
  usage
  exit 1
  ;;
esac
