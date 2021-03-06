-- MySQL Script generated by MySQL Workbench
-- Sun Feb 14 15:45:01 2021
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
-- Table `mydb`.`Opérateurs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Opérateurs` (
  `id_opé` INT GENERATED ALWAYS AS () VIRTUAL,
  `mail` VARCHAR(45) NULL,
  `région` VARCHAR(45) NULL,
  `établissement` VARCHAR(45) NULL,
  `filiale` VARCHAR(45) NULL,
  `poste` VARCHAR(45) NULL,
  PRIMARY KEY (`id_opé`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`DA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`DA` (
  `Ref_DA` INT NOT NULL,
  `date` DATE NULL,
  `article_demandé` VARCHAR(45) NULL,
  `quantité` INT NULL,
  `adresse_livraison` VARCHAR(45) NULL,
  `id_demandeur` VARCHAR(45) NULL,
  `fk_Ref_DA` VARCHAR(45) NULL,
  `DA_Ref_DA` INT NOT NULL,
  `Opérateurs_id_opé` INT NOT NULL,
  PRIMARY KEY (`Ref_DA`, `Opérateurs_id_opé`),
  INDEX `fk_DA_Opérateurs1_idx` (`Opérateurs_id_opé` ASC) VISIBLE,
  CONSTRAINT `fk_DA_Opérateurs1`
    FOREIGN KEY (`Opérateurs_id_opé`)
    REFERENCES `mydb`.`Opérateurs` (`id_opé`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Commandes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Commandes` (
  `Ref_commande` INT GENERATED ALWAYS AS () VIRTUAL,
  `date` DATE NULL,
  `Ref_article` VARCHAR(45) NULL,
  `quantité` INT NULL,
  `id_fournisseur` VARCHAR(45) NULL,
  `adresse_livraison` VARCHAR(45) NULL,
  `id_demandeur` VARCHAR(45) NULL,
  PRIMARY KEY (`Ref_commande`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Factures`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Factures` (
  `id_facture` INT GENERATED ALWAYS AS (),
  `date` DATE NULL,
  `ref_article` VARCHAR(45) NULL,
  `quantité` DATE NULL,
  `id_fournisseur` VARCHAR(45) NULL,
  `adresse_livraison` VARCHAR(45) NULL,
  PRIMARY KEY (`id_facture`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Articles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Articles` (
  `ref_article` VARCHAR(45) NOT NULL,
  `famille` VARCHAR(45) NULL,
  `sous_famille` VARCHAR(45) NULL,
  `fournisseur` VARCHAR(45) NULL,
  PRIMARY KEY (`ref_article`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Fournisseurs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Fournisseurs` (
  `id_fournisseur` VARCHAR(45) NOT NULL,
  `nom` VARCHAR(45) NULL,
  `adresse` VARCHAR(45) NULL,
  `contact` VARCHAR(45) NULL,
  PRIMARY KEY (`id_fournisseur`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`comptabilisation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`comptabilisation` (
  `fk_Ref_commande` INT NOT NULL,
  `fk_id_facture` INT NOT NULL,
  PRIMARY KEY (`fk_Ref_commande`, `fk_id_facture`),
  INDEX `fk_Commandes_has_Factures_Factures1_idx` (`fk_id_facture` ASC) VISIBLE,
  INDEX `fk_Commandes_has_Factures_Commandes1_idx` (`fk_Ref_commande` ASC) VISIBLE,
  CONSTRAINT `fk_Commandes_has_Factures_Commandes1`
    FOREIGN KEY (`fk_Ref_commande`)
    REFERENCES `mydb`.`Commandes` (`Ref_commande`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Commandes_has_Factures_Factures1`
    FOREIGN KEY (`fk_id_facture`)
    REFERENCES `mydb`.`Factures` (`id_facture`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`composition_article`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`composition_article` (
  `fk_Ref_commande` INT NOT NULL,
  `fk_ref_article` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`fk_Ref_commande`, `fk_ref_article`),
  INDEX `fk_Commandes_has_Articles_Articles1_idx` (`fk_ref_article` ASC) VISIBLE,
  INDEX `fk_Commandes_has_Articles_Commandes1_idx` (`fk_Ref_commande` ASC) VISIBLE,
  CONSTRAINT `fk_Commandes_has_Articles_Commandes1`
    FOREIGN KEY (`fk_Ref_commande`)
    REFERENCES `mydb`.`Commandes` (`Ref_commande`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Commandes_has_Articles_Articles1`
    FOREIGN KEY (`fk_ref_article`)
    REFERENCES `mydb`.`Articles` (`ref_article`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`composition_fournisseur`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`composition_fournisseur` (
  `fk_Ref_commande` INT NOT NULL,
  `fk_id_fournisseur` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`fk_Ref_commande`, `fk_id_fournisseur`),
  INDEX `fk_Commandes_has_Fournisseurs_Fournisseurs1_idx` (`fk_id_fournisseur` ASC) VISIBLE,
  INDEX `fk_Commandes_has_Fournisseurs_Commandes1_idx` (`fk_Ref_commande` ASC) VISIBLE,
  CONSTRAINT `fk_Commandes_has_Fournisseurs_Commandes1`
    FOREIGN KEY (`fk_Ref_commande`)
    REFERENCES `mydb`.`Commandes` (`Ref_commande`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Commandes_has_Fournisseurs_Fournisseurs1`
    FOREIGN KEY (`fk_id_fournisseur`)
    REFERENCES `mydb`.`Fournisseurs` (`id_fournisseur`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`concretisation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`concretisation` (
  `fk_Ref_DA` INT NOT NULL,
  `fk_Ref_commade` INT NOT NULL,
  PRIMARY KEY (`fk_Ref_DA`, `fk_Ref_commade`),
  INDEX `fk_Commandes_has_DA_DA1_idx` (`fk_Ref_commade` ASC) VISIBLE,
  INDEX `fk_Commandes_has_DA_Commandes1_idx` (`fk_Ref_DA` ASC) VISIBLE,
  CONSTRAINT `fk_Commandes_has_DA_Commandes1`
    FOREIGN KEY (`fk_Ref_DA`)
    REFERENCES `mydb`.`Commandes` (`Ref_commande`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Commandes_has_DA_DA1`
    FOREIGN KEY (`fk_Ref_commade`)
    REFERENCES `mydb`.`DA` (`Ref_DA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
