# ONBOARDING APP UNIR – PYTHON

## Arquitectura de Software

Utilizamos una **arquitectura por capas**, lo que permite que el código sea más modular, escalable y fácil de mantener. Las capas son las siguientes:

### 1. Capa de Presentación
- Implementada con **Flask**.
- Controla la entrada y salida de datos desde el Front-End o herramientas como Postman.
- Se encuentra en el archivo: `routes.py`.

### 2. Lógica de Negocio
- Contiene la lógica del sistema: reglas, validaciones, etc.
- Se encuentra en el archivo: `services.py`.

### 3. Capa de Acceso a Datos
- Encargada de la comunicación con la base de datos.
- Utilizamos **SQLAlchemy** para definir tablas, columnas y relaciones.
- Se encuentra en el archivo: `models.py`.

### 4. Base de Datos
- Motor de base de datos: **PostgreSQL**.

### 5. Otros componentes
- **Docker**: para encapsular la aplicación y la base de datos, formando el entorno de desarrollo.
- **pytest**: para ejecutar pruebas automatizadas.

---

## Cómo ejecutar los tests

- Los tests están ubicados en: `app/test_routes.py`.
- Para lanzarlos:

```bash
cd app
pytest test_routes.py
