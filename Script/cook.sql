CREATE DATABASE `cook` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `cook`;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `firstname` varchar(60) DEFAULT NULL,
  `lastname` varchar(60) DEFAULT NULL,
  `password` varchar(64) DEFAULT NULL,
  `email` varchar(80) DEFAULT NULL,
  `social_id` varchar(45) DEFAULT NULL,
  `link` varchar(255) DEFAULT NULL,
  `avatar` varchar(100) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `activity` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `weather` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO activity (id,name,weather) VALUES(1,'Piscine','eclaircies');
INSERT INTO activity (id,name,weather) VALUES(2,'Pêcher','eclaircies');
INSERT INTO activity (id,name,weather) VALUES(3,'Football / BasketBall','eclaircies');
INSERT INTO activity (id,name,weather) VALUES(4,'Mécanique','eclaircies');
INSERT INTO activity (id,name,weather) VALUES(5,'Aller au zoo','eclaircies');
INSERT INTO activity (id,name,weather) VALUES(6,'Mini golf','eclaircies');
INSERT INTO activity (id,name,weather) VALUES(7,'Pêcher','eclaircies');
INSERT INTO activity (id,name,weather) VALUES(8,'Football / BasketBall','eclaircies');
INSERT INTO activity (id,name,weather) VALUES(9,'Pêcher','eclaircies');
INSERT INTO activity (id,name,weather) VALUES(10,'Football / BasketBall','eclaircies');

INSERT INTO activity (id,name,weather) VALUES(11,'Sortir entres amis','nuit-nuageuse');
INSERT INTO activity (id,name,weather) VALUES(12,'Aller boire un verre','nuit-nuageuse');
INSERT INTO activity (id,name,weather) VALUES(13,'Courir','nuit-nuageuse');
INSERT INTO activity (id,name,weather) VALUES(14,'Faire du vélo','nuit-nuageuse');

INSERT INTO activity (id,name,weather) VALUES(15,'Voir une pièce de théâtre','brouillard');
INSERT INTO activity (id,name,weather) VALUES(16,'Aller au zoo','brouillard');
INSERT INTO activity (id,name,weather) VALUES(17,'Mini golf','brouillard');
INSERT INTO activity (id,name,weather) VALUES(18,'Cinéma','brouillard');

INSERT INTO activity (id,name,weather) VALUES(19,'Musée','fortement-nuageux');
INSERT INTO activity (id,name,weather) VALUES(20,'Karting','fortement-nuageux');
INSERT INTO activity (id,name,weather) VALUES(21,'Billard','fortement-nuageux');
INSERT INTO activity (id,name,weather) VALUES(22,'Bowling','fortement-nuageux');

INSERT INTO activity (id,name,weather) VALUES(23,'Karting','ciel-voile');
INSERT INTO activity (id,name,weather) VALUES(24,'Billard','ciel-voile');
INSERT INTO activity (id,name,weather) VALUES(25,'Bowling','ciel-voile');
INSERT INTO activity (id,name,weather) VALUES(26,'Jouer à un jeu de société','ciel-voile');
INSERT INTO activity (id,name,weather) VALUES(27,'Jouer d’un instrument de musique','ciel-voile');

INSERT INTO activity (id,name,weather) VALUES(28,'Maraton série ou films','nuit-avec-averses-de-neige-faible');

INSERT INTO activity (id,name,weather) VALUES(29,'Drive in (cinéma en plein air)','nuit-avec-developpement-nuageux');
INSERT INTO activity (id,name,weather) VALUES(30,'Jouer à la play','nuit-avec-developpement-nuageux');
INSERT INTO activity (id,name,weather) VALUES(31,'Boire un verre en terrasse','developpement-nuageux');
INSERT INTO activity (id,name,weather) VALUES(32,'Musée','developpement-nuageux');

INSERT INTO activity (id,name,weather) VALUES(33,'Jouer d’un instrument de musique','nuit-faiblement-orageuse');
INSERT INTO activity (id,name,weather) VALUES(34,'Faire des patisseries','nuit-faiblement-orageuse');
INSERT INTO activity (id,name,weather) VALUES(35,'Jouer d’un instrument de musique','nuit-faiblement-orageuse');

