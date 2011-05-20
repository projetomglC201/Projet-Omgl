with ville_io;
with basec201_data; use basec201_data;
with db_commons;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
package p_appli_enregville is


EXVilleExistante:exception;



function GetVillesExistantes return Basec201_Data.Ville_List.Vector;
procedure CreateVille (resultEntryNomVille : in Unbounded_String; resultEntryMail : Unbounded_String );







end p_appli_enregville;
