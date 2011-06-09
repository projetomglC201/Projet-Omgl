with basec201_data; use basec201_data;
with db_commons;
with ville_io;
with festival_io;
with groupe_io;
with grande_finale_io;
with gagnant_festival_io;
with jour_festival_io;
with ada.strings.Unbounded; use Ada.Strings.Unbounded;

package p_appli_menu is

procedure reinitDB;
function AuMoins1Festival return boolean;
function AuMoins1Ville return boolean;
function AuMoins1Groupe return boolean;
function Is1Finale return boolean;
function IsGagnantFinale return boolean;






end p_appli_menu;
