--with tp_Intl; use tp_Intl;
with Glade.XML;use Glade.XML;
with base_type; use base_type;
package body P_window_creerfestival is


windowcreerfestival:gtk_window;
XML : Glade_XML;
procedure init is

begin
	Glade.XML.Gtk_New(XML, "./src/ihm/glade/CreerFestival.glade", "windowcreerfestival");
	windowcreerfestival:=Gtk_Window(Get_Widget(XML,"windowcreerfestival"));
	Glade.XML.signal_connect (XML,"on_buttonAnnuler_clicked",fermerFenetre'address,Null_Address);
	Glade.XML.signal_connect (XML,"on_buttonValider_clicked",validerfestival'address,Null_Address);
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
--	resultcalendardatedebut: ?
	resultEntryLieu:Unbounded_String;
	resultentryPrixEntree:Unbounded_String;
	resultentryNbgroupes1:integer;
	resultentryNbgroupes2:integer;
	festival:tfestival;
	jours : Jour_Festival_List.Vector;
	jour1,jour2 : tJour_Festival;
	an,mois,jour:Guint;
	date:time;
	resultentryHeure1:integer;
	resultentryHeure2:integer;
	begin
	
	
		to_ada_type(Get_Active_Text(Gtk_combo_box(Get_Widget(XML,"comboboxVille"))),resultcomboboxVille);
		Get_Date(Gtk_calendar(Get_Widget(XML,"calendardatedebut")),an,mois,jour);	
		to_ada_type(Get_Text(Gtk_Entry(Get_Widget(XML,"entryLieu"))),resultEntryLieu);
	
		to_ada_type(Get_Text(Gtk_Entry(Get_Widget(XML,"entryPrixEntree"))),resultentryPrixEntree);
		to_ada_type(Get_Text(Gtk_Entry(Get_Widget(XML,"entryNbgroupes1"))),resultentryNbgroupes1);
		to_ada_type(Get_Text(Gtk_Entry(Get_Widget(XML,"entryNbgroupes2"))),resultentryNbgroupes2);		
		to_ada_type(Get_Text(Gtk_Entry(Get_Widget(XML,"entryHeure1"))),resultentryHeure1);
		to_ada_type(Get_Text(Gtk_Entry(Get_Widget(XML,"entryHeure2"))),resultentryHeure2);

		jour1 := (MISSING_I_KEY,MISSING_I_KEY,1,resultEntryNbGroupes1, heure,Groupe_List.Empty_Vector);
		jour2 := (MISSING_I_KEY,MISSING_I_KEY,2,resultEntryNbGroupes2,heure,Groupe_List.Empty_Vector);
		
		jours := (jour1,jour2);
	
		festival:=(default, resultcomboboxVille, date, resultEntryLieu, resultEntryPrixEntree, jours, Gagnant_Festival_List.empty_vector);
		
		CreateFestival(festival);
		


	
	
		b_box:=message_dialog("Festival crée",Confirmation,Button_Ok,Button_Ok);
		
	end validerfestival;
--------------------------------------------------------------------------
end P_window_creerfestival;
