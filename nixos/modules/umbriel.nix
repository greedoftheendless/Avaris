{
  inputs,
  ...
}: {
  imports = [ inputs.umbriel.nixosModules.default ];

  programs.umbriel.enable = true;

  home-manager.users.greed = {
    imports = [ inputs.umbriel.homeModules.default ];

    programs.umbriel.enable = true;
  };
}
