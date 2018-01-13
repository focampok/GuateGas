-- MySQL Script generated by MySQL Workbench
-- 08/26/17 15:11:35
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema bd_mem
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema bd_mem
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `bd_mem` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `bd_mem` ;

-- -----------------------------------------------------
-- Table `bd_mem`.`CUENTA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_mem`.`CUENTA` (
  `codigo_cuenta` VARCHAR(45) NOT NULL COMMENT '',
  `nombre` VARCHAR(45) NOT NULL COMMENT '',
  PRIMARY KEY (`codigo_cuenta`)  COMMENT '')
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bd_mem`.`DEPARTAMENTO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_mem`.`DEPARTAMENTO` (
  `codigo_departamento` VARCHAR(45) NOT NULL COMMENT '',
  `nombre` VARCHAR(45) NOT NULL COMMENT '',
  PRIMARY KEY (`codigo_departamento`)  COMMENT '')
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bd_mem`.`ADICION`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_mem`.`ADICION` (
  `codigo_adicion` VARCHAR(45) NOT NULL COMMENT '',
  `nombre_adicion` VARCHAR(45) NOT NULL COMMENT '',
  PRIMARY KEY (`codigo_adicion`)  COMMENT '')
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bd_mem`.`ACTA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_mem`.`ACTA` (
  `codigo_acta` VARCHAR(45) NOT NULL COMMENT '',
  `fecha` VARCHAR(45) NULL COMMENT '',
  `hora` VARCHAR(45) NULL COMMENT '',
  `estado` INT NULL COMMENT '',
  PRIMARY KEY (`codigo_acta`)  COMMENT '')
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bd_mem`.`CERTIFICACION`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_mem`.`CERTIFICACION` (
  `codigo_certificacion` VARCHAR(45) NOT NULL COMMENT '',
  `fecha` VARCHAR(45) NOT NULL COMMENT '',
  `estado` INT NULL COMMENT '',
  PRIMARY KEY (`codigo_certificacion`)  COMMENT '')
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bd_mem`.`ACTIVO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_mem`.`ACTIVO` (
  `codigo_inventario` VARCHAR(45) NOT NULL COMMENT '',
  `folio` INT NOT NULL COMMENT '',
  `fecha` VARCHAR(45) NOT NULL COMMENT '',
  `CUENTA_codigo_cuenta` VARCHAR(45) NOT NULL COMMENT '',
  `codigo_subcuenta` VARCHAR(45) NOT NULL COMMENT '',
  `estado` INT NOT NULL COMMENT '',
  `cantidad` INT NOT NULL COMMENT '',
  `marca` VARCHAR(45) NULL COMMENT '',
  `modelo` VARCHAR(45) NULL COMMENT '',
  `serie` VARCHAR(45) NULL COMMENT '',
  `descripcion` VARCHAR(255) NOT NULL COMMENT '',
  `precio_unitario` FLOAT NOT NULL COMMENT '',
  `subtotal` FLOAT NOT NULL COMMENT '',
  `DEPARTAMENTO_codigo_departamento` VARCHAR(45) NOT NULL COMMENT '',
  `nit` VARCHAR(45) NULL COMMENT '',
  `nombre` VARCHAR(45) NULL COMMENT '',
  `ADICION_codigo_adicion` VARCHAR(45) NOT NULL COMMENT '',
  `ACTA_codigo_acta` VARCHAR(45) NOT NULL COMMENT '',
  `CERTIFICACION_codigo_certificacion` VARCHAR(45) NOT NULL COMMENT '',
  `cantidad_cert` INT NULL COMMENT '',
  PRIMARY KEY (`codigo_inventario`)  COMMENT '',
  INDEX `fk_ACTIVO_CUENTA1_idx` (`CUENTA_codigo_cuenta` ASC)  COMMENT '',
  INDEX `fk_ACTIVO_DEPARTAMENTO1_idx` (`DEPARTAMENTO_codigo_departamento` ASC)  COMMENT '',
  INDEX `fk_ACTIVO_ADICION1_idx` (`ADICION_codigo_adicion` ASC)  COMMENT '',
  INDEX `fk_ACTIVO_ACTA1_idx` (`ACTA_codigo_acta` ASC)  COMMENT '',
  INDEX `fk_ACTIVO_CERTIFICACION1_idx` (`CERTIFICACION_codigo_certificacion` ASC)  COMMENT '',
  CONSTRAINT `fk_ACTIVO_CUENTA1`
    FOREIGN KEY (`CUENTA_codigo_cuenta`)
    REFERENCES `bd_mem`.`CUENTA` (`codigo_cuenta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ACTIVO_DEPARTAMENTO1`
    FOREIGN KEY (`DEPARTAMENTO_codigo_departamento`)
    REFERENCES `bd_mem`.`DEPARTAMENTO` (`codigo_departamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ACTIVO_ADICION1`
    FOREIGN KEY (`ADICION_codigo_adicion`)
    REFERENCES `bd_mem`.`ADICION` (`codigo_adicion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ACTIVO_ACTA1`
    FOREIGN KEY (`ACTA_codigo_acta`)
    REFERENCES `bd_mem`.`ACTA` (`codigo_acta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ACTIVO_CERTIFICACION1`
    FOREIGN KEY (`CERTIFICACION_codigo_certificacion`)
    REFERENCES `bd_mem`.`CERTIFICACION` (`codigo_certificacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bd_mem`.`SUBCUENTA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_mem`.`SUBCUENTA` (
  `codigo_subcuenta` VARCHAR(45) NOT NULL COMMENT '',
  `nombre` VARCHAR(45) NOT NULL COMMENT '',
  `CUENTA_codigo_cuenta` VARCHAR(45) NOT NULL COMMENT '',
  PRIMARY KEY (`codigo_subcuenta`)  COMMENT '',
  INDEX `fk_SUBCUENTA_CUENTA1_idx` (`CUENTA_codigo_cuenta` ASC)  COMMENT '',
  CONSTRAINT `fk_SUBCUENTA_CUENTA1`
    FOREIGN KEY (`CUENTA_codigo_cuenta`)
    REFERENCES `bd_mem`.`CUENTA` (`codigo_cuenta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bd_mem`.`USUARIO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_mem`.`USUARIO` (
  `nit` VARCHAR(45) NOT NULL COMMENT '',
  `nombre` VARCHAR(45) NOT NULL COMMENT '',
  `apellido` VARCHAR(45) NOT NULL COMMENT '',
  `puesto` VARCHAR(60) NOT NULL COMMENT '',
  `password` VARCHAR(45) NOT NULL COMMENT '',
  `tipo` INT NOT NULL COMMENT '',
  `DEPARTAMENTO_codigo_departamento` VARCHAR(45) NOT NULL COMMENT '',
  PRIMARY KEY (`nit`)  COMMENT '',
  INDEX `fk_USUARIO_DEPARTAMENTO1_idx` (`DEPARTAMENTO_codigo_departamento` ASC)  COMMENT '',
  CONSTRAINT `fk_USUARIO_DEPARTAMENTO1`
    FOREIGN KEY (`DEPARTAMENTO_codigo_departamento`)
    REFERENCES `bd_mem`.`DEPARTAMENTO` (`codigo_departamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bd_mem`.`BITACORA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_mem`.`BITACORA` (
  `codigo_bitacora` INT NOT NULL AUTO_INCREMENT COMMENT '',
  `fecha` VARCHAR(45) NOT NULL COMMENT '',
  `accion` VARCHAR(255) NOT NULL COMMENT '',
  `USUARIO_nit` VARCHAR(45) NOT NULL COMMENT '',
  PRIMARY KEY (`codigo_bitacora`)  COMMENT '',
  INDEX `fk_BITACORA_USUARIO1_idx` (`USUARIO_nit` ASC)  COMMENT '',
  CONSTRAINT `fk_BITACORA_USUARIO1`
    FOREIGN KEY (`USUARIO_nit`)
    REFERENCES `bd_mem`.`USUARIO` (`nit`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
