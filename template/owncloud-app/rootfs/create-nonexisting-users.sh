#!/bin/bash

php occ user:list | cut -d':' -f 1 | cut -d' ' -f 4 | while read line ; do 
        mkdir -p /data/owncloud/$line/files ;
        chmod a-rwx /data/owncloud/$line/files;
done

