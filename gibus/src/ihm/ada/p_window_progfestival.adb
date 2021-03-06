--with tp_Intl; use tp_Intl;
with Glade.XML;use Glade.XML;
with ada.text_io;

package body P_window_progfestival is

windowprogfestival:gtk_window;
XML : Glade_XML;

treeview_festival : Gtk_Tree_View;
modele_festival : Gtk_Tree_Store;
rang_festival : Gtk_Tree_Iter := Null_Iter;

treeview_jour1 : Gtk_Tree_View;
modele_jour1 : Gtk_Tree_Store;
rang_jour1 : Gtk_Tree_Iter := Null_Iter;

treeview_jour2 : Gtk_Tree_View;
modele_jour2 : Gtk_Tree_Store;
rang_jour2 : Gtk_Tree_Iter := Null_Iter;

jour1,jour2 : groupe_list.vector;

procedure init is

begin
	Glade.XML.Gtk_New(XML, "./src/ihm/glade/ProgrammerFestival.glade", "windowprogrammerfestival");
	windowprogfestival:=Gtk_Window(Get_Widget(XML,"windowprogrammerfestival"));
	Glade.XML.signal_connect (XML,"on_buttonAnnuler1_clicked",fermerFenetre'address,Null_Address);
	Glade.XML.signal_connect (XML,"on_buttonAnnuler2_clicked",selectionregion1'address,Null_Address);
	Glade.XML.signal_connect (XML,"on_buttonValider_clicked",rechercherprog'address,Null_Address);
	Glade.XML.signal_connect (XML,"on_buttonTerminer_clicked",finprogrammation'address,Null_Address);
	Glade.XML.signal_connect (XML,"on_buttonright_clicked",switchJour2'address,Null_Address);
	Glade.XML.signal_connect (XML,"on_buttonleft_clicked",switchJour1'address,Null_Address);

        Glade.XML.signal_connect (XML,"on_buttonUp_clicked",upGroupe'address,Null_Address);
        Glade.XML.signal_connect (XML,"on_buttonTop_clicked",top'address,Null_Address);
        Glade.XML.signal_connect (XML,"on_buttonDown_clicked",downGroupe'address,Null_Address);
        Glade.XML.signal_connect (XML,"on_buttonBot_clicked",bot'address,Null_Address);
        Glade.XML.signal_connect (XML,"on_buttonDelete_clicked",deleteGroupe'address,Null_Address);
        Glade.XML.signal_connect (XML,"on_treeviewGauche_cursor_changed",clearright'address,Null_Address);
        Glade.XML.signal_connect (XML,"on_treeviewDroite_cursor_changed",clearleft'address,Null_Address);
	
	Treeview_Festival := Gtk_Tree_View(Get_Widget(XML,"treeviewNomFestival"));
	treeview_jour1 := Gtk_Tree_View(Get_Widget(XML,"treeviewGauche"));
	treeview_jour2 := Gtk_Tree_View(Get_Widget(XML,"treeviewDroite"));
	
	initregion1;
	initregion2;
	selectionregion1;
end init;
---------------------------------------------------------------------
	procedure fermerFenetre is
	begin
		Destroy(windowprogfestival);
	end fermerFenetre;
----------------------------------------------------------------------
	procedure initregion1 is
		festivals : Festival_List.Vector;

		procedure alimente( pos : Festival_List.Cursor ) is
                        festival : Basec201_Data.tFestival;
                        begin
                          festival := Festival_List.element( pos );
                          append (modele_festival, rang_festival, Null_Iter);
                          Set (modele_festival, rang_festival, 0, p_conversion.to_string(festival.Ville_Festival));
                end alimente;
	begin
		festivals := p_appli_progfestival.GetFestivals;
		creerColonne("nomFestival", treeview_Festival, false);
		creerModele(treeview_Festival,modele_festival);
		Festival_List.iterate(festivals,alimente'Access);
	end initregion1;
---------------------------------------------------------------------

        procedure initregion2 is
        begin

		creerColonne("Ordre",treeview_jour1, false);
                creerColonne("nomGroupe", treeview_jour1, false);
		creerColonne("genre",treeview_jour1,false);
                creerModele(treeview_jour1,modele_jour1);


                creerColonne("Ordre",treeview_jour2, false);
                creerColonne("nomGroupe", treeview_jour2, false);
		creerColonne("genre",treeview_jour2,false);
                creerModele(treeview_jour2,modele_jour2);

        end initregion2;
---------------------------------------------------------------------
	procedure fillTreeviewJour1(groupes : in groupe_list.vector) is
		procedure alimente( pos : Groupe_List.Cursor ) is
                       groupe : Basec201_Data.tGroupe;
                       begin
                         groupe := Groupe_List.element( pos );
                         append (modele_jour1, rang_jour1, Null_Iter);
                         Set (modele_jour1, rang_jour1, 1, p_conversion.to_string(groupe.Nom_Groupe));
			 Set (modele_jour1, rang_jour1, 0, p_conversion.to_string(groupe.Ordre_Passage));
			Set (modele_jour1,rang_jour1, 2, tGenre_enum'image(groupe.Genre));
               end alimente;

	begin
		CreerModele(treeview_jour1,modele_jour1);
		Clear(modele_jour1);
		groupe_List.iterate(groupes,alimente'Access);
	end fillTreeviewJour1;
---------------------------------------------------------------------
        procedure fillTreeviewJour2(groupes : in groupe_list.vector) is
                procedure alimente( pos : Groupe_List.Cursor ) is
                       groupe : Basec201_Data.tGroupe;
                       begin
                         groupe := Groupe_List.element( pos );
                         append (modele_jour2, rang_jour2, Null_Iter);
                         Set (modele_jour2, rang_jour2, 1, p_conversion.to_string(groupe.Nom_Groupe));
                         Set (modele_jour2, rang_jour2, 0, p_conversion.to_string(groupe.Ordre_Passage));
			Set (modele_jour2,rang_jour2, 2, tGenre_enum'image(groupe.Genre));
               end alimente;

        begin
		creerModele(treeview_jour2,modele_jour2);
                Clear(modele_jour2);
                groupe_List.iterate(groupes,alimente'Access);
        end fillTreeviewJour2;
---------------------------------------------------------------------


	procedure selectionregion1 is
	begin
		--Desactivations
		Set_Sensitive(Gtk_button(Get_Widget(XML,"buttonAnnuler2")),false);
		Set_Sensitive(Gtk_button(Get_Widget(XML,"buttonTerminer")),false);
		Set_Sensitive(Gtk_button(Get_Widget(XML,"buttonBot")),false);
		Set_Sensitive(Gtk_button(Get_Widget(XML,"buttonDown")),false);
		Set_Sensitive(Gtk_button(Get_Widget(XML,"buttonUp")),false);
		Set_Sensitive(Gtk_button(Get_Widget(XML,"buttonTop")),false);
		Set_Sensitive(Gtk_button(Get_Widget(XML,"buttonright")),false);
		Set_Sensitive(Gtk_button(Get_Widget(XML,"buttonleft")),false);
		Set_Text(Gtk_Entry(Get_Widget(XML,"entryNbGroupes1")),"");
		Set_Text(Gtk_Entry(Get_Widget(XML,"entryMax1")),"");
		Set_Text(Gtk_Entry(Get_Widget(XML,"entryNbGroupes2")),"");
		Set_Text(Gtk_Entry(Get_Widget(XML,"entryMax2")),"");
		--activations
		Set_Sensitive(Gtk_button(Get_Widget(XML,"buttonAnnuler1")),true);
		Set_Sensitive(Gtk_button(Get_Widget(XML,"buttonValider")),true);
		fillTreeviewJour1(Groupe_List.Empty_Vector);
		fillTreeviewJour2(Groupe_List.Empty_Vector);--pour vider les treeviews
	end selectionregion1;
----------------------------------------------------------------------
	procedure selectionregion2 is
		festival : Unbounded_String;
	begin
		--Desactivations
		Set_Sensitive(Gtk_button(Get_Widget(XML,"buttonAnnuler1")),false);
		Set_Sensitive(Gtk_button(Get_Widget(XML,"buttonValider")),false);
		--activations
		Set_Sensitive(Gtk_button(Get_Widget(XML,"buttonAnnuler2")),true);
		Set_Sensitive(Gtk_button(Get_Widget(XML,"buttonTerminer")),true);
		Set_Sensitive(Gtk_button(Get_Widget(XML,"buttonBot")),true);
		Set_Sensitive(Gtk_button(Get_Widget(XML,"buttonDown")),true);
		Set_Sensitive(Gtk_button(Get_Widget(XML,"buttonUp")),true);
		Set_Sensitive(Gtk_button(Get_Widget(XML,"buttonTop")),true);

		Get_Selected(Get_Selection(treeview_festival),Gtk_Tree_Model(modele_festival),rang_festival);
		p_conversion.to_ada_type(Get_String(modele_festival,rang_festival,0),festival);	

		Set_Text(Gtk_Entry(Get_Widget(XML,"entryNbGroupes1")),p_conversion.to_string(integer(jour1.length)));
		Set_Text(Gtk_Entry(Get_Widget(XML,"entryMax1")),p_conversion.to_string(p_appli_progfestival.MaxGroupes(festival,1)));

		--S'il y a un jour 2, on active les boutons droite/gauche et on remplit la seconde treeview.
		if p_appli_progfestival.isJour2(festival) then
			Set_Sensitive(Gtk_button(Get_Widget(XML,"buttonright")),true);
			Set_Sensitive(Gtk_button(Get_Widget(XML,"buttonleft")),true);		
			Set_Text(Gtk_Entry(Get_Widget(XML,"entryNbGroupes2")),p_conversion.to_string(integer(jour2.length)));
			Set_Text(Gtk_Entry(Get_Widget(XML,"entryMax2")),p_conversion.to_string(p_appli_progfestival.MaxGroupes(festival,2)));
		end if;
		fillTreeviewJour1(jour1);
		fillTreeviewJour2(jour2);
	end selectionregion2;
---------------------------------------------------------------------------
	procedure rechercherprog is
		festival : Unbounded_String;
		b_box : message_dialog_buttons;
		EX_AUCUN_FESTIVAL_SELECTIONNE : exception;
	begin
		Get_Selected(Get_Selection(treeview_festival),Gtk_Tree_Model(modele_festival),rang_festival);
		if rang_festival = Null_Iter then
			raise EX_AUCUN_FESTIVAL_SELECTIONNE;
		end if;
		p_conversion.to_ada_type(Get_String(modele_festival,rang_festival,0),festival);
		
		p_appli_progfestival.GetGroupes(festival,jour1,jour2);


		selectionregion2;
		exception
			when EX_AUCUN_FESTIVAL_SELECTIONNE => b_box := message_dialog("Vous n'avez pas sélectionné de festival !",Error,Button_ok,Button_ok);
	end rechercherprog;
---------------------------------------------------------------------
	procedure finprogrammation is
	b_box:message_dialog_buttons;
	begin
		p_appli_progfestival.save(jour1,jour2);
		b_box:=message_dialog("Festival programmé",Information,Button_Ok,Button_Ok);
		fermerfenetre;
		
		exception
                         when p_appli_progfestival.EX_TROP_DE_GROUPES =>
                                 b_box := message_dialog("Il y a trop de groupes dans l'une des journées",Error,Button_Ok,Button_Ok);

	end finprogrammation;
-------------------------------------------------------------------------
	procedure switchJour1 is
		groupe : Unbounded_String;
		b_box:message_dialog_buttons;
	begin
		Get_Selected(Get_Selection(treeview_jour2),Gtk_Tree_Model(modele_jour2),rang_jour2);
		if rang_jour2 = Null_Iter then
			b_box := message_dialog("Aucun groupe sélectionné",Error,Button_Ok,Button_Ok);
		else
			p_conversion.to_ada_type(Get_String(modele_jour2,rang_jour2,1), groupe);
			p_appli_progfestival.switchJour(groupe,jour2,jour1);
			SelectionRegion2;
		end if;
	end switchJour1;
--------------------------------------------------------------------
	procedure switchJour2 is
		groupe : Unbounded_String;
		b_box:message_dialog_buttons;
        begin
                Get_Selected(Get_Selection(treeview_jour1),Gtk_Tree_Model(modele_jour1),rang_jour1);
                if rang_jour1 = Null_Iter then
                        b_box := message_dialog("Aucun groupe sélectionné",Error,Button_Ok,Button_Ok);
                else
                        p_conversion.to_ada_type(Get_String(modele_jour1,rang_jour1,1), groupe);
                        p_appli_progfestival.switchJour(groupe,jour1,jour2);
			SelectionRegion2;
                end if;


	end switchJour2;
--------------------------------------------------------------------
procedure upGroupe is
	b_box:message_dialog_buttons;
	nomgroupe : Unbounded_String;
begin

	Get_Selected(Get_Selection(treeview_jour1),Gtk_Tree_Model(modele_jour1),rang_jour1);
	if rang_jour1 = Null_Iter then
		Get_Selected(Get_Selection(treeview_jour2),Gtk_Tree_Model(modele_jour2),rang_jour2);
		if rang_jour2 = Null_Iter then
			b_box := Message_Dialog("Aucun groupe sélectionné",Error,Button_Ok,Button_Ok);
		else
			p_conversion.to_ada_type(Get_String(modele_jour2,rang_jour2,1),nomgroupe);
                	creerModele(treeview_jour1,modele_jour1);
			p_appli_progfestival.up(nomgroupe,jour2);
			SelectionRegion2;
		end if;
	else
		p_conversion.to_ada_type(Get_String(modele_jour1,rang_jour1,1),nomgroupe);
		p_appli_progfestival.up(nomgroupe,jour1);
		SelectionRegion2;
	end if;
	exception
		when p_appli_progfestival.EX_DEJA_EN_HAUT =>
			b_box := message_dialog("Ce groupe est déjà en première position",Error,Button_Ok,Button_Ok);
end upGroupe;
--------------------------------------------------------------------
procedure top is
	b_box:message_dialog_buttons;
	nomgroupe : Unbounded_String;
begin

	Get_Selected(Get_Selection(treeview_jour1),Gtk_Tree_Model(modele_jour1),rang_jour1);
	if rang_jour1 = Null_Iter then
		Get_Selected(Get_Selection(treeview_jour2),Gtk_Tree_Model(modele_jour2),rang_jour2);
		if rang_jour2 = Null_Iter then
			b_box := Message_Dialog("Aucun groupe sélectionné",Error,Button_Ok,Button_Ok);
		else
			p_conversion.to_ada_type(Get_String(modele_jour2,rang_jour2,1),nomgroupe);
                	creerModele(treeview_jour1,modele_jour1);
			p_appli_progfestival.top(nomgroupe,jour2);
			SelectionRegion2;
		end if;
	else
		p_conversion.to_ada_type(Get_String(modele_jour1,rang_jour1,1),nomgroupe);
		p_appli_progfestival.top(nomgroupe,jour1);
		SelectionRegion2;
	end if;
	exception
		when p_appli_progfestival.EX_DEJA_EN_HAUT =>
			b_box := message_dialog("Ce groupe est déjà en première position",Error,Button_Ok,Button_Ok);
end top;
--------------------------------------------------------------------
procedure downGroupe is
	b_box:message_dialog_buttons;
	nomgroupe : Unbounded_String;
begin

	Get_Selected(Get_Selection(treeview_jour1),Gtk_Tree_Model(modele_jour1),rang_jour1);
	if rang_jour1 = Null_Iter then
		Get_Selected(Get_Selection(treeview_jour2),Gtk_Tree_Model(modele_jour2),rang_jour2);
		if rang_jour2 = Null_Iter then
			b_box := Message_Dialog("Aucun groupe sélectionné",Error,Button_Ok,Button_Ok);
		else
			p_conversion.to_ada_type(Get_String(modele_jour2,rang_jour2,1),nomgroupe);
			p_appli_progfestival.down(nomgroupe,jour2);
                	creerModele(treeview_jour1,modele_jour1);
			SelectionRegion2;
		end if;
	else
		p_conversion.to_ada_type(Get_String(modele_jour1,rang_jour1,1),nomgroupe);
		p_appli_progfestival.down(nomgroupe,jour1);
		SelectionRegion2;
	end if;
	exception
		when p_appli_progfestival.EX_DEJA_EN_BAS =>
			b_box := message_dialog("Ce groupe est déjà en dernière position",Error,Button_Ok,Button_Ok);
end downGroupe;
--------------------------------------------------------------------
procedure bot is
	b_box:message_dialog_buttons;
	nomgroupe : Unbounded_String;
begin

	Get_Selected(Get_Selection(treeview_jour1),Gtk_Tree_Model(modele_jour1),rang_jour1);
	if rang_jour1 = Null_Iter then
		Get_Selected(Get_Selection(treeview_jour2),Gtk_Tree_Model(modele_jour2),rang_jour2);
		if rang_jour2 = Null_Iter then
			b_box := Message_Dialog("Aucun groupe sélectionné",Error,Button_Ok,Button_Ok);
		else
			p_conversion.to_ada_type(Get_String(modele_jour2,rang_jour2,1),nomgroupe);
			p_appli_progfestival.bot(nomgroupe,jour2);
                	creerModele(treeview_jour1,modele_jour1);
			SelectionRegion2;
		end if;
	else
		p_conversion.to_ada_type(Get_String(modele_jour1,rang_jour1,1),nomgroupe);
		p_appli_progfestival.bot(nomgroupe,jour1);
		SelectionRegion2;
	end if;
	exception
		when p_appli_progfestival.EX_DEJA_EN_BAS =>
			b_box := message_dialog("Ce groupe est déjà en dernière position",Error,Button_Ok,Button_Ok);
end bot;
--------------------------------------------------------------------
procedure deleteGroupe is
	b_box:message_dialog_buttons;
        nomgroupe : Unbounded_String;
begin
	Get_Selected(Get_Selection(treeview_jour1),Gtk_Tree_Model(modele_jour1),rang_jour1);
        if rang_jour1 = Null_Iter then
                Get_Selected(Get_Selection(treeview_jour2),Gtk_Tree_Model(modele_jour2),rang_jour2);
                if rang_jour2 = Null_Iter then
                        b_box := Message_Dialog("Aucun groupe sélectionné",Error,Button_Ok,Button_Ok);
                else
                        p_conversion.to_ada_type(Get_String(modele_jour2,rang_jour2,1),nomgroupe);
			b_box := message_dialog("Êtes-vous sûr de vouloir supprimer le groupe " & to_string(nomgroupe),Confirmation, Button_Yes or Button_No, Button_No);
			case b_box is
				when 1=>
		                        p_appli_progfestival.delete(nomgroupe,jour2);
	        	                creerModele(treeview_jour1,modele_jour1);
                	        	SelectionRegion2;
				when others=>
					null;
			end case;
                end if;
        else
                p_conversion.to_ada_type(Get_String(modele_jour1,rang_jour1,1),nomgroupe);
		b_box := message_dialog("Êtes-vous sûr de vouloir supprimer le groupe " & to_string(nomgroupe) & "?",Confirmation, Button_Yes or Button_No, Button_No);
		case b_box is
			when 1=>
		                p_appli_progfestival.delete(nomgroupe,jour1);
                		SelectionRegion2;
			when others =>
				null;
		end case;
        end if;

end deleteGroupe;

--------------------------------------------------------------------
procedure clearleft is
begin
	 Unselect_All(Get_Selection(treeview_jour1));
end clearleft;
--------------------------------------------------------------------
procedure clearright is
begin
	Unselect_All(Get_Selection(treeview_jour2));	
end clearright;
--------------------------------------------------------------------
end P_window_progfestival;
