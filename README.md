# Ayisigimakademi

Source code and development environment for the Ayisigimakademi educational platform.

## Platform Components

| Component | URL | Technology | Status |
|---------|-----|-----------|-------|
| **Portal** (LMS) | https://portal.ayisigimakademi.com | Moodle 5 | Under Development |

## Quick Start

```bash
# 1. Clone the repository (including the Moodle submodule)
git clone --recurse-submodules git@ayisigimakademi:fkayisigimakademi/portal.ayisigimakademi.com.git
cd ayisigimakademi

# 2. Set up environment variables
cp .env.example .env
# Open the .env file and update the passwords

# 3. Run the local setup script
./scripts/setup-local.sh

# 4. Open in your browser
# http://portal.localhost  → Moodle installation wizard
# http://localhost:8080    → phpMyAdmin
```

For detailed installation instructions: [docs/moodle-kurulum-rehberi.md](docs/moodle-kurulum-rehberi.md)

## Project Structure

```
ayisigimakademi/
├── docker/                    # Docker environment (Compose, Nginx, PHP)
│   ├── docker-compose.yml
│   ├── Dockerfile.php
│   ├── nginx/moodle.conf
│   └── php/php.ini
├── moodle/                    # Moodle core (git submodule - do not modify)
├── moodle-custom/             # All custom modifications go here
│   ├── themes/
│   │   └── boost_magnific/   # Ayisigimakademi custom theme
│   └── plugins/
│       └── mod_googlemeet/   # Live class plugin
├── db/
│   ├── migrations/           # Sequential SQL migrations (tracked in git)
│   └── apply_migrations.sh   # Script to apply migrations
├── config/
│   └── config.php.example    # Moodle config template (no passwords included)
├── scripts/
│   ├── setup-local.sh        # Initial setup script
│   ├── moodle-update.sh      # Moodle update script
│   ├── db-export.sh          # DB export script
│   └── local-to-hostinger.sh # Deployment script for Hostinger
└── docs/
    └── moodle-kurulum-rehberi.md
```

## Basic Rules

1. **Never modify the `moodle/` directory.** All customizations must be placed inside `moodle-custom/`.
2. For every DB change, create a `db/migrations/NNN_description.sql` file.
3. The `config.php` and `.env` files must never be committed to git.
4. Use `./scripts/moodle-update.sh` to update Moodle.

## Common Commands

```bash
# Start Docker services
docker compose -f docker/docker-compose.yml up -d

# Stop Docker services
docker compose -f docker/docker-compose.yml down

# Watch PHP logs
docker compose -f docker/docker-compose.yml logs -f php

# Run Moodle cron
docker compose -f docker/docker-compose.yml exec php \
    php /var/www/html/admin/cli/cron.php

# Purge caches
docker compose -f docker/docker-compose.yml exec php \
    php /var/www/html/admin/cli/purge_caches.php

# Apply migrations
./db/apply_migrations.sh

# Export DB dump
./scripts/db-export.sh --full

# Deploy to Hostinger
./scripts/local-to-hostinger.sh --dry-run
```

## Hosting

- **Server:** Hostinger Shared Hosting
- **Local Development:** Docker (Linux)
- **Moodle Version:** 5.x
- **PHP:** 8.2
- **DB:** MySQL 8.0

## License

This repository contains the proprietary development environment and Moodle integrations for Ayışığım Akademi. While Moodle's core files are subject to their own GPL v3 license, all customizations within this repository are fully protected under the "All Rights Reserved" license and cannot be used without permission.
