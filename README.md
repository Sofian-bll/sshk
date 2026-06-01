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
sshk create              Create a new key pair (interactive wizard)
sshk list                List all keys and authorized accesses
sshk list --keys          List only your identities
sshk list --auth          List only incoming accesses
sshk show <name>          Show key details
sshk copy <name>          Copy public key to clipboard
sshk delete <name>        Delete a key
sshk grant <name>         Authorize this machine on a remote server
sshk revoke <name>        Revoke remote access
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
    ├── nova
    └── vela
```

## Server Setup (for `grant`)

On each server, enable `authorized_keys.d/`:

```bash
mkdir -p ~/.ssh/authorized_keys.d
chmod 700 ~/.ssh/authorized_keys.d
echo 'AuthorizedKeysFile .ssh/authorized_keys .ssh/authorized_keys.d/*' | sudo tee -a /etc/ssh/sshd_config
sudo systemctl restart sshd
```

## License

MIT