INSERT INTO activity (id,name,weather) VALUES(36,'Sortir entres amis','ensoleille');
INSERT INTO activity (id,name,weather) VALUES(37,'Aller boire un verre','ensoleille');
INSERT INTO activity (id,name,weather) VALUES(38,'Courir','ensoleille');
INSERT INTO activity (id,name,weather) VALUES(39,'Faire du vélo','ensoleille');
INSERT INTO activity (id,name,weather) VALUES(40,'Balade au parc','ensoleille');

INSERT INTO activity (id,name,weather) VALUES(41,'Soirée entre amis à la maison','orage-modere');
INSERT INTO activity (id,name,weather) VALUES(42,'Journée au spa','orage-modere');

INSERT INTO activity (id,name,weather) VALUES(43,'Billard/Bowling','fortement-orageux');
INSERT INTO activity (id,name,weather) VALUES(44,'Lire','fortement-orageux');

INSERT INTO activity (id,name,weather) VALUES(45,'Jouer à la play','averses-de-pluie-faible');
INSERT INTO activity (id,name,weather) VALUES(46,'Yoga','averses-de-pluie-faible');
INSERT INTO activity (id,name,weather) VALUES(47,'Aller à l’aquarium','averses-de-pluie-faible');

INSERT INTO activity (id,name,weather) VALUES(48,'Journée à la montagne','neige-forte');
INSERT INTO activity (id,name,weather) VALUES(49,'Ski','neige-forte');
INSERT INTO activity (id,name,weather) VALUES(50,'Cinéma','neige-forte');

INSERT INTO activity (id,name,weather) VALUES(51,'Journée cocooning','pluie-forte');
INSERT INTO activity (id,name,weather) VALUES(52,'Lire','pluie-forte');
INSERT INTO activity (id,name,weather) VALUES(53,'Jouer à la play','pluie-forte');
INSERT INTO activity (id,name,weather) VALUES(54,'Jouer à un jeu de société','pluie-forte');
INSERT INTO activity (id,name,weather) VALUES(55,'Jouer à la play','pluie-forte');
INSERT INTO activity (id,name,weather) VALUES(56,'Jouer à un jeu de société','pluie-forte');

INSERT INTO activity (id,name,weather) VALUES(57,'Cinéma','averses-de-pluie-forte');
INSERT INTO activity (id,name,weather) VALUES(58,'Journée cocooning','averses-de-pluie-forte');
INSERT INTO activity (id,name,weather) VALUES(59,'Lire','averses-de-pluie-forte');

INSERT INTO activity (id,name,weather) VALUES(60,'Jouer d’un instrument de musique','nuit-avec-averses');
INSERT INTO activity (id,name,weather) VALUES(61,'Prendre un bain reposant','nuit-avec-averses');
INSERT INTO activity (id,name,weather) VALUES(62,'Jouer d’un instrument de musique','nuit-avec-averses');
INSERT INTO activity (id,name,weather) VALUES(63,'Prendre un bain reposant','nuit-avec-averses');

INSERT INTO activity (id,name,weather) VALUES(64,'Cuisiner','pluie-moderee');
INSERT INTO activity (id,name,weather) VALUES(65,'Faire des patisseries','pluie-moderee');
INSERT INTO activity (id,name,weather) VALUES(66,'Patinoire','pluie-moderee');
INSERT INTO activity (id,name,weather) VALUES(67,'Yoga','pluie-moderee');
INSERT INTO activity (id,name,weather) VALUES(68,'Cuisiner','pluie-moderee');
INSERT INTO activity (id,name,weather) VALUES(69,'Faire des patisseries','pluie-moderee');
INSERT INTO activity (id,name,weather) VALUES(70,'Patinoire','pluie-moderee');
INSERT INTO activity (id,name,weather) VALUES(71,'Yoga','pluie-moderee');

INSERT INTO activity (id,name,weather) VALUES(72,'Journée à la montagne','pluie-et-neige-melee-moderee');
INSERT INTO activity (id,name,weather) VALUES(73,'Ski','pluie-et-neige-melee-moderee');

INSERT INTO activity (id,name,weather) VALUES(74,'Journée à la montagne','pluie-et-neige-melee-forte');

INSERT INTO activity (id,name,weather) VALUES(75,'Ski','pluie-et-neige-melee-faible');

INSERT INTO activity (id,name,weather) VALUES(76,'Cinéma','averses-de-neige-faible');
INSERT INTO activity (id,name,weather) VALUES(77,'Soirée entre amis à la maison','averses-de-neige-faible');

INSERT INTO activity (id,name,weather) VALUES(78,'Journée au spa','neige-moderee');
INSERT INTO activity (id,name,weather) VALUES(79,'Billard/Bowling','neige-moderee');

