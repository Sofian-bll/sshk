<div align="center">

[![License: MIT](https://img.shields.io/github/license/Sofian-bll/sshk?style=flat)](https://github.com/Sofian-bll/sshk/blob/main/LICENSE)
[![Version](https://img.shields.io/github/v/release/Sofian-bll/sshk?style=flat)](https://github.com/Sofian-bll/sshk/releases)
[![Stars](https://img.shields.io/github/stars/Sofian-bll/sshk?style=flat)](https://github.com/Sofian-bll/sshk/stargazers)

<p align="center">
  <img src="docs/assets/logo.png" width="160" alt="logo sshk"/>
</p>

<h1 id="readme-top" align="center">sshk</h1>

<p align="center">Gestionnaire de clés SSH — créez, organisez, autorisez et révoquez des clés SSH. Bash pur + OpenSSH.</p>

<p align="center">🇬🇧 <a href="README.md">English</a> · 🇫🇷 <a href="README.fr.md"><b>Français</b></a></p>

</div>

---

<p align="center">
  <a href="https://sofian-bll.github.io/sshk/"><strong>Explorer la doc</strong></a>
  ·
  <a href="https://github.com/Sofian-bll/sshk/issues/new?labels=bug">Signaler un bug</a>
  ·
  <a href="https://github.com/Sofian-bll/sshk/issues/new?labels=enhancement">Proposer une fonctionnalité</a>
</p>

<details open>
  <summary>Table des matières</summary>
  <ol>
    <li><a href="#fonctionnalités">Fonctionnalités</a></li>
    <li><a href="#technologies">Technologies</a></li>
    <li><a href="#démarrage-rapide">Démarrage rapide</a></li>
    <li><a href="#utilisation">Utilisation</a></li>
    <li><a href="#comment-ça-marche">Comment ça marche</a></li>
    <li><a href="#configuration">Configuration</a></li>
    <li><a href="#configuration-serveur">Configuration serveur</a></li>
    <li><a href="#structure-du-projet">Structure du projet</a></li>
    <li><a href="#contribuer">Contribuer</a></li>
    <li><a href="#licence">Licence</a></li>
  </ol>
</details>

## Fonctionnalités

<p align="right">(<a href="#readme-top">haut de page</a>)</p>

- **Une identité par usage** — chaque clé SSH vit dans son propre namespace sous `~/.ssh/keys/`
- **Gestion des identités sortantes** — `create`, `list`, `show`, `copy`, `delete` avec une commande par action
- **Gestion des accès entrants** — `grant` et `revoke` pour contrôler qui peut se connecter à vos machines
- **Zéro dépendance** — Bash pur, nécessite uniquement OpenSSH (standard sur macOS et Linux)
- **Tous les types de clés** — ed25519 (recommandé), RSA 4096, et tout type supporté par OpenSSH

## Technologies

<p align="right">(<a href="#readme-top">haut de page</a>)</p>

- [![Bash](https://img.shields.io/badge/bash-%23121011.svg?style=flat&logo=gnu-bash&logoColor=white)](#) — langage de script
- [OpenSSH](https://www.openssh.com/) — génération de clés, empreintes et transport
- [Git](https://git-scm.com/) — gestion de version

## Démarrage rapide

<p align="right">(<a href="#readme-top">haut de page</a>)</p>

```bash
curl -fsSL https://raw.githubusercontent.com/Sofian-bll/sshk/main/install.sh | bash
```

Assurez-vous que `~/.local/bin` est dans votre `PATH`, puis :

```bash
sshk create       # Assistant interactif pour créer une nouvelle clé SSH
sshk list         # Lister toutes les identités et accès autorisés
sshk copy github  # Copier une clé publique dans le presse-papier
sshk grant vela   # Envoyer une clé vers un serveur distant
```

## Utilisation

<p align="right">(<a href="#readme-top">haut de page</a>)</p>

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

  › Nom      : github
  › Type     [1=ed25519, 2=rsa4096] [1] :
  › Comment  [git@github] :
  › HostName (laisser vide si sshk ne contacte pas cette machine) :

  Nom         : github
  Type        : ed25519
  Fichier     : ~/.ssh/keys/github/id_ed25519

  Créer ? [Y/n]

  ✅ Clé créée.
  ✅ Fichier créé : ~/.ssh/config.d/github.conf
```

### Lister les clés

```
$ sshk list

  NOM          TYPE     EMPREINTE            CRÉÉ
  ──────────────────────────────────────────────────
  github       ed25519  SHA256:nsUE...        03/03
  vela         ed25519  SHA256:s7N3...        01/06
  void         ed25519  SHA256:gszk...        01/06
```

### Afficher les détails

```
$ sshk show vela

  🔑  vela
  Type        : ed25519
  Empreinte   : SHA256:s7N3Um...
  Commentaire : sofian@vela
  Créée le    : 2026-06-01
  Chemin      : ~/.ssh/keys/vela/id_ed25519
  Config      : ~/.ssh/config.d/vela.conf
    HostName  : 100.77.184.28

  ssh         : ssh vela
  copier      : sshk copy vela
  supprimer   : sshk delete vela
```

### Autoriser l'accès à un serveur

```
$ sshk grant void

  ℹ  Copie de la clé publique vers void (100.115.31.73)...
  ✅ Accès accordé → macbook autorisé sur void.
```

## Comment ça marche

<p align="right">(<a href="#readme-top">haut de page</a>)</p>

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

Fini le bazar des fichiers `~/.ssh/id_rsa` à plat. Chaque identité est namespace, avec un snippet de config et une entrée authorized_keys correspondante.

## Configuration

<p align="right">(<a href="#readme-top">haut de page</a>)</p>

Au premier lancement, `sshk` crée `~/.config/sshk/config` avec les valeurs par défaut. Éditez-le pour personnaliser :

| Option | Défaut | Description |
|--------|--------|-------------|
| `SSHK_DEFAULT_TYPE` | `ed25519` | Type de clé par défaut (`ed25519` ou `rsa`) |
| `SSHK_DEFAULT_USER` | `$USER` | Utilisateur SSH par défaut pour les blocs HostName |
| `SSHK_KEYS_DIR` | `~/.ssh/keys` | Remplacer le répertoire des clés |
| `SSHK_AUTH_DIR` | `~/.ssh/authorized_keys.d` | Remplacer le répertoire des clés autorisées |
| `SSHK_CONFIG_DIR` | `~/.ssh/config.d` | Remplacer le répertoire des snippets de config SSH |

## Configuration serveur

<p align="right">(<a href="#readme-top">haut de page</a>)</p>

Sur chaque serveur, activez `authorized_keys.d/` une fois pour que `grant` fonctionne :

```bash
mkdir -p ~/.ssh/authorized_keys.d
chmod 700 ~/.ssh/authorized_keys.d
echo 'AuthorizedKeysFile .ssh/authorized_keys .ssh/authorized_keys.d/*' | sudo tee -a /etc/ssh/sshd_config
sudo systemctl restart sshd
```

## Structure du projet

<p align="right">(<a href="#readme-top">haut de page</a>)</p>

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

## Contribuer

<p align="right">(<a href="#readme-top">haut de page</a>)</p>

Les contributions sont les bienvenues. Voici comment faire :

1. Forkez le dépôt
2. Créez une branche (`git checkout -b feat/fonctionnalite-geniale`)
3. Committez vos changements (`git commit -m 'feat: ajout fonctionnalité géniale'`)
4. Poussez la branche (`git push origin feat/fonctionnalite-geniale`)
5. Ouvrez une Pull Request

<a href="https://github.com/Sofian-bll/sshk/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=Sofian-bll/sshk" alt="Contributeurs"/>
</a>

## Licence

<p align="right">(<a href="#readme-top">haut de page</a>)</p>

Distribué sous licence MIT. Voir [LICENSE](LICENSE) pour plus d'informations.

---

<div align="center">

[![Star History Chart](https://api.star-history.com/svg?repos=Sofian-bll/sshk&type=Date)](https://star-history.com/#Sofian-bll/sshk&Date)

</div>

<!-- REFERENCE_LINKS -->
[stars-shield]: https://img.shields.io/github/stars/Sofian-bll/sshk?style=flat
[license-shield]: https://img.shields.io/github/license/Sofian-bll/sshk?style=flat
[version-shield]: https://img.shields.io/github/v/release/Sofian-bll/sshk?style=flat
