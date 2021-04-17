#!/bin/sh

JSON_STRING='window.configs = { "API_URL":"'"${API_URL}"'"}'

sed -i "s@// CONFIGURATIONS_PLACEHOLDER@${JSON_STRING}@g" /usr/share/nginx/html/index.html

exec "$@"