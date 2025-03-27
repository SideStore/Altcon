#!/bin/bash

printf "\nPlug in your idevice and enter your passcode.\n"
printf "=============================================\n"
while ! idevicepair pair; do
  sleep 1s
done

# Get SideStore ipa
printf "\nDownloading SideStore.ipa stable.\n"
printf "=================================\n"
curl --progress-bar -L -o SideStore.ipa $(curl -s https://api.github.com/repos/SideStore/SideStore/releases/latest | grep "browser_download_url.*SideStore.ipa*" | cut -d : -f 2,3 | tr -d \")

# Get SideStore-Nightly ipa
printf "\nDownloading SideStore.ipa nightly.\n"
printf "=================================\n"
curl --progress-bar -L -o SideStore-Nightly.ipa https://github.com/SideStore/SideStore/releases/download/nightly/SideStore.ipa

# Get udid
udid=$(idevice_id | awk '{print $1}')

# Generate mobiledevicepairing file
printf "\nGenerating mobiledevicepairing file for SideStore\n"
printf "===============================================================\n"
./jitterbugpair -c > /mnt/${udid}.mobiledevicepairing && echo "Check your home folder on your host/after your exit, and copy the ${udid}.mobiledevicepairing file to your iDevice."

echo -e "\nTo install an IPA, run the following command and change \033[0;31mmyemail\033[0m and \033[0;31mmyapplepass\033[0m. The \033[0;32mUDID\033[0m is already correct:"
printf "=============================================================================================================\n"
echo -e "./AltServer -u \033[0;32m${udid}\033[0m -a \033[0;31mmyemail@mail.com\033[0m -p \033[0;31mmyapplepass\033[0m SideStore.ipa\n"
echo -e "\nDo note that if your password contains special characters like '@','$' '!'or a space."
echo "It may not work and you need to put backslashes before it"
echo "For example, if your password is 'azerty79!?', you need to write 'azerty79\!\?'"
printf "=============================================================================================\n"
echo -e "\nOnce you're finished, type: \033[0;35mexit\033[0m."
printf "=================================\n\n"

/bin/bash
