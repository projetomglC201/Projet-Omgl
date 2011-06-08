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


function IsFinale return boolean;

function GetInscritsFinale return Basec201_data.Gagnant_Festival_List.Vector;

procedure Save(groupe : in Unbounded_String);

end p_appli_enreggagnantfinale;
