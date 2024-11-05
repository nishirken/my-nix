{ pkgs, ... }:

let
  root = builtins.getEnv "PWD";
  standardPlugins = with pkgs.vimPlugins; [
    gruvbox-material-nvim
    vim-sleuth # auto tabsize
    neogit
    fzf-vim # files search
    git-blame-nvim
    vim-visual-multi
    vim-airline
    vim-airline-themes
    vim-fugitive
    telescope-nvim

    # Languages
    vim-nickel
    coc-eslint
    vim-flutter
    dart-vim-plugin
    haskell-vim
    typescript-vim
    vim-nix
    vim-css-color
    purescript-vim
    coc-tsserver
    coc-pyright
  ];
  awesomePlugins = with pkgs.awesomeNeovimPlugins; [
    neo-tree-nvim
    nui-nvim
    nvim-web-devicons
    image-nvim
  ];
in {
  programs.neovim = {
    enable = true;
    plugins = standardPlugins ++ awesomePlugins;
    viAlias = true;
    vimAlias = true;
    extraConfig = builtins.readFile "${root}/home/init.vim";
    coc = {
      enable = true;
      settings = {
        languageserver = {
          pylsp.enable = false;
          haskell = {
            command = "haskell-language-server-wrapper";
            args = [ "--lsp" ];
            rootPatterns = [
              "*.cabal"
              "stack.yaml"
              "cabal.project"
              "package.yaml"
              "hie.yaml"
            ];
            filetypes = [ "haskell" "lhaskell" "hs" ];
          };
          purescript = {
            command = "purescript-language-server";
            args = [ "--stdio" ];
            filetypes = [ "purs" "purescript" ];
            traceserver = "off";
            rootPatterns = [ "bower.json" "psc-package.json" "spago.dhall" ];
            settings = {
              purescript = {
                addSpagoSources = true;
                formatter = "purs-tidy";
              };
            };
          };
          csharp-ls = {
            command = "csharp-ls";
            filetypes = [ "cs" ];
            rootPatterns = [ "*.csproj" ];
          };
        };
        eslint = {
          enable = false;
          autoFixOnSave = true;
          quiet = true;
        };
      };
    };
  };
}
