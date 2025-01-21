#!/bin/bash
rm -rf src pkg *.tar.zst my-ml4w-*
makepkg $1
