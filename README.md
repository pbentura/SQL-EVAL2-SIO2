![separe](https://github.com/studoo-app/.github/blob/main/profile/studoo-banner-logo.png)
# EVAL 2 - Les triggers SQL
[![Version](https://img.shields.io/badge/Version-1.0.0-blue)]()

## Objectif
Projet contenant une base de données MariaDb et un PHPMyAdmin ayant pour finalité
de s'initier et s'entrainer à la création de triggers SQL.

Ce projet présente la base de données d'une application de gestion de tickets d'incidents.

Un utilisateur anonyme déclare un incident, ce dernier sera ensuite affilié à un utilisateur (Technicien support)
enregistré afin qu'il le traite.

### Schéma de la BDD de l'application

![Schéma de la base](./docs/schema.png)
## Installation

Un fichier `docker-compose.yaml` est fourni, ainsi il suffit de démarrer les services.
Ce dernier importe automatoquement la base de données
- `docker compose up -d`

Vous pouvez ensuite accéder à PHPMyAdmin, à l'adresse suivante :
- [http://localhost:8081](https://localhost:8081)

## Missions
