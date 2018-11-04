#!/bin/bash

emerge -uDN world -j1

rc-update add cronie default
rc-update add dbus default
