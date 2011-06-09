--with tp_Intl; use tp_Intl;
with Glade.XML;use Glade.XML;

package body P_window_consultgroupe is

windowconsultgroupe:Gtk_window;
treeview_groupe:Gtk_Tree_View;
modele_groupe:Gtk_Tree_Store;
rang_groupe:Gtk_tree_iter:=Null_Iter;

		XML : Glade_XML;




------------------------------------------------------------------------
	procedure init is

	begin
	--Initialisation de la fenetre
		Glade.XML.Gtk_New(XML, "./src/ihm/glade/ConsultGroupe.glade", "windowconsultgroupe");
		windowconsultgroupe:=Gtk_Window(Get_Widget(XML,"windowconsultgroupe"));
	--connections aux handler
		Glade.XML.signal_connect (XML,"on_buttonFermer_clicked",fermerFenetre'address,Null_Address);
		Glade.XML.signal_connect (XML,"on_buttonDelete_clicked",deleteGroupe'address,Null_Address);
		treeview_groupe := Gtk_Tree_View(Get_Widget(XML,"treeview1"));
		inittreeview;
		Glade.XML.signal_connect (XML,"on_treeview1_cursor_changed",remplirinfo'address,Null_Address);
	end init;
---------------------------------------------------------------------
	procedure fermerFenetre is
	begin
		Destroy(windowconsultgroupe);
	end fermerFenetre;
--------------------------------------------------------------------------
	procedure remplirinfo is
		Groupes:Groupe_List.vector;
        	resulttreeviewgroupe:Unbounded_String;
	        Groupe:tgroupe;
		Ville:Unbounded_String;
	begin
                Get_Selected(Get_Selection(treeview_groupe),Gtk_Tree_Model(modele_groupe),rang_groupe);
                to_ada_type(Get_String (modele_groupe, rang_groupe, 0), resulttreeviewgroupe);

		Groupe := p_appli_consultgroupe.getTGroupe(resulttreeviewgroupe);
		Ville := p_appli_consultgroupe.getVilleGroupe(Groupe);

                Set_Text(Gtk_Entry(Get_Widget(XML,"entryGroupe")),p_conversion.to_string(groupe.Nom_Groupe));
                Set_Text(Gtk_Entry(Get_Widget(XML,"entryNomContact")),p_conversion.to_string(Groupe.Nom_Contact));
                Set_Text(Gtk_Entry(Get_Widget(XML,"entryAdresseContact")),p_conversion.to_string(Groupe.Coord_Contact));
                Set_Text(Gtk_Entry(Get_Widget(XML,"entryGenre")),tgenre_Enum'image(Groupe.Genre));
                Set_Text(Gtk_Entry(Get_Widget(XML,"entrySite")),p_conversion.to_string(Groupe.Adr_Site));
                Set_Text(Gtk_Entry(Get_Widget(XML,"entryVille")),p_conversion.to_string(Ville));
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
                          Set (modele_groupe, rang_groupe, 0, p_conversion.to_string(groupe.Nom_Groupe));
                end alimente;
	begin
		creerColonne("nomGroupe", treeView_Groupe, false);
                creerModele(treeView_Groupe,modele_groupe);
                liste_groupe := p_appli_consultgroupe.GetGroupes;
                Groupe_List.iterate(liste_groupe, alimente'Access);
	end inittreeview;

--------------------------------------------------------------------------	
procedure remplirtreeview is
       liste_groupe:Basec201_Data.Groupe_List.Vector;
       procedure alimente( pos : Groupe_List.Cursor ) is
                groupe : Basec201_Data.tGroupe;
       begin
                groupe := Groupe_List.element( pos );
                append (modele_groupe, rang_groupe, Null_Iter);
                Set (modele_groupe, rang_groupe, 0, p_conversion.to_string(groupe.Nom_Groupe));
       end alimente;

begin
       creerModele(treeView_Groupe,modele_groupe);
       liste_groupe := p_appli_consultgroupe.GetGroupes;
       Groupe_List.iterate(liste_groupe, alimente'Access);
end remplirtreeview;
--------------------------------------------------------------------------	
procedure deleteGroupe is
	b_box:message_dialog_buttons;
	nomgroupe : Unbounded_String;
begin
	Get_Selected(Get_Selection(treeview_groupe),Gtk_Tree_Model(modele_groupe),rang_groupe);
	if rang_groupe = Null_Iter then
		b_box := message_dialog("Aucun groupe sélectionné",Error,Button_Ok,Button_Ok);
	else
		to_ada_type(Get_String (modele_groupe, rang_groupe, 0), nomgroupe);
		b_box := message_dialog("Êtes-vous sûr de vouloir supprimer le groupe "& p_conversion.to_string(nomgroupe) &"?",Confirmation,Button_Yes or Button_No, Button_No);
		case b_box is
			when 1 =>
				p_appli_consultgroupe.delete(nomgroupe);
				remplirtreeview;
				Set_Text(Gtk_Entry(Get_Widget(XML,"entryGroupe")),"");
		                Set_Text(Gtk_Entry(Get_Widget(XML,"entryNomContact")),"");
        		        Set_Text(Gtk_Entry(Get_Widget(XML,"entryAdresseContact")),"");
                		Set_Text(Gtk_Entry(Get_Widget(XML,"entryGenre")),"");
	                	Set_Text(Gtk_Entry(Get_Widget(XML,"entrySite")),"");
	        	        Set_Text(Gtk_Entry(Get_Widget(XML,"entryVille")),"");
			when others=>
				null;
		end case;
	end if;
end deleteGroupe;
--------------------------------------------------------------------------
end P_window_consultgroupe;
