
with db_commons;
with Grande_Finale_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with ada.calendar; use ada.calendar;

package p_appli_creerfinale is

procedure SaveFinale (date : time; prix : integer);
	--enregistre dans la DB la grande finale avec les infos fournies



end p_appli_creerfinale;
