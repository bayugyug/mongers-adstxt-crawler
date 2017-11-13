-- 
DROP TABLE IF EXISTS adstxt;
CREATE TABLE `adstxt` (
   id int(11) NOT NULL AUTO_INCREMENT,
   site_domain         varchar(255) NOT NULL COLLATE utf8_unicode_ci,
   exchange_domain     varchar(255) NOT NULL COLLATE utf8_unicode_ci,
   seller_account_id   varchar(255) NOT NULL COLLATE utf8_unicode_ci,
   adsystem_domain     int default 0,
   account_type        varchar(255) COLLATE utf8_unicode_ci,
   tag_id              varchar(255) COLLATE utf8_unicode_ci,
   entry_comment       varchar(255) COLLATE utf8_unicode_ci,
   create_dt           timestamp NULL DEFAULT '0000-00-00 00:00:00',
   update_dt           timestamp NULL DEFAULT '0000-00-00 00:00:00',
   PRIMARY KEY (id),
   UNIQUE KEY uadstxt(site_domain,exchange_domain,seller_account_id)
);

DROP TABLE IF EXISTS adsystem_domain;
CREATE TABLE adsystem_domain (
    id int(11) NOT NULL AUTO_INCREMENT,
    domain varchar(255) NOT NULL,
    domain_id int,
    PRIMARY KEY (id),
    UNIQUE KEY uadomain(domain,domain_id)
);
DROP TABLE IF EXISTS adsystem;
CREATE TABLE adsystem (
    id int(11) NOT NULL AUTO_INCREMENT,
    name             varchar(255)  COLLATE utf8_unicode_ci,
    canonical_domain varchar(255)  COLLATE utf8_unicode_ci,
    PRIMARY KEY (id),
    UNIQUE KEY uadsystem(name,canonical_domain)
);

