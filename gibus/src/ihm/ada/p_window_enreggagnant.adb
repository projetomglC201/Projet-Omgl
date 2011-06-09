

package body p_window_enreggagnant is

b_box:message_dialog_buttons;
XML : Glade_XML;
window:Gtk_window;
festival:tfestival;
-- déclaration des variables utiles pour la suite 1. 2. 3.
treeview_ville: Gtk_Tree_View;
modele_ville: Gtk_Tree_Store; -- le modèle associé à la vue
rang_ville: Gtk_Tree_Iter := Null_Iter; -- ligne dans le modèle

treeview_groupe: Gtk_Tree_View;
modele_groupe: Gtk_Tree_Store; -- le modèle associé à la vue
rang_groupe: Gtk_Tree_Iter := Null_Iter; -- ligne dans le modèle
----------------------------------------------------------------------------
procedure init is

begin
	Glade.XML.Gtk_New(XML, "./src/ihm/glade/enregGagnant.glade", "windowEnregGagnant");
	window := Gtk_Window(Get_Widget(XML,"windowEnregGagnant"));
	treeview_ville:=Gtk_Tree_View(Get_Widget(XML,"treeviewville"));
	treeview_groupe:=Gtk_Tree_View(Get_Widget(XML,"treeviewgroupe"));
	
	Glade.XML.signal_connect (XML,"on_buttonAnnuler_clicked",fermerFenetre'address,Null_Address);
	Glade.XML.signal_connect (XML,"on_buttonEnregistrer_clicked",enregistrergagnant'address,Null_Address);
	Glade.XML.signal_connect (XML,"on_treeviewville_cursor_changed",remplirtreeviewgroupe'address,Null_Address);
	
	inittreeviewville;
	remplirtreeviewville;
	inittreeviewgroupe;


end init;
------------------------------------------------------------------------------
	procedure fermerFenetre is
	begin
		Destroy(window);
	end fermerFenetre;
-----------------------------------------------------------------------------
	procedure enregistrergagnant is
	
	resulttreeviewgroupe:unbounded_string;
	begin
	
		Get_Selected(Get_Selection(treeview_ville),Gtk_Tree_model(modele_ville), 
		rang_ville);
		if rang_ville = Null_Iter then
			
			raise EX_AUCUNE_VILLE_SELECTIONNEE;
		end if;
		Get_Selected(Get_Selection(treeview_groupe),Gtk_Tree_model(modele_groupe), 
		rang_groupe);
		if rang_groupe = Null_Iter then
			
			raise EX_AUCUN_GROUPE_SELECTIONNEE;
		else
				to_ada_type(Get_String (modele_groupe, rang_groupe, 0), resulttreeviewgroupe);
		end if;
	b_box := Message_Dialog("Êtes-vous sûr de vouloir enregistrer le groupe "&p_conversion.to_string(resulttreeviewgroupe)&"comme gagnant du festival de "&p_conversion.to_string(festival.ville_festival)&"?",Confirmation,Button_Yes or button_no, button_no);
	if b_box = 1 then
		SaveGagnantFestival(festival,resulttreeviewgroupe);
		clear(modele_groupe);
		remplirtreeviewville;
	end if;		
	exception
		when EX_AUCUN_GROUPE_SELECTIONNEE
			=> b_box:=Message_Dialog ("Aucun groupe selectionné",Error,Button_Ok,Button_Ok);
		when EX_AUCUNE_VILLE_SELECTIONNEE
			=> b_box := Message_Dialog("Aucune ville sélectionnée",Error,Button_Ok,Button_Ok);
	
	end enregistrergagnant;
-------------------------------------------------------------------------------
	procedure remplirtreeviewgroupe is
		
		resulttreeviewville:unbounded_string;
		liste_groupe:Basec201_Data.Groupe_List.Vector;
		groupe : Basec201_Data.tGroupe;
	
		procedure alimente( pos : Groupe_List.Cursor ) is
			Groupe : Basec201_Data.tGroupe;
		begin
			
			  Groupe := Groupe_List.element( pos );
			  append (modele_groupe, rang_groupe, Null_Iter);
			  Set (modele_groupe, rang_groupe, 0, p_conversion.to_string(groupe.Nom_Groupe));
		end alimente;
	begin
		CreerModele(treeview_groupe,modele_groupe);
		Clear(modele_groupe);

		Get_Selected(Get_Selection(treeview_ville),Gtk_Tree_model(modele_ville), 
		rang_ville);
		if rang_ville = Null_Iter then
			
			raise EX_AUCUNE_VILLE_SELECTIONNEE;
		else
			to_ada_type(Get_String (modele_ville, rang_ville, 0), resulttreeviewville);
		end if;
		Festival:=GetFestivalAssocie(resulttreeviewville);

		liste_groupe :=p_appli_enreggagnant.GetGroupes(festival);

		groupe_list.iterate(liste_groupe, alimente'Access);
	exception
		when EX_AUCUNE_VILLE_SELECTIONNEE
			=> b_box:=Message_Dialog ("Aucune ville selectionnée",Error,Button_Ok,Button_Ok);
	
	end remplirtreeviewgroupe;
---------------------------------------------------------------------------------
	procedure inittreeviewville is
	

	begin

		creerColonne("nomVille", treeView_ville, false);
		
		creerModele(treeView_ville,modele_ville);

	
	end inittreeviewville;
-------------------------------------------------------------------------------
	procedure remplirtreeviewville is

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
	
		clear(modele_ville);
	
		liste_ville := p_appli_enreggagnant.GetVillesSansFinaliste;
		
		Ville_List.iterate(liste_ville, alimente'Access);
	
	
	end remplirtreeviewville;
------------------------------------------------------------------------------
	procedure inittreeviewgroupe is

	
	begin
		
		creerColonne("NomVille", treeView_groupe, false);
		creerColonne("Genre", treeView_groupe, false);
		
		creerModele(treeView_groupe,modele_groupe);


	end inittreeviewgroupe;
-----------------------------------------------------------------------------------












end p_window_enreggagnant;
