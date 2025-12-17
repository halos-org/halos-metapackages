# HaLOS Metapackages

Debian metapackages for the HaLOS system.

## Packages

### `halos`
Base HaLOS system metapackage that installs:
- Cockpit web interface
- cockpit-networkmanager
- cockpit-storaged
- cockpit-apt package manager
- halos-cockpit-branding

### `halos-marine`
Marine system metapackage that extends `halos` with:
- marine-container-store
- signalk-server-container

## Installation

```bash
# Base HaLOS system
sudo apt install halos

# Marine system
sudo apt install halos-marine
```

## Building

```bash
# Build both packages
./run build-all

# Build individual packages
./run build-halos
./run build-halos-marine

# Check with lintian
./run lint
```

## Version Management

This repository uses the HaLOS unified versioning system:
- `VERSION` file contains the upstream version
- CI automatically calculates revision numbers
- Packages are published to apt.hatlabs.fi

See `cockpit-apt` repository for the detailed versioning workflow.

## Repository

Part of the [HaLOS](https://github.com/hatlabs/halos-distro) distribution.
