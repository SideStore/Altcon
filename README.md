# Altcon

Altcon is a container image that is meant to install any IPA of your choosing using AltServer-linux.
The benefitis of this container is that you only need an Apple account to install Sidestore for example.
Because all of this is in a container, you also don't leave anything on the host and it's easier to use. ~~As pairing is done for you,~~ the UDID is fetched for you aswell and the Sidestore IPA is already present too. After pairing you'll get an example command how to install the SideStore ipa.

~~The pairing file you'll need for Sidestore is available in `/var/lib/lockdown/*.plist` (on your host system).~~

The only thing that isn't included in this container is the ability to wifi refresh with AltServer-linux. However because Sidestore doesn't need this, i don't see the need to include this.

## How to run Altcon only

First install the needed dependency:

```bash
sudo apt install -y usbmuxd
```

To run Altcon itself:

```bash
docker run --rm -it -e ALTSERVER_ANISETTE_SERVER="http://your.anisette.server.ip:6969" -v /var/run:/var/run macley/altcon
```

### How it works

The container will try to pair with your iDevice, just plug it in and enter your pin. After the pairing is successful, you'll be brough into the terminal within the container. Then you'll only need to run the command and adjust the apple account to the one of your choosing.
I do advice to [create a secondairy account](https://wiki.sidestore.io/guides/create-account.html#create-an-apple-id-account-itunes-method--no-mfa).
After you're done, you can type exit and the container will be removed.

## Altcon+anisette

As of writing I host two anisette servers for the public, whilst you can use these to authenticate in the container and iDevice. I do advice you to run your own instance locally to minimze any potentional errors. Therefore i've created a docker-compose file to setup Anisette and Altcon with one single command. Anisettte will continue to run in the background so you can use the IP of the host to authenticate on your iDevice aswell. You no longer need to set the environment variable either, as this is done for you.

### How to run Altcon+anisette

The following will download the docker-compose file with all the details specified for you.
After that, the docker-compose command will run and remove the altcon container. Because anisette is a dependency, it will startup aswell and will continue to run in the background (even after exitting Altcon).

```bash
sudo apt install -y usbmuxd
wget https://raw.githubusercontent.com/Macleykun/Altcon/main/docker-compose.yml
docker-compose run --rm altcon
docker stop anisette && docker rm anisette
```

## Problem with the pairing file

During testing, i've noticed the pairing file generated by AltServer-Linux isn't correct and will not work with SideStore.
This means you must use Jitterbug to create a working pairing plist for your iDevice. Related issue: https://github.com/NyaMisty/AltServer-Linux/issues/90

## Credit

- [Dadoum's Anisette](https://github.com/Dadoum/Provision) for providing a stable anisette.
- [NyaMisty's AltServer-linux](https://github.com/NyaMisty/AltServer-Linux) for making Altserver work on Linux.
- [Powenn's AltServer-Linux-shellScript](https://github.com/powenn/AltServer-Linux-ShellScript) for helping me understand how to work with AltServer-Linux.
- [Hkfuertes's altserverd](https://github.com/hkfuertes/altserverd) for inspring me to make something more userfriendly, simpler and how to get the pairing to work within a container.
