#!/bin/bash
echo '{ "internet_ip":' '"'$(curl -s https://checkip.amazonaws.com/)'" }'
