{ config, lib, pkgs, ... }: {
  programs = {
    nushell = {
      enable = true;
      configFile.source = ./config.nu;
      shellAliases = {
        rebuild = "doas nixos-rebuild switch";
      };
    };  

    carapace = {
      enable = true;
      enableNushellIntegration = true;
    };

    starship = {
      enable = true;
      enableNushellIntegration = true;
      settings = {
        add_newline = true;
        os.symbols.NixOS = "nix ";

        character = {
          success_symbol = "[>](bold green)";
          error_symbol = "[x](bold red)";
          vimcmd_symbol = "[<](bold green)";
        };

        git_branch.symbol = "git ";
        git_commit.tag_symbol = " tag ";
        git_status = {
          ahead = ">";
          behind = "<";
          diverged = "<>";
          renamed = "r";
          deleted = "x";
        };

        directory.read_only = " ro";
        status.symbol = "[x](bold red) ";
        memory_usage.symbol = "memory ";
        sudo.symbol = "sudo ";

        aws.symbol = "aws ";
        azure.symbol = "az ";
        buf.symbol = "buf ";
        bun.symbol = "bun ";
        c.symbol = "C ";
        cobol.symbol = "cobol ";
        conda.symbol = "conda ";
        crystal.symbol = "cr ";
        cmake.symbol = "cmake ";
        daml.symbol = "daml ";
        dart.symbol = "dart ";
        deno.symbol = "deno ";
        dotnet.symbol = ".NET ";
        docker_context.symbol = "docker ";
        elixir.symbol = "exs ";
        elm.symbol = "elm ";
        fennel.symbol = "fnl ";
        fossil_branch.symbol = "fossil ";
        gcloud.symbol = "gcp ";
        gleam.symbol = "gleam ";
        golang.symbol = "go ";
        gradle.symbol = "gradle ";
        guix_shell.symbol = "guix ";
        hg_branch.symbol = "hg ";
        java.symbol = "java ";
        julia.symbol = "jl ";
        kotlin.symbol = "kt ";
        lua.symbol = "lua ";
        nodejs.symbol = "nodejs ";
        meson.symbol = "meson ";
        nats.symbol = "nats ";
        nim.symbol = "nim ";
        nix_shell.symbol = "nix ";
        ocaml.symbol = "ml ";
        opa.symbol = "opa ";
        package.symbol = "pkg ";
        perl.symbol = "pl ";
        php.symbol = "php ";
        pijul_channel.symbol = "pijul ";
        pulumi.symbol = "pulumi ";
        purescript.symbol = "purs ";
        python.symbol = "py ";
        quarto.symbol = "quarto ";
        raku.symbol = "raku ";
        ruby.symbol = "rb ";
        rust.symbol = "rs ";
        scala.symbol = "scala ";
        spack.symbol = "spack ";
        solidity.symbol = "solidity ";
        swift.symbol = "swift ";
        typst.symbol = "typst ";
        terraform.symbol = "terraform ";
        zig.symbol = "zig ";
      };
    };
  };
}
