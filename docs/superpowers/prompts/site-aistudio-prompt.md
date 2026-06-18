# sshk — Landing Page Prompt for AI Studio

Copy this into AI Studio (aistudio.google.com).

Settings:
- Model: Gemini 2.5 Pro
- Temperature: 0.3
- Upload `docs/assets/logo.png` as visual reference
- Output only the final HTML

---

Create a single-file HTML landing page for sshk.

Match the uploaded logo: a dark rounded-square icon with a green terminal-and-key hybrid mark. The site should feel like a precise command-line security tool, not a generic SaaS landing page.

──────────────────────────
RULES
──────────────────────────

Apple design language. Minimal, clean, calm, high precision.

Tailwind CSS CDN is the only allowed dependency:

```html
<script src="https://cdn.tailwindcss.com"></script>
```

Use Tailwind for layout, spacing, grid, responsive behavior, and gradients.
Custom CSS only for keyframes, reveal animations, terminal details, and focus states.
Minimal vanilla JS allowed, under 40 lines total, for copy buttons and scroll reveal.
Under 500 lines total.

Output only the HTML.
Start with `<!doctype html>`.
No Markdown explanation.
No external fonts.
No emoji.
No fake CI badges.
No Docker/API/deploy references.
No warm cream background.
No Inter.

──────────────────────────
PROJECT DATA
──────────────────────────

Name: sshk

Tagline: Structured SSH keys. One identity per directory. Zero dependencies beyond OpenSSH.

Repo: https://github.com/Sofian-bll/sshk

Release: v1.0.0

License: MIT

Tech: Pure Bash + OpenSSH

Description:
sshk brings order to SSH keys with a predictable directory structure: one identity per purpose, one command per action. It manages outgoing identities and incoming access with the same CLI. No dependencies beyond OpenSSH.

How it works:
`~/.ssh/keys/` — personal identities, one directory per key
`~/.ssh/config.d/` — SSH config snippets so `ssh <name>` works
`~/.ssh/authorized_keys.d/` — incoming access, one file per trusted machine

Quick start:

```bash
curl -fsSL https://raw.githubusercontent.com/Sofian-bll/sshk/main/install.sh | bash
sshk create
sshk list
sshk grant server
```

Main commands:
- `sshk create` — interactive identity creation
- `sshk list` — identities and incoming access at a glance
- `sshk show <name>` — fingerprint, path, config, hostname
- `sshk copy <name>` — public key to clipboard
- `sshk grant <name>` — authorize a remote server
- `sshk revoke <name>` — remove access remotely
- `sshk delete <name>` — remove an identity with confirmation

Palette:
- `--bg`: #090c10
- `--surface`: #0f1419
- `--elevated`: #151b23
- `--border`: #1e2a33
- `--text`: #d6d9de
- `--muted`: #697582
- `--accent`: #86e040
- `--accent-dim`: #4a7a24
- `--blue`: #7dabf8
- `--yellow`: #e5b550

Typography:
- System font stack for body and headlines.
- Code and terminal: SF Mono, Menlo, Monaco, Consolas, monospace.
- Headlines should be tight, confident, and restrained.

──────────────────────────
LOCAL ASSETS AND PLACEHOLDERS
──────────────────────────

Use these asset paths exactly in the final HTML:

Logo:
- `assets/logo.png`

Screenshots:
- `screenshots/sshk-list.png` — main hero screenshot. Shows only the output of `sshk list`, no command line.
- `screenshots/sshk-show.png` — secondary screenshot. Shows only the output of `sshk show vela`, no command line.
- `screenshots/sshk-help.png` — optional command reference screenshot. Shows only the output of `sshk help`, no command line.

Screenshot rules:
- Treat screenshots as rectangular 16:9 terminal-output images.
- Do not crop important terminal text.
- Do not stretch images.
- Use `object-fit: contain`.
- Place screenshots inside dark elevated cards with subtle border and shadow.
- On mobile, screenshots must remain readable on Redmi-sized screens.
- On mobile, stack text above screenshots.
- On desktop, hero can be centered or two-column, but the screenshot must remain the page's main visual proof.

