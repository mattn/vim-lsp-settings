#!/usr/bin/env python3
import json
import sys


def send(message: dict):
    raw = json.dumps(message)
    message = "Content-Length: " + str(len(raw)) + "\r\n\r\n" + raw
    sys.stdout.write(message)


initialize = {
    "jsonrpc": "2.0",
    "id": 1,
    "method": "initialize",
    "params": {"processId": None, "rootUri": None, "capabilities": {}},
}
send(initialize)

initialized = {
    "jsonrpc": "2.0",
    "id": 2,
    "method": "initialized",
    "params": {},
}
send(initialized)

shutdown = {
    "jsonrpc": "2.0",
    "id": 3,
    "method": "shutdown",
    "params": {},
}
send(shutdown)

_exit = {
    "jsonrpc": "2.0",
    "id": 4,
    "method": "exit",
    "params": {},
}
send(_exit)
