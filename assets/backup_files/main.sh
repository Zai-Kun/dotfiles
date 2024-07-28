#!/bin/bash

if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <pack|unpack>"
  exit 1
fi

CURRENT_DIR=$(pwd)
BACKUP_FILE="$CURRENT_DIR/backup.tar"

case "$1" in
  pack)

    cat ignore.txt | tar --exclude-from=- -cf "$BACKUP_FILE" -T paths.txt
    echo "Packed files into $BACKUP_FILE"
    ;;
  unpack)
    if [ ! -f "$BACKUP_FILE" ]; then
      echo "backup.tar does not exist in the current directory."
      exit 1
    fi
    cd /
    tar -xvf "$BACKUP_FILE"
    echo "Unpacked files from $BACKUP_FILE to /"
    ;;
  *)
    echo "Invalid argument. Use 'pack' or 'unpack'."
    exit 1
    ;;
esac

