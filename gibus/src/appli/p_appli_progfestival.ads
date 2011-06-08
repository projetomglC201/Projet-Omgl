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

	EX_TROP_DE_GROUPES,EX_DEJA_EN_HAUT,EX_DEJA_EN_BAS : exception;

	function GetFestivals return Festival_List.Vector;

	procedure GetGroupes(festival : in Unbounded_String; GroupesJour1 : out Groupe_List.Vector; GroupesJour2 : out Groupe_List.Vector);

	function IsJour2(festival : in Unbounded_String) return boolean;	
	function MaxGroupes(festival : in Unbounded_String; numjour : in integer) return integer ;

	procedure MaJOrdrePassage(liste : in out Groupe_List.Vector);

	procedure switchJour(Nom_groupe : in Unbounded_String; Groupes_Jour_ori : in out Groupe_List.vector; Groupes_Jour_Dest : in out Groupe_List.Vector);
	
	procedure up(nomgroupe : in Unbounded_String;liste_groupe : in out Groupe_List.Vector);

	procedure down(nomgroupe : in Unbounded_String;liste_groupe : in out Groupe_List.Vector);
	
	procedure save(groupesJour1,groupesJour2 : in Groupe_List.Vector);

	procedure top(nomgroupe : in Unbounded_String; liste_groupe : in out Groupe_List.Vector);

	procedure bot(nomgroupe : in Unbounded_String; liste_groupe : in out Groupe_List.Vector);
end p_appli_progfestival;
