
with basec201_data; use basec201_data;
with festival_io;
with ville_io;
with jour_festival_io;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with db_commons;




package p_appli_enreggroupe is


function GetVillesAvecFestival return Ville_list.vector;
function GetGroupesJour1 (festival :in tfestival) return Groupe_list.vector;
function GetGroupesJour2 (festival :in tfestival) return Groupe_list.vector;
function GetFestivalAssocie(entryVille: in Unbounded_String) return Festival_List.vector;
function Nbgroupeinscrit(Festival : in tfestival; OrdreJour: in integer) return integer;




end p_appli_enreggroupe;
