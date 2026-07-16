# Source the Nix profile scripts for non-NixOS systems
if not grep -q '^ID=nixos$' /etc/os-release
    set -l nix_profile "/nix/var/nix/profiles/default/etc/profile.d"
    if test -e $nix_profile/nix-daemon.fish
        source $nix_profile/nix-daemon.fish
    else if test -e $nix_profile/nix.fish
        source $nix_profile/nix.fish
    end
end
