-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1:3307
-- Tiempo de generación: 22-04-2025 a las 07:35:21
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `miiga`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `aplicacion`
--

CREATE TABLE `aplicacion` (
  `id` int(11) NOT NULL,
  `tipo` enum('Nacional','Departamental','Municipal') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `aplicacion`
--

INSERT INTO `aplicacion` (`id`, `tipo`) VALUES
(1, 'Nacional'),
(2, 'Departamental'),
(3, 'Municipal');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `documentos`
--

CREATE TABLE `documentos` (
  `codigo` varchar(20) NOT NULL,
  `tipo` enum('ley','decreto','resolucion','plan','norma','resolucion_municipal','programa','otro') DEFAULT NULL,
  `fuente` text DEFAULT NULL,
  `descripcion` text DEFAULT NULL,
  `relevancia` text DEFAULT NULL,
  `anio` year(4) DEFAULT NULL,
  `enlace` text DEFAULT NULL,
  `aplicacion_id` int(11) DEFAULT NULL,
  `conceptos_cpe` text DEFAULT NULL,
  `creado_por` int(11) DEFAULT NULL,
  `jerarquia` enum('Suprema','Alta','Media','Media alta','Media baja','Baja') DEFAULT NULL,
  `vigente` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `documentos`
--

INSERT INTO `documentos` (`codigo`, `tipo`, `fuente`, `descripcion`, `relevancia`, `anio`, `enlace`, `aplicacion_id`, `conceptos_cpe`, `creado_por`, `jerarquia`, `vigente`) VALUES
('DOC001', 'ley', 'Ley de Educación Avelino Siñani', 'Norma editada', 'Editamos el artículo 5', '2022', 'https://drive.google.com/EDITADO', 2, 'Editado CPE', 3, NULL, 1),
('DOC003', 'ley', 'Constitución Política del Estado', 'Normativa base sobre derechos fundamentales', 'Incluye el derecho a la salud y alimentación', '2009', 'https://drive.google.com/ley2009', 1, 'Derecho a la salud y bienestar', 4, 'Suprema', 1),
('DOC004', '', 'Gobierno Autónomo Municipal de La Paz', 'Programa de desayuno escolar nutritivo', 'Aplicado en el distrito 4 desde 2022', '2022', 'https://drive.google.com/programa2022', 3, 'Acceso a alimentación en escuelas', 4, 'Media', 1),
('DOC005', 'resolucion', 'Ministerio de Salud', 'Reglamento sobre uso de productos saludables', 'Prohíbe productos ultraprocesados en kioscos', '2023', 'https://drive.google.com/resolucion-kioscos', 2, 'Protección a la niñez', 4, 'Alta', 1),
('DOC006', '', 'Programa Nacional de Alimentación Escolar', 'Aplica estrategias nutricionales en entornos educativos.', 'Artículo 6 fomenta la distribución de alimentos saludables.', '2024', 'https://drive.google.com/doc006', 3, 'El derecho a la salud y a la alimentación está garantizado por la CPE.', 3, 'Media', 1),
('DOC007', 'norma', 'Ley de Alimentación Escolar', 'Norma que regula la alimentación en escuelas', 'Artículo 5, 7 y 9 aplican a las escuelas rurales', '2024', 'https://drive.google.com/normaalimentos', 2, 'Derecho a la alimentación en el marco de la CPE', 4, 'Media alta', 1),
('DOC008', 'norma', 'Ministerio de Educación', 'Norma técnica para la alimentación escolar', 'Establece criterios nutricionales mínimos', '2021', 'https://drive.google.com/norma-escuela', 1, 'Educación en salud alimentaria', 4, 'Media alta', 1),
('DOC009', 'resolucion_municipal', 'Gobierno Municipal de El Alto', 'Implementación piloto de huertos escolares', 'Involucra a comunidad educativa y padres', '2020', 'https://drive.google.com/huertos', 3, 'Educación productiva', 4, 'Media baja', 1),
('DOC010', 'resolucion_municipal', 'Gobierno Municipal de El Alto', 'Implementación piloto de huertos escolares', 'Involucra a comunidad educativa y padres', '2020', 'https://drive.google.com/huertos', 3, 'Educación productiva', 4, 'Media baja', 1),
('DOC011', 'resolucion_municipal', 'Gobierno Municipal de El Alto', 'Implementación piloto de huertos escolares', 'Involucra a comunidad educativa y padres', '2020', 'https://drive.google.com/huertos', 3, 'Educación productiva', 4, 'Media baja', 1),
('DOC012', 'resolucion_municipal', 'Gobierno Municipal de El Alto', 'Implementación piloto de huertos escolares', 'Involucra a comunidad educativa y padres', '2020', 'https://drive.google.com/huertos', 3, 'Educación productiva', 4, 'Media baja', 1),
('DOC013', '', 'Ministerio de Desarrollo Productivo', 'Programa para fomentar la alimentación saludable en escolares', 'Capacitación en producción alimentaria local', '2024', 'https://drive.google.com/programa-alimentacion', 3, 'Alimentación y desarrollo', 4, 'Media alta', 1),
('DOC014', '', 'Ministerio de Salud', 'Programa educativo de alimentacion para estudiantes rurales', 'Este programa impulsa la alimentacion local sin conservantes', '2024', 'https://drive.google.com/programa-alimentacion', 1, 'Derecho a la alimentacion sana', 4, 'Media alta', 1),
('DOC999', 'programa', 'Ministerio de Salud', 'Programa educativo de alimentación saludable en escuelas rurales', 'Apoya el derecho a la alimentación sin conservantes en todos los niveles', '2024', 'https://drive.google.com/programa-alimentacion', 1, 'Derecho a la alimentación y a una vida saludable', 4, 'Media alta', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `documentos_eliminados`
--

CREATE TABLE `documentos_eliminados` (
  `codigo` varchar(20) NOT NULL,
  `eliminado_en` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `historial_busquedas`
--

CREATE TABLE `historial_busquedas` (
  `id` int(11) NOT NULL,
  `palabra` varchar(100) NOT NULL,
  `buscado_donde` enum('descripcion','relevancia','ambos') DEFAULT NULL,
  `buscado_en` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `historial_busquedas`
--

INSERT INTO `historial_busquedas` (`id`, `palabra`, `buscado_donde`, `buscado_en`) VALUES
(1, 'huertos', 'ambos', '2025-04-21 07:02:29'),
(2, 'huertos', 'ambos', '2025-04-21 07:03:02'),
(3, 'aliment', 'ambos', '2025-04-21 07:18:33'),
(4, 'escolar', 'ambos', '2025-04-21 07:18:41'),
(5, 'padres', 'ambos', '2025-04-21 07:18:49'),
(6, 'padr', 'ambos', '2025-04-21 07:18:56'),
(7, 'norma', 'ambos', '2025-04-21 07:19:05'),
(8, 'normativ', 'ambos', '2025-04-21 07:19:14'),
(9, 'implementacion', 'ambos', '2025-04-21 07:19:21'),
(10, 'escuela', 'ambos', '2025-04-21 07:19:28'),
(11, 'programa', 'ambos', '2025-04-21 07:19:42'),
(12, 'huert', 'ambos', '2025-04-21 07:19:50'),
(13, 'alimentación escolar', 'ambos', '2025-04-21 07:23:32'),
(14, 'nutricionales', 'ambos', '2025-04-21 07:24:47'),
(15, 'nutricionales mínimos', 'ambos', '2025-04-21 07:25:05'),
(16, 'alimentacion', 'ambos', '2025-04-21 08:02:10'),
(17, 'alimentacion', 'ambos', '2025-04-21 08:02:37'),
(18, 'saludable', 'ambos', '2025-04-21 08:02:37'),
(19, 'escolar', 'ambos', '2025-04-21 08:02:37');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `nombres` varchar(200) DEFAULT NULL,
  `apellidop` varchar(200) DEFAULT NULL,
  `apellidom` varchar(200) DEFAULT NULL,
  `correo` varchar(100) DEFAULT NULL,
  `contraseña` varchar(255) DEFAULT NULL,
  `rol` enum('MIGA') DEFAULT 'MIGA',
  `creado_en` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `nombres`, `apellidop`, `apellidom`, `correo`, `contraseña`, `rol`, `creado_en`) VALUES
(1, 'MigaNombre', 'ApellidoP', 'ApellidoM', 'miga@admin.com', 'HASH_COPIADO', 'MIGA', '2025-04-14 05:19:40'),
(3, 'Admin', 'Miga', 'Oficial', 'mg@admin.com', '$2b$10$.wnDOiKdhSR/s6EwxVAO6.im1.GJMLIUwY0nSDD/OsYtAK/uAy4Qy', 'MIGA', '2025-04-14 05:41:35'),
(4, 'Jean', 'Fernandez', 'Silva', 'admin@miga.com', '$2b$10$lejq1Aqgc0c0ecGHiWL8KOzwjRjczhTAG5SU.QFbSX3Ai2A/jVmgW', 'MIGA', '2025-04-15 06:31:54');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `aplicacion`
--
ALTER TABLE `aplicacion`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `documentos`
--
ALTER TABLE `documentos`
  ADD PRIMARY KEY (`codigo`),
  ADD KEY `alcance_id` (`aplicacion_id`),
  ADD KEY `creado_por` (`creado_por`);

--
-- Indices de la tabla `documentos_eliminados`
--
ALTER TABLE `documentos_eliminados`
  ADD PRIMARY KEY (`codigo`);

--
-- Indices de la tabla `historial_busquedas`
--
ALTER TABLE `historial_busquedas`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `correo` (`correo`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `aplicacion`
--
ALTER TABLE `aplicacion`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `historial_busquedas`
--
ALTER TABLE `historial_busquedas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `documentos`
--
ALTER TABLE `documentos`
  ADD CONSTRAINT `documentos_ibfk_1` FOREIGN KEY (`aplicacion_id`) REFERENCES `aplicacion` (`id`),
  ADD CONSTRAINT `documentos_ibfk_3` FOREIGN KEY (`creado_por`) REFERENCES `usuarios` (`id`);

--
-- Filtros para la tabla `documentos_eliminados`
--
ALTER TABLE `documentos_eliminados`
  ADD CONSTRAINT `documentos_eliminados_ibfk_1` FOREIGN KEY (`codigo`) REFERENCES `documentos` (`codigo`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
