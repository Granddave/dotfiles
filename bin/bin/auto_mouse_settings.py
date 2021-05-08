#!/usr/bin/env python3

import argparse

import Xlib
import Xlib.display
import Xlib.error
import Xlib.X

from alt_drag import set_alt_drag
from xinput import filter_devices, has_prop, set_prop


DEVICE_ID = None
devices = filter_devices("g203", only_pointer=True)
for device in devices:
    device_id = int(device["id"])
    if has_prop(device_id, "libinput Scroll Method Enabled"):
        DEVICE_ID = device_id
        break


def set_mouse_mode(enabled: bool, verbose=False):
    """Enables alt drag and middle mouse button drag to scroll"""

    if verbose:
        print("Setting mouse mode:", enabled)

    if type(enabled) is not bool:
        raise ValueError(f"'enabled' (type {type(enabled)}) is not of type bool")

    set_alt_drag(enabled, verbose)
    set_prop(DEVICE_ID, "libinput Scroll Method Enabled", 0, 0, int(enabled))
    set_prop(DEVICE_ID, "libinput Button Scrolling Button", 2)


def _run(window_names, verbose):
    disp = Xlib.display.Display()
    root = disp.screen().root

    NET_WM_NAME = disp.intern_atom("_NET_WM_NAME")
    NET_ACTIVE_WINDOW = disp.intern_atom("_NET_ACTIVE_WINDOW")
    root.change_attributes(event_mask=Xlib.X.FocusChangeMask)

    last_window_id = None
    mouse_mode_enabled_current = True
    set_mouse_mode(mouse_mode_enabled_current, verbose)
    while True:
        try:
            window_id = root.get_full_property(NET_ACTIVE_WINDOW, Xlib.X.AnyPropertyType).value[0]
            if window_id != last_window_id:
                last_window_id = window_id

                window = disp.create_resource_object("window", window_id)
                window.change_attributes(event_mask=Xlib.X.PropertyChangeMask)
                window_name = window.get_full_property(NET_WM_NAME, 0).value.decode("utf-8")

                if verbose:
                    print("Changed focus to", window_name)

                mouse_mode_enabled_new = window_name not in window_names
                if mouse_mode_enabled_current != mouse_mode_enabled_new:
                    set_mouse_mode(mouse_mode_enabled_new, verbose)
                    mouse_mode_enabled_current = mouse_mode_enabled_new

        except Xlib.error.XError:
            window_name = None

        _ = disp.next_event()


def _main():
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "window_names",
        nargs="+",
        help="disable custom mouse settings for these window names",
        type=str,
    )
    parser.add_argument("--verbose", "-v", action="store_true")
    parser.add_argument(
        "--device-id", type=int, help="override the auto discovered pointer device ID"
    )
    args = parser.parse_args()

    if args.device_id is not None:
        if not has_prop(args.device_id, "libinput Scroll Method Enabled"):
            raise ValueError("Pointer device does not have the required properties")
        global DEVICE_ID
        DEVICE_ID = args.device_id

    try:
        _run(args.window_names, args.verbose)
    except KeyboardInterrupt:
        pass


if __name__ == "__main__":
    _main()
