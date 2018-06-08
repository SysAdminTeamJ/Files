#!/bin/bash

mysqldump -u root  --all-databases --add-drop-table > /home/sqldump/db-backup.sql


