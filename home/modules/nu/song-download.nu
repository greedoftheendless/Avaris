#!/usr/bin/env nu

def write-log [log_file: string]: string -> nothing {
    if ($log_file | is-empty) { return }
    let plain = $in | ansi strip | str trim
    if ($plain | is-not-empty) {
        $"($plain)\n" | save --append $log_file
    }
}

def run-ytdlp-stream [args: list<string>, verbose: bool, log_file: string]: nothing -> int {
    if $verbose {
        ^yt-dlp ...$args o+e>| lines | each { print $in } | ignore
    } else {
        let state = ^yt-dlp --newline ...$args o+e>| lines | reduce --fold {first: true, needs_nl: false} { |raw_line, acc|
            let line = $raw_line | str replace --all "\r" ""
            if ($line | is-empty) {
                $acc
            } else {
                $line | write-log $log_file
                match $line {
                    _ if ($line | str contains "[download]") and ($line | str contains "%") => {
                        print --no-newline $"\r  ($line)(ansi erase_line)"
                        {first: false, needs_nl: true}
                    }
                    _ if ($line | str contains "[Merger]") => {
                        print --no-newline $"\r  (ansi blue)Merging streams...(ansi reset)(ansi erase_line)"
                        {first: false, needs_nl: true}
                    }
                    _ if ($line | str contains "ERROR:") => {
                        if $acc.needs_nl { print "" }
                        print $"  (ansi red)($line)(ansi reset)"
                        {first: true, needs_nl: false}
                    }
                    _ => { $acc }
                }
            }
        }
        if $state.needs_nl { print "" }
    }
    $env.LAST_EXIT_CODE
}

def ask-bool [prompt: string]: nothing -> bool {
    input $"  (ansi attr_bold)[?](ansi reset) ($prompt) [y/N]: " | str trim | str lowercase | str starts-with "y"
}

def shell-quote []: string -> string {
    let s = $in | str replace --all "'" "'\\''"
    $"'($s)'"
}

def load-config [config_file: string, key: string, default_path: string]: nothing -> string {
    if ($config_file | path exists) {
        open $config_file | get -o $key
    } | default $default_path
}

def setup-log-file [log_dir: string, name: string]: nothing -> string {
    mkdir $log_dir
    let safe_name = $name | str replace --regex --all '[<>:"/\\|?*]' ""
    let log_path = [$log_dir, $"(date now | format date '%m-%d-%y - %H%M') - ($safe_name).log"] | path join
    "" | save $log_path
    $log_path
}

const CONFIG_FILE = ("~/.config/snag/config.json" | path expand)
const LOG_DIR = ("~/.config/snag/logs" | path expand)
const DEFAULT_MUSIC_DIR = ("~/Music" | path expand)

def title-case []: string -> string {
    split row " "
    | each { if ($in | is-empty) { $in } else { str capitalize } }
    | str join " "
}

def save-config [music_dir: string]: nothing -> nothing {
    mkdir ($CONFIG_FILE | path dirname)
    {music_dir: $music_dir} | save --force $CONFIG_FILE
    print $"(ansi green)Configuration saved.(ansi reset)"
}

def sanitize-filename []: string -> string {
    $in | str replace --regex --all '[<>:"/\\|?*]' "" | str trim
}

def verify-url [url: string]: nothing -> nothing {
    let result = ^yt-dlp --flat-playlist --print "%(title)s" $url | complete
    if $result.exit_code != 0 or ($result.stdout | str trim | is-empty) {
        error make {msg: $"Could not reach or parse URL: ($url)"}
    }
}

def extract-song-metadata [url: string]: nothing -> record {
    let result = ^yt-dlp --dump-json --no-warnings $url | complete
    if $result.exit_code != 0 or ($result.stdout | str trim | is-empty) {
        return {}
    }
    try {
        let data = $result.stdout | str trim | lines | first | from json
        let artist_raw = ($data.artist? | default $data.uploader? | default $data.channel? | default "Unknown Artist") | into string
        let artist = $artist_raw | str replace --regex " - Topic$" "" | title-case
        {
            title: (($data.title? | default "Unknown Title") | into string)
            artist: $artist
            artist_folder: ($artist | split row "," | first | str trim)
            album: (try { (($data.album? | default "") | into string) } catch { "" })
        }
    } catch {
        {}
    }
}

def ask-song-metadata-fallback [url: string, metadata: record]: nothing -> record {
    print $"  (ansi yellow)Could not extract complete metadata.(ansi reset)"
    print $"  (ansi blue)Please visit: ($url)(ansi reset)"

    let artist = input "  [?] Enter artist name: " | str trim
    let album = input "  [?] Enter album name (optional): " | str trim
    {
        title: ($metadata.title? | default "Unknown Title" | into string)
        artist: $artist
        artist_folder: ($artist | split row "," | first | str trim)
        album: $album
    }
}

def ask-file-collision [song_file: string]: nothing -> string {
    print $"\n  (ansi yellow)Song already exists: ($song_file)(ansi reset)"
    print "  [S]kip | [O]verwrite"

    mut result = ""
    loop {
        let choice = input $"  (ansi attr_bold)Your choice:(ansi reset) " | str trim | str lowercase
        match $choice {
            "s" => { $result = "skip";      break }
            "o" => { $result = "overwrite"; break }
            _   => { print $"  (ansi red)Invalid choice. Please enter S or O.(ansi reset)" }
        }
    }
    $result
}

