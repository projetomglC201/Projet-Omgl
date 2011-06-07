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


Festival:festival_list.vector;
jour1:tjour_festival;
jour2:tjour_festival;
radiobuttonJour1:Gtk_radio_Button;
radiobuttonJour2:Gtk_radio_Button;
----------------------------------------------------------------------------
procedure init is

begin
	Glade.XML.Gtk_New(XML, "./src/ihm/glade/enregGroupe.glade", "windowenreggroupe");
	window := Gtk_Window(Get_Widget(XML,"windowenreggroupe"));
	treeview_ville:=Gtk_Tree_View(Get_Widget(XML,"treeviewville"));
	treeview_jour1:=Gtk_Tree_View(Get_Widget(XML,"treeviewjour1"));
	treeview_jour2:=Gtk_Tree_View(Get_Widget(XML,"treeviewjour2"));
	radiobuttonJour1:=Gtk_radio_Button(Get_Widget(XML,"radiobuttonJour1"));
	radiobuttonJour2:=Gtk_radio_Button(Get_Widget(XML,"radiobuttonJour2"));	
	
	Glade.XML.signal_connect (XML,"on_buttonAnnuler_clicked",fermerFenetre'address,Null_Address);
	Glade.XML.signal_connect (XML,"on_buttonEnregistrer_clicked",enregistrergroupe'address,Null_Address);
	Glade.XML.signal_connect (XML,"on_treeviewville_cursor_changed",initselect'address,Null_Address);
	Glade.XML.signal_connect (XML,"on_radiobuttonJour1_toggled",SetSensitiveJourSelect'address,Null_Address);

	
	inittreeviewville;
	inittreeviewgroupejour1;
	inittreeviewgroupejour2;
	SetSensitiveJourSelect;

end init;
------------------------------------------------------------------------------
	procedure fermerFenetre is
	begin
		Destroy(window);
	end fermerFenetre;
---------------------------------------------------------------------------
	procedure enregistrergroupe is
		
	resultEntryGroupe:Unbounded_String;
	resultGenre:string(1..10);
	resultjour:integer;
	resultOrdre:integer;
	resultentryContact:Unbounded_String;
	resultentryCoord:Unbounded_String;
	resultentrySite:Unbounded_String;
	begin
		if not (Get_Text(Gtk_Entry(Get_Widget(XML,"entryGroupe")))'length=0) then
		
			to_ada_type(Get_Text(Gtk_Entry(Get_Widget(XML,"entryGroupe"))),resultEntryGroupe);
			convertirnom(resultEntryGroupe);
		else
			raise EXEntryGroupeEmpty;
		end if;
		
		
		to_ada_type(Get_Label(Gtk_Button(GetActiveButtonGenre)),resultGenre);
		
		if GetActiveButtonJour=radiobuttonJour1 then
		resultjour:=jour1.Id_Jour_Festival;
		resultOrdre:=1+Nbgroupeinscrit(festival.first_element,1);
		else
		resultjour:=jour2.Id_Jour_Festival;
		resultOrdre:=1+Nbgroupeinscrit(festival.first_element,2);
		end if;
		
		if not (Get_Text(Gtk_Entry(Get_Widget(XML,"entryContact")))'length=0) then	
			to_ada_type(Get_Text(Gtk_Entry(Get_Widget(XML,"entryContact"))),resultentryContact);
		else
			raise EXEntryContactEmpty;
		end if;
		if not (Get_Text(Gtk_Entry(Get_Widget(XML,"entryCoord")))'length=0) then	
			to_ada_type(Get_Text(Gtk_Entry(Get_Widget(XML,"entryCoord"))),resultentryCoord);
		else
			raise EXEntryCoordEmpty;
		end if;	
		if not (Get_Text(Gtk_Entry(Get_Widget(XML,"entrySite")))'length=0) then	
			to_ada_type(Get_Text(Gtk_Entry(Get_Widget(XML,"entrySite"))),resultentrySite);
		end if;		
	
		SaveGroupe(resultEntryGroupe,resultentryContact,resultEntryCoord,ResultentrySite,resultGenre,resultOrdre,resultjour);
	
		b_box:=message_dialog("Groupe enregistré !",Information,Button_Ok,Button_Ok);
		remplirtreeviewgroupejour1(festival.first_element);
		remplirtreeviewgroupejour2(festival.first_element);
		
		Set_Text(Gtk_Entry(Get_Widget(XML,"entryDateJour1")),"");
		Set_Text(Gtk_Entry(Get_Widget(XML,"entryPrevuJour1")),"");
		Set_Text(Gtk_Entry(Get_Widget(XML,"entryPlaceJour1")),"");
		Set_Text(Gtk_Entry(Get_Widget(XML,"entryDateJour2")),"");
		Set_Text(Gtk_Entry(Get_Widget(XML,"entryPrevuJour2")),"");
		Set_Text(Gtk_Entry(Get_Widget(XML,"entryPlaceJour2")),"");
		Set_Text(Gtk_Entry(Get_Widget(XML,"entryGroupe")),"");
		Set_Text(Gtk_Entry(Get_Widget(XML,"entryContact")),"");
		Set_Text(Gtk_Entry(Get_Widget(XML,"entryCoord")),"");
		Set_Text(Gtk_Entry(Get_Widget(XML,"entrySite")),"");
		
		
	exception
		when EXGroupeExistant
			=> b_box:=message_dialog("Groupe déjà existant",Error,Button_Ok,Button_Ok);
		when EXEntryGroupeEmpty
			=> b_box:=message_dialog("Entrez un nom de groupe",Error,Button_Ok,Button_Ok);
		when EXEntryContactEmpty
			=> b_box:=message_dialog("Entrez le nom du contact",Error,Button_Ok,Button_Ok);
		when EXEntryCoordEmpty
			=> b_box:=message_dialog("Entrez les coordonnées du contact",Error,Button_Ok,Button_Ok);
		
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
	procedure inittreeviewgroupejour1 is	

	begin
	
		creerColonne("NomVille", treeView_jour1, false);
		creerColonne("Genre", treeView_jour1, false);
		
		creerModele(treeView_jour1,modele_jour1);


	
	end inittreeviewgroupejour1;
-----------------------------------------------------------------------------
	procedure inittreeviewgroupejour2  is

	begin

		creerColonne("NomVille", treeView_jour2, false);
		creerColonne("Genre", treeView_jour2, false);
		
		creerModele(treeView_jour2,modele_jour2);

	
	end inittreeviewgroupejour2;
---------------------------------------------------------------------------
	procedure initselect is

	resulttreeviewville:Unbounded_String;
	groupesjour1:groupe_list.vector;
	groupesjour2:groupe_list.vector;

	
	begin

		--Recuperation de la selection dans la treeview
		Get_Selected(Get_Selection(treeview_ville),Gtk_Tree_model(modele_ville), 
		rang_ville);
		if rang_ville = Null_Iter then
		
			raise EX_AUCUNE_VILLE_SELECTIONNEE;
		else
			to_ada_type(Get_String (modele_ville, rang_ville, 0), resulttreeviewville);
		end if;
		Festival:=GetFestivalAssocie(resulttreeviewville);
		
		Clear(modele_jour2);
		Set_Text(Gtk_Entry(Get_Widget(XML,"entryDateJour2")),"");
		Set_Text(Gtk_Entry(Get_Widget(XML,"entryPrevuJour2")),"");
		Set_Text(Gtk_Entry(Get_Widget(XML,"entryPlaceJour2")),"");
		
		
		remplirtreeviewgroupejour1(festival.first_element);
		jour1:=GetJourFestivalAssocie(festival.first_element).element(1);
		If  integer(Jour_Festival_List.Length(GetJourFestivalAssocie(festival.first_element)))=1 then
			jour2:=Null_Jour_Festival;
		else
		jour2:=GetJourFestivalAssocie(festival.first_element).element(2);
		end if;
		
		Set_Text(Gtk_Entry(Get_Widget(XML,"entryDateJour1")),(integer'image(Day(Festival_list.First_Element(Festival).Date))&"/"&integer'image(Month(Festival_list.First_Element(festival).Date))&"/"&integer'image(Year(Festival_list.First_Element(festival).Date))));
		Set_Text(Gtk_Entry(Get_Widget(XML,"entryPrevuJour1")),integer'image(jour1.Nbre_Concert_Max));
		Set_Text(Gtk_Entry(Get_Widget(XML,"entryPlaceJour1")),integer'image(jour1.Nbre_Concert_Max-Nbgroupeinscrit(festival.first_element,1)));


		if jour2/=Null_Jour_Festival then
			Set_Sensitive(radiobuttonJour2,true);
			remplirtreeviewgroupejour2(festival.first_element);
			Set_Text(Gtk_Entry(Get_Widget(XML,"entryDateJour2")),(integer'image(Day(Festival_list.First_Element(Festival).Date+86400.0))&"/"&integer'image(Month(Festival_list.First_Element(festival).Date+86400.0))&"/"&integer'image(Year(Festival_list.First_Element(festival).Date+86400.0))));
			Set_Text(Gtk_Entry(Get_Widget(XML,"entryPrevuJour2")),integer'image(jour2.Nbre_Concert_Max));
		Set_Text(Gtk_Entry(Get_Widget(XML,"entryPlaceJour2")),integer'image(jour2.Nbre_Concert_Max-Nbgroupeinscrit(festival.first_element,2)));
			else
			Set_Sensitive(radiobuttonJour2,false);
		end if;
		
	exception
		when EX_AUCUNE_VILLE_SELECTIONNEE
			=> b_box:=Message_Dialog ("Aucune ville selectionnée",Error,Button_Ok,Button_Ok);
		
		
	end initselect;
------------------------------------------------------------------------
	procedure remplirtreeviewgroupejour1  (festival : in tfestival) is
	
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
		Clear(modele_jour1);

		liste_groupe :=p_appli_enreggroupe.GetGroupesJour(festival,1);
		
		groupe_list.iterate(liste_groupe, alimente'Access);
		
	end remplirtreeviewgroupejour1;
-------------------------------------------------------------------------
	procedure remplirtreeviewgroupejour2 (festival : in tfestival) is
	
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
		Clear(modele_jour2);
		
		liste_groupe :=p_appli_enreggroupe.GetGroupesJour(festival,2);
		
		groupe_list.iterate(liste_groupe, alimente'Access);
	
	end remplirtreeviewgroupejour2;

------------------------------------------------------------------------
	function GetActiveButtonGenre return Gtk_radio_Button is
		radioButtonHard:Gtk_radio_Button:=Gtk_radio_Button(Get_Widget(XML,"radiobuttonHard"));
		radioButtonPunk:Gtk_radio_Button:=Gtk_radio_Button(Get_Widget(XML,"radiobuttonPunk"));
		radioButtonPop:Gtk_radio_Button:=Gtk_radio_Button(Get_Widget(XML,"radiobuttonPop"));
		radioButtonAlternatif:Gtk_radio_Button:=Gtk_radio_Button(Get_Widget(XML,"radiobuttonAlternatif"));
		radioButtonFusion:Gtk_radio_Button:=Gtk_radio_Button(Get_Widget(XML,"radiobuttonFusion"));
		radioButtonRockabilly:Gtk_radio_Button:=Gtk_radio_Button(Get_Widget(XML,"radiobuttonRockabilly"));
	begin
		
		if Get_active(Gtk_Toggle_Button(radioButtonHard)) then
			return radioButtonHard;
		
		elsif Get_active(Gtk_Toggle_Button(radiobuttonPunk)) then
			return radiobuttonPunk;
		
		elsif Get_active(Gtk_Toggle_Button(radiobuttonPop)) then
			return radiobuttonPop;
		
		elsif Get_active(Gtk_Toggle_Button(radiobuttonAlternatif)) then
			return radiobuttonAlternatif;
		
		elsif Get_active(Gtk_Toggle_Button(radiobuttonFusion)) then
			return radiobuttonFusion;
		
		else 
			return radiobuttonRockabilly;

		end if;
		
	
	end GetActiveButtonGenre;
---------------------------------------------------------------------------
	function GetActiveButtonJour return Gtk_radio_Button is


	begin
		
		
		if Get_active(Gtk_Toggle_Button(radiobuttonJour1)) then
			return radiobuttonJour1;
		else
			return radiobuttonJour2;

		end if;

	
	end GetActiveButtonJour;
--------------------------------------------------------------------------------
	procedure convertirnom (nom :in out Unbounded_String) is
		c:character;
	begin
		if element(nom,1) >= 'a' and element(nom,1) <= 'z' then
			replace_element(nom,1,(character'val(character'pos(element(nom,1)) -16#20#)));
		end if;
		for i in 2..length(nom) loop
			c:= element(nom,i);
			if c < 'a' and c >= 'A' then
				c := character'val(character'pos(c)+16#20#);
			end if;
			replace_element(nom,i,c);
		end loop;
	
	end convertirnom;
------------------------------------------------------------------------------------
	procedure SetSensitiveJourSelect is
		
	begin
		if GetActiveButtonJour=radiobuttonJour1 then	
			Set_Sensitive(Gtk_entry(Get_Widget(XML,"entryDateJour2")),false);
			Set_Sensitive(Gtk_entry(Get_Widget(XML,"entryPrevuJour2")),false);
			Set_Sensitive(Gtk_entry(Get_Widget(XML,"entryPlaceJour2")),false);

			Set_Sensitive(Gtk_entry(Get_Widget(XML,"entryDateJour1")),true);
			Set_Sensitive(Gtk_entry(Get_Widget(XML,"entryPrevuJour1")),true);
			Set_Sensitive(Gtk_entry(Get_Widget(XML,"entryPlaceJour1")),true);
	
		else
			Set_Sensitive(Gtk_entry(Get_Widget(XML,"entryDateJour1")),false);
			Set_Sensitive(Gtk_entry(Get_Widget(XML,"entryPrevuJour1")),false);
			Set_Sensitive(Gtk_entry(Get_Widget(XML,"entryPlaceJour1")),false);

			Set_Sensitive(Gtk_entry(Get_Widget(XML,"entryDateJour2")),true);
			Set_Sensitive(Gtk_entry(Get_Widget(XML,"entryPrevuJour2")),true);
			Set_Sensitive(Gtk_entry(Get_Widget(XML,"entryPlaceJour2")),true);

		end if;
	
	end SetSensitiveJourSelect;
-----------------------------------------------------------------------------------

end P_window_enreggroupe;

