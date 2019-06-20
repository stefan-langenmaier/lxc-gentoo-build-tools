#!/bin/bash

emerge -uDN --changed-use --with-bdeps=y world -j1

rc-update add cronie default
rc-update add dbus default
