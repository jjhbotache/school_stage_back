-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 29-05-2023 a las 21:41:53
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

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `addresses`
--

CREATE TABLE `addresses` (
  `id` int(11) NOT NULL,
  `state` varchar(50) NOT NULL,
  `town` varchar(25) NOT NULL,
  `commune` int(3) NOT NULL,
  `neighbourhood` varchar(25) NOT NULL,
  `street` int(11) NOT NULL,
  `number` varchar(20) NOT NULL,
  `complement` varchar(200) NOT NULL,
  `postal_code` int(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `adr_list`
--

CREATE TABLE `adr_list` (
  `id` int(11) NOT NULL,
  `id_adress` int(11) NOT NULL,
  `id_user` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `designs`
--

CREATE TABLE `designs` (
  `id` int(11) NOT NULL,
  `name` varchar(106) NOT NULL,
  `img` varchar(106) NOT NULL,
  `ai` varchar(106) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `designs`
--

INSERT INTO `designs` (`id`, `name`, `img`, `ai`) VALUES
(25, 'Amor el mundo tiene sus maravillas pero tú eres la maravilla de mi mundo', 'img/amor_el_mundo_tiene_sus_maravillas_pero_tu_eres_maravillas_de_mi_mundo.png', 'ai/amor_el_mundo_tiene_sus_maravillas_pero_tu_eres_maravillas_de_mi_mundo.ai'),
(26, '20 pero a que costo', 'img/20-pero-a-que-costo.png', 'ai/20-pero-a-que-costo.ai'),
(29, 'drink wine feel fine', 'img/drink-wine-feel-fine.png', 'ai/drink-wine-feel-fine.ai'),
(30, 'Juli como no te voy a querer si dices puras pendejadas igual que yo', 'img/como-no-te-voy-a-querer-si-dices-puras-pendejadas-igual-que-yo.png', 'ai/como-no-te-voy-a-querer-si-dices-puras-pendejadas-igual-que-yo.ai');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `packing_colors`
--

CREATE TABLE `packing_colors` (
  `id` int(11) NOT NULL,
  `color` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `packing_colors`
--

INSERT INTO `packing_colors` (`id`, `color`) VALUES
(1, 'rojo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pucharse_orders`
--

CREATE TABLE `pucharse_orders` (
  `id` int(11) NOT NULL,
  `id_wine` int(11) NOT NULL,
  `id_design` int(11) DEFAULT NULL,
  `id_real_design` int(11) NOT NULL,
  `msg` varchar(255) DEFAULT NULL,
  `id_packing_color` int(11) NOT NULL,
  `id_secondary_packing_color` int(11) NOT NULL,
  `delivery_date` date NOT NULL,
  `id_delivery_place` varchar(255) NOT NULL,
  `id_user` bigint(20) NOT NULL,
  `id_vaucher` varchar(100) NOT NULL,
  `amount` int(11) NOT NULL,
  `paid` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `real_designs`
--

CREATE TABLE `real_designs` (
  `id` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `img` varchar(114) NOT NULL,
  `dxf` varchar(114) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `real_designs`
--

INSERT INTO `real_designs` (`id`, `name`, `img`, `dxf`) VALUES
(5, '20 pero a que costo ?', 'img/20-pero-a-que-costo_REAL_DESIGN.png', 'dxf/20-pero-a-que-costo_REAL_DESIGN.dxf'),
(7, 'vuela alto', 'img/vuela-alto_REAL_DESIGN.png', 'dxf/vuela-alto_REAL_DESIGN.dxf'),
(8, 'brilla-mas-que-nunca-hoy-es-tu-dia', 'img/brilla-mas-que-nunca-hoy-es-tu-dia_REAL_DESIGN.png', 'dxf/brilla-mas-que-nunca-hoy-es-tu-dia_REAL_DESIGN.dxf');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `secondary_packing_colors`
--

CREATE TABLE `secondary_packing_colors` (
  `id` int(11) NOT NULL,
  `color` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `secondary_packing_colors`
--

INSERT INTO `secondary_packing_colors` (`id`, `color`) VALUES
(1, 'plateado'),
(2, 'blanco'),
(3, 'negro');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tags`
--

CREATE TABLE `tags` (
  `id` int(11) NOT NULL,
  `name` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tags`
--

INSERT INTO `tags` (`id`, `name`) VALUES
(1, 'cumpleaños'),
(2, 'aniversario'),
(3, 'amor'),
(4, 'casual');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tag_list`
--

CREATE TABLE `tag_list` (
  `id` int(11) NOT NULL,
  `id_design` int(11) NOT NULL,
  `id_tag` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `id` bigint(20) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `phone` bigint(20) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `first_name`, `last_name`, `phone`, `email`, `password`) VALUES
(1104938753, 'Sofia', 'Zuluaga', 3185942457, 'soffiazuluagaramirez56@gmail.com', NULL),
(1106226952, 'JUAN JOSE', 'HUERTAS BOTACHE', 3012167977, 'jjhuertasbotache@gmail.com', NULL),
(1106226953, 'juan jose', 'huertas botache', 3012167977, 'jjhuertasbotache@gmail.com', 'J1234567890j'),
(1109411200, 'Juan David ', 'Rios Escudero', 3155175493, 'riosescudero192004@gmail.com', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `vouchers`
--

CREATE TABLE `vouchers` (
  `id` int(11) NOT NULL,
  `file` blob NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `wine_kinds`
--

CREATE TABLE `wine_kinds` (
  `id` int(11) NOT NULL,
  `name` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `addresses`
--
ALTER TABLE `addresses`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `adr_list`
--
ALTER TABLE `adr_list`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_adress` (`id_adress`),
  ADD KEY `id_user_dir_list` (`id_user`);

--
-- Indices de la tabla `designs`
--
ALTER TABLE `designs`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `packing_colors`
--
ALTER TABLE `packing_colors`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `pucharse_orders`
--
ALTER TABLE `pucharse_orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_wine_kinds` (`id_wine`),
  ADD KEY `id_real_designs` (`id_real_design`),
  ADD KEY `id_packing_color` (`id_packing_color`),
  ADD KEY `id_secondary_packing_color` (`id_secondary_packing_color`),
  ADD KEY `id_user` (`id_user`),
  ADD KEY `id_design_constraint` (`id_design`);

--
-- Indices de la tabla `real_designs`
--
ALTER TABLE `real_designs`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `secondary_packing_colors`
--
ALTER TABLE `secondary_packing_colors`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `tags`
--
ALTER TABLE `tags`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `tag_list`
--
ALTER TABLE `tag_list`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_tags` (`id_design`),
  ADD KEY `id_designs` (`id_tag`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `vouchers`
--
ALTER TABLE `vouchers`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `wine_kinds`
--
ALTER TABLE `wine_kinds`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `addresses`
--
ALTER TABLE `addresses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `designs`
--
ALTER TABLE `designs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT de la tabla `packing_colors`
--
ALTER TABLE `packing_colors`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `pucharse_orders`
--
ALTER TABLE `pucharse_orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=55;

--
-- AUTO_INCREMENT de la tabla `real_designs`
--
ALTER TABLE `real_designs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `secondary_packing_colors`
--
ALTER TABLE `secondary_packing_colors`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `tags`
--
ALTER TABLE `tags`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `vouchers`
--
ALTER TABLE `vouchers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `wine_kinds`
--
ALTER TABLE `wine_kinds`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `adr_list`
--
ALTER TABLE `adr_list`
  ADD CONSTRAINT `id_adress` FOREIGN KEY (`id_adress`) REFERENCES `addresses` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `id_user_dir_list` FOREIGN KEY (`id_user`) REFERENCES `users` (`id`);

--
-- Filtros para la tabla `pucharse_orders`
--
ALTER TABLE `pucharse_orders`
  ADD CONSTRAINT `id_design_constraint` FOREIGN KEY (`id_design`) REFERENCES `designs` (`id`);

--
-- Filtros para la tabla `tag_list`
--
ALTER TABLE `tag_list`
  ADD CONSTRAINT `id_designs` FOREIGN KEY (`id_tag`) REFERENCES `designs` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `id_tags` FOREIGN KEY (`id_design`) REFERENCES `tags` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
