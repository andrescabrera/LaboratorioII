SELECT * FROM producto;
DELETE FROM producto;
DELETE FROM materiaprima;
SELECT * FROM materiaprima;
SELECT id FROM producto WHERE nombre =;
SELECT id FROM producto WHERE nombre = 'Pinza';
INSERT INTO (nombre, costo) VALUES ('" + actual.getNombre() +"', "+ actual.getCosto()+")
INSERT INTO producto () VALUES ();
INSERT INTO materiaprima (nombre, costo) VALUES ('Tornillo Eje de Pinza', 9);
DELETE FROM materiaprima WHERE id = 3;
UPDATE producto SET id_materiaprima = 1 WHERE id = 1;
SELECT id FROM producto WHERE nombre = 'Pinza';
-- ---
-- Globals
-- ---

-- SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
-- SET FOREIGN_KEY_CHECKS=0;

-- ---
-- Table 'materiaprima'
--
-- ---

DROP TABLE IF EXISTS `materiaprima`;

CREATE TABLE `materiaprima` (
  `id` INTEGER AUTO_INCREMENT DEFAULT NULL,
  `nombre` VARCHAR(45) DEFAULT NULL,
  `costo` INTEGER DEFAULT NULL,
  `id_producto` INTEGER DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- ---
-- Table 'producto'
--
-- ---

DROP TABLE IF EXISTS `producto`;

CREATE TABLE `producto` (
  `id` INTEGER AUTO_INCREMENT DEFAULT NULL,
  `nombre` VARCHAR(45) DEFAULT NULL,
  `costo` INTEGER NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
);

-- ---
-- Foreign Keys
-- ---

ALTER TABLE `materiaprima` ADD FOREIGN KEY (id_producto) REFERENCES `producto` (`id`);

-- ---
-- Table Properties
-- ---

-- ALTER TABLE `materiaprima` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `producto` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ---
-- Test Data
-- ---

-- INSERT INTO `materiaprima` (`id`,`nombre`,`costo`,`id_producto`) VALUES
-- ('','','','');
-- INSERT INTO `producto` (`id`,`nombre`,`costo`) VALUES
-- ('','','');