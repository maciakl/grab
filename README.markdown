# grab

A simple bash script to install the latest version of single-executable binaries directly from GitHub.

## Philosophy

Imagine the following scenario: you are setting up a server, and want to quickly install couple of useful tools such as `eza`, `fzf`, `ripgrep` and `bat`. Problem is, this is Debian Stable and none of these are available via apt, or if they are, it’s an ancient, primordial version with half the features missing.

I wrote this script because I wanted around 10% of the functionality of [fox](https://www.getfox.sh/) with none of the hassle of having to install gh and having to authenticate against github servers.

## Usage

Grab takes 2 arguments:

1. The repository in the format `user/repo`
3. (optional) The name of the executable within the archive, if it's different from the repository name

You can skip the second argument, in which case it will default to the name of the repository (eg. `fzf`).

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

To install `grab`, you can use the following command:

```bash
wget -qN https://github.com/maciakl/grab/releases/latest/download/grab.tar.gz \
-O /tmp/grab.tar.gz \
&& tar -xzf /tmp/grab.tar.gz -C /tmp \
&& chmod +x /tmp/grab \
&& sudo mv /tmp/grab /usr/local/bin/grab
```

You can upgrade `grab` via `grab` itself:

```bash
grab maciakl/grab
```
