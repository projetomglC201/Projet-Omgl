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

with p_appli_enregville; use p_appli_enregville;
with Basec201_Data; use basec201_data;
with Ada.Containers.Vectors;
with p_conversion; use p_conversion;

with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

package P_window_enregville is

  EX_MAIL_INCORRECT:exception;
  procedure init;
	--initialise la fenetre, les signaux, la treeview
  procedure fermerFenetre;
	--ferme la fenetre
  procedure villesuivante;
	--récupère les infos entrées, enregistre la ville,met à jour la treeview et réinitialise les champs d'entrée
  procedure finenregistrementville;
	--Ferme la fenetre
  procedure inittreeview;
	--Initialise la treeview des villes
  procedure convertirnom (nom :in out Unbounded_String);
	--Convertit le nom 'nom' au format 1ère lettre en majuscule, le reste en minuscules
end P_window_enregville;
