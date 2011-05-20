--with tp_Intl; use tp_Intl;
with Glade.XML;use Glade.XML;

package body P_window_creerfestival is


windowcreerfestival:gtk_window;

procedure init is
XML : Glade_XML;
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
--	resultcalendradatedebut: ?
	resultEntryLieu:Unbounded_String;
	resultentryPrixEntree:Unbounded_String;
	resultentryNbgroupes1:Unbounded_String;
	resultentryNbgroupes2:Unbounded_String;
	festival:tfestival;
	an,mois,jour:integer;

	begin
	
	
--		to_ada_type(Get_Active_Text(Gtk_combobox(Get_Widget(XML,"comboboxVille"))),resultcomboboxVille);
--		Get_Date(Gtk_calendar(Get_Widget(XML,"calendardatedebut")),an,mois,jour);	
--		to_ada_type(Get_Text(Gtk_Entry(Get_Widget(XML,"entryLieu"))),resultEntryLieu);
--	
--		to_ada_type(Get_Text(Gtk_Entry(Get_Widget(XML,"entryPrixEntree"))),resultentryPrixEntree);
--		to_ada_type(Get_Text(Gtk_Entry(Get_Widget(XML,"entryNbgroupes1"))),resultentryNbgroupes1);
--		to_ada_type(Get_Text(Gtk_Entry(Get_Widget(XML,"entryNbgroupes2"))),resultentryNbgroupes2);		


--		
--		
--	
--		--festival:=(resultEntryNomVille,resultEntryMail,Festival_List.Empty_Vector);
--		
--		CreateFestival(Ville);
--		


	
	
		b_box:=message_dialog("Festival crée",Confirmation,Button_Ok,Button_Ok);
		
	end validerfestival;
--------------------------------------------------------------------------
end P_window_creerfestival;