Required HTML comments above each image:

```html
<!-- LOGO: docs/assets/logo.png -->
```

```html
<!-- SCREENSHOT: docs/screenshots/sshk-list.png -->
```

```html
<!-- SCREENSHOT: docs/screenshots/sshk-show.png -->
```

```html
<!-- SCREENSHOT: docs/screenshots/sshk-help.png optional -->
```

──────────────────────────
VISUAL DIRECTION
──────────────────────────

Dark, precise, terminal-native.
Use the green accent as a command cursor/light, not everywhere.
Make the signature element a small “key as terminal prompt” motif: vertical cursor/key shapes can appear as section markers.
Keep spacing generous and Apple-like.
Cards should feel like quiet black hardware panels.

The hero is the thesis: sshk turns messy SSH key sprawl into a readable, namespaced terminal workflow. Make the terminal screenshot feel like proof, not decoration.

Avoid generic SaaS visuals:
- No big abstract gradient blobs as the main idea.
- No random dashboard cards.
- No fake metrics.
- No “deploy” pills.
- No vague productivity copy.

──────────────────────────
PAGE STRUCTURE
──────────────────────────

1. NAV

Content:
- Logo image from `assets/logo.png`
- Project name: sshk
- GitHub pill linking to `https://github.com/Sofian-bll/sshk`
- Version pill: v1.0.0 linking to `https://github.com/Sofian-bll/sshk/releases/tag/v1.0.0`
- MIT pill linking to `https://github.com/Sofian-bll/sshk/blob/main/LICENSE`

Layout:
- Max width container.
- Logo and name on left.
- Pills on right.
- On mobile, keep compact and wrap cleanly.

2. HERO

Content:
- Eyebrow badge: SSH Key Manager with small pulsing green dot.
- Headline: “Structured SSH keys, without the ~/.ssh mess.”
- Subheadline: “Create, organize, grant, and revoke SSH keys with one predictable Bash CLI.”
- Primary CTA: View repository
- Secondary CTA: Install with curl
- Main visual: `screenshots/sshk-list.png`

Hero screenshot requirements:
- Use this exact path: `screenshots/sshk-list.png`
- Add comment above image: `<!-- SCREENSHOT: docs/screenshots/sshk-list.png -->`
- Wide terminal card, 16:9 presentation.
- Image must use `object-fit: contain`.
- It should read as output-only terminal proof.
- Do not overlay fake text on top of the screenshot.

3. PROBLEM / STRUCTURE

Explain the flat-key problem in short, concrete copy:
“id_rsa, id_ed25519, old server keys, GitHub keys, no ownership trail.”

Then show sshk's structure as a tree:

```text
~/.ssh/
├── keys/                  # identities
│   ├── github/
│   │   └── id_ed25519
│   └── vela/
│       └── id_ed25519
├── config.d/              # ssh config snippets
│   ├── github.conf
│   └── vela.conf
└── authorized_keys.d/     # incoming access
    └── macbook
```

Design:
- Use a calm two-column section on desktop.
- Left: short problem text.
- Right: terminal-style tree panel.
- Stack on mobile.

4. COMMANDS

Responsive feature cards:
- `sshk create` — Interactive identity creation.
- `sshk list` — Identities and incoming access at a glance.
- `sshk show <name>` — Fingerprint, path, config, hostname.
- `sshk copy <name>` — Public key to clipboard.
- `sshk grant <name>` — Authorize a remote server.
- `sshk revoke <name>` — Remove access remotely.
- `sshk delete <name>` — Remove an identity with confirmation.

Layout:
- Mobile: 1 column.
- Tablet: 2 columns.
- Desktop: 3 columns if it remains readable.
- Since there are 7 cards, do not leave the final card awkwardly orphaned. Center it or make it span appropriately.

