#!/usr/bin/env python3

import re
import subprocess
import argparse
from pprint import pprint


class DeviceNotFoundException(Exception):
    pass


class PropertyNotFoundException(Exception):
    pass


class PropertySetException(Exception):
    pass


def _run_command(command):
    stdout = ""
    stderr = ""
    try:
        pipe = subprocess.Popen(command, stdout=subprocess.PIPE)
        stdout, stderr = pipe.communicate()
        if pipe.returncode != 0:
            raise RuntimeError(f"Subprocess returned with rc: {pipe.returncode}")
        return stdout.decode("utf8")
    except Exception as e:
        print("Subprocess error:", e)
        if stderr:
            print(stderr.decode("utf8"))
    return str()


def available_devices():
    output = _run_command(["xinput", "list"])
    pattern = re.compile(
        r"(?P<device_name>\w+(?:\s*\w+)*)\s*id=(?P<id>\d+)\s+\[(?P<master_slave>\w+)\s+(?P<type>\w+)\s+\((\d+)\)"
    )
    devices = [match.groupdict() for match in pattern.finditer(output)]
    return devices


def filter_devices(
    name_pattern: str = None, only_pointer: bool = False, only_keyboard: bool = False
):
    devices = available_devices()
    if name_pattern is not None:
        devices = [d for d in devices if name_pattern.lower() in d["device_name"].lower()]
    if only_pointer:
        devices = [d for d in devices if "pointer" == d["type"]]
    if only_keyboard:
        devices = [d for d in devices if "keyboard" == d["type"]]
    if not len(devices):
        raise DeviceNotFoundException(f"Could not find device with pattern {name_pattern}")
    return devices


def list_props(device_id):
    output = _run_command(["xinput", "list-props", str(device_id)])
    # Remove first line that specifies the device name
    output = "\n".join(output.splitlines()[1:])
    pattern = re.compile(
        r"\s+(?P<property_name>\w+(?:\s*\w+)*)\s\((?P<property_id>\d+)\):\s+(?P<value>.*)"
    )
    properties = [match.groupdict() for match in pattern.finditer(output)]
    return properties


def has_prop(device_id, property_name):
    props = list_props(device_id)
    found_prop = False
    for prop in props:
        if property_name in prop["property_name"]:
            found_prop = True
            break
    return found_prop


def set_prop(device_id: int, property_name: str, *values):
    if not has_prop(device_id, property_name):
        raise PropertyNotFoundException(
            f"Could not find property {property_name} for device {device_id}"
        )
    values = [str(v) for v in list(values)]
    command = ["xinput", "set-prop", str(device_id), property_name] + values
    output = _run_command(command)
    if output:
        raise PropertySetException


def _main():
    parser = argparse.ArgumentParser()
    subparsers = parser.add_subparsers(dest="command", required=True)

    device_parser = subparsers.add_parser("list-devices", help="list devices")
    device_parser.add_argument(
        "--device-pattern", "-d", help="filter by device name pattern", type=str
    )
    device_parser.add_argument("--id", help="list the device IDs", action="store_true")
    device_type = device_parser.add_mutually_exclusive_group()
    device_type.add_argument(
        "--keyboard", "-k", help="filter by keyboard devices", action="store_true"
    )
    device_type.add_argument(
        "--pointer", "-p", help="filter by pointer devices", action="store_true"
    )

    props_parser = subparsers.add_parser("list-props", help="list device properties")
    props_parser.add_argument("id", help="device ID")

    set_prop_parser = subparsers.add_parser("set-props", help="set device properties")
    set_prop_parser.add_argument("device_id", help="device to operate on", type=int)
    set_prop_parser.add_argument(
        "property_name", help="which properlibinput Button Scrolling Buttonty to alter", type=str
    )
    set_prop_parser.add_argument("value", help="value(s) to set to property", nargs="+")

    args = parser.parse_args()

    if args.command == "list-props":
        pprint(list_props(args.id))
    elif args.command == "list-devices":
        devices = filter_devices(args.device_pattern, args.pointer, args.keyboard)
        if args.id:
            for device in devices:
                print(device["id"])
        else:
            pprint(devices)
    elif args.command == "set-props":
        set_prop(args.device_id, args.property_name, *args.value)


if __name__ == "__main__":
    _main()
