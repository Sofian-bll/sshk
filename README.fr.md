<div align="center">

[![License: MIT](https://img.shields.io/github/license/Sofian-bll/sshk?style=flat)](https://github.com/Sofian-bll/sshk/blob/main/LICENSE)
[![Version](https://img.shields.io/github/v/release/Sofian-bll/sshk?style=flat)](https://github.com/Sofian-bll/sshk/releases)
[![Stars](https://img.shields.io/github/stars/Sofian-bll/sshk?style=flat)](https://github.com/Sofian-bll/sshk/stargazers)

<p align="center">
  <img src="docs/assets/logo.png" width="160" alt="sshk logo"/>
</p>

<a id="readme-top"></a>
<h1 align="center">sshk</h1>

<p align="center">Gestionnaire de clés SSH — créez, organisez, accordez et révoquez des clés SSH. Bash pur + OpenSSH.</p>

<p align="center">🇬🇧 <a href="README.md">English</a> · 🇫🇷 <a href="README.fr.md"><b>Français</b></a></p>

</div>

## Qu'est-ce que c'est ?

`sshk` met de l'ordre dans vos clés SSH avec une structure de répertoires prévisible — une identité par usage, une commande par action. Gérez les identités sortantes (les clés que vous utilisez pour vous connecter à d'autres machines) et les accès entrants (les clés qui peuvent se connecter à vous) avec le même outil. Zéro dépendance au-delà d'OpenSSH.

<img src="docs/screenshots/sshk-list.png" width="720" alt="sshk list"/>

## Démarrage rapide

```bash
curl -fsSL https://raw.githubusercontent.com/Sofian-bll/sshk/main/install.sh | bash
```

Assurez-vous que `~/.local/bin` est dans votre `PATH`, puis :

```bash
sshk create      # Assistant interactif pour créer une clé SSH
sshk list        # Lister toutes les identités et accès autorisés
sshk copy NAME   # Copier une clé publique dans le presse-papier
sshk grant NAME  # Envoyer une clé vers un serveur distant
```

## Utilisation

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

### Créer une clé

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

### Lister toutes les clés

```
$ sshk list

  NOM      TYPE      EMPREINTE              CRÉÉ
  ──────────────────────────────────────────────────
  github   ed25519   SHA256:nsUE...          03/03
  vela     ed25519   SHA256:s7N3...          01/06
  void     ed25519   SHA256:gszk...          01/06
```

### Afficher les détails d'une clé

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

### Accorder l'accès à un serveur

```
$ sshk grant void
ℹ  Copie de la clé publique vers void (100.115.31.73)...
✅ Accès accordé → macbook autorisé sur void.
```

## Comment ça marche

`sshk` organise les clés SSH dans trois répertoires sous `~/.ssh/` :

```
~/.ssh/
├── keys/                  # Vos identités (qui vous êtes)
│   ├── github/
│   │   └── id_ed25519
│   └── vela/
│       └── id_ed25519
├── config.d/              # Snippets de config SSH (ssh <nom>)
│   ├── github.conf
│   └── vela.conf
└── authorized_keys.d/     # Qui peut se connecter à vous
    └── macbook
```

Fini le bazar des `~/.ssh/id_rsa` à plat. Chaque identité est namespacée, avec un snippet de config et une entrée authorized_keys correspondants.

## Configuration

Au premier lancement, `sshk` crée `~/.config/sshk/config` avec les valeurs par défaut. Éditez-le pour personnaliser :

| Option | Défaut | Description |
|--------|--------|-------------|
| `SSHK_DEFAULT_TYPE` | `ed25519` | Type de clé par défaut (`ed25519` ou `rsa`) |
| `SSHK_DEFAULT_USER` | `$USER` | Utilisateur SSH par défaut pour les blocs HostName |
| `SSHK_KEYS_DIR` | `~/.ssh/keys` | Remplacer le répertoire des clés |
| `SSHK_AUTH_DIR` | `~/.ssh/authorized_keys.d` | Remplacer le répertoire des clés autorisées |
| `SSHK_CONFIG_DIR` | `~/.ssh/config.d` | Remplacer le répertoire des snippets de config |

## Configuration serveur (pour `grant`)

Sur chaque serveur, activez `authorized_keys.d/` une fois :

```bash
mkdir -p ~/.ssh/authorized_keys.d
chmod 700 ~/.ssh/authorized_keys.d
echo 'AuthorizedKeysFile .ssh/authorized_keys .ssh/authorized_keys.d/*' | sudo tee -a /etc/ssh/sshd_config
sudo systemctl restart sshd
```

## Structure du projet

```
sshk/
├── docs/            # Page d'atterrissage GitHub Pages et assets
├── install.sh      # Installateur one-line via curl
├── README.md       # Version anglaise
├── README.fr.md    # Ce fichier
├── LICENSE         # Licence MIT
└── sshk            # Script principal (~550 lignes, Bash)
```

## Documentation

| Ressource | Description |
|-----------|-------------|
| [`docs/index.html`](docs/index.html) | Page d'atterrissage GitHub Pages |
| `sshk` | Script principal — toutes les commandes, helpers de clés, presse-papier |
| `install.sh` | Installateur one-line pour `~/.local/bin` |

## Licence

[MIT](LICENSE)

---

<div align="center">

[![Star History Chart](https://api.star-history.com/svg?repos=Sofian-bll/sshk&type=Date)](https://star-history.com/#Sofian-bll/sshk&Date)

</div>
