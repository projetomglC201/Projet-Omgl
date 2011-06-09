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
with Gtk.Toggle_button; Use Gtk.Toggle_Button;
with Gtk.Radio_Button; Use Gtk.Radio_Button;

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
  EXEntryGroupeEmpty:exception;
  EXEntryContactEmpty:exception;
  EXEntryCoordEmpty:exception;
  procedure init;
  procedure fermerFenetre;
  procedure enregistrergroupe;
  procedure inittreeviewville;
  procedure inittreeviewgroupejour1;
  procedure inittreeviewgroupejour2;
  procedure initselect;
  procedure remplirtreeviewgroupejour1(festival : in tfestival);
  procedure remplirtreeviewgroupejour2(festival : in tfestival);
  function GetActiveButtonGenre return Gtk_radio_Button;
  function GetActiveButtonJour return Gtk_radio_Button;
  procedure convertirnom (nom :in out Unbounded_String);
  procedure SetSensitiveJourSelect;
end P_window_enreggroupe;
