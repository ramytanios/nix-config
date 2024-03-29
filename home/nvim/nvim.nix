{ pkgs, ... }: {

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;
    plugins = let

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

      # We prefer the colorschemes flake
      # tokyonight = { plugin = pkgs.vimPlugins.tokyonight-nvim; };

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
        {
          plugin = pkgs.vimUtils.buildVimPlugin {
            name = "telescope-emoji.nvim";
            src = pkgs.fetchFromGitHub {
              owner = "xiyaowong";
              repo = "telescope-emoji.nvim";
              rev = "86248d97be84a1ce83f0541500ef9edc99ea2aa1";
              sha256 = "sha256-8V3MTporANLtZkH0RuLviWlgMmR6fay0WmZ3ZOQzpKI=";
            };
            meta.homepage = "https://github.com/xiyaowong/telescope-emoji.nvim";
          };
        }
        {
          plugin = pkgs.vimPlugins.telescope-nvim;
          type = "lua";
          config = builtins.readFile ./plugins/telescope.lua;
        }
      ];

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

      diffview = { plugin = pkgs.vimPlugins.diffview-nvim; };

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

      tree = {
        plugin = pkgs.vimPlugins.nvim-tree-lua;
        type = "lua";
        config = ''
          require("nvim-tree").setup({})
        '';
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

      dressing = { plugin = pkgs.vimPlugins.dressing-nvim; };

      web-devicons = { plugin = pkgs.vimPlugins.nvim-web-devicons; };

      vim-tmux = { plugin = pkgs.vimPlugins.vim-tmux-navigator; };

      fugitive = { plugin = pkgs.vimPlugins.vim-fugitive; };

      lspkind = { plugin = pkgs.vimPlugins.lspkind-nvim; };

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

    in pkgs.lib.lists.flatten [
      lsp
      lsp-signature
      trouble
      neoscroll
      surround
      cmp
      lspkind
      fugitive
      vim-tmux
      web-devicons
      dressing
      indent
      notify
      tree
      flash
      lint
      conform
      gitsigns
      diffview
      lualine
      treesitter
      telescope
      plenary
      comment
      todo-comments
      metals
      oil
      lua-dev
    ];

    extraPackages = with pkgs; [
      # LSPs
      lua-language-server
      nil
      ruff-lsp
      nodePackages.bash-language-server
      nodePackages.typescript-language-server
      texlab
      typst-lsp

      # Formatters and linters
      stylua
      ruff
      statix
      nixfmt
      typstfmt
    ];

    extraLuaConfig = builtins.readFile ./init.lua;
  };
}