def download-song [url: string, metadata: record, song_name: string, music_dir: string, verbose: bool, log_file: string]: nothing -> nothing {
    let song_dir = $music_dir
    mkdir $song_dir

    let base_name = if ($song_name | is-empty) {
        $"($metadata.title) - ($metadata.artist)" | sanitize-filename
    } else {
        $song_name | sanitize-filename
    }
    let song_file = [$song_dir, $"($base_name).mp3"] | path join

    if ($song_file | path exists) {
        match (ask-file-collision $song_file) {
            "skip" => {
                print $"  (ansi yellow)Skipping download. Song already exists.(ansi reset)"
                return
            }
            _ => {} # overwrite: fall through
        }
    }

    print $"\n  (ansi blue)Downloading song...(ansi reset)"

    mut ppargs = $"ffmpeg:-metadata artist=($metadata.artist | shell-quote) -loglevel error"
    if ($metadata.album | is-not-empty) {
        $ppargs += $" -metadata album=($metadata.album | shell-quote)"
    }
    let output_template = [$song_dir, ( $base_name + ".%(ext)s" )] | path join

    let dl_args = [
        "-x" "--audio-format" "mp3"
        "--add-metadata" "--embed-thumbnail"
        "--parse-metadata" "%(album)s:%(meta_album)s"
        "--replace-in-metadata" "artist" " - Topic$" ""
        "--ignore-errors"
        "--no-warnings"
        "--js-runtimes" "node"
        "--remote-components" "ejs:github"
        "-o" $output_template
        "--postprocessor-args" $ppargs
        $url
    ]

    $"CMD: yt-dlp ($dl_args | str join ' ')" | write-log $log_file

    let returncode = run-ytdlp-stream $dl_args $verbose $log_file

    if $returncode != 0 {
        print $"\n  (ansi red)Download failed with exit code ($returncode)(ansi reset)"
        if ($log_file | is-not-empty) { print $"  (ansi yellow)Check log: ($log_file)(ansi reset)" }
        exit 1
    }

    print $"\n  (ansi green)Success!(ansi reset)"
    print $"  Song saved to: ($song_file)"
}

def print-intro [music_dir: string]: nothing -> nothing {
    let line = "" | fill -c '=' -w 8
    print $"\n  (ansi blue)($line)(ansi reset)"
    print $"(ansi blue_bold)  Snag It?(ansi reset)"
    print $"  (ansi blue)($line)(ansi reset)"
    print "\n  Automated Song Downloader & Organizer"
    print $"  Library Location: (ansi cyan)($music_dir)(ansi reset)"
    print $"  For detailed usage: (ansi green)song-download --help(ansi reset)"
}

def run-download [url: string, verbose: bool, do_log: bool, music_dir: string, song_name: string]: nothing -> nothing {
    verify-url $url
    let metadata_raw = extract-song-metadata $url
    let needs_fallback = ($metadata_raw | is-empty) or ($metadata_raw.artist == "Unknown Artist")
    let metadata = if $needs_fallback { ask-song-metadata-fallback $url $metadata_raw } else { $metadata_raw }

    let log_file = if $do_log { setup-log-file $LOG_DIR $metadata.title } else { "" }

    let sep = "" | fill -c '=' -w 48
    print $"\n  (ansi blue)($sep)(ansi reset)"
    print $"  (ansi blue_underline)(ansi attr_bold)Artist(ansi reset)(ansi blue) : (ansi cyan)($metadata.artist)(ansi reset)"
    print $"  (ansi blue_underline)(ansi attr_bold)Title(ansi reset)(ansi blue)  : (ansi cyan)($metadata.title)(ansi reset)"
    print $"  (ansi blue)($sep)(ansi reset)"

    let base_name = if ($song_name | is-empty) { $"($metadata.title) - ($metadata.artist)" } else { $song_name }
    print $"  (ansi blue_underline)(ansi attr_bold)Filename(ansi reset)(ansi blue) : (ansi cyan)($base_name).mp3(ansi reset)"
    print $"  (ansi blue_underline)(ansi attr_bold)Folder(ansi reset)(ansi blue)   : (ansi cyan)($music_dir)(ansi reset)"

    download-song $url $metadata $song_name $music_dir $verbose $log_file
}

# Snag It? - Automated Song Downloader & Organizer
def main [
    url?: string        # YouTube/YouTube Music song URL
    --name (-n): string # Output filename, e.g. "Never Gonna Give You Up-Rick Astley"
    --verbose (-v)      # Enable verbose output
    --no-log            # Disable logging to ~/.config/snag/logs/
    --set-dir: string   # Set a new persistent default music library location
] {
    let music_dir = load-config $CONFIG_FILE "music_dir" $DEFAULT_MUSIC_DIR

    if $set_dir != null {
        let new_path = $set_dir | path expand
        mkdir $new_path
        save-config $new_path
        print $"(ansi green)Default library location updated to: ($new_path)(ansi reset)"
        return
    }

    match $url {
        null => {
            print-intro $music_dir

            mut entered_url = ""
            loop {
                let u = input "\n  [?] Enter Song URL: " | str trim
                if ($u | is-not-empty) { $entered_url = $u; break }
                print $"      (ansi red)URL cannot be empty.(ansi reset)"
            }

            let be_verbose = ask-bool "Enable verbose console output?"

            let song_name = input "  [?] Enter filename (<name>-<artist>) [Enter to auto-detect]: " | str trim

            run-download $entered_url $be_verbose true $music_dir $song_name
        }
        _ => { run-download $url $verbose (not $no_log) $music_dir ($name | default "") }
    }
}