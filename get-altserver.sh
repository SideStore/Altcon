#!/bin/bash

# Check if we're running 32-bit arm, x86 or else aarch64/x86_64
if [[ "$(uname -m)" = 'arm'* ]]; then
  curl -sL -o AltServer $(curl -s https://api.github.com/repos/Dadoum/Jitterbug-cross/releases/latest | grep "browser_download_url.*armv*" | cut -d : -f 2,3 | tr -d \")
  curl -sL -o jitterbugpair.zip $(curl -s https://api.github.com/repos/Dadoum/Jitterbug-cross/releases/latest | grep "browser_download_url.*armv*" | cut -d : -f 2,3 | tr -d \")
  unzip jitterbugpair.zip
else
  curl -sL -o AltServer $(curl -s https://api.github.com/repos/Dadoum/Jitterbug-cross/releases/latest | grep "browser_download_url.*$(uname -m)*" | cut -d : -f 2,3 | tr -d \")
  curl -sL -o jitterbugpair.zip $(curl -s https://api.github.com/repos/Dadoum/Jitterbug-cross/releases/latest | grep "browser_download_url.*$(uname -m)*" | cut -d : -f 2,3 | tr -d \")
  unzip jitterbugpair.zip
fi

rm jitterbugpair.zip
chmod +x AltServer jitterbugpair