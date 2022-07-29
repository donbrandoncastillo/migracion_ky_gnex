/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 80029 (8.0.29)
 Source Host           : 127.0.0.1:3306
 Source Schema         : a24

 Target Server Type    : MySQL
 Target Server Version : 80029 (8.0.29)
 File Encoding         : 65001

 Date: 29/07/2022 14:30:54
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for aduana_seccion
-- ----------------------------
DROP TABLE IF EXISTS `aduana_seccion`;
CREATE TABLE `aduana_seccion` (
  `id` int NOT NULL AUTO_INCREMENT,
  `clave` varchar(5) NOT NULL,
  `seccion` varchar(5) NOT NULL,
  `descripcion` varchar(200) NOT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=128 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for agencia
-- ----------------------------
DROP TABLE IF EXISTS `agencia`;
CREATE TABLE `agencia` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre_corto` varchar(80) NOT NULL,
  `opcion_id_tipo_agencia` int NOT NULL,
  `razon_social` varchar(255) NOT NULL,
  `telefono` varchar(15) DEFAULT NULL,
  `fax` varchar(15) DEFAULT NULL,
  `calle` varchar(60) DEFAULT NULL,
  `numero_ext` varchar(10) DEFAULT NULL,
  `numero_int` varchar(10) DEFAULT NULL,
  `colonia` varchar(50) DEFAULT NULL,
  `cp` varchar(10) DEFAULT NULL,
  `ciudad` varchar(50) DEFAULT NULL,
  `pais_id` int DEFAULT NULL,
  `municipio_id` int DEFAULT NULL,
  `estado_id` int DEFAULT NULL,
  `correo` varchar(50) DEFAULT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  `numero_identificacion_fiscal` varchar(15) NOT NULL,
  `broker_number` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `UQ_agencia_clave` (`nombre_corto`) USING BTREE,
  UNIQUE KEY `UQ_agencia_razon_social` (`razon_social`) USING BTREE,
  UNIQUE KEY `UQ_agencia_clave_razon_social_rfc` (`nombre_corto`,`razon_social`) USING BTREE,
  KEY `opcion_id_tipo_agencia` (`opcion_id_tipo_agencia`) USING BTREE,
  KEY `pais_id` (`pais_id`) USING BTREE,
  KEY `municipio_id` (`municipio_id`) USING BTREE,
  KEY `estado_id` (`estado_id`) USING BTREE,
  CONSTRAINT `agencia_ibfk_737` FOREIGN KEY (`opcion_id_tipo_agencia`) REFERENCES `opcion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `agencia_ibfk_738` FOREIGN KEY (`pais_id`) REFERENCES `pais` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `agencia_ibfk_739` FOREIGN KEY (`municipio_id`) REFERENCES `municipio` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `agencia_ibfk_740` FOREIGN KEY (`estado_id`) REFERENCES `estado` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=86 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for agencia_patente
-- ----------------------------
DROP TABLE IF EXISTS `agencia_patente`;
CREATE TABLE `agencia_patente` (
  `id` int NOT NULL AUTO_INCREMENT,
  `agencia_id` int NOT NULL,
  `nombre` varchar(80) NOT NULL,
  `patente` varchar(10) NOT NULL,
  `opcion_id_tipo_patente` int NOT NULL,
  `rfc` varchar(15) NOT NULL,
  `curp` varchar(20) DEFAULT NULL,
  `patente_default` tinyint(1) NOT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `agencia_id` (`agencia_id`) USING BTREE,
  KEY `opcion_id_tipo_patente` (`opcion_id_tipo_patente`) USING BTREE,
  CONSTRAINT `agencia_patente_ibfk_135` FOREIGN KEY (`agencia_id`) REFERENCES `agencia` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `agencia_patente_ibfk_136` FOREIGN KEY (`opcion_id_tipo_patente`) REFERENCES `opcion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for almacen_desperdicio
-- ----------------------------
DROP TABLE IF EXISTS `almacen_desperdicio`;
CREATE TABLE `almacen_desperdicio` (
  `id` int NOT NULL AUTO_INCREMENT,
  `parte_id` int NOT NULL,
  `saldo` decimal(19,6) NOT NULL,
  `peso_kg` decimal(19,6) NOT NULL,
  `opcion_id_categoria` int NOT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  `fraccion_id` int DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `parte_id` (`parte_id`) USING BTREE,
  KEY `opcion_id_categoria` (`opcion_id_categoria`) USING BTREE,
  KEY `fraccion_id` (`fraccion_id`) USING BTREE,
  CONSTRAINT `almacen_desperdicio_ibfk_441` FOREIGN KEY (`parte_id`) REFERENCES `parte` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `almacen_desperdicio_ibfk_442` FOREIGN KEY (`opcion_id_categoria`) REFERENCES `opcion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `almacen_desperdicio_ibfk_443` FOREIGN KEY (`fraccion_id`) REFERENCES `fraccion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3260 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for bom
-- ----------------------------
DROP TABLE IF EXISTS `bom`;
CREATE TABLE `bom` (
  `id` int NOT NULL AUTO_INCREMENT,
  `bom_id` int DEFAULT NULL,
  `componente_id` int NOT NULL,
  `fecha_inicial` date NOT NULL,
  `fecha_final` date NOT NULL,
  `cantidad_um` decimal(28,14) NOT NULL,
  `um` int NOT NULL,
  `factor_conversion` decimal(28,14) NOT NULL,
  `cantidad_umc` decimal(28,14) NOT NULL,
  `umc` int NOT NULL,
  `merma` decimal(28,14) NOT NULL,
  `desperdicio` decimal(28,14) NOT NULL,
  `consumible` tinyint(1) NOT NULL DEFAULT '0',
  `originario` tinyint(1) NOT NULL DEFAULT '0',
  `se_descarga` tinyint(1) NOT NULL DEFAULT '1',
  `usuario_id` int DEFAULT NULL,
  `fecha_actualizacion` date NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `bom_id` (`bom_id`),
  KEY `componente_id` (`componente_id`),
  KEY `um` (`um`),
  KEY `umc` (`umc`),
  CONSTRAINT `bom_ibfk_177` FOREIGN KEY (`bom_id`) REFERENCES `bom` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `bom_ibfk_178` FOREIGN KEY (`componente_id`) REFERENCES `parte` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `bom_ibfk_179` FOREIGN KEY (`um`) REFERENCES `medida` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `bom_ibfk_180` FOREIGN KEY (`umc`) REFERENCES `medida` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2711 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for bom_detalle
-- ----------------------------
DROP TABLE IF EXISTS `bom_detalle`;
CREATE TABLE `bom_detalle` (
  `id` int NOT NULL AUTO_INCREMENT,
  `bom_id` int NOT NULL,
  `parte_id_componente` int NOT NULL,
  `cantidad_descargar` decimal(19,6) NOT NULL,
  `cantidad_uso_mrp` decimal(19,6) NOT NULL,
  `medida_id_mrp` int NOT NULL,
  `factor_conversion` decimal(19,6) NOT NULL,
  `medida_id_descarga` int NOT NULL,
  `fraccion_id_mx_parte` int NOT NULL,
  `fraccion_id_usa_parte` int DEFAULT NULL,
  `fecha_inicial` date NOT NULL,
  `fecha_final` date NOT NULL,
  `merma` decimal(19,6) DEFAULT '0.000000',
  `desperdicio` decimal(19,6) DEFAULT '0.000000',
  `fantasma` tinyint(1) DEFAULT '0',
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `bom_id` (`bom_id`),
  KEY `parte_id_componente` (`parte_id_componente`),
  KEY `medida_id_mrp` (`medida_id_mrp`),
  KEY `medida_id_descarga` (`medida_id_descarga`),
  KEY `fraccion_id_mx_parte` (`fraccion_id_mx_parte`),
  KEY `fraccion_id_usa_parte` (`fraccion_id_usa_parte`),
  CONSTRAINT `bom_detalle_ibfk_1` FOREIGN KEY (`bom_id`) REFERENCES `bom` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `bom_detalle_ibfk_2` FOREIGN KEY (`parte_id_componente`) REFERENCES `parte` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `bom_detalle_ibfk_3` FOREIGN KEY (`medida_id_mrp`) REFERENCES `medida` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `bom_detalle_ibfk_4` FOREIGN KEY (`medida_id_descarga`) REFERENCES `medida` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `bom_detalle_ibfk_5` FOREIGN KEY (`fraccion_id_mx_parte`) REFERENCES `fraccion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `bom_detalle_ibfk_6` FOREIGN KEY (`fraccion_id_usa_parte`) REFERENCES `fraccion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for certificacion_origen
-- ----------------------------
DROP TABLE IF EXISTS `certificacion_origen`;
CREATE TABLE `certificacion_origen` (
  `id` int NOT NULL AUTO_INCREMENT,
  `folio` varchar(50) NOT NULL,
  `edocument` varchar(50) DEFAULT NULL,
  `fecha_emision` date NOT NULL,
  `fecha_inicial` date NOT NULL,
  `fecha_final` date NOT NULL,
  `tipo_documento_id` int NOT NULL,
  `tratado_acuerdo_id` int NOT NULL,
  `tipo_catalogo_id` int NOT NULL,
  `nombre` varchar(50) DEFAULT NULL,
  `puesto` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQ_folio` (`folio`),
  KEY `tipo_documento_id` (`tipo_documento_id`),
  KEY `tratado_acuerdo_id` (`tratado_acuerdo_id`),
  KEY `tipo_catalogo_id` (`tipo_catalogo_id`),
  CONSTRAINT `certificacion_origen_ibfk_1` FOREIGN KEY (`tipo_documento_id`) REFERENCES `opcion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `certificacion_origen_ibfk_2` FOREIGN KEY (`tratado_acuerdo_id`) REFERENCES `opcion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `certificacion_origen_ibfk_3` FOREIGN KEY (`tipo_catalogo_id`) REFERENCES `opcion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for certificacion_origen_detalle
-- ----------------------------
DROP TABLE IF EXISTS `certificacion_origen_detalle`;
CREATE TABLE `certificacion_origen_detalle` (
  `id` int NOT NULL AUTO_INCREMENT,
  `certificacion_origen_id` int NOT NULL,
  `parte_id` int NOT NULL,
  `descripcion_esp` varchar(250) NOT NULL,
  `descripcion_ing` varchar(250) NOT NULL,
  `clasificacion_arancelaria` varchar(10) NOT NULL,
  `criterio_id` int NOT NULL,
  `productor_id` int DEFAULT NULL,
  `costo_neto_id` int DEFAULT NULL,
  `pais_origen_id` int NOT NULL,
  `comentarios` varchar(250) DEFAULT NULL,
  `fecha_captura` date NOT NULL,
  `fecha_inicial` date NOT NULL,
  `fecha_final` date NOT NULL,
  PRIMARY KEY (`id`),
  KEY `certificacion_origen_id` (`certificacion_origen_id`),
  KEY `parte_id` (`parte_id`),
  KEY `criterio_id` (`criterio_id`),
  KEY `productor_id` (`productor_id`),
  KEY `costo_neto_id` (`costo_neto_id`),
  KEY `pais_origen_id` (`pais_origen_id`),
  CONSTRAINT `certificacion_origen_detalle_ibfk_1` FOREIGN KEY (`certificacion_origen_id`) REFERENCES `certificacion_origen` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `certificacion_origen_detalle_ibfk_2` FOREIGN KEY (`parte_id`) REFERENCES `parte` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `certificacion_origen_detalle_ibfk_3` FOREIGN KEY (`criterio_id`) REFERENCES `criterio_origen` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `certificacion_origen_detalle_ibfk_4` FOREIGN KEY (`productor_id`) REFERENCES `productor` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `certificacion_origen_detalle_ibfk_5` FOREIGN KEY (`costo_neto_id`) REFERENCES `costo_neto` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `certificacion_origen_detalle_ibfk_6` FOREIGN KEY (`pais_origen_id`) REFERENCES `pais` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for certificacion_origen_entidad
-- ----------------------------
DROP TABLE IF EXISTS `certificacion_origen_entidad`;
CREATE TABLE `certificacion_origen_entidad` (
  `id` int NOT NULL AUTO_INCREMENT,
  `certificacion_origen_id` int NOT NULL,
  `tipo_entidad_id` int NOT NULL,
  `entidad_id` int NOT NULL,
  `entidad_domicilio_id` int NOT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `certificador` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `certificacion_origen_id` (`certificacion_origen_id`),
  KEY `tipo_entidad_id` (`tipo_entidad_id`),
  KEY `entidad_id` (`entidad_id`),
  KEY `entidad_domicilio_id` (`entidad_domicilio_id`),
  CONSTRAINT `certificacion_origen_entidad_ibfk_1` FOREIGN KEY (`certificacion_origen_id`) REFERENCES `certificacion_origen` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `certificacion_origen_entidad_ibfk_2` FOREIGN KEY (`tipo_entidad_id`) REFERENCES `opcion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `certificacion_origen_entidad_ibfk_3` FOREIGN KEY (`entidad_id`) REFERENCES `cliente` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `certificacion_origen_entidad_ibfk_4` FOREIGN KEY (`entidad_domicilio_id`) REFERENCES `cliente_domicilio` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for chofer
-- ----------------------------
DROP TABLE IF EXISTS `chofer`;
CREATE TABLE `chofer` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `apellido_paterno` varchar(50) NOT NULL,
  `apellido_materno` varchar(50) NOT NULL,
  `compania_transportista_id` int NOT NULL,
  `rfc` varchar(15) DEFAULT NULL,
  `opcion_id_genero` int DEFAULT NULL,
  `pais_id_nacionalidad` int DEFAULT NULL,
  `licencia` varchar(15) DEFAULT NULL,
  `estado_id_licencia` int DEFAULT NULL,
  `opcion_id_licencia` int DEFAULT NULL,
  `vencimiento_licencia` date DEFAULT NULL,
  `gafete` varchar(24) DEFAULT NULL,
  `vencimiento_gafete` date DEFAULT NULL,
  `fastid` varchar(15) DEFAULT NULL,
  `vencimiento_fastid` date DEFAULT NULL,
  `num_documento_viaje` varchar(15) DEFAULT NULL,
  `estado_id_documento` int DEFAULT NULL,
  `opcion_id_documento` int DEFAULT NULL,
  `aceid` varchar(10) DEFAULT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  `hazmat` tinyint(1) NOT NULL DEFAULT '1',
  `curp` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `compania_transportista_id` (`compania_transportista_id`) USING BTREE,
  KEY `opcion_id_genero` (`opcion_id_genero`) USING BTREE,
  KEY `pais_id_nacionalidad` (`pais_id_nacionalidad`) USING BTREE,
  KEY `estado_id_licencia` (`estado_id_licencia`) USING BTREE,
  KEY `opcion_id_licencia` (`opcion_id_licencia`) USING BTREE,
  KEY `estado_id_documento` (`estado_id_documento`) USING BTREE,
  KEY `opcion_id_documento` (`opcion_id_documento`) USING BTREE,
  CONSTRAINT `chofer_ibfk_984` FOREIGN KEY (`compania_transportista_id`) REFERENCES `compania_transportista` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `chofer_ibfk_985` FOREIGN KEY (`opcion_id_genero`) REFERENCES `opcion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `chofer_ibfk_986` FOREIGN KEY (`pais_id_nacionalidad`) REFERENCES `pais` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `chofer_ibfk_987` FOREIGN KEY (`estado_id_licencia`) REFERENCES `estado` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `chofer_ibfk_988` FOREIGN KEY (`opcion_id_licencia`) REFERENCES `opcion` (`id`),
  CONSTRAINT `chofer_ibfk_989` FOREIGN KEY (`estado_id_documento`) REFERENCES `estado` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `chofer_ibfk_990` FOREIGN KEY (`opcion_id_documento`) REFERENCES `opcion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for clave_pedimento
-- ----------------------------
DROP TABLE IF EXISTS `clave_pedimento`;
CREATE TABLE `clave_pedimento` (
  `id` int NOT NULL AUTO_INCREMENT,
  `clave` varchar(5) NOT NULL,
  `opcion_id_tipo` int DEFAULT NULL,
  `nombre` varchar(200) NOT NULL,
  `descripcion_esp` varchar(1100) NOT NULL,
  `descargable` tinyint(1) DEFAULT NULL,
  `consolidado` tinyint(1) DEFAULT NULL,
  `tlcan303` tinyint(1) DEFAULT NULL,
  `opcion_id_pago_dta` int DEFAULT NULL,
  `nafta_dta` tinyint(1) DEFAULT NULL,
  `aplicacion` varchar(4000) DEFAULT NULL,
  `base_legal` varchar(1200) DEFAULT NULL,
  `pago_igi_imp` varchar(50) DEFAULT NULL,
  `pago_cc_imp` varchar(50) DEFAULT NULL,
  `pago_dta_imp` varchar(50) DEFAULT NULL,
  `pago_ieps_imp` varchar(50) DEFAULT NULL,
  `pago_isan_imp` varchar(50) DEFAULT NULL,
  `pago_iva_imp` varchar(50) DEFAULT NULL,
  `pago_recargos_imp` varchar(50) DEFAULT NULL,
  `pago_dti_imp` varchar(50) DEFAULT NULL,
  `pago_bbs_imp` varchar(50) DEFAULT NULL,
  `pago_ige_exp` varchar(50) DEFAULT NULL,
  `pago_cc_exp` varchar(50) DEFAULT NULL,
  `pago_dta_exp` varchar(50) DEFAULT NULL,
  `pago_ieps_exp` varchar(50) DEFAULT NULL,
  `pago_isan_exp` varchar(50) DEFAULT NULL,
  `pago_iva_exp` varchar(50) DEFAULT NULL,
  `pago_recargos_exp` varchar(50) DEFAULT NULL,
  `pago_dti_exp` varchar(50) DEFAULT NULL,
  `pago_bbs_exp` varchar(50) DEFAULT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `opcion_id_tipo` (`opcion_id_tipo`) USING BTREE,
  KEY `opcion_id_pago_dta` (`opcion_id_pago_dta`) USING BTREE,
  CONSTRAINT `clave_pedimento_ibfk_1` FOREIGN KEY (`opcion_id_tipo`) REFERENCES `opcion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `clave_pedimento_ibfk_2` FOREIGN KEY (`opcion_id_pago_dta`) REFERENCES `opcion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=105 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for clave_pedimento_identificador
-- ----------------------------
DROP TABLE IF EXISTS `clave_pedimento_identificador`;
CREATE TABLE `clave_pedimento_identificador` (
  `id` int NOT NULL AUTO_INCREMENT,
  `clave_pedimento_id` int NOT NULL,
  `identificador_id` int NOT NULL,
  `opcion_id_nivel` int NOT NULL,
  `opcion_id_movimiento` int NOT NULL,
  `complemento` varchar(1200) DEFAULT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `clave_pedimento_id` (`clave_pedimento_id`) USING BTREE,
  KEY `identificador_id` (`identificador_id`) USING BTREE,
  KEY `opcion_id_nivel` (`opcion_id_nivel`) USING BTREE,
  KEY `opcion_id_movimiento` (`opcion_id_movimiento`) USING BTREE,
  CONSTRAINT `clave_pedimento_identificador_ibfk_525` FOREIGN KEY (`clave_pedimento_id`) REFERENCES `clave_pedimento` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `clave_pedimento_identificador_ibfk_526` FOREIGN KEY (`identificador_id`) REFERENCES `identificador` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `clave_pedimento_identificador_ibfk_527` FOREIGN KEY (`opcion_id_nivel`) REFERENCES `opcion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `clave_pedimento_identificador_ibfk_528` FOREIGN KEY (`opcion_id_movimiento`) REFERENCES `opcion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for cliente
-- ----------------------------
DROP TABLE IF EXISTS `cliente`;
CREATE TABLE `cliente` (
  `id` int NOT NULL AUTO_INCREMENT,
  `razon_social` varchar(150) NOT NULL,
  `nombre_corto` varchar(50) NOT NULL,
  `tipo_entidad_id` int NOT NULL,
  `opcion_id_empresa` int NOT NULL,
  `opcion_id_tipo_productor` int DEFAULT NULL,
  `actividad_principal` varchar(100) DEFAULT NULL,
  `agencia_usa` varchar(10) DEFAULT NULL,
  `agencia_mx` varchar(10) DEFAULT NULL,
  `rep_legal_nombre` varchar(30) DEFAULT NULL,
  `rep_legal_apPaterno` varchar(30) DEFAULT NULL,
  `rep_legal_apMaterno` varchar(30) DEFAULT NULL,
  `rep_legal_rfc` varchar(15) DEFAULT NULL,
  `rep_legal_curp` varchar(20) DEFAULT NULL,
  `rep_legal_tel` varchar(15) DEFAULT NULL,
  `rep_legal_fax` varchar(15) DEFAULT NULL,
  `rep_legal_email` varchar(40) DEFAULT NULL,
  `opcion_id_rep_puesto` int DEFAULT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  `logo` varchar(500) DEFAULT NULL,
  `opcion_id_procedencia` int DEFAULT NULL,
  `opcion_id_tipo_identificador` int DEFAULT NULL,
  `numero_identificacion` varchar(40) DEFAULT NULL,
  `corporativo` tinyint(1) NOT NULL DEFAULT '0',
  `numero_autorizacion` varchar(15) DEFAULT NULL,
  `metodo_valoracion_id` int NOT NULL DEFAULT '1',
  `tipo_vinculacion_id` int DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `UQ_cliente_razon_social` (`razon_social`) USING BTREE,
  UNIQUE KEY `UQ_cliente_nombre_corto_razon_social_rfc` (`razon_social`,`nombre_corto`) USING BTREE,
  KEY `opcion_id_cliente` (`tipo_entidad_id`) USING BTREE,
  KEY `opcion_id_empresa` (`opcion_id_empresa`) USING BTREE,
  KEY `opcion_id_tipo_productor` (`opcion_id_tipo_productor`) USING BTREE,
  KEY `opcion_id_rep_puesto` (`opcion_id_rep_puesto`) USING BTREE,
  KEY `opcion_id_procedencia` (`opcion_id_procedencia`),
  KEY `opcion_id_tipo_identificador` (`opcion_id_tipo_identificador`),
  KEY `metodo_valoracion_id` (`metodo_valoracion_id`),
  KEY `cliente_tipo_vinculacion_id_foreign_idx` (`tipo_vinculacion_id`),
  CONSTRAINT `cliente_ibfk_542` FOREIGN KEY (`tipo_entidad_id`) REFERENCES `opcion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `cliente_ibfk_543` FOREIGN KEY (`opcion_id_empresa`) REFERENCES `opcion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `cliente_ibfk_544` FOREIGN KEY (`opcion_id_tipo_productor`) REFERENCES `opcion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `cliente_ibfk_545` FOREIGN KEY (`opcion_id_rep_puesto`) REFERENCES `opcion` (`id`),
  CONSTRAINT `cliente_ibfk_546` FOREIGN KEY (`opcion_id_procedencia`) REFERENCES `opcion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `cliente_ibfk_547` FOREIGN KEY (`opcion_id_tipo_identificador`) REFERENCES `opcion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `cliente_ibfk_548` FOREIGN KEY (`metodo_valoracion_id`) REFERENCES `metodo_valoracion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `cliente_ibfk_549` FOREIGN KEY (`tipo_vinculacion_id`) REFERENCES `tipo_vinculacion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=70 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for cliente_certificacion
-- ----------------------------
DROP TABLE IF EXISTS `cliente_certificacion`;
CREATE TABLE `cliente_certificacion` (
  `id` int NOT NULL AUTO_INCREMENT,
  `cliente_id` int NOT NULL,
  `opcion_id_certificacion` int NOT NULL,
  `oficio` varchar(35) NOT NULL,
  `fecha_inicial` date NOT NULL,
  `fecha_vencimiento` date NOT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  `opcion_id_modalidad_rubro` int DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `cliente_id` (`cliente_id`) USING BTREE,
  KEY `opcion_id_certificacion` (`opcion_id_certificacion`) USING BTREE,
  KEY `opcion_id_modalidad_rubro` (`opcion_id_modalidad_rubro`),
  CONSTRAINT `cliente_certificacion_ibfk_334` FOREIGN KEY (`cliente_id`) REFERENCES `cliente` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `cliente_certificacion_ibfk_335` FOREIGN KEY (`opcion_id_certificacion`) REFERENCES `opcion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `cliente_certificacion_ibfk_336` FOREIGN KEY (`opcion_id_modalidad_rubro`) REFERENCES `opcion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for cliente_domicilio
-- ----------------------------
DROP TABLE IF EXISTS `cliente_domicilio`;
CREATE TABLE `cliente_domicilio` (
  `id` int NOT NULL AUTO_INCREMENT,
  `cliente_id` int NOT NULL,
  `almacen` varchar(15) DEFAULT NULL,
  `tipo_domicilio_id` int NOT NULL,
  `calle` varchar(60) NOT NULL,
  `numero_exterior` varchar(10) NOT NULL,
  `numero_interior` varchar(20) DEFAULT NULL,
  `colonia` varchar(50) NOT NULL,
  `codigo_postal` varchar(10) NOT NULL,
  `ciudad` varchar(50) DEFAULT NULL,
  `pais_id` int NOT NULL,
  `municipio_id` int DEFAULT NULL,
  `estado_id` int DEFAULT NULL,
  `codigo_fabricante` varchar(30) DEFAULT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `cliente_id` (`cliente_id`) USING BTREE,
  KEY `opcion_id_tipo` (`tipo_domicilio_id`) USING BTREE,
  KEY `pais_id` (`pais_id`) USING BTREE,
  KEY `municipio_id` (`municipio_id`) USING BTREE,
  KEY `estado_id` (`estado_id`) USING BTREE,
  CONSTRAINT `cliente_domicilio_ibfk_651` FOREIGN KEY (`cliente_id`) REFERENCES `cliente` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `cliente_domicilio_ibfk_652` FOREIGN KEY (`tipo_domicilio_id`) REFERENCES `opcion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `cliente_domicilio_ibfk_653` FOREIGN KEY (`pais_id`) REFERENCES `pais` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `cliente_domicilio_ibfk_654` FOREIGN KEY (`municipio_id`) REFERENCES `municipio` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `cliente_domicilio_ibfk_655` FOREIGN KEY (`estado_id`) REFERENCES `estado` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `cliente_domicilio_ibfk_656` FOREIGN KEY (`tipo_domicilio_id`) REFERENCES `opcion` (`id`),
  CONSTRAINT `cliente_domicilio_ibfk_657` FOREIGN KEY (`pais_id`) REFERENCES `pais` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for cliente_padron_sector
-- ----------------------------
DROP TABLE IF EXISTS `cliente_padron_sector`;
CREATE TABLE `cliente_padron_sector` (
  `id` int NOT NULL AUTO_INCREMENT,
  `cliente_id` int NOT NULL,
  `padron_sector_id` int NOT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  `opcion_tipo_padron_sector_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `cliente_id` (`cliente_id`),
  KEY `padron_sector_id` (`padron_sector_id`),
  KEY `opcion_tipo_padron_sector_id` (`opcion_tipo_padron_sector_id`),
  CONSTRAINT `cliente_padron_sector_ibfk_146` FOREIGN KEY (`cliente_id`) REFERENCES `cliente` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `cliente_padron_sector_ibfk_147` FOREIGN KEY (`padron_sector_id`) REFERENCES `padron_sector` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `cliente_padron_sector_ibfk_148` FOREIGN KEY (`opcion_tipo_padron_sector_id`) REFERENCES `opcion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for cliente_prosec
-- ----------------------------
DROP TABLE IF EXISTS `cliente_prosec`;
CREATE TABLE `cliente_prosec` (
  `id` int NOT NULL AUTO_INCREMENT,
  `cliente_id` int NOT NULL,
  `prosec_id` int NOT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `cliente_id` (`cliente_id`),
  KEY `prosec_id` (`prosec_id`),
  CONSTRAINT `cliente_prosec_ibfk_91` FOREIGN KEY (`cliente_id`) REFERENCES `cliente` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `cliente_prosec_ibfk_92` FOREIGN KEY (`prosec_id`) REFERENCES `prosec` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for codigo_agencia
-- ----------------------------
DROP TABLE IF EXISTS `codigo_agencia`;
CREATE TABLE `codigo_agencia` (
  `id` int NOT NULL AUTO_INCREMENT,
  `cliente_id` int DEFAULT NULL,
  `agencia_id` int DEFAULT NULL,
  `codigo` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cliente_id` (`cliente_id`),
  KEY `agencia_id` (`agencia_id`),
  CONSTRAINT `codigo_agencia_ibfk_133` FOREIGN KEY (`cliente_id`) REFERENCES `cliente` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `codigo_agencia_ibfk_134` FOREIGN KEY (`agencia_id`) REFERENCES `agencia_patente` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=75 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for compania_transportista
-- ----------------------------
DROP TABLE IF EXISTS `compania_transportista`;
CREATE TABLE `compania_transportista` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre_corto` varchar(80) NOT NULL,
  `rfc` varchar(15) NOT NULL,
  `razon_social` varchar(255) NOT NULL,
  `curp` varchar(20) DEFAULT NULL,
  `activo_hasta` date DEFAULT NULL,
  `telefono` varchar(15) DEFAULT NULL,
  `telefono2` varchar(15) DEFAULT NULL,
  `fax` varchar(15) DEFAULT NULL,
  `contacto` varchar(255) DEFAULT NULL,
  `registrada_sat_emp_cer` tinyint(1) NOT NULL DEFAULT '0',
  `calle` varchar(60) DEFAULT NULL,
  `numero_ext` varchar(10) DEFAULT NULL,
  `numero_int` varchar(15) DEFAULT NULL,
  `colonia` varchar(50) DEFAULT NULL,
  `cp` varchar(10) DEFAULT NULL,
  `po_box` varchar(15) DEFAULT NULL,
  `pais_id` int DEFAULT NULL,
  `ciudad` varchar(50) DEFAULT NULL,
  `municipio` varchar(50) DEFAULT NULL,
  `estado_id` int DEFAULT NULL,
  `correo` varchar(50) DEFAULT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  `caat` varchar(15) NOT NULL,
  `scac` varchar(15) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `pais_id` (`pais_id`) USING BTREE,
  KEY `estado_id` (`estado_id`) USING BTREE,
  CONSTRAINT `compania_transportista_ibfk_287` FOREIGN KEY (`pais_id`) REFERENCES `pais` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `compania_transportista_ibfk_288` FOREIGN KEY (`estado_id`) REFERENCES `estado` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for compania_transportista_autorizacion
-- ----------------------------
DROP TABLE IF EXISTS `compania_transportista_autorizacion`;
CREATE TABLE `compania_transportista_autorizacion` (
  `id` int NOT NULL AUTO_INCREMENT,
  `compania_transportista_id` int NOT NULL,
  `nombre` varchar(200) NOT NULL,
  `autorizacion` varchar(10) NOT NULL,
  `fecha_inicio` date NOT NULL,
  `fecha_final` date NOT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  `pais_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UX_compania_transportista_autorizacion` (`compania_transportista_id`,`nombre`,`autorizacion`,`fecha_inicio`,`fecha_final`),
  KEY `pais_id` (`pais_id`),
  CONSTRAINT `compania_transportista_autorizacion_ibfk_1` FOREIGN KEY (`compania_transportista_id`) REFERENCES `compania_transportista` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `compania_transportista_autorizacion_ibfk_2` FOREIGN KEY (`pais_id`) REFERENCES `pais` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for compania_transportista_certificacion
-- ----------------------------
DROP TABLE IF EXISTS `compania_transportista_certificacion`;
CREATE TABLE `compania_transportista_certificacion` (
  `id` int NOT NULL AUTO_INCREMENT,
  `compania_transportista_id` int NOT NULL,
  `nombre` varchar(200) NOT NULL,
  `autorizacion` varchar(10) NOT NULL,
  `fecha_inicio` date NOT NULL,
  `fecha_final` date NOT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  `pais_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UX_compania_transportista_certificacion` (`compania_transportista_id`,`nombre`,`autorizacion`,`fecha_inicio`,`fecha_final`),
  KEY `pais_id` (`pais_id`),
  CONSTRAINT `compania_transportista_certificacion_ibfk_151` FOREIGN KEY (`compania_transportista_id`) REFERENCES `compania_transportista` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `compania_transportista_certificacion_ibfk_152` FOREIGN KEY (`pais_id`) REFERENCES `pais` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for compania_transportista_requerimiento
-- ----------------------------
DROP TABLE IF EXISTS `compania_transportista_requerimiento`;
CREATE TABLE `compania_transportista_requerimiento` (
  `id` int NOT NULL AUTO_INCREMENT,
  `compania_transportista_id` int NOT NULL,
  `tipo_contenedor_id_vehiculo` int NOT NULL,
  `peso_minimo_kg` decimal(19,6) NOT NULL,
  `peso_maximo_kg` decimal(19,6) NOT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `UX_compania_transportista_requerimiento` (`compania_transportista_id`,`tipo_contenedor_id_vehiculo`,`peso_minimo_kg`,`peso_maximo_kg`) USING BTREE,
  KEY `tipo_contenedor_id_vehiculo` (`tipo_contenedor_id_vehiculo`) USING BTREE,
  CONSTRAINT `compania_transportista_requerimiento_ibfk_259` FOREIGN KEY (`compania_transportista_id`) REFERENCES `compania_transportista` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `compania_transportista_requerimiento_ibfk_260` FOREIGN KEY (`tipo_contenedor_id_vehiculo`) REFERENCES `tipo_contenedor` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for configuracion_campo
-- ----------------------------
DROP TABLE IF EXISTS `configuracion_campo`;
CREATE TABLE `configuracion_campo` (
  `id` int NOT NULL AUTO_INCREMENT,
  `modulo` varchar(65) NOT NULL,
  `campo` varchar(85) NOT NULL,
  `tipo` enum('DEFAULT','REQUIRED','MAX','MIN') NOT NULL DEFAULT 'DEFAULT',
  `valor_default` varchar(160) NOT NULL,
  `usuario_id` int DEFAULT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  `valor_texto` varchar(160) DEFAULT '',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=498 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for contenedor
-- ----------------------------
DROP TABLE IF EXISTS `contenedor`;
CREATE TABLE `contenedor` (
  `id` int NOT NULL AUTO_INCREMENT,
  `no_economico` varchar(20) DEFAULT NULL,
  `placas_usa` varchar(15) DEFAULT NULL,
  `estado_usa_id` int DEFAULT NULL,
  `tipo_contenedor_id_mx` int NOT NULL,
  `compania_transportista_id` int NOT NULL,
  `capacidad` int DEFAULT NULL,
  `aceid` varchar(10) DEFAULT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  `placas_mx` varchar(15) DEFAULT NULL,
  `marca` varchar(50) DEFAULT NULL,
  `modelo` varchar(50) DEFAULT NULL,
  `serie` varchar(50) DEFAULT NULL,
  `estado_mx_id` int DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `estado_id_registro` (`estado_usa_id`) USING BTREE,
  KEY `tipo_contenedor_id_mx` (`tipo_contenedor_id_mx`) USING BTREE,
  KEY `compania_transportista_id` (`compania_transportista_id`) USING BTREE,
  KEY `contenedor_estado_mx_id_foreign_idx` (`estado_mx_id`),
  CONSTRAINT `contenedor_estado_mx_id_foreign_idx` FOREIGN KEY (`estado_mx_id`) REFERENCES `estado` (`id`),
  CONSTRAINT `contenedor_ibfk_431` FOREIGN KEY (`estado_usa_id`) REFERENCES `estado` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `contenedor_ibfk_432` FOREIGN KEY (`tipo_contenedor_id_mx`) REFERENCES `tipo_contenedor` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `contenedor_ibfk_433` FOREIGN KEY (`compania_transportista_id`) REFERENCES `compania_transportista` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for contribucion
-- ----------------------------
DROP TABLE IF EXISTS `contribucion`;
CREATE TABLE `contribucion` (
  `id` int NOT NULL AUTO_INCREMENT,
  `clave` varchar(5) NOT NULL,
  `opcion_id_tipo` int NOT NULL,
  `abreviacion` varchar(10) NOT NULL,
  `descripcion` varchar(150) DEFAULT NULL,
  `opcion_id_nivel` int DEFAULT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `opcion_id_tipo` (`opcion_id_tipo`) USING BTREE,
  KEY `opcion_id_nivel` (`opcion_id_nivel`) USING BTREE,
  CONSTRAINT `contribucion_ibfk_1` FOREIGN KEY (`opcion_id_tipo`) REFERENCES `opcion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `contribucion_ibfk_2` FOREIGN KEY (`opcion_id_nivel`) REFERENCES `opcion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for contribucion_fija
-- ----------------------------
DROP TABLE IF EXISTS `contribucion_fija`;
CREATE TABLE `contribucion_fija` (
  `id` int NOT NULL AUTO_INCREMENT,
  `contribucion_id` int NOT NULL,
  `opcion_id_tipo_doc` int NOT NULL,
  `cuota` decimal(19,6) NOT NULL,
  `periodo_inicial` date NOT NULL,
  `periodo_final` date NOT NULL,
  `porcentaje` decimal(19,6) DEFAULT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `contribucion_id` (`contribucion_id`) USING BTREE,
  KEY `opcion_id_tipo_doc` (`opcion_id_tipo_doc`) USING BTREE,
  CONSTRAINT `contribucion_fija_ibfk_253` FOREIGN KEY (`contribucion_id`) REFERENCES `contribucion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `contribucion_fija_ibfk_254` FOREIGN KEY (`opcion_id_tipo_doc`) REFERENCES `opcion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for costo_neto
-- ----------------------------
DROP TABLE IF EXISTS `costo_neto`;
CREATE TABLE `costo_neto` (
  `id` int NOT NULL AUTO_INCREMENT,
  `metodo_valoracion` varchar(5) NOT NULL,
  `supuesto` varchar(250) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for criterio_origen
-- ----------------------------
DROP TABLE IF EXISTS `criterio_origen`;
CREATE TABLE `criterio_origen` (
  `id` int NOT NULL AUTO_INCREMENT,
  `criterio` varchar(1) NOT NULL,
  `supuesto` varchar(500) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for decrementable
-- ----------------------------
DROP TABLE IF EXISTS `decrementable`;
CREATE TABLE `decrementable` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre_esp` varchar(200) NOT NULL,
  `nombre_ing` varchar(200) DEFAULT NULL,
  `opcion_id_tipo` int DEFAULT NULL,
  `es_incrementable` tinyint(1) DEFAULT NULL,
  `entrada` decimal(19,6) DEFAULT NULL,
  `salida` decimal(19,6) DEFAULT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `opcion_id_tipo` (`opcion_id_tipo`),
  CONSTRAINT `decrementable_ibfk_1` FOREIGN KEY (`opcion_id_tipo`) REFERENCES `opcion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for descarga
-- ----------------------------
DROP TABLE IF EXISTS `descarga`;
CREATE TABLE `descarga` (
  `id` int NOT NULL AUTO_INCREMENT,
  `cantidad_descargar` decimal(28,14) NOT NULL,
  `cantidad_faltante` decimal(28,14) NOT NULL,
  `tipo` enum('24','31','AF','BO','CR','EXP') NOT NULL DEFAULT '24',
  `factura_detalle_id` int NOT NULL,
  `estructura_configurable_id` int DEFAULT NULL,
  `pedimento_detalle_id` int DEFAULT NULL,
  `parte_descargada_id` int DEFAULT NULL,
  `medida_descargada_id` int DEFAULT NULL,
  `cantidad_descargada` decimal(28,14) NOT NULL,
  `opcion_id_estatus` int NOT NULL,
  `bom_id` int DEFAULT NULL,
  `bom_padre_id` int DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `factura_detalle_id` (`factura_detalle_id`) USING BTREE,
  KEY `estructura_configurable_id` (`estructura_configurable_id`) USING BTREE,
  KEY `pedimento_detalle_id` (`pedimento_detalle_id`) USING BTREE,
  KEY `parte_descargada_id` (`parte_descargada_id`) USING BTREE,
  KEY `medida_descargada_id` (`medida_descargada_id`) USING BTREE,
  KEY `opcion_id_estatus` (`opcion_id_estatus`) USING BTREE,
  KEY `bom_id` (`bom_id`) USING BTREE,
  KEY `descarga_bom_padre_id_foreign_idx` (`bom_padre_id`) USING BTREE,
  CONSTRAINT `descarga_ibfk_17` FOREIGN KEY (`factura_detalle_id`) REFERENCES `factura_detalle` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `descarga_ibfk_18` FOREIGN KEY (`estructura_configurable_id`) REFERENCES `factura_detalle_estructura_dinamica` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `descarga_ibfk_19` FOREIGN KEY (`pedimento_detalle_id`) REFERENCES `pedimento_detalle` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `descarga_ibfk_20` FOREIGN KEY (`parte_descargada_id`) REFERENCES `parte` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `descarga_ibfk_21` FOREIGN KEY (`medida_descargada_id`) REFERENCES `medida` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `descarga_ibfk_22` FOREIGN KEY (`opcion_id_estatus`) REFERENCES `opcion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `descarga_ibfk_23` FOREIGN KEY (`bom_id`) REFERENCES `bom` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `descarga_ibfk_24` FOREIGN KEY (`bom_padre_id`) REFERENCES `bom` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for descarga_bitacora
-- ----------------------------
DROP TABLE IF EXISTS `descarga_bitacora`;
CREATE TABLE `descarga_bitacora` (
  `id` int NOT NULL AUTO_INCREMENT,
  `accion` enum('CANCEL_DESCARGA','DESCARGA_24','DESCARGA_31','DESCARGA_AF','DESCARGA_BO','DESCARGA_CR','DESCARGA_EXP') DEFAULT NULL,
  `fecha` datetime DEFAULT NULL,
  `ref_info` text,
  `factura_id` int DEFAULT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `factura_id` (`factura_id`),
  CONSTRAINT `descarga_bitacora_ibfk_1` FOREIGN KEY (`factura_id`) REFERENCES `factura` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1885 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for descarga_bo
-- ----------------------------
DROP TABLE IF EXISTS `descarga_bo`;
CREATE TABLE `descarga_bo` (
  `id` int NOT NULL AUTO_INCREMENT,
  `documento_detalle_id_af` int NOT NULL,
  `documento_detalle_id_exp` int NOT NULL,
  `documento_detalle_id_imp` int DEFAULT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  `cantidad` decimal(19,6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `documento_detalle_id_af` (`documento_detalle_id_af`),
  KEY `documento_detalle_id_exp` (`documento_detalle_id_exp`),
  KEY `documento_detalle_id_imp` (`documento_detalle_id_imp`),
  CONSTRAINT `descarga_bo_ibfk_1` FOREIGN KEY (`documento_detalle_id_af`) REFERENCES `documento_detalle` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `descarga_bo_ibfk_2` FOREIGN KEY (`documento_detalle_id_exp`) REFERENCES `documento_detalle` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `descarga_bo_ibfk_3` FOREIGN KEY (`documento_detalle_id_imp`) REFERENCES `documento_detalle` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for destino_mercancia
-- ----------------------------
DROP TABLE IF EXISTS `destino_mercancia`;
CREATE TABLE `destino_mercancia` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(150) NOT NULL,
  `pais_id` int DEFAULT NULL,
  `opcion_id_zona` int DEFAULT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  `clave` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `pais_id` (`pais_id`) USING BTREE,
  KEY `opcion_id_zona` (`opcion_id_zona`) USING BTREE,
  CONSTRAINT `destino_mercancia_ibfk_267` FOREIGN KEY (`pais_id`) REFERENCES `pais` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `destino_mercancia_ibfk_268` FOREIGN KEY (`opcion_id_zona`) REFERENCES `opcion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for empresa_configuracion
-- ----------------------------
DROP TABLE IF EXISTS `empresa_configuracion`;
CREATE TABLE `empresa_configuracion` (
  `id` int NOT NULL AUTO_INCREMENT,
  `empresa_id` int DEFAULT NULL,
  `logout_automatico` tinyint(1) NOT NULL DEFAULT '0',
  `timer_logout_automatico` int DEFAULT '10',
  `descarga_similares` tinyint(1) NOT NULL DEFAULT '0',
  `descarga_order_descarga` varchar(30) NOT NULL,
  `descarga_fecha_saldos` varchar(30) NOT NULL,
  `prioridad_explosion_subensamble` tinyint(1) NOT NULL DEFAULT '0',
  `decimales_fijos` tinyint NOT NULL DEFAULT '4',
  PRIMARY KEY (`id`),
  KEY `empresa_id` (`empresa_id`),
  CONSTRAINT `empresa_configuracion_ibfk_1` FOREIGN KEY (`empresa_id`) REFERENCES `cliente` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for empresa_rubro
-- ----------------------------
DROP TABLE IF EXISTS `empresa_rubro`;
CREATE TABLE `empresa_rubro` (
  `id` int NOT NULL AUTO_INCREMENT,
  `cliente_id` int NOT NULL,
  `opcion_id_rubro` int NOT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `opcion_id_rubro` (`opcion_id_rubro`),
  KEY `AK_relacion_empresa_rubro` (`cliente_id`,`opcion_id_rubro`),
  CONSTRAINT `empresa_rubro_ibfk_1` FOREIGN KEY (`cliente_id`) REFERENCES `cliente` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `empresa_rubro_ibfk_2` FOREIGN KEY (`opcion_id_rubro`) REFERENCES `opcion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for entrada
-- ----------------------------
DROP TABLE IF EXISTS `entrada`;
CREATE TABLE `entrada` (
  `id` int NOT NULL AUTO_INCREMENT,
  `codigo` char(2) NOT NULL,
  `descripcion_ing` varchar(80) NOT NULL,
  `categoria` char(25) NOT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for entry_summary
-- ----------------------------
DROP TABLE IF EXISTS `entry_summary`;
CREATE TABLE `entry_summary` (
  `id` int NOT NULL AUTO_INCREMENT,
  `entry_number` varchar(15) NOT NULL,
  `opcion_id_estatus` int DEFAULT NULL,
  `fecha_alta` date NOT NULL,
  `agencia_patente_id_usa` int DEFAULT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FK_entry_summary_opcion` (`opcion_id_estatus`) USING BTREE,
  KEY `FK_entry_summary_agencia_usa` (`agencia_patente_id_usa`) USING BTREE,
  CONSTRAINT `entry_summary_ibfk_239` FOREIGN KEY (`opcion_id_estatus`) REFERENCES `opcion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `entry_summary_ibfk_240` FOREIGN KEY (`agencia_patente_id_usa`) REFERENCES `agencia` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf16;

-- ----------------------------
-- Table structure for estado
-- ----------------------------
DROP TABLE IF EXISTS `estado`;
CREATE TABLE `estado` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre_corto` varchar(5) NOT NULL,
  `clave_entidad` varchar(5) DEFAULT NULL,
  `pais_id` int DEFAULT NULL,
  `nombre_esp` varchar(150) NOT NULL,
  `nombre_ing` varchar(150) DEFAULT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `pais_id` (`pais_id`) USING BTREE,
  CONSTRAINT `estado_ibfk_1` FOREIGN KEY (`pais_id`) REFERENCES `pais` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for factor_conversion
-- ----------------------------
DROP TABLE IF EXISTS `factor_conversion`;
CREATE TABLE `factor_conversion` (
  `id` int NOT NULL AUTO_INCREMENT,
  `medida_id_uno` int NOT NULL,
  `medida_id_dos` int NOT NULL,
  `factor_conversion` decimal(28,14) NOT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `medida_id_uno` (`medida_id_uno`) USING BTREE,
  KEY `medida_id_dos` (`medida_id_dos`) USING BTREE,
  CONSTRAINT `factor_conversion_ibfk_1` FOREIGN KEY (`medida_id_uno`) REFERENCES `medida` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `factor_conversion_ibfk_2` FOREIGN KEY (`medida_id_dos`) REFERENCES `medida` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=919 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for factura
-- ----------------------------
DROP TABLE IF EXISTS `factura`;
CREATE TABLE `factura` (
  `id` int NOT NULL AUTO_INCREMENT,
  `folio` varchar(25) NOT NULL,
  `agencia_patente_id` int DEFAULT NULL,
  `fecha` date NOT NULL,
  `tipo_cambio` decimal(19,6) NOT NULL,
  `cliente_id_empresa` int NOT NULL,
  `opcion_id_tipo_factura` int DEFAULT NULL,
  `tipo_catalogo_id` int DEFAULT NULL,
  `opcion_id_destino_aduanero` int DEFAULT NULL,
  `folio_destino_aduanero` varchar(25) DEFAULT NULL,
  `opcion_id_estatus` int DEFAULT NULL,
  `pedimento_id` int DEFAULT NULL,
  `clave_pedimento_id` int NOT NULL,
  `compania_transportista_id` int DEFAULT NULL,
  `vehiculo_id` int DEFAULT NULL,
  `chofer_id` int DEFAULT NULL,
  `contenedor_id` int DEFAULT NULL,
  `tracking_number` varchar(100) DEFAULT NULL,
  `num_ruta_GPS` varchar(50) DEFAULT NULL,
  `incoterm_id` int DEFAULT NULL,
  `total_tarima` int DEFAULT NULL,
  `cove` varchar(100) DEFAULT NULL,
  `moneda_id` int DEFAULT NULL,
  `importacion` tinyint(1) NOT NULL DEFAULT '1',
  `usuario_id` int DEFAULT NULL,
  `usuario` varchar(125) DEFAULT NULL,
  `observacion` varchar(1100) DEFAULT NULL,
  `bill_lading` varchar(50) DEFAULT NULL,
  `entry_summary_id` int DEFAULT NULL,
  `contra_parte_v1` varchar(20) DEFAULT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  `cliente_domicilio_id` int DEFAULT NULL,
  `cliente_domicilio_id_proveedor` int DEFAULT NULL,
  `cliente_domicilio_id_destinatario` int DEFAULT NULL,
  `cliente_domicilio_id_remitente` int DEFAULT NULL,
  `cliente_domicilio_id_destino_final` int DEFAULT NULL,
  `opcion_id_envio` int DEFAULT NULL,
  `no_economico_vehiculo` varchar(20) DEFAULT NULL,
  `tipo_vehiculo_id_mx` int DEFAULT NULL,
  `placas_mx_vehiculo` varchar(15) DEFAULT NULL,
  `placas_usa_vehiculo` varchar(15) DEFAULT NULL,
  `estado_usa_vehiculo_id` int DEFAULT NULL,
  `no_economico_contenedor` varchar(20) DEFAULT NULL,
  `placas_usa_contenedor` varchar(15) DEFAULT NULL,
  `tipo_contenedor_mx_id` int DEFAULT NULL,
  `estado_mx_contenedor_id` int DEFAULT NULL,
  `agencia_aduanal_id_usa` int DEFAULT NULL,
  `cliente_id` int DEFAULT NULL,
  `cliente_id_proveedor` int DEFAULT NULL,
  `cliente_id_destinatario` int DEFAULT NULL,
  `cliente_id_remitente` int DEFAULT NULL,
  `cliente_id_destino_final` int DEFAULT NULL,
  `scac` varchar(15) DEFAULT NULL,
  `caat` varchar(15) DEFAULT NULL,
  `puerto_id_carga` int DEFAULT NULL,
  `puerto_id_salida` int DEFAULT NULL,
  `puerto_id_destino` int DEFAULT NULL,
  `puerto_id_entrada` int DEFAULT NULL,
  `instrucciones_envio` varchar(30) DEFAULT NULL,
  `cliente_domicilio_id_empresa` int DEFAULT NULL,
  `cliente_id_importador` int DEFAULT NULL,
  `cliente_domicilio_id_importador` int DEFAULT NULL,
  `cliente_id_vendedor` int DEFAULT NULL,
  `cliente_domicilio_id_vendedor` int DEFAULT NULL,
  `cliente_id_destino_intermedio` int DEFAULT NULL,
  `cliente_domicilio_id_destino_intermedio` int DEFAULT NULL,
  `cliente_id_comprador` int DEFAULT NULL,
  `cliente_domicilio_id_comprador` int DEFAULT NULL,
  `cliente_id_exportador` int DEFAULT NULL,
  `cliente_domicilio_id_exportador` int DEFAULT NULL,
  `cliente_id_productor` int DEFAULT NULL,
  `cliente_domicilio_id_productor` int DEFAULT NULL,
  `regimen_id` int NOT NULL DEFAULT '1',
  `leyenda_mx` varchar(1100) DEFAULT NULL,
  `leyenda_us` varchar(1100) DEFAULT NULL,
  `metodo_valoracion_id` int NOT NULL DEFAULT '1',
  `aduana_seccion_id` int NOT NULL DEFAULT '1',
  `gafete_unico` varchar(24) DEFAULT NULL,
  `fast_id` varchar(24) DEFAULT NULL,
  `placas_mx_contenedor` varchar(15) DEFAULT NULL,
  `estado_mx_vehiculo_id` int DEFAULT NULL,
  `estado_usa_contenedor_id` int DEFAULT NULL,
  `tipo_vinculacion_id` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `UQ_factura_folio` (`folio`,`importacion`),
  KEY `cliente_id_empresa` (`cliente_id_empresa`) USING BTREE,
  KEY `opcion_id_tipo_factura` (`opcion_id_tipo_factura`) USING BTREE,
  KEY `opcion_id_material` (`tipo_catalogo_id`) USING BTREE,
  KEY `opcion_id_destino_aduanero` (`opcion_id_destino_aduanero`) USING BTREE,
  KEY `opcion_id_estatus` (`opcion_id_estatus`) USING BTREE,
  KEY `pedimento_id` (`pedimento_id`) USING BTREE,
  KEY `clave_pedimento_id` (`clave_pedimento_id`) USING BTREE,
  KEY `compania_transportista_id` (`compania_transportista_id`) USING BTREE,
  KEY `vehiculo_id` (`vehiculo_id`) USING BTREE,
  KEY `chofer_id` (`chofer_id`) USING BTREE,
  KEY `contenedor_id` (`contenedor_id`) USING BTREE,
  KEY `incoterm_id` (`incoterm_id`) USING BTREE,
  KEY `moneda_id` (`moneda_id`) USING BTREE,
  KEY `puerto_id_carga` (`puerto_id_carga`) USING BTREE,
  KEY `FK_puerto_destino` (`puerto_id_destino`) USING BTREE,
  KEY `FK_puerto_entrada` (`puerto_id_entrada`) USING BTREE,
  KEY `FK_puerto_salida` (`puerto_id_salida`) USING BTREE,
  KEY `UX_factura_catalogo_performance` (`importacion`,`opcion_id_estatus`,`activo`) USING BTREE,
  KEY `UX_factura_pk_performance` (`id`) USING BTREE,
  KEY `agencia_patente_id` (`agencia_patente_id`) USING BTREE,
  KEY `entry_summary_id` (`entry_summary_id`),
  KEY `cliente_domicilio_id` (`cliente_domicilio_id`),
  KEY `cliente_domicilio_id_proveedor` (`cliente_domicilio_id_proveedor`),
  KEY `cliente_domicilio_id_destinatario` (`cliente_domicilio_id_destinatario`),
  KEY `cliente_domicilio_id_remitente` (`cliente_domicilio_id_remitente`),
  KEY `cliente_domicilio_id_destino_final` (`cliente_domicilio_id_destino_final`),
  KEY `opcion_id_envio` (`opcion_id_envio`),
  KEY `tipo_vehiculo_id_mx` (`tipo_vehiculo_id_mx`),
  KEY `estado_id_usa_vehiculo` (`estado_usa_vehiculo_id`),
  KEY `tipo_contenedor_id_usa` (`tipo_contenedor_mx_id`),
  KEY `estado_id_registro_contenedor` (`estado_mx_contenedor_id`),
  KEY `agencia_aduanal_id_usa` (`agencia_aduanal_id_usa`),
  KEY `cliente_id` (`cliente_id`),
  KEY `cliente_id_proveedor` (`cliente_id_proveedor`),
  KEY `cliente_id_destinatario` (`cliente_id_destinatario`),
  KEY `cliente_id_remitente` (`cliente_id_remitente`),
  KEY `cliente_id_destino_final` (`cliente_id_destino_final`),
  KEY `cliente_domicilio_id_empresa` (`cliente_domicilio_id_empresa`),
  KEY `cliente_id_importador` (`cliente_id_importador`),
  KEY `cliente_domicilio_id_importador` (`cliente_domicilio_id_importador`),
  KEY `cliente_id_vendedor` (`cliente_id_vendedor`),
  KEY `cliente_domicilio_id_vendedor` (`cliente_domicilio_id_vendedor`),
  KEY `cliente_id_destino_intermedio` (`cliente_id_destino_intermedio`),
  KEY `cliente_domicilio_id_destino_intermedio` (`cliente_domicilio_id_destino_intermedio`),
  KEY `cliente_id_comprador` (`cliente_id_comprador`),
  KEY `cliente_domicilio_id_comprador` (`cliente_domicilio_id_comprador`),
  KEY `cliente_id_exportador` (`cliente_id_exportador`),
  KEY `cliente_domicilio_id_exportador` (`cliente_domicilio_id_exportador`),
  KEY `cliente_id_productor` (`cliente_id_productor`),
  KEY `cliente_domicilio_id_productor` (`cliente_domicilio_id_productor`),
  KEY `regimen_id` (`regimen_id`),
  KEY `metodo_valoracion_id` (`metodo_valoracion_id`),
  KEY `aduana_seccion_id` (`aduana_seccion_id`),
  KEY `estado_id_mx_vehiculo` (`estado_mx_vehiculo_id`),
  KEY `estado_id_usa_contenedor` (`estado_usa_contenedor_id`),
  KEY `factura_tipo_vinculacion_id_foreign_idx` (`tipo_vinculacion_id`),
  CONSTRAINT `factura_ibfk_5688` FOREIGN KEY (`agencia_patente_id`) REFERENCES `agencia_patente` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `factura_ibfk_5689` FOREIGN KEY (`cliente_id_empresa`) REFERENCES `cliente` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `factura_ibfk_5690` FOREIGN KEY (`opcion_id_tipo_factura`) REFERENCES `opcion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `factura_ibfk_5691` FOREIGN KEY (`tipo_catalogo_id`) REFERENCES `opcion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `factura_ibfk_5692` FOREIGN KEY (`opcion_id_destino_aduanero`) REFERENCES `opcion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `factura_ibfk_5693` FOREIGN KEY (`opcion_id_estatus`) REFERENCES `opcion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `factura_ibfk_5694` FOREIGN KEY (`pedimento_id`) REFERENCES `pedimento` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `factura_ibfk_5695` FOREIGN KEY (`clave_pedimento_id`) REFERENCES `clave_pedimento` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `factura_ibfk_5696` FOREIGN KEY (`compania_transportista_id`) REFERENCES `compania_transportista` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `factura_ibfk_5697` FOREIGN KEY (`vehiculo_id`) REFERENCES `vehiculo` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `factura_ibfk_5698` FOREIGN KEY (`chofer_id`) REFERENCES `chofer` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `factura_ibfk_5699` FOREIGN KEY (`contenedor_id`) REFERENCES `contenedor` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `factura_ibfk_5700` FOREIGN KEY (`incoterm_id`) REFERENCES `incoterm` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `factura_ibfk_5701` FOREIGN KEY (`moneda_id`) REFERENCES `moneda` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `factura_ibfk_5702` FOREIGN KEY (`entry_summary_id`) REFERENCES `entry_summary` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `factura_ibfk_5703` FOREIGN KEY (`cliente_domicilio_id`) REFERENCES `cliente_domicilio` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `factura_ibfk_5704` FOREIGN KEY (`cliente_domicilio_id_proveedor`) REFERENCES `cliente_domicilio` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `factura_ibfk_5705` FOREIGN KEY (`cliente_domicilio_id_destinatario`) REFERENCES `cliente_domicilio` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `factura_ibfk_5706` FOREIGN KEY (`cliente_domicilio_id_remitente`) REFERENCES `cliente_domicilio` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `factura_ibfk_5707` FOREIGN KEY (`cliente_domicilio_id_destino_final`) REFERENCES `cliente_domicilio` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `factura_ibfk_5708` FOREIGN KEY (`opcion_id_envio`) REFERENCES `opcion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `factura_ibfk_5709` FOREIGN KEY (`tipo_vehiculo_id_mx`) REFERENCES `tipo_vehiculo` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `factura_ibfk_5710` FOREIGN KEY (`estado_usa_vehiculo_id`) REFERENCES `estado` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `factura_ibfk_5711` FOREIGN KEY (`tipo_contenedor_mx_id`) REFERENCES `tipo_contenedor` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `factura_ibfk_5712` FOREIGN KEY (`estado_mx_contenedor_id`) REFERENCES `estado` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `factura_ibfk_5713` FOREIGN KEY (`agencia_aduanal_id_usa`) REFERENCES `agencia` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `factura_ibfk_5714` FOREIGN KEY (`cliente_id`) REFERENCES `cliente` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `factura_ibfk_5715` FOREIGN KEY (`cliente_id_proveedor`) REFERENCES `cliente` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `factura_ibfk_5716` FOREIGN KEY (`cliente_id_destinatario`) REFERENCES `cliente` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `factura_ibfk_5717` FOREIGN KEY (`cliente_id_remitente`) REFERENCES `cliente` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `factura_ibfk_5718` FOREIGN KEY (`cliente_id_destino_final`) REFERENCES `cliente` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `factura_ibfk_5719` FOREIGN KEY (`puerto_id_carga`) REFERENCES `puerto` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `factura_ibfk_5720` FOREIGN KEY (`puerto_id_salida`) REFERENCES `puerto` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `factura_ibfk_5721` FOREIGN KEY (`puerto_id_destino`) REFERENCES `puerto` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `factura_ibfk_5722` FOREIGN KEY (`puerto_id_entrada`) REFERENCES `puerto` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `factura_ibfk_5723` FOREIGN KEY (`cliente_domicilio_id_empresa`) REFERENCES `cliente_domicilio` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `factura_ibfk_5724` FOREIGN KEY (`cliente_id_importador`) REFERENCES `cliente` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `factura_ibfk_5725` FOREIGN KEY (`cliente_domicilio_id_importador`) REFERENCES `cliente_domicilio` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `factura_ibfk_5726` FOREIGN KEY (`cliente_id_vendedor`) REFERENCES `cliente` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `factura_ibfk_5727` FOREIGN KEY (`cliente_domicilio_id_vendedor`) REFERENCES `cliente_domicilio` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `factura_ibfk_5728` FOREIGN KEY (`cliente_id_destino_intermedio`) REFERENCES `cliente` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `factura_ibfk_5729` FOREIGN KEY (`cliente_domicilio_id_destino_intermedio`) REFERENCES `cliente_domicilio` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `factura_ibfk_5730` FOREIGN KEY (`cliente_id_comprador`) REFERENCES `cliente` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `factura_ibfk_5731` FOREIGN KEY (`cliente_domicilio_id_comprador`) REFERENCES `cliente_domicilio` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `factura_ibfk_5732` FOREIGN KEY (`cliente_id_exportador`) REFERENCES `cliente` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `factura_ibfk_5733` FOREIGN KEY (`cliente_domicilio_id_exportador`) REFERENCES `cliente_domicilio` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `factura_ibfk_5734` FOREIGN KEY (`cliente_id_productor`) REFERENCES `cliente` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `factura_ibfk_5735` FOREIGN KEY (`cliente_domicilio_id_productor`) REFERENCES `cliente_domicilio` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `factura_ibfk_5736` FOREIGN KEY (`regimen_id`) REFERENCES `regimen` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `factura_ibfk_5737` FOREIGN KEY (`metodo_valoracion_id`) REFERENCES `metodo_valoracion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `factura_ibfk_5738` FOREIGN KEY (`aduana_seccion_id`) REFERENCES `aduana_seccion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `factura_ibfk_5739` FOREIGN KEY (`estado_mx_vehiculo_id`) REFERENCES `estado` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `factura_ibfk_5740` FOREIGN KEY (`estado_usa_contenedor_id`) REFERENCES `estado` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `factura_ibfk_5741` FOREIGN KEY (`tipo_vinculacion_id`) REFERENCES `tipo_vinculacion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=417 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for factura_decrementable
-- ----------------------------
DROP TABLE IF EXISTS `factura_decrementable`;
CREATE TABLE `factura_decrementable` (
  `id` int NOT NULL AUTO_INCREMENT,
  `factura_id` int NOT NULL,
  `transporte` decimal(19,6) NOT NULL,
  `seguro` decimal(19,6) NOT NULL,
  `carga` decimal(19,6) NOT NULL,
  `descarga` decimal(19,6) NOT NULL,
  `otros` decimal(19,6) NOT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `factura_id` (`factura_id`),
  CONSTRAINT `factura_decrementable_ibfk_1` FOREIGN KEY (`factura_id`) REFERENCES `factura` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=20146 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for factura_detalle
-- ----------------------------
DROP TABLE IF EXISTS `factura_detalle`;
CREATE TABLE `factura_detalle` (
  `id` int NOT NULL AUTO_INCREMENT,
  `factura_id` int DEFAULT NULL,
  `parte_id` int NOT NULL,
  `descripcion_esp` varchar(250) NOT NULL,
  `descripcion_ing` varchar(250) NOT NULL,
  `factor_conversion` decimal(28,14) NOT NULL,
  `pais_id_origen` int NOT NULL,
  `cantidad_empaque` decimal(28,14) DEFAULT NULL,
  `costo_unitario_dll` decimal(28,14) NOT NULL,
  `costo_total_dll` decimal(28,14) NOT NULL,
  `peso_unitario_kg` decimal(28,14) DEFAULT NULL,
  `peso_neto_kg` decimal(28,14) DEFAULT NULL,
  `peso_bruto_kg` decimal(28,14) DEFAULT NULL,
  `tipo_tasa_fraccion_mx_id` int DEFAULT NULL,
  `fraccion_id_mx` int NOT NULL,
  `fraccion_id_usa` int DEFAULT NULL,
  `tipo_material_id` int NOT NULL,
  `observacion` varchar(1100) DEFAULT NULL,
  `lista_embarque_detalle_id` int DEFAULT NULL,
  `secuencia` int NOT NULL DEFAULT '0',
  `tipo_adquisicion_id` int NOT NULL DEFAULT '350',
  `consecutivo_captura` int NOT NULL DEFAULT '1',
  `lote` varchar(20) DEFAULT NULL,
  `orden_compra` varchar(20) DEFAULT NULL,
  `orden_venta` varchar(20) DEFAULT NULL,
  `eccn` varchar(5) DEFAULT NULL,
  `materia_prima_originaria` decimal(28,14) NOT NULL DEFAULT '0.00000000000000',
  `materia_prima_no_originaria` decimal(28,14) NOT NULL DEFAULT '0.00000000000000',
  `empaque_originario` decimal(28,14) NOT NULL DEFAULT '0.00000000000000',
  `empaque_no_originario` decimal(28,14) NOT NULL DEFAULT '0.00000000000000',
  `otros_costos_originario` decimal(28,14) NOT NULL DEFAULT '0.00000000000000',
  `otros_costos_no_originario` decimal(28,14) NOT NULL DEFAULT '0.00000000000000',
  `gasto_directo` decimal(28,14) NOT NULL DEFAULT '0.00000000000000',
  `gasto_indirecto` decimal(28,14) NOT NULL DEFAULT '0.00000000000000',
  `compra_nacional` decimal(28,14) NOT NULL DEFAULT '0.00000000000000',
  `tasa_importacion_mx` varchar(100) NOT NULL,
  `tasa_exportacion_mx` varchar(100) DEFAULT NULL,
  `tasa_importacion_usa` varchar(100) DEFAULT NULL,
  `tasa_exportacion_usa` varchar(100) DEFAULT NULL,
  `opcion_id_tipo_fraccion_mx` int NOT NULL DEFAULT '381',
  `opcion_id_tipo_fraccion_usa` int DEFAULT NULL,
  `opcion_id_tipo_costo` int NOT NULL DEFAULT '364',
  `umc_id` int NOT NULL DEFAULT '19',
  `um_id` int DEFAULT NULL,
  `cantidad_um` decimal(28,14) NOT NULL,
  `cantidad_umc` decimal(28,14) NOT NULL,
  `tipo_empaque_id` int DEFAULT NULL,
  `license` varchar(20) DEFAULT NULL,
  `marca` varchar(50) DEFAULT NULL,
  `modelo` varchar(50) DEFAULT NULL,
  `serie` varchar(50) DEFAULT NULL,
  `fraccion_adicional_id` int DEFAULT NULL,
  `tipo_fraccion_adicional_id` int DEFAULT NULL,
  `certificacion_origen_detalle_id` int DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `factura_id` (`factura_id`) USING BTREE,
  KEY `parte_id` (`parte_id`) USING BTREE,
  KEY `pais_id_origen` (`pais_id_origen`) USING BTREE,
  KEY `opcion_id_tipo_tasa` (`tipo_tasa_fraccion_mx_id`) USING BTREE,
  KEY `fraccion_id_mx` (`fraccion_id_mx`) USING BTREE,
  KEY `fraccion_id_usa` (`fraccion_id_usa`) USING BTREE,
  KEY `tipo_material_id` (`tipo_material_id`) USING BTREE,
  KEY `lista_embarque_detalle_id` (`lista_embarque_detalle_id`) USING BTREE,
  KEY `tipo_adquisicion_id` (`tipo_adquisicion_id`) USING BTREE,
  KEY `opcion_id_tipo_fraccion_mx` (`opcion_id_tipo_fraccion_mx`) USING BTREE,
  KEY `opcion_id_tipo_fraccion_usa` (`opcion_id_tipo_fraccion_usa`) USING BTREE,
  KEY `opcion_id_tipo_costo` (`opcion_id_tipo_costo`) USING BTREE,
  KEY `medida_id_umc` (`umc_id`) USING BTREE,
  KEY `medida_id_um` (`um_id`) USING BTREE,
  KEY `opcion_id_tipo_empaque` (`tipo_empaque_id`) USING BTREE,
  KEY `fraccion_adicional_id` (`fraccion_adicional_id`) USING BTREE,
  KEY `tipo_fraccion_adicional_id` (`tipo_fraccion_adicional_id`) USING BTREE,
  KEY `factura_detalle_certificacion_origen_detalle_id_foreign_idx` (`certificacion_origen_detalle_id`),
  CONSTRAINT `factura_detalle_certificacion_origen_detalle_id_foreign_idx` FOREIGN KEY (`certificacion_origen_detalle_id`) REFERENCES `certificacion_origen_detalle` (`id`),
  CONSTRAINT `factura_detalle_ibfk_1730` FOREIGN KEY (`factura_id`) REFERENCES `factura` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `factura_detalle_ibfk_1731` FOREIGN KEY (`parte_id`) REFERENCES `parte` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `factura_detalle_ibfk_1732` FOREIGN KEY (`pais_id_origen`) REFERENCES `pais` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `factura_detalle_ibfk_1733` FOREIGN KEY (`tipo_tasa_fraccion_mx_id`) REFERENCES `opcion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `factura_detalle_ibfk_1734` FOREIGN KEY (`fraccion_id_mx`) REFERENCES `fraccion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `factura_detalle_ibfk_1735` FOREIGN KEY (`fraccion_id_usa`) REFERENCES `fraccion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `factura_detalle_ibfk_1736` FOREIGN KEY (`tipo_material_id`) REFERENCES `tipo_material` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `factura_detalle_ibfk_1737` FOREIGN KEY (`lista_embarque_detalle_id`) REFERENCES `lista_embarque_detalle` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `factura_detalle_ibfk_1738` FOREIGN KEY (`tipo_adquisicion_id`) REFERENCES `opcion` (`id`),
  CONSTRAINT `factura_detalle_ibfk_1739` FOREIGN KEY (`opcion_id_tipo_fraccion_mx`) REFERENCES `opcion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `factura_detalle_ibfk_1740` FOREIGN KEY (`opcion_id_tipo_fraccion_usa`) REFERENCES `opcion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `factura_detalle_ibfk_1741` FOREIGN KEY (`opcion_id_tipo_costo`) REFERENCES `opcion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `factura_detalle_ibfk_1742` FOREIGN KEY (`umc_id`) REFERENCES `medida` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `factura_detalle_ibfk_1743` FOREIGN KEY (`um_id`) REFERENCES `medida` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `factura_detalle_ibfk_1744` FOREIGN KEY (`tipo_empaque_id`) REFERENCES `opcion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `factura_detalle_ibfk_1745` FOREIGN KEY (`fraccion_adicional_id`) REFERENCES `fraccion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `factura_detalle_ibfk_1746` FOREIGN KEY (`tipo_fraccion_adicional_id`) REFERENCES `opcion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `factura_detalle_ibfk_1747` FOREIGN KEY (`tipo_tasa_fraccion_mx_id`) REFERENCES `opcion` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=527 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for factura_detalle_contribucion
-- ----------------------------
DROP TABLE IF EXISTS `factura_detalle_contribucion`;
CREATE TABLE `factura_detalle_contribucion` (
  `id` int NOT NULL AUTO_INCREMENT,
  `factura_detalle_id` int NOT NULL,
  `contribucion_id` int NOT NULL,
  `forma_pago_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `factura_detalle_id` (`factura_detalle_id`),
  KEY `contribucion_id` (`contribucion_id`),
  KEY `forma_pago_id` (`forma_pago_id`),
  CONSTRAINT `factura_detalle_contribucion_ibfk_25` FOREIGN KEY (`factura_detalle_id`) REFERENCES `factura_detalle` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `factura_detalle_contribucion_ibfk_26` FOREIGN KEY (`contribucion_id`) REFERENCES `contribucion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `factura_detalle_contribucion_ibfk_27` FOREIGN KEY (`forma_pago_id`) REFERENCES `forma_pago` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=106 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for factura_detalle_estructura_dinamica
-- ----------------------------
DROP TABLE IF EXISTS `factura_detalle_estructura_dinamica`;
CREATE TABLE `factura_detalle_estructura_dinamica` (
  `id` int NOT NULL AUTO_INCREMENT,
  `factura_detalle_id` int NOT NULL,
  `parte_id_componente` int NOT NULL,
  `cantidad_um` decimal(28,14) NOT NULL,
  `um_id` int NOT NULL,
  `factor_conversion` decimal(28,14) NOT NULL,
  `cantidad_umc` decimal(28,14) NOT NULL,
  `umc_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `factura_detalle_id` (`factura_detalle_id`),
  KEY `parte_id_componente` (`parte_id_componente`),
  KEY `umc` (`umc_id`),
  KEY `factura_detalle_estructura_dinamica_um_id_foreign_idx` (`um_id`),
  CONSTRAINT `factura_detalle_estructura_dinamica_ibfk_63` FOREIGN KEY (`factura_detalle_id`) REFERENCES `factura_detalle` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `factura_detalle_estructura_dinamica_ibfk_64` FOREIGN KEY (`parte_id_componente`) REFERENCES `parte` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `factura_detalle_estructura_dinamica_ibfk_65` FOREIGN KEY (`umc_id`) REFERENCES `medida` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `factura_detalle_estructura_dinamica_um_id_foreign_idx` FOREIGN KEY (`um_id`) REFERENCES `medida` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1323926 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for factura_detalle_identificador
-- ----------------------------
DROP TABLE IF EXISTS `factura_detalle_identificador`;
CREATE TABLE `factura_detalle_identificador` (
  `id` int NOT NULL AUTO_INCREMENT,
  `factura_detalle_id` int NOT NULL,
  `identificador_id` int NOT NULL,
  `complemento1` varchar(50) DEFAULT NULL,
  `complemento2` varchar(50) DEFAULT NULL,
  `complemento3` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `identificador_id` (`identificador_id`),
  KEY `UX_factura_detalle_identificador_id` (`factura_detalle_id`),
  CONSTRAINT `factura_detalle_identificador_ibfk_151` FOREIGN KEY (`factura_detalle_id`) REFERENCES `factura_detalle` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `factura_detalle_identificador_ibfk_152` FOREIGN KEY (`identificador_id`) REFERENCES `identificador` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=118 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for factura_identificador
-- ----------------------------
DROP TABLE IF EXISTS `factura_identificador`;
CREATE TABLE `factura_identificador` (
  `id` int NOT NULL AUTO_INCREMENT,
  `factura_id` int NOT NULL,
  `identificador_id` int DEFAULT NULL,
  `complemento1` varchar(50) DEFAULT NULL,
  `complemento2` varchar(50) DEFAULT NULL,
  `complemento3` varchar(50) DEFAULT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `factura_id` (`factura_id`) USING BTREE,
  KEY `identificador_id` (`identificador_id`) USING BTREE,
  CONSTRAINT `factura_identificador_ibfk_147` FOREIGN KEY (`factura_id`) REFERENCES `factura` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `factura_identificador_ibfk_148` FOREIGN KEY (`identificador_id`) REFERENCES `identificador` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=143 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for factura_incrementable
-- ----------------------------
DROP TABLE IF EXISTS `factura_incrementable`;
CREATE TABLE `factura_incrementable` (
  `id` int NOT NULL AUTO_INCREMENT,
  `factura_id` int NOT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  `val_seguros` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `seguro` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `fletes` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `embalaje` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `otros` decimal(19,6) NOT NULL DEFAULT '0.000000',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `factura_id` (`factura_id`) USING BTREE,
  CONSTRAINT `factura_incrementable_ibfk_1` FOREIGN KEY (`factura_id`) REFERENCES `factura` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=20237 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for factura_sello_fiscal
-- ----------------------------
DROP TABLE IF EXISTS `factura_sello_fiscal`;
CREATE TABLE `factura_sello_fiscal` (
  `id` int NOT NULL AUTO_INCREMENT,
  `factura_id` int NOT NULL,
  `sello_fiscal_id` int NOT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  `primario` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `factura_id` (`factura_id`) USING BTREE,
  KEY `sello_fiscal_id` (`sello_fiscal_id`) USING BTREE,
  CONSTRAINT `factura_sello_fiscal_ibfk_147` FOREIGN KEY (`factura_id`) REFERENCES `factura` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `factura_sello_fiscal_ibfk_148` FOREIGN KEY (`sello_fiscal_id`) REFERENCES `sello_fiscal` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=168 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for forma_pago
-- ----------------------------
DROP TABLE IF EXISTS `forma_pago`;
CREATE TABLE `forma_pago` (
  `id` int NOT NULL AUTO_INCREMENT,
  `clave_m3` varchar(5) NOT NULL,
  `descripcion_esp` varchar(250) NOT NULL,
  `descripcion_ing` varchar(250) NOT NULL,
  `moneda_id` int DEFAULT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `moneda_id` (`moneda_id`) USING BTREE,
  CONSTRAINT `forma_pago_ibfk_1` FOREIGN KEY (`moneda_id`) REFERENCES `moneda` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for fraccion
-- ----------------------------
DROP TABLE IF EXISTS `fraccion`;
CREATE TABLE `fraccion` (
  `id` int NOT NULL AUTO_INCREMENT,
  `fraccion` varchar(13) NOT NULL,
  `fraccion_puntos` varchar(15) DEFAULT NULL,
  `descripcion` text NOT NULL,
  `medida_id` int DEFAULT NULL,
  `tasa_importacion` varchar(200) DEFAULT NULL,
  `tasa_exportacion` varchar(200) DEFAULT NULL,
  `iva_especial_interior` int DEFAULT NULL,
  `iva_especial_frontera` int DEFAULT NULL,
  `tasa_mixta` decimal(10,6) DEFAULT NULL,
  `arancel_especifico` varchar(35) DEFAULT NULL,
  `fecha_actualizacion_dof` date DEFAULT NULL,
  `fecha_actualizacion_tiggie` date NOT NULL,
  `opcion_id_tipo_arancel` int DEFAULT NULL,
  `unidad_cantidad_americana` varchar(150) DEFAULT NULL,
  `tasa_americana_1` varchar(450) DEFAULT NULL,
  `tasa_americana_2` varchar(450) DEFAULT NULL,
  `tlc_americano` varchar(400) DEFAULT NULL,
  `mexicana` tinyint(1) NOT NULL DEFAULT '1',
  `obsoleta` tinyint(1) NOT NULL DEFAULT '0',
  `nico` varchar(13) DEFAULT NULL,
  `num_tasa_importacion` decimal(10,6) DEFAULT NULL,
  `num_tasa_exportacion` decimal(10,6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UX_fraccion` (`fraccion`),
  KEY `UX_index_id` (`id`) USING BTREE,
  KEY `medida_id` (`medida_id`),
  KEY `opcion_id_tipo_arancel` (`opcion_id_tipo_arancel`),
  CONSTRAINT `fraccion_ibfk_77` FOREIGN KEY (`medida_id`) REFERENCES `medida` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fraccion_ibfk_78` FOREIGN KEY (`opcion_id_tipo_arancel`) REFERENCES `opcion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1697562 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for fraccion_anexo
-- ----------------------------
DROP TABLE IF EXISTS `fraccion_anexo`;
CREATE TABLE `fraccion_anexo` (
  `id` int NOT NULL AUTO_INCREMENT,
  `fraccion_id` int NOT NULL,
  `anexo` varchar(100) NOT NULL,
  `regimen` varchar(100) NOT NULL,
  `condicion` varchar(1000) NOT NULL,
  `adunanas` varchar(100) DEFAULT NULL,
  `dof` date NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fraccion_id` (`fraccion_id`),
  CONSTRAINT `fraccion_anexo_ibfk_1` FOREIGN KEY (`fraccion_id`) REFERENCES `fraccion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21737 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for fraccion_desglose_tasa
-- ----------------------------
DROP TABLE IF EXISTS `fraccion_desglose_tasa`;
CREATE TABLE `fraccion_desglose_tasa` (
  `id` int NOT NULL AUTO_INCREMENT,
  `fraccion_id` int NOT NULL,
  `tipo` varchar(25) NOT NULL,
  `tasa` varchar(100) NOT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `fraccion_id` (`fraccion_id`),
  CONSTRAINT `fraccion_desglose_tasa_ibfk_1` FOREIGN KEY (`fraccion_id`) REFERENCES `fraccion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=134236 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for fraccion_informacion
-- ----------------------------
DROP TABLE IF EXISTS `fraccion_informacion`;
CREATE TABLE `fraccion_informacion` (
  `id` int NOT NULL AUTO_INCREMENT,
  `fraccion_id` int NOT NULL,
  `tipo` enum('IMPORTACION','EXPORTACION','OBSERVACION') NOT NULL DEFAULT 'IMPORTACION',
  `leyenda` text NOT NULL,
  `nota` text,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `fraccion_id` (`fraccion_id`),
  CONSTRAINT `fraccion_informacion_ibfk_1` FOREIGN KEY (`fraccion_id`) REFERENCES `fraccion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=297751 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for fraccion_prosec
-- ----------------------------
DROP TABLE IF EXISTS `fraccion_prosec`;
CREATE TABLE `fraccion_prosec` (
  `id` int NOT NULL AUTO_INCREMENT,
  `fraccion_id` int NOT NULL,
  `articulo` varchar(25) NOT NULL,
  `sector` varchar(25) NOT NULL,
  `descripcion` text NOT NULL,
  `observacion` text,
  `tasa` varchar(15) NOT NULL,
  `fecha_actualizacion_dof` date DEFAULT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `fraccion_id` (`fraccion_id`),
  CONSTRAINT `fraccion_prosec_ibfk_1` FOREIGN KEY (`fraccion_id`) REFERENCES `fraccion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=33586 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for fraccion_regulacion
-- ----------------------------
DROP TABLE IF EXISTS `fraccion_regulacion`;
CREATE TABLE `fraccion_regulacion` (
  `id` int NOT NULL AUTO_INCREMENT,
  `fraccion_id` int NOT NULL,
  `acuerdo` varchar(85) NOT NULL,
  `complemento` varchar(65) NOT NULL,
  `condicion` text NOT NULL,
  `fundamento` text NOT NULL,
  `criterio` text NOT NULL,
  `fecha_actualizacion_dof` date DEFAULT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `fraccion_id` (`fraccion_id`),
  CONSTRAINT `fraccion_regulacion_ibfk_1` FOREIGN KEY (`fraccion_id`) REFERENCES `fraccion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=76062 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for fraccion_requisito
-- ----------------------------
DROP TABLE IF EXISTS `fraccion_requisito`;
CREATE TABLE `fraccion_requisito` (
  `id` int NOT NULL AUTO_INCREMENT,
  `fraccion_id` int NOT NULL,
  `permiso` varchar(25) NOT NULL,
  `descripcion` text NOT NULL,
  `observacion` text,
  `nota` text NOT NULL,
  `fecha_actualizacion_dof` date DEFAULT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `fraccion_id` (`fraccion_id`),
  CONSTRAINT `fraccion_requisito_ibfk_1` FOREIGN KEY (`fraccion_id`) REFERENCES `fraccion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16285 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for fraccion_resumen
-- ----------------------------
DROP TABLE IF EXISTS `fraccion_resumen`;
CREATE TABLE `fraccion_resumen` (
  `id` int NOT NULL AUTO_INCREMENT,
  `fraccion_id` int NOT NULL,
  `title` varchar(35) NOT NULL,
  `descripcion` text NOT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `fraccion_id` (`fraccion_id`),
  CONSTRAINT `fraccion_resumen_ibfk_1` FOREIGN KEY (`fraccion_id`) REFERENCES `fraccion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=193280 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for fraccion_sensible
-- ----------------------------
DROP TABLE IF EXISTS `fraccion_sensible`;
CREATE TABLE `fraccion_sensible` (
  `id` int NOT NULL AUTO_INCREMENT,
  `fraccion` varchar(13) NOT NULL,
  `anexo` varchar(20) NOT NULL,
  `fecha_inicial` date NOT NULL,
  `fecha_final` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1560 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for fraccion_tasa
-- ----------------------------
DROP TABLE IF EXISTS `fraccion_tasa`;
CREATE TABLE `fraccion_tasa` (
  `id` int NOT NULL AUTO_INCREMENT,
  `fraccion_id` int NOT NULL,
  `tipo` enum('IVA','IEPS','OTRO') NOT NULL DEFAULT 'IVA',
  `fundamento` text NOT NULL,
  `condicion` text,
  `tasa` varchar(15) NOT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `fraccion_id` (`fraccion_id`),
  CONSTRAINT `fraccion_tasa_ibfk_1` FOREIGN KEY (`fraccion_id`) REFERENCES `fraccion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3031 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for fraccion_tratado
-- ----------------------------
DROP TABLE IF EXISTS `fraccion_tratado`;
CREATE TABLE `fraccion_tratado` (
  `id` int NOT NULL AUTO_INCREMENT,
  `fraccion_id` int NOT NULL,
  `pais_clave` varchar(5) NOT NULL,
  `descripcion` text,
  `notas` varchar(800) NOT NULL,
  `tasa` varchar(100) NOT NULL,
  `tratado` enum('TLC','TIPAT','ALADI') NOT NULL DEFAULT 'TLC',
  `fecha_actualizacion_dof` date DEFAULT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UX_fraccion_tratado` (`fraccion_id`,`pais_clave`,`tasa`,`tratado`),
  CONSTRAINT `fraccion_tratado_ibfk_1` FOREIGN KEY (`fraccion_id`) REFERENCES `fraccion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1032546 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for identificador
-- ----------------------------
DROP TABLE IF EXISTS `identificador`;
CREATE TABLE `identificador` (
  `id` int NOT NULL AUTO_INCREMENT,
  `clave` char(2) NOT NULL,
  `descripcion` varchar(400) NOT NULL,
  `nivel` char(1) NOT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  `supuesto_aplicacion` varchar(1800) DEFAULT NULL,
  `complemento_1` varchar(5000) DEFAULT NULL,
  `complemento_2` varchar(5000) DEFAULT NULL,
  `complemento_3` varchar(5000) DEFAULT NULL,
  `tipo_operacion_id` int DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `identificador_tipo_operacion_id_foreign_idx` (`tipo_operacion_id`),
  CONSTRAINT `identificador_ibfk_1` FOREIGN KEY (`tipo_operacion_id`) REFERENCES `opcion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=203 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for incoterm
-- ----------------------------
DROP TABLE IF EXISTS `incoterm`;
CREATE TABLE `incoterm` (
  `id` int NOT NULL AUTO_INCREMENT,
  `clave` varchar(3) NOT NULL,
  `descripcion_esp` varchar(250) NOT NULL,
  `descripcion_ing` varchar(250) NOT NULL,
  `opcion_id_tipo` int DEFAULT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  `vigencia` date NOT NULL DEFAULT '9999-01-01',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `opcion_id_tipo` (`opcion_id_tipo`) USING BTREE,
  CONSTRAINT `incoterm_ibfk_1` FOREIGN KEY (`opcion_id_tipo`) REFERENCES `opcion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for incrementable
-- ----------------------------
DROP TABLE IF EXISTS `incrementable`;
CREATE TABLE `incrementable` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre_esp` varchar(200) NOT NULL,
  `nombre_ing` varchar(200) DEFAULT NULL,
  `opcion_id_tipo` int DEFAULT NULL,
  `es_incrementable` tinyint(1) DEFAULT NULL,
  `entrada` decimal(19,6) DEFAULT NULL,
  `salida` decimal(19,6) DEFAULT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `opcion_id_tipo` (`opcion_id_tipo`) USING BTREE,
  CONSTRAINT `incrementable_ibfk_1` FOREIGN KEY (`opcion_id_tipo`) REFERENCES `opcion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for inpc
-- ----------------------------
DROP TABLE IF EXISTS `inpc`;
CREATE TABLE `inpc` (
  `id` int NOT NULL AUTO_INCREMENT,
  `anio` int NOT NULL,
  `mes` int unsigned NOT NULL,
  `fecha_inicio` date NOT NULL,
  `cantidad_inpc` decimal(19,6) NOT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for lista_embarque
-- ----------------------------
DROP TABLE IF EXISTS `lista_embarque`;
CREATE TABLE `lista_embarque` (
  `id` int NOT NULL AUTO_INCREMENT,
  `folio` varchar(25) NOT NULL,
  `fecha` date NOT NULL,
  `cliente_id_empresa` int NOT NULL,
  `tipo_catalogo_id` int NOT NULL,
  `importacion` tinyint(1) NOT NULL DEFAULT '0',
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  `total_tarima` int DEFAULT NULL,
  `clave_pedimento_id` int DEFAULT NULL,
  `pedimento_id` int DEFAULT NULL,
  `comentario` varchar(1100) DEFAULT NULL,
  `cliente_id_proveedor` int DEFAULT NULL,
  `cliente_id_importador` int DEFAULT NULL,
  `cliente_id_vendedor` int DEFAULT NULL,
  `cliente_id_destino_intermedio` int DEFAULT NULL,
  `cliente_id_comprador` int DEFAULT NULL,
  `cliente_id_exportador` int DEFAULT NULL,
  `cliente_id_productor` int DEFAULT NULL,
  `cliente_id_destino_final` int DEFAULT NULL,
  `chofer_id` int DEFAULT NULL,
  `compania_transportista_id` int DEFAULT NULL,
  `contenedor_id` int DEFAULT NULL,
  `no_economico_contenedor` varchar(20) DEFAULT NULL,
  `vehiculo_id` int DEFAULT NULL,
  `no_economico_vehiculo` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `cliente_id_empresa` (`cliente_id_empresa`) USING BTREE,
  KEY `opcion_id_material` (`tipo_catalogo_id`) USING BTREE,
  KEY `clave_pedimento_id` (`clave_pedimento_id`),
  KEY `pedimento_id` (`pedimento_id`),
  KEY `cliente_id_proveedor` (`cliente_id_proveedor`),
  KEY `cliente_id_importador` (`cliente_id_importador`),
  KEY `cliente_id_vendedor` (`cliente_id_vendedor`),
  KEY `cliente_id_destino_intermedio` (`cliente_id_destino_intermedio`),
  KEY `cliente_id_comprador` (`cliente_id_comprador`),
  KEY `cliente_id_exportador` (`cliente_id_exportador`),
  KEY `cliente_id_productor` (`cliente_id_productor`),
  KEY `cliente_id_destino_final` (`cliente_id_destino_final`),
  KEY `chofer_id` (`chofer_id`),
  KEY `compania_transportista_id` (`compania_transportista_id`),
  KEY `contenedor_id` (`contenedor_id`),
  KEY `vehiculo_id` (`vehiculo_id`),
  CONSTRAINT `lista_embarque_ibfk_1162` FOREIGN KEY (`cliente_id_empresa`) REFERENCES `cliente` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `lista_embarque_ibfk_1163` FOREIGN KEY (`tipo_catalogo_id`) REFERENCES `opcion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `lista_embarque_ibfk_1164` FOREIGN KEY (`clave_pedimento_id`) REFERENCES `clave_pedimento` (`id`),
  CONSTRAINT `lista_embarque_ibfk_1165` FOREIGN KEY (`pedimento_id`) REFERENCES `pedimento` (`id`),
  CONSTRAINT `lista_embarque_ibfk_1166` FOREIGN KEY (`cliente_id_proveedor`) REFERENCES `cliente` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `lista_embarque_ibfk_1167` FOREIGN KEY (`cliente_id_importador`) REFERENCES `cliente` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `lista_embarque_ibfk_1168` FOREIGN KEY (`cliente_id_vendedor`) REFERENCES `cliente` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `lista_embarque_ibfk_1169` FOREIGN KEY (`cliente_id_destino_intermedio`) REFERENCES `cliente` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `lista_embarque_ibfk_1170` FOREIGN KEY (`cliente_id_comprador`) REFERENCES `cliente` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `lista_embarque_ibfk_1171` FOREIGN KEY (`cliente_id_exportador`) REFERENCES `cliente` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `lista_embarque_ibfk_1172` FOREIGN KEY (`cliente_id_productor`) REFERENCES `cliente` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `lista_embarque_ibfk_1173` FOREIGN KEY (`cliente_id_destino_final`) REFERENCES `cliente` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `lista_embarque_ibfk_1174` FOREIGN KEY (`chofer_id`) REFERENCES `chofer` (`id`),
  CONSTRAINT `lista_embarque_ibfk_1175` FOREIGN KEY (`compania_transportista_id`) REFERENCES `compania_transportista` (`id`),
  CONSTRAINT `lista_embarque_ibfk_1176` FOREIGN KEY (`contenedor_id`) REFERENCES `contenedor` (`id`),
  CONSTRAINT `lista_embarque_ibfk_1177` FOREIGN KEY (`vehiculo_id`) REFERENCES `vehiculo` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for lista_embarque_detalle
-- ----------------------------
DROP TABLE IF EXISTS `lista_embarque_detalle`;
CREATE TABLE `lista_embarque_detalle` (
  `id` int NOT NULL AUTO_INCREMENT,
  `lista_embarque_id` int NOT NULL,
  `parte_id` int NOT NULL,
  `descripcion` varchar(250) DEFAULT NULL,
  `descripcion_ing` varchar(250) DEFAULT NULL,
  `cantidad` decimal(19,6) NOT NULL,
  `cantidad_saldo` decimal(19,6) NOT NULL,
  `tipo_material_id` int DEFAULT NULL,
  `medida_id` int NOT NULL,
  `medida_id_mx` int NOT NULL,
  `factor_conversion` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `fraccion_id_mx` int NOT NULL DEFAULT '1',
  `tipo_empaque_id` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `lista_embarque_id` (`lista_embarque_id`) USING BTREE,
  KEY `parte_id` (`parte_id`) USING BTREE,
  KEY `tipo_material_id` (`tipo_material_id`) USING BTREE,
  KEY `medida_id` (`medida_id`) USING BTREE,
  KEY `medida_id_mx` (`medida_id_mx`) USING BTREE,
  KEY `fraccion_id_mx` (`fraccion_id_mx`),
  KEY `tipo_empaque_id` (`tipo_empaque_id`),
  CONSTRAINT `lista_embarque_detalle_ibfk_596` FOREIGN KEY (`lista_embarque_id`) REFERENCES `lista_embarque` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `lista_embarque_detalle_ibfk_597` FOREIGN KEY (`parte_id`) REFERENCES `parte` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `lista_embarque_detalle_ibfk_598` FOREIGN KEY (`tipo_material_id`) REFERENCES `tipo_material` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `lista_embarque_detalle_ibfk_599` FOREIGN KEY (`medida_id`) REFERENCES `medida` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `lista_embarque_detalle_ibfk_600` FOREIGN KEY (`medida_id_mx`) REFERENCES `medida` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `lista_embarque_detalle_ibfk_601` FOREIGN KEY (`fraccion_id_mx`) REFERENCES `fraccion` (`id`),
  CONSTRAINT `lista_embarque_detalle_ibfk_602` FOREIGN KEY (`tipo_empaque_id`) REFERENCES `opcion` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for lista_embarque_sello_fiscal
-- ----------------------------
DROP TABLE IF EXISTS `lista_embarque_sello_fiscal`;
CREATE TABLE `lista_embarque_sello_fiscal` (
  `id` int NOT NULL AUTO_INCREMENT,
  `lista_embarque_id` int NOT NULL,
  `sello_fiscal_id` int NOT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  `primario` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `lista_embarque_id` (`lista_embarque_id`),
  KEY `sello_fiscal_id` (`sello_fiscal_id`),
  CONSTRAINT `lista_embarque_sello_fiscal_ibfk_121` FOREIGN KEY (`lista_embarque_id`) REFERENCES `lista_embarque` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `lista_embarque_sello_fiscal_ibfk_122` FOREIGN KEY (`sello_fiscal_id`) REFERENCES `sello_fiscal` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for material_peligroso
-- ----------------------------
DROP TABLE IF EXISTS `material_peligroso`;
CREATE TABLE `material_peligroso` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(100) NOT NULL,
  `numero_nu` varchar(10) NOT NULL,
  `numero_cas` varchar(15) DEFAULT NULL,
  `clase_peligrosidad` varchar(5) NOT NULL,
  `descripcion_clase_peligrosidad` varchar(100) NOT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for medida
-- ----------------------------
DROP TABLE IF EXISTS `medida`;
CREATE TABLE `medida` (
  `id` int NOT NULL AUTO_INCREMENT,
  `clave` varchar(15) NOT NULL,
  `clave_esp` varchar(15) NOT NULL,
  `descripcion_esp` varchar(150) NOT NULL,
  `descripcion_ing` varchar(150) NOT NULL,
  `saai_m3` int DEFAULT NULL,
  `iso` varchar(15) DEFAULT NULL,
  `id_sicex` int DEFAULT NULL,
  `descripcion_sicex` varchar(150) DEFAULT NULL,
  `sched_b` varchar(15) DEFAULT NULL,
  `clave_oma` varchar(50) DEFAULT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=185 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for medio_transporte
-- ----------------------------
DROP TABLE IF EXISTS `medio_transporte`;
CREATE TABLE `medio_transporte` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descripcion_esp` varchar(100) NOT NULL,
  `descripcion_ing` varchar(100) NOT NULL,
  `clave_ped` varchar(5) DEFAULT NULL,
  `clave_usa` varchar(5) DEFAULT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for metodo_valoracion
-- ----------------------------
DROP TABLE IF EXISTS `metodo_valoracion`;
CREATE TABLE `metodo_valoracion` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(150) NOT NULL,
  `clave` int NOT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for moneda
-- ----------------------------
DROP TABLE IF EXISTS `moneda`;
CREATE TABLE `moneda` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descripcion_esp` varchar(150) NOT NULL,
  `descripcion_ing` varchar(150) NOT NULL,
  `saai_m3` varchar(5) DEFAULT NULL,
  `oma` varchar(5) DEFAULT NULL,
  `simbolo` varchar(5) DEFAULT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=95 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for municipio
-- ----------------------------
DROP TABLE IF EXISTS `municipio`;
CREATE TABLE `municipio` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(150) NOT NULL,
  `clave_ent` int NOT NULL,
  `estado_id` int NOT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `estado_id` (`estado_id`) USING BTREE,
  CONSTRAINT `municipio_ibfk_1` FOREIGN KEY (`estado_id`) REFERENCES `estado` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2562 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for opcion
-- ----------------------------
DROP TABLE IF EXISTS `opcion`;
CREATE TABLE `opcion` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre_tabla` varchar(50) NOT NULL,
  `nombre_campo` varchar(50) NOT NULL,
  `descripcion_esp` varchar(200) NOT NULL,
  `descripcion_ing` varchar(200) NOT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=410 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for padron_sector
-- ----------------------------
DROP TABLE IF EXISTS `padron_sector`;
CREATE TABLE `padron_sector` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(150) NOT NULL,
  `opcion_tipo_padron_sector_id` int NOT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `opcion_tipo_padron_sector_id` (`opcion_tipo_padron_sector_id`),
  CONSTRAINT `padron_sector_ibfk_1` FOREIGN KEY (`opcion_tipo_padron_sector_id`) REFERENCES `opcion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for pais
-- ----------------------------
DROP TABLE IF EXISTS `pais`;
CREATE TABLE `pais` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre_corto` varchar(15) NOT NULL,
  `descripcion_esp` varchar(150) NOT NULL,
  `descripcion_ing` varchar(150) NOT NULL,
  `clave_saai_fill` varchar(5) DEFAULT NULL,
  `codigo_iso` varchar(15) DEFAULT NULL,
  `clave_saai_m3` varchar(5) DEFAULT NULL,
  `codigo_permiso` int DEFAULT NULL,
  `tratado_id` int DEFAULT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `tratado_id` (`tratado_id`) USING BTREE,
  CONSTRAINT `pais_ibfk_1` FOREIGN KEY (`tratado_id`) REFERENCES `tratado` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=267 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for pais_moneda
-- ----------------------------
DROP TABLE IF EXISTS `pais_moneda`;
CREATE TABLE `pais_moneda` (
  `id` int NOT NULL AUTO_INCREMENT,
  `pais_id` int NOT NULL,
  `moneda_id` int NOT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `pais_id` (`pais_id`) USING BTREE,
  KEY `moneda_id` (`moneda_id`) USING BTREE,
  CONSTRAINT `pais_moneda_ibfk_139` FOREIGN KEY (`pais_id`) REFERENCES `pais` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `pais_moneda_ibfk_140` FOREIGN KEY (`moneda_id`) REFERENCES `moneda` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=161 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for paqueteria
-- ----------------------------
DROP TABLE IF EXISTS `paqueteria`;
CREATE TABLE `paqueteria` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `descripcion` varchar(210) NOT NULL,
  `URL` varchar(78) DEFAULT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for parte
-- ----------------------------
DROP TABLE IF EXISTS `parte`;
CREATE TABLE `parte` (
  `id` int NOT NULL AUTO_INCREMENT,
  `noparte` varchar(50) NOT NULL,
  `tipo_material_id` int DEFAULT NULL,
  `descripcion_esp` varchar(250) NOT NULL,
  `descripcion_ing` varchar(250) NOT NULL,
  `peso_unitario_kg` decimal(19,6) NOT NULL,
  `medida_id_mx` int DEFAULT NULL,
  `pais_id_origen` int DEFAULT NULL,
  `eccn` varchar(5) DEFAULT NULL,
  `fecha_ultima_modificacion` date DEFAULT NULL,
  `fecha_creacion` date NOT NULL,
  `marca` varchar(50) DEFAULT NULL,
  `modelo` varchar(50) DEFAULT NULL,
  `serie` varchar(50) DEFAULT NULL,
  `numero_activo` varchar(50) DEFAULT NULL,
  `ubicacion` varchar(50) DEFAULT NULL,
  `vida_util` int DEFAULT NULL,
  `etiqueto` varchar(50) DEFAULT NULL,
  `foto` varchar(500) DEFAULT NULL,
  `tipo_catalogo_id` int NOT NULL,
  `medida_id_extranjera` int NOT NULL,
  `factor_conversion` decimal(19,6) NOT NULL,
  `costo_unitario_dll` decimal(19,6) NOT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  `tipo_adquisicion_id` int DEFAULT NULL,
  `peso_libras` decimal(19,6) NOT NULL,
  `ext_art_25` tinyint(1) DEFAULT '0',
  `comentario_foto` varchar(250) DEFAULT NULL,
  `fecha_carga_foto` date DEFAULT NULL,
  `prosec_id_tasa` int DEFAULT NULL,
  `licence` varchar(20) DEFAULT NULL,
  `numero_nu` varchar(4) DEFAULT NULL,
  `numero_cas` varchar(10) DEFAULT NULL,
  `division_clase` decimal(2,1) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `UQ_numero_parte` (`noparte`) USING BTREE,
  KEY `medida_id_mx` (`medida_id_mx`) USING BTREE,
  KEY `pais_id_origen` (`pais_id_origen`) USING BTREE,
  KEY `opcion_id_material` (`tipo_catalogo_id`) USING BTREE,
  KEY `medida_id_extranjera` (`medida_id_extranjera`) USING BTREE,
  KEY `tipo_material_id` (`tipo_material_id`) USING BTREE,
  KEY `UX_parte_pk_performance` (`id`) USING BTREE,
  KEY `parte_prosec_id_tasa_foreign_idx` (`prosec_id_tasa`),
  KEY `tipo_adquisicion_id` (`tipo_adquisicion_id`),
  CONSTRAINT `parte_ibfk_1846` FOREIGN KEY (`tipo_material_id`) REFERENCES `tipo_material` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `parte_ibfk_1847` FOREIGN KEY (`medida_id_mx`) REFERENCES `medida` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `parte_ibfk_1848` FOREIGN KEY (`pais_id_origen`) REFERENCES `pais` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `parte_ibfk_1849` FOREIGN KEY (`tipo_catalogo_id`) REFERENCES `opcion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `parte_ibfk_1850` FOREIGN KEY (`medida_id_extranjera`) REFERENCES `medida` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `parte_ibfk_1851` FOREIGN KEY (`tipo_adquisicion_id`) REFERENCES `opcion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `parte_ibfk_1852` FOREIGN KEY (`prosec_id_tasa`) REFERENCES `prosec` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=460 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for parte_bc
-- ----------------------------
DROP TABLE IF EXISTS `parte_bc`;
CREATE TABLE `parte_bc` (
  `id` int NOT NULL AUTO_INCREMENT,
  `noparte` varchar(50) NOT NULL,
  `descripcion_esp` varchar(250) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=459 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for parte_bitacora
-- ----------------------------
DROP TABLE IF EXISTS `parte_bitacora`;
CREATE TABLE `parte_bitacora` (
  `id` int NOT NULL AUTO_INCREMENT,
  `parte_id` int NOT NULL,
  `campo` tinyint(1) NOT NULL,
  `valor_anterior` date NOT NULL,
  `valor_nuevo` date NOT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `parte_id` (`parte_id`) USING BTREE,
  CONSTRAINT `parte_bitacora_ibfk_1` FOREIGN KEY (`parte_id`) REFERENCES `parte` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for parte_cliente
-- ----------------------------
DROP TABLE IF EXISTS `parte_cliente`;
CREATE TABLE `parte_cliente` (
  `id` int NOT NULL AUTO_INCREMENT,
  `parte_id` int NOT NULL,
  `cliente_id` int NOT NULL,
  `pais_id_origen` int DEFAULT NULL,
  `fraccion_nadalisa` varchar(13) DEFAULT NULL,
  `fraccion_taric` varchar(13) DEFAULT NULL,
  `no_parte_prov` varchar(50) DEFAULT NULL,
  `costo_unitario_dll` decimal(19,6) DEFAULT NULL,
  `medida_id_mx` int NOT NULL,
  `medida_id_extranjera` int NOT NULL,
  `factor_conversion` decimal(19,6) DEFAULT NULL,
  `mano_obra_gravable` decimal(19,6) DEFAULT NULL,
  `mano_obra_no_gravable` decimal(19,6) DEFAULT NULL,
  `materia_prima_gravable` decimal(19,6) DEFAULT NULL,
  `materia_prima_no_gravable` decimal(19,6) DEFAULT NULL,
  `empaque_gravable` decimal(19,6) DEFAULT NULL,
  `empaque_no_gravable` decimal(19,6) DEFAULT NULL,
  `gasto_indirecto_gravable` decimal(19,6) DEFAULT NULL,
  `gasto_indirecto_no_gravable` decimal(19,6) DEFAULT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `parte_id` (`parte_id`),
  KEY `cliente_id` (`cliente_id`),
  KEY `pais_id_origen` (`pais_id_origen`),
  KEY `medida_id_mx` (`medida_id_mx`),
  KEY `medida_id_extranjera` (`medida_id_extranjera`),
  CONSTRAINT `parte_cliente_ibfk_1` FOREIGN KEY (`parte_id`) REFERENCES `parte` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `parte_cliente_ibfk_2` FOREIGN KEY (`cliente_id`) REFERENCES `cliente` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `parte_cliente_ibfk_3` FOREIGN KEY (`pais_id_origen`) REFERENCES `pais` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `parte_cliente_ibfk_4` FOREIGN KEY (`medida_id_mx`) REFERENCES `medida` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `parte_cliente_ibfk_5` FOREIGN KEY (`medida_id_extranjera`) REFERENCES `medida` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for parte_configuracion
-- ----------------------------
DROP TABLE IF EXISTS `parte_configuracion`;
CREATE TABLE `parte_configuracion` (
  `id` int NOT NULL AUTO_INCREMENT,
  `parte_id` int NOT NULL,
  `nacional` tinyint(1) NOT NULL,
  `ensamblado` tinyint(1) NOT NULL,
  `medida_id_peso` int NOT NULL,
  `pais_id_origen` int NOT NULL,
  `pais_id_procedencia` int NOT NULL,
  `ext_art_303` tinyint(1) NOT NULL,
  `gravable` tinyint(1) NOT NULL,
  `fantasma` tinyint(1) NOT NULL,
  `analisis_nafta` tinyint(1) NOT NULL,
  `tratado_id` int NOT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  `prosec_id_tasa` int NOT NULL,
  `tipo_tasa_ids` int NOT NULL,
  `tipo_tasa_id` int DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `parte_id` (`parte_id`) USING BTREE,
  KEY `medida_id_peso` (`medida_id_peso`) USING BTREE,
  KEY `pais_id_origen` (`pais_id_origen`) USING BTREE,
  KEY `pais_id_procedencia` (`pais_id_procedencia`) USING BTREE,
  KEY `tratado_id` (`tratado_id`) USING BTREE,
  KEY `parte_configuracion_prosec_id_tasa_foreign_idx` (`prosec_id_tasa`),
  KEY `parte_configuracion_tipo_tasa_ids_foreign_idx` (`tipo_tasa_ids`),
  KEY `parte_configuracion_tipo_tasa_id_foreign_idx` (`tipo_tasa_id`),
  CONSTRAINT `parte_configuracion_ibfk_476` FOREIGN KEY (`parte_id`) REFERENCES `parte` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `parte_configuracion_ibfk_477` FOREIGN KEY (`medida_id_peso`) REFERENCES `medida` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `parte_configuracion_ibfk_478` FOREIGN KEY (`pais_id_origen`) REFERENCES `pais` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `parte_configuracion_ibfk_479` FOREIGN KEY (`pais_id_procedencia`) REFERENCES `pais` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `parte_configuracion_ibfk_480` FOREIGN KEY (`tratado_id`) REFERENCES `tratado` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `parte_configuracion_ibfk_481` FOREIGN KEY (`prosec_id_tasa`) REFERENCES `prosec` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `parte_configuracion_tipo_tasa_id_foreign_idx` FOREIGN KEY (`tipo_tasa_id`) REFERENCES `opcion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `parte_configuracion_tipo_tasa_ids_foreign_idx` FOREIGN KEY (`tipo_tasa_ids`) REFERENCES `opcion` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for parte_costo
-- ----------------------------
DROP TABLE IF EXISTS `parte_costo`;
CREATE TABLE `parte_costo` (
  `id` int NOT NULL AUTO_INCREMENT,
  `parte_id` int NOT NULL,
  `costo` decimal(28,14) NOT NULL DEFAULT '0.00000000000000',
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  `fecha_inicial` date NOT NULL DEFAULT '2021-09-06',
  `fecha_final` date NOT NULL DEFAULT '9999-12-30',
  `materia_prima_originaria` decimal(28,14) NOT NULL DEFAULT '0.00000000000000',
  `materia_prima_no_originaria` decimal(28,14) NOT NULL DEFAULT '0.00000000000000',
  `empaque_originario` decimal(28,14) NOT NULL DEFAULT '0.00000000000000',
  `empaque_no_originario` decimal(28,14) NOT NULL DEFAULT '0.00000000000000',
  `otros_costos_originario` decimal(28,14) NOT NULL DEFAULT '0.00000000000000',
  `otros_costos_no_originario` decimal(28,14) NOT NULL DEFAULT '0.00000000000000',
  `gasto_directo` decimal(28,14) NOT NULL DEFAULT '0.00000000000000',
  `gasto_indirecto` decimal(28,14) NOT NULL DEFAULT '0.00000000000000',
  `compra_nacional` decimal(28,14) NOT NULL DEFAULT '0.00000000000000',
  `proveedor_id` int DEFAULT NULL,
  `opcion_id_tipo_costo` int NOT NULL DEFAULT '364',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `parte_id` (`parte_id`) USING BTREE,
  KEY `proveedor_id` (`proveedor_id`) USING BTREE,
  KEY `opcion_id_tipo_costo` (`opcion_id_tipo_costo`) USING BTREE,
  CONSTRAINT `parte_costo_ibfk_106` FOREIGN KEY (`parte_id`) REFERENCES `parte` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `parte_costo_ibfk_107` FOREIGN KEY (`proveedor_id`) REFERENCES `cliente` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `parte_costo_ibfk_108` FOREIGN KEY (`opcion_id_tipo_costo`) REFERENCES `opcion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=372 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for parte_fda
-- ----------------------------
DROP TABLE IF EXISTS `parte_fda`;
CREATE TABLE `parte_fda` (
  `id` int NOT NULL AUTO_INCREMENT,
  `parte_id` int NOT NULL,
  `fda_product_code` char(15) DEFAULT NULL,
  `opcion_id_fda_storage` int DEFAULT NULL,
  `pais_id_fda_country_code` int DEFAULT NULL,
  `manufacturerid` varchar(50) DEFAULT NULL,
  `opcion_id_fcc_import_condition` int DEFAULT NULL,
  `fcc_identifier` varchar(20) DEFAULT NULL,
  `fcc_public_inspection` tinyint(1) NOT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `parte_id` (`parte_id`) USING BTREE,
  KEY `opcion_id_fda_storage` (`opcion_id_fda_storage`) USING BTREE,
  KEY `pais_id_fda_country_code` (`pais_id_fda_country_code`) USING BTREE,
  KEY `opcion_id_fcc_import_condition` (`opcion_id_fcc_import_condition`) USING BTREE,
  CONSTRAINT `parte_fda_ibfk_265` FOREIGN KEY (`parte_id`) REFERENCES `parte` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `parte_fda_ibfk_266` FOREIGN KEY (`opcion_id_fda_storage`) REFERENCES `opcion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `parte_fda_ibfk_267` FOREIGN KEY (`pais_id_fda_country_code`) REFERENCES `pais` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `parte_fda_ibfk_268` FOREIGN KEY (`opcion_id_fcc_import_condition`) REFERENCES `opcion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for parte_fda_afirmacion
-- ----------------------------
DROP TABLE IF EXISTS `parte_fda_afirmacion`;
CREATE TABLE `parte_fda_afirmacion` (
  `id` int NOT NULL AUTO_INCREMENT,
  `parte_fda_id` int NOT NULL,
  `opcion_id_aff_compliance_code` int NOT NULL,
  `aff_compliance_qualifier` varchar(25) NOT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `parte_fda_id` (`parte_fda_id`) USING BTREE,
  KEY `opcion_id_aff_compliance_code` (`opcion_id_aff_compliance_code`) USING BTREE,
  KEY `UX_parte_fda_afirmacion_fdaid` (`parte_fda_id`) USING BTREE,
  CONSTRAINT `parte_fda_afirmacion_ibfk_133` FOREIGN KEY (`parte_fda_id`) REFERENCES `parte_fda` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `parte_fda_afirmacion_ibfk_134` FOREIGN KEY (`opcion_id_aff_compliance_code`) REFERENCES `opcion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for parte_fraccion
-- ----------------------------
DROP TABLE IF EXISTS `parte_fraccion`;
CREATE TABLE `parte_fraccion` (
  `id` int NOT NULL AUTO_INCREMENT,
  `opcion_id_tarifa` int NOT NULL,
  `parte_id` int DEFAULT NULL,
  `opcion_id_tipo_fraccion` int NOT NULL,
  `opcion_id_tipo_operacion` int NOT NULL,
  `fraccion_id` int NOT NULL,
  `umc` int NOT NULL,
  `factor_conversion` decimal(28,14) NOT NULL,
  `umt` int DEFAULT NULL,
  `tasa_importacion` varchar(100) DEFAULT NULL,
  `tasa_exportacion` varchar(100) DEFAULT NULL,
  `no_grava_iva` tinyint(1) NOT NULL DEFAULT '0',
  `ieps` tinyint(1) NOT NULL DEFAULT '0',
  `fecha_inicio` date NOT NULL,
  `fecha_final` date NOT NULL,
  PRIMARY KEY (`id`),
  KEY `opcion_id_tarifa` (`opcion_id_tarifa`),
  KEY `parte_id` (`parte_id`),
  KEY `opcion_id_tipo_fraccion` (`opcion_id_tipo_fraccion`),
  KEY `opcion_id_tipo_operacion` (`opcion_id_tipo_operacion`),
  KEY `fraccion_id` (`fraccion_id`),
  KEY `umc` (`umc`),
  KEY `umt` (`umt`),
  CONSTRAINT `parte_fraccion_ibfk_175` FOREIGN KEY (`opcion_id_tarifa`) REFERENCES `opcion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `parte_fraccion_ibfk_176` FOREIGN KEY (`parte_id`) REFERENCES `parte` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `parte_fraccion_ibfk_177` FOREIGN KEY (`opcion_id_tipo_fraccion`) REFERENCES `opcion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `parte_fraccion_ibfk_178` FOREIGN KEY (`opcion_id_tipo_operacion`) REFERENCES `opcion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `parte_fraccion_ibfk_179` FOREIGN KEY (`fraccion_id`) REFERENCES `fraccion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `parte_fraccion_ibfk_180` FOREIGN KEY (`umc`) REFERENCES `medida` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `parte_fraccion_ibfk_181` FOREIGN KEY (`umt`) REFERENCES `medida` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=524 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for parte_identificador
-- ----------------------------
DROP TABLE IF EXISTS `parte_identificador`;
CREATE TABLE `parte_identificador` (
  `id` int NOT NULL AUTO_INCREMENT,
  `parte_id` int NOT NULL,
  `identificador_id` int DEFAULT NULL,
  `complemento1` varchar(50) DEFAULT NULL,
  `complemento2` varchar(50) DEFAULT NULL,
  `complemento3` varchar(50) DEFAULT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `parte_id` (`parte_id`),
  KEY `identificador_id` (`identificador_id`),
  CONSTRAINT `parte_identificador_ibfk_25` FOREIGN KEY (`parte_id`) REFERENCES `parte` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `parte_identificador_ibfk_26` FOREIGN KEY (`identificador_id`) REFERENCES `identificador` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for parte_material_prohibido
-- ----------------------------
DROP TABLE IF EXISTS `parte_material_prohibido`;
CREATE TABLE `parte_material_prohibido` (
  `id` int NOT NULL AUTO_INCREMENT,
  `parte_id` int NOT NULL,
  `prohibido` tinyint(1) NOT NULL,
  `fecha_inicial` date NOT NULL,
  `fecha_final` date NOT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `parte_id` (`parte_id`),
  CONSTRAINT `parte_material_prohibido_ibfk_1` FOREIGN KEY (`parte_id`) REFERENCES `parte` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for parte_material_suspendido
-- ----------------------------
DROP TABLE IF EXISTS `parte_material_suspendido`;
CREATE TABLE `parte_material_suspendido` (
  `id` int NOT NULL AUTO_INCREMENT,
  `parte_id` int NOT NULL,
  `comentario` varchar(1100) DEFAULT NULL,
  `fecha_inicial` date NOT NULL,
  `fecha_final` date NOT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `parte_id` (`parte_id`),
  CONSTRAINT `parte_material_suspendido_ibfk_1` FOREIGN KEY (`parte_id`) REFERENCES `parte` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for parte_preferencia_arancelaria
-- ----------------------------
DROP TABLE IF EXISTS `parte_preferencia_arancelaria`;
CREATE TABLE `parte_preferencia_arancelaria` (
  `id` int NOT NULL AUTO_INCREMENT,
  `parte_id` int NOT NULL,
  `bajo_tratado` tinyint NOT NULL DEFAULT '1',
  `regla_octava` tinyint NOT NULL DEFAULT '2',
  `pps` tinyint NOT NULL DEFAULT '3',
  `general` tinyint NOT NULL DEFAULT '4',
  PRIMARY KEY (`id`),
  KEY `parte_id` (`parte_id`),
  CONSTRAINT `parte_preferencia_arancelaria_ibfk_1` FOREIGN KEY (`parte_id`) REFERENCES `parte` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=353 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for parte_similar
-- ----------------------------
DROP TABLE IF EXISTS `parte_similar`;
CREATE TABLE `parte_similar` (
  `id` int NOT NULL AUTO_INCREMENT,
  `parte_id` int DEFAULT NULL,
  `orden` int DEFAULT NULL,
  `parte_id_similar` int DEFAULT NULL,
  `parte_id_producto` int DEFAULT NULL,
  `factor_conversion` decimal(19,6) DEFAULT NULL,
  `fecha_inicial` date DEFAULT NULL,
  `fecha_final` date DEFAULT NULL,
  `activo` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `parte_id` (`parte_id`) USING BTREE,
  KEY `parte_id_similar` (`parte_id_similar`) USING BTREE,
  KEY `parte_id_producto` (`parte_id_producto`) USING BTREE,
  CONSTRAINT `parte_similar_ibfk_1` FOREIGN KEY (`parte_id`) REFERENCES `parte` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `parte_similar_ibfk_2` FOREIGN KEY (`parte_id_similar`) REFERENCES `parte` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `parte_similar_ibfk_3` FOREIGN KEY (`parte_id_producto`) REFERENCES `parte` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for parte_similar_ptsub
-- ----------------------------
DROP TABLE IF EXISTS `parte_similar_ptsub`;
CREATE TABLE `parte_similar_ptsub` (
  `id` int NOT NULL AUTO_INCREMENT,
  `parte_similar_id` int DEFAULT NULL,
  `activo` tinyint(1) DEFAULT '1',
  `parte_ptsub_id` int DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `parte_similar_id` (`parte_similar_id`) USING BTREE,
  KEY `parte_ptsub_id` (`parte_ptsub_id`) USING BTREE,
  CONSTRAINT `parte_similar_ptsub_ibfk_47` FOREIGN KEY (`parte_similar_id`) REFERENCES `parte_similar` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `parte_similar_ptsub_ibfk_48` FOREIGN KEY (`parte_ptsub_id`) REFERENCES `parte` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for pedimento
-- ----------------------------
DROP TABLE IF EXISTS `pedimento`;
CREATE TABLE `pedimento` (
  `id` int NOT NULL AUTO_INCREMENT,
  `agencia_patente_id` int NOT NULL,
  `numero_pedimento` varchar(7) NOT NULL,
  `clave_pedimento_id` int NOT NULL,
  `importacion` tinyint(1) NOT NULL DEFAULT '1',
  `regimen_id` int NOT NULL,
  `fecha_pago` date DEFAULT NULL,
  `tipo_cambio` decimal(19,6) DEFAULT NULL,
  `opcion_id_estatus` int DEFAULT NULL,
  `cliente_id_empresa` int DEFAULT NULL,
  `tipo_catalogo_id` int DEFAULT NULL,
  `total_bulto` int DEFAULT '0',
  `valor_aduana` decimal(19,6) DEFAULT NULL,
  `peso_total_bruto_kg` decimal(19,6) DEFAULT NULL,
  `numero_operacion` varchar(10) DEFAULT NULL,
  `semana` int DEFAULT NULL,
  `contra_parte_v1` varchar(20) DEFAULT NULL,
  `destino_mercancia_id` int DEFAULT NULL,
  `pedimento_id_rectificado` int DEFAULT NULL,
  `usuario_id` int DEFAULT NULL,
  `consolidado` tinyint(1) NOT NULL DEFAULT '0',
  `observacion` varchar(1100) DEFAULT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  `clave_pedimento_id_nueva` int DEFAULT NULL,
  `codigo_aceptacion` varchar(8) DEFAULT NULL,
  `linea_captura` varchar(20) DEFAULT NULL,
  `medio_transporte_arribo_id` int DEFAULT NULL,
  `medio_transporte_salida_id` int DEFAULT NULL,
  `numero_transaccion_sat` int DEFAULT NULL,
  `medio_presentacion` varchar(50) DEFAULT NULL,
  `medio_recepcion_cobro` varchar(50) DEFAULT NULL,
  `aduana_seccion_entrada_salida_id` int NOT NULL DEFAULT '15',
  `aduana_seccion_despacho_id` int DEFAULT NULL,
  `valor_dll` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `valor_comercial` decimal(19,6) DEFAULT NULL,
  `institucion_bancaria` varchar(50) DEFAULT NULL,
  `fecha_presentacion` date NOT NULL DEFAULT '2021-01-01',
  `medio_transporte_entrada_salida_id` int DEFAULT NULL,
  `fecha_entrada` date NOT NULL DEFAULT '2020-01-01',
  `factor_prorrateo` decimal(28,14) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `pedimento_id_rectificado` (`pedimento_id_rectificado`) USING BTREE,
  KEY `agencia_patente_id` (`agencia_patente_id`) USING BTREE,
  KEY `clave_pedimento_id` (`clave_pedimento_id`) USING BTREE,
  KEY `regimen_id` (`regimen_id`) USING BTREE,
  KEY `opcion_id_estatus` (`opcion_id_estatus`) USING BTREE,
  KEY `cliente_id_empresa` (`cliente_id_empresa`) USING BTREE,
  KEY `opcion_id_material` (`tipo_catalogo_id`) USING BTREE,
  KEY `destino_mercancia_id` (`destino_mercancia_id`) USING BTREE,
  KEY `UX_pedimento_catalogo_performance` (`importacion`,`opcion_id_estatus`,`activo`) USING BTREE,
  KEY `UX_pedimento_pk_performance` (`id`) USING BTREE,
  KEY `clave_pedimento_id_nueva` (`clave_pedimento_id_nueva`) USING BTREE,
  KEY `medio_transporte_arribo_id` (`medio_transporte_arribo_id`),
  KEY `medio_transporte_salida_id` (`medio_transporte_salida_id`),
  KEY `aduana_seccion_entrada_salida_id` (`aduana_seccion_entrada_salida_id`),
  KEY `aduana_seccion_despacho_id` (`aduana_seccion_despacho_id`),
  KEY `medio_transporte_entrada_salida_id` (`medio_transporte_entrada_salida_id`),
  CONSTRAINT `pedimento_ibfk_15` FOREIGN KEY (`agencia_patente_id`) REFERENCES `agencia_patente` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `pedimento_ibfk_16` FOREIGN KEY (`clave_pedimento_id`) REFERENCES `clave_pedimento` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `pedimento_ibfk_17` FOREIGN KEY (`regimen_id`) REFERENCES `regimen` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `pedimento_ibfk_18` FOREIGN KEY (`opcion_id_estatus`) REFERENCES `opcion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `pedimento_ibfk_19` FOREIGN KEY (`cliente_id_empresa`) REFERENCES `cliente` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `pedimento_ibfk_20` FOREIGN KEY (`tipo_catalogo_id`) REFERENCES `opcion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `pedimento_ibfk_21` FOREIGN KEY (`destino_mercancia_id`) REFERENCES `destino_mercancia` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `pedimento_ibfk_22` FOREIGN KEY (`pedimento_id_rectificado`) REFERENCES `pedimento` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `pedimento_ibfk_23` FOREIGN KEY (`clave_pedimento_id_nueva`) REFERENCES `clave_pedimento` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `pedimento_ibfk_24` FOREIGN KEY (`medio_transporte_arribo_id`) REFERENCES `medio_transporte` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `pedimento_ibfk_25` FOREIGN KEY (`medio_transporte_salida_id`) REFERENCES `medio_transporte` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `pedimento_ibfk_26` FOREIGN KEY (`aduana_seccion_entrada_salida_id`) REFERENCES `aduana_seccion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `pedimento_ibfk_27` FOREIGN KEY (`aduana_seccion_despacho_id`) REFERENCES `aduana_seccion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `pedimento_ibfk_28` FOREIGN KEY (`medio_transporte_entrada_salida_id`) REFERENCES `medio_transporte` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=299 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for pedimento_agrupacion_saai
-- ----------------------------
DROP TABLE IF EXISTS `pedimento_agrupacion_saai`;
CREATE TABLE `pedimento_agrupacion_saai` (
  `id` int NOT NULL AUTO_INCREMENT,
  `pedimento_id` int NOT NULL,
  `fraccion_id_mx` int NOT NULL,
  `fraccion_id_usa` int NOT NULL,
  `descripcion_esp` varchar(250) NOT NULL,
  `descripcion_ing` varchar(250) NOT NULL,
  `medida_id_tarifa` int NOT NULL,
  `cantidad` decimal(19,6) NOT NULL,
  `costo_unitario_mx` decimal(19,6) NOT NULL,
  `pais_id_origen` int NOT NULL,
  `secuencia` int NOT NULL DEFAULT '0',
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `pedimento_id` (`pedimento_id`) USING BTREE,
  KEY `fraccion_id_mx` (`fraccion_id_mx`) USING BTREE,
  KEY `fraccion_id_usa` (`fraccion_id_usa`) USING BTREE,
  KEY `medida_id_tarifa` (`medida_id_tarifa`) USING BTREE,
  KEY `pais_id_origen` (`pais_id_origen`) USING BTREE,
  CONSTRAINT `pedimento_agrupacion_saai_ibfk_391` FOREIGN KEY (`pedimento_id`) REFERENCES `pedimento` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `pedimento_agrupacion_saai_ibfk_392` FOREIGN KEY (`fraccion_id_mx`) REFERENCES `fraccion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `pedimento_agrupacion_saai_ibfk_393` FOREIGN KEY (`fraccion_id_usa`) REFERENCES `fraccion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `pedimento_agrupacion_saai_ibfk_394` FOREIGN KEY (`medida_id_tarifa`) REFERENCES `medida` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `pedimento_agrupacion_saai_ibfk_395` FOREIGN KEY (`pais_id_origen`) REFERENCES `pais` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for pedimento_cuadro_liquidacion
-- ----------------------------
DROP TABLE IF EXISTS `pedimento_cuadro_liquidacion`;
CREATE TABLE `pedimento_cuadro_liquidacion` (
  `id` int NOT NULL AUTO_INCREMENT,
  `pedimento_id` int NOT NULL,
  `contribucion_id` int NOT NULL,
  `importe_mn` decimal(19,6) NOT NULL,
  `forma_pago_id` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `pedimento_id` (`pedimento_id`) USING BTREE,
  KEY `contribucion_id` (`contribucion_id`) USING BTREE,
  KEY `forma_pago_id` (`forma_pago_id`) USING BTREE,
  CONSTRAINT `pedimento_cuadro_liquidacion_ibfk_199` FOREIGN KEY (`pedimento_id`) REFERENCES `pedimento` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `pedimento_cuadro_liquidacion_ibfk_200` FOREIGN KEY (`contribucion_id`) REFERENCES `contribucion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `pedimento_cuadro_liquidacion_ibfk_201` FOREIGN KEY (`forma_pago_id`) REFERENCES `forma_pago` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for pedimento_cuenta_aduanera
-- ----------------------------
DROP TABLE IF EXISTS `pedimento_cuenta_aduanera`;
CREATE TABLE `pedimento_cuenta_aduanera` (
  `id` int NOT NULL AUTO_INCREMENT,
  `pedimento_id` int NOT NULL,
  `numero_cuenta` varchar(20) NOT NULL,
  `opcion_id_cuenta` int NOT NULL,
  `institucion_emisora` varchar(50) NOT NULL,
  `opcion_id_garantia` int DEFAULT NULL,
  `folio_constancia` varchar(20) DEFAULT NULL,
  `fecha_constancia` date DEFAULT NULL,
  `deposito_total` decimal(19,6) DEFAULT NULL,
  `titulo_asignado` decimal(19,6) NOT NULL,
  `cantidad` decimal(19,6) NOT NULL,
  `valor_unitario` decimal(19,6) NOT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `pedimento_id` (`pedimento_id`) USING BTREE,
  KEY `opcion_id_cuenta` (`opcion_id_cuenta`) USING BTREE,
  KEY `opcion_id_garantia` (`opcion_id_garantia`) USING BTREE,
  CONSTRAINT `pedimento_cuenta_aduanera_ibfk_199` FOREIGN KEY (`pedimento_id`) REFERENCES `pedimento` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `pedimento_cuenta_aduanera_ibfk_200` FOREIGN KEY (`opcion_id_cuenta`) REFERENCES `opcion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `pedimento_cuenta_aduanera_ibfk_201` FOREIGN KEY (`opcion_id_garantia`) REFERENCES `opcion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for pedimento_decrementable
-- ----------------------------
DROP TABLE IF EXISTS `pedimento_decrementable`;
CREATE TABLE `pedimento_decrementable` (
  `id` int NOT NULL AUTO_INCREMENT,
  `pedimento_id` int NOT NULL,
  `transporte` decimal(19,6) NOT NULL,
  `seguro` decimal(19,6) NOT NULL,
  `carga` decimal(19,6) NOT NULL,
  `descarga` decimal(19,6) NOT NULL,
  `otros` decimal(19,6) NOT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `pedimento_id` (`pedimento_id`),
  CONSTRAINT `pedimento_decrementable_ibfk_1` FOREIGN KEY (`pedimento_id`) REFERENCES `pedimento` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6002 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for pedimento_detalle
-- ----------------------------
DROP TABLE IF EXISTS `pedimento_detalle`;
CREATE TABLE `pedimento_detalle` (
  `id` int NOT NULL AUTO_INCREMENT,
  `factura_detalle_id` int DEFAULT NULL,
  `pedimento_id` int DEFAULT NULL,
  `parte_id` int NOT NULL,
  `descripcion_esp` varchar(250) NOT NULL,
  `umc_id` int NOT NULL,
  `umt_id` int DEFAULT NULL,
  `valor_aduana` decimal(28,14) DEFAULT NULL,
  `factor_conversion` decimal(28,14) NOT NULL,
  `factor_conversion_tarifa` decimal(28,14) DEFAULT NULL,
  `pais_id_origen` int NOT NULL,
  `cantidad_umc` decimal(28,14) DEFAULT NULL,
  `cantidad_umt` decimal(28,14) DEFAULT NULL,
  `costo_unitario_mx` decimal(28,14) DEFAULT NULL,
  `costo_total_mx` decimal(28,14) DEFAULT NULL,
  `peso_unitario_kg` decimal(28,14) DEFAULT NULL,
  `peso_neto_kg` decimal(28,14) DEFAULT NULL,
  `peso_bruto_kg` decimal(28,14) DEFAULT NULL,
  `peso_total_kg` decimal(28,14) DEFAULT NULL,
  `valor_agregado` decimal(28,14) DEFAULT NULL,
  `tipo_tasa_fraccion_mx_id` int DEFAULT NULL,
  `fraccion_id_mx` int NOT NULL,
  `tipo_material_id` int NOT NULL,
  `observacion` varchar(1100) DEFAULT NULL,
  `secuencia` int NOT NULL DEFAULT '0',
  `opcion_id_estatus` int NOT NULL DEFAULT '307',
  `pais_id_vendedor` int DEFAULT NULL,
  `metodo_valoracion_id` int NOT NULL DEFAULT '1',
  `tipo_vinculacion_id` int NOT NULL,
  `marca` varchar(50) DEFAULT NULL,
  `modelo` varchar(50) DEFAULT NULL,
  `serie` varchar(50) DEFAULT NULL,
  `valor_dll` decimal(28,14) DEFAULT NULL,
  `pedimento_detalle_agrupado_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `factura_detalle_id` (`factura_detalle_id`),
  KEY `pedimento_id` (`pedimento_id`),
  KEY `parte_id` (`parte_id`),
  KEY `medida_id_comercial` (`umc_id`),
  KEY `medida_id_tarifa` (`umt_id`),
  KEY `pais_id_origen` (`pais_id_origen`),
  KEY `opcion_id_tipo_tasa` (`tipo_tasa_fraccion_mx_id`),
  KEY `fraccion_id_mx` (`fraccion_id_mx`),
  KEY `tipo_material_id` (`tipo_material_id`),
  KEY `opcion_id_estatus` (`opcion_id_estatus`),
  KEY `pais_id_vendedor` (`pais_id_vendedor`),
  KEY `metodo_valoracion_id` (`metodo_valoracion_id`),
  KEY `pedimento_detalle_tipo_vinculacion_id_foreign_idx` (`tipo_vinculacion_id`),
  KEY `fk_pedimento_detalle_pedimento_detalle_agrupado` (`pedimento_detalle_agrupado_id`),
  CONSTRAINT `fk_pedimento_detalle_pedimento_detalle_agrupado` FOREIGN KEY (`pedimento_detalle_agrupado_id`) REFERENCES `pedimento_detalle_agrupado` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT,
  CONSTRAINT `pedimento_detalle_ibfk_1291` FOREIGN KEY (`factura_detalle_id`) REFERENCES `factura_detalle` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `pedimento_detalle_ibfk_1292` FOREIGN KEY (`pedimento_id`) REFERENCES `pedimento` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `pedimento_detalle_ibfk_1293` FOREIGN KEY (`parte_id`) REFERENCES `parte` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `pedimento_detalle_ibfk_1294` FOREIGN KEY (`umc_id`) REFERENCES `medida` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `pedimento_detalle_ibfk_1295` FOREIGN KEY (`umt_id`) REFERENCES `medida` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `pedimento_detalle_ibfk_1296` FOREIGN KEY (`pais_id_origen`) REFERENCES `pais` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `pedimento_detalle_ibfk_1297` FOREIGN KEY (`tipo_tasa_fraccion_mx_id`) REFERENCES `opcion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `pedimento_detalle_ibfk_1298` FOREIGN KEY (`fraccion_id_mx`) REFERENCES `fraccion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `pedimento_detalle_ibfk_1299` FOREIGN KEY (`tipo_material_id`) REFERENCES `tipo_material` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `pedimento_detalle_ibfk_1300` FOREIGN KEY (`opcion_id_estatus`) REFERENCES `opcion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `pedimento_detalle_ibfk_1301` FOREIGN KEY (`pais_id_vendedor`) REFERENCES `pais` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `pedimento_detalle_ibfk_1302` FOREIGN KEY (`metodo_valoracion_id`) REFERENCES `metodo_valoracion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `pedimento_detalle_tipo_vinculacion_id_foreign_idx` FOREIGN KEY (`tipo_vinculacion_id`) REFERENCES `tipo_vinculacion` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11749308 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for pedimento_detalle_agrupado
-- ----------------------------
DROP TABLE IF EXISTS `pedimento_detalle_agrupado`;
CREATE TABLE `pedimento_detalle_agrupado` (
  `id` int NOT NULL AUTO_INCREMENT,
  `pedimento_id` int NOT NULL,
  `secuencia` int NOT NULL DEFAULT '0',
  `descripcion_esp` varchar(250) NOT NULL,
  `fraccion_id_mx` int NOT NULL,
  `tipo_vinculacion_id` int NOT NULL,
  `metodo_valoracion_id` int NOT NULL,
  `cantidad_umc` decimal(28,14) NOT NULL,
  `umc_id` int NOT NULL,
  `cantidad_umt` decimal(28,14) NOT NULL,
  `umt_id` int NOT NULL,
  `pais_id_vendedor` int NOT NULL,
  `pais_id_origen` int NOT NULL,
  `valor_aduana` decimal(28,14) NOT NULL,
  `valor_dll` decimal(28,14) NOT NULL,
  `costo_total_mx` decimal(28,14) NOT NULL,
  `costo_unitario_mx` decimal(28,14) NOT NULL,
  `valor_agregado` decimal(28,14) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `pedimento_id` (`pedimento_id`),
  KEY `fraccion_id_mx` (`fraccion_id_mx`),
  KEY `tipo_vinculacion_id` (`tipo_vinculacion_id`),
  KEY `metodo_valoracion_id` (`metodo_valoracion_id`),
  KEY `umc_id` (`umc_id`),
  KEY `umt_id` (`umt_id`),
  KEY `pais_id_vendedor` (`pais_id_vendedor`),
  KEY `pais_id_origen` (`pais_id_origen`),
  CONSTRAINT `pedimento_detalle_agrupado_ibfk_1` FOREIGN KEY (`pedimento_id`) REFERENCES `pedimento` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `pedimento_detalle_agrupado_ibfk_2` FOREIGN KEY (`fraccion_id_mx`) REFERENCES `fraccion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `pedimento_detalle_agrupado_ibfk_3` FOREIGN KEY (`tipo_vinculacion_id`) REFERENCES `tipo_vinculacion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `pedimento_detalle_agrupado_ibfk_4` FOREIGN KEY (`metodo_valoracion_id`) REFERENCES `metodo_valoracion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `pedimento_detalle_agrupado_ibfk_5` FOREIGN KEY (`umc_id`) REFERENCES `medida` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `pedimento_detalle_agrupado_ibfk_6` FOREIGN KEY (`umt_id`) REFERENCES `medida` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `pedimento_detalle_agrupado_ibfk_7` FOREIGN KEY (`pais_id_vendedor`) REFERENCES `pais` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `pedimento_detalle_agrupado_ibfk_8` FOREIGN KEY (`pais_id_origen`) REFERENCES `pais` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=473 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for pedimento_detalle_agrupado_contribucion
-- ----------------------------
DROP TABLE IF EXISTS `pedimento_detalle_agrupado_contribucion`;
CREATE TABLE `pedimento_detalle_agrupado_contribucion` (
  `id` int NOT NULL AUTO_INCREMENT,
  `pedimento_detalle_agrupado_id` int NOT NULL,
  `contribucion_id` int NOT NULL,
  `forma_pago_id` int NOT NULL,
  `importe` decimal(28,14) NOT NULL DEFAULT '0.00000000000000',
  `tasa` varchar(100) DEFAULT NULL,
  `tipo_tasa_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `pedimento_detalle_agrupado_id` (`pedimento_detalle_agrupado_id`),
  KEY `contribucion_id` (`contribucion_id`),
  KEY `forma_pago_id` (`forma_pago_id`),
  KEY `tipo_tasa_id` (`tipo_tasa_id`),
  CONSTRAINT `pedimento_detalle_agrupado_contribucion_ibfk_1` FOREIGN KEY (`pedimento_detalle_agrupado_id`) REFERENCES `pedimento_detalle_agrupado` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `pedimento_detalle_agrupado_contribucion_ibfk_2` FOREIGN KEY (`contribucion_id`) REFERENCES `contribucion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `pedimento_detalle_agrupado_contribucion_ibfk_3` FOREIGN KEY (`forma_pago_id`) REFERENCES `forma_pago` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `pedimento_detalle_agrupado_contribucion_ibfk_4` FOREIGN KEY (`tipo_tasa_id`) REFERENCES `tipo_tasa` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=305 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for pedimento_detalle_agrupado_identificador
-- ----------------------------
DROP TABLE IF EXISTS `pedimento_detalle_agrupado_identificador`;
CREATE TABLE `pedimento_detalle_agrupado_identificador` (
  `id` int NOT NULL AUTO_INCREMENT,
  `pedimento_detalle_agrupado_id` int NOT NULL,
  `identificador_id` int NOT NULL,
  `complemento1` varchar(50) DEFAULT NULL,
  `complemento2` varchar(50) DEFAULT NULL,
  `complemento3` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `pedimento_detalle_agrupado_id` (`pedimento_detalle_agrupado_id`),
  KEY `identificador_id` (`identificador_id`),
  CONSTRAINT `pedimento_detalle_agrupado_identificador_ibfk_1` FOREIGN KEY (`pedimento_detalle_agrupado_id`) REFERENCES `pedimento_detalle_agrupado` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `pedimento_detalle_agrupado_identificador_ibfk_2` FOREIGN KEY (`identificador_id`) REFERENCES `identificador` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=361 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for pedimento_detalle_saldo
-- ----------------------------
DROP TABLE IF EXISTS `pedimento_detalle_saldo`;
CREATE TABLE `pedimento_detalle_saldo` (
  `id` int NOT NULL AUTO_INCREMENT,
  `pedimento_detalle_id` int NOT NULL,
  `saldo` decimal(28,14) NOT NULL,
  `fecha_vencimiento` date DEFAULT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  `temporalidad_id` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `pedimento_detalle_id` (`pedimento_detalle_id`),
  KEY `temporalidad_id` (`temporalidad_id`),
  CONSTRAINT `pedimento_detalle_saldo_ibfk_1` FOREIGN KEY (`pedimento_detalle_id`) REFERENCES `pedimento_detalle` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `pedimento_detalle_saldo_ibfk_2` FOREIGN KEY (`temporalidad_id`) REFERENCES `temporalidad` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1118208 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for pedimento_identificador
-- ----------------------------
DROP TABLE IF EXISTS `pedimento_identificador`;
CREATE TABLE `pedimento_identificador` (
  `id` int NOT NULL AUTO_INCREMENT,
  `pedimento_id` int NOT NULL,
  `identificador_id` int NOT NULL,
  `complemento1` varchar(50) DEFAULT NULL,
  `complemento2` varchar(50) DEFAULT NULL,
  `complemento3` varchar(50) DEFAULT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `pedimento_id` (`pedimento_id`) USING BTREE,
  KEY `identificador_id` (`identificador_id`) USING BTREE,
  CONSTRAINT `pedimento_identificador_ibfk_131` FOREIGN KEY (`pedimento_id`) REFERENCES `pedimento` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `pedimento_identificador_ibfk_132` FOREIGN KEY (`identificador_id`) REFERENCES `identificador` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=268 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for pedimento_incrementable
-- ----------------------------
DROP TABLE IF EXISTS `pedimento_incrementable`;
CREATE TABLE `pedimento_incrementable` (
  `id` int NOT NULL AUTO_INCREMENT,
  `pedimento_id` int NOT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  `val_seguros` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `seguro` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `fletes` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `embalaje` decimal(19,6) NOT NULL DEFAULT '0.000000',
  `otros` decimal(19,6) NOT NULL DEFAULT '0.000000',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `pedimento_id` (`pedimento_id`) USING BTREE,
  CONSTRAINT `pedimento_incrementable_ibfk_1` FOREIGN KEY (`pedimento_id`) REFERENCES `pedimento` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6292 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for pedimentos_danados
-- ----------------------------
DROP TABLE IF EXISTS `pedimentos_danados`;
CREATE TABLE `pedimentos_danados` (
  `total_partidas` bigint DEFAULT NULL,
  `id_estatus_pedimento` int DEFAULT '0',
  `estatus_pedimento` varchar(200) DEFAULT NULL,
  `id` int DEFAULT '0',
  `agencia_patente_id` int DEFAULT NULL,
  `numero_pedimento` varchar(7) DEFAULT NULL,
  `clave_pedimento_id` int DEFAULT NULL,
  `importacion` tinyint(1) DEFAULT '1',
  `regimen_id` int DEFAULT NULL,
  `fecha_pago` date DEFAULT NULL,
  `tipo_cambio` decimal(19,6) DEFAULT NULL,
  `opcion_id_estatus` int DEFAULT NULL,
  `cliente_id_empresa` int DEFAULT NULL,
  `tipo_catalogo_id` int DEFAULT NULL,
  `total_bulto` int DEFAULT '0',
  `valor_aduana` decimal(19,6) DEFAULT NULL,
  `peso_total_bruto_kg` decimal(19,6) DEFAULT NULL,
  `numero_operacion` varchar(10) DEFAULT NULL,
  `semana` int DEFAULT NULL,
  `contra_parte_v1` varchar(20) DEFAULT NULL,
  `destino_mercancia_id` int DEFAULT NULL,
  `pedimento_id_rectificado` int DEFAULT NULL,
  `usuario_id` int DEFAULT NULL,
  `consolidado` tinyint(1) DEFAULT '0',
  `observacion` varchar(1100) DEFAULT NULL,
  `activo` tinyint(1) DEFAULT '1',
  `clave_pedimento_id_nueva` int DEFAULT NULL,
  `codigo_aceptacion` varchar(8) DEFAULT NULL,
  `linea_captura` varchar(20) DEFAULT NULL,
  `medio_transporte_arribo_id` int DEFAULT NULL,
  `medio_transporte_salida_id` int DEFAULT NULL,
  `numero_transaccion_sat` int DEFAULT NULL,
  `medio_presentacion` varchar(50) DEFAULT NULL,
  `medio_recepcion_cobro` varchar(50) DEFAULT NULL,
  `aduana_seccion_entrada_salida_id` int DEFAULT '15',
  `aduana_seccion_despacho_id` int DEFAULT NULL,
  `valor_dll` decimal(19,6) DEFAULT '0.000000',
  `valor_comercial` decimal(19,6) DEFAULT NULL,
  `institucion_bancaria` varchar(50) DEFAULT NULL,
  `fecha_presentacion` date DEFAULT '2021-01-01',
  `medio_transporte_entrada_salida_id` int DEFAULT NULL,
  `fecha_entrada` date DEFAULT '2020-01-01',
  `factor_prorrateo` decimal(28,14) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for periodo
-- ----------------------------
DROP TABLE IF EXISTS `periodo`;
CREATE TABLE `periodo` (
  `id` int NOT NULL AUTO_INCREMENT,
  `clave` varchar(2) NOT NULL,
  `periodo_descripcion` varchar(24) NOT NULL,
  `mes_empiezo` int DEFAULT NULL,
  `dia_empiezo` int DEFAULT NULL,
  `periodo_rango` enum('MES','QUINCE','BIMES') DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf16;

-- ----------------------------
-- Table structure for permiso
-- ----------------------------
DROP TABLE IF EXISTS `permiso`;
CREATE TABLE `permiso` (
  `id` int NOT NULL AUTO_INCREMENT,
  `numero_documento` int NOT NULL,
  `anio` varchar(4) NOT NULL,
  `opcion_id_documento` int NOT NULL,
  `opcion_id_tipo` int NOT NULL,
  `aprobado` tinyint(1) DEFAULT NULL,
  `fecha_inicio` date NOT NULL,
  `fecha_vencimiento` date NOT NULL,
  `opcion_id_dependencia` int NOT NULL,
  `permiso_id_original` int DEFAULT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  `edocument` varchar(100) DEFAULT NULL,
  `foto` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `opcion_id_documento` (`opcion_id_documento`) USING BTREE,
  KEY `opcion_id_tipo` (`opcion_id_tipo`) USING BTREE,
  KEY `opcion_id_dependencia` (`opcion_id_dependencia`) USING BTREE,
  KEY `permiso_id_original` (`permiso_id_original`) USING BTREE,
  CONSTRAINT `permiso_ibfk_405` FOREIGN KEY (`opcion_id_documento`) REFERENCES `opcion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `permiso_ibfk_406` FOREIGN KEY (`opcion_id_tipo`) REFERENCES `opcion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `permiso_ibfk_407` FOREIGN KEY (`opcion_id_dependencia`) REFERENCES `opcion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `permiso_ibfk_408` FOREIGN KEY (`permiso_id_original`) REFERENCES `permiso` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for permiso_fraccion
-- ----------------------------
DROP TABLE IF EXISTS `permiso_fraccion`;
CREATE TABLE `permiso_fraccion` (
  `id` int NOT NULL AUTO_INCREMENT,
  `permiso_id` int NOT NULL,
  `fraccion_id` int NOT NULL,
  `cantidad` decimal(19,6) NOT NULL,
  `porcentaje_tasa` int NOT NULL,
  `cantidad_saldo` decimal(19,6) NOT NULL,
  `observacion` varchar(1100) DEFAULT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `permiso_id` (`permiso_id`) USING BTREE,
  KEY `fraccion_id` (`fraccion_id`) USING BTREE,
  CONSTRAINT `permiso_fraccion_ibfk_131` FOREIGN KEY (`permiso_id`) REFERENCES `permiso` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `permiso_fraccion_ibfk_132` FOREIGN KEY (`fraccion_id`) REFERENCES `fraccion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for permiso_fraccion_historico
-- ----------------------------
DROP TABLE IF EXISTS `permiso_fraccion_historico`;
CREATE TABLE `permiso_fraccion_historico` (
  `id` int NOT NULL AUTO_INCREMENT,
  `cantidad_umc` decimal(19,6) NOT NULL,
  `valor_umc` decimal(19,6) NOT NULL,
  `permiso_id` int NOT NULL,
  `factura_id` int DEFAULT NULL,
  `factura_detalle_id` int NOT NULL,
  `parte_id` int NOT NULL,
  `fraccion_id_mx` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `permiso_id` (`permiso_id`),
  KEY `factura_id` (`factura_id`),
  KEY `factura_detalle_id` (`factura_detalle_id`),
  KEY `parte_id` (`parte_id`),
  KEY `fraccion_id_mx` (`fraccion_id_mx`),
  CONSTRAINT `permiso_fraccion_historico_ibfk_291` FOREIGN KEY (`permiso_id`) REFERENCES `permiso` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `permiso_fraccion_historico_ibfk_292` FOREIGN KEY (`factura_id`) REFERENCES `factura` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `permiso_fraccion_historico_ibfk_293` FOREIGN KEY (`factura_detalle_id`) REFERENCES `factura_detalle` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `permiso_fraccion_historico_ibfk_294` FOREIGN KEY (`parte_id`) REFERENCES `parte` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `permiso_fraccion_historico_ibfk_295` FOREIGN KEY (`fraccion_id_mx`) REFERENCES `fraccion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for permiso_fraccion_parte
-- ----------------------------
DROP TABLE IF EXISTS `permiso_fraccion_parte`;
CREATE TABLE `permiso_fraccion_parte` (
  `id` int NOT NULL AUTO_INCREMENT,
  `permiso_fraccion_id` int NOT NULL,
  `parte_id` int NOT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `permiso_fraccion_id` (`permiso_fraccion_id`) USING BTREE,
  KEY `parte_id` (`parte_id`) USING BTREE,
  CONSTRAINT `permiso_fraccion_parte_ibfk_130` FOREIGN KEY (`permiso_fraccion_id`) REFERENCES `permiso_fraccion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `permiso_fraccion_parte_ibfk_131` FOREIGN KEY (`parte_id`) REFERENCES `parte` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for productor
-- ----------------------------
DROP TABLE IF EXISTS `productor`;
CREATE TABLE `productor` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(5) NOT NULL,
  `supuesto` varchar(250) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for prosec
-- ----------------------------
DROP TABLE IF EXISTS `prosec`;
CREATE TABLE `prosec` (
  `id` int NOT NULL AUTO_INCREMENT,
  `clave` varchar(10) NOT NULL,
  `descripcion` varchar(150) NOT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for puerto
-- ----------------------------
DROP TABLE IF EXISTS `puerto`;
CREATE TABLE `puerto` (
  `id` int NOT NULL AUTO_INCREMENT,
  `pais_id` int DEFAULT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  `nombre_locacion` varchar(80) NOT NULL,
  `puerto` varchar(10) NOT NULL,
  `codigo_locacion` varchar(10) NOT NULL,
  `tipo_locacion` varchar(80) NOT NULL,
  `direccion` varchar(80) NOT NULL,
  `ciudad` varchar(80) NOT NULL,
  `codigo_postal` varchar(15) NOT NULL,
  `estado` varchar(15) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `pais_id` (`pais_id`) USING BTREE,
  CONSTRAINT `puerto_ibfk_1` FOREIGN KEY (`pais_id`) REFERENCES `pais` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16775 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for recicladora
-- ----------------------------
DROP TABLE IF EXISTS `recicladora`;
CREATE TABLE `recicladora` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre_esp` varchar(120) NOT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for recinto_fiscalizado
-- ----------------------------
DROP TABLE IF EXISTS `recinto_fiscalizado`;
CREATE TABLE `recinto_fiscalizado` (
  `id` int NOT NULL AUTO_INCREMENT,
  `aduana` varchar(50) NOT NULL,
  `clave` varchar(5) NOT NULL,
  `descripcion` varchar(150) NOT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for regimen
-- ----------------------------
DROP TABLE IF EXISTS `regimen`;
CREATE TABLE `regimen` (
  `id` int NOT NULL AUTO_INCREMENT,
  `clave` varchar(5) NOT NULL,
  `descripcion` varchar(250) NOT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for relacion_certificacion_modalidad_rubro
-- ----------------------------
DROP TABLE IF EXISTS `relacion_certificacion_modalidad_rubro`;
CREATE TABLE `relacion_certificacion_modalidad_rubro` (
  `id` int NOT NULL AUTO_INCREMENT,
  `opcion_id_certificacion` int NOT NULL,
  `opcion_id_modalidad_rubro` int NOT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `AK_relacion_certificacion_modalidad_rubro` (`opcion_id_certificacion`,`opcion_id_modalidad_rubro`),
  KEY `opcion_id_modalidad_rubro` (`opcion_id_modalidad_rubro`),
  CONSTRAINT `relacion_certificacion_modalidad_rubro_ibfk_1` FOREIGN KEY (`opcion_id_certificacion`) REFERENCES `opcion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `relacion_certificacion_modalidad_rubro_ibfk_2` FOREIGN KEY (`opcion_id_modalidad_rubro`) REFERENCES `opcion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for relacion_clave_pedimento_regimen
-- ----------------------------
DROP TABLE IF EXISTS `relacion_clave_pedimento_regimen`;
CREATE TABLE `relacion_clave_pedimento_regimen` (
  `id` int NOT NULL AUTO_INCREMENT,
  `clave_pedimento_id` int DEFAULT NULL,
  `regimen_id` int DEFAULT NULL,
  `opcion_id_tipo_movimiento` int NOT NULL,
  `descripcion` varchar(800) DEFAULT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  `opcion_id_tipo_factura` int NOT NULL,
  `fecha_derogacion` date DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `regimen_id` (`regimen_id`) USING BTREE,
  KEY `opcion_id_tipo_movimiento` (`opcion_id_tipo_movimiento`) USING BTREE,
  KEY `AK_relacion_clave_pedimento_regimen_clave_pedimento_regimen` (`clave_pedimento_id`,`regimen_id`) USING BTREE,
  CONSTRAINT `relacion_clave_pedimento_regimen_ibfk_193` FOREIGN KEY (`clave_pedimento_id`) REFERENCES `clave_pedimento` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `relacion_clave_pedimento_regimen_ibfk_194` FOREIGN KEY (`regimen_id`) REFERENCES `regimen` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `relacion_clave_pedimento_regimen_ibfk_195` FOREIGN KEY (`opcion_id_tipo_movimiento`) REFERENCES `opcion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=141 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for relacion_embarque_material
-- ----------------------------
DROP TABLE IF EXISTS `relacion_embarque_material`;
CREATE TABLE `relacion_embarque_material` (
  `id` int NOT NULL AUTO_INCREMENT,
  `tipo_embarque_id` int NOT NULL,
  `tipo_material_id` int NOT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `AK_relacion_embarque_material_tipo_embarque_material` (`tipo_embarque_id`,`tipo_material_id`),
  KEY `tipo_material_id` (`tipo_material_id`),
  CONSTRAINT `relacion_embarque_material_ibfk_1` FOREIGN KEY (`tipo_embarque_id`) REFERENCES `tipo_embarque` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `relacion_embarque_material_ibfk_2` FOREIGN KEY (`tipo_material_id`) REFERENCES `tipo_material` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for relacion_tipo_empresa_rubro
-- ----------------------------
DROP TABLE IF EXISTS `relacion_tipo_empresa_rubro`;
CREATE TABLE `relacion_tipo_empresa_rubro` (
  `id` int NOT NULL AUTO_INCREMENT,
  `opcion_id_empresa` int NOT NULL,
  `opcion_id_rubro` int NOT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `AK_relacion_tipo_empresa_rubro` (`opcion_id_empresa`,`opcion_id_rubro`),
  KEY `opcion_id_rubro` (`opcion_id_rubro`),
  CONSTRAINT `relacion_tipo_empresa_rubro_ibfk_1` FOREIGN KEY (`opcion_id_empresa`) REFERENCES `opcion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `relacion_tipo_empresa_rubro_ibfk_2` FOREIGN KEY (`opcion_id_rubro`) REFERENCES `opcion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for relacion_tipo_material_tipo_adquisicion
-- ----------------------------
DROP TABLE IF EXISTS `relacion_tipo_material_tipo_adquisicion`;
CREATE TABLE `relacion_tipo_material_tipo_adquisicion` (
  `id` int NOT NULL AUTO_INCREMENT,
  `tipo_material_id` int NOT NULL,
  `tipo_adquisicion_id` int NOT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  `tipo_operacion_id` int NOT NULL DEFAULT '376',
  PRIMARY KEY (`id`),
  KEY `AK_relacion_tipo_material_tipo_adquisicion` (`tipo_material_id`,`tipo_adquisicion_id`),
  KEY `opcion_id_tipo_adquisicion` (`tipo_adquisicion_id`),
  KEY `fk_relacion_tipo_material_tipo_adquisicion_tipo_operacion` (`tipo_operacion_id`),
  CONSTRAINT `fk_relacion_tipo_material_tipo_adquisicion_tipo_operacion` FOREIGN KEY (`tipo_operacion_id`) REFERENCES `opcion` (`id`),
  CONSTRAINT `relacion_tipo_material_tipo_adquisicion_ibfk_67` FOREIGN KEY (`tipo_material_id`) REFERENCES `tipo_material` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `relacion_tipo_material_tipo_adquisicion_ibfk_68` FOREIGN KEY (`tipo_adquisicion_id`) REFERENCES `opcion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for relacion_tipo_material_tipo_catalogo
-- ----------------------------
DROP TABLE IF EXISTS `relacion_tipo_material_tipo_catalogo`;
CREATE TABLE `relacion_tipo_material_tipo_catalogo` (
  `id` int NOT NULL AUTO_INCREMENT,
  `opcion_id_tipo_catalogo` int NOT NULL,
  `tipo_material_id` int NOT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `opcion_id_tipo_catalogo` (`opcion_id_tipo_catalogo`),
  KEY `tipo_material_id` (`tipo_material_id`),
  CONSTRAINT `relacion_tipo_material_tipo_catalogo_ibfk_67` FOREIGN KEY (`opcion_id_tipo_catalogo`) REFERENCES `opcion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `relacion_tipo_material_tipo_catalogo_ibfk_68` FOREIGN KEY (`tipo_material_id`) REFERENCES `tipo_material` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for relacion_tratado_acuerdo_pais
-- ----------------------------
DROP TABLE IF EXISTS `relacion_tratado_acuerdo_pais`;
CREATE TABLE `relacion_tratado_acuerdo_pais` (
  `id` int NOT NULL AUTO_INCREMENT,
  `tratado_acuerdo_id` int NOT NULL,
  `pais_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `tratado_acuerdo_id` (`tratado_acuerdo_id`),
  KEY `pais_id` (`pais_id`),
  CONSTRAINT `relacion_tratado_acuerdo_pais_ibfk_1` FOREIGN KEY (`tratado_acuerdo_id`) REFERENCES `opcion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `relacion_tratado_acuerdo_pais_ibfk_2` FOREIGN KEY (`pais_id`) REFERENCES `pais` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for reporte
-- ----------------------------
DROP TABLE IF EXISTS `reporte`;
CREATE TABLE `reporte` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(150) NOT NULL,
  `categoria` varchar(85) DEFAULT NULL,
  `campos` text NOT NULL,
  `usuario_id` int DEFAULT NULL,
  `usuario` varchar(125) DEFAULT NULL,
  `fecha` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  `descripcion` text,
  `tipo` enum('csv','txt','pdf','xlsx') NOT NULL DEFAULT 'csv',
  `filtros` text,
  `encabezados` text,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for ruta
-- ----------------------------
DROP TABLE IF EXISTS `ruta`;
CREATE TABLE `ruta` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre_corto` varchar(50) NOT NULL,
  `descripcion` varchar(100) NOT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  `compania_transportista_id` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `fk_rutacia` (`compania_transportista_id`) USING BTREE,
  CONSTRAINT `ruta_ibfk_1` FOREIGN KEY (`compania_transportista_id`) REFERENCES `compania_transportista` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for sector
-- ----------------------------
DROP TABLE IF EXISTS `sector`;
CREATE TABLE `sector` (
  `id` int NOT NULL AUTO_INCREMENT,
  `clave` varchar(10) NOT NULL,
  `descripcion` varchar(150) NOT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for sello_fiscal
-- ----------------------------
DROP TABLE IF EXISTS `sello_fiscal`;
CREATE TABLE `sello_fiscal` (
  `id` int NOT NULL AUTO_INCREMENT,
  `codigo` varchar(15) NOT NULL,
  `opcion_id_estatus` int NOT NULL,
  `fecha_alta` date NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `UX_sello_fiscal_codigo` (`codigo`) USING BTREE,
  KEY `opcion_id_estatus` (`opcion_id_estatus`) USING BTREE,
  KEY `UX_sello_fiscal_fecha_alta` (`fecha_alta`) USING BTREE,
  CONSTRAINT `sello_fiscal_ibfk_1` FOREIGN KEY (`opcion_id_estatus`) REFERENCES `opcion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=85 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for SequelizeMeta
-- ----------------------------
DROP TABLE IF EXISTS `SequelizeMeta`;
CREATE TABLE `SequelizeMeta` (
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`name`) USING BTREE,
  UNIQUE KEY `name` (`name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Table structure for submaquila
-- ----------------------------
DROP TABLE IF EXISTS `submaquila`;
CREATE TABLE `submaquila` (
  `id` int NOT NULL AUTO_INCREMENT,
  `empresa_id` int DEFAULT NULL,
  `perm_aut_submaquila` varchar(40) DEFAULT NULL,
  `perm_fecha_submaq` date DEFAULT NULL,
  `proveedor_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `empresa_id` (`empresa_id`),
  KEY `proveedor_id` (`proveedor_id`),
  CONSTRAINT `submaquila_ibfk_1` FOREIGN KEY (`empresa_id`) REFERENCES `cliente` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `submaquila_ibfk_2` FOREIGN KEY (`proveedor_id`) REFERENCES `cliente` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for tasa_recargo
-- ----------------------------
DROP TABLE IF EXISTS `tasa_recargo`;
CREATE TABLE `tasa_recargo` (
  `id` int NOT NULL AUTO_INCREMENT,
  `anio` int NOT NULL,
  `mes` int unsigned NOT NULL,
  `fecha_ent_vigor` date DEFAULT NULL,
  `tasa` double DEFAULT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for template_impresion
-- ----------------------------
DROP TABLE IF EXISTS `template_impresion`;
CREATE TABLE `template_impresion` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for temporalidad
-- ----------------------------
DROP TABLE IF EXISTS `temporalidad`;
CREATE TABLE `temporalidad` (
  `id` int NOT NULL AUTO_INCREMENT,
  `tipo_empresa_id` int NOT NULL,
  `clave_pedimento_id` int NOT NULL,
  `fraccion_sensible` varchar(20) DEFAULT NULL,
  `tipo_catalogo_id` int NOT NULL,
  `meses` int NOT NULL,
  `fecha_inicial` date NOT NULL,
  `fecha_final` date NOT NULL,
  `tipo_operacion_id` int NOT NULL DEFAULT '34',
  PRIMARY KEY (`id`),
  KEY `tipo_empresa_id` (`tipo_empresa_id`),
  KEY `clave_pedimento_id` (`clave_pedimento_id`),
  KEY `tipo_catalogo_id` (`tipo_catalogo_id`),
  KEY `temporalidad_tipo_operacion_id_foreign_idx` (`tipo_operacion_id`),
  CONSTRAINT `temporalidad_ibfk_3` FOREIGN KEY (`tipo_empresa_id`) REFERENCES `opcion` (`id`),
  CONSTRAINT `temporalidad_ibfk_4` FOREIGN KEY (`clave_pedimento_id`) REFERENCES `clave_pedimento` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `temporalidad_ibfk_5` FOREIGN KEY (`tipo_catalogo_id`) REFERENCES `opcion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `temporalidad_tipo_operacion_id_foreign_idx` FOREIGN KEY (`tipo_operacion_id`) REFERENCES `opcion` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=461 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for temporalidad_certificacion
-- ----------------------------
DROP TABLE IF EXISTS `temporalidad_certificacion`;
CREATE TABLE `temporalidad_certificacion` (
  `id` int NOT NULL AUTO_INCREMENT,
  `temporalidad_id` int NOT NULL,
  `certificacion_id` int NOT NULL,
  `modalidad_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `temporalidad_id` (`temporalidad_id`),
  KEY `certificacion_id` (`certificacion_id`),
  KEY `modalidad_id` (`modalidad_id`),
  CONSTRAINT `temporalidad_certificacion_ibfk_4` FOREIGN KEY (`temporalidad_id`) REFERENCES `temporalidad` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `temporalidad_certificacion_ibfk_5` FOREIGN KEY (`certificacion_id`) REFERENCES `opcion` (`id`),
  CONSTRAINT `temporalidad_certificacion_ibfk_6` FOREIGN KEY (`modalidad_id`) REFERENCES `opcion` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=607 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for temporalidad_identificador
-- ----------------------------
DROP TABLE IF EXISTS `temporalidad_identificador`;
CREATE TABLE `temporalidad_identificador` (
  `id` int NOT NULL AUTO_INCREMENT,
  `temporalidad_id` int NOT NULL,
  `identificador_id` int NOT NULL,
  `complemento1` varchar(20) DEFAULT NULL,
  `complemento2` varchar(20) DEFAULT NULL,
  `complemento3` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `temporalidad_id` (`temporalidad_id`),
  KEY `identificador_id` (`identificador_id`),
  CONSTRAINT `temporalidad_identificador_ibfk_3` FOREIGN KEY (`temporalidad_id`) REFERENCES `temporalidad` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `temporalidad_identificador_ibfk_4` FOREIGN KEY (`identificador_id`) REFERENCES `identificador` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=911 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for tipo_cambio
-- ----------------------------
DROP TABLE IF EXISTS `tipo_cambio`;
CREATE TABLE `tipo_cambio` (
  `id` int NOT NULL AUTO_INCREMENT,
  `tipo_cambio` decimal(19,6) NOT NULL,
  `fecha` date NOT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=923 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for tipo_contenedor
-- ----------------------------
DROP TABLE IF EXISTS `tipo_contenedor`;
CREATE TABLE `tipo_contenedor` (
  `id` int NOT NULL AUTO_INCREMENT,
  `clave` varchar(5) NOT NULL,
  `descripcion_esp` varchar(260) NOT NULL,
  `descripcion_ing` varchar(260) NOT NULL,
  `mexicano` tinyint(1) NOT NULL DEFAULT '1',
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=400 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for tipo_embarque
-- ----------------------------
DROP TABLE IF EXISTS `tipo_embarque`;
CREATE TABLE `tipo_embarque` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre_esp` varchar(80) NOT NULL,
  `nombre_ing` varchar(80) DEFAULT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQ_tipo_embarque_nombre_esp` (`nombre_esp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for tipo_material
-- ----------------------------
DROP TABLE IF EXISTS `tipo_material`;
CREATE TABLE `tipo_material` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descripcion_esp` varchar(250) NOT NULL,
  `descripcion_ing` varchar(250) NOT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for tipo_tasa
-- ----------------------------
DROP TABLE IF EXISTS `tipo_tasa`;
CREATE TABLE `tipo_tasa` (
  `id` int NOT NULL AUTO_INCREMENT,
  `clave_ped` varchar(5) NOT NULL,
  `descripcion` varchar(250) NOT NULL,
  `opcion_id_nivel` int DEFAULT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `opcion_id_nivel` (`opcion_id_nivel`) USING BTREE,
  CONSTRAINT `tipo_tasa_ibfk_1` FOREIGN KEY (`opcion_id_nivel`) REFERENCES `opcion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for tipo_vehiculo
-- ----------------------------
DROP TABLE IF EXISTS `tipo_vehiculo`;
CREATE TABLE `tipo_vehiculo` (
  `id` int NOT NULL AUTO_INCREMENT,
  `clave` varchar(5) NOT NULL,
  `descripcion_esp` varchar(150) NOT NULL,
  `descripcion_ing` varchar(150) NOT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for tipo_vinculacion
-- ----------------------------
DROP TABLE IF EXISTS `tipo_vinculacion`;
CREATE TABLE `tipo_vinculacion` (
  `id` int NOT NULL AUTO_INCREMENT,
  `clave` int NOT NULL,
  `descripcion_esp` varchar(200) NOT NULL,
  `descripcion_ing` varchar(200) NOT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for transmisor_configuracion
-- ----------------------------
DROP TABLE IF EXISTS `transmisor_configuracion`;
CREATE TABLE `transmisor_configuracion` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(150) NOT NULL,
  `tipo` enum('SMTP','FTP','CSV','XML','N') NOT NULL DEFAULT 'N',
  `ftp_host` varchar(85) DEFAULT NULL,
  `ftp_puerto` varchar(5) DEFAULT NULL,
  `ftp_usuario` varchar(25) DEFAULT NULL,
  `ftp_clave` varchar(85) DEFAULT NULL,
  `smtp_correos` varchar(125) DEFAULT NULL,
  `fecha_registro` date NOT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for transmisor_seccion
-- ----------------------------
DROP TABLE IF EXISTS `transmisor_seccion`;
CREATE TABLE `transmisor_seccion` (
  `id` int NOT NULL AUTO_INCREMENT,
  `clave` varchar(15) NOT NULL,
  `nombre` varchar(65) NOT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for transmisor_seccion_campo
-- ----------------------------
DROP TABLE IF EXISTS `transmisor_seccion_campo`;
CREATE TABLE `transmisor_seccion_campo` (
  `id` int NOT NULL AUTO_INCREMENT,
  `transmisor_seccion_id` int NOT NULL,
  `campo` varchar(800) DEFAULT NULL,
  `nombre` varchar(85) NOT NULL,
  `default` varchar(100) DEFAULT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `UQ_campos_nombre` (`transmisor_seccion_id`,`nombre`) USING BTREE,
  KEY `transmisor_seccion_id` (`transmisor_seccion_id`) USING BTREE,
  CONSTRAINT `transmisor_seccion_campo_ibfk_1` FOREIGN KEY (`transmisor_seccion_id`) REFERENCES `transmisor_seccion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2748 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for transmisor_template
-- ----------------------------
DROP TABLE IF EXISTS `transmisor_template`;
CREATE TABLE `transmisor_template` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(65) NOT NULL,
  `delimitador` varchar(4) NOT NULL DEFAULT '|',
  `transmisor_configuracion_id` int DEFAULT NULL,
  `fecha_registro` date NOT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `transmisor_configuracion_id` (`transmisor_configuracion_id`) USING BTREE,
  CONSTRAINT `transmisor_template_ibfk_1` FOREIGN KEY (`transmisor_configuracion_id`) REFERENCES `transmisor_configuracion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for transmisor_template_campo
-- ----------------------------
DROP TABLE IF EXISTS `transmisor_template_campo`;
CREATE TABLE `transmisor_template_campo` (
  `id` int NOT NULL AUTO_INCREMENT,
  `transmisor_template_detalle_id` int NOT NULL,
  `orden` int NOT NULL DEFAULT '1',
  `transmisor_seccion_campo_id` int NOT NULL,
  `obligatorio` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `transmisor_template_detalle_id` (`transmisor_template_detalle_id`) USING BTREE,
  KEY `transmisor_seccion_campo_id` (`transmisor_seccion_campo_id`) USING BTREE,
  CONSTRAINT `transmisor_template_campo_ibfk_129` FOREIGN KEY (`transmisor_template_detalle_id`) REFERENCES `transmisor_template_detalle` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `transmisor_template_campo_ibfk_130` FOREIGN KEY (`transmisor_seccion_campo_id`) REFERENCES `transmisor_seccion_campo` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for transmisor_template_detalle
-- ----------------------------
DROP TABLE IF EXISTS `transmisor_template_detalle`;
CREATE TABLE `transmisor_template_detalle` (
  `id` int NOT NULL AUTO_INCREMENT,
  `transmisor_template_id` int NOT NULL,
  `orden` int NOT NULL DEFAULT '1',
  `transmisor_seccion_id` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `transmisor_template_id` (`transmisor_template_id`) USING BTREE,
  KEY `transmisor_seccion_id` (`transmisor_seccion_id`) USING BTREE,
  CONSTRAINT `transmisor_template_detalle_ibfk_129` FOREIGN KEY (`transmisor_template_id`) REFERENCES `transmisor_template` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `transmisor_template_detalle_ibfk_130` FOREIGN KEY (`transmisor_seccion_id`) REFERENCES `transmisor_seccion` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for tratado
-- ----------------------------
DROP TABLE IF EXISTS `tratado`;
CREATE TABLE `tratado` (
  `id` int NOT NULL AUTO_INCREMENT,
  `clave` varchar(15) NOT NULL,
  `descripcion_esp` varchar(150) NOT NULL,
  `descripcion_ing` varchar(150) NOT NULL,
  `opcion_id_mostrar` int DEFAULT NULL,
  `analisis_fraccion` varchar(5) DEFAULT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `opcion_id_mostrar` (`opcion_id_mostrar`) USING BTREE,
  CONSTRAINT `tratado_ibfk_1` FOREIGN KEY (`opcion_id_mostrar`) REFERENCES `opcion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for usuario
-- ----------------------------
DROP TABLE IF EXISTS `usuario`;
CREATE TABLE `usuario` (
  `id` int NOT NULL AUTO_INCREMENT,
  `usuario` varchar(50) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `apellido_paterno` varchar(50) NOT NULL,
  `apellido_materno` varchar(50) NOT NULL,
  `contrasena` varchar(120) NOT NULL DEFAULT 'AG-Global',
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for vehiculo
-- ----------------------------
DROP TABLE IF EXISTS `vehiculo`;
CREATE TABLE `vehiculo` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(50) NOT NULL,
  `no_economico` varchar(20) DEFAULT NULL,
  `tipo_vehiculo_id_mx` int NOT NULL,
  `placas_mx` varchar(15) NOT NULL,
  `placas_usa` varchar(15) DEFAULT NULL,
  `estado_usa_id` int DEFAULT NULL,
  `compania_transportista_id` int NOT NULL,
  `vin` varchar(20) DEFAULT NULL,
  `tipo_vehiculo_id_usa` int DEFAULT NULL,
  `dot_number` varchar(15) DEFAULT NULL,
  `tarjeta_circulacion` varchar(20) DEFAULT NULL,
  `marca` varchar(30) DEFAULT NULL,
  `modelo` varchar(30) DEFAULT NULL,
  `chofer_id` int DEFAULT NULL,
  `aceid` varchar(10) DEFAULT NULL,
  `poliza` varchar(15) DEFAULT NULL,
  `aseguradora` varchar(100) DEFAULT NULL,
  `fecha_expedicion` date DEFAULT NULL,
  `fecha_vencimiento` date DEFAULT NULL,
  `monto_asegurado` int DEFAULT NULL,
  `contacto` varchar(100) DEFAULT NULL,
  `telefono_contacto` varchar(15) DEFAULT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  `estado_mx_id` int DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `tipo_vehiculo_id_mx` (`tipo_vehiculo_id_mx`) USING BTREE,
  KEY `estado_id_usa` (`estado_usa_id`) USING BTREE,
  KEY `compania_transportista_id` (`compania_transportista_id`) USING BTREE,
  KEY `tipo_vehiculo_id_usa` (`tipo_vehiculo_id_usa`) USING BTREE,
  KEY `chofer_id` (`chofer_id`) USING BTREE,
  KEY `vehiculo_estado_mx_id_foreign_idx` (`estado_mx_id`),
  CONSTRAINT `vehiculo_estado_mx_id_foreign_idx` FOREIGN KEY (`estado_mx_id`) REFERENCES `estado` (`id`),
  CONSTRAINT `vehiculo_ibfk_636` FOREIGN KEY (`tipo_vehiculo_id_mx`) REFERENCES `tipo_vehiculo` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `vehiculo_ibfk_637` FOREIGN KEY (`estado_usa_id`) REFERENCES `estado` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `vehiculo_ibfk_638` FOREIGN KEY (`compania_transportista_id`) REFERENCES `compania_transportista` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `vehiculo_ibfk_639` FOREIGN KEY (`tipo_vehiculo_id_usa`) REFERENCES `tipo_vehiculo` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `vehiculo_ibfk_640` FOREIGN KEY (`chofer_id`) REFERENCES `chofer` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for ventanilla_unica
-- ----------------------------
DROP TABLE IF EXISTS `ventanilla_unica`;
CREATE TABLE `ventanilla_unica` (
  `id` int NOT NULL AUTO_INCREMENT,
  `cliente_id` int NOT NULL,
  `email` varchar(50) DEFAULT NULL,
  `usuario` varchar(50) DEFAULT NULL,
  `password` varchar(250) DEFAULT NULL,
  `certificado` text,
  `efirma` text,
  `webservice_password` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cliente_id` (`cliente_id`),
  CONSTRAINT `ventanilla_unica_ibfk_1` FOREIGN KEY (`cliente_id`) REFERENCES `cliente` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Table structure for yarda
-- ----------------------------
DROP TABLE IF EXISTS `yarda`;
CREATE TABLE `yarda` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(100) NOT NULL,
  `clave` varchar(15) NOT NULL,
  `capacidad` int NOT NULL,
  `ubicacion` varchar(60) NOT NULL,
  `compania_transportista_id` int NOT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `compania_transportista_id` (`compania_transportista_id`) USING BTREE,
  CONSTRAINT `yarda_ibfk_1` FOREIGN KEY (`compania_transportista_id`) REFERENCES `compania_transportista` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- View structure for rpt_descarga
-- ----------------------------
DROP VIEW IF EXISTS `rpt_descarga`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `rpt_descarga` AS select `descargas`.`id` AS `Id descarga`,`factura_expo`.`id` AS `Id factura`,`clave_pedimento_expo`.`clave` AS `Clave expo`,`pedimento_expo`.`id` AS `Id pedimento`,`pedimento_expo`.`numero_pedimento` AS `Pedimento expo`,`estatus_pedimento_expo`.`descripcion_esp` AS `Estatus pedimento expo`,`factura_expo`.`folio` AS `Factura expo`,`estatus_factura_expo`.`descripcion_esp` AS `Estatus factura expo`,`factura_expo`.`fecha` AS `Fecha expo`,`factura_detalle_expo`.`id` AS `Id expo`,if((`factura_detalle_expo`.`secuencia` = 0),`pedimento_detalle_expo`.`secuencia`,`pedimento_detalle_expo`.`secuencia`) AS `Secuencia expo`,`tipo_adquisicion_expo`.`descripcion_esp` AS `Tipo adquisición expo`,`tipo_material_expo`.`descripcion_esp` AS `Tipo material expo`,`parte_expo`.`noparte` AS `No parte expo`,`factura_detalle_expo`.`cantidad_um` AS `Cantidad UM expo`,`factura_detalle_expo`.`cantidad_umc` AS `Cantidad UMC expo`,`padre_noparte`.`noparte` AS `No parte padre`,`parte_descargada`.`noparte` AS `No parte descargado`,`estatus`.`descripcion_esp` AS `Estatus`,`descargas`.`cantidad_descargar` AS `Cantidad a descargar`,`descargas`.`cantidad_descargada` AS `Cantidad descargada`,`descargas`.`cantidad_faltante` AS `Cantidad faltante`,`pedimento_descargado`.`id` AS `Id pedimento impo`,concat(`patente_impo`.`patente`,'-',`pedimento_descargado`.`numero_pedimento`,'-',`aduana_impo`.`clave`,`aduana_impo`.`seccion`,'-',`pedimento_detalle_descargado`.`secuencia`) AS `Pedimento descargado`,`factura_impo`.`folio` AS `Factura impo`,`pedimento_descargado`.`fecha_pago` AS `Fecha pago`,`tipo_adquisicion_saldo`.`descripcion_esp` AS `Tipo adquisición impo`,`tipo_material_impo`.`descripcion_esp` AS `Tipo material impo` from ((((((((((((((((((((((`descarga` `descargas` left join `factura_detalle` `factura_detalle_expo` on((`factura_detalle_expo`.`id` = `descargas`.`factura_detalle_id`))) left join `factura` `factura_expo` on((`factura_expo`.`id` = `factura_detalle_expo`.`factura_id`))) left join `parte` `parte_expo` on((`parte_expo`.`id` = `factura_detalle_expo`.`parte_id`))) left join `pedimento_detalle` `pedimento_detalle_expo` on((`pedimento_detalle_expo`.`factura_detalle_id` = `factura_detalle_expo`.`id`))) left join `pedimento` `pedimento_expo` on((`pedimento_expo`.`id` = `pedimento_detalle_expo`.`pedimento_id`))) left join `opcion` `estatus_pedimento_expo` on((`estatus_pedimento_expo`.`id` = `pedimento_expo`.`opcion_id_estatus`))) left join `opcion` `estatus_factura_expo` on((`estatus_factura_expo`.`id` = `factura_expo`.`opcion_id_estatus`))) left join `opcion` `tipo_adquisicion_expo` on((`tipo_adquisicion_expo`.`id` = `factura_detalle_expo`.`tipo_adquisicion_id`))) left join `tipo_material` `tipo_material_expo` on((`tipo_material_expo`.`id` = `factura_detalle_expo`.`tipo_material_id`))) left join `parte` `parte_descargada` on((`parte_descargada`.`id` = `descargas`.`parte_descargada_id`))) left join `clave_pedimento` `clave_pedimento_expo` on((`clave_pedimento_expo`.`id` = `factura_expo`.`clave_pedimento_id`))) left join `pedimento_detalle` `pedimento_detalle_descargado` on((`pedimento_detalle_descargado`.`id` = `descargas`.`pedimento_detalle_id`))) left join `factura_detalle` `factura_detalle_impo` on((`factura_detalle_impo`.`id` = `pedimento_detalle_descargado`.`factura_detalle_id`))) left join `factura` `factura_impo` on((`factura_impo`.`id` = `factura_detalle_impo`.`factura_id`))) left join `pedimento` `pedimento_descargado` on((`pedimento_descargado`.`id` = `pedimento_detalle_descargado`.`pedimento_id`))) left join `aduana_seccion` `aduana_impo` on((`aduana_impo`.`id` = `pedimento_descargado`.`aduana_seccion_entrada_salida_id`))) left join `agencia_patente` `patente_impo` on((`patente_impo`.`id` = `pedimento_descargado`.`agencia_patente_id`))) left join `opcion` `tipo_adquisicion_saldo` on((`tipo_adquisicion_saldo`.`id` = `factura_detalle_impo`.`tipo_adquisicion_id`))) left join `tipo_material` `tipo_material_impo` on((`tipo_material_impo`.`id` = `factura_detalle_impo`.`tipo_material_id`))) left join `bom` `bom_padre` on((`bom_padre`.`id` = `descargas`.`bom_padre_id`))) left join `parte` `padre_noparte` on((`padre_noparte`.`id` = `bom_padre`.`componente_id`))) left join `opcion` `estatus` on(((`estatus`.`id` = `descargas`.`opcion_id_estatus`) and (`estatus`.`nombre_tabla` = 'descarga') and (`estatus`.`nombre_campo` = 'opcion_id_estatus'))));

-- ----------------------------
-- Procedure structure for sp_duplicar_noparte
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_duplicar_noparte`;
delimiter ;;
CREATE PROCEDURE `sp_duplicar_noparte`(IN noparte varchar(50))
BEGIN
		-- internal viables
		declare id_noparte INT DEFAULT null;
		declare last_id_noparte INT DEFAULT null;
		
		-- get the original no parte id and set into id_noparte
    select parte.id
		into id_noparte
		from parte 
		where parte.noparte = noparte;
		IF (SELECT EXISTS (SELECT 1 FROM a24.parte WHERE parte.id like id_noparte)) THEN 
				
			-- duplicate no parte
			INSERT INTO a24.parte (noparte, tipo_material_id, descripcion_esp, descripcion_ing, peso_unitario_kg, medida_id_mx
			, pais_id_origen, eccn, fecha_ultima_modificacion, fecha_creacion, marca, modelo, serie, numero_activo, ubicacion, vida_util
			, etiqueto, foto, tipo_catalogo_id, medida_id_extranjera, factor_conversion, costo_unitario_dll, activo, tipo_adquisicion_id
			, peso_libras, ext_art_25, comentario_foto, fecha_carga_foto, prosec_id_tasa, licence, numero_nu, numero_cas, division_clase)
			select concat(noparte, '-'), tipo_material_id, descripcion_esp, descripcion_ing, peso_unitario_kg, medida_id_mx, pais_id_origen, eccn, fecha_ultima_modificacion
			, fecha_creacion, marca, modelo, serie, numero_activo, ubicacion, vida_util, etiqueto, foto, tipo_catalogo_id, medida_id_extranjera
			, factor_conversion, costo_unitario_dll, activo, tipo_adquisicion_id, peso_libras, ext_art_25, comentario_foto, fecha_carga_foto, prosec_id_tasa
			, licence, numero_nu, numero_cas, division_clase
			from a24.parte
			where id = id_noparte;
			
			-- get last id inserted
			SET @last_id_noparte = LAST_INSERT_ID();
			
			-- duplicate parte_fraccion
			INSERT INTO a24.parte_fraccion (opcion_id_tarifa, parte_id, opcion_id_tipo_fraccion
			, opcion_id_tipo_operacion, fraccion_id, umc, factor_conversion, umt, tasa_importacion, tasa_exportacion, no_grava_iva, ieps, fecha_inicio, fecha_final)
			select opcion_id_tarifa, @last_id_noparte, opcion_id_tipo_fraccion, opcion_id_tipo_operacion, fraccion_id, umc
			, factor_conversion, umt, tasa_importacion, tasa_exportacion, no_grava_iva, ieps, fecha_inicio, fecha_final
			from a24.parte_fraccion
			where 1 = 1
			and parte_id = id_noparte;
			
			INSERT INTO a24.parte_costo (parte_id, costo, activo, fecha_inicial, fecha_final, materia_prima_originaria
			, materia_prima_no_originaria, empaque_originario
			, empaque_no_originario, otros_costos_originario, otros_costos_no_originario, gasto_directo, gasto_indirecto, compra_nacional, proveedor_id, opcion_id_tipo_costo)
			select
			@last_id_noparte, costo, activo, fecha_inicial, fecha_final, materia_prima_originaria
			, materia_prima_no_originaria, empaque_originario
			, empaque_no_originario, otros_costos_originario, otros_costos_no_originario, gasto_directo, gasto_indirecto, compra_nacional, proveedor_id, opcion_id_tipo_costo
			from a24.parte_costo
			where 1 = 1
			and parte_costo.parte_id = id_noparte;
		else
			select concat(noparte, ' no existe en la bd a24.') 'message';
		end if;
END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
