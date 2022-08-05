#!/bin/bash
sudo apt update -y
sudo apt install apache2 -y
sudo service apache2 start
chkconfig apache2 on
