#!/bin/bash

emerge --config =dev-db/mariadb
cp /etc/mysql/my.cnf.cluster /etc/mysql/my.cnf
