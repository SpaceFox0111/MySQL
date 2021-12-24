-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Semesterarbeit_MySQL_KarinTimcke
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Semesterarbeit_MySQL_KarinTimcke
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Semesterarbeit_MySQL_KarinTimcke` DEFAULT CHARACTER SET utf8 ;
USE `Semesterarbeit_MySQL_KarinTimcke` ;

-- -----------------------------------------------------
-- Table `Semesterarbeit_MySQL_KarinTimcke`.`Kunden`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Semesterarbeit_MySQL_KarinTimcke`.`Kunden` (
  `idKunden` INT NOT NULL,
  `Vorname` VARCHAR(45) NULL,
  `Nachname` VARCHAR(45) NULL,
  `StrasseHausNr` VARCHAR(45) NULL,
  `PLZ` INT NULL,
  `Ortschaft` VARCHAR(45) NULL,
  `Handy` INT NULL,
  `Email` VARCHAR(45) NULL,
  PRIMARY KEY (`idKunden`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Semesterarbeit_MySQL_KarinTimcke`.`Artikel`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Semesterarbeit_MySQL_KarinTimcke`.`Artikel` (
  `idArtikel` INT NOT NULL,
  `Artikelbezeichnung` VARCHAR(45) NULL,
  `Einkaufspreis` DECIMAL(10,2) NOT NULL,
  `Verkaufpreis` DECIMAL(10,2) NOT NULL,
  `Bestand_Artikel` INT NOT NULL,
  PRIMARY KEY (`idArtikel`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Semesterarbeit_MySQL_KarinTimcke`.`BestellungenVerkauf`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Semesterarbeit_MySQL_KarinTimcke`.`BestellungenVerkauf` (
  `idRechnungsnummer` INT NOT NULL,
  `Lieferdatum_Verkauf` DATETIME NULL,
  `Kunden_idKunden` INT NOT NULL,
  PRIMARY KEY (`idRechnungsnummer`),
  INDEX `fk_Bestellungen_Kunden_idx` (`Kunden_idKunden` ASC) VISIBLE,
  CONSTRAINT `fk_Bestellungen_Kunden`
    FOREIGN KEY (`Kunden_idKunden`)
    REFERENCES `Semesterarbeit_MySQL_KarinTimcke`.`Kunden` (`idKunden`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Semesterarbeit_MySQL_KarinTimcke`.`Lagerbestand`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Semesterarbeit_MySQL_KarinTimcke`.`Lagerbestand` (
  `idArtikel` INT NOT NULL,
  `idLager_Einkauf` INT NOT NULL,
  `Wareneinkauf_Menge` INT NOT NULL,
  `Wareneinkauf_Datum` DATETIME NULL,
  `BestellungenVerkauf_idRechnungsnummer` INT NOT NULL,
  PRIMARY KEY (`idArtikel`, `idLager_Einkauf`),
  INDEX `fk_Lagerbestand_BestellungenVerkauf1_idx` (`BestellungenVerkauf_idRechnungsnummer` ASC) VISIBLE,
  CONSTRAINT `fk_Lagerbestand_Artikel1`
    FOREIGN KEY (`idArtikel`)
    REFERENCES `Semesterarbeit_MySQL_KarinTimcke`.`Artikel` (`idArtikel`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Lagerbestand_BestellungenVerkauf1`
    FOREIGN KEY (`BestellungenVerkauf_idRechnungsnummer`)
    REFERENCES `Semesterarbeit_MySQL_KarinTimcke`.`BestellungenVerkauf` (`idRechnungsnummer`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Semesterarbeit_MySQL_KarinTimcke`.`VerkaufArtikel`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Semesterarbeit_MySQL_KarinTimcke`.`VerkaufArtikel` (
  `Artikel_idArtikel` INT NOT NULL,
  `Verkaufsmenge` INT NOT NULL,
  `BestellungenVerkauf_idRechnungsnummer` INT NOT NULL,
  PRIMARY KEY (`Artikel_idArtikel`, `BestellungenVerkauf_idRechnungsnummer`),
  INDEX `fk_Artikel_has_Bestellungen/Verkauf_Artikel1_idx` (`Artikel_idArtikel` ASC) VISIBLE,
  INDEX `fk_VerkaufArtikel_BestellungenVerkauf1_idx` (`BestellungenVerkauf_idRechnungsnummer` ASC) VISIBLE,
  CONSTRAINT `fk_Artikel_has_Bestellungen/Verkauf_Artikel1`
    FOREIGN KEY (`Artikel_idArtikel`)
    REFERENCES `Semesterarbeit_MySQL_KarinTimcke`.`Artikel` (`idArtikel`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_VerkaufArtikel_BestellungenVerkauf1`
    FOREIGN KEY (`BestellungenVerkauf_idRechnungsnummer`)
    REFERENCES `Semesterarbeit_MySQL_KarinTimcke`.`BestellungenVerkauf` (`idRechnungsnummer`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
