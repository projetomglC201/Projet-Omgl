
with basec201_data; use basec201_data;
with base_types; use base_types;
with festival_io;
with ville_io;
with jour_festival_io;
with groupe_io;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with db_commons;
with GNU.DB.SQLCLI;



package p_appli_enreggroupe is

EXGroupeExistant:exception;

function GetVillesAvecFestival return Ville_list.vector;
	--retourne la liste des villes ayant un festival
function GetGroupesJour (festival :in tfestival; numjour:positive) return Groupe_list.vector;
	--retourne la liste des groupes inscrit au jour numéro 'numjour' du festival 'festival'
function GetFestivalAssocie(entryVille: in Unbounded_String) return Festival_List.vector;
	--retourne une liste contenant le festival de la ville de nom "entryVille"
function Nbgroupeinscrit(Festival : in tfestival; OrdreJour: in positive) return integer;
	--retourne le nombre de groupes inscrits au jour numéro 'numjour' du festival 'Festival'
function GetJourFestivalAssocie(Festival : in tfestival) return Jour_Festival_List.Vector;
	--retourne la liste des jours du festival 'Festival'
procedure SaveGroupe(Nom,Contact,Coord,Site :in Unbounded_String; genre:string; ordre,jour:positive);
	--enregistre dans la DB le groupe avec les infos fournies au jour d'id 'jour'

end p_appli_enreggroupe;
