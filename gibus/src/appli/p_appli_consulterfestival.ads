with ville_io;
with festival_io;
with jour_festival_io;
with basec201_data; use basec201_data;
with db_commons;
with Ada.Containers.Vectors;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with p_conversion; use p_conversion;


package p_appli_consulterfestival is

	function GetVille(entryVille: in Unbounded_String) return tville;
		--retourne la structure contenant la ville de nom "entryVille"
	function GetFestivalAssocie(entryVille: in Unbounded_String) return Festival_List.vector;
		--retourne une liste de festivals contenant le festival de la ville "entryVille"
	function GetJoursFestivalAssocie(IdFestival: in integer) return Jour_Festival_List.vector;
		--retourne une liste des jours du festival d'id IdFestival
	function GetVillesAvecFestival return Ville_list.vector;
		--retourne la liste des villes ayant un festival
	


end p_appli_consulterfestival;
