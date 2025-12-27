-- Creates the auth database and imports the provided dump
CREATE DATABASE IF NOT EXISTS `acore_auth` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `acore_auth`;
SOURCE /docker-entrypoint-initdb.d/acore_auth.sql;
