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
	--initialise la fenetre, les signaux, les treeviews
  procedure fermerFenetre;
	--ferme la fenetre
  procedure enregistrergroupe;
	--Récupère les infos entrées et enregistre le groupe
  procedure inittreeviewville;
	--initialise et remplit la treeview des villes
  procedure inittreeviewgroupejour1;
	--initialise la treeview des groupes du jour 1
  procedure inittreeviewgroupejour2;
	--initialise la treeview des groupes du jour 2
  procedure initselect;
	--initialise les treeviews de groupes et les champs de texte
  procedure remplirtreeviewgroupejour1(festival : in tfestival);
	--remplit la treeview des groupes du jour 1 du festival 'festival'
  procedure remplirtreeviewgroupejour2(festival : in tfestival);
	--remplit la treeview des groupes du jour 2 du festival 'festival'
  function GetActiveButtonGenre return Gtk_radio_Button;
	--Retourne la radio_button des genres sélectionné
  function GetActiveButtonJour return Gtk_radio_Button;
	--Retourne la radio_button du jour sélectionné
  procedure convertirnom (nom :in out Unbounded_String);
	--Converti le nom 'nom' au format 1ère lettre majuscule, le reste en minuscules
  procedure SetSensitiveJourSelect;
	--Grise les informations du jour non sélectionné et dégrise celles du jour sélectionné
end P_window_enreggroupe;
