# https://github.com/nix-community/nixvim
# https://nix-community.github.io/nixvim/

{ config, pkgs, ... }:
{
  home.packages = with pkgs; [ fd ];
  programs.nixvim = {
    enable = true;

    defaultEditor = true;

    viAlias = true;
    vimAlias = true;

    diagnostic.settings = {
      enable = true;
      signs.enable = true;
      virtualText.enable = true;
      underline.enable = true;
      hover.enable = true;
      float.enable = true;
    };

    opts = {
      autoread = true;
      relativenumber = true;
      number = true;
      spell = true;

      # show invisible characters
      list = true;
      listchars = "eol:↲,tab:|->,lead:·,space: ,trail:•,extends:→,precedes:←,nbsp:␣";

      # spacing configuration
      tabstop = 2;
      shiftwidth = 2;
      softtabstop = 2;
      expandtab = true;
      smartindent = true;
      breakindent = true;
      conceallevel = 1;
      termguicolors = true;
    };

    keymaps = [
      {
        key = "<space>w";
        action = "<C-w>";
      }
      {
        key = "<space>qq";
        action = "<cmd>qa<cr>";
      }
      {
        key = "<space>g";
        action = "<cmd>Neogit<cr>";
      }
    ];

    dependencies = {
      tree-sitter.enable = true;
      ripgrep.enable = true;
    };

    plugins = {
      lz-n.enable = true;
      auto-save.enable = true;
      neocord.enable = true;
      treesitter.enable = true;
      trouble.enable = true;
      bufferline.enable = true;
      neo-tree.enable = true;
      diffview = {
        enable = true;
        settings.hg_cmd = null;
      };
      web-devicons.enable = true;
      #      mini = {
      #        enable = true;
      #        mockDevIcons = true;
      #        modules.icons.glyphs = "ascii";
      #      };
      indent-blankline.enable = true;
      which-key.enable = true;
      wakatime.enable = true;

      neogit = {
        enable = true;
        settings = {
          graph_style = "unicode";
          telescope_sorter = "require('telescope').extensions.fzf.native_fzf_sorter";
          integrations = {
            diffview = true;
            telescope = true;
          };
        };
      };

      # TODO: dont depend on a plugin, use builtins
      rustaceanvim = {
        enable = false;
        settings = {
          server = {
            default_settings = {
              rust-analyzer = {
                check = {
                  command = "clippy";
                };
                inlayHints = {
                  lifetimeElisionHints = {
                    enable = "always";
                  };
                };
              };
            };
            standalone = false;
          };
        };
      };

      conform-nvim = {
        enable = true;
        settings = {
          format_on_save = {
            lsp_fallback = "fallback";
            timeout_ms = 500;
          };

          notify_on_error = true;

          format_by_ft = { };
        };
      };

      obsidian = {
        enable = false;
        settings = {
          new_notes_location = "current_dir";
          workspaces = [ ];
        };
      };

      telescope = {
        enable = true;

        keymaps = {
          "<space>ff" = "find_files";
          "<space>fb" = "file_browser";
          "<space>fg" = "live_grep";
          "<space>b" = "buffers";
        };

        extensions = {
          file-browser.enable = true;
          media-files.enable = true;
          fzf-native.enable = true;
          ui-select.enable = true;
          zoxide = {
            enable = true;
            settings.mappings = {

            };
          };
        };
      };

      cmp = {
        enable = true;
        autoEnableSources = true;
        settings = {
          completion.keyword_length = 1;
          sources = [
            { name = "nvim_lsp"; }
            { name = "vim_lsp"; }
            { name = "path"; }
            { name = "buffer"; }
            { name = "conventionalcommits"; }
            { name = "clippy"; }
          ];
          mapping = {
            "<C-Space>" = "cmp.mapping.complete()";
            "<C-d>" = "cmp.mapping.scroll_docs(-4)";
            "<C-e>" = "cmp.mapping.close()";
            "<C-f>" = "cmp.mapping.scroll_docs(4)";
            "<CR>" = "cmp.mapping.confirm({ select = true })"; # TODO: fix!!!
            "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
            "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
          };
        };
      };

      lualine = {
        enable = true;
      };

      typescript-tools.enable = true;
      typst-vim.enable = true;
      typst-preview.enable = true;
      markdown-preview.enable = true;

      flutter-tools = {
        enable = true;
        settings = {
          widget_guides.enabled = true;
          flutter_path = "${pkgs.flutter}/bin/flutter";
        };
      };

      lsp = {
        enable = true;

        servers = {
          tinymist.enable = true;
          jsonls.enable = true;
          nixd.enable = true;
          html.enable = true;
          ts_ls.enable = true;
          ts_query_ls.enable = true;
          sourcekit.enable = true;
          dartls.enable = true;
          java_language_server.enable = true;
          kotlin_language_server.enable = true;
          rust_analyzer = {
            installCargo = true;
            installRustc = true;
            enable = true;
          };
          wgsl_analyzer.enable = true;
        };
      };
    };
  };
}
