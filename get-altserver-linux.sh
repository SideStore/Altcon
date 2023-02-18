#!/bin/bash

# Check if we're running 32-bit arm, x86 or else aarch64/x86_64
if [[ "$(uname -m)" = 'arm'* ]]; then
  curl -sL -o AltServer $(curl -s https://api.github.com/repos/NyaMisty/AltServer-Linux/releases/latest | grep "browser_download_url.*armv*" | cut -d : -f 2,3 | tr -d \")
else
  curl -sL -o AltServer $(curl -s https://api.github.com/repos/NyaMisty/AltServer-Linux/releases/latest | grep "browser_download_url.*$(uname -m)*" | cut -d : -f 2,3 | tr -d \")
fi
chmod +x AltServer

# Get SideStore Stable and Nightly
curl -sL -o SideStore.ipa $(curl -s https://github.com/SideStore/SideStore/releases/latest/download/SideStore.ipa | grep "browser_download_url.*armv*" | cut -d : -f 2,3 | tr -d \")
curl -sL -o SideStore-Nightly.ipa $(curl -s https://github.com/SideStore/SideStore/releases/download/nightly/SideStore.ipa | grep "browser_download_url.*armv*" | cut -d : -f 2,3 | tr -d \")
