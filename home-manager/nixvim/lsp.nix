{ config, pkgs, ... }:

let
  javaFormatter = pkgs.writeText "eclipse-java-formatter.xml" ''
    <?xml version="1.0" encoding="UTF-8" standalone="no"?>
    <profiles version="23">
      <profile kind="CodeFormatterProfile" name="my-style" version="23">

        <!-- if / else -->
        <setting id="org.eclipse.jdt.core.formatter.keep_then_statement_on_same_line" value="true"/>
        <setting id="org.eclipse.jdt.core.formatter.keep_else_statement_on_same_line" value="true"/>
        <setting id="org.eclipse.jdt.core.formatter.keep_simple_if_on_one_line" value="true"/>

        <!-- loops -->
        <setting id="org.eclipse.jdt.core.formatter.keep_simple_for_body_on_same_line" value="true"/>
        <setting id="org.eclipse.jdt.core.formatter.keep_simple_while_body_on_same_line" value="true"/>
        <setting id="org.eclipse.jdt.core.formatter.keep_simple_do_while_body_on_same_line" value="true"/>

        <!-- simple tiny bodies -->
        <setting id="org.eclipse.jdt.core.formatter.keep_simple_methods_in_one_line" value="true"/>
        <setting id="org.eclipse.jdt.core.formatter.keep_simple_getter_setter_on_one_line" value="true"/>
        <setting id="org.eclipse.jdt.core.formatter.keep_simple_lambda_body_on_one_line" value="true"/>

      </profile>
    </profiles>
  '';
in
{
  programs.nixvim = {
    plugins.lsp = {
      enable = true;

      servers = {
        # Nix
        nil_ls.enable = true;

        # Lua / Neovim config
        lua_ls.enable = true;

        # Bash
        bashls.enable = true;

        clangd.enable = true;

        pyright.enable = true;

        hls = {
          enable = true;
          installGhc = false;

          # Allow an HLS supplied by `nix develop`/`nix-shell`
          # to override Nixvim's packaged HLS.
          packageFallback = true;

          settings = {
            haskell = {
              checkProject = true;
              checkParents = "CheckOnSave";
              formattingProvider = "ormolu";

              plugin = {
                hlint.globalOn = true;
                rename.globalOn = true;
                importLens.globalOn = true;
                class.globalOn = true;
                eval.globalOn = true;
              };
            };
          };
        };

        jdtls = {
          enable = true;
          settings = {
            java = {
              format = {
                enabled = true;
                settings = {
                  url = "${javaFormatter}";
                  profile = "my-style";
                };
              };
            };
          };
          rootMarkers = [
            ".git"
            "pom.xml"
            "build.gradle"
            "build.gradle.kts"
            "mvnw"
            "gradlew"
          ];
        };

        kotlin_language_server = {
          enable = true;
          rootMarkers = [
            "settings.gradle"
            "settings.gradle.kts"
            "build.gradle"
            "build.gradle.kts"
            "pom.xml"
            "build.xml"
            ".git"
          ];
        };

        ts_ls.enable = true;
        ts_ls.filetypes = [
          "javascript"
          "javascriptreact"
          "typescript"
          "typescriptreact"
        ];

        # Rust
        rust_analyzer = {
          enable = true;

          installCargo = true;
          installRustc = true;
          installRustfmt = true;

          settings = {
            "rust-analyzer" = {
              check = {
                command = "clippy";
              };
            };
          };
        };
      };

      keymaps = {
        diagnostic = {
          "<leader>dn" = "goto_next";
          "<leader>dp" = "goto_prev";
          "<leader>de" = "open_float";
          "<leader>dq" = "setloclist";
        };

        lspBuf = {
          "gd" = "definition";
          "gD" = "declaration";
          "gr" = "references";
          "gi" = "implementation";
          "K" = "hover";
          "<leader>rn" = "rename";
          "<leader>ca" = "code_action";
        };
      };
    };

    diagnostic.settings = {
      virtual_text = true;
      signs = true;
      underline = true;
      update_in_insert = false;
      severity_sort = true;
    };
  };
}
