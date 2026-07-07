{...}: {
  programs.zed-editor = {
    enable = true;

    userSettings = {
      auto_install_extensions = {
        basher = true;
        catppuccin = true;
        "catppuccin-icons" = true;
        css = true;
        csv = true;
        dockerfile = true;
        dracula = true;
        fish = true;
        html = true;
        java = true;
        json5 = true;
        kdl = true;
        log = true;
        lua = true;
        nix = true;
        nu = true;
        python = true;
        qml = true;
        "rainbow-csv" = true;
        sql = true;
        toml = true;
      };
      auto_update = false;
      buffer_font_family = "JetBrainsMono Nerd Font";
      buffer_font_size = 20;
      chat_panel = {
        dock = "left";
      };
      collaboration_panel = {
        dock = "left";
      };
      file_finder = {
        modal_width = "medium";
      };
      file_types = {
        JSON = [
          "json"
          "jsonc"
          "*.code-snippets"
        ];
      };
      git_panel = {
        dock = "left";
      };
      hour_format = "hour12";
      icon_theme = "Catppuccin Mocha";
      inactive_opacity = 0.5;
      indent_guides = {
        coloring = "indent_aware";
        enabled = true;
      };
      inlay_hints = {
        enabled = true;
      };
      languages = {
        JSON = {
          formatter = "prettier";
        };
        Markdown = {
          formatter = "prettier";
        };
        TOML = {
          formatter = "taplo";
        };
      };
      lsp = {
        nix = {
          binary = {
            path_lookup = true;
          };
        };
        rust-analyzer = {
          binary = {
            path = "/nix/store/3i6z4bh7ffyj99drw554nsmnspyizky6-rust-default-1.87.0-nightly-2025-02-18/bin/rust-analyzer";
          };
          settings = {
            cargo = {
              buildScripts = {
                enable = true;
              };
              features = "all";
            };
            check = {
              command = "clippy";
              features = "all";
            };
            checkOnSave = true;
            diagnostics = {
              enable = true;
              styleLints = {
                enable = true;
              };
            };
            files = {
              excludeDirs = [
                ".cargo"
                ".direnv"
                ".git"
                "node_modules"
                "target"
              ];
            };
            inlayHints = {
              bindingModeHints = {
                enable = true;
              };
              closureReturnTypeHints = {
                enable = "always";
              };
              closureStyle = "rust_analyzer";
              discriminantHints = {
                enable = "always";
              };
              expressionAdjustmentHints = {
                enable = "always";
              };
              implicitDrops = {
                enable = true;
              };
              lifetimeElisionHints = {
                enable = "always";
              };
              rangeExclusiveHints = {
                enable = true;
              };
            };
            procMacro = {
              enable = true;
            };
            rustc = {
              source = "discover";
            };
          };
        };
        settings = {
          dialyzerEnabled = true;
        };
      };
      minimap = {
        show = "always";
      };
      node = {
        npm_path = "/nix/store/cv3yxgf7zp70wk8d8lg5zi84lg35nyxs-nodejs-22.22.0/bin/npm";
        path = "/nix/store/cv3yxgf7zp70wk8d8lg5zi84lg35nyxs-nodejs-22.22.0/bin/node";
      };
      notification_panel = {
        dock = "left";
      };
      outline_panel = {
        dock = "left";
      };
      project_panel = {
        button = true;
        dock = "left";
      };
      relative_line_numbers = true;
      tab_bar = {
        show = true;
      };
      tabs = {
        show_diagnostics = "errors";
      };
      telemetry = {
        diagnostics = false;
        metrics = false;
      };
      terminal = {
        alternate_scroll = "off";
        blinking = "off";
        button = false;
        copy_on_select = false;
        detect_venv = {
          on = {
            activate_script = "default";
            directories = [
              ".env"
              "env"
              ".venv"
              "venv"
            ];
          };
        };
        dock = "bottom";
        env = {
          EDITOR = "zed --wait";
          TERM = "ghostty";
        };
        font_family = "FiraCode Nerd Font Mono";
        line_height = "comfortable";
        option_as_meta = false;
        shell = "system";
        toolbar = {
          title = true;
        };
        working_directory = "current_project_directory";
      };
      theme = {
        dark = "Catppuccin Mocha";
        light = "Catppuccin Mocha";
        mode = "system";
      };
      ui_font_size = 20;
      vim = {
        enable_vim_sneak = true;
      };
      vim_mode = true;
    };

    userKeymaps = [
      {
        bindings = {
          "ctrl-w h" = "workspace::ActivatePaneLeft";
          "ctrl-w j" = "workspace::ActivatePaneDown";
          "ctrl-w k" = "workspace::ActivatePaneUp";
          "ctrl-w l" = "workspace::ActivatePaneRight";
        };
        context = "Dock";
      }
      {
        bindings = {
          "g f" = "editor::OpenExcerpts";
          "space c z" = "workspace::ToggleCenteredLayout";
          "space f M" = "editor::FormatSelections";
          "space f m" = "editor::Format";
          "space f p" = "projects::OpenRecent";
          "space g h d" = "editor::ToggleHunkDiff";
          "space g h r" = "editor::RevertSelectedHunks";
          "space m P" = "markdown::OpenPreviewToTheSide";
          "space m p" = "markdown::OpenPreview";
          "space s w" = "pane::DeploySearch";
          "space t i" = "editor::ToggleInlayHints";
          "space u w" = "editor::ToggleSoftWrap";
        };
        context = "Editor && (vim_mode == normal || vim_mode == visual)";
      }
      {
        bindings = {
          "j j" = "vim::NormalBefore";
          "j k" = "vim::NormalBefore";
        };
        context = "Editor && vim_mode == insert && !menu";
      }
      {
        bindings = {
          "[ d" = "editor::GoToPrevDiagnostic";
          "[ e" = "editor::GoToPrevDiagnostic";
          "[ h" = "editor::GoToPrevHunk";
          "] d" = "editor::GoToDiagnostic";
          "] e" = "editor::GoToDiagnostic";
          "] h" = "editor::GoToHunk";
          "ctrl-h" = "workspace::ActivatePaneLeft";
          "ctrl-j" = "workspace::ActivatePaneDown";
          "ctrl-k" = "workspace::ActivatePaneUp";
          "ctrl-l" = "workspace::ActivatePaneRight";
          "ctrl-q" = "pane::CloseActiveItem";
          "ctrl-s" = "workspace::Save";
          "g D" = "editor::GoToDefinitionSplit";
          "g I" = "editor::GoToImplementationSplit";
          "g T" = "editor::GoToTypeDefinitionSplit";
          "g d" = "editor::GoToDefinition";
          "g i" = "editor::GoToImplementation";
          "g r" = "editor::FindAllReferences";
          "g t" = "editor::GoToTypeDefinition";
          "s S" = "project_symbols::Toggle";
          "s s" = "outline::Toggle";
          "shift-h" = "pane::ActivatePrevItem";
          "shift-l" = "pane::ActivateNextItem";
          "shift-q" = "pane::CloseActiveItem";
          "space ." = "editor::ToggleCodeActions";
          "space /" = "pane::DeploySearch";
          "space b d" = "pane::CloseActiveItem";
          "space b o" = "pane::CloseInactiveItems";
          "space c a" = "editor::ToggleCodeActions";
          "space c r" = "editor::Rename";
          "space e" = "pane::RevealInProjectPanel";
          "space space" = "file_finder::Toggle";
          "space x x" = "diagnostics::Deploy";
        };
        context = "Editor && vim_mode == normal && !VimWaiting && !menu";
      }
      {
        bindings = {
          "g c" = "editor::ToggleComments";
        };
        context = "Editor && vim_mode == visual && !VimWaiting && !menu";
      }
      {
        bindings = {
          "a" = "editor::ToggleCodeActions";
          "c" = "vim::CurrentLine";
        };
        context = "Editor && vim_operator == c";
      }
      {
        bindings = {
          "space f p" = "projects::OpenRecent";
          "space space" = "file_finder::Toggle";
        };
        context = "EmptyPane || SharedScreen";
      }
      {
        bindings = {
          "A" = "project_panel::NewDirectory";
          "a" = "project_panel::NewFile";
          "c" = "project_panel::Copy";
          "ctrl-h" = "workspace::ActivatePaneLeft";
          "ctrl-j" = "workspace::ActivatePaneDown";
          "ctrl-k" = "workspace::ActivatePaneUp";
          "ctrl-l" = "workspace::ActivatePaneRight";
          "d" = "project_panel::Delete";
          "p" = "project_panel::Paste";
          "q" = "workspace::ToggleRightDock";
          "r" = "project_panel::Rename";
          "space e" = "workspace::ToggleRightDock";
          "x" = "project_panel::Cut";
        };
        context = "ProjectPanel && not_editing";
      }
      {
        bindings = {
          "ctrl-h" = "workspace::ActivatePaneLeft";
          "ctrl-j" = "workspace::ActivatePaneDown";
          "ctrl-k" = "workspace::ActivatePaneUp";
          "ctrl-l" = "workspace::ActivatePaneRight";
        };
        context = "Terminal";
      }
      {
        bindings = {
          "ctrl-\\" = "terminal_panel::ToggleFocus";
          "ctrl-b" = "workspace::ToggleRightDock";
        };
        context = "Workspace";
      }
    ];
  };
}
