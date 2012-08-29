-- phpMyAdmin SQL Dump
-- version 3.4.10.1deb1
-- http://www.phpmyadmin.net
--
-- Servidor: localhost
-- Tiempo de generación: 25-08-2012 a las 12:01:00
-- Versión del servidor: 5.5.24
-- Versión de PHP: 5.3.10-1ubuntu3.2

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de datos: `LanguageLearning`
--

-- --------------------------------------------------------

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Chapters`
--

CREATE TABLE IF NOT EXISTS `Chapters` (
  `id_chapters` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `level` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_chapters`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=3 ;

--
-- Volcado de datos para la tabla `Chapters`
--

INSERT INTO `Chapters` (`id_chapters`, `name`, `level`) VALUES
(1, 'Introduction', 0),
(2, 'Basic I', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Compost`
--

CREATE TABLE IF NOT EXISTS `Compost` (
  `id_compost` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_chapters` int(10) unsigned NOT NULL,
  `id_phrases` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_compost`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=11 ;

--
-- Volcado de datos para la tabla `Compost`
--

INSERT INTO `Compost` (`id_compost`, `id_chapters`, `id_phrases`) VALUES
(1, 0, 5),
(2, 0, 6),
(3, 0, 7),
(4, 0, 8),
(5, 0, 9),
(6, 0, 10),
(7, 0, 11),
(8, 0, 12),
(9, 0, 13),
(10, 0, 14);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Courses`
--

CREATE TABLE IF NOT EXISTS `Courses` (
  `id_courses` tinyint(4) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `level` int(11) NOT NULL,
  PRIMARY KEY (`id_courses`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=2 ;

--
-- Volcado de datos para la tabla `Courses`
--

INSERT INTO `Courses` (`id_courses`, `name`, `level`) VALUES
(0, 'English', 0),
(1, 'Español', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Courses_Tiene`
--

CREATE TABLE IF NOT EXISTS `Courses_Tiene` (
  `id_tiene` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_courses` int(10) unsigned NOT NULL,
  `id_chapters` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_tiene`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=3 ;

--
-- Volcado de datos para la tabla `Courses_Tiene`
--

INSERT INTO `Courses_Tiene` (`id_tiene`, `id_courses`, `id_chapters`) VALUES
(1, 0, 1),
(2, 0, 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Matriculat`
--

CREATE TABLE IF NOT EXISTS `Matriculat` (
  `id_matriculat` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `nick` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `id_courses` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_matriculat`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=3 ;

--
-- Volcado de datos para la tabla `Matriculat`
--

INSERT INTO `Matriculat` (`id_matriculat`, `nick`, `id_courses`) VALUES
(1, 'admin', 0),
(2, 'null', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Phrases`
--

CREATE TABLE IF NOT EXISTS `Phrases` (
  `id_phrases` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `phrases` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `file_path` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id_phrases`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=15 ;

--
-- Volcado de datos para la tabla `Phrases`
--

INSERT INTO `Phrases` (`id_phrases`, `phrases`, `file_path`) VALUES
(5, 'Are you ready?', 'areYouReady.mp3'),
(6, 'Are you ok?', 'areYouOk.mp3'),
(7, 'Are you Sick?', 'areYouSick.mp3'),
(8, 'Are you Sure?', 'areYouSure.mp3'),
(9, 'Are you waiting for someone?', 'areYouWaitingForSomeone.mp3'),
(10, 'Are you working today?', 'areYouWorkingToday.mp3'),
(11, 'Are you working tomorrow?', 'areYouWorkingTomorrow.mp3'),
(12, 'At what time?', 'atWhatTime.mp3'),
(13, 'At what time did it happen?', 'atWhatTimeDidItHappen.mp3'),
(14, 'A long time ago?', 'aLongTimeAgo.mp3');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Users`
--

CREATE TABLE IF NOT EXISTS `Users` (
  `id_user` int(11) NOT NULL AUTO_INCREMENT,
  `nick` varchar(20) NOT NULL,
  `pass` varchar(20) NOT NULL,
  `type` varchar(10) NOT NULL,
  `name` varchar(20) NOT NULL,
  `lastname` varchar(20) NOT NULL,
  `gender` varchar(5) NOT NULL,
  `mail` varchar(20) NOT NULL,
  `experience` tinyint(3) unsigned NOT NULL,
  `date` varchar(12) NOT NULL,
  `more_information` varchar(255) NOT NULL,
  `path_photo` varchar(30) NOT NULL,
  PRIMARY KEY (`id_user`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 COMMENT='UserTable information' AUTO_INCREMENT=6 ;

--
-- Volcado de datos para la tabla `Users`
--

INSERT INTO `Users` (`id_user`, `nick`, `pass`, `type`, `name`, `lastname`, `gender`, `mail`, `experience`, `date`, `more_information`, `path_photo`) VALUES
(1, 'admin', 'admin', 'admin', 'John', 'Rock', 'Home', 'admin@litwitter.com', 1, '31-02-88', 'Al ser el primer usuari, al registrarme soc el admin.', 'photos/avatar_unknown.png'),
(2, 'lisa', 'lisa', 'admin', 'Lisa', 'Simpson', 'Dona', 'lisa@simpsons.com', 0, '19-04-87', 'Soc molt coneguda en un show de TV que faig en Estats Units, aqui em podeu veure per antena3.\r\n	\r\n	\r\n	', 'photos/lisa.gif'),
(3, 'Homer', 'homer', 'usuari', 'Homer', 'Simpson', 'Home', 'homer@simpsons.com', 0, '19-04-87', 'Mmmm..... rosquillasss....', 'photos/homerAvatar.png'),
(4, 'Bart', 'bart', 'usuari', 'Bart', 'Simpsons', 'Home', 'bart@simpsons.com', 0, '19-04-87', 'Multiplicate por cero!!!\n<br>Yo no he sido..', 'photos/bartAvatar.jpg'),
(5, 'xavier', 'xanguera', 'usuari', 'Xavier', 'Anguera', 'Home', 'xan@gmail.com', 0, '31-02-12', 'Usuari de proba', 'photos/homerAvatar.png');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
