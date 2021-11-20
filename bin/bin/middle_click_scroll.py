#!/usr/bin/env python3

import argparse

from xinput import filter_devices, has_prop, set_prop, DeviceNotFoundException


def set_mode(enabled: bool, device_name: str = None, device_id: int = None):
    if device_id is None:
        for device in filter_devices(device_name, only_pointer=True):
            device_id = int(device["id"])
            if has_prop(device_id, "libinput Scroll Method Enabled"):
                device_id = device_id
                break

    set_prop(device_id, "libinput Scroll Method Enabled", 0, 0, int(enabled))
    set_prop(device_id, "libinput Button Scrolling Button", 2)


def str2bool(v):
    if isinstance(v, bool):
        return v
    if v.lower() in ("enabled", "yes", "true", "t", "y", "1"):
        return True
    elif v.lower() in ("disabled", "no", "false", "f", "n", "0"):
        return False
    else:
        raise argparse.ArgumentTypeError("Boolean value expected.")


def _main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--device-name", "-d", type=str, help="", required=True)
    parser.add_argument("enabled", type=str2bool)
    args = parser.parse_args()

    try:
        set_mode(args.enabled, args.device_name)
    except DeviceNotFoundException:
        pass  # Don't care if we didn't find the device


if __name__ == "__main__":
    _main()
