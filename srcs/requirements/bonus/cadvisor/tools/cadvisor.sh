#!/bin/bash

mkdir -p /dev/kmsg

exec "$@" -port 8888