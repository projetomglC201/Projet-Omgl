with ville_io;
with festival_io;
with basec201_data; use basec201_data;
with db_commons;
with Ada.Containers.Vectors;



package p_appli_creerfestival is



function GetVillesSansFestival return Ville_list.Vector;

procedure CreateFestival (Festival: in tFestival);





end p_appli_creerfestival;
