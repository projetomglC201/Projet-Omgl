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
	begin
		b_box:=message_dialog("Festival crée",Confirmation,Button_Ok,Button_Ok);
		
	end validerfestival;
--------------------------------------------------------------------------
end P_window_creerfestival;
