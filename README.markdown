# ✊ grab

A simple bash script to install the latest version of single-executable binaries directly from GitHub.

## Philosophy

Imagine the following scenario: you are setting up a server, and want to quickly install couple of useful tools such as `eza`, `fzf`, `ripgrep` and `bat`. Problem is, this is Debian Stable and none of these are available via apt, or if they are, it’s an ancient, primordial version with half the features missing.

I wrote this script because I wanted around 10% of the functionality of [fox](https://www.getfox.sh/) with none of the hassle of having to install gh and having to authenticate against github servers.

## Usage

Grab takes 2 arguments:

1. The repository in the format `user/repo`
3. (optional) The name of the executable within the archive, if it's different from the repository name

You can skip the second argument, in which case it will default to the name of the repository (eg. `rg`).

The installed program must be:

- hosted on github
- the github repository has to have a published release
- the program must be a single executable file
- the archive in the release must be either a `.tar.gz` or a `.zip` file

It's not guaranteed to work with every repository, but it works with the handful I have tried. 

Grab is by no means production ready. It's just something I put together to make my life easier. Use it at your own risk.

Examples:

```bash
    grab junegunn/fzf
    grab eza-community/eza
    grab burntsushi/ripgrep rg
```
Grab is not smart enough to figure out which released version is correct for your platform, so it will list the available files and ask you which one you want.

![grab](https://github.com/user-attachments/assets/1a79c91f-a687-4858-bee1-9621373d0c2c)

You are the user, you press the buttons.

If you installed the wrong version, just run the command again. Grab will happily overwrite the previous version.

### Scripting Support

Grab is interactive. It will always ask and wait for a numeric input. If you already know which file from the release you want to install, and where it is on the list, you can use the `yes` command to pass it in. For example, if you know you want to install the first item from the list you can do it like so:

```bash
yes 1 | grab maciakl/grab
```

⚠️ Note: the ordering of the files may change between releases. Grab always downloads the latest release.

## Dependencies

Grab requires `bash`, `wget`, `curl`, `unzip` and `tar`. Most of these should be installed by default. If you are missing them, you can install them using your package manager. For example, on Debian-based systems you can run:

```bash
sudo apt install wget curl unzip
```


## Uninstalling Programs Installed with Grab

Grab installs programs in `/usr/local/bin/`. To uninstall a program called `foo` just run:

```bash
    sudo rm -f /usr/local/bin/foo
```


## Installing / Upgrading

To install `grab` for the first time, you can use the following command:

```bash
wget -qN https://github.com/maciakl/grab/releases/download/v0.3.3/grab-0.3.3.zip \
-O /tmp/grab.zip \
&& unzip -q -o /tmp/grab.zip -d /tmp \
&& chmod +x /tmp/grab \
&& sudo mv /tmp/grab /usr/local/bin/grab
```

⚠️ Note: you need to make sure you have `unzip` installed before you try.

### Upgrading

You can upgrade `grab` via `grab` itself:

```bash
grab maciakl/grab
```

### Uninstalling

To remove `grab` from your system run:

```bash
sudo rm -f /usr/local/bin/grab
```

⚠️ Note: this will only remove `grab` itself. All programs it installed will remain in `/usr/local/bin` and will need to be purged manually.
