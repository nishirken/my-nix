{ pkgs, ... }:

let
  standardPlugins = with pkgs.vimPlugins; [
    vim-nix
    haskell-vim
    typescript-vim
    purescript-vim
    vim-css-color
    coc-nvim
    nord-nvim # color scheme
    vim-sleuth # auto tabsize
    neogit
    fzf-vim # files search
    git-blame-nvim
    vim-visual-multi
    vim-airline
    vim-airline-themes
    vim-fugitive
    coc-eslint
    coc-tsserver
    vim-flutter
    dart-vim-plugin
    coc-tsserver
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
    vimAlias = true;
    extraConfig = ''
      nnoremap <silent> gh :call CocActionAsync('doHover')<cr>
      nnoremap <silent> gd :call CocAction('jumpDefinition', 'tab drop')<cr>

      set tabstop=2
      set shiftwidth=2
      set expandtab

      set termguicolors
      colorscheme nord
      let g:nord_contrast = v:true
      let g:nord_borders = v:true
      let g:airline_theme='base16'

      " restore alacritty cursor
      augroup RestoreCursorShapeOnExit
        autocmd!
        autocmd VimLeave * set guicursor=a:ver15:blinkwait750-blinkoff750-blinkon750
      augroup END
    '';
    coc = {
      enable = true;
      settings = {
        "pylsp.builtin.enableInstallPylspMypy" = true;
        languageserver = {
          haskell = {
            command = "haskell-language-server";
            args = [ "--lsp" "--project-ghc-version" ];
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
