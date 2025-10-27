
## Estructura del Proyecto
```markdown
sage-bd-docker/
├── docker-compose.yml
├── postgres/
│ └── init-scripts/
│ ├── 01-schema.sql
│ └── 02-query-test.sql
└── documentation/
└── README.md
```
## Configuración LOCAL (Actual)
- **Base de Datos**: PostgreSQL 15
- **Puerto BD**: 5432 (localhost)
- **Puerto Adminer**: 8080 (localhost)
- **Red**: red-bd-unsis (bridge)
- **Volumen**: postgres_data (persistente)

## Comandos Útiles - Local

### Iniciar servicios:
```bash
docker-compose up -d

> [!IMPORTANT]
> Crea un archivo .env que contenga las siguientes variables con tus credenciales
> POSTGRES_DB: nombre_de_tu_bd
> POSTGRES_USER: nombre_de_usuario_postgreSQL
> POSTGRES_PASSWORD: contraseña_de_postgreSQL