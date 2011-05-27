--with tp_Intl; use tp_Intl;
with Glade.XML;use Glade.XML;

package body P_window_consultgroupe is

windowconsultgroupe:Gtk_window;
treeview_groupe:Gtk_Tree_View;
modele_groupe:Gtk_Tree_Store;
rang_groupe:Gtk_tree_iter:=Null_Iter;





------------------------------------------------------------------------
	procedure init is
		XML : Glade_XML;
	begin
	--Initialisation de la fenetre
		Glade.XML.Gtk_New(XML, "./src/ihm/glade/ConsultGroupe.glade", "windowconsultgroupe");
		windowconsultgroupe:=Gtk_Window(Get_Widget(XML,"windowconsultgroupe"));
	--connections aux handler
		Glade.XML.signal_connect (XML,"on_buttonFermer_clicked",fermerFenetre'address,Null_Address);
		inittreeview;
		Glade.XML.signal_connect (XML,"on_treeview1_row_activated",remplirinfo'address,Null_Address);
	end init;
---------------------------------------------------------------------
	procedure fermerFenetre is
	begin
		Destroy(windowconsultgroupe);
	end fermerFenetre;
--------------------------------------------------------------------------
	procedure remplirinfo is
		Groupe:Groupe_List.vector;
        	resulttreeviewgroupe:Unbounded_String;
	        Groupe:tgroupe;
	begin
                Get_Selected(Get_Selection(treeview_groupe),Gtk_Tree_Model(modele_groupe),rang_groupe);
                to_ada_type(Get_String (modele_groupe, rang_groupe, 0), resulttreeviewgroupe);

		Groupe := GetTGroupe(resulttreeviewgroupe);

                Set_Text(Gtk_Entry(Get_Widget(XML,"entryGroupe")),p_conversion.to_string(groupe.Nom_Groupe));
                Set_Text(Gtk_Entry(Get_Widget(XML,"entryNomContact")),p_conversion.to_string(Groupe.Nom_Contact));
                Set_Text(Gtk_Entry(Get_Widget(XML,"entryMelContact")),p_conversion.to_string(Groupe.Coord_Contact));
                Set_Text(Gtk_Entry(Get_Widget(XML,"entryGenre")),;
                Set_Text(Gtk_Entry(Get_Widget(XML,"entrySite")),integer'image(Festival_list.First_Element(festival).Prix_Place));
                Set_Text(Gtk_Entry(Get_Widget(XML,"entryVille")),p_conversion.to_string(ville.Mel_Contact));
	end remplirinfo;
--------------------------------------------------------------------------
	procedure inittreeview is
		liste_groupe:Basec201_Data.Groupe_List.Vector;
		groupe : Basec201_Data.tGroupe;

		procedure alimente( pos : Groupe_List.Cursor ) is
                        groupe : Basec201_Data.tGroupe;
                begin
                          groupe := Groupe_List.element( pos );
                          append (modele_groupe, rang_groupe, Null_Iter);
                          Set (modele_groupe, rang_groupe, 0, p_conversion.to_string(groupe.Nom_Groupe);
                end alimente;

	begin
		creerColonne("nomGroupe", treeView_Groupe, false);
                creerModele(treeView_Groupe,modele_groupe);
                liste_groupe := p_appli_consultgroupe.GetGroupes;
                Groupe_List.iterate(liste_groupe, alimente'Access);
	end inittreeview;

	end P_window_consultgroupe;

