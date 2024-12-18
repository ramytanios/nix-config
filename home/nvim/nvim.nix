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
        config = builtins.readFile ./plugins/trouble.lua;
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

      vimcool = { plugin = pkgs.vimPlugins.vim-cool; };

      marks = {
        plugin = pkgs.vimPlugins.marks-nvim;
        type = "lua";
        config = ''
          require("marks").setup({})
        '';
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

      autopairs = {
        plugin = pkgs.vimPlugins.nvim-autopairs;
        type = "lua";
        config = ''
          require("nvim-autopairs").setup {}
        '';
      };

      rest = { plugin = pkgs.vimPlugins.rest-nvim; };

      clangd_extensions-nvim = {
        plugin = pkgs.vimPlugins.clangd_extensions-nvim;
        type = "lua";
        config = ''
          require("clangd_extensions.inlay_hints").setup_autocmd()
          require("clangd_extensions.inlay_hints").set_inlay_hints()
        '';
      };

      smear_cursor = let
        smear_cursor = pkgs.vimUtils.buildVimPlugin {
          name = "smear-cursor.nvim";
          src = pkgs.fetchFromGitHub {
            owner = "sphamba";
            repo = "smear-cursor.nvim";
            rev = "78c42170f9326fb70d09aff2184c81189eddf144";
            sha256 = "rmNyjHjHGaRzFvnmBuzQnSH8VGZ2j5XfNxDwYcgPkPA=";
          };
        };
      in {
        plugin = smear_cursor;
        type = "lua";
        config = ''
          require("smear_cursor").setup {}
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
      fidget
      # noice
      nui
      markdown-preview
      inc-rename
      vimcool
      marks
      lightbulb
      # autopairs
      rest
      clangd_extensions-nvim
      smear_cursor
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
      yaml-language-server

      # Formatters and linters
      stylua
      ruff
      statix
      nixfmt
      cpplint
      yamlfmt
      yamllint
      pgformatter
    ];

    extraLuaConfig = builtins.readFile ./init.lua;
  };
}
