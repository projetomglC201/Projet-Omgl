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
		--retourne la liste des festivals
	procedure GetGroupes(festival : in Unbounded_String; GroupesJour1 : out Groupe_List.Vector; GroupesJour2 : out Groupe_List.Vector);
		--affecte à GroupesJour1 et GroupesJour2 la liste des groupes inscrits au jour 1 et 2 du festival de la ville de nom "festival"
		--GroupesJour2 est vide s'il n'y a pas de jour2
	function IsJour2(festival : in Unbounded_String) return boolean;	
		--vaut Vrai si le festival de la ville de nom "festival" a deux journées
	function MaxGroupes(festival : in Unbounded_String; numjour : in integer) return integer ;
		--retourne le nombre maxi de groupes du jour numéro "numjour" du festival de la ville "festival"
	procedure MaJOrdrePassage(liste : in out Groupe_List.Vector);
		--Met à jour les ordres de passages des groupes de la liste 'liste'
	procedure switchJour(Nom_groupe : in Unbounded_String; Groupes_Jour_ori : in out Groupe_List.vector; Groupes_Jour_Dest : in out Groupe_List.Vector);
		--Transfère le groupe de nom "Nom_Groupe" présent dans la liste de groupes 'Groupes_Jour_Ori' en fin de la liste 'Groupes_Jour_Dest
		--le groupe est supprimé de la liste 'Groupes_Jour_Ori'
	procedure up(nomgroupe : in Unbounded_String;liste_groupe : in out Groupe_List.Vector);
		--Monte le groupe de nom "nomgroupe" d'une place dans la liste 'liste_groupe'
	procedure down(nomgroupe : in Unbounded_String;liste_groupe : in out Groupe_List.Vector);
		--Descend le groupe de nom "nomgroupe" d'une place dans la liste 'liste_groupe'
	procedure save(groupesJour1,groupesJour2 : in Groupe_List.Vector);
		--Enregistre dans la DB les groupes des listes groupesJour1 et groupesJour2 dans les bonnes journées
	procedure top(nomgroupe : in Unbounded_String; liste_groupe : in out Groupe_List.Vector);
		--Monte le groupe de nom "nomgroupe" en haut de la liste 'liste_groupe'
	procedure bot(nomgroupe : in Unbounded_String; liste_groupe : in out Groupe_List.Vector);
		--Descend le groupe de nom "nomgroupe" en bas de la liste 'liste_groupe'
	procedure delete(nomgroupe : in Unbounded_String; liste_groupe : in out Groupe_List.Vector);
		--supprime le rgoupe de nom "nomgroupe" de la liste 'liste_groupe'
end p_appli_progfestival;
