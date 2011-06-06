--with tp_Intl; use tp_Intl;
with Glade.XML;use Glade.XML;
with ada.text_io; use ada.text_io;
package body P_window_creerfestival is


windowcreerfestival:gtk_window;
XML : Glade_XML;
-- déclaration des variables utiles pour la suite 1. 2. 3.
treeview_ville: Gtk_Tree_View;
modele_ville: Gtk_Tree_Store; -- le modèle associé à la vue
rang_ville: Gtk_Tree_Iter := Null_Iter; -- ligne dans le modèle

----------------------------------------------------------------------
procedure init is

begin
	Glade.XML.Gtk_New(XML, "./src/ihm/glade/CreerFestival.glade", "windowcreerfestival");
	windowcreerfestival:=Gtk_Window(Get_Widget(XML,"windowcreerfestival"));
	treeview_ville:=Gtk_Tree_View(Get_Widget(XML,"treeview1"));
	
	
	
	Glade.XML.signal_connect (XML,"on_buttonAnnuler_clicked",fermerFenetre'address,Null_Address);
	Glade.XML.signal_connect (XML,"on_buttonValider_clicked",validerfestival'address,Null_Address);
	Glade.XML.signal_connect (XML,"on_entryNbgroupes2_changed",activerjour2'address,Null_Address);
	inittreeview;
end init;
---------------------------------------------------------------------
	procedure fermerFenetre is
	begin
		Destroy(windowcreerfestival);
	end fermerFenetre;
--------------------------------------------------------------------------
	procedure validerfestival is
	b_box:message_dialog_buttons;
	-----
	resulttreeviewville:Unbounded_String;
	resultcalendardatedebut:time;
	resultEntryLieu:Unbounded_String;
	resultentryPrixEntree:integer;
	resultentryNbgroupes1:integer;
	resultentryNbgroupes2:integer;
	festival:tfestival;
	jours : Jour_Festival_List.Vector;
	jour1,jour2 : tJour_Festival;
	an,mois,jour:Guint;
	resultentryHeure1:integer;
	resultentryHeure2:integer;
	IDFESTIVAL:integer:=festival_io.next_free_id_festival;

	begin
		--Recuperation de la selection dans la treeview
		Get_Selected(Get_Selection(treeview_ville),Gtk_Tree_Model(modele_ville), 
		rang_ville);
		if rang_ville = Null_Iter then

			raise EX_AUCUNE_VILLE_SELECTIONNEE;
		else
			to_ada_type(Get_String (modele_ville, rang_ville, 0), resulttreeviewville);
		end if;
		--Recuperation de la date du calendar
		
		Get_Date(Gtk_calendar(Get_Widget(XML,"calendardatedebut")),an,mois,jour);
		
		resultcalendardatedebut:=Time_Of(integer(an),integer(mois),integer(jour));	
		
		--Recuperation des entry
		if not (Get_Text(Gtk_Entry(Get_Widget(XML,"entryLieu")))'length=0) then
			to_ada_type(Get_Text(Gtk_Entry(Get_Widget(XML,"entryLieu"))),resultEntryLieu);
		else
			raise EXEntryLieuEmpty;
		end if;
		if not (Get_Text(Gtk_Entry(Get_Widget(XML,"entryPrixEntree")))'length=0) then
			to_ada_type(Get_Text(Gtk_Entry(Get_Widget(XML,"entryPrixEntree"))),resultentryPrixEntree);
		else
			raise EXEntryPrixEntreeEmpty;
		end if;
		if not (Get_Text(Gtk_Entry(Get_Widget(XML,"entryNbgroupes1")))'length=0) then
			to_ada_type(Get_Text(Gtk_Entry(Get_Widget(XML,"entryNbgroupes1"))),resultentryNbgroupes1);
		else
			raise EXEntryNbgroupes1Empty;
		end if;		
		if not (Get_Text(Gtk_Entry(Get_Widget(XML,"entryHeure1")))'length=0) then
			to_ada_type(Get_Text(Gtk_Entry(Get_Widget(XML,"entryHeure1"))),resultentryHeure1);
		else
			raise EXEntryHeure1Empty;
		end if;				
		
		if not (resultentryHeure1 in 0..23) then
			raise Ex_HeureIncorrecte;
		end if;

		if not (Get_Text(Gtk_Entry(Get_Widget(XML,"entryNbgroupes2")))'length = 0)  then
			to_ada_type(Get_Text(Gtk_Entry(Get_Widget(XML,"entryNbgroupes2"))),resultentryNbgroupes2); 
			to_ada_type(Get_Text(Gtk_Entry(Get_Widget(XML,"entryHeure2"))),resultentryHeure2);
			if not (resultentryHeure2 in 0..23) then
				raise Ex_HeureIncorrecte;
			end if;
		end if;



		--Creation du festival	EXAucuneVilleSelectionnée;
		festival:=(IDFESTIVAL, resulttreeviewville, resultcalendardatedebut, resultEntryLieu, resultEntryPrixEntree, Jour_Festival_List.empty_vector, Gagnant_Festival_List.empty_vector);
		
		CreateFestival(festival);

		--Creation des jourfestival
		jour1 := (jour_festival_io.Next_Free_Id_Jour_Festival,IDFESTIVAL,1,resultEntryNbGroupes1, resultentryHeure1,Groupe_List.Empty_Vector);
		CreateJourFestival(jour1);

		--Creation du jour 2 si le champ n'est pas vide
		 if not (Get_Text(Gtk_Entry(Get_Widget(XML,"entryNbgroupes2")))'length = 0)  then
			jour2 := (jour_festival_io.Next_Free_Id_Jour_Festival,IDFESTIVAL,2,resultEntryNbGroupes2,resultentryHeure2,Groupe_List.Empty_Vector);	
			CreateJourFestival(jour2);
		end if;	

		

	
		b_box:=message_dialog("Festival crée",Confirmation,Button_Ok,Button_Ok);
		fermerfenetre;
	exception
		when EX_AUCUNE_VILLE_SELECTIONNEE => 	
			b_box:=Message_Dialog ("Aucune ville selectionnée.",Error,Button_Ok,Button_Ok);
		when P_CONVERSION.EXCONVERSION => null;
		when Ex_HeureIncorrecte => b_box:= Message_Dialog("L'heure doit être comprise entre 0 et 23.");
		when EXEntryLieuEmpty => b_box:=Message_Dialog ("Entrez un lieu",Error,Button_Ok,Button_Ok);
		when EXEntryPrixEntreeEmpty => b_box:=Message_Dialog ("Entrez un prix d'entrée",Error,Button_Ok,Button_Ok);
		when EXEntryNbgroupes1Empty => b_box:=Message_Dialog ("Entrez un nombre de concert limite pour le jour 1",Error,Button_Ok,Button_Ok);
		when EXEntryHeure1Empty => b_box:=Message_Dialog ("Entrez une heure de debut pour le jour 1",Error,Button_Ok,Button_Ok);
		
		
	end validerfestival;
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
		
		liste_ville := p_appli_creerfestival.GetVillesSansFestival;
		
		Ville_List.iterate(liste_ville, alimente'Access);
	
	end inittreeview;
----------------------------------------------------------------------
	procedure activerJour2 is
		resultNbJour2 : unbounded_string;
		b_box : message_dialog_buttons;
		intNbJour2 : integer;
	begin
		to_ada_type(Get_Text(Gtk_Entry(Get_Widget(XML,"entryNbgroupes2"))),resultNbJour2);
		if length(resultNbJour2) = 0  then
			Set_Sensitive(Get_Widget(XML,"entryHeure2"), false);
			Set_Text(Gtk_Entry(Get_Widget(XML,"entryHeure2")),""); --On vide le champ heure si on le désactive.
		else
			intNbJour2 := integer'value(p_conversion.to_string(resultNbJour2));
			if intNbJour2 = 0 then
				Set_Sensitive(Get_Widget(XML,"entryHeure2"), false);
				Set_Text(Gtk_Entry(Get_Widget(XML,"entryHeure2")),"");
			else
				Set_Sensitive(Get_Widget(XML,"entryHeure2"), true);
			end if;
		end if;
		exception
			when CONSTRAINT_ERROR => b_box:=message_dialog("Caractère interdit",Error,Button_Ok,Button_Ok);
						 Set_Text(Gtk_Entry(Get_Widget(XML,"entryNbgroupes2")),"");
	end activerJour2;

end P_window_creerfestival;
