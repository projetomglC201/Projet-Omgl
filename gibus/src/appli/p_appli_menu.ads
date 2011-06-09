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
	--réinitialise la base de données
function AuMoins1Festival return boolean;
	--vaut vrai s'il y a au moins 1 festival dans la BD
function AuMoins1Ville return boolean;
	--vaut vrai s'il y a au moins 1 ville dans la BD
function AuMoins1Groupe return boolean;
	--vaut vrai s'il y a au moins 1 groupe dans la BD
function Is1Finale return boolean;
	--vaut vrai si la grande finale a été créée
function IsGagnantFinale return boolean;
	--vaut vrai si la grande finale a un gagnant

end p_appli_menu;
