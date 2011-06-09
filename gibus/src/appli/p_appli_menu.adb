package body p_appli_menu is

procedure reinitDB is
	crit : db_commons.criteria;
begin

	ville_io.delete(crit);
	festival_io.delete(crit);
	groupe_io.delete(crit);
	grande_finale_io.delete(crit);
	jour_festival_io.delete(crit);
	gagnant_festival_io.delete(crit);
	
end reinitDB;

function AuMoins1Ville return boolean is
	criteria : db_commons.criteria;
begin
	return not ville_io.Is_Empty(ville_io.retrieve(criteria));
end AuMoins1Ville;

function AuMoins1Festival return boolean is
	criteria : db_commons.criteria;
begin
	return not festival_io.Is_Empty(festival_io.retrieve(criteria));
end;

function AuMoins1Groupe return boolean is
	criteria : db_commons.criteria;
begin
	return not groupe_io.Is_Empty(groupe_io.retrieve(criteria));
end;

function Is1Finale return boolean is
	criteria : db_commons.criteria;
begin
	return not grande_finale_io.Is_Empty(grande_finale_io.retrieve(criteria));
end;

function IsGagnantFinale return boolean is
	criteria : db_commons.criteria;
begin
	return (grande_finale_io.retrieve(criteria).first_element.Gagnant_Finale /= Ada.Strings.Unbounded.Null_Unbounded_String);
end;


end p_appli_menu;
