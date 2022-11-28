# Dotfiles

## NPM Security

The install scripts set `ignore-scripts` to true to ignore any pre- and post-install hooks from npm packages.

```bash
npm config set ignore-scripts true
```

## Setup OS X

```bash
xcode-select --install # install command line developer tools
git clone git@github.com:ollesve/dotfiles.git
cd dotfiles
sh osx.sh
```
## Setup Ubuntu

### Setup

Open terminal

```bash
git clone git@github.com:ollesve/dotfiles.git
cd dotfiles
sh ubuntu.sh
```

### Hot Reloading frameworks

To have developer servers such as react and preact, filewatch limit has to be increased for users.

```bash
echo 100000 | sudo tee /proc/sys/fs/inotify/max_user_watches
echo fs.inotify.max_user_watches=100000 | sudo tee -a /etc/sysctl.conf
sudo sysctl -p
```

## .gitconfig-user

Update .gitconfig-user email, user, username, and signingkey if applicable.

## Fixes and workarounds

### Ubuntu on NUC Audio & Mic combojack fix

#### Get codec info

```bash
cat /proc/asound/card*/codec* | grep Codec
```

[Lookup model on kernel.org](https://www.kernel.org/doc/html/latest/sound/hd-audio/models.html)

#### Add setting to end of /etc/modprobe.d/alsa-base.conf file

```bash
options snd-hda-intel model=dell-headset-multi
```