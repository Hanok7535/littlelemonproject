-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema littlelemondm
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema littlelemondm
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `littlelemondm` DEFAULT CHARACTER SET utf8mb3 ;
USE `littlelemondm` ;

-- -----------------------------------------------------
-- Table `littlelemondm`.`customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `littlelemondm`.`customers` (
  `customerid` INT NOT NULL,
  `fullname` VARCHAR(100) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `contactnumber` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`customerid`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `littlelemondm`.`bookings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `littlelemondm`.`bookings` (
  `bookingid` INT NOT NULL,
  `bookingdate` DATE NOT NULL,
  `tablenumber` INT NOT NULL,
  `customerid` INT NOT NULL,
  PRIMARY KEY (`bookingid`),
  INDEX `customer_id_fk_idx` (`customerid` ASC) VISIBLE,
  CONSTRAINT `booking_customer_id_fk`
    FOREIGN KEY (`customerid`)
    REFERENCES `littlelemondm`.`customers` (`customerid`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `littlelemondm`.`menuitems`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `littlelemondm`.`menuitems` (
  `menuitemid` INT NOT NULL,
  `menuitemname` VARCHAR(100) NOT NULL,
  `type` VARCHAR(45) NOT NULL,
  `price` DECIMAL(10,2) NOT NULL,
  `stock` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`menuitemid`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `littlelemondm`.`menu`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `littlelemondm`.`menu` (
  `menuid` INT NOT NULL,
  `menuname` VARCHAR(100) NOT NULL,
  `cuisine` VARCHAR(100) NOT NULL,
  `menuitemid` INT NOT NULL,
  PRIMARY KEY (`menuid`),
  INDEX `menuitem_id_fk_idx` (`menuitemid` ASC) VISIBLE,
  CONSTRAINT `menuitem_id_fk`
    FOREIGN KEY (`menuitemid`)
    REFERENCES `littlelemondm`.`menuitems` (`menuitemid`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `littlelemondm`.`orderdeliverystatus`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `littlelemondm`.`orderdeliverystatus` (
  `orderdeliveryid` INT NOT NULL,
  `status` VARCHAR(100) NOT NULL,
  `deliverydate` DATE NOT NULL,
  PRIMARY KEY (`orderdeliveryid`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `littlelemondm`.`staff`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `littlelemondm`.`staff` (
  `staffid` INT NOT NULL,
  `staffname` VARCHAR(100) NOT NULL,
  `role` VARCHAR(45) NOT NULL,
  `salary` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`staffid`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `littlelemondm`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `littlelemondm`.`orders` (
  `orderid` INT NOT NULL,
  `orderdate` DATE NOT NULL,
  `quantity` INT NOT NULL,
  `totalcost` DECIMAL(10,2) NOT NULL,
  `menuid` INT NOT NULL,
  `customerid` INT NOT NULL,
  `staffid` INT NOT NULL,
  `orderdeliveryid` INT NOT NULL,
  PRIMARY KEY (`orderid`),
  INDEX `customer_id_fk_idx` (`customerid` ASC) VISIBLE,
  INDEX `menu_item_fk_idx` (`menuid` ASC) VISIBLE,
  INDEX `staff_id_fk_idx` (`staffid` ASC) VISIBLE,
  INDEX `orderdelivery_id_fk_idx` (`orderdeliveryid` ASC) VISIBLE,
  CONSTRAINT `customer_id_fk`
    FOREIGN KEY (`customerid`)
    REFERENCES `littlelemondm`.`customers` (`customerid`),
  CONSTRAINT `menu_item_fk`
    FOREIGN KEY (`menuid`)
    REFERENCES `littlelemondm`.`menu` (`menuid`),
  CONSTRAINT `orderdelivery_id_fk`
    FOREIGN KEY (`orderdeliveryid`)
    REFERENCES `littlelemondm`.`orderdeliverystatus` (`orderdeliveryid`),
  CONSTRAINT `staff_id_fk`
    FOREIGN KEY (`staffid`)
    REFERENCES `littlelemondm`.`staff` (`staffid`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
