


with Ada.Containers.Vectors;
with basec201_data; use basec201_data;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with base_types; use base_types;
with db_commons;
with ville_io;
with jour_festival_io;
with gagnant_festival_io;
with festival_io;


package p_appli_consultfinalistes is


      type tfinaliste is record
         Groupe : Unbounded_String := Ada.Strings.Unbounded.Null_Unbounded_String;
         Ville : Unbounded_string := Ada.Strings.Unbounded.Null_Unbounded_String;
         Genre : tgenre_Enum := hard;
      end record;

      package finaliste_List is new Ada.Containers.Vectors
         (Element_Type => tfinaliste,
         Index_Type => Positive );
function GetVilleGroupefinalisteGenre return finaliste_list.vector;
function GetVillesAvecFinaliste return Ville_list.vector;
function GetGroupes (festival :in tfestival) return Groupe_list.vector;
function GetVillesAvecFestival return Ville_list.vector;





end p_appli_consultfinalistes;
