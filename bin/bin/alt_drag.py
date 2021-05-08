#!/usr/bin/env python3

import os
import subprocess
import argparse


CURRENT_DESKTOP_ENV = os.getenv("XDG_CURRENT_DESKTOP")
SUPPORTED_DESKTOP_ENVS = ["KDE", "ubuntu:GNOME"]


def _set_for_kde(enabled: bool):
    subprocess.run(
        [
            "kwriteconfig5",
            "--file",
            "~/.config/kwinrc",
            "--group",
            "MouseBindings",
            "--key",
            "CommandAllKey",
            # Kde does unfortunately not allow disable the alt drag feature.
            # Use the Meta key instead.
            "Alt" if enabled else "Meta",
        ]
    )
    subprocess.run(
        [
            "dbus-send",
            "--type=signal",
            "--dest=org.kde.KWin",
            "/KWin",
            "org.kde.KWin.reloadConfig",
        ]
    )


def _set_for_ubuntu_gnome(enabled: bool):
    subprocess.run(
        [
            "gsettings",
            "set",
            "org.gnome.desktop.wm.preferences",
            "mouse-button-modifier",
            "<Alt>" if enabled else "disabled",
        ]
    )


def set_alt_drag(enabled: bool, verbose=False):
    if CURRENT_DESKTOP_ENV is None:
        raise RuntimeError("Could not get XDG_CURRENT_DESKTOP")

    if CURRENT_DESKTOP_ENV == "KDE":
        _set_for_kde(enabled)
    elif CURRENT_DESKTOP_ENV == "ubuntu:GNOME":
        _set_for_ubuntu_gnome(enabled)
    else:
        raise RuntimeError("Not a supported desktop environment")

    if verbose:
        print("Alt drag", "enabled" if enabled else "disabled")


def is_supported_platform():
    return CURRENT_DESKTOP_ENV in SUPPORTED_DESKTOP_ENVS


def _main():
    if not is_supported_platform():
        print(f"'{CURRENT_DESKTOP_ENV}' is not a supported desktop environment")
        print(f"The only with support are {SUPPORTED_DESKTOP_ENVS}")
        exit(1)

    parser = argparse.ArgumentParser()
    parser.add_argument("enabled", type=int)
    parser.add_argument("--verbose", "-v", action="store_true")
    args = parser.parse_args()

    if args.enabled not in [0, 1]:
        raise ValueError("Argument not 1 or 0")

    set_alt_drag(bool(args.enabled), args.verbose)


if __name__ == "__main__":
    _main()
