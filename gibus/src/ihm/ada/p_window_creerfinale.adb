package body p_window_creerfinale is

windowcreerfinale : Gtk_window;
XML : Glade_XML;
calendar : Gtk_Calendar;
b_box:message_dialog_buttons;

---------------------------------------------------------------------------------
procedure init is

begin
	Glade.XML.Gtk_New(XML, "./src/ihm/glade/creerFinale.glade", "windowCreerFinale");
	
	windowcreerfinale := Gtk_Window(Get_Widget(XML,"windowCreerFinale"));
	calendar := Gtk_Calendar(Get_Widget(XML,"calendarDate"));
	
	Glade.XML.signal_connect (XML,"on_buttonFermer_clicked",FermerFenetre'address,Null_Address);
	Glade.XML.signal_connect (XML,"on_buttonCreer_clicked",creerfestival'address,Null_Address);
	SetSensitiveThenFinaleCreee;

	
end init;
------------------------------------------------------------------------------------------------
procedure FermerFenetre is

begin
	Destroy(windowcreerfinale);
end FermerFenetre;
------------------------------------------------------------------------------------------------------
procedure creerfestival is
an,mois,jour:Guint;
resultcalendardate:time;
resultEntryPrix:integer;
begin

	
	Get_Date(Gtk_calendar(Get_Widget(XML,"calendarDate")),an,mois,jour);
		
	resultcalendardate:=Time_Of(integer(an),integer(mois),integer(jour));	


	if not (Get_Text(Gtk_Entry(Get_Widget(XML,"entryPrix")))'length=0) then
		to_ada_type(Get_Text(Gtk_Entry(Get_Widget(XML,"entryPrix"))),resultEntryPrix);
	else
		raise EXEntryPrixEmpty;
	end if;


	SaveFinale(resultcalendardate,resultEntryPrix);


exception
	when EXEntryPrixEmpty
		=> b_box:=message_dialog("Entrez un prix",Error,Button_Ok,Button_Ok);

end creerfestival;
----------------------------------------------------------------------------------
procedure SetSensitiveThenFinaleCreee is

begin

	if FinaleCreee then
		Set_Sensitive(Gtk_Button(Get_Widget(XML,"buttonCreer")),false);
		Set_Sensitive(Gtk_Entry(Get_Widget(XML,"entryPrix")),false);
		Set_Sensitive(calendar,false);
		b_box:=message_dialog("Grande Finale déjà créee",Error,Button_Ok,Button_Ok);
	end if;

end SetSensitiveThenFinaleCreee;
------------------------------------------------------------------------------

end p_window_creerfinale;
