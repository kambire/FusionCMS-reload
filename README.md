# FusionCMS-reload

[![License: AGPL v3](https://img.shields.io/badge/License-AGPL%20v3-blue.svg)](LICENSE.md)

**FusionCMS-reload** es un fork orientado a modernizar y facilitar el desarrollo local de FusionCMS (CodeIgniter + Smarty), con foco en una puesta en marcha reproducible y en mejoras prácticas sobre tienda/permisos/cachés.

> Este repositorio **no es el proyecto original**. En la sección de Agradecimientos se referencia el repositorio base y a sus desarrolladores.

## Contenido

- [Visión](#visión)
- [Requisitos](#requisitos)
- [Instalación (clonar)](#instalación-clonar)
- [Ejecución (Docker)](#ejecución-docker)
- [Configuración sensible](#configuración-sensible)
- [Cambios realizados](#cambios-realizados)
- [Roadmap](#roadmap)
- [Troubleshooting](#troubleshooting)
- [Agradecimientos](#agradecimientos)

## Visión

- Reducir fricción para levantar FusionCMS en local (entorno reproducible).
- Proveer una base ordenada para iterar sobre UX de tienda y ajustes de plataforma.
- Mantener compatibilidad con el ecosistema del proyecto original, evitando exponer configuración sensible en Git.

## Requisitos

- Docker Desktop (Windows)
- Git
- (Opcional) Node.js: solo si necesitás trabajar con assets fuera del contenedor

## Instalación (clonar)

1) Clonar el repositorio:

```bash
git clone https://github.com/kambire/FusionCMS-reload.git
cd FusionCMS-reload
```

2) (Opcional) Revisar documentación del stack Docker:

- Ver [docker/README.md](docker/README.md)

## Ejecución (Docker)

Desde la raíz del repo:

```bash
docker compose up -d --build
```

Servicios:

- Sitio: http://localhost:8080/
- phpMyAdmin: http://localhost:8081/ (host: `db`, user: `root`, pass: `root`)

Notas operativas:

- Los scripts SQL de inicialización corren **solo** si el volumen de MySQL está vacío.
- Reset completo de DB (borra datos):

```bash
docker compose down -v
docker compose up -d --build
```

## Configuración sensible

Por seguridad, este repositorio ignora archivos de configuración que suelen contener credenciales o secretos:

- `application/config/database.php`
- `application/config/fusion.php`

Esto implica que:

- En un clon nuevo vas a tener que crearlos/configurarlos para tu entorno.
- Recomendación: basarte en los archivos de ejemplo del proyecto original o los `.dist` cuando existan.

## Cambios realizados

Resumen (enfoque dev/local):

- **Docker**: entorno listo con PHP 8.3 + Apache + MySQL + phpMyAdmin.
- **Routing/Rewrite**: ajustes para que el enrutamiento funcione correctamente en local mediante `.htaccess`.
- **Cachés**: ajustes para evitar errores comunes de permisos/paths (ej. cache de HTMLPurifier dentro de `writable/`).
- **Store (Tienda)**:
  - Layout tipo ecommerce: grilla (4 productos por fila) + categorías.
  - Ajustes de CSS/JS para presentación y comportamiento.
  - Seed de datos demo para pruebas visuales: `docker/mysql/seed_store_sample.sql`.
- **Teleport**: validación/filtrado para bloquear el uso de “brackets Ulduar” en destinos.

Para ver el detalle exacto, revisá el historial de commits en GitHub.

## Roadmap

Líneas de trabajo previstas (pueden cambiar):

- Documentación de instalación separada para local vs producción.
- Consolidación de permisos/ACL (incluyendo visibilidad de Admin y menú).
- Mejoras en datasets demo (tienda/roles) sin comprometer datos sensibles.
- Estandarización del flujo de assets/caché/minify para desarrollo.
- Revisión incremental de dependencias y compatibilidad.

## Troubleshooting

1) “No veo mis cambios”

- Si estás en Docker, confirmá que tu `docker-compose.yml` está montando los directorios de código (`application/`, `system/`, `index.php` y `.htaccess`).

2) “No se reinicializa la DB”

- MySQL solo ejecuta scripts de init con volumen vacío. Usá:

```bash
docker compose down -v
docker compose up -d --build
```

3) Errores de caché/permisos

- En local, confirmá que `writable/` exista y sea escribible para el contenedor/servidor.

## Agradecimientos

Este fork se apoya en el trabajo del equipo y la comunidad del proyecto **FusionCMS**.

- Repositorio original: https://github.com/FusionWowCMS/FusionCMS
- Gracias a los desarrolladores y contribuyentes originales por el CMS y el ecosistema.

### Autores & Contributors (proyecto original)

El proyecto original existe gracias a:

- [Jesper Lindström](https://github.com/jesperlindstrom) (FusionCMS)
- [Xavier Geernick](https://github.com/XavierGeerinck)
- [FusionGen](https://github.com/FusionGen/FusionGEN)

Lista completa de contributors:

- https://github.com/FusionWowCMS/FusionCMS/graphs/contributors

Si buscás la versión oficial/estable o querés contribuir al upstream, usá el repositorio original.
