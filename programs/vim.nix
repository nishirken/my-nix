{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      vim-nix
      haskell-vim
      coc-nvim
      vim-one
    ];
    vimAlias = true;
    extraConfig = ''
      nnoremap <silent> h :call CocActionAsync('doHover')<cr>

      colorscheme one
      let g:one_allow_italics = 1

      let hr = (strftime('%H'))
      if hr >= 20 || hr <= 9
        set background=dark
      endif

      if exists('+termguicolors')
        let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
        let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
        set termguicolors
      endif
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
