with db_commons;
with GNU.DB.SQLCLI;
with basec201_data; use basec201_data;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with ville_io;
with festival_io;
with jour_festival_io;
with gagnant_festival_io;
with grande_finale_io;


package p_appli_enreggagnantfinale is


function GetInscritsFinale return Basec201_data.Gagnant_Festival_List.Vector;
	--retourne la liste des gagnants des festivals
procedure Save(groupe : in Unbounded_String);
	--enregistre le groupe de nom "groupe" comme gagnant de la grande finale
end p_appli_enreggagnantfinale;
