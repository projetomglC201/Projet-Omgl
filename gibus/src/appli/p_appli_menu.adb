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

end p_appli_menu;
