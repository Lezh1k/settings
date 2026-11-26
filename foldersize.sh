#!/bin/bash
dst=$1
if [ -z "$1" ]; then
  dst=. 
fi
du -h --max-depth=1 -- "$dst" | sort -h
