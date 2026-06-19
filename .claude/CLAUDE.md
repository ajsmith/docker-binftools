# docker-binftools

A Docker image bundling bioinformatics and general dev tools, built on Fedora. Used as a
personal/general-purpose toolbox (not tied to a specific course or research pipeline).

**Single user, single arch.** This image only ever runs on the owner's Apple Silicon Mac
(M4 Pro, `arm64`), so everything targets `linux/arm64` only. No amd64/multi-arch builds.
Revisit if it ever needs to run on Intel/amd64 hardware.

## Layout

- `Dockerfile` — image definition. Pins the Fedora base, runs `fedora/setup.sh`, creates user
  `me` (uid 1001), and drops in a default `.emacs`.
- `fedora/setup.sh` — installs everything in `packages.txt` via `dnf`, then `mandb -c` so man
  pages work. Uses `--setopt=tsflags=''` to keep docs (don't remove that).
- `fedora/packages.txt` — the list of packages to install.
- `fedora/user-files/.emacs` — default Emacs config copied into the user's home.
- `.github/workflows/docker-image.yml` — CI that builds and publishes the image.
- `build.sh` + `build.conf` — local build wrapper (see Known issues).

## Conventions

### Fedora version
- **Pinned, bumped manually.** The base is an explicit version (e.g. `fedora:44`). Only upgrade
  when explicitly asked — don't track latest on your own.
- Always target the latest **stable** Fedora, never Rawhide/pre-release. Verify a version is GA
  before suggesting it (e.g. a Docker Hub tag can exist for a release that isn't out yet).

### packages.txt
- One package per line, kept in **case-insensitive alphabetical order**. Insert new entries in
  the right spot; don't append to the end or regroup.

### Git / PR workflow
- **Work on a feature branch off `main`** — don't commit directly to `main`.
- Open PRs **only when asked**. Branch and commit freely, but leave PR creation to the user.
- Merged PRs land via GitHub; history uses squash commits titled like `Refresh (#3)`.

### Verification
- **Rely on CI.** After pushing, GitHub Actions builds the image and surfaces package/build
  failures. A local build before pushing isn't required (fast iteration is fine).

## CI / publishing

`.github/workflows/docker-image.yml` runs on push/PR to `main`:
- Builds `linux/arm64` only, on a standard `ubuntu-latest` runner via QEMU emulation. This is
  slower than a native arm64 runner but works on any plan / public or private repo, which was
  the explicit preference (robustness over speed).
- Pushes to Docker Hub: `ajsmith/binftools:latest` on `main`, `ajsmith/binftools:ci-<branch>`
  on PRs.
- Needs repo secrets `DOCKER_HUB_USERNAME` / `DOCKER_HUB_TOKEN`.

CI and `build.sh` are both considered relevant: CI owns publishing, `build.sh` is the local
build path. `build.sh` reads `build.conf` (`platform=linux/arm64`) and runs a plain
`docker build`, which works because arm64 is native on the owner's Mac (single-arch builds
load straight into the local image store).

## Known issues

- Stray editor backup files exist in the repo root (`Dockerfile~`, `build.sh~`, `build.conf~`).
