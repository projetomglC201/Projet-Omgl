--with tp_Intl; use tp_Intl;
with Glade.XML;use Glade.XML;

package body P_window_enregville is

windowenregville:gtk_window;
-- déclaration des variables utiles pour la suite 1. 2. 3.
treeview_ville: Gtk_Tree_View;
modele_ville: Gtk_Tree_Store; -- le modèle associé à la vue
rang_ville: Gtk_Tree_Iter := Null_Iter; -- ligne dans le modèle


procedure init is
XML : Glade_XML;
begin
	Glade.XML.Gtk_New(XML, "./src/ihm/glade/EnregistrerVilles.glade", "windowenregville");
	treeview_ville:=Gtk_Tree_View(Get_Widget(XML,"treeview1"));
	windowenregville:=Gtk_Window(Get_Widget(XML,"windowenregville"));
	Glade.XML.signal_connect (XML,"on_buttonAnnuler_clicked",fermerFenetre'address,Null_Address);
	Glade.XML.signal_connect (XML,"on_buttonSuivant_clicked",villesuivante'address,Null_Address);
	Glade.XML.signal_connect (XML,"on_buttonTerminer_clicked",finenregistrementville'address,Null_Address);
end init;
---------------------------------------------------------------------
	procedure fermerFenetre is
	begin
		Destroy(windowenregville);
	end fermerFenetre;
--------------------------------------------------------------------------
	procedure villesuivante is
	--Enregistre la ville, efface le contenu des entry et met à jour la liste
	b_box:message_dialog_buttons;
	begin
		b_box:=message_dialog("Ville enregistrée !",Information,Button_Ok,Button_Ok);
		--a completer
	end villesuivante;
------------------------------------------------------------------------
	procedure finenregistrementville is
	b_box:message_dialog_buttons;
	begin
		b_box:=message_dialog("Ville enregistrée !",Information,Button_Ok,Button_Ok);
		--enregistrement
		Destroy(windowenregville);
	end finenregistrementville;
------------------------------------------------------------------------------
	procedure inittreeview is
		liste_ville:Basec201_Data.Ville_List.Vector;
		ville : Basec201_Data.tVille;
		
		procedure alimente( pos : Ville_List.Cursor ) is
			ville : Basec201_Data.tVille;
			begin
			  ville := Ville_List.element( pos );
			  append (modele_ville, rang_ville, Null_Iter);
			  Set (modele_ville, rang_ville, 0, p_conversion.to_string(ville.Nom_Ville));
		end alimente;

	begin
		
		creerColonne("nomVille", treeView_ville, false);
		creerModele(treeView_ville,modele_ville);
		liste_ville := p_appli_enregville.GetVillesExistantes;
		Ville_List.iterate(liste_ville, alimente'Access);
		
	
	end inittreeview;
end P_window_enregville;
