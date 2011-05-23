--with tp_Intl; use tp_Intl;
with Glade.XML;use Glade.XML;

package body P_window_creerfestival is


windowcreerfestival:gtk_window;
XML : Glade_XML;
combobox:access Gtk_Combo_Box_Record;
procedure init is

begin
	Glade.XML.Gtk_New(XML, "./src/ihm/glade/CreerFestival.glade", "windowcreerfestival");
	windowcreerfestival:=Gtk_Window(Get_Widget(XML,"windowcreerfestival"));
	Glade.XML.signal_connect (XML,"on_buttonAnnuler_clicked",fermerFenetre'address,Null_Address);
	Glade.XML.signal_connect (XML,"on_buttonValider_clicked",validerfestival'address,Null_Address);
	combobox :=Gtk_combo_box(Get_Widget(XML,"comboboxVille"));
end init;
---------------------------------------------------------------------
	procedure fermerFenetre is
	begin
		Destroy(windowcreerfestival);
	end fermerFenetre;
--------------------------------------------------------------------------
	procedure validerfestival is
	b_box:message_dialog_buttons;
	resultcomboboxVille:Unbounded_String;
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
	
	
		to_ada_type(Get_Active_Text(combobox),resultcomboboxVille);
		Get_Date(Gtk_calendar(Get_Widget(XML,"calendardatedebut")),an,mois,jour);
		resultcalendardatedebut:=Time_Of(integer(an),integer(mois),integer(jour));	
		to_ada_type(Get_Text(Gtk_Entry(Get_Widget(XML,"entryLieu"))),resultEntryLieu);
	
		to_ada_type(Get_Text(Gtk_Entry(Get_Widget(XML,"entryPrixEntree"))),resultentryPrixEntree);
		to_ada_type(Get_Text(Gtk_Entry(Get_Widget(XML,"entryNbgroupes1"))),resultentryNbgroupes1);
		to_ada_type(Get_Text(Gtk_Entry(Get_Widget(XML,"entryNbgroupes2"))),resultentryNbgroupes2);		
		to_ada_type(Get_Text(Gtk_Entry(Get_Widget(XML,"entryHeure1"))),resultentryHeure1);
		to_ada_type(Get_Text(Gtk_Entry(Get_Widget(XML,"entryHeure2"))),resultentryHeure2);

		jour1 := (jour_festival_io.Next_Free_Id_Jour_Festival,IDFESTIVAL,1,resultEntryNbGroupes1, resultentryHeure1,Groupe_List.Empty_Vector);
		jour2 := (jour_festival_io.Next_Free_Id_Jour_Festival+1,IDFESTIVAL,2,resultEntryNbGroupes2,resultentryHeure2,Groupe_List.Empty_Vector);
		

		
		festival:=(IDFESTIVAL, resultcomboboxVille, resultcalendardatedebut, resultEntryLieu, resultEntryPrixEntree, Jour_Festival_List.empty_vector, Gagnant_Festival_List.empty_vector);
		
		CreateFestival(festival);
		

	
		b_box:=message_dialog("Festival crée",Confirmation,Button_Ok,Button_Ok);
		
	end validerfestival;
--------------------------------------------------------------------------
	procedure initcombobox is
	Liste_ville:Ville_list.Vector:=GetVillesSansFestival;
	begin
	
	
	Append_Text(combobox,"");
	
	end initcombobox;
----------------------------------------------------------------------
end P_window_creerfestival;
