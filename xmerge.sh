#!/bin/bash
CBUILD=$(portageq envvar CHOST)
PORTAGE_CONFIGROOT="$SYSROOT"
if [[ "$1" == "--root" ]] ; then
    ROOT="$2"
    shift 2
else
    ROOT="$SYSROOT"
fi
export CBUILD PORTAGE_CONFIGROOT ROOT

emerge $*
