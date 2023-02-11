# Altcon

Altcon is a container image that is meant to install any IPA of your choosing using AltServer-linux.
The benefitis of this container is that you only need an Apple account to install Sidestore for example.
Because all of this is in a container, you also don't leave anything on the host and it's easier to use. As pairing is done for you, the UDID is fetched for you aswell and the Sidestore IPA is already present to be installed with an example command.
The pairing file you'll need for Sidestore is available in `/var/lib/lockdown/*.plist` (on your host system).

The only thing that isn't included in this container is the ability to wifi refresh with AltServer-linux. However because Sidestore doesn't need this, i don't see the need to include this.

## Altcon+anisette

(soontm)
You'll be able to use only one command to get a fully working environment to install an IPA of your choosing. The default anisette in Altserver will lock your account immediatly. With docker-compose the anisette container will be setup and the environment variable will be adjusted accordingly so less mistakes will happen when installing an IPA file.

## How to run Altcon only

If you wish to only run altcon (excluding anisette), then run:

```bash
docker run --rm -it -e ALTSERVER_ANISETTE_SERVER="http://your.anisette.server.ip:6969" -v /dev/bus/usb:/dev/bus/usb -v /var/lib/lockdown:/var/lib/lockdown -v /var/run:/var/run -v /sys/fs/cgroup:/sys/fs/cgroup:ro --privileged macley/altcon
```

Note that the above command isn't optimized yet. This means that not all volume mounts may be needed or even privileged itself. Will experiment to futher reduce giving permission to the container.

### How it works

The container will try to pair with your iDevice, just plug it in and enter the pin. After the pairing is successful, you'll be brough into the terinal within the container. Then you'll only need to run the command that's present (adjust the mail and password to the apple account you wish to use).
I do advice to create a secondairy account (make sure it has logged into an idevice once, so it'll work).

## Credit

- [Dadoum's Anisette](https://github.com/Dadoum/Provision) for providing a stable anisette.
- [NyaMisty's AltServer-linux](https://github.com/NyaMisty/AltServer-Linux) for making Altserver work on Linux.
- [Powenn's AltServer-Linux-shellScript](https://github.com/powenn/AltServer-Linux-ShellScript) for helping me understand how to work with AltServer-Linux.
- [Hkfuertes's altserverd](https://github.com/hkfuertes/altserverd) for inspring me to make something more userfriendly, simpler and how to get the pairing to work within a container.
