#!/bin/bash

emerge -uDN world --changed-use --with-bdeps=y
rc-update add collectd default
