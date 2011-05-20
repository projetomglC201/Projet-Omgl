with ville_io;
with basec201_data; use basec201_data;
with db_commons;
package p_appli_enregville is


function GetVillesExistantes return Basec201_Data.Ville_List.Vector;
	procedure CreateVille (Ville_item : in Basec201_Data.tVille);







end p_appli_enregville;