INSERT INTO `adsystem_domain` VALUES (NULL,'adtech.com',11);
INSERT INTO `adsystem_domain` VALUES (NULL,'aolcloud.net',11);
INSERT INTO `adsystem_domain` VALUES (NULL,'appnexus.com',84);
INSERT INTO `adsystem_domain` VALUES (NULL,'districtm.io',96);
INSERT INTO `adsystem_domain` VALUES (NULL,'google.com',8);
INSERT INTO `adsystem_domain` VALUES (NULL,'indexechange.com',48);
INSERT INTO `adsystem_domain` VALUES (NULL,'indexexchange.com',48);
INSERT INTO `adsystem_domain` VALUES (NULL,'indexexchnage.com',48);
INSERT INTO `adsystem_domain` VALUES (NULL,'openx.com',4);
INSERT INTO `adsystem_domain` VALUES (NULL,'pubmatic.com',3);
INSERT INTO `adsystem_domain` VALUES (NULL,'rubicon.com',1);
INSERT INTO `adsystem_domain` VALUES (NULL,'rubiconproject.com',1);
INSERT INTO `adsystem_domain` VALUES (NULL,'spotx.tv',44);
INSERT INTO `adsystem_domain` VALUES (NULL,'spotxchange.com',44);
INSERT INTO `adsystem_domain` VALUES (NULL,'spx.smaato.com',17);
INSERT INTO `adsystem_domain` VALUES (NULL,'teads.tv',94);
INSERT INTO `adsystem_domain` VALUES (NULL,'pulsepoint.com',95);
INSERT INTO `adsystem_domain` VALUES (NULL,'aol.com',15);
INSERT INTO `adsystem_domain` VALUES (NULL,'liveintent.com',12);
INSERT INTO `adsystem_domain` VALUES (NULL,'triplelift.com',83);
INSERT INTO `adsystem_domain` VALUES (NULL,'teads.com',94);
INSERT INTO `adsystem_domain` VALUES (NULL,'contextweb.com',95);
INSERT INTO `adsystem_domain` VALUES (NULL,'sharethrough.com',97);
INSERT INTO `adsystem_domain` VALUES (NULL,'districtm.ca',96);
INSERT INTO `adsystem_domain` VALUES (NULL,'sovrn.com',23);
INSERT INTO `adsystem_domain` VALUES (NULL,'smaato.com',17);
INSERT INTO `adsystem_domain` VALUES (NULL,'coxmt.com',86);
INSERT INTO `adsystem_domain` VALUES (NULL,'lijit.com',23);
INSERT INTO `adsystem_domain` VALUES (NULL,'www.indexexchange.com',48);
INSERT INTO `adsystem_domain` VALUES (NULL,'tremorhub.com',77);
INSERT INTO `adsystem_domain` VALUES (NULL,'appnexus',84);
INSERT INTO `adsystem_domain` VALUES (NULL,'advertising.com',88);
INSERT INTO `adsystem_domain` VALUES (NULL,'fastlane.rubiconproject.com',1);
INSERT INTO `adsystem_domain` VALUES (NULL,'33across.com',2);
INSERT INTO `adsystem_domain` VALUES (NULL,'facebook.com',5);
INSERT INTO `adsystem_domain` VALUES (NULL,'gumgum.com',6);
INSERT INTO `adsystem_domain` VALUES (NULL,'kargo.com',7);
INSERT INTO `adsystem_domain` VALUES (NULL,'brealtime.com',9);
INSERT INTO `adsystem_domain` VALUES (NULL,'c.amazon-adsystem.com',10);
INSERT INTO `adsystem_domain` VALUES (NULL,'yieldmo.com',13);
INSERT INTO `adsystem_domain` VALUES (NULL,'taboola.com',18);
INSERT INTO `adsystem_domain` VALUES (NULL,'sofia.trustx.org',19);
INSERT INTO `adsystem_domain` VALUES (NULL,'a9.com',10);
INSERT INTO `adsystem_domain` VALUES (NULL,'amazon.com',10);
INSERT INTO `adsystem_domain` VALUES (NULL,'lkqd.com',20);
INSERT INTO `adsystem_domain` VALUES (NULL,'criteo.com',21);
INSERT INTO `adsystem_domain` VALUES (NULL,'exponential.com',22);
INSERT INTO `adsystem_domain` VALUES (NULL,'yldbt.com',25);
INSERT INTO `adsystem_domain` VALUES (NULL,'rhythmone.com',24);
INSERT INTO `adsystem_domain` VALUES (NULL,'technorati.com',26);
INSERT INTO `adsystem_domain` VALUES (NULL,'bidfluence.com',27);
INSERT INTO `adsystem_domain` VALUES (NULL,'switch.com',28);
INSERT INTO `adsystem_domain` VALUES (NULL,'amazon-adsystem.com',10);
INSERT INTO `adsystem_domain` VALUES (NULL,'conversantmedia.com',30);
INSERT INTO `adsystem_domain` VALUES (NULL,'sonobi.com',31);
INSERT INTO `adsystem_domain` VALUES (NULL,'spoutable.com',32);
INSERT INTO `adsystem_domain` VALUES (NULL,'trustx.org',19);
INSERT INTO `adsystem_domain` VALUES (NULL,'freewheel.tv',33);
INSERT INTO `adsystem_domain` VALUES (NULL,'connatix.com',34);
INSERT INTO `adsystem_domain` VALUES (NULL,'lkqd.net',20);
INSERT INTO `adsystem_domain` VALUES (NULL,'positivemobile.com',36);
INSERT INTO `adsystem_domain` VALUES (NULL,'memeglobal.com',37);
INSERT INTO `adsystem_domain` VALUES (NULL,'kixer.com',38);
INSERT INTO `adsystem_domain` VALUES (NULL,'sekindo.com',39);
INSERT INTO `adsystem_domain` VALUES (NULL,'360yield.com',40);
INSERT INTO `adsystem_domain` VALUES (NULL,'cdn.stickyadstv.com',33);
INSERT INTO `adsystem_domain` VALUES (NULL,'adform.com',41);
INSERT INTO `adsystem_domain` VALUES (NULL,'streamrail.net',45);
INSERT INTO `adsystem_domain` VALUES (NULL,'mathtag.com',46);
INSERT INTO `adsystem_domain` VALUES (NULL,'adyoulike.com',47);
INSERT INTO `adsystem_domain` VALUES (NULL,'kiosked.com',50);
INSERT INTO `adsystem_domain` VALUES (NULL,'video.unrulymedia.com',51);
INSERT INTO `adsystem_domain` VALUES (NULL,'meridian.sovrn.com',23);
INSERT INTO `adsystem_domain` VALUES (NULL,'brightcom.com',52);
INSERT INTO `adsystem_domain` VALUES (NULL,'smartadserver.com',64);
INSERT INTO `adsystem_domain` VALUES (NULL,'apnexus.com',84);
INSERT INTO `adsystem_domain` VALUES (NULL,'jadserve.postrelease.com',56);
INSERT INTO `adsystem_domain` VALUES (NULL,'rs-stripe.com',53);
INSERT INTO `adsystem_domain` VALUES (NULL,'fyber.com',54);
INSERT INTO `adsystem_domain` VALUES (NULL,'inner-active.com',43);
INSERT INTO `adsystem_domain` VALUES (NULL,'tidaltv.com',55);
INSERT INTO `adsystem_domain` VALUES (NULL,'critero.com',21);
INSERT INTO `adsystem_domain` VALUES (NULL,'advertising.amazon.com',10);
INSERT INTO `adsystem_domain` VALUES (NULL,'nativo.com',56);
INSERT INTO `adsystem_domain` VALUES (NULL,'media.net',57);
INSERT INTO `adsystem_domain` VALUES (NULL,'www.yumenetworks.com',58);
INSERT INTO `adsystem_domain` VALUES (NULL,'revcontent.com',59);
INSERT INTO `adsystem_domain` VALUES (NULL,'adtech.net',11);
INSERT INTO `adsystem_domain` VALUES (NULL,'go.sonobi.com',31);
INSERT INTO `adsystem_domain` VALUES (NULL,'outbrain.com',60);
INSERT INTO `adsystem_domain` VALUES (NULL,'ib.adnxs.com',84);
INSERT INTO `adsystem_domain` VALUES (NULL,'freeskreen.com',62);
INSERT INTO `adsystem_domain` VALUES (NULL,'bidtellect.com',63);
INSERT INTO `adsystem_domain` VALUES (NULL,'loopme.com',65);
INSERT INTO `adsystem_domain` VALUES (NULL,'vidazoo.com',66);
INSERT INTO `adsystem_domain` VALUES (NULL,'videoflare.com',67);
INSERT INTO `adsystem_domain` VALUES (NULL,'yahoo.com',68);
INSERT INTO `adsystem_domain` VALUES (NULL,'yume.com',58);
INSERT INTO `adsystem_domain` VALUES (NULL,'pixfuture.com',69);

