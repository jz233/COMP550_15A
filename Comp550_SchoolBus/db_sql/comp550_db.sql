/*
SQLyog Ultimate v11.11 (64 bit)
MySQL - 5.5.25 : Database - schoolbusdb
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`schoolbusdb` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `schoolbusdb`;

/*Table structure for table `trip` */

DROP TABLE IF EXISTS `trip`;

CREATE TABLE `trip` (
  `tripID` int(11) NOT NULL AUTO_INCREMENT,
  `trip_date` datetime NOT NULL,
  `trip_name` varchar(45) NOT NULL,
  `trip_status` double DEFAULT '0' COMMENT '0 = not started, 0.5 = on going, 1 = finished.',
  PRIMARY KEY (`tripID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*Data for the table `trip` */

insert  into `trip`(`tripID`,`trip_date`,`trip_name`,`trip_status`) values (1,'2015-05-06 17:07:47','trip_1',1),(2,'2015-05-10 12:18:39','trip_2',0);

/*Table structure for table `trip_has_user` */

DROP TABLE IF EXISTS `trip_has_user`;

CREATE TABLE `trip_has_user` (
  `trip_tripID` int(11) NOT NULL,
  `user_userID` int(11) NOT NULL,
  `driver_lat` varchar(45) NOT NULL,
  `driver_lng` varchar(45) NOT NULL,
  `user_in_trip_status` double DEFAULT '0' COMMENT '0 = waiting, 1 = picked up.',
  PRIMARY KEY (`trip_tripID`,`user_userID`),
  KEY `fk_trip_has_user_user1` (`user_userID`),
  KEY `fk_trip_has_user_trip` (`trip_tripID`),
  CONSTRAINT `fk_trip_has_user_trip` FOREIGN KEY (`trip_tripID`) REFERENCES `trip` (`tripID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_trip_has_user_user1` FOREIGN KEY (`user_userID`) REFERENCES `user` (`userID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `trip_has_user` */

insert  into `trip_has_user`(`trip_tripID`,`user_userID`,`driver_lat`,`driver_lng`,`user_in_trip_status`) values (1,1,'-37.765595','175.300544',0);

/*Table structure for table `user` */

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `userID` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  `role` int(11) NOT NULL DEFAULT '1',
  `user_lat` varchar(45) DEFAULT NULL,
  `user_lng` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`userID`),
  UNIQUE KEY `username_UNIQUE` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

/*Data for the table `user` */

insert  into `user`(`userID`,`username`,`password`,`role`,`user_lat`,`user_lng`) values (1,'Adam','123',1,'-37.787568','175.267308'),(2,'Bob','123',1,'-37.783909','175.306793'),(3,'Chris','123',1,'-37.794752','175.293888'),(4,'Daniel','123',1,'-37.778120','175.281325'),(5,'Emmy','123',1,'-37.794302','175.329991');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
