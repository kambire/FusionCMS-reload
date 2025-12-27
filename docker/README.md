# FusionCMS Docker

This repo includes a ready-to-run Docker setup (PHP 8.3 + Apache + MySQL).

## Start

From the repo root:

- Build + run: `docker compose up -d --build`
- Site: http://localhost:8080/
- phpMyAdmin: http://localhost:8081/ (server: `db`, user: `root`, password: `root`)

## Databases

The container creates/imports:

- `fusioncms` (FusionCMS schema from `application/modules/install/SQL/fusion_final_full.sql`)
- `acore_auth` (auth schema from `acore_auth.sql`)

Note: MySQL init scripts only run on a fresh database volume.

## Reset DB (re-import SQL)

This deletes the MySQL volume and re-runs the imports:

- `docker compose down -v`
- `docker compose up -d --build`

## Stop

- `docker compose down`