INSERT INTO activity (id,name,weather) VALUES(80,'Lire','neige-faible');
INSERT INTO activity (id,name,weather) VALUES(81,'Jouer à la play','neige-faible');

INSERT INTO activity (id,name,weather) VALUES(82,'Faire des patisseries','pluie-faible');
INSERT INTO activity (id,name,weather) VALUES(83,'Yoga','pluie-faible');

INSERT INTO activity (id,name,weather) VALUES(84,'Aller à l’aquarium','nuit-bien-degagee');

INSERT INTO activity (id,name,weather) VALUES(85,'Sortir entres amis','faibles-passages-nuageux');
INSERT INTO activity (id,name,weather) VALUES(86,'Aller boire un verre','faibles-passages-nuageux');
INSERT INTO activity (id,name,weather) VALUES(87,'Courir','faibles-passages-nuageux');
INSERT INTO activity (id,name,weather) VALUES(88,'Faire du vélo','faibles-passages-nuageux');

INSERT INTO activity (id,name,weather) VALUES(89,'Piscine','faiblement-nuageux');
INSERT INTO activity (id,name,weather) VALUES(90,'Mécanique','faiblement-nuageux');
INSERT INTO activity (id,name,weather) VALUES(91,'Aller au zoo','faiblement-nuageux');
INSERT INTO activity (id,name,weather) VALUES(92,'Mini golf','faiblement-nuageux');
INSERT INTO activity (id,name,weather) VALUES(93,'Cinéma','faiblement-nuageux');

INSERT INTO activity (id,name,weather) VALUES(94,'Faire des patisseries','averses-de-pluie-moderee');
INSERT INTO activity (id,name,weather) VALUES(95,'Yoga','averses-de-pluie-moderee');

INSERT INTO activity (id,name,weather) VALUES(96,'Lire','couvert-avec-averses');
INSERT INTO activity (id,name,weather) VALUES(97,'Jouer à la play','couvert-avec-averses');
INSERT INTO activity (id,name,weather) VALUES(98,'Faire des patisseries','couvert-avec-averses');
INSERT INTO activity (id,name,weather) VALUES(99,'Yoga','couvert-avec-averses');
INSERT INTO activity (id,name,weather) VALUES(100,'Aller à l’aquarium','couvert-avec-averses');

INSERT INTO activity (id,name,weather) VALUES(101,'Lire','faiblement-orageux');
INSERT INTO activity (id,name,weather) VALUES(102,'Jouer à la play','faiblement-orageux');
INSERT INTO activity (id,name,weather) VALUES(103,'Faire des patisseries','faiblement-orageux');
INSERT INTO activity (id,name,weather) VALUES(104,'Yoga','faiblement-orageux');
INSERT INTO activity (id,name,weather) VALUES(105,'Aller à l’aquarium','faiblement-orageux');

INSERT INTO activity (id,name,weather) VALUES(106,'Regarder les étoiles','nuit-claire');
INSERT INTO activity (id,name,weather) VALUES(107,'Bowling','nuit-claire');

INSERT INTO activity (id,name,weather) VALUES(108,'Regarder les étoiles','nuit-legerement-voilee');
INSERT INTO activity (id,name,weather) VALUES(109,'Bowling','nuit-legerement-voilee');
INSERT INTO activity (id,name,weather) VALUES(110,'Lecture','nuit-legerement-voilee');
INSERT INTO activity (id,name,weather) VALUES(111,'Paintball','nuit-legerement-voilee');

INSERT INTO activity (id,name,weather) VALUES(112,'Regarder les étoiles','nuit-claire-et-stratus');
INSERT INTO activity (id,name,weather) VALUES(113,'Bowling','nuit-claire-et-stratus');
INSERT INTO activity (id,name,weather) VALUES(114,'Lecture','nuit-claire-et-stratus');
INSERT INTO activity (id,name,weather) VALUES(115,'Paintball','nuit-claire-et-stratus');

INSERT INTO activity (id,name,weather) VALUES(116,'Piscine','stratus');
INSERT INTO activity (id,name,weather) VALUES(117,'Mécanique','stratus');
INSERT INTO activity (id,name,weather) VALUES(118,'Aller au zoo','stratus');
INSERT INTO activity (id,name,weather) VALUES(119,'Mini golf','stratus');
INSERT INTO activity (id,name,weather) VALUES(120,'Cinéma','stratus');


