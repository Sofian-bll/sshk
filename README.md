<div align="center">

[![License: MIT](https://img.shields.io/github/license/Sofian-bll/sshk?style=flat)](https://github.com/Sofian-bll/sshk/blob/main/LICENSE)
[![Version](https://img.shields.io/github/v/release/Sofian-bll/sshk?style=flat)](https://github.com/Sofian-bll/sshk/releases)
[![Stars](https://img.shields.io/github/stars/Sofian-bll/sshk?style=flat)](https://github.com/Sofian-bll/sshk/stargazers)

<p align="center">
  <img src="docs/assets/logo.png" width="160" alt="sshk logo"/>
</p>

<a id="readme-top"></a>
<h1 align="center">sshk</h1>

<p align="center">SSH Key Manager — create, organize, grant, and revoke SSH keys. Pure Bash + OpenSSH.</p>

<p align="center">🇬🇧 <a href="README.md"><b>English</b></a> · 🇫🇷 <a href="README.fr.md">Français</a></p>

</div>

## What is this?

`sshk` brings order to your SSH keys with a predictable directory structure — one identity per purpose, one command per action. Manage outgoing identities (keys you use to connect to other machines) and incoming access (keys that can connect to you) with the same tool. Zero dependencies beyond OpenSSH.

<img src="docs/screenshots/sshk-list.png" width="720" alt="sshk list"/>

## Quick Start

```bash
curl -fsSL https://raw.githubusercontent.com/Sofian-bll/sshk/main/install.sh | bash
```

Make sure `~/.local/bin` is in your `PATH`, then:

```bash
sshk create      # Interactive wizard to create a new SSH key
sshk list        # List all identities and authorized accesses
sshk copy NAME   # Copy a public key to clipboard
sshk grant NAME  # Push a key to a remote server
```

## Usage

```
$ sshk

  🔑  sshk — SSH Key Manager

  Usage: sshk <command> [options]

  Outgoing Identities
  ──────────────────────────────────────────────────
  create          Interactive creation wizard
  list            List everything (identities + access)
  list --keys     My identities only
  list --auth     Incoming access only
  show <name>     Identity details
  copy <name>     Copy public key
  delete <name>   Delete an identity

  Incoming Access
  ──────────────────────────────────────────────────
  grant <name>    Authorize a remote machine
  revoke <name>   Revoke access
```

### Create a key

```
$ sshk create
New identity name: github
Key type (1=ed25519 recommended, 2=rsa 4096) [1]:
Comment [sofian@github]:
HostName [github.com]:

  📋 Summary
  Name      : github
  Type      : ed25519
  HostName  : github.com

Create this identity? [Y/n]
✅ Identity created.
```

### List all keys

```
$ sshk list

  NAME     TYPE      FINGERPRINT           CREATED
  ──────────────────────────────────────────────────
  github   ed25519   SHA256:nsUE...          03/03
  vela     ed25519   SHA256:s7N3...          01/06
  void     ed25519   SHA256:gszk...          01/06
```

### Show key details

```
$ sshk show vela

  🔑  vela
  Type       : ed25519
  Fingerprint: SHA256:s7N3Um...
  Comment    : sofian@vela
  Created    : 2026-06-01
  Path       : ~/.ssh/keys/vela/id_ed25519
  Config     : ~/.ssh/config.d/vela.conf
    HostName : 100.77.184.28

  ssh         : ssh vela
  copy        : sshk copy vela
```

### Grant access to a server

```
$ sshk grant void
ℹ  Copying public key to void (100.115.31.73)...
✅ Access granted → macbook authorized on void.
```

## How it works

`sshk` organizes SSH keys into three directories under `~/.ssh/`:

```
~/.ssh/
├── keys/                  # Your identities (who you are)
│   ├── github/
│   │   └── id_ed25519
│   └── vela/
│       └── id_ed25519
├── config.d/              # SSH config snippets (ssh <name>)
│   ├── github.conf
│   └── vela.conf
└── authorized_keys.d/     # Who can connect to you
    └── macbook
```

No more flat `~/.ssh/id_rsa` mess. Each identity is namespaced, with a matching config snippet and authorized keys entry.

## Configuration

On first run, `sshk` creates `~/.config/sshk/config` with defaults. Edit it to customize:

| Option | Default | Description |
|--------|---------|-------------|
| `SSHK_DEFAULT_TYPE` | `ed25519` | Default key type (`ed25519` or `rsa`) |
| `SSHK_DEFAULT_USER` | `$USER` | Default SSH user for HostName blocks |
| `SSHK_KEYS_DIR` | `~/.ssh/keys` | Override keys directory |
| `SSHK_AUTH_DIR` | `~/.ssh/authorized_keys.d` | Override authorized keys directory |
| `SSHK_CONFIG_DIR` | `~/.ssh/config.d` | Override SSH config snippets directory |

## Server Setup (for `grant`)

On each server, enable `authorized_keys.d/` once:

```bash
mkdir -p ~/.ssh/authorized_keys.d
chmod 700 ~/.ssh/authorized_keys.d
echo 'AuthorizedKeysFile .ssh/authorized_keys .ssh/authorized_keys.d/*' | sudo tee -a /etc/ssh/sshd_config
sudo systemctl restart sshd
```

## Project Structure

```
sshk/
├── docs/            # GitHub Pages landing page and assets
├── install.sh      # One-line installer via curl
├── README.md       # This file
├── LICENSE         # MIT license
└── sshk            # Main script (~550 lines, Bash)
```

## Documentation

| Resource | Description |
|----------|-------------|
| [`docs/index.html`](docs/index.html) | GitHub Pages landing page |
| `sshk` | Main script — all commands, key helpers, clipboard support |
| `install.sh` | One-line installer for `~/.local/bin` |

## License

[MIT](LICENSE)

---

<div align="center">

[![Star History Chart](https://api.star-history.com/svg?repos=Sofian-bll/sshk&type=Date)](https://star-history.com/#Sofian-bll/sshk&Date)

</div>
