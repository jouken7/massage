-- MySQL Script for creating the bookings table with relationships

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8;
USE `mydb`;

-- -----------------------------------------------------
-- Table `mydb`.`bookings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`bookings` (
  `booking_id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `room_id` INT NOT NULL,
  `booking_date` DATETIME(3) NOT NULL,
  `status` ENUM('Pending', 'Confirmed', 'Cancelled') NOT NULL,
  PRIMARY KEY (`booking_id`),
  INDEX `fk_user_id_idx` (`user_id` ASC),
  INDEX `fk_room_id_idx` (`room_id` ASC),
  CONSTRAINT `fk_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `mydb`.`users` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_room_id`
    FOREIGN KEY (`room_id`)
    REFERENCES `mydb`.`rooms` (`room_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `mydb`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`users` (
  `user_id` INT NOT NULL AUTO_INCREMENT,
  `full_name` VARCHAR(100) NOT NULL,
  `phone_number` VARCHAR(15) NOT NULL,
  `password_hash` VARCHAR(255) NOT NULL,
  `email` VARCHAR(255) NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE INDEX `phone_number_UNIQUE` (`phone_number` ASC) VISIBLE,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `mydb`.`rooms`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`rooms` (
  `room_id` INT NOT NULL AUTO_INCREMENT,
  `room_name` VARCHAR(50) NOT NULL,
  `type` ENUM('Regular', 'VIP') NOT NULL,
  PRIMARY KEY (`room_id`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `mydb`.`staff`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`staff` (
  `staff_id` INT NOT NULL AUTO_INCREMENT,
  `full_name` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`staff_id`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `mydb`.`room_staff`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`room_staff` (
  `room_staff_id` INT NOT NULL AUTO_INCREMENT,
  `room_id` INT NOT NULL,
  `staff_id` INT NOT NULL,
  PRIMARY KEY (`room_staff_id`),
  INDEX `fk_room_id_idx` (`room_id` ASC),
  INDEX `fk_staff_id_idx` (`staff_id` ASC),
  CONSTRAINT `fk_room_id`
    FOREIGN KEY (`room_id`)
    REFERENCES `mydb`.`rooms` (`room_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_staff_id`
    FOREIGN KEY (`staff_id`)
    REFERENCES `mydb`.`staff` (`staff_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;