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
	function GetFestivalAssocie(entryVille: in Unbounded_String) return Festival_List.vector;
	function GetJoursFestivalAssocie(IdFestival: in integer) return Jour_Festival_List.vector;
	function GetVillesAvecFestival return Ville_list.vector;
	


end p_appli_consulterfestival;
