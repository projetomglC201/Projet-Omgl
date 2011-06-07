with festival_io;
with db_commons;
with basec201_data; use basec201_data;
with Ada.Containers.Vectors; use Ada.Containers;
with Ada.strings.Unbounded; use ada.strings.unbounded;
with p_conversion;
with jour_festival_io;
with groupe_io;
with festival_io;

package p_appli_progfestival is

	EX_TROP_DE_GROUPES : exception;

	function GetFestivals return Festival_List.Vector;

	procedure GetGroupes(festival : in Unbounded_String; GroupesJour1 : out Groupe_List.Vector; GroupesJour2 : out Groupe_List.Vector);

	procedure switchJour(Nom_groupe : in Unbounded_String; nbjour : in integer);


end p_appli_progfestival;
