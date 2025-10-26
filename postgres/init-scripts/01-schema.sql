-- ============================================
-- TABLAS PRINCIPALES
-- ============================================

CREATE TABLE CARRERAS (
    id VARCHAR(50) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    activo BOOLEAN DEFAULT TRUE
);


CREATE TABLE MATERIAS (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    clave VARCHAR(20) UNIQUE,
    carrera_id VARCHAR(100),
    FOREIGN KEY (carrera_id) REFERENCES CARRERAS(id)
);

CREATE TABLE PROFESORES (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    carrera_id VARCHAR(100),
    activo BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (carrera_id) REFERENCES CARRERAS(id)
);

CREATE TABLE ESTUDIANTES (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    matricula VARCHAR(20) NOT NULL UNIQUE,
    nombre VARCHAR(100) NOT NULL,
    carrera_id VARCHAR(100),
    FOREIGN KEY (carrera_id) REFERENCES CARRERAS(id)
);

CREATE TABLE AULAS (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    capacidad INT NOT NULL,
    tipo VARCHAR(30) NOT NULL,
    activa BOOLEAN DEFAULT TRUE
);

CREATE TABLE GRUPOS (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre_grupo VARCHAR(50) NOT NULL,
    capacidad INT NOT NULL,
    materia_id INT,
    profesor_titular_id INT,
    FOREIGN KEY (materia_id) REFERENCES MATERIAS(id),
    FOREIGN KEY (profesor_titular_id) REFERENCES PROFESORES(id)
);

-- ============================================
-- TABLAS DE CONFIGURACIÓN
-- ============================================

CREATE TABLE BLOQUES_HORARIOS (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    hora_inicio TIME NOT NULL,
    hora_fin TIME NOT NULL,
    nombre VARCHAR(30) NOT NULL
);

CREATE TABLE DIAS_SEMANA (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR(15) NOT NULL UNIQUE
);

CREATE TABLE PERIODOS_EVALUACION (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL,
    tipo VARCHAR(30) NOT NULL
);

CREATE TABLE TIPOS_EVALUACION (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    clave VARCHAR(10) NOT NULL UNIQUE,
    necesita_sinodales BOOLEAN DEFAULT FALSE,
    es_recursamiento BOOLEAN DEFAULT FALSE
);

-- ============================================
-- TABLAS DE RELACIÓN
-- ============================================

CREATE TABLE HORARIOS_CLASE (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    grupo_id INT,
    bloque_horario_id INT,
    dia_semana_id INT,
    aula_id INT,
    FOREIGN KEY (grupo_id) REFERENCES GRUPOS(id),
    FOREIGN KEY (bloque_horario_id) REFERENCES BLOQUES_HORARIOS(id),
    FOREIGN KEY (dia_semana_id) REFERENCES DIAS_SEMANA(id),
    FOREIGN KEY (aula_id) REFERENCES AULAS(id)
);

CREATE TABLE EXAMENES (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    grupo_id INT,
    tipo_evaluacion_id INT,
    periodo_evaluacion_id INT,
    fecha DATE NOT NULL,
    bloque_horario_id INT,
    aula_id INT,
    profesor_aplicador_id INT,
    estado VARCHAR(20) DEFAULT 'Programado',
    FOREIGN KEY (grupo_id) REFERENCES GRUPOS(id),
    FOREIGN KEY (tipo_evaluacion_id) REFERENCES TIPOS_EVALUACION(id),
    FOREIGN KEY (periodo_evaluacion_id) REFERENCES PERIODOS_EVALUACION(id),
    FOREIGN KEY (bloque_horario_id) REFERENCES BLOQUES_HORARIOS(id),
    FOREIGN KEY (aula_id) REFERENCES AULAS(id),
    FOREIGN KEY (profesor_aplicador_id) REFERENCES PROFESORES(id)
);

CREATE TABLE EXAMENES_SINODALES (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    examen_id INT,
    profesor_id INT,
    tipo_rol VARCHAR(30) NOT NULL,
    FOREIGN KEY (examen_id) REFERENCES EXAMENES(id),
    FOREIGN KEY (profesor_id) REFERENCES PROFESORES(id)
);

CREATE TABLE EXAMENES_ALUMNOS (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    examen_id INT,
    estudiante_id INT,
    tipo_inscripcion VARCHAR(30) NOT NULL,
    materia_id INT,
    FOREIGN KEY (examen_id) REFERENCES EXAMENES(id),
    FOREIGN KEY (estudiante_id) REFERENCES ESTUDIANTES(id),
    FOREIGN KEY (materia_id) REFERENCES MATERIAS(id)
);

