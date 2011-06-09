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

with basec201_data; use basec201_data;
with festival_io;
with ville_io;
with jour_festival_io;
with groupe_io;

with p_conversion; use p_conversion;
with p_appli_enreggroupe;
with p_appli_consultprog;

with ada.strings.unbounded; use ada.strings.unbounded;

package P_window_consultprogramme is
  procedure init;
	--initialise la fenetre, les signaux, les treeviews
  procedure fermerFenetre;
	--ferme la fenetre
  procedure selectfest;
	--récupère les infos du festival sélectionné dans la tree view et les écrit
  procedure inittreeviewfest;
	--Initialise et remplit la treeview des festivals
  procedure inittreeviewJour1;
	--initialise la treeview du jour 1
  procedure inittreeviewJour2;
	--initialise la treeview du jour 2
  procedure filltreeviewJour1(id : in integer);
	--remplit la treeview du jour 1 avec les groupes associés au Jour_Festival id
  procedure filltreeviewJour2(id : in integer);
	--remplit la treeview du jour 2 avec les groupes associés au Jour_Festival id
end P_window_consultprogramme;
