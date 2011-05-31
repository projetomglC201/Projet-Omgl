--with tp_Intl; use tp_Intl;
with Glade.XML;use Glade.XML;
with System; use System;
with Gtk.Main;
with Gtkada.Dialogs;use Gtkada.Dialogs;

-- pour gérer les composants de la fenetre
with Gtk.Window; use Gtk.Window;
with Gtk.Button; use Gtk.Button;
with Gtk.Gentry; use Gtk.Gentry;
with Gtk.Tree_View; use Gtk.Tree_View;
with Gtk.Label; use Gtk.Label;
with Gtk.Scrolled_Window; use Gtk.Scrolled_Window; 

-- pour gérer le composant Tree_View
with Gtk.Tree_Model; use Gtk.Tree_Model;-- l'itérateur rang dans le modèle
with Gtk.Tree_Store; use Gtk.Tree_Store;-- le modèle associé à la vue
with Gtk.Tree_Selection; use Gtk.Tree_Selection;  -- pour la sélection dans la vue
with Gtk.Tree_View_column; use Gtk.Tree_View_column;
with p_util_treeview; use p_util_treeview;  -- utilitaire de gestion d'une treeView

with p_appli_enreggroupe; use p_appli_enreggroupe;
with Basec201_Data; use basec201_data;
with p_conversion; use p_conversion;
with base_types; use base_types;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with ada.calendar; use ada.calendar;

package P_window_enreggroupe is
  EX_AUCUNE_VILLE_SELECTIONNEE:exception;
  procedure init;
  procedure fermerFenetre;
  procedure enregistrergroupe;
  procedure inittreeviewville;
  procedure inittreeviewjour1;
  procedure inittreeviewjour2;
  procedure initselect;
  procedure remplirtreeviewjour1(festival : in tfestival);
  procedure remplirtreeviewjour2(festival : in tfestival);

end P_window_enreggroupe;
