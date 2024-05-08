{
    description = "A very basic flake";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    };

    outputs = { self, nixpkgs }: rec {
        packages.x86_64-linux.lua-pam =
        let pkgs = import nixpkgs { system = "x86_64-linux"; };
        in pkgs.stdenv.mkDerivation {
            pname = "lua-pam";
            version = "1.0.0";
            src = ./.;
            nativeBuildInputs = with pkgs; [ cmake lua pam ];
            installPhase = ''
                mkdir -p $out/etc/xdg/awesome/
                cp liblua_pam.so $out/etc/xdg/awesome/
            '';
        };

        packages.x86_64-linux.default = packages.x86_64-linux.lua-pam;

        #overlay = final: prev: { lua-pam = prev.lua-pam; };
    };
}
