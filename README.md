# sshk

<div align="center">

**SSH Key Manager — create, organize, and grant access. No dependencies.**

</div>

## What is this?

`sshk` manages your SSH keys in a clean, predictable structure. One key per purpose, one command per action. Zero dependencies — pure Bash + OpenSSH.

## Quick Install

```bash
curl -fsSL https://raw.githubusercontent.com/Sofian-bll/sshk/main/install.sh | bash
```

Or manually:

```bash
mkdir -p ~/.local/bin
curl -fsSL https://raw.githubusercontent.com/Sofian-bll/sshk/main/sshk -o ~/.local/bin/sshk
chmod +x ~/.local/bin/sshk
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

### List all keys

```
$ sshk list

  🔑  Clés SSH

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
  ──────────────────────────────────────────────────
  Type       : ed25519
  Empreinte  : SHA256:s7N3Um...
  Comment    : sofian@vela
  Créée le   : 2026-06-01
  Chemin     : ~/.ssh/keys/vela/id_ed25519
  Config     : ~/.ssh/config.d/20-vela.conf
    HostName : 100.77.184.28
  ──────────────────────────────────────────────────

  ssh         : ssh vela
  copier      : sshk copy vela
```

### Grant access to a server

```
$ sshk grant void

  ℹ  Copie de la clé publique vers void (100.115.31.73)...
  ✅ Accès accordé → macbook autorisé sur void.
  ✅ Prêt. Testez avec ssh void.
```

## Structure

```
~/.ssh/
├── keys/                          # Your identities (who you are)
│   ├── github/
│   │   └── id_ed25519
│   ├── vela/
│   │   └── id_ed25519
│   └── void/
│       └── id_ed25519
├── config.d/                      # Outgoing connections (ssh <name>)
│   ├── 20-github.conf
│   ├── 20-vela.conf
│   └── 30-void.conf
└── authorized_keys.d/             # Incoming accesses (who can connect)
    ├── macbook
    └── vela
```

## Server Setup (for `grant`)

On each server, enable `authorized_keys.d/` once:

```bash
mkdir -p ~/.ssh/authorized_keys.d
chmod 700 ~/.ssh/authorized_keys.d
echo 'AuthorizedKeysFile .ssh/authorized_keys .ssh/authorized_keys.d/*' | sudo tee -a /etc/ssh/sshd_config
sudo systemctl restart sshd
```

## License

MIT
