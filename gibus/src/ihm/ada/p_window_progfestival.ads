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
with Gtk.combo_Box; Use Gtk.combo_Box;

-- pour gérer le composant Tree_View
with Gtk.Tree_Model; use Gtk.Tree_Model;-- l'itérateur rang dans le modèle
with Gtk.Tree_Store; use Gtk.Tree_Store;-- le modèle associé à la vue
with Gtk.Tree_Selection; use Gtk.Tree_Selection;  -- pour la sélection dans la vue
with p_util_treeview; use p_util_treeview;  -- utilitaire de gestion d'une treeView

with p_appli_progfestival;
with basec201_data; use basec201_data;
with p_conversion;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with base_types; use base_types;

package P_window_progfestival is
  procedure init;
  procedure fermerFenetre;
  procedure initregion1;
  procedure initregion2;
  procedure fillTreeviewJour1(groupes : in groupe_list.vector);
  procedure fillTreeViewJour2(groupes : in groupe_list.vector);
  procedure selectionregion1;
  procedure selectionregion2;
  procedure rechercherprog;
  procedure finprogrammation;
  procedure switchjour2;
  procedure switchjour1; 
  procedure upgroupe;
  procedure top;
  procedure downGroupe;
  procedure bot;
  procedure deleteGroupe;
  procedure clearright;
  procedure clearleft;
end P_window_progfestival;
