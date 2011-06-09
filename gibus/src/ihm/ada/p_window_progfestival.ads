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
	--initialise la fenetre, les signaux, les treeviews et selectionne la premiere partie de la fenetre
  procedure fermerFenetre;
	--ferme la fenetre
  procedure initregion1;
	--initialise la première partie de la fenetre
  procedure initregion2;
	--initialise la seconde partie de la fenetre
  procedure fillTreeviewJour1(groupes : in groupe_list.vector);
	--remplit la treeview des groupes du jour 1 avec les groupes de 'groupes'
  procedure fillTreeViewJour2(groupes : in groupe_list.vector);
	--remplit la treeview des groupes du jour 2 avec les groupes de 'groupes'
  procedure selectionregion1;
	--Selectionne la première partie de la fenetre, grise et vide la seconde
  procedure selectionregion2;
	--Selectionne la deuxieme partie de la fenetre et grise la première
  procedure rechercherprog;
	--affiche les informations du festival sélectionné dans la treeview des villes
  procedure finprogrammation;
	--récupère toutes les infos entrées et sauvegarde la programmation
  procedure switchjour2;
	--passe le jour sélectionné dans la liste du jour 1 vers le jour 2
  procedure switchjour1; 
	--passe le jour sélectionné dans la liste du jour 2 vers le jour 1
  procedure upgroupe;
	--monte le groupe sélectionné dans sa liste d'un cran
  procedure top;
	--monte le groupe sélectionné en haut de sa liste
  procedure downGroupe;
	--descend le groupe sélectionné dans sa liste d'un cran
  procedure bot;
	--descend le groupe sélectionné en bas de sa liste
  procedure deleteGroupe;
	--supprime le groupe sélectionné de sa liste
  procedure clearright;
	--efface la sélection de la treeview de droite
  procedure clearleft;
	--efface la sélection de la treeview de gauche
end P_window_progfestival;
