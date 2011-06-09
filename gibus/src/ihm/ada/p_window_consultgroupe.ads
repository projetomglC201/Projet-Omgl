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
with p_util_treeview; use p_util_treeview;  -- utilitaire de gestion d'une treeView
with Ada.Containers.Vectors;
with Ada.Strings.Unbounded; use ada.strings.unbounded;
with basec201_data; use basec201_data;
with p_conversion; use p_conversion;
with p_appli_consultgroupe; use p_appli_consultgroupe;
with base_types; use base_types;

package P_window_consultgroupe is
  procedure init;
	--Initialise la fenetre, la treeview, les signaux
  procedure fermerFenetre;
	--Ferme la fenetre
  procedure remplirinfo;
	--Remplis les champs avec les infos du groupe
  procedure inittreeview;
	--Initialise la treeview des groupes
  procedure remplirtreeview;
	--Met à jour les informations de la treeview
  procedure deletegroupe;
	--Supprime le groupe selectionné
end P_window_consultgroupe;
