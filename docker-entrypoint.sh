#!/bin/bash

# Get udid
if ! idevice_id; then
  echo "Plug the device in, then run the command!"
  exit
fi

udid=$(idevice_id | awk '{print $1}')

# Check if we need to pair
printf "\nVerify if current mobiledevicepairing file is valid.\n"
printf "====================================================\n"
if ! idevicepair validate -u "${udid}"; then
  printf "\nEnter your passcode.\n"
  printf "====================\n"
  while ! idevicepair pair; do
    sleep 1s
  done
fi

# Ensure UDID key is present in mobiledevicepairing before we copy to host through mount
printf "\nCopying mobiledevicepairing file for SideStore to current directory on host machine.\n"
printf "====================================================================================\n"
if ! grep -q "<key>UDID</key>" "/tmp/lockdown/${udid}.plist"; then
    sed -i "/<\/dict>/ i\\
        <key>UDID</key>\\
        <string>$udid</string>" "/tmp/lockdown/${udid}.plist"
fi
cp --verbose /tmp/lockdown/${udid}.plist /mnt/${udid}.mobiledevicepairing

# Get SideStore ipa
printf "\nDownloading SideStore.ipa.\n"
printf "==========================\n"
curl --progress-bar -L -o SideStore.ipa https://github.com/SideStore/SideStore/releases/latest/download/SideStore.ipa

# Get SideStore-Nightly ipa
printf "\nDownloading SideStore-Nightly.ipa.\n"
printf "==================================\n"
curl --progress-bar -L -o SideStore-Nightly.ipa https://github.com/SideStore/SideStore/releases/download/nightly/SideStore.ipa

# Explain how to install IPA and how to exit container
echo -e "\nTo install an IPA, run the following command and change \033[0;31mmyemail\033[0m and \033[0;31mmyapplepass\033[0m. The \033[0;32mUDID\033[0m is already correct:"
printf "=============================================================================================================\n"
echo -e "./AltServer -u \033[0;32m${udid}\033[0m -a \033[0;31mmyemail@mail.com\033[0m -p \033[0;31mmyapplepass\033[0m SideStore.ipa\n"
echo -e "\nDo note that if your password contains special characters like '@','$' '!'or a space."
echo "It may not work and you need to put backslashes before it"
echo "For example, if your password is 'azerty79!?', you need to write 'azerty79\!\?'"
printf "=====================================================================================\n"
echo -e "\nOnce you're finished, type: \033[0;35mexit\033[0m."
printf "=================================\n\n"

# Throw user into a shell
/bin/bash
