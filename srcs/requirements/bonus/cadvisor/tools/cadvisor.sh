#!/bin/bash

touch /dev/kmsg

exec "$@"
