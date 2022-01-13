{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      vim-nix
      haskell-vim
      typescript-vim
      vim-css-color
      coc-nvim
      nord-nvim # color scheme
      vim-sleuth # auto tabsize
      neogit
      fzf-vim # files search
      git-blame-nvim
    ];
    vimAlias = true;
    extraConfig = ''
      nnoremap <silent> h :call CocActionAsync('doHover')<cr>

      set tabstop=4

      set termguicolors
      colorscheme nord
      let g:nord_contrast = v:true
      let g:nord_borders = v:true

      " restore alacritty cursor
      augroup RestoreCursorShapeOnExit
        autocmd!
        autocmd VimLeave * set guicursor=a:ver15:blinkwait750-blinkoff750-blinkon750
      augroup END
    '';
    coc = {
      enable = true;
      settings = {
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
            filetypes = [ "haskell" "lhaskell" ];
          };
        };
      };
    };
  };
}
