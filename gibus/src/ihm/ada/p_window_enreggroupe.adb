--with tp_Intl; use tp_Intl;
with Glade.XML;use Glade.XML;




package body P_window_enreggroupe is
b_box:message_dialog_buttons;
XML : Glade_XML;
window:Gtk_window;
-- déclaration des variables utiles pour la suite 1. 2. 3.
treeview_ville: Gtk_Tree_View;
modele_ville: Gtk_Tree_Store; -- le modèle associé à la vue
rang_ville: Gtk_Tree_Iter := Null_Iter; -- ligne dans le modèle

treeview_jour1: Gtk_Tree_View;
modele_jour1: Gtk_Tree_Store; -- le modèle associé à la vue
rang_jour1: Gtk_Tree_Iter := Null_Iter; -- ligne dans le modèle

treeview_jour2: Gtk_Tree_View;
modele_jour2: Gtk_Tree_Store; -- le modèle associé à la vue
rang_jour2: Gtk_Tree_Iter := Null_Iter; -- ligne dans le modèle

----------------------------------------------------------------------------
procedure init is

begin
	Glade.XML.Gtk_New(XML, "./src/ihm/glade/enregGroupe.glade", "windowenreggroupe");
	window := Gtk_Window(Get_Widget(XML,"windowenreggroupe"));
	treeview_ville:=Gtk_Tree_View(Get_Widget(XML,"treeviewville"));
	treeview_jour1:=Gtk_Tree_View(Get_Widget(XML,"treeviewjour1"));
	treeview_jour2:=Gtk_Tree_View(Get_Widget(XML,"treeviewjour2"));
	
	
	Glade.XML.signal_connect (XML,"on_buttonAnnuler_clicked",fermerFenetre'address,Null_Address);
	Glade.XML.signal_connect (XML,"on_buttonEnregistrer_clicked",enregistrergroupe'address,Null_Address);
	Glade.XML.signal_connect (XML,"on_treeviewville_row_activated",initselect'address,Null_Address);

end init;
------------------------------------------------------------------------------
	procedure fermerFenetre is
	begin
		Destroy(window);
	end fermerFenetre;
---------------------------------------------------------------------------
	procedure enregistrergroupe is
		
	begin
		b_box:=message_dialog("Groupe enregistré !",Information,Button_Ok,Button_Ok);
	end enregistrergroupe;
-----------------------------------------------------------------------------
	procedure inittreeviewville is
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
		
		liste_ville := p_appli_enreggroupe.GetVillesAvecFestival;
		
		Ville_List.iterate(liste_ville, alimente'Access);
	
	end inittreeviewville;
-----------------------------------------------------------------------------
	procedure inittreeviewjour1 (festival : in tfestival) is
		liste_groupe:Basec201_Data.Groupe_List.Vector;
		groupe : Basec201_Data.tGroupe;
		
		procedure alimente( pos : Groupe_List.Cursor ) is
			Groupe : Basec201_Data.tGroupe;
		begin
			  Groupe := Groupe_List.element( pos );
			  append (modele_jour1, rang_jour1, Null_Iter);
			  Set (modele_jour1, rang_jour1, 0, p_conversion.to_string(groupe.Nom_Groupe));
			  Set (modele_jour1, rang_jour1, 1, tgenre_Enum'image(groupe.Genre));
		end alimente;
	begin
		
		creerColonne("NomVille", treeView_jour1, false);
		creerColonne("Genre", treeView_jour1, false);
		
		creerModele(treeView_jour1,modele_jour1);
		
		liste_groupe :=p_appli_enreggroupe.GetGroupesJour1(festival);
		
		groupe_list.iterate(liste_groupe, alimente'Access);
	
	end inittreeviewjour1;

-----------------------------------------------------------------------------
	procedure inittreeviewjour2 (festival : in tfestival) is
		liste_groupe:Basec201_Data.Groupe_List.Vector;
		groupe : Basec201_Data.tgroupe;
		
		procedure alimente( pos : Groupe_List.Cursor ) is
			Groupe : Basec201_Data.tGroupe;
		begin
			  Groupe := Groupe_List.element( pos );
			  append (modele_jour2, rang_jour2, Null_Iter);
			  Set (modele_jour2, rang_jour2, 0, p_conversion.to_string(groupe.Nom_Groupe));
			  Set (modele_jour2, rang_jour2, 1, tgenre_Enum'image(groupe.Genre));
		end alimente;

	begin
		
		creerColonne("NomVille", treeView_jour2, false);
		creerColonne("Genre", treeView_jour2, false);
		
		creerModele(treeView_jour2,modele_jour2);
		
		liste_groupe :=p_appli_enreggroupe.GetGroupesJour1(festival);
		
		groupe_list.iterate(liste_groupe, alimente'Access);
	
	end inittreeviewjour2;
---------------------------------------------------------------------------
	procedure initselect is
	Festival:festival_list.vector;
	resulttreeviewville:Unbounded_String;
	
	
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
		
		Set_Text(Gtk_Entry(Get_Widget(XML,"entryDateJour1")),(integer'image(Day(Festival_list.First_Element(Festival).Date))&"/"&integer'image(Month(Festival_list.First_Element(festival).Date))&"/"&integer'image(Year(Festival_list.First_Element(festival).Date))));
	end initselect;
------------------------------------------------------------------------

end P_window_enreggroupe;

