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
        config = builtins.readFile ./plugins/metals.lua;
     };

    oil = {
        plugin = pkgs.vimPlugins.oil-nvim; 
        type = "lua";
        config = builtins.readFile ./plugins/oil.lua;
     };

    todo-comments = {
        plugin = pkgs.vimPlugins.todo-comments-nvim; 
        type = "lua";
        config = builtins.readFile ./plugins/todo-comments.lua;
     };

    tokyonight = {
        plugin = pkgs.vimPlugins.tokyonight-nvim;
        type = "lua"; 
        config = builtins.readFile ./plugins/tokyonight.lua;
     };

    comment = {
        plugin = pkgs.vimPlugins.comment-nvim;
        type = "lua"; 
        config = builtins.readFile ./plugins/comment.lua;
     };

    plenary = {
        plugin = pkgs.vimPlugins.plenary-nvim;
        type = "lua"; 
     };

    telescope = with pkgs.vimPlugins; [
     { plugin = telescope-ui-select }
     { plugin = telescope-fzf-native }
     {
        plugin = telescope-nvim;
        type = "lua"; 
        config = builtins.readFile ./plugins/telescope.lua;
     }
    ];

    treesitter = {
        plugin = pkgs.vimPlugins.nvim-treesitter;
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
        type = "lua"; 
        config = builtins.readFile ./plugins/diffview.lua;
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

    lspkind = { plugin = pkgs.vimPlugins.lspkind-nvim };

    cmp =  with pkgs.vimPlugins; [
        { 
          plugin = nvim-cmp;
          type = "lua";
          config = builtins.readFile ./plugins/cmp.lua;
        }
        { plugin = cmp-path; }
        { plugin = cmp-buffer; }
        { plugin = cmp_luasnip; }
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
   
   in pkgs.lib.lists.flatten [
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
      tokyonight 
      todo-comments
      metals 
      oil
   ];
    
    extraPackages = with pkgs; [
      lua-language-server
      nil
      nodePackages.bash-language-server
      nodePackages.typescript-language-server
    ];

    extraLuaConfig = builtins.readFile ./init.lua;
  };
}
