{ inputs, pkgs, ... }: 
{
  imports = [ inputs.nvf.homeManagerModules.default ];

  programs.nvf = {
    defaultEditor = true;
    settings = {
      vim = {
        viAlias = true;
        vimAlias = true;

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
          {
            mode = "n";
            key = "<leader>w";
            action = ":w<CR>";
            silent = false;
          }
          {
            mode = "n";
            key = "<leader>q";
            action = ":q<CR>";
            silent = false;
          }
          {
            mode = "n";
            key = "<leader>ff";
            action = "<cmd>Telescope find_files<CR>";
          }
          {
            mode = "n";
            key = "<leader>fg";
            action = "<cmd>Telescope live_grep<CR>";
          }
          {
            mode = "n";
            key = "<leader>fb";
            action = "<cmd>Telescope buffers<CR>";
          }
          {
            mode = "n";
            key = "<leader>fh";
            action = "<cmd>Telescope help_tags<CR>";
          }
          {
            mode = "n";
            key = "<leader>lp";
            action = "<cmd>lua require('gitsigns').preview_hunk()<CR>";
          }
        ];

        # Languages
        languages = {
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
                filetypes = [ "dashboard" ];
              };
            };
          };
          nvim-web-devicons.enable = true;
        };

        statusline.lualine = {
          enable = true;
          theme = "tokyonight";
          sectionSeparator = { left = ""; right = ""; };
          componentSeparator = { left = ""; right = ""; };
        };

        telescope = {
          enable = true;
          extensions = [
            {
              name = "fzf";
              packages = [ pkgs.vimPlugins.telescope-fzf-native-nvim ];
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
        { icon = "  "; desc = "Find file";         key = "f"; action = "Telescope find_files"; }
        { icon = "  "; desc = "Recent files";      key = "r"; action = "Telescope oldfiles"; }
        { icon = "  "; desc = "Live grep";         key = "g"; action = "Telescope live_grep"; }
        { icon = "  "; desc = "Edit nvf config";   key = "n"; action = "edit ~/dotfiles/home/modules/nvf.nix"; }
        { icon = "  "; desc = "Quit";              key = "q"; action = "qa"; }
      ];
    };
  };
};
        theme = {
          enable = true;
          name = "tokyonight";
          style = "moon";
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
