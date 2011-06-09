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
with Gtk.Image_Menu_Item; use Gtk.Image_Menu_Item;
with Gtk.Label; use Gtk.Label;
with Gtk.Scrolled_Window; use Gtk.Scrolled_Window; 

-- pour gérer le composant Tree_View
with Gtk.Tree_Model; use Gtk.Tree_Model;-- l'itérateur rang dans le modèle
with Gtk.Tree_Store; use Gtk.Tree_Store;-- le modèle associé à la vue
with Gtk.Tree_Selection; use Gtk.Tree_Selection;  -- pour la sélection dans la vue
with p_util_treeview; use p_util_treeview;  -- utilitaire de gestion d'une treeView

--Pour les autres fenêtres
with p_window_consultgroupe;
with p_window_consulterfestival;
with p_window_creerfestival;
with p_window_enregville;
with p_window_progfestival;
with p_window_consultprogramme;
with p_window_enreggroupe;
with p_window_creerfinale;
with p_window_enreggagnant;
with p_window_consultfinalistes;
with p_window_enreggagnantfinale;

--Couche appli
with p_appli_menu;


package p_window_menu is  
--Ce package gère la fenetre principale et les appels aux fenetres secondaires


procedure Init;
	--initialise la fenetre, les signaux, grise les options de menu inaccessibles en fonction des données présentes
procedure Reinit;  
	--demande confirmation puis réinitialise la base de données
procedure fermerFenetre;
	--ferme l'application

---------------------------------
--Ces procedures servent à l'ouverture des fenetres secondaires
procedure Openenregvilles;  
procedure Opencreerfestival;  
procedure Openconsultfestival;  
procedure Openprogfestival;  
procedure Openenreggroupe;  
procedure Openconsultgroupe;
procedure Openconsultprogramme;
procedure Opencreerfinale;
procedure OpenEnregGagnant;
procedure OpenConsultFinalistes;
procedure OpenEnregGagnantFinale;
--------------------------------
--Ces procedures servent à la mise à jour des options de menu grisées
procedure CheckFestival;
procedure CheckGroupe;
procedure CheckFinale;
-------------------------------
end  p_window_menu;

