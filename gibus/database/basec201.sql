--
-- created on 13-05-2011 by Mill
--
drop database if exists basec201;
create database basec201 with encoding 'UTF-8';

\c basec201;


CREATE TABLE ville( 
       nom_ville VARCHAR(45) not null,
       mel_contact VARCHAR(100) not null default '',
       PRIMARY KEY( nom_ville )
);

CREATE TABLE festival( 
       id_festival INTEGER not null,
       ville_festival VARCHAR(45) not null,
       date TIMESTAMP not null default TIMESTAMP '1901-01-01 00:00:00.000000',
       lieu VARCHAR(100) not null default '',
       prix_place INTEGER not null,
       PRIMARY KEY( id_festival ),
       CONSTRAINT festival_FK_0 FOREIGN KEY( ville_festival) references ville( nom_ville ) on delete CASCADE
);

CREATE TABLE jour_festival( 
       id_jour_festival INTEGER not null,
       festival INTEGER not null,
       num_ordre INTEGER not null,
       nbre_concert_max INTEGER not null,
       heure_debut INTEGER not null,
       PRIMARY KEY( id_jour_festival ),
       CONSTRAINT jour_festival_FK_0 FOREIGN KEY( festival) references festival( id_festival ) on delete CASCADE
);

CREATE TABLE groupe( 
       nom_groupe VARCHAR(100) not null,
       jour_festival INTEGER not null,
       nom_contact VARCHAR(50) not null default '',
       coord_contact VARCHAR(100) not null default '',
       adr_site VARCHAR(100) default '',
       ordre_passage INTEGER,
       genre INTEGER not null default 0,
       PRIMARY KEY( nom_groupe ),
       CONSTRAINT groupe_FK_0 FOREIGN KEY( jour_festival) references jour_festival( id_jour_festival ) on delete CASCADE
);

CREATE TABLE gagnant_festival( 
       id_gagnant_festival INTEGER not null,
       festival INTEGER not null,
       groupe VARCHAR(100) not null,
       PRIMARY KEY( id_gagnant_festival ),
       CONSTRAINT gagnant_festival_FK_0 FOREIGN KEY( festival) references festival( id_festival ) on delete CASCADE,
       CONSTRAINT gagnant_festival_FK_1 FOREIGN KEY( groupe) references groupe( nom_groupe ) on delete cascade
);

CREATE TABLE grande_finale( 
       id_finale INTEGER not null,
       date TIMESTAMP not null default TIMESTAMP '1901-01-01 00:00:00.000000',
       prix_place INTEGER not null,
       gagnant_finale VARCHAR(100),
       PRIMARY KEY( id_finale ),
       CONSTRAINT grande_finale_FK_0 FOREIGN KEY( gagnant_finale) references groupe( nom_groupe ) on delete cascade
);

