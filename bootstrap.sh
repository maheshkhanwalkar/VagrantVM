#!/usr/bin/env bash

apt-get update
apt install -y build-essential cmake clang lld   # C/C++ tools
apt install -y qemu xorriso bochs                # OS tools
