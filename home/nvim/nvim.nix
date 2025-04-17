{ pkgs, ... }:
{

  programs.neovim = with pkgs; {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;
    plugins =
      let

        nvim-metals = {
          plugin = vimPlugins.nvim-metals;
          type = "lua";
          config = ''
            local metalsBinary = "${metals}/bin/metals"
            ${builtins.readFile ./plugins/metals.lua}
          '';
        };

        oil = {
          plugin = vimPlugins.oil-nvim;
          type = "lua";
          config = builtins.readFile ./plugins/oil.lua;
        };

        todo-comments = {
          plugin = vimPlugins.todo-comments-nvim;
          type = "lua";
          config = ''
            require("todo-comments").setup({})
          '';
        };

        comment = {
          plugin = vimPlugins.comment-nvim;
          type = "lua";
          config = ''
            require("Comment").setup({})
          '';
        };

        plenary = {
          plugin = vimPlugins.plenary-nvim;
          type = "lua";
        };

        fidget = {
          plugin = vimPlugins.fidget-nvim;
          type = "lua";
          config = ''
            require("fidget").setup {}
          '';
        };

        treesitter = {
          plugin = vimPlugins.nvim-treesitter.withAllGrammars;
          type = "lua";
          config = builtins.readFile ./plugins/treesitter.lua;
        };

        lualine = {
          plugin = vimPlugins.lualine-nvim;
          type = "lua";
          config = builtins.readFile ./plugins/lualine.lua;
        };

        diffview = {
          plugin = vimPlugins.diffview-nvim;
        };

        gitsigns = {
          plugin = vimPlugins.gitsigns-nvim;
          type = "lua";
          config = builtins.readFile ./plugins/gitsigns.lua;
        };

        conform = {
          plugin = vimPlugins.conform-nvim;
          type = "lua";
          config = builtins.readFile ./plugins/conform.lua;
        };

        lint = {
          plugin = vimPlugins.nvim-lint;
          type = "lua";
          config = builtins.readFile ./plugins/lint.lua;
        };

        flash = {
          plugin = vimPlugins.flash-nvim;
          type = "lua";
          config = builtins.readFile ./plugins/flash.lua;
        };

        dressing = {
          plugin = vimPlugins.dressing-nvim;
        };

        web-devicons = {
          plugin = vimPlugins.nvim-web-devicons;
        };

        vim-tmux = {
          plugin = vimPlugins.vim-tmux-navigator;
        };

        fugitive = {
          plugin = pkgs.vimPlugins.vim-fugitive;
        };

        lspkind = {
          plugin = pkgs.vimPlugins.lspkind-nvim;
        };

        trouble = {
          plugin = vimPlugins.trouble-nvim;
          type = "lua";
          config = ''
            require("trouble").setup({})
          '';
        };

        nui = {
          plugin = vimPlugins.nui-nvim;
          type = "lua";
        };

        neoscroll = {
          plugin = vimPlugins.neoscroll-nvim;
          type = "lua";
          config = ''
            require("neoscroll").setup({})
          '';
        };

        surround = {
          plugin = vimPlugins.nvim-surround;
          type = "lua";
          config = ''
            require("nvim-surround").setup({})
          '';
        };

        lsp = {
          plugin = vimPlugins.nvim-lspconfig;
          type = "lua";
          config = builtins.readFile ./plugins/lsp.lua;
        };

        lua-dev = {
          plugin = vimPlugins.neodev-nvim;
          type = "lua";
          config = ''
            require("neodev").setup({})
          '';
        };

        vimcool = {
          plugin = vimPlugins.vim-cool;
        };

        lightbulb = {
          plugin = vimPlugins.nvim-lightbulb;
          type = "lua";
          config = ''
              require("nvim-lightbulb").setup({
              autocmd = { enabled = true }
            })
          '';
        };

        kulala = {
          plugin = vimPlugins.kulala-nvim;
          type = "lua";
          config = builtins.readFile ./plugins/kulala.lua;
        };

        smear_cursor = {
          plugin = vimPlugins.smear-cursor-nvim;
          type = "lua";
          config = ''
            require("smear_cursor").setup {}
          '';
        };

        snacks = {
          plugin = vimPlugins.snacks-nvim;
          type = "lua";
          config = builtins.readFile ./plugins/snacks.lua;
        };

        fzf-lua = {
          plugin = vimPlugins.fzf-lua;
          type = "lua";
          config = builtins.readFile ./plugins/fzf-lua.lua;
        };

        which-key = {
          plugin = vimPlugins.which-key-nvim;
          type = "lua";
          config = builtins.readFile ./plugins/which-key.lua;
        };

        blink-cmp = {
          plugin = vimPlugins.blink-cmp;
          type = "lua";
          config = builtins.readFile ./plugins/blink-cmp.lua;
        };

        outline = {
          plugin = vimPlugins.outline-nvim;
          type = "lua";
          config = ''
            require("outline").setup {}
          '';
        };

        precognition = {
          plugin = vimPlugins.precognition-nvim;
          type = "lua";
          config = ''
            require("precognition").setup {
              startVisible = false
            }
          '';
        };

      in
      lib.lists.flatten [
        lsp
        trouble
        neoscroll
        surround
        lspkind
        fugitive
        vim-tmux
        web-devicons
        dressing
        flash
        lint
        conform
        gitsigns
        diffview
        lualine
        treesitter
        plenary
        comment
        todo-comments
        nvim-metals
        oil
        lua-dev
        fidget
        nui
        vimcool
        lightbulb
        kulala
        smear_cursor
        snacks
        fzf-lua
        which-key
        blink-cmp
        outline
        precognition
      ];

    extraPackages =
      let
        kulala_lsp = buildNpmPackage {
          name = "kulala-ls";
          src = fetchFromGitHub {
            owner = "mistweaverco";
            repo = "kulala-ls";
            rev = "v1.9.0";
            sha256 = "sha256-We7d6if++n8Y0eouY3I9hbb5iJ+YyaPyFSvu6Ff5U0U=";
          };
          npmDepsHash = "sha256-/6JZYsIYDJHS/8TOPjtR/SrRbzTbL43X0g/tPIn2YfQ=";
        };
        lsps = [
          nil
          lua-language-server
          yaml-language-server
          bash-language-server
          python3Packages.python-lsp-server
          # kulala_lsp
        ];
        formatters = [
          stylua
          nixfmt-rfc-style
          yamlfmt
          pgformatter
          black
          isort
          ruff
          kulala-fmt
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
