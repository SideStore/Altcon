#!/bin/bash

# Check if we're running 32-bit arm, x86 or else aarch64/x86_64
if [[ "$(uname -m)" = 'arm'* ]]; then
  curl -L -o AltServer $(curl -s https://api.github.com/repos/NyaMisty/AltServer-Linux/releases/latest | grep "browser_download_url.*armv*" | cut -d : -f 2,3 | tr -d \")
  curl -L -o jitterbugpair.zip $(curl -s https://api.github.com/repos/Dadoum/Jitterbug-cross/releases/latest | grep "browser_download_url.*armv*" | cut -d : -f 2,3 | tr -d \")
  unzip jitterbugpair.zip
elif [[ "$(uname -m)" = 'i'* ]]; then
  curl -L -o AltServer $(curl -s https://api.github.com/repos/NyaMisty/AltServer-Linux/releases/latest | grep "browser_download_url.*86" | grep -E '86\>' | cut -d : -f 2,3 | tr -d \")
  curl -L -o jitterbugpair.zip  $(curl -s https://api.github.com/repos/Dadoum/Jitterbug-cross/releases/latest | grep "browser_download_url.*86" | grep -E '86\>' | cut -d : -f 2,3 | tr -d \")
  unzip jitterbugpair.zip
else
  curl -L -o AltServer $(curl -s https://api.github.com/repos/NyaMisty/AltServer-Linux/releases/latest | grep "browser_download_url.*$(uname -m)*" | cut -d : -f 2,3 | tr -d \")
  curl -L -o jitterbugpair.zip $(curl -s https://api.github.com/repos/Dadoum/Jitterbug-cross/releases/latest | grep "browser_download_url.*$(uname -m)*" | cut -d : -f 2,3 | tr -d \")
  unzip jitterbugpair.zip
fi

rm jitterbugpair.zip
chmod +x AltServer jitterbugpair