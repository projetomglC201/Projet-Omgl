
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
function GetGroupesJour (festival :in tfestival; numjour:integer) return Groupe_list.vector;

function GetFestivalAssocie(entryVille: in Unbounded_String) return Festival_List.vector;
function Nbgroupeinscrit(Festival : in tfestival; OrdreJour: in integer) return integer;
function GetJourFestivalAssocie(Festival : in tfestival) return Jour_Festival_List.Vector;
procedure SaveGroupe(Nom,Contact,Coord,Site :in Unbounded_String; genre:string; ordre,jour:integer);


end p_appli_enreggroupe;
