--with tp_Intl; use tp_Intl;
with Glade.XML;use Glade.XML;

package body P_window_consultprogramme is


windowconsultprogramme:gtk_window;

treeview_festival: Gtk_Tree_View;
modele_festival: Gtk_Tree_Store; 
rang_festival: Gtk_Tree_Iter := Null_Iter;

treeview_jour1: Gtk_Tree_View;
modele_jour1: Gtk_Tree_Store; 
rang_jour1: Gtk_Tree_Iter := Null_Iter; 

treeview_jour2: Gtk_Tree_View;
modele_jour2: Gtk_Tree_Store; 
rang_jour2: Gtk_Tree_Iter := Null_Iter;

XML : Glade_XML;
-------------------------------------------------------------------
procedure init is

begin
	Glade.XML.Gtk_New(XML, "./src/ihm/glade/consultProgramme.glade", "windowconsulterprogramme");
	windowconsultprogramme:=Gtk_Window(Get_Widget(XML,"windowconsulterprogramme"));
	
		Glade.XML.signal_connect(XML,"on_buttonOK_clicked",fermerFenetre'address,Null_Address);
		Glade.XML.signal_connect(XML,"on_treeview1_cursor_changed",selectFest'address,Null_Address);
	treeview_festival :=Gtk_Tree_View(Get_Widget(XML,"treeview1"));
	treeview_jour1:=Gtk_Tree_View(Get_Widget(XML,"treeview2"));	
	treeview_jour2:=Gtk_Tree_View(Get_Widget(XML,"treeview3"));
	initTreeviewFest;
	initTreeviewJour1;
	initTreeviewJour2;
end init;
---------------------------------------------------------------------
	procedure fermerFenetre is
	begin
		Destroy(windowconsultprogramme);
	end fermerFenetre;
---------------------------------------------------------------------------
	procedure initTreeviewFest is
		liste_ville:Basec201_Data.Ville_List.Vector;
                procedure alimente( pos : Ville_List.Cursor ) is
                        ville : Basec201_Data.tVille;
                begin
                          ville := Ville_List.element( pos );
                          append (modele_festival, rang_festival, Null_Iter);
                          Set (modele_festival, rang_festival, 0, p_conversion.to_string(Ville.nom_Ville));
                end alimente;

        begin
                creerColonne("nomVille", treeView_festival, false);
                creerModele(treeView_festival,modele_festival);
                liste_ville := p_appli_enreggroupe.GetVillesAvecFestival;
                Ville_List.iterate(liste_ville, alimente'Access);
	end initTreeviewFest;
---------------------------------------------------------------------------
	procedure initTreeviewJour1 is
        begin
                creerColonne("ordrePassage", treeView_jour1, false);
		creerColonne("NomGroupe", treeView_jour1, false);
                creerModele(treeView_jour1,modele_jour1);
        end initTreeviewJour1;

---------------------------------------------------------------------------
	procedure initTreeviewJour2 is
        begin
                creerColonne("ordrePassage", treeView_jour2, false);
		creerColonne("NomGroupe", treeView_jour2, false);
                creerModele(treeView_jour2,modele_jour2);
        end initTreeviewJour2;
---------------------------------------------------------------------------
	procedure fillTreeviewJour1(id : in integer) is
        	liste_groupe : basec201_data.Groupe_List.Vector;
		procedure alimente( pos : Groupe_List.Cursor ) is
                          groupe : Basec201_Data.tGroupe;
                begin
                          groupe := Groupe_List.element( pos );
                          append (modele_jour1, rang_jour1, Null_Iter);
                          Set (modele_jour1, rang_jour1, 0, p_conversion.to_string(Groupe.Ordre_Passage));
			  Set (modele_jour1, rang_jour1, 1, p_conversion.to_string(Groupe.Nom_Groupe));
                end alimente;
	begin
		p_appli_consultProg.getGroupInfo(id, liste_groupe);
      clear(modele_Jour1);
		clear(modele_jour2); --Au cas ou le festival n'a qu'un jour
		Groupe_List.iterate(liste_groupe,alimente'access);
	end fillTreeviewJour1;
---------------------------------------------------------------------------
	procedure fillTreeviewJour2(id : in integer) is
        	liste_groupe : basec201_data.Groupe_List.Vector;
                procedure alimente( pos : Groupe_List.Cursor ) is
                        groupe : Basec201_Data.tGroupe;
                begin
                          groupe := Groupe_List.element( pos );
                          append (modele_jour2, rang_jour2, Null_Iter);
                          Set (modele_jour2, rang_jour2, 0, p_conversion.to_string(Groupe.Ordre_Passage));
			  Set (modele_jour2, rang_jour2, 1, p_conversion.to_string(Groupe.Nom_Groupe));
                end alimente;
		
        begin
		p_appli_consultProg.getGroupInfo(id, liste_groupe);
		clear(modele_jour2);
		Groupe_List.iterate(liste_groupe,alimente'access);
        end fillTreeviewJour2;
---------------------------------------------------------------------------
	procedure selectFest is
		nom_ville : unbounded_string;
		nom_lieu : unbounded_string;
		datejour1 : unbounded_string;
		datejour2 : unbounded_string;
		idjour1 : integer;
		idjour2 : integer;
		jour2 : boolean;
		b_box : message_dialog_buttons;
	begin
		Get_Selected(Get_Selection(treeview_festival),Gtk_Tree_model(modele_festival),rang_festival);
		if rang_festival = null_iter then
			b_box := message_dialog("Aucun festival selectionné",Error,Button_ok,Button_ok);
		else
			to_ada_type(Get_String(modele_festival,rang_festival,0), nom_ville);
		end if;
		
		p_appli_consultprog.getFestInfo(nom_ville,nom_lieu,datejour1,datejour2,idjour1,idjour2,jour2);
		set_text(Gtk_Entry(Get_Widget(XML,"entryLieu")), p_conversion.to_string(nom_lieu));
		set_text(Gtk_Entry(Get_Widget(XML,"entryDate1")), p_conversion.to_string(datejour1));
		filltreeviewjour1(idjour1);

		if jour2 then
			set_text(Gtk_Entry(Get_Widget(XML,"entryDate2")), p_conversion.to_string(datejour2));
			filltreeviewjour2(idjour2);
		else
			set_text(Gtk_Entry(Get_Widget(XML,"entryDate2")),"Pas de jour 2" );

		end if;
	end selectFest;
--------------------------------------------------------------------
end P_window_consultprogramme;
