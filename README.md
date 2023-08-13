# Altcon

Altcon is a container image that is meant to install any IPA of your choosing using AltServer-linux.
The benefitis of this container is that you only need an Apple account to install Sidestore for example.
Because all of this is in a container, you also don't leave anything on the host and it's easier to use. The UDID and pairingfile is fetched for you and the Sidestore IPA is already present too. After pairing you'll get an example command how to install the SideStore ipa.

You'll find your pairing file in the current directory when you leave the Altcon container. Email it to yourself and save it into files to import it using SideStore.

## How it works

The container will try to pair with your iDevice, just plug it in and enter your pin. After the pairing is successful, you'll be brought into the terminal within the container. Then you'll only need to run the command and adjust the apple account to the one of your choosing.
I do advice to [create a secondairy account](https://wiki.sidestore.io/guides/create-account.html#create-an-apple-id-account-itunes-method--no-mfa).
After you're done, you can type exit and the container will be removed.
You will see your pairingfile in your home directory (ends with .mobiledevicepairing). Copy this to your iDevice using mail/whatever so you can import it into SideStore.

### How to run Altcon

The following will install usbmuxd and docker. Run these as a none-root user and you only have to this once. After this you only need to use the docker run command.

```bash
sudo apt install -y usbmuxd
curl -fsSL https://test.docker.com -o test-docker.sh
sudo sh test-docker.sh
sudo usermod -aG docker $USER
docker run --rm -it -e ALTSERVER_ANISETTE_SERVER="https://ani.sidestore.io/" -v ${PWD}/:/mnt/ -v /var/run:/var/run sidestore/altcon
```

## Credit

- [Dadoum's Anisette](https://github.com/Dadoum/Provision) for providing a stable anisette.
- [NyaMisty's AltServer-linux](https://github.com/NyaMisty/AltServer-Linux) for making Altserver work on Linux.
- [Powenn's AltServer-Linux-shellScript](https://github.com/powenn/AltServer-Linux-ShellScript) for helping me understand how to work with AltServer-Linux.
- [Hkfuertes's altserverd](https://github.com/hkfuertes/altserverd) for inspring me to make something more userfriendly, simpler and how to get the pairing to work within a container.
- [Dadoum's Jitterbug-cross](https://github.com/Dadoum/Jitterbug-cross/releases) for making jitterbug available on arm devices.
- All of the SideStore community members <3