-- MySQL dump 10.15  Distrib 10.0.14-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: hoteleria
-- ------------------------------------------------------
-- Server version	10.0.14-MariaDB-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `categorias`
--

DROP TABLE IF EXISTS `categorias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categorias` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL,
  `orden` int(11) DEFAULT '0',
  `enlace_imagen` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categorias`
--

LOCK TABLES `categorias` WRITE;
/*!40000 ALTER TABLE `categorias` DISABLE KEYS */;
INSERT INTO `categorias` VALUES (1,'Hoteles 5 estrellas',1,'img/categorias/5estrellas.jpg'),(2,'Hoteles 4 estrellas',2,'img/categorias/4estrellas.jpg'),(3,'Hoteles 3 estrellas',3,'img/categorias/3estrellas.jpg'),(4,'Apart hoteles',4,'img/categorias/apart.jpg'),(5,'Hoteles boutique',5,'img/categorias/boutique.jpg');
/*!40000 ALTER TABLE `categorias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hoteles`
--

DROP TABLE IF EXISTS `hoteles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hoteles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL,
  `info_resumen` varchar(1000) DEFAULT NULL,
  `info_habitaciones` varchar(1000) DEFAULT NULL,
  `info_restaurant` varchar(1000) DEFAULT NULL,
  `enlace_imagen` varchar(200) DEFAULT NULL,
  `directorio_galeria` varchar(200) DEFAULT NULL,
  `orden` int(11) DEFAULT '0',
  `categoria` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_categoria_idx` (`categoria`),
  CONSTRAINT `fk_categoria` FOREIGN KEY (`categoria`) REFERENCES `categorias` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hoteles`
--

