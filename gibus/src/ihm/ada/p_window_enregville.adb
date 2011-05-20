--with tp_Intl; use tp_Intl;
with Glade.XML;use Glade.XML;
with ada.text_io;

package body p_window_enregville is

XML : Glade_XML;
windowenregville:gtk_window;
-- déclaration des variables utiles pour la suite 1. 2. 3.
treeview_ville: Gtk_Tree_View;
modele_ville: Gtk_Tree_Store; -- le modèle associé à la vue
rang_ville: Gtk_Tree_Iter := Null_Iter; -- ligne dans le modèle


-----------------------------------------------------------------------------------
	procedure init is

	begin
		Glade.XML.Gtk_New(XML, "./src/ihm/glade/EnregistrerVilles.glade", "windowenregville");
		treeview_ville:=Gtk_Tree_View(Get_Widget(XML,"treeview1"));
		windowenregville:=Gtk_Window(Get_Widget(XML,"windowenregville"));
		Glade.XML.signal_connect (XML,"on_buttonAnnuler_clicked",fermerFenetre'address,Null_Address);
		Glade.XML.signal_connect (XML,"on_buttonSuivant_clicked",villesuivante'address,Null_Address);
		Glade.XML.signal_connect (XML,"on_buttonTerminer_clicked",finenregistrementville'address,Null_Address);
		
		inittreeview;
		
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
	resultEntryNomVille:Unbounded_String;
	resultEntryMail:Unbounded_String;
	ville : Basec201_Data.tVille;
	i : integer;
	
	begin
		
		to_ada_type(Get_Text(Gtk_Entry(Get_Widget(XML,"entryNomVille"))),resultEntryNomVille);
	
		to_ada_type(Get_Text(Gtk_Entry(Get_Widget(XML,"entryMail"))),resultEntryMail);
		
		--Test de l'email
			i := 1;
			while i < length(resultEntryMail) and then element(resultEntryMail,i) /= '@' loop
				i := i+1;			
			end loop;
			while i < length(resultEntryMail) and then element(resultEntryMail,i) /= '.' loop
				i:= i+1;
			end loop;
			
			if i = length(resultEntryMail) then
				raise EX_MAIL_INCORRECT;
			end if;
		
		--
		
		CreateVille(resultEntryNomVille,resultEntryMail);
		
				
		
		Set_Text(Gtk_Entry(Get_Widget(XML,"entryMail")),"");
		Set_Text(Gtk_Entry(Get_Widget(XML,"entryNomVille")),"");
		
		b_box:=message_dialog("Ville enregistrée !",Information,Button_Ok,Button_Ok);
		inittreeview;

	exception
		when  EXVilleExistante => b_box:=message_dialog("Ville déjà existante !",Error,Button_Ok,Button_Ok); 
		Set_Text(Gtk_Entry(Get_Widget(XML,"entryMail")),"");
		Set_Text(Gtk_Entry(Get_Widget(XML,"entryNomVille")),"");
		when EX_MAIL_INCORRECT => b_box:=message_dialog("Mail de format incorrect !",Error,Button_Ok,Button_Ok); 


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
		ada.text_io.put_line("Début");
		creerColonne("nomVille", treeView_ville, false);
		ada.text_io.put_line("Colonne créée");
		creerModele(treeView_ville,modele_ville);
		ada.text_io.put_line("Modele Créé");
		liste_ville := p_appli_enregville.GetVillesExistantes;
		ada.text_io.put_line("Init liste ville");
		Ville_List.iterate(liste_ville, alimente'Access);
		ada.text_io.put_line("Appel de alimente");
		
	
	end inittreeview;
--------------------------------------------------------------------------------
end P_window_enregville;
