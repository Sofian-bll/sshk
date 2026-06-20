<div align="center">

[![License: MIT](https://img.shields.io/github/license/Sofian-bll/sshk?style=flat)](https://github.com/Sofian-bll/sshk/blob/main/LICENSE)
[![Version](https://img.shields.io/github/v/release/Sofian-bll/sshk?style=flat)](https://github.com/Sofian-bll/sshk/releases)
[![Stars](https://img.shields.io/github/stars/Sofian-bll/sshk?style=flat)](https://github.com/Sofian-bll/sshk/stargazers)

<p align="center">
  <img src="docs/assets/logo.png" width="160" alt="sshk logo"/>
</p>

<h1 id="readme-top" align="center">sshk</h1>

<p align="center">SSH Key Manager — create, organize, grant, and revoke SSH keys. Pure Bash + OpenSSH.</p>

<p align="center">🇬🇧 <a href="README.md"><b>English</b></a> · 🇫🇷 <a href="README.fr.md">Français</a></p>

</div>

---

<p align="center">
  <a href="https://sofian-bll.github.io/sshk/"><strong>Explore the docs</strong></a>
  ·
  <a href="https://github.com/Sofian-bll/sshk/issues/new?labels=bug">Report Bug</a>
  ·
  <a href="https://github.com/Sofian-bll/sshk/issues/new?labels=enhancement">Request Feature</a>
</p>

<details open>
  <summary>Table of Contents</summary>
  <ol>
    <li><a href="#features">Features</a></li>
    <li><a href="#built-with">Built With</a></li>
    <li><a href="#quick-start">Quick Start</a></li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#how-it-works">How It Works</a></li>
    <li><a href="#configuration">Configuration</a></li>
    <li><a href="#server-setup">Server Setup</a></li>
    <li><a href="#project-structure">Project Structure</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
  </ol>
</details>

## Features

<p align="right">(<a href="#readme-top">back to top</a>)</p>

- **One identity per purpose** — each SSH key lives in its own namespace under `~/.ssh/keys/`
- **Manage outgoing identities** — `create`, `list`, `show`, `copy`, `delete` with one command per action
- **Manage incoming access** — `grant` and `revoke` who can connect to your machines
- **Zero dependencies** — pure Bash, only needs OpenSSH (standard on macOS and Linux)
- **All key types supported** — ed25519 (recommended), RSA 4096, and any type OpenSSH supports

## Built With

<p align="right">(<a href="#readme-top">back to top</a>)</p>

- [![Bash](https://img.shields.io/badge/bash-%23121011.svg?style=flat&logo=gnu-bash&logoColor=white)](#) — scripting language
- [OpenSSH](https://www.openssh.com/) — key generation, fingerprinting, and transport
- [Git](https://git-scm.com/) — version control

## Quick Start

<p align="right">(<a href="#readme-top">back to top</a>)</p>

```bash
curl -fsSL https://raw.githubusercontent.com/Sofian-bll/sshk/main/install.sh | bash
```

Make sure `~/.local/bin` is in your `PATH`, then:

```bash
sshk create       # Interactive wizard to create a new SSH key
sshk list         # List all identities and authorized accesses
sshk copy github  # Copy a public key to clipboard
sshk grant vela   # Push a key to a remote server
```

## Usage

<p align="right">(<a href="#readme-top">back to top</a>)</p>

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

  › Name      : github
  › Type      [1=ed25519, 2=rsa4096] [1] :
  › Comment   [git@github] :
  › HostName  (leave empty if sshk doesn't contact this machine) :

  Name        : github
  Type        : ed25519
  File        : ~/.ssh/keys/github/id_ed25519

  Create? [Y/n]

  ✅ Key created.
  ✅ Created: ~/.ssh/config.d/github.conf
```

### List all keys

```
$ sshk list

  NAME         TYPE    FINGERPRINT           CREATED
  ──────────────────────────────────────────────────
  github       ed25519 SHA256:nsUE...        2026-03-03
  vela         ed25519 SHA256:s7N3...        2026-06-01
  void         ed25519 SHA256:gszk...        2026-06-01
```

### Show key details

```
$ sshk show vela

  🔑  vela
  Type        : ed25519
  Fingerprint : SHA256:s7N3Um...
  Comment     : sofian@vela
  Created     : 2026-06-01
  Path        : ~/.ssh/keys/vela/id_ed25519
  Config      : ~/.ssh/config.d/vela.conf
    HostName  : 100.77.184.28

  ssh         : ssh vela
  copy        : sshk copy vela
  delete      : sshk delete vela
```

### Grant access to a server

```
$ sshk grant void

  ℹ  Copying public key to void (100.115.31.73)...
  ✅ Access granted → macbook authorized on void.
```

## How It Works

<p align="right">(<a href="#readme-top">back to top</a>)</p>

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

<p align="right">(<a href="#readme-top">back to top</a>)</p>

On first run, `sshk` creates `~/.config/sshk/config` with defaults. Edit it to customize:

| Option | Default | Description |
|--------|---------|-------------|
| `SSHK_DEFAULT_TYPE` | `ed25519` | Default key type (`ed25519` or `rsa`) |
| `SSHK_DEFAULT_USER` | `$USER` | Default SSH user for HostName blocks |
| `SSHK_KEYS_DIR` | `~/.ssh/keys` | Override keys directory |
| `SSHK_AUTH_DIR` | `~/.ssh/authorized_keys.d` | Override authorized keys directory |
| `SSHK_CONFIG_DIR` | `~/.ssh/config.d` | Override SSH config snippets directory |

## Server Setup

<p align="right">(<a href="#readme-top">back to top</a>)</p>

On each server, enable `authorized_keys.d/` once for `grant` to work:

```bash
mkdir -p ~/.ssh/authorized_keys.d
chmod 700 ~/.ssh/authorized_keys.d
echo 'AuthorizedKeysFile .ssh/authorized_keys .ssh/authorized_keys.d/*' | sudo tee -a /etc/ssh/sshd_config
sudo systemctl restart sshd
```

## Project Structure

<p align="right">(<a href="#readme-top">back to top</a>)</p>

```
sshk/
├── assets/
│   └── logo.svg
├── docs/
│   ├── assets/
│   │   ├── logo.png
│   │   ├── logo-512.png
│   │   └── screenshot.png
│   ├── screenshots/
│   │   ├── sshk-help.png
│   │   ├── sshk-list.png
│   │   └── sshk-show.png
│   └── index.html
├── install.sh
├── LICENSE
├── README.fr.md
├── README.md
└── sshk
```

## Contributing

<p align="right">(<a href="#readme-top">back to top</a>)</p>

Contributions are welcome. Here's how:

1. Fork the repository
2. Create a branch (`git checkout -b feat/amazing-feature`)
3. Commit your changes (`git commit -m 'feat: add amazing feature'`)
4. Push to the branch (`git push origin feat/amazing-feature`)
5. Open a Pull Request

<a href="https://github.com/Sofian-bll/sshk/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=Sofian-bll/sshk" alt="Contributors"/>
</a>

## License

<p align="right">(<a href="#readme-top">back to top</a>)</p>

Distributed under the MIT License. See [LICENSE](LICENSE) for more information.

---

<div align="center">

[![Star History Chart](https://api.star-history.com/svg?repos=Sofian-bll/sshk&type=Date)](https://star-history.com/#Sofian-bll/sshk&Date)

</div>

<!-- REFERENCE_LINKS -->
[stars-shield]: https://img.shields.io/github/stars/Sofian-bll/sshk?style=flat
[license-shield]: https://img.shields.io/github/license/Sofian-bll/sshk?style=flat
[version-shield]: https://img.shields.io/github/v/release/Sofian-bll/sshk?style=flat
