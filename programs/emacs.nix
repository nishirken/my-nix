{ pkgs, ... }:

{
    programs.emacs = {
        enable = true;
	extraPackages = pkgs: with pkgs; [
	  evil
	  magit
	  direnv
	  haskell-mode
	  lsp-mode
	  lsp-haskell
	];
    };
}
