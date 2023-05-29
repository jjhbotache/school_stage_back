-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 29-05-2023 a las 22:27:26
-- Versión del servidor: 10.4.27-MariaDB
-- Versión de PHP: 8.0.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `school_stage_project`
--

--
-- Volcado de datos para la tabla `designs`
--

INSERT INTO `designs` (`id`, `name`, `img`, `ai`) VALUES
(25, 'Amor el mundo tiene sus maravillas pero tú eres la maravilla de mi mundo', 'img/amor_el_mundo_tiene_sus_maravillas_pero_tu_eres_maravillas_de_mi_mundo.png', 'ai/amor_el_mundo_tiene_sus_maravillas_pero_tu_eres_maravillas_de_mi_mundo.ai'),
(26, '20 pero a que costo', 'img/20-pero-a-que-costo.png', 'ai/20-pero-a-que-costo.ai'),
(29, 'drink wine feel fine', 'img/drink-wine-feel-fine.png', 'ai/drink-wine-feel-fine.ai'),
(30, 'Juli como no te voy a querer si dices puras pendejadas igual que yo', 'img/como-no-te-voy-a-querer-si-dices-puras-pendejadas-igual-que-yo.png', 'ai/como-no-te-voy-a-querer-si-dices-puras-pendejadas-igual-que-yo.ai');

--
-- Volcado de datos para la tabla `packing_colors`
--

INSERT INTO `packing_colors` (`id`, `color`) VALUES
(1, 'rojo');

--
-- Volcado de datos para la tabla `pucharse_orders`
--

INSERT INTO `pucharse_orders` (`id`, `id_wine`, `id_design`, `id_real_design`, `msg`, `id_packing_color`, `id_secondary_packing_color`, `delivery_date`, `id_delivery_place`, `id_user`, `id_vaucher`, `amount`, `paid`) VALUES
(47, 6, 26, 0, 'fgsdfsdf', 1, 1, '2023-05-25', 'Ibague Tolima Calle 13 #7-82', 1106226952, 'vaucher/Captura de pantalla 2023-03-03 082352.png', 1, 1),
(49, 2, 25, 0, '', 1, 1, '2023-06-01', 'Ibague Tolima Calle 13 #7-82', 1106226952, 'vaucher/Feliz-aniversario-mi-amor-te-amo-cesar.png', 1, 0),
(50, 2, 29, 0, ' Wanted sentence drink wine feel mine', 1, 3, '2023-06-01', 'mi casas', 1106226952, 'vaucher/you-did-it.png', 1, 0),
(51, 2, 30, 0, ' Wanted sentence Juli como no te voy a odiar perra', 1, 3, '2023-06-01', 'Ibague Tolima Calle 13 #7-82', 1106226952, 'vaucher/WhatsApp Image 2023-05-11 at 10.04.27.jpeg', 1, 0),
(52, 2, 25, 0, 'null', 1, 3, '2023-06-01', 'Ibague Tolima Calle 13 #7-82', 1106226952, 'vaucher/cargador cel.jpg', 1, 0),
(53, 6, 26, 7, 'null', 1, 1, '2023-05-30', 'a mi casa', 1106226952, 'vaucher/asdasdasda.png', 4, 1),
(54, 8, 30, 8, ' Wanted sentence Juli como no te voy a querer si dices puras pendejadas igual que SU MAMA HPTA', 1, 2, '2023-05-30', 'a mi casa', 1106226952, 'vaucher/Que-todo-lo-bueno-te-siga,-te-encuentra-y-se-quede-contigo.-Feliz-Cumpleaños.png', 2, 1);

--
-- Volcado de datos para la tabla `real_designs`
--

INSERT INTO `real_designs` (`id`, `name`, `img`, `dxf`) VALUES
(5, '20 pero a que costo ?', 'img/20-pero-a-que-costo_REAL_DESIGN.png', 'dxf/20-pero-a-que-costo_REAL_DESIGN.dxf'),
(7, 'vuela alto', 'img/vuela-alto_REAL_DESIGN.png', 'dxf/vuela-alto_REAL_DESIGN.dxf'),
(8, 'brilla-mas-que-nunca-hoy-es-tu-dia', 'img/brilla-mas-que-nunca-hoy-es-tu-dia_REAL_DESIGN.png', 'dxf/brilla-mas-que-nunca-hoy-es-tu-dia_REAL_DESIGN.dxf');

--
-- Volcado de datos para la tabla `secondary_packing_colors`
--

INSERT INTO `secondary_packing_colors` (`id`, `color`) VALUES
(1, 'plateado'),
(2, 'blanco'),
(3, 'negro');

--
-- Volcado de datos para la tabla `tags`
--

INSERT INTO `tags` (`id`, `name`) VALUES
(1, 'cumpleaños'),
(2, 'aniversario'),
(3, 'amor'),
(4, 'casual');

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `first_name`, `last_name`, `phone`, `email`, `password`) VALUES
(1104938753, 'Sofia', 'Zuluaga', 3185942457, 'soffiazuluagaramirez56@gmail.com', NULL),
(1106226952, 'JUAN JOSE', 'HUERTAS BOTACHE', 3012167977, 'jjhuertasbotache@gmail.com', NULL),
(1106226953, 'juan jose', 'huertas botache', 3012167977, 'jjhuertasbotache@gmail.com', 'J1234567890j'),
(1109411200, 'Juan David ', 'Rios Escudero', 3155175493, 'riosescudero192004@gmail.com', NULL);

--
-- Volcado de datos para la tabla `wine_kinds`
--

INSERT INTO `wine_kinds` (`id`, `name`) VALUES
(2, 'tempranillo'),
(3, 'airen'),
(4, 'malbec'),
(5, 'carmenere'),
(6, 'merlot'),
(8, 'cabernet sauvignon '),
(13, 'moscatel'),
(16, 'rose');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
