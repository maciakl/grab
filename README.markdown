# ✊ grab

A simple bash script to install the latest version of single-executable binaries directly from GitHub.

## Philosophy

Imagine the following scenario: you are setting up a server, and want to quickly install couple of useful tools such as `eza`, `fzf`, `ripgrep` and `bat`. Problem is, this is Debian Stable and none of these are available via apt, or if they are, it’s an ancient, primordial version with half the features missing.

I wrote this script because I wanted around 10% of the functionality of [fox](https://www.getfox.sh/) with none of the hassle of having to install gh and having to authenticate against github servers.

## Usage

The usage for `grab` is as follows:

```
Usage: grab <github_user/repo> [executable_name]

  <github_user/repo>   : GitHub repository in the format user/repo
  [executable_name]    : (optional) name of the executable to install (if different from repo name)

Options:
  -h, --help           : Display this help message
  -v, --version        : Display grab version
  -l, --list           : List installed executables
  -ls, --list-simple   : Script friendly list (no formatting)
  -r, --remove <name>  : Uninstall the specified executable

Note: options are only allowed as the first argument.
```

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

⚠️ Note: As of 0.4.2 `grab` has clobbering protection. If a file with the same name as the one already exists in the default install directory, `grab` will warn and exit. This does not include symlinks managed by `grab` itself.

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
## Upgrading Progeams Installed with Grab

To uphrade a program to the latest version simply install it again. For example, to upgrade `grab` run:

```bash
grab maciakl/grab
```
This will automatically overwrite the old version with the new.

## Uninstalling Programs Installed with Grab

As of 0.4.0 `grab` installs programs in `/opt/grab` and then symlinks the file in `/usr/local/bin/` (or `/usr/bin` on solaris).

To uninstall a program called `foo` just run:

```bash
    grab -r foo
```

When you do this, `grab` will:

- verify that `/opt/grab/foo` exists
- verify that `/usr/local/bin/foo` (or `/usr/bin/foo`) exists
- verify that `/usr/local/bin/foo` (or `/usr/bin/foo`) is a symlink to `/opt/grab/foo`
- then and only then, it will delete both


## Installing / Upgrading

To install `grab` for the first time, you can use the following command:

```bash
wget -qN https://github.com/maciakl/grab/releases/download/v0.4.2/grab-0.4.2.zip \
-O /tmp/grab.zip \
&& unzip -q -o /tmp/grab.zip -d /tmp \
&& chmod +x /tmp/grab \
&& sudo mkdir -p /opt/grab \
&& sudo mv /tmp/grab /opt/grab \
&& sudo ln -sf /opt/grab/grab /usr/local/bin/grab
```

⚠️ Note: you need to make sure you have `unzip` installed before you try. On Solaris, change `/usr/local/bin` to `/usr/bin`.

### Upgrading

You can upgrade `grab` via `grab` itself:

```bash
grab maciakl/grab
```

### Uninstalling

To remove `grab` from your system run:

```bash
grab -r grab
```

⚠️ Note: this will only remove `grab` itself. All programs it installed will remain in `/opt/grab` and their symlinks will persist in `/usr/local/bin` (or `/usr/bin` on solaris) and will need to be purged manually.
