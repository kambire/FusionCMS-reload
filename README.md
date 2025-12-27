# FusionCMS-reload

Fork/reload de **FusionCMS** (basado en CodeIgniter + Smarty) orientado a desarrollo local rápido y a iterar sobre la tienda, permisos y ajustes de performance.

> Este repositorio **no es el proyecto original**. Abajo dejo los agradecimientos y enlaces al repositorio base y a sus desarrolladores.

## Objetivo

- Tener un entorno reproducible (Docker) para levantar FusionCMS en minutos.
- Mejorar/ajustar UX de la tienda (layout tipo ecommerce) y facilitar pruebas.
- Ajustar permisos/rutas y corregir problemas comunes de cachés en local.

## Requisitos

- Docker Desktop (Windows)
- Git
- (Opcional) Node.js si querés compilar assets fuera del contenedor

## Levantar el proyecto (Docker)

Desde la raíz del repo:

- `docker compose up -d --build`

URLs:

- Sitio: http://localhost:8080/
- phpMyAdmin: http://localhost:8081/ (host: `db`, user: `root`, pass: `root`)

Notas:

- Las importaciones SQL del contenedor se ejecutan **solo la primera vez** (cuando el volumen de MySQL está vacío).
- Para reiniciar DB desde cero: `docker compose down -v` y luego `docker compose up -d --build`.

Más detalles en [docker/README.md](docker/README.md).

## Configuración (importante)

Por seguridad, este repo ignora archivos sensibles (no deberían subirse a Git):

- `application/config/database.php`
- `application/config/fusion.php`

Si estás clonando por primera vez, vas a tener que crearlos/configurarlos (o copiarlos desde los `.dist`/ejemplos del proyecto base) según tu entorno.

## Cambios realizados en este fork

Alto nivel (enfocado en dev/local):

- **Docker**: stack de desarrollo con PHP 8.3 + Apache + MySQL + phpMyAdmin.
- **Rutas / Rewrite**: ajustes para que el routing funcione bien en local con Apache + `.htaccess`.
- **Cachés**: limpieza/ajustes para evitar errores típicos de permisos/paths (por ejemplo, cache de HTMLPurifier en `writable/`).
- **Tienda**:
	- Layout tipo ecommerce con grilla (4 items por fila) y categorías.
	- Ajustes de JS/CSS para mejorar presentación en el storefront.
	- Seed de ejemplo para poblar categorías/items de prueba: `docker/mysql/seed_store_sample.sql`.
- **Teleport**: validación/filtrado para bloquear el uso de “brackets Ulduar” en destinos.

> Si querés una lista exacta por commit, revisá el historial de Git en GitHub.

## Proyectos a futuro (roadmap)

Ideas/puntos pendientes (no necesariamente implementados todavía):

- Dejar un flujo de instalación más claro (local vs producción).
- Consolidar y documentar permisos/ACL y visibilidad del menú de Admin.
- Mejorar seeders/datos demo (tienda, usuarios, roles) sin tocar datos sensibles.
- Estandarizar build de assets (cuando aplique) y documentar minify/cache.
- Revisar compatibilidad/actualización incremental de dependencias.

## Agradecimientos

Este proyecto existe gracias al trabajo del equipo y contribuyentes del **FusionCMS** original.

- Repositorio original: https://github.com/FusionWowCMS/FusionCMS
- Gracias a los desarrolladores y a la comunidad que mantiene el CMS y sus dependencias.

Si estás buscando la versión oficial/estable o querés contribuir al upstream, por favor usá el repositorio original.
