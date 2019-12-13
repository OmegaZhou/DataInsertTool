-- MySQL Script generated by MySQL Workbench
-- Tue Dec  3 19:50:59 2019
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema data_warehouse
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema data_warehouse
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `data_warehouse` DEFAULT CHARACTER SET utf8 ;
USE `data_warehouse` ;

-- -----------------------------------------------------
-- Table `data_warehouse`.`actor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `data_warehouse`.`actor` ;

CREATE TABLE IF NOT EXISTS `data_warehouse`.`actor` (
  `actor_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(300) NOT NULL,
  `actor_count` INT NULL DEFAULT 0,
  `starring_count` INT NULL DEFAULT 0,
  `supporting_count` INT NULL DEFAULT 0,
  `actor_movies` LONGTEXT NULL,
  `starring_movies` LONGTEXT NULL,
  `supporting_movies` LONGTEXT NULL,
  PRIMARY KEY (`actor_id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `data_warehouse`.`actor_corporation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `data_warehouse`.`actor_corporation` ;

CREATE TABLE IF NOT EXISTS `data_warehouse`.`actor_corporation` (
  `actor_id1` INT NOT NULL,
  `actor_id2` INT NOT NULL,
  `actor_name1` VARCHAR(300) NOT NULL,
  `actor_name2` VARCHAR(300) NOT NULL,
  `count` INT NULL DEFAULT 0,
  `movies` LONGTEXT NULL,
  PRIMARY KEY (`actor_id1`, `actor_id2`),
  INDEX `actor_id2_FK_idx` (`actor_id2` ASC) VISIBLE,
  UNIQUE INDEX `name_index_UNIQUE` (`actor_name1` ASC, `actor_name2` ASC) VISIBLE,
  INDEX `count_index` (`count` ASC) VISIBLE,
  CONSTRAINT `actor_id1_FK`
    FOREIGN KEY (`actor_id1`)
    REFERENCES `data_warehouse`.`actor` (`actor_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `actor_id2_FK`
    FOREIGN KEY (`actor_id2`)
    REFERENCES `data_warehouse`.`actor` (`actor_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `data_warehouse`.`date`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `data_warehouse`.`date` ;

CREATE TABLE IF NOT EXISTS `data_warehouse`.`date` (
  `date_id` INT NOT NULL AUTO_INCREMENT,
  `year` INT NULL,
  `month` INT NULL,
  `day` INT NULL,
  `weekday` INT NULL,
  `count` INT NULL DEFAULT 0,
  `movies` LONGTEXT NULL DEFAULT NULL,
  `date_str` VARCHAR(45) NULL,
  PRIMARY KEY (`date_id`),
  INDEX `year_index` (`year` ASC, `month` ASC, `day` ASC) INVISIBLE,
  INDEX `month_index` (`month` ASC, `day` ASC) VISIBLE,
  INDEX `weekday_index` (`weekday` ASC) VISIBLE,
  INDEX `day_index` (`day` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `data_warehouse`.`director`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `data_warehouse`.`director` ;

CREATE TABLE IF NOT EXISTS `data_warehouse`.`director` (
  `director_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `director_count` INT NULL DEFAULT 0,
  `director_movies` LONGTEXT NULL,
  PRIMARY KEY (`director_id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
KEY_BLOCK_SIZE = 1;


-- -----------------------------------------------------
-- Table `data_warehouse`.`director_actor_corporation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `data_warehouse`.`director_actor_corporation` ;

CREATE TABLE IF NOT EXISTS `data_warehouse`.`director_actor_corporation` (
  `director_id` INT NOT NULL,
  `actor_id` INT NOT NULL,
  `director_name` VARCHAR(300) NOT NULL,
  `actor_name` VARCHAR(300) NOT NULL,
  `count` INT NULL DEFAULT 0,
  `movies` LONGTEXT NULL,
  PRIMARY KEY (`director_id`, `actor_id`),
  INDEX `actor_id_FK_idx` (`actor_id` ASC) INVISIBLE,
  INDEX `director_id_FK_idx` (`director_id` ASC) INVISIBLE,
  UNIQUE INDEX `name_index_UNIQUE` (`director_name` ASC, `actor_name` ASC) INVISIBLE,
  INDEX `count_index` (`count` ASC) VISIBLE,
  CONSTRAINT `actor_id_cor_FK`
    FOREIGN KEY (`actor_id`)
    REFERENCES `data_warehouse`.`actor` (`actor_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `director_id_cor_FK`
    FOREIGN KEY (`director_id`)
    REFERENCES `data_warehouse`.`director` (`director_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `data_warehouse`.`genre`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `data_warehouse`.`genre` ;

CREATE TABLE IF NOT EXISTS `data_warehouse`.`genre` (
  `genre_id` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`genre_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `data_warehouse`.`actors_group`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `data_warehouse`.`actors_group` ;

CREATE TABLE IF NOT EXISTS `data_warehouse`.`actors_group` (
  `actors_group_id` INT NOT NULL AUTO_INCREMENT,
  `actor_id` INT NOT NULL,
  `names` VARCHAR(6000) NULL DEFAULT NULL,
  `count` INT NULL DEFAULT NULL,
  PRIMARY KEY (`actors_group_id`, `actor_id`),
  INDEX `actor_id_FK_idx` (`actor_id` ASC) VISIBLE,
  CONSTRAINT `actor_id_FK`
    FOREIGN KEY (`actor_id`)
    REFERENCES `data_warehouse`.`actor` (`actor_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `data_warehouse`.`starrings_group`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `data_warehouse`.`starrings_group` ;

CREATE TABLE IF NOT EXISTS `data_warehouse`.`starrings_group` (
  `starrings_group_id` INT NOT NULL AUTO_INCREMENT,
  `starring_id` INT NOT NULL,
  `names` VARCHAR(6000) NULL,
  `count` INT NULL DEFAULT 0,
  PRIMARY KEY (`starrings_group_id`, `starring_id`),
  INDEX `starring_id_FK_idx` (`starring_id` ASC) VISIBLE,
  CONSTRAINT `starring_id_FK`
    FOREIGN KEY (`starring_id`)
    REFERENCES `data_warehouse`.`actor` (`actor_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `data_warehouse`.`supportings_group`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `data_warehouse`.`supportings_group` ;

CREATE TABLE IF NOT EXISTS `data_warehouse`.`supportings_group` (
  `supportings_group_id` INT NOT NULL AUTO_INCREMENT,
  `supporting_id` INT NOT NULL,
  `names` VARCHAR(6000) NULL,
  `count` INT NULL DEFAULT 0,
  PRIMARY KEY (`supportings_group_id`, `supporting_id`),
  INDEX `supporting_id_FK_idx` (`supporting_id` ASC) INVISIBLE,
  CONSTRAINT `supporting_id_FK`
    FOREIGN KEY (`supporting_id`)
    REFERENCES `data_warehouse`.`actor` (`actor_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `data_warehouse`.`directors_group`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `data_warehouse`.`directors_group` ;

CREATE TABLE IF NOT EXISTS `data_warehouse`.`directors_group` (
  `directors_group_id` INT NOT NULL AUTO_INCREMENT,
  `director_id` INT NOT NULL,
  `count` INT NULL DEFAULT 0,
  `names` VARCHAR(1000) NULL DEFAULT NULL,
  PRIMARY KEY (`directors_group_id`, `director_id`),
  INDEX `director_id_FK_idx` (`director_id` ASC) VISIBLE,
  CONSTRAINT `director_id_FK`
    FOREIGN KEY (`director_id`)
    REFERENCES `data_warehouse`.`director` (`director_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `data_warehouse`.`ranking`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `data_warehouse`.`ranking` ;

CREATE TABLE IF NOT EXISTS `data_warehouse`.`ranking` (
  `ranking_id` INT NOT NULL AUTO_INCREMENT,
  `count` INT NULL DEFAULT 0,
  `movies` LONGTEXT NULL DEFAULT NULL,
  `score` DOUBLE NULL,
  PRIMARY KEY (`ranking_id`),
  UNIQUE INDEX `score_UNIQUE` (`score` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `data_warehouse`.`product`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `data_warehouse`.`product` ;

CREATE TABLE IF NOT EXISTS `data_warehouse`.`product` (
  `product_id` INT NOT NULL AUTO_INCREMENT,
  `price` VARCHAR(20) NULL DEFAULT NULL,
  `format` VARCHAR(50) NULL DEFAULT NULL,
  `asin` VARCHAR(50) NULL DEFAULT NULL,
  PRIMARY KEY (`product_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `data_warehouse`.`products_group`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `data_warehouse`.`products_group` ;

CREATE TABLE IF NOT EXISTS `data_warehouse`.`products_group` (
  `product_group_id` INT NOT NULL AUTO_INCREMENT,
  `product_id` INT NOT NULL,
  PRIMARY KEY (`product_group_id`, `product_id`),
  INDEX `product_id_FK_idx` (`product_id` ASC) VISIBLE,
  CONSTRAINT `product_id_FK`
    FOREIGN KEY (`product_id`)
    REFERENCES `data_warehouse`.`product` (`product_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `data_warehouse`.`movie`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `data_warehouse`.`movie` ;

CREATE TABLE IF NOT EXISTS `data_warehouse`.`movie` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `genre_id` INT NOT NULL,
  `date_id` INT NOT NULL,
  `ranking_id` INT NOT NULL,
  `actors_group_id` INT NULL,
  `products_group_id` INT NULL,
  `starrings_group_id` INT NULL,
  `supportings_group_id` INT NULL,
  `directors_group_id` INT NULL,
  `name` VARCHAR(500) NOT NULL,
  `num_of_count` INT NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  INDEX `genre_FK_idx` (`genre_id` ASC) VISIBLE,
  INDEX `actors_in_movie_FK_idx` (`actors_group_id` ASC) VISIBLE,
  INDEX `starrings_group_id_FK_idx` (`starrings_group_id` ASC) VISIBLE,
  INDEX `supporting_actors_group_id_FK_idx` (`supportings_group_id` ASC) VISIBLE,
  INDEX `date_FK_idx` (`date_id` ASC) VISIBLE,
  INDEX `directors_group_id_FK_idx` (`directors_group_id` ASC) VISIBLE,
  INDEX `ranking_FK_idx` (`ranking_id` ASC) INVISIBLE,
  INDEX `products_group_FK_idx` (`products_group_id` ASC) VISIBLE,
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE,
  CONSTRAINT `genre_FK`
    FOREIGN KEY (`genre_id`)
    REFERENCES `data_warehouse`.`genre` (`genre_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `actors_group_id_FK`
    FOREIGN KEY (`actors_group_id`)
    REFERENCES `data_warehouse`.`actors_group` (`actors_group_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `starrings_group_id_FK`
    FOREIGN KEY (`starrings_group_id`)
    REFERENCES `data_warehouse`.`starrings_group` (`starrings_group_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `supporting_group_id_FK`
    FOREIGN KEY (`supportings_group_id`)
    REFERENCES `data_warehouse`.`supportings_group` (`supportings_group_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `date_FK`
    FOREIGN KEY (`date_id`)
    REFERENCES `data_warehouse`.`date` (`date_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `directors_group_id_FK`
    FOREIGN KEY (`directors_group_id`)
    REFERENCES `data_warehouse`.`directors_group` (`directors_group_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `ranking_FK`
    FOREIGN KEY (`ranking_id`)
    REFERENCES `data_warehouse`.`ranking` (`ranking_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `products_group_FK`
    FOREIGN KEY (`products_group_id`)
    REFERENCES `data_warehouse`.`products_group` (`product_group_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `data_warehouse`.`review`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `data_warehouse`.`review` ;

CREATE TABLE IF NOT EXISTS `data_warehouse`.`review` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `product_id` INT NULL,
  `userId` VARCHAR(50) NULL DEFAULT NULL,
  `profileName` VARCHAR(50) NULL DEFAULT NULL,
  `helpfulness` VARCHAR(50) NULL DEFAULT NULL,
  `score` DOUBLE NULL DEFAULT NULL,
  `time` INT NULL DEFAULT NULL,
  `summary` TEXT NULL DEFAULT NULL,
  `text` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `data_warehouse`.`genre_names`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `data_warehouse`.`genre_names` ;

CREATE TABLE IF NOT EXISTS `data_warehouse`.`genre_names` (
  `genre_name` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`genre_name`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
