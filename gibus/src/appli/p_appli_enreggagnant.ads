

with db_commons;
with GNU.DB.SQLCLI;
with basec201_data; use basec201_data;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with ville_io;
with festival_io;
with jour_festival_io;
with gagnant_festival_io;


package p_appli_enreggagnant is

function GetGroupes (festival :in tfestival) return Groupe_list.vector;
	--retourne la liste des groupes inscrits au festival 'festival'
function GetVillesSansFinaliste return Ville_list.vector;
	--retourne la liste des villes dont le festival n'a pas de finaliste
function GetFestivalAssocie(entryVille: in Unbounded_String) return tfestival;
	--retourne le festival de la ville de nom "entryVille"
procedure SaveGagnantFestival( festival : in tfestival; nom_groupe : in unbounded_string);
	--enregistre le groupe de nom "nom_groupe" comme gagnant du festival 'festival'




end p_appli_enreggagnant;
