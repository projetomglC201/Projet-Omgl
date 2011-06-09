with ville_io;
with festival_io;
with jour_festival_io;
with basec201_data; use basec201_data;
with db_commons;
with Ada.Containers.Vectors;



package p_appli_creerfestival is



function GetVillesSansFestival return Ville_list.Vector;
	--retourne la liste des villes n'ayant pas de festival
procedure CreateFestival (Festival: in tFestival);
	--enregistre dans la DB le festival "Festival"
procedure CreateJourFestival (Jour_Festival : in tJour_Festival);
	--enregistre dans la DB le jour "Jour_Festival"


end p_appli_creerfestival;
