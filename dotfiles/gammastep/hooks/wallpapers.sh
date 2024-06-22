#!/bin/sh
# Uncomment to enable logging
# logger --tag "Gammastep" "Hook called with params $1 $2 $3"
case $1 in
   period-changed)
      # Uncomment this line or replace with correct background manager in order to update background
      # bgmanager set_background
      ;;
esac
