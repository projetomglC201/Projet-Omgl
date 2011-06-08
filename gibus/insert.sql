


--insertion des villes
insert into ville (nom_ville, mel_contact  ) values  ( 'Echirolles', 'will@gmail.FR' );
insert into ville (nom_ville, mel_contact  ) values  ( 'Grenoble', 'Tom@free.fr' );
insert into ville (nom_ville, mel_contact  ) values  ( 'Paris', 'Parsi@paris.Paris' );


--creation des festivales
insert into festival (id_festival, ville_festival, date, lieu, prix_place  ) values  (  1, 'Echirolles', '2012-01-23 00:00:00', 'La chaufferie',  12 );
insert into jour_festival (id_jour_festival, festival, num_ordre, nbre_concert_max, heure_debut  ) values  ( -2148503,  1,  1,  15,  10 );
insert into jour_festival (id_jour_festival, festival, num_ordre, nbre_concert_max, heure_debut  ) values  ( -2148502,  1,  2,  13,  10 );
insert into festival (id_festival, ville_festival, date, lieu, prix_place  ) values  (  2, 'Grenoble', '2012-01-23 00:00:00', 'L''esplanade',  10 );
insert into jour_festival (id_jour_festival, festival, num_ordre, nbre_concert_max, heure_debut  ) values  ( -2148501,  2,  1,  12,  9 );


--insertion de groupes
insert into groupe (nom_groupe, jour_festival, nom_contact, coord_contact, adr_site, ordre_passage, genre  ) values  ( 'Mytho logic', -2148503, 'Pierre', 'Quelque part', 'unsite.fr',  1,  1 );
insert into groupe (nom_groupe, jour_festival, nom_contact, coord_contact, adr_site, ordre_passage, genre  ) values  ( 'Kingston', -2148503, 'Key', 'Ailleurs', '',  2,  3 );
insert into groupe (nom_groupe, jour_festival, nom_contact, coord_contact, adr_site, ordre_passage, genre  ) values  ( 'X', -2148502, 'Yann', 'Netherland', 'host.fr',  1,  0 );
insert into groupe (nom_groupe, jour_festival, nom_contact, coord_contact, adr_site, ordre_passage, genre  ) values  ( 'Groupe grenoblois', -2148501, 'Paul', 'Cours jean jaures', '',  1,  3 )

