

package body P_window_consulterfestival is
b_box:message_dialog_buttons;
XML : Glade_XML;
windowconsulterfestival : Gtk_window;

-- déclaration des variables utiles pour la suite 1. 2. 3.
treeview_ville: Gtk_Tree_View;
modele_ville: Gtk_Tree_Store; -- le modèle associé à la vue
rang_ville: Gtk_Tree_Iter := Null_Iter; -- ligne dans le modèle

---------------------------------------------------------------------------------
procedure init is


begin
	Glade.XML.Gtk_New(XML, "./src/ihm/glade/ConsulterFestival.glade", "windowconsulterfestival");
	
	windowconsulterfestival := Gtk_Window(Get_Widget(XML,"windowconsulterfestival"));
	treeview_ville:=Gtk_Tree_View(Get_Widget(XML,"treeview1"));
	Glade.XML.signal_connect (XML,"on_buttonFermer_clicked",fermerFenetre'address,Null_Address);
	Glade.XML.signal_connect (XML,"on_treeview1_cursor_changed",remplirentry'address,Null_Address);
	
	inittreeview;
end init;
-------------------------------------------------------------------------
	procedure fermerFenetre is
	begin
		Destroy(windowconsulterfestival);
	end fermerFenetre;
--------------------------------------------------------------------------
	procedure remplirentry is
	Festival:Festival_List.vector;
	Jours_Festival:Jour_Festival_List.vector;
	resulttreeviewville:Unbounded_String;
	Ville:tville;
	
	begin
		--Recuperation de la selection dans la treeview
		Get_Selected(Get_Selection(treeview_ville),Gtk_Tree_Model(modele_ville), 
		rang_ville);
		if rang_ville = Null_Iter then
			b_box:=Message_Dialog ("Aucune ville selectionnée",Error,Button_Ok,Button_Ok);
			raise EX_AUCUNE_VILLE_SELECTIONNEE;
		else
			to_ada_type(Get_String (modele_ville, rang_ville, 0), resulttreeviewville);
		end if;	
	
		Festival:=GetFestivalAssocie(resulttreeviewville);
		Jours_Festival:=GetJoursFestivalAssocie(Festival_List.First_element(Festival).id_festival);
		Ville:=GetVille(resulttreeviewville);
		
		Set_Text(Gtk_Entry(Get_Widget(XML,"entryVille")),p_conversion.to_string(ville.Nom_ville));
		Set_Text(Gtk_Entry(Get_Widget(XML,"entryLieu")),p_conversion.to_string(Festival_list.First_Element(festival).Lieu));
		Set_Text(Gtk_Entry(Get_Widget(XML,"entryDate")),(integer'image(Day(Festival_list.First_Element(Festival).Date))&"/"&integer'image(Month(Festival_list.First_Element(festival).Date))&"/"&integer'image(Year(Festival_list.First_Element(festival).Date))));
		Set_Text(Gtk_Entry(Get_Widget(XML,"entryNbJour")),integer'image(integer(Jour_Festival_IO.Card(Jours_Festival))));
		Set_Text(Gtk_Entry(Get_Widget(XML,"entryPrix")),integer'image(Festival_list.First_Element(festival).Prix_Place));
		Set_Text(Gtk_Entry(Get_Widget(XML,"entryContact")),p_conversion.to_string(ville.Mel_Contact));
		
		
	end remplirentry;
--------------------------------------------------------------------------
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

		liste_ville := p_appli_consulterfestival.GetVillesAvecFestival;
		
		Ville_List.iterate(liste_ville, alimente'Access);
	
	end inittreeview;
---------------------------------------------------------------------------	
	

end P_window_consulterfestival;
