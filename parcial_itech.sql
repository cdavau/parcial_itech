-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1:3306
-- Tiempo de generación: 01-07-2026 a las 14:16:35
-- Versión del servidor: 8.4.7
-- Versión de PHP: 8.3.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `parcial_itech`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `areas_interes`
--

DROP TABLE IF EXISTS `areas_interes`;
CREATE TABLE IF NOT EXISTS `areas_interes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_area_nombre` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `areas_interes`
--

INSERT INTO `areas_interes` (`id`, `nombre`) VALUES
(2, 'Big Data'),
(11, 'Blockchain'),
(4, 'Ciberseguridad'),
(1, 'Cloud Computing'),
(3, 'Desarrollo Móvil'),
(9, 'Desarrollo Web'),
(7, 'DevOps'),
(10, 'Inteligencia Artificial'),
(5, 'IoT (Internet de las Cosas)'),
(6, 'Machine Learning'),
(8, 'Python');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inscriptores`
--

DROP TABLE IF EXISTS `inscriptores`;
CREATE TABLE IF NOT EXISTS `inscriptores` (
  `id` int NOT NULL AUTO_INCREMENT,
  `identidad` varchar(30) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `apellido` varchar(100) NOT NULL,
  `edad` int NOT NULL,
  `sexo` enum('Masculino','Femenino','Otro') NOT NULL,
  `pais_residencia_id` int NOT NULL,
  `nacionalidad_id` int NOT NULL,
  `correo` varchar(150) NOT NULL,
  `celular` varchar(20) NOT NULL,
  `observaciones` text,
  `firma` text,
  `fecha_registro` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_identidad` (`identidad`),
  UNIQUE KEY `uq_correo` (`correo`),
  KEY `fk_insc_pais` (`pais_residencia_id`),
  KEY `fk_insc_nacionalidad` (`nacionalidad_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `inscriptores`
--

INSERT INTO `inscriptores` (`id`, `identidad`, `nombre`, `apellido`, `edad`, `sexo`, `pais_residencia_id`, `nacionalidad_id`, `correo`, `celular`, `observaciones`, `firma`, `fecha_registro`) VALUES
(1, '4-823-2233', 'Carlos', 'Abadia', 22, 'Masculino', 1, 1, 'davidsolo162@gmail.com', '69928506', 'Bueno', 'PvzzR2d6as4EsnMGf0yI/8L8KGN+I+iEbzhEU/DS26Cbmhjwyr+OYx7KRDv8fmbZDPEBfbW9KIuS5sWO75A8MQq/YSjwbOtmxDdxYnhNSdRXGiXJv8hF/ixEZjwtqJ3c8ISa/+K3/p/FDjfi0VGFMp8meVn/a+8y3sQScRhJrqz87pbnBGjy4PNHfvMQSk+ofvpYAFueDXQuTt9Pyx/Msz04zfJbIgvnPWB9Pf4cj31jVIqd+ozYGUvJC8J4sNVY67NzRypudI3t4XDHdGJy1LCEjnoo8jgP6dcpUzKqO56gRNvMS3e+iYF4B1ZHL6AapCNrF8rv4PVYsSTDO4bcXA==', '2026-07-01 14:09:33');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inscriptor_temas`
--

DROP TABLE IF EXISTS `inscriptor_temas`;
CREATE TABLE IF NOT EXISTS `inscriptor_temas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `inscriptor_id` int NOT NULL,
  `area_interes_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_insc_area` (`inscriptor_id`,`area_interes_id`),
  KEY `fk_it_area` (`area_interes_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `inscriptor_temas`
--

INSERT INTO `inscriptor_temas` (`id`, `inscriptor_id`, `area_interes_id`) VALUES
(3, 1, 8),
(1, 1, 9),
(2, 1, 10);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `paises`
--

DROP TABLE IF EXISTS `paises`;
CREATE TABLE IF NOT EXISTS `paises` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_pais_nombre` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `paises`
--

INSERT INTO `paises` (`id`, `nombre`) VALUES
(7, 'Argentina'),
(8, 'Chile'),
(2, 'Colombia'),
(3, 'Costa Rica'),
(6, 'España'),
(5, 'Estados Unidos'),
(4, 'México'),
(1, 'Panamá'),
(9, 'Perú'),
(10, 'Venezuela');

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `inscriptores`
--
ALTER TABLE `inscriptores`
  ADD CONSTRAINT `fk_insc_nacionalidad` FOREIGN KEY (`nacionalidad_id`) REFERENCES `paises` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_insc_pais` FOREIGN KEY (`pais_residencia_id`) REFERENCES `paises` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

--
-- Filtros para la tabla `inscriptor_temas`
--
ALTER TABLE `inscriptor_temas`
  ADD CONSTRAINT `fk_it_area` FOREIGN KEY (`area_interes_id`) REFERENCES `areas_interes` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_it_inscriptor` FOREIGN KEY (`inscriptor_id`) REFERENCES `inscriptores` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
