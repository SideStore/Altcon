#!/bin/bash

# See if we can get the latest, it's ok if these fail, they are in the image still
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

printf "\nPlug in your idevice and enter your passcode.\n"
printf "=============================================\n"
while ! idevicepair pair; do
  sleep 1s
done

udid=$(idevice_id | awk '{print $1}')
echo -e "\nTo install an IPA, run the following command and change \033[0;31mmyemail\033[0m and \033[0;31mmyapplepass\033[0m. The \033[0;32mUDID\033[0m is already correct:"
echo -e "./AltServer -u \033[0;32m${udid}\033[0m -a \033[0;31mmyemail@mail.com\033[0m -p \033[0;31mmyapplepass\033[0m SideStore.ipa\n"
printf "Use this host IP address with port 6969 as your custom anisette server. This will ensure SideStore/AltStore will let you sign in\n"
printf "Once you're finished, type exit to exit the container you're now in.\n"
printf "===================================================================================================================\n"

/bin/bash
