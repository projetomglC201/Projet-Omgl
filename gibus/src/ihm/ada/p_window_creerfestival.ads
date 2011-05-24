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
with Gtk.combo_box; use Gtk.combo_box;
with Gtk.calendar; Use Gtk.calendar;

-- pour gérer le composant Tree_View
with Gtk.Tree_Model; use Gtk.Tree_Model;-- l'itérateur rang dans le modèle
with Gtk.Tree_Store; use Gtk.Tree_Store;-- le modèle associé à la vue
with Gtk.Tree_Selection; use Gtk.Tree_Selection;  -- pour la sélection dans la vue
with p_util_treeview; use p_util_treeview;  -- utilitaire de gestion d'une treeView


with p_appli_creerfestival; use p_appli_creerfestival;
with Basec201_Data; use basec201_data;
with Ada.Containers.Vectors;
with p_conversion; use p_conversion;

with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with ada.calendar; use ada.calendar;
with ville_io;
with festival_io;
with jour_festival_io;


package P_window_creerfestival is

	EX_AUCUNE_VILLE_SELECTIONNEE:exception;


  procedure init;
  procedure fermerFenetre;
  procedure validerfestival;
  procedure inittreeview;
end P_window_creerfestival;