INSERT INTO `adsystem` VALUES (1,'Rubicon',NULL);
INSERT INTO `adsystem` VALUES (2,'33Across',NULL);
INSERT INTO `adsystem` VALUES (3,'PubMatic','pubmatic.com');
INSERT INTO `adsystem` VALUES (4,'OpenX','openx.com');
INSERT INTO `adsystem` VALUES (5,'Facebook',NULL);
INSERT INTO `adsystem` VALUES (6,'GumGum',NULL);
INSERT INTO `adsystem` VALUES (7,'Kargo',NULL);
INSERT INTO `adsystem` VALUES (8,'Google','google.com');
INSERT INTO `adsystem` VALUES (9,'bRealtime',NULL);
INSERT INTO `adsystem` VALUES (10,'Amazon',NULL);
INSERT INTO `adsystem` VALUES (11,'One by AOL: Display',NULL);
INSERT INTO `adsystem` VALUES (12,'LiveIntent',NULL);
INSERT INTO `adsystem` VALUES (13,'Yieldmo',NULL);
INSERT INTO `adsystem` VALUES (14,'MoPub',NULL);
INSERT INTO `adsystem` VALUES (15,'One by AOL: Mobile','aol.com');
INSERT INTO `adsystem` VALUES (17,'Smaato',NULL);
INSERT INTO `adsystem` VALUES (18,'Taboola',NULL);
INSERT INTO `adsystem` VALUES (19,'TrustX',NULL);
INSERT INTO `adsystem` VALUES (20,'LKQD',NULL);
INSERT INTO `adsystem` VALUES (21,'Criteo',NULL);
INSERT INTO `adsystem` VALUES (22,'Exponential',NULL);
INSERT INTO `adsystem` VALUES (23,'Sovrn',NULL);
INSERT INTO `adsystem` VALUES (24,'RhythmOne',NULL);
INSERT INTO `adsystem` VALUES (25,'Yieldbot',NULL);
INSERT INTO `adsystem` VALUES (26,'Technorati',NULL);
INSERT INTO `adsystem` VALUES (27,'Bidfluence',NULL);
INSERT INTO `adsystem` VALUES (28,'Switch Concepts',NULL);
INSERT INTO `adsystem` VALUES (29,'BrightRoll Exchange',NULL);
INSERT INTO `adsystem` VALUES (30,'Conversant',NULL);
INSERT INTO `adsystem` VALUES (31,'Sonobi',NULL);
INSERT INTO `adsystem` VALUES (32,'Spoutable',NULL);
INSERT INTO `adsystem` VALUES (33,'FreeWheel',NULL);
INSERT INTO `adsystem` VALUES (34,'Connatix',NULL);
INSERT INTO `adsystem` VALUES (35,'Centro Brand Exchange',NULL);
INSERT INTO `adsystem` VALUES (36,'Positive Mobile',NULL);
INSERT INTO `adsystem` VALUES (37,'MemeGlobal',NULL);
INSERT INTO `adsystem` VALUES (38,'Kixer',NULL);
INSERT INTO `adsystem` VALUES (39,'Sekindo',NULL);
INSERT INTO `adsystem` VALUES (40,'Improve Digital','improvedigital.com');
INSERT INTO `adsystem` VALUES (41,'AdForm',NULL);
INSERT INTO `adsystem` VALUES (42,'MADS',NULL);
INSERT INTO `adsystem` VALUES (43,'Inneractive','inner-active.com');
INSERT INTO `adsystem` VALUES (44,'SpotX',NULL);
INSERT INTO `adsystem` VALUES (45,'StreamRail',NULL);
INSERT INTO `adsystem` VALUES (46,'MediaMath',NULL);
INSERT INTO `adsystem` VALUES (47,'AdYouLike',NULL);
INSERT INTO `adsystem` VALUES (48,'Index Exchange','indexexchange.com');
INSERT INTO `adsystem` VALUES (49,'e-Planning',NULL);
INSERT INTO `adsystem` VALUES (50,'Kiosked',NULL);
INSERT INTO `adsystem` VALUES (51,'UnrulyX',NULL);
INSERT INTO `adsystem` VALUES (52,'Brightcom',NULL);
INSERT INTO `adsystem` VALUES (53,'PowerInbox',NULL);
INSERT INTO `adsystem` VALUES (54,'Fyber','fyber.com');
INSERT INTO `adsystem` VALUES (55,'TidalTV',NULL);
INSERT INTO `adsystem` VALUES (56,'Nativo',NULL);
INSERT INTO `adsystem` VALUES (57,'Media.net',NULL);
INSERT INTO `adsystem` VALUES (58,'YuMe',NULL);
INSERT INTO `adsystem` VALUES (59,'RevContent',NULL);
INSERT INTO `adsystem` VALUES (60,'Outbrain',NULL);
INSERT INTO `adsystem` VALUES (61,'Zedo',NULL);
INSERT INTO `adsystem` VALUES (62,'SlimCut Media',NULL);
INSERT INTO `adsystem` VALUES (63,'Bidtellect',NULL);
INSERT INTO `adsystem` VALUES (64,'Smart RTB+',NULL);
INSERT INTO `adsystem` VALUES (65,'LoopMe',NULL);
INSERT INTO `adsystem` VALUES (66,'Vidazoo',NULL);
INSERT INTO `adsystem` VALUES (67,'Videoflare',NULL);
INSERT INTO `adsystem` VALUES (68,'Yahoo Ad Exchange',NULL);
INSERT INTO `adsystem` VALUES (69,'PixFuture',NULL);
INSERT INTO `adsystem` VALUES (77,'Tremor',NULL);
INSERT INTO `adsystem` VALUES (83,'TripleLift',NULL);
INSERT INTO `adsystem` VALUES (84,'AppNexus','appnexus.com');
INSERT INTO `adsystem` VALUES (86,'COMET',NULL);
INSERT INTO `adsystem` VALUES (88,'One by AOL: Video','advertising.com');
INSERT INTO `adsystem` VALUES (94,'Teads','teads.tv');
INSERT INTO `adsystem` VALUES (95,'PulsePoint',NULL);
INSERT INTO `adsystem` VALUES (96,'District M',NULL);
INSERT INTO `adsystem` VALUES (97,'Sharethrough',NULL);



