package body p_window_enreggagnantfinale is

XML : Glade_XML;
window: Gtk_window;

treeview_groupe : Gtk_Tree_View;
modele_groupe : Gtk_Tree_Store;
rang_groupe : Gtk_Tree_Iter := Null_Iter;

------------------------------------------------------
procedure init is
	b_box : message_dialog_buttons;
begin
	Glade.XML.Gtk_New(XML, "./src/ihm/glade/enregGagnantFinale.glade", "windowGagnantFinale");
        window := Gtk_Window(Get_Widget(XML,"windowGagnantFinale"));
        Glade.XML.signal_connect (XML,"on_buttonFermer_clicked",fermerFenetre'address,Null_Address);
	treeview_groupe:=Gtk_Tree_View(Get_Widget(XML,"treeview1"));
	

        Glade.XML.signal_connect (XML,"on_buttonEnregistrer_clicked",enregistrer'address,Null_Address);
       	inittreeview;
end init;


procedure inittreeview is
	groupes : Basec201_data.Gagnant_Festival_List.vector;

	procedure alimente (pos : Basec201_data.Gagnant_festival_List.Cursor) is
		groupe : Basec201_data.tGagnant_Festival;
	begin
		Groupe := Basec201_data.Gagnant_festival_List.element(pos);
		append(modele_groupe, rang_groupe, Null_Iter);
                Set (modele_groupe, rang_groupe, 0, p_conversion.to_string(groupe.Groupe));
        end alimente;

begin
	groupes := p_appli_enregGagnantFinale.GetInscritsFinale;
	creerColonne("nomGroupe", treeView_groupe, false);
	creerModele(treeView_groupe,modele_groupe);
	groupes.iterate(alimente'Access);
end inittreeview;

procedure fermerFenetre is
begin
	Destroy(window);
end fermerFenetre;

procedure enregistrer is
	resulttreeviewgroupe : Unbounded_String;
	b_box : message_dialog_buttons;
	EX_AUCUN_GROUPE_SELECTIONNE : exception;
begin

	Get_Selected(Get_Selection(treeview_groupe),Gtk_Tree_Model(modele_groupe),rang_groupe);
	if rang_groupe = Null_Iter then
		raise EX_AUCUN_GROUPE_SELECTIONNE;
	else
		p_conversion.to_ada_type(Get_String(modele_groupe,rang_groupe,0),resulttreeviewgroupe);
	end if;
	
	b_box := message_dialog("Êtes vous sûr de vouloir enregistrer " & p_conversion.to_string(resulttreeviewgroupe)& " comme gagnant de la finale ?",Confirmation,Button_Yes or Button_No,Button_No);
	case b_box is
		when 1 =>
			p_appli_enregGagnantFinale.save(resulttreeviewgroupe);
			fermerFenetre;
		when others =>
			null;
	end case;
end enregistrer;


end p_window_enreggagnantfinale;
