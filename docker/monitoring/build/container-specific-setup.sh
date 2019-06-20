#!/bin/bash

emerge -uDN --changed-use --with-bdeps=y world -j1

rc-update add prometheus default
rc-update add collectd default
