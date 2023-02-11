#!/bin/bash

printf "\nPlug in your idevice and enter your passcode.\n"
printf "=============================================\n"
while ! idevicepair pair; do
  sleep 1s
done

udid=$(idevice_id | awk '{print $1}')
echo -e "\nTo install an IPA, run the following command and change \033[0;31mmyemail\033[0m and \033[0;31mmyapplepass\033[0m. The \033[0;32mUDID\033[0m is already correct:"
echo -e "./AltServer -u \033[0;32m${udid}\033[0m -a \033[0;31mmyemail@mail.com\033[0m -p \033[0;31mmyapplepass\033[0m SideStore.ipa\n"
printf "Once you're finished, type exit to exit the container you're now in.\n"
printf "=============================================================================================================\n"

/bin/bash
