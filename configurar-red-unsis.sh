#!/bin/bash
echo "=== CONFIGURACIÓN PARA RED UNSIS ==="

# Crear docker-compose para red UNSIS
cat > docker-compose-unsis.yml << EOF
version: '3.8'

services:
  postgres-db:
    image: postgres:15
    container_name: contenedor-bd-unsis
    environment:
      POSTGRES_DB: tu_basedatos
      POSTGRES_USER: tu_usuario
      POSTGRES_PASSWORD: tu_contraseña_segura
    ports:
      - "$TU_IP_ACTUAL:5432:5432"
    volumes:
      - postgres_data:/var/lib/postgresql/data
      - ./postgres/init-scripts:/docker-entrypoint-initdb.d
    networks:
      - red-bd-unsis
    restart: unless-stopped

  adminer:
    image: adminer:4.8.1
    container_name: adminer-bd
    ports:
      - "$TU_IP_ACTUAL:8080:8080"
    networks:
      - red-bd-unsis
    depends_on:
      - postgres-db
    restart: unless-stopped

networks:
  red-bd-unsis:
    driver: bridge

volumes:
  postgres_data:
EOF

echo "Archivo docker-compose-unsis.yml creado"
echo "Para usar en UNSIS ejecutar: docker-compose -f docker-compose-unsis.yml up -d"