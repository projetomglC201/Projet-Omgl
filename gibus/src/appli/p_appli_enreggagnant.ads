

with db_commons;
with GNU.DB.SQLCLI;
with basec201_data; use basec201_data;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with ville_io;
with festival_io;
with jour_festival_io;


package p_appli_enreggagnant is

function GetGroupes (festival :in tfestival) return Groupe_list.vector;
function GetVillesAvecFestival return Ville_list.vector;
function GetFestivalAssocie(entryVille: in Unbounded_String) return tfestival;






end p_appli_enreggagnant;
