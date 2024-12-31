{ pkgs, ... }:
{

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;
    plugins =
      let

        metals = {
          plugin = pkgs.vimPlugins.nvim-metals;
          type = "lua";
          config = ''
            local metalsBinary = "${pkgs.metals}/bin/metals"
            ${builtins.readFile ./plugins/metals.lua}
          '';
        };

        oil = {
          plugin = pkgs.vimPlugins.oil-nvim;
          type = "lua";
          config = builtins.readFile ./plugins/oil.lua;
        };

        todo-comments = {
          plugin = pkgs.vimPlugins.todo-comments-nvim;
          type = "lua";
          config = ''
            require("todo-comments").setup({})
          '';
        };

        comment = {
          plugin = pkgs.vimPlugins.comment-nvim;
          type = "lua";
          config = ''
            require("Comment").setup({})
          '';
        };

        plenary = {
          plugin = pkgs.vimPlugins.plenary-nvim;
          type = "lua";
        };

        telescope = [
          { plugin = pkgs.vimPlugins.telescope-fzf-native-nvim; }
          { plugin = pkgs.vimPlugins.telescope-symbols-nvim; }
          {
            plugin = pkgs.vimPlugins.telescope-nvim;
            type = "lua";
            config = builtins.readFile ./plugins/telescope.lua;
          }
        ];

        fidget = {
          plugin = pkgs.vimPlugins.fidget-nvim;
          type = "lua";
          config = ''
            require("fidget").setup {}
          '';
        };

        treesitter = {
          plugin = pkgs.vimPlugins.nvim-treesitter.withAllGrammars;
          type = "lua";
          config = builtins.readFile ./plugins/treesitter.lua;
        };

        lualine = {
          plugin = pkgs.vimPlugins.lualine-nvim;
          type = "lua";
          config = builtins.readFile ./plugins/lualine.lua;
        };

        diffview = {
          plugin = pkgs.vimPlugins.diffview-nvim;
        };

        gitsigns = {
          plugin = pkgs.vimPlugins.gitsigns-nvim;
          type = "lua";
          config = builtins.readFile ./plugins/gitsigns.lua;
        };

        conform = {
          plugin = pkgs.vimPlugins.conform-nvim;
          type = "lua";
          config = builtins.readFile ./plugins/conform.lua;
        };

        lint = {
          plugin = pkgs.vimPlugins.nvim-lint;
          type = "lua";
          config = builtins.readFile ./plugins/lint.lua;
        };

        flash = {
          plugin = pkgs.vimPlugins.flash-nvim;
          type = "lua";
          config = builtins.readFile ./plugins/flash.lua;
        };

        notify = {
          plugin = pkgs.vimPlugins.nvim-notify;
          type = "lua";
          config = ''
            vim.notify = require("notify")
          '';
        };

        indent = {
          plugin = pkgs.vimPlugins.indent-blankline-nvim;
          type = "lua";
          config = builtins.readFile ./plugins/indent.lua;
        };

        dressing = {
          plugin = pkgs.vimPlugins.dressing-nvim;
        };

        web-devicons = {
          plugin = pkgs.vimPlugins.nvim-web-devicons;
        };

        vim-tmux = {
          plugin = pkgs.vimPlugins.vim-tmux-navigator;
        };

        fugitive = {
          plugin = pkgs.vimPlugins.vim-fugitive;
        };

        lspkind = {
          plugin = pkgs.vimPlugins.lspkind-nvim;
        };

        cmp = with pkgs.vimPlugins; [
          {
            plugin = nvim-cmp;
            type = "lua";
            config = builtins.readFile ./plugins/cmp.lua;
          }
          { plugin = cmp-vsnip; }
          { plugin = vim-vsnip; }
          { plugin = cmp-path; }
          { plugin = cmp-buffer; }
          { plugin = cmp-nvim-lsp; }
        ];

        trouble = {
          plugin = pkgs.vimPlugins.trouble-nvim;
          type = "lua";
          config = ''
            require("trouble").setup({})
          '';
        };

        noice = {
          plugin = pkgs.vimPlugins.noice-nvim;
          type = "lua";
          config = builtins.readFile ./plugins/noice.lua;
        };

        nui = {
          plugin = pkgs.vimPlugins.nui-nvim;
          type = "lua";
        };

        neoscroll = {
          plugin = pkgs.vimPlugins.neoscroll-nvim;
          type = "lua";
          config = ''
            require("neoscroll").setup({})
          '';
        };

        surround = {
          plugin = pkgs.vimPlugins.nvim-surround;
          type = "lua";
          config = ''
            require("nvim-surround").setup({})
          '';
        };

        lsp = {
          plugin = pkgs.vimPlugins.nvim-lspconfig;
          type = "lua";
          config = builtins.readFile ./plugins/lsp.lua;
        };

        lsp-signature = {
          plugin = pkgs.vimPlugins.lsp_signature-nvim;
          type = "lua";
          config = ''
            require("lsp_signature").setup({})
          '';
        };

        lua-dev = {
          plugin = pkgs.vimPlugins.neodev-nvim;
          type = "lua";
          config = ''
            require("neodev").setup({})
          '';
        };

        markdown-preview = {
          plugin = pkgs.vimPlugins.markdown-preview-nvim;
          type = "lua";
          config = "";
        };

        inc-rename = {
          plugin = pkgs.vimPlugins.inc-rename-nvim;
          type = "lua";
          config = ''
            require('inc_rename').setup({})
          '';
        };

        vimcool = {
          plugin = pkgs.vimPlugins.vim-cool;
        };

        lightbulb = {
          plugin = pkgs.vimPlugins.nvim-lightbulb;
          type = "lua";
          config = ''
              require("nvim-lightbulb").setup({
              autocmd = { enabled = true }
            })
          '';
        };

        rest = {
          plugin = pkgs.vimPlugins.rest-nvim;
        };

        smear_cursor =
          let
            smear_cursor = pkgs.vimUtils.buildVimPlugin {
              name = "smear-cursor.nvim";
              src = pkgs.fetchFromGitHub {
                owner = "sphamba";
                repo = "smear-cursor.nvim";
                rev = "78c42170f9326fb70d09aff2184c81189eddf144";
                sha256 = "rmNyjHjHGaRzFvnmBuzQnSH8VGZ2j5XfNxDwYcgPkPA=";
              };
            };
          in
          {
            plugin = smear_cursor;
            type = "lua";
            config = ''
              require("smear_cursor").setup {}
            '';
          };

        snacks = {
          plugin = pkgs.vimUtils.buildVimPlugin {
            pname = "snacks.nvim";
            version = "2024-12-09";
            src = pkgs.fetchFromGitHub {
              owner = "folke";
              repo = "snacks.nvim";
              rev = "98df370703b3c47a297988f3e55ce99628639590";
              sha256 = "sha256-Gvd2QfAgrpRxJvZ41LAOPRrDGwVdeZUb8BGrzzcpcHU=";
            };
            meta.homepage = "https://github.com/folke/snacks.nvim/";
          };
          type = "lua";
          config = builtins.readFile ./plugins/snacks.lua;
        };

        fzf-lua = {
          plugin = pkgs.vimPlugins.fzf-lua;
          type = "lua";
          config = builtins.readFile ./plugins/fzf-lua.lua;
        };

        which-key = {
          plugin = pkgs.vimPlugins.which-key-nvim;
          type = "lua";
          config = builtins.readFile ./plugins/which-key.lua;
        };

        blink-cmp = {
          plugin = pkgs.vimPlugins.blink-cmp;
          type = "lua";
          config = builtins.readFile ./plugins/blink-cmp.lua;
        };

        outline = {
          plugin = pkgs.vimPlugins.outline-nvim;
          type = "lua";
          config = ''
            require("outline").setup {}
          '';
        };

      in
      pkgs.lib.lists.flatten [
        lsp
        #lsp-signature
        trouble
        neoscroll
        surround
        #cmp
        lspkind
        fugitive
        vim-tmux
        web-devicons
        dressing
        #indent
        #notify
        flash
        lint
        conform
        gitsigns
        diffview
        lualine
        treesitter
        #telescope
        plenary
        comment
        todo-comments
        metals
        oil
        lua-dev
        fidget
        # noice
        nui
        markdown-preview
        #inc-rename
        vimcool
        lightbulb
        # autopairs
        rest
        smear_cursor
        snacks
        fzf-lua
        which-key
        blink-cmp
        outline
      ];

    extraPackages =
      with pkgs;
      let
        lsps = [
          lua-language-server
          yaml-language-server
          bash-language-server
          python3Packages.python-lsp-server
        ];
        formatters = [
          stylua
          nixfmt-rfc-style
          yamlfmt
          pgformatter
          black
          isort
          ruff
        ];
        linters = [
          yamllint
          statix
          mypy
          python3Packages.flake8
        ];
      in
      lib.lists.flatten [
        lsps
        formatters
        linters
      ];

    extraLuaConfig = builtins.readFile ./init.lua;
  };
}
