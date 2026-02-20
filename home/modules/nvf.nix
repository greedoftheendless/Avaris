{
  inputs,
  pkgs,
  ...
}: {
  imports = [inputs.nvf.homeManagerModules.default];

  programs.nvf = {
    defaultEditor = true;
    settings = {
      vim = {
        viAlias = true;
        vimAlias = true;
        autocomplete.blink-cmp.enable = true;

        globals.mapleader = " ";

        options = {
          # general settings
          clipboard = "unnamedplus";
          mouse = "a";
          splitbelow = true;
          splitright = true;
          timeoutlen = 500;
          termguicolors = true;
          completeopt = "menuone,noselect";
          updatetime = 300;

          # tab settings
          tabstop = 2;
          shiftwidth = 2;
          softtabstop = 2;
          expandtab = true;
          shiftround = true;
          autoindent = true;
          smartindent = true;

          # line numbers
          number = true;
          relativenumber = true;
          wrap = false;
          cursorline = true;
          signcolumn = "yes";
          scrolloff = 8;
          sidescrolloff = 5;

          # search
          ignorecase = true;
          smartcase = true;
          incsearch = true;
          hlsearch = true;

          # swap
          swapfile = false;
          backup = false;
          writebackup = false;
          undofile = true;

          # text stuff
          list = true;
          listchars = "tab:→\\ ,trail:°,extends:›,precedes:‹";

          # fold your laundry
          foldmethod = "indent";
          foldlevel = 99;
          foldenable = false;
        };

        keymaps = [
          # AntiUndo
          {
            action = "<cmd>redo<CR>";
            key = "<S-u>";
            mode = "n";
          }
          # Disable accidentally pressing Ctrl-Z and suspending Neovim
          {
            action = "<Nop>";
            key = "<C-z>";
            mode = "n";
          }
          # Disable ex-mode
          {
            action = "<Nop>";
            key = "Q";
            mode = "n";
          }
          # Fast command-line mode
          {
            action = ":";
            key = ";";
            mode = "n";
          }
          # ESC to turn off search highlighting
          {
            action = "<cmd>nohlsearch<CR>";
            key = "<esc>";
            mode = "n";
          }
          # Stay in visual mode after indenting with < or >
          {
            action = ">gv";
            key = ">";
            mode = "n";
          }
          {
            action = "<gv";
            key = "<";
            mode = "n";
          }
          # Exit insert mode in terminal
          {
            action = "<C-\\><C-n>";
            key = "<esc>";
            mode = "t";
          }
          # Move between windows
          {
            action = "<C-w>h";
            key = "<S-Left>";
            mode = "n";
          }
          {
            action = "<C-w>j";
            key = "<S-Down>";
            mode = "n";
          }
          {
            action = "<C-w>k";
            key = "<S-Up>";
            mode = "n";
          }
          {
            action = "<C-w>l";
            key = "<S-Right>";
            mode = "n";
          }
          # Resize splits
          {
            action = "<cmd>resize +2<cr>";
            key = "<A-Up>";
            mode = "n";
          }
          {
            action = "<cmd>resize -2<cr>";
            key = "<A-Down>";
            mode = "n";
          }
          {
            action = "<cmd>vertical resize +2<cr>";
            key = "<A-Left>";
            mode = "n";
          }
          {
            action = "<cmd>vertical resize -2<cr>";
            key = "<A-Right>";
            mode = "n";
          }
          {
            action = "<cmd>bnext<CR>";
            key = "<leader>.";
            mode = "n";
            desc = "Right Buffer";
          }
          {
            action = "<cmd>bnext<CR>";
            key = "<leader>,";
            mode = "n";
            desc = "Right Buffer";
          }
          # Close Buffer
          {
            action = "<cmd>bdelete<CR>";
            key = "<leader>x";
            mode = "n";
            desc = "Close Buffer";
          }
        ];

        # Languages
        languages = {
          enableFormat = true;
          enableTreesitter = true;
          html.enable = true;
          css.enable = true;
          json.enable = true;
          lua.enable = true;
          sql.enable = true;
          nix.enable = true;
          python.enable = true;
          rust.enable = true;
          nu.enable = true;
          bash.enable = true;
        };

        #LSP server
        lsp = {
          enable = true;
          formatOnSave = true;
          inlayHints.enable = true;
          lspconfig.enable = true;
          lspkind.enable = true;
          mappings = {
            goToDefinition = "<leader>LD";
            renameSymbol = "<F2>";
            codeAction = "<leader>lc";
            listImplementations = "<leader>lD";
            hover = "K";
            nextDiagnostic = "<leader>[";
            previousDiagnostic = "<leader>]";
          };
        };

        visuals = {
          indent-blankline = {
            enable = true;
            setupOpts = {
              indent = {
                char = "▏";
                tab_char = "▏";
              };
              scope = {
                enabled = true;
                show_start = true;
                show_end = false;
              };
              exclude = {
                filetypes = ["dashboard"];
              };
            };
          };
          nvim-web-devicons.enable = true;
        };

        statusline.lualine = {
          enable = true;
          theme = "catppuccin";
          sectionSeparator = {
            left = "";
            right = "";
          };
          componentSeparator = {
            left = "";
            right = "";
          };
        };

        extraPlugins = {
          "auto-save".package = pkgs.vimPlugins.auto-save-nvim;
          "auto-save".setup =
            # lua
            "require('auto-save').setup{}";
        };

        telescope = {
          enable = true;
          extensions = [
            {
              name = "fzf";
              packages = [pkgs.vimPlugins.telescope-fzf-native-nvim];
              setup = {
                fzf = {
                  fuzzy = true;
                  override_file_sorter = true;
                  override_generic_sorter = true;
                  case_mode = "smart_case";
                };
              };
            }
          ];
          setupOpts = {
            defaults = {
              layout_config.horizontal.prompt_position = "top";
              sorting_strategy = "ascending";
            };
            pickers.find_files.hidden = true;
          };
        };

        git.gitsigns = {
          enable = true;
          setupOpts = {
            attach_to_untracked = true;
            current_line_blame = true;
            current_line_blame_opts = {
              delay = 0;
              virt_text_pos = "eol";
            };
          };
        };

        terminal.toggleterm = {
          enable = true;
          lazygit = {
            enable = true;
            mappings.open = "<leader>lg";
          };
        };

        dashboard.dashboard-nvim = {
          enable = true;

          setupOpts = {
            theme = "doom";

            config = {
              header = [
                ""
                " ██████╗ ██████╗ ███████╗███████╗██████╗ "
                "██╔════╝ ██╔══██╗██╔════╝██╔════╝██╔══██╗"
                "██║  ███╗██████╔╝█████╗  █████╗  ██║  ██║"
                "██║   ██║██╔══██╗██╔══╝  ██╔══╝  ██║  ██║"
                "╚██████╔╝██║  ██║███████╗███████╗██████╔╝"
                " ╚═════╝ ╚═╝  ╚═╝╚══════╝╚══════╝╚═════╝ "
                ""
              ];

              center = [
                {
                  icon = "  ";
                  desc = "Find file";
                  key = "f";
                  action = "Telescope find_files";
                }
                {
                  icon = "  ";
                  desc = "Recent files";
                  key = "r";
                  action = "Telescope oldfiles";
                }
                {
                  icon = "  ";
                  desc = "Live grep";
                  key = "g";
                  action = "Telescope live_grep";
                }
                {
                  icon = "  ";
                  desc = "Edit nvf config";
                  key = "n";
                  action = "edit ~/dotfiles/home/modules/nvf.nix";
                }
                {
                  icon = "  ";
                  desc = "Quit";
                  key = "q";
                  action = "qa";
                }
              ];
            };
          };
        };
        theme = {
          enable = true;
          name = "catppuccin";
          style = "macchiato";
        };

        # Example: tiny Lua tweak when Nix doesn't cover a case.
        luaConfigRC.example = ''
          vim.api.nvim_create_autocmd("TextYankPost", {
            callback = function()
              vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
            end,
          })
        '';
      };
    };
  };
}
