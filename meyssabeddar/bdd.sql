-- MySQL Script generated by MySQL Workbench
-- Sun Feb 14 00:07:57 2021
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`MEDECIN`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`MEDECIN` (
  `id_MEDECIN` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NULL,
  `prenom` VARCHAR(45) NULL,
  PRIMARY KEY (`id_MEDECIN`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`PATIENT`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`PATIENT` (
  `id_PATIENT` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NULL,
  `prenom` VARCHAR(45) NULL,
  `adresse` VARCHAR(45) NULL,
  `ville` VARCHAR(45) NULL,
  `code_postal` VARCHAR(45) NULL,
  `sexe` VARCHAR(1) NULL,
  `date_nsce` DATETIME NULL,
  `date_crea_doss` DATETIME NULL,
  `mutuelle` VARCHAR(45) NULL,
  `num_ss` INT NULL,
  PRIMARY KEY (`id_PATIENT`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`PARCOURS_DE_SOIN`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`PARCOURS_DE_SOIN` (
  `id_COURRIER` INT NOT NULL AUTO_INCREMENT,
  `nom_MED_CONFRERE` VARCHAR(45) NULL,
  `prenom_MED_CONFRERE` VARCHAR(45) NULL,
  `specialite_MED_CONFRERE` VARCHAR(45) NULL,
  PRIMARY KEY (`id_COURRIER`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ORDONNANCE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ORDONNANCE` (
  `id_ORDONNANCE` INT NOT NULL AUTO_INCREMENT,
  `type_medicament` VARCHAR(45) NULL,
  `date_ord` DATETIME NULL,
  `MEDECIN_id_MEDECIN` INT NOT NULL,
  `PATIENT_id_PATIENT` INT NOT NULL,
  PRIMARY KEY (`id_ORDONNANCE`, `MEDECIN_id_MEDECIN`, `PATIENT_id_PATIENT`),
  INDEX `fk_ORDONNANCE_MEDECIN1_idx` (`MEDECIN_id_MEDECIN` ASC) VISIBLE,
  INDEX `fk_ORDONNANCE_PATIENT1_idx` (`PATIENT_id_PATIENT` ASC) VISIBLE,
  CONSTRAINT `fk_ORDONNANCE_MEDECIN1`
    FOREIGN KEY (`MEDECIN_id_MEDECIN`)
    REFERENCES `mydb`.`MEDECIN` (`id_MEDECIN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ORDONNANCE_PATIENT1`
    FOREIGN KEY (`PATIENT_id_PATIENT`)
    REFERENCES `mydb`.`PATIENT` (`id_PATIENT`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`MEDECIN_RECOMMANDE_PARCOURS_DE_SOIN`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`MEDECIN_RECOMMANDE_PARCOURS_DE_SOIN` (
  `MEDECIN_id_MEDECIN` INT NOT NULL,
  `PARCOURS_DE_SOIN_id_COURRIER` INT NOT NULL,
  PRIMARY KEY (`MEDECIN_id_MEDECIN`, `PARCOURS_DE_SOIN_id_COURRIER`),
  INDEX `fk_MEDECIN_has_PARCOURS_DE_SOIN_PARCOURS_DE_SOIN1_idx` (`PARCOURS_DE_SOIN_id_COURRIER` ASC) VISIBLE,
  INDEX `fk_MEDECIN_has_PARCOURS_DE_SOIN_MEDECIN_idx` (`MEDECIN_id_MEDECIN` ASC) VISIBLE,
  CONSTRAINT `fk_MEDECIN_has_PARCOURS_DE_SOIN_MEDECIN`
    FOREIGN KEY (`MEDECIN_id_MEDECIN`)
    REFERENCES `mydb`.`MEDECIN` (`id_MEDECIN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_MEDECIN_has_PARCOURS_DE_SOIN_PARCOURS_DE_SOIN1`
    FOREIGN KEY (`PARCOURS_DE_SOIN_id_COURRIER`)
    REFERENCES `mydb`.`PARCOURS_DE_SOIN` (`id_COURRIER`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`PATIENT_has_PARCOURS_DE_SOIN`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`PATIENT_has_PARCOURS_DE_SOIN` (
  `PARCOURS_DE_SOIN_id_COURRIER` INT NOT NULL,
  `PATIENT_id_PATIENT` INT NOT NULL,
  PRIMARY KEY (`PARCOURS_DE_SOIN_id_COURRIER`, `PATIENT_id_PATIENT`),
  INDEX `fk_PARCOURS_DE_SOIN_has_PATIENT_PATIENT1_idx` (`PATIENT_id_PATIENT` ASC) VISIBLE,
  INDEX `fk_PARCOURS_DE_SOIN_has_PATIENT_PARCOURS_DE_SOIN1_idx` (`PARCOURS_DE_SOIN_id_COURRIER` ASC) VISIBLE,
  CONSTRAINT `fk_PARCOURS_DE_SOIN_has_PATIENT_PARCOURS_DE_SOIN1`
    FOREIGN KEY (`PARCOURS_DE_SOIN_id_COURRIER`)
    REFERENCES `mydb`.`PARCOURS_DE_SOIN` (`id_COURRIER`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PARCOURS_DE_SOIN_has_PATIENT_PATIENT1`
    FOREIGN KEY (`PATIENT_id_PATIENT`)
    REFERENCES `mydb`.`PATIENT` (`id_PATIENT`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`CONSULTATION`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`CONSULTATION` (
  `id_CONSULTATION` INT NOT NULL AUTO_INCREMENT,
  `MEDECIN_id_MEDECIN` INT NOT NULL,
  `PATIENT_id_PATIENT` INT NOT NULL,
  `date_consultation` DATETIME NOT NULL,
  PRIMARY KEY (`id_CONSULTATION`, `MEDECIN_id_MEDECIN`, `PATIENT_id_PATIENT`),
  INDEX `fk_MEDECIN_has_PATIENT_PATIENT1_idx` (`PATIENT_id_PATIENT` ASC) VISIBLE,
  INDEX `fk_MEDECIN_has_PATIENT_MEDECIN1_idx` (`MEDECIN_id_MEDECIN` ASC) VISIBLE,
  CONSTRAINT `fk_MEDECIN_has_PATIENT_MEDECIN1`
    FOREIGN KEY (`MEDECIN_id_MEDECIN`)
    REFERENCES `mydb`.`MEDECIN` (`id_MEDECIN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_MEDECIN_has_PATIENT_PATIENT1`
    FOREIGN KEY (`PATIENT_id_PATIENT`)
    REFERENCES `mydb`.`PATIENT` (`id_PATIENT`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
