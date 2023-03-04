#!/bin/bash

printf "\nPlug in your idevice and enter your passcode.\n"
printf "=============================================\n"
while ! idevicepair pair; do
  sleep 1s
done

# Show what we download, we get both to leave the choice to the user and we now always have the latest
echo -e "\ncurl -sL -o SideStore.ipa $(curl -s https://api.github.com/repos/SideStore/SideStore/releases/latest | grep "browser_download_url.*SideStore.ipa*" | cut -d : -f 2,3 | tr -d \")"
curl -sL -o SideStore.ipa $(curl -s https://api.github.com/repos/SideStore/SideStore/releases/latest | grep "browser_download_url.*SideStore.ipa*" | cut -d : -f 2,3 | tr -d \")
echo -e "\ncurl -sL -o SideStore-Nightly.ipa https://github.com/SideStore/SideStore/releases/download/nightly/SideStore.ipa"
curl -sL -o SideStore-Nightly.ipa https://github.com/SideStore/SideStore/releases/download/nightly/SideStore.ipa

udid=$(idevice_id | awk '{print $1}')
echo -e "\nTo install an IPA, run the following command and change \033[0;31mmyemail\033[0m and \033[0;31mmyapplepass\033[0m. The \033[0;32mUDID\033[0m is already correct:"
echo -e "./AltServer -u \033[0;32m${udid}\033[0m -a \033[0;31mmyemail@mail.com\033[0m -p \033[0;31mmyapplepass\033[0m SideStore-Nightly.ipa\n"
printf "Use this host IP address with port 6969 as your custom anisette server. This will ensure SideStore/AltStore will let you sign in\n"
printf "Once you're finished, type exit to exit the container you're now in.\n"
printf "================================================================================================================================\n"

/bin/bash
