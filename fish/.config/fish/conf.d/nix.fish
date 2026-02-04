if test -e /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish
    source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish
else if test -e /nix/var/nix/profiles/default/etc/profile.d/nix.fish
    source /nix/var/nix/profiles/default/etc/profile.d/nix.fish
end