LOCK TABLES `hoteles` WRITE;
/*!40000 ALTER TABLE `hoteles` DISABLE KEYS */;
INSERT INTO `hoteles` VALUES (1,'Sheraton','Sheraton Mendoza Hotel está ubicado en el centro de la ciudad de\nMendoza, una de las capitales provinciales más importantes de\nArgentina; y a sólo unos minutos de la Plaza Independencia,\nlos principales paseos peatonales y el área comercial.','En sus 17 pisos ofrece 180 espaciosas habitaciones; incluyendo 18 suites, entre las que se destacan la Suite Presidencial y dos Suite Gobernador.\nTodas ofrecen excelentes vistas de la ciudad y de la Cordillera de los\nAndes, aire acondicionado, TV, radio/reloj, secador de pelo, minibar,\nteléfono con DD y las innovadoras camas Sheraton Sweet SleeperSM\nBed. El Club Level, ubicado entre los pisos 12 y 15, está diseñado\nespecialmente para quienes viajan por negocios.','Lobby Bar: Snacks y bebidas en un cálido y acogedor ambiente\ncon capacidad para hasta 70 comensales.\nCardinale: Un moderno restaurante para 114 personas, donde\nse puede disfrutar lo mejor de la cocina internacional y una gran\nselección de vinos.\nClub Lounge: Ubicado en el piso 16, ofrece una inmejorable vista de la\nciudad y combina las especialidades del mundo con bebidas y cócteles.\nRoom Service las 24 horas.','img/hoteles/portada/Sheraton.jpg','img/hoteles/galeria/Sheraton/',1,1),(2,'Park Hyatt','Park Hyatt Mendoza está ubicado en el corazón de Mendoza, frente a la Plaza Independencia. Cuenta con 186 habitaciones con magnífica vista a la Cordillera de los Andes o a la ciudad de Mendoza.','186 habitaciones, incluyendo 11 Suites.','Bistro M es el restaurant principal de Park Hyatt Mendoza, cuenta con una terraza al aire libre. Presenta un horno de leña central, con una magnífica cocina abierta y una vinoteca con más de 2.500 variedades de vinos de la zona.','img/hoteles/portada/Hyatt.jpg','img/hoteles/galeria/Hyatt/',2,1),(3,'Huentala','Ubicado en Pleno microcentro de Mendoza, a metros del kilómetro cero de la provincia, Huentala Hotel Boutique ofrece a clientes y turistas un servicio de atención preferencial.\nLa evolución del tradicional Hotel Huentala al Huentala Hotel Boutique, incluye una completa remodelación de su interior, conjugando el arte y la arquitectura en cada rincón para el disfrute de cada uno de sus clientes.\nHuentala Hotel Boutique cuenta además con un restaurant con la mejor cocina internacional, una cava donde degustar los mejores vinos de la región, un micro cine y diferentes salones de reuniones pensados para satisfacer la necesidades de cada cliente.\nHuentala Hotel Boutique. Un lugar distinto donde disfrutar Mendoza.','44 habitaciones de 25 mts2, con cama Queen/Twin.\n22 habitaciones de 40 mts2, con cama King/Queen/Twin.','Chimpay Bistro\nLa armonía de su arquitectura, conjuga sus espacios con diseños de\nvanguardia, dando origen a un ambiente único. Además de contar con una cocina de nivel internacional, Chimpay Bistró posee su propia cava de guarda climatizada con una gran variedad de genéricos, como así también su carta de vinos de oro.\nCapacidad máxima: 90 personas','img/hoteles/portada/Huentala.jpg','img/hoteles/galeria/Huentala/',1,2),(4,'The Modern','Nuestro hotel esta ubicado en el corazón de la ciudad de Mendoza cerca a las\nprincipales zonas comerciales. El mismo posee una ubicación privilegiada, con fácil\naccesos desde cualquier punto de la ciudad. Su infraestructura y la calidad del\npersonal que lo integra hacen del lugar una combinación única.','36 habitaciones estándar\n24 habitaciones Ejecutivas (Incluye loft, hidromasaje)\n24 Family Suites ( Dos Ambientes con capacidad para 4 personas, baño con ducha escocesa)\n\nServicios de todas las habitaciones y Suites: Caja de Seguridad, Aire Acondicionado, Calefacción, Minibar, Room Service, Secador de Pelo, Televisión satelital, Teléfono, Microondas','El servicio de Alimentos y Bebidas es realizado directamente por el hotel, por personal altamente capacitado, cumpliendo con los estándares de calidad y excelencia de THE MODERN HOTELS.','img/hoteles/portada/TheModern.jpg','img/hoteles/galeria/TheModern/',2,2),(5,'Bonarda','En Bonarda Hotel atendemos todos los requerimientos de nuestros huéspedes con experiencia y puntualidad, brindándoles nuestro especial servicio de excelencia para que su viaje de negocios o turismo se desarrolle en forma placentera y segura.','SINGLE: 32 | DOBLE: 20 | SUITES: 12 | GRAN SUITES: 3 | DISCAPACITADOS: 2\nTodas nuestras habitaciones sumamente amplias y confortables, estan equipadas con camas queen, cajas de seguridad digital, frigobar, radio reloj despertador, teléfono, TV por cable. Servicio de Wi Fi en todo el hotel y room service, entre otros.\nContamos además con salas de reuniones equipadas para cualquier tipo de evento empresarial, piscina y estacionamiento monitoreado las 24 hs.\nEl Hotel tambien cuenta con Piscina y Gimnasio.','Bonarda recrea lo mejor de la comida fusión. Los tips regionales y cuyanos, la presencia latinoamericana de vanguardia y la clásica y afamada cocina europea y mundial.\nUna estética de cortes simples y funcionales. Pensada para almuerzos y cenas de trabajo, como así también como un espacio de distención y disfrute.\nAbierto de lunes a domingos desayunos, almuerzos y cenas.\nAceptamos tarjetas de credito Visa, Master Card y American Express.','img/hoteles/portada/Bonarda.jpg','img/hoteles/galeria/Bonarda/',1,3),(6,'Gran Hotel Mendoza','Ubicado en pleno centro de la ciudad, a metros de la plaza Independencia y la Peatonal Sarmiento. Con facil acceso a todos los puntos de interes. El hotel cuenta con 10 pisos, 80 habitaciones con todos los servicios, aire acondicionado frio-calor individual, frigobar,TV por cable, caja de seguridad, wi.fi en todo el Hotel . Area Protegida en e mergencias medicas.','80 habitaciones completamente equipadas.','Con una muy buena combinación entre la mejor vista de la ciudad y una excelente cocina goumet.','img/hoteles/portada/Mendoza.jpg','img/hoteles/galeria/Mendoza/',2,3),(7,'Montañas Azules','El toque único que ofrece Montañas Azules,\nbrinda a sus huéspedes la sensación de estar como en su propia casa.\nLa perfecta combinación entre lujo y comodidad,\nse refleja mediante una decoración que resalta delicados detalles,\npara que su estadía sea placentera.','34 SUITES\nCATEGORIAS: Montañas Azules, Superior, Deptos. de 3 ambientes, Deptos. de 2 ambientes, Ejecutivas.','PIEDRAS BLANCAS RESTAURANTE\n\nUn ambiente acogedor para degustar de los mas exquisitos platos regionales e internacionales, en reuniones familiares o sociales, o para disfrutar de un momento de descanso mientras se deleita con nuestras diferentes opciones de menú ejecutivo acompañadas de exclusivos vinos.','img/hoteles/portada/MontanasAzules.jpg','img/hoteles/galeria/MontanasAzules/',1,4),(9,'Lares de Chacras','Lares de Chacras es un espacio que armoniza confort y simpleza en un entorno natural y saludable. Nuestro hotel boutique está ubicada en el corazón de Chacras de Coria, a dos cuadras de la plaza principal. Chacras es una zona residencial y polo gastronómico a 15 Km. de la Ciudad de Mendoza. Nuestros huéspedes pueden acceder a pie a una variedad de negocios y restaurantes que ofrecen diversas especialidades.','El hotel posee 10 amplias habitaciones lo que garantiza un ambiente íntimo para nuestros huéspedes, contamos con 2 habitaciones Especiales con Jacuzzi, hogar a leña y balcón, ideales para disfrutar en pareja.','Contamos con una innovadora cava de vinos abierta al huésped que desee elegir personalmente el vino de su agrado. El restaurante ofrece cenas regionales, y el bar es el lugar ideal para relajarse después de un día por los caminos del vino, así como la piscina y el jacuzzi ubicados en el jardín de la casona.','img/hoteles/portada/LaresDeChacras.jpg','img/hoteles/galeria/LaresDeChacras/',1,5),(10,'Villaggio','Villaggio Hotel Boutique fue concebido para satisfacer todas las necesidades de un mercado cada vez más exigente, con una moderna arquitectura, personalización del servicio y lo último en tecnología.','El Hotel cuenta con 26 habitaciones, 22 Clásicas, 4 Superiores y 2 Departamentos. Todas las habitaciones ,decoradas con cuadros de autor , cuentan con servicio de cuarto en su totalidad, sistema de apertura de puertas por aproximación. Además, cuentan con Wi-Fi sin cargo en todo el hotel, control individual de temperatura, minibar, sábanas bordadas, secador de cabello, cajas de seguridad para notebooks y LCD 32´ en las todas las habitaciones. Las habitaciones Suepriores cuentan con mini Cava con vinos de bodegas Boutique.','El Launge bar “Salotto”, cuenta con una magnífica cava propia con etiquetas de bodegas boutique y un menú ejecutivo de cocina fusión basada en su mayoría en la cocina tradicional Italiana. El bar está equipado con 3 computadoras con conexión a Internet sin cargo.','img/hoteles/portada/Villaggio.jpg','img/hoteles/galeria/Villaggio/',2,5);
/*!40000 ALTER TABLE `hoteles` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-11-20 21:56:56
