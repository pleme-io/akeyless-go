{
  description = "Auto-generated Go SDK for the Akeyless API (604 endpoints, regenerated via forge-gen --sdks go from api/openapi.yaml)";
  inputs = {
    nixpkgs.follows = "substrate/nixpkgs";
    substrate = { url = "github:pleme-io/substrate";};
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = inputs: (import "${inputs.substrate}/lib/repo-flake.nix" {
    inherit (inputs) nixpkgs flake-utils;
  }) {
    self = inputs.self;
    language = "go";
    builder = "devShell";
    pname = "akeyless-go";
    description = "Auto-generated Go SDK for the Akeyless API";
  };
}
