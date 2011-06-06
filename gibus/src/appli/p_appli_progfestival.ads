with festival_io;
with db_commons;
with basec201_data; use basec201_data;
with Ada.Containers.Vectors; use Ada.Containers;
with Ada.strings.Unbounded; use ada.strings.unbounded;
with p_conversion;
with jour_festival_io;

package p_appli_progfestival is

	function GetFestivals return Festival_List.Vector;

	procedure GetGroupes(festival : in Unbounded_String; GroupesJour1 : out Groupe_List.Vector; GroupesJour2 : out Groupe_List.Vector);



end p_appli_progfestival;
