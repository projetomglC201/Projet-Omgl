--with tp_Intl; use tp_Intl;
with Glade.XML;use Glade.XML;
with System; use System;
with Gtk.Main;
with Gtkada.Dialogs;use Gtkada.Dialogs;
with Glib; use Glib;

-- pour gérer les composants de la fenetre
with Gtk.Window; use Gtk.Window;
with Gtk.Button; use Gtk.Button;
with Gtk.Gentry; use Gtk.Gentry;
with Gtk.Tree_View; use Gtk.Tree_View;
with Gtk.Label; use Gtk.Label;
with Gtk.Scrolled_Window; use Gtk.Scrolled_Window; 
with Gtk.Calendar; Use Gtk.calendar;

-- pour gérer le composant Tree_View
with Gtk.Tree_Model; use Gtk.Tree_Model;-- l'itérateur rang dans le modèle
with Gtk.Tree_Store; use Gtk.Tree_Store;-- le modèle associé à la vue
with Gtk.Tree_Selection; use Gtk.Tree_Selection;  -- pour la sélection dans la vue
with p_util_treeview; use p_util_treeview;  -- utilitaire de gestion d'une treeView



with p_appli_creerfinale; use p_appli_creerfinale;
with ada.calendar; use ada.calendar;
with p_conversion; use p_conversion;


package p_window_creerfinale is

EXEntryPrixEmpty:exception;

procedure Init;
procedure FermerFenetre;
procedure creerfestival;
procedure SetSensitiveThenFinaleCreee;




end p_window_creerfinale;
