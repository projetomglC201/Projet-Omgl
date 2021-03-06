

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

with p_appli_consultfinalistes; use p_appli_consultfinalistes;
with Basec201_Data; use basec201_data;
with p_conversion; use p_conversion;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with base_types; use base_types;



package p_window_consultfinalistes is

procedure init;
	--initialise la fenetre, les signaux, les treeviews
procedure fermerFenetre;
	--ferme la fenetre
procedure inittreeviewfinalistes;
	--initialise la treeview des finalistes
procedure remplirtreeviewfinalistes;
	--met à jour les valeurs de la treeview des finalistes.


end p_window_consultfinalistes;
