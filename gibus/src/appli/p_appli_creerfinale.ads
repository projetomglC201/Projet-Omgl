
with db_commons;
with Grande_Finale_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with ada.calendar; use ada.calendar;

package p_appli_creerfinale is

function FinaleCreee return boolean;
procedure SaveFinale (date : time; prix : integer);




end p_appli_creerfinale;
