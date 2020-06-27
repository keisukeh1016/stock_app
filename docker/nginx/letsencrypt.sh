#!/bin/bash

nginx

certbot certonly -m keisuke.example@gmail.com -d stock-app.net -n --agree-tos --nginx --force-renewal