#!/usr/bin/env python3
import Xlib
import Xlib.display
import subprocess
import time

disp = Xlib.display.Display()
root = disp.screen().root

NET_ACTIVE_WINDOW = disp.intern_atom('_NET_ACTIVE_WINDOW')
NET_WM_NAME = disp.intern_atom('_NET_WM_NAME')

last_seen = {'xid': None}
def get_active_window():
    window_id = root.get_full_property(NET_ACTIVE_WINDOW,
                                       Xlib.X.AnyPropertyType).value[0]

    focus_changed = (window_id != last_seen['xid'])
    last_seen['xid'] = window_id

    return window_id, focus_changed

def get_window_name(window_id):
    try:
        window_obj = disp.create_resource_object('window', window_id)
        window_name = window_obj.get_full_property(NET_WM_NAME, 0).value
    except Xlib.error.XError:
        window_name = None

    return window_name

def set_mouse_mode(value):
    subprocess.run(["/home/david/bin/set-alt-drag.sh", str(value)])

if __name__ == '__main__':
    root.change_attributes(event_mask=Xlib.X.PropertyChangeMask)
    while True:
        win, changed = get_active_window()
        if changed:
            if get_window_name(win) == b'Blender':
                set_mouse_mode(0)
            else:
                set_mouse_mode(1)

        time.sleep(0.2)
