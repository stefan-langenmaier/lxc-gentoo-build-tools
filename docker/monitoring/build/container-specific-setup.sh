#!/bin/bash

emerge -uDN world -j1

rc-update add prometheus default
rc-update add collectd default