5. INSPECT AN IDENTITY

Use screenshot `screenshots/sshk-show.png`.

Content:
- Short heading: “Know exactly what each identity does.”
- Copy: “sshk show gives you the fingerprint, comment, creation date, key path, config path, and hostname in one place.”
- Image from `screenshots/sshk-show.png`.
- Add comment above image: `<!-- SCREENSHOT: docs/screenshots/sshk-show.png -->`

Design:
- This section should break the card grid and give the screenshot room.
- Keep screenshot rectangular, readable, and not cropped.

6. QUICK START

Two Apple-style terminal panels, not screenshots:

Left panel: install commands

```bash
curl -fsSL https://raw.githubusercontent.com/Sofian-bll/sshk/main/install.sh | bash
sshk create
sshk list
```

Right panel: server setup for grant/revoke

```bash
mkdir -p ~/.ssh/authorized_keys.d
chmod 700 ~/.ssh/authorized_keys.d
echo 'AuthorizedKeysFile .ssh/authorized_keys .ssh/authorized_keys.d/*' | sudo tee -a /etc/ssh/sshd_config
sudo systemctl restart sshd
```

Terminal panel requirements:
- Dark background #090c10 or #0f1419.
- 14px-20px radius.
- Subtle border #1e2a33.
- macOS traffic lights in header.
- Copy button hidden until hover/focus.
- Copy button copies the `<pre>` content.
- “Copied” feedback for 1.5s.

7. OPTIONAL COMMAND REFERENCE

Use `screenshots/sshk-help.png` only if the layout benefits from one more visual.

If used:
- Put it near the Commands section or before the footer.
- Add comment above image: `<!-- SCREENSHOT: docs/screenshots/sshk-help.png optional -->`
- Keep it smaller than the hero screenshot.

If the page already feels complete, omit this screenshot.

8. FOOTER

Content:
- “sshk is open source under the MIT license.”
- GitHub link.
- “Pure Bash + OpenSSH.”

Layout:
- Space-between on desktop.
- Stacked on mobile.

──────────────────────────
RESPONSIVE CONSTRAINTS
──────────────────────────

- Mobile <640px: single column, readable terminal images, no horizontal scroll.
- Tablet 640-1024px: two-column grids where appropriate.
- Desktop 1024-1440px: max width around 1120px or 1280px.
- Wide >=1440px: max-w-7xl mx-auto.
- Body: min-h-dvh flex flex-col.
- Main: flex-1.
- Global horizontal padding: px-5 on mobile, px-6/px-8 above.
- Cards: 20px-24px radius.
- Buttons: rounded-full.
- Images: max-width: 100%, height: auto.
- Screenshot wrappers: aspect-video, object-contain.

──────────────────────────
MICRO-INTERACTIONS
──────────────────────────

Implement under 40 lines of vanilla JS total:

1. Copy buttons:
- Find buttons with `data-copy-target`.
- Copy target `<pre>` text through `navigator.clipboard.writeText`.
- Change label to “Copied” for 1.5s.

2. Scroll reveal:
- `.reveal` elements fade up with IntersectionObserver.
- threshold: 0.1.
- duration: 0.6s ease-out.
- Small stagger is allowed.

CSS:
- Respect `prefers-reduced-motion: reduce`.
- focus-visible outline: 2px solid #86e040, offset 4px.
- Hover: cards border shifts to #4a7a24.
- Buttons scale to 1.02 on hover.

──────────────────────────
SEO / HEAD
──────────────────────────

Include:
- `<title>sshk — SSH Key Manager</title>`
- meta description: “A pure Bash SSH key manager for creating, organizing, granting, and revoking SSH keys.”
- theme-color: #090c10
- Open Graph title and description
- Open Graph image: `assets/logo.png`
- Twitter card: summary
- favicon: `assets/logo.png`

──────────────────────────
FINAL OUTPUT
──────────────────────────

Output only the HTML.
Start with `<!doctype html>`.
Do not include explanations before or after.
