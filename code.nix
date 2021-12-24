{ pkgs, ... }:

{
  programs.vscode = {
      enable = true;
      extensions = with pkgs.vscode-extensions; [
        haskell.haskell
        ms-vscode.cpptools
        eamodio.gitlens
      ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "language-haskell";
          publisher = "justusadam";
          version = "3.4.0";
          sha256 = "fe989d59bc93fa1807ec6b2554060ad6ee51266312bccaa3ea72aafe65a96729";
        }
        {
          name = "vscode-direnv";
          publisher = "cab404";
          version = "1.0.0";
          sha256 = "fa72c7f93f6fe93402a8a670e873cdfd97af43ae45566d92028d95f5179c3376";
        }
        {
          name = "Nix";
          publisher = "bbenoist";
          version = "1.0.1";
          sha256 = "ab0c6a386b9b9507953f6aab2c5f789dd5ff05ef6864e9fe64c0855f5cb2a07d";
        }
      ];
    };
  }
