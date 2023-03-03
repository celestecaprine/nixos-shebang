{pkgs, ...}: {
  programs = {
    neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
      coc = {
        enable = true;
        settings = {
          languageserver = {
            nix = {
              command = "rnix-lsp";
              filetypes = ["nix"];
            };
            lua = {
              command = "${pkgs.sumneko-lua-language-server}/bin/lua-language-server";
              args = ["-E" "${pkgs.sumneko-lua-language-server}/share/lua-language-server/main.lua"];
              rootPatterns = [".git"];
              filetypes = ["lua"];
            };
          };
        };
      };

      plugins = with pkgs.vimPlugins; [
        # Syntax
        vim-nix
        vim-markdown
        neoformat

        # Quality of life
        vim-lastplace # Opens document where you left it
        auto-pairs # Print double quotes/brackets/etc
        vim-gitgutter # See uncommitted changes of file :GitGutterEnable

        # File Tree
        nerdtree # File Manager - set in extraConfig to F6

        # Customization
        catppuccin-nvim

        lualine-nvim
        indent-blankline-nvim # Indentation lines

        vim-startify
        noice-nvim
        nui-nvim
        nvim-notify
        nvim-treesitter.withAllGrammars
        nvim-ts-rainbow2
        nvim-web-devicons

        coc-markdownlint
        coc-pyright
        coc-docker
        coc-sh
        coc-json
        coc-yaml
        coc-toml
        coc-rls
        coc-spell-checker
      ];

      extraConfig = ''
        syntax enable                             " Syntax highlighting
        highlight Comment cterm=italic gui=italic " Comments become italic
        hi Normal guibg=NONE ctermbg=NONE         " Remove background, better for personal theme
        set number                                " Set numbers
        nmap <F6> :NERDTreeToggle<CR>             " F6 opens NERDTree
        lua << EOF
        require('lualine').setup {
          options = {
              theme = "catppuccin"
          }
        }

        require("nvim-treesitter.configs").setup {
          highlight = {
            enable = true,
          },
          rainbow = {
            enable = true,
          },
        }

        require("catppuccin").setup {
          compile_path = vim.fn.stdpath "cache" .. "/catppuccin",
          flavour = "mocha",
          transparent_background = true,
          integrations = {
            barbar = true,
            dashboard = true,
            gitgutter = true,
            noice = true,
            notify = true,
            treesitter = true,
            ts_rainbow = true,
          },
        }

        vim.cmd.colorscheme "catppuccin"

        require("noice").setup({
          lsp = {
            -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
            override = {
              ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
              ["vim.lsp.util.stylize_markdown"] = true,
              ["cmp.entry.get_documentation"] = true,
            },
          },
          -- you can enable a preset for easier configuration
          presets = {
            bottom_search = true, -- use a classic bottom cmdline for search
            command_palette = false, -- position the cmdline and popupmenu together
            long_message_to_split = true, -- long messages will be sent to a split
            inc_rename = false, -- enables an input dialog for inc-rename.nvim
            lsp_doc_border = false, -- add a border to hover docs and signature help
          },
        })
        require("notify").setup({
          background_colour = "#000000",
        })

        EOF
        augroup fmt
          autocmd!
          autocmd BufWritePre * undojoin | Neoformat
        augroup END
      '';
    };
  };
}
