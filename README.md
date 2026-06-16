<div align="center">

# sshk

**SSH Key Manager — create, organize, grant, and revoke SSH keys. Pure Bash + OpenSSH.**

[![License: MIT](https://img.shields.io/github/license/Sofian-bll/sshk?style=for-the-badge)](https://github.com/Sofian-bll/sshk/blob/main/README.md)
[![Release](https://img.shields.io/github/v/release/Sofian-bll/sshk?style=for-the-badge)](https://github.com/Sofian-bll/sshk/releases)
[![Stars](https://img.shields.io/github/stars/Sofian-bll/sshk?style=for-the-badge)](https://github.com/Sofian-bll/sshk/stargazers)

</div>

## What is this?

`sshk` brings order to your SSH keys with a predictable directory structure — one identity per purpose, one command per action. Manage outgoing identities (keys you use to connect to other machines) and incoming access (keys that can connect to you) with the same tool. Zero dependencies beyond OpenSSH.

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

  🔑  sshk — Gestionnaire de clés SSH

  Usage : sshk <commande> [options]

  Identités (sortant)
  ──────────────────────────────────────────────────
  create          Assistant interactif de création
  list            Lister tout (identités + accès)
  list --keys     Seulement mes identités
  list --auth     Seulement les accès entrants
  show <nom>      Détails d'une identité
  copy <nom>      Copier la clé publique
  delete <nom>    Supprimer une identité

  Accès (entrant)
  ──────────────────────────────────────────────────
  grant <nom>     Autoriser une machine distante
  revoke <nom>    Révoquer l'accès
```

### Create a key

```
$ sshk create
Nom de la nouvelle identité : github
Type de clé (1=ed25519 recommandé, 2=rsa 4096) [1] :
Commentaire [sofian@github] :
Nom d'hôte (HostName) [github.com] :

  📋 Résumé
  Nom       : github
  Type      : ed25519
  HostName  : github.com

Créer cette identité ? [O/n]
✅ Identité créée.
```

### List all keys

```
$ sshk list

  NOM      TYPE      EMPREINTE              CRÉÉ
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
  Empreinte  : SHA256:s7N3Um...
  Comment    : sofian@vela
  Créée le   : 2026-06-01
  Chemin     : ~/.ssh/keys/vela/id_ed25519
  Config     : ~/.ssh/config.d/vela.conf
    HostName : 100.77.184.28

  ssh         : ssh vela
  copier      : sshk copy vela
```

### Grant access to a server

```
$ sshk grant void
ℹ  Copie de la clé publique vers void (100.115.31.73)...
✅ Accès accordé → macbook autorisé sur void.
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
├── install.sh      # One-line installer via curl
├── README.md       # This file
└── sskhk           # Main script (~500 lines, Bash)
```

## Documentation

| Resource | Description |
|----------|-------------|
| `sshk` | Main script — all commands, key helpers, clipboard support |
| `install.sh` | One-line installer for `~/.local/bin` |

## Contributing

PRs and issues welcome. Found a bug or have an idea? [Open an issue](https://github.com/Sofian-bll/sshk/issues).

<a href="https://github.com/Sofian-bll/sshk/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=Sofian-bll/sshk" />
</a>

## License

MIT

---

<div align="center">

[![Star History Chart](https://api.star-history.com/svg?repos=Sofian-bll/sshk&type=Date)](https://star-history.com/#Sofian-bll/sshk&Date)

</div>
