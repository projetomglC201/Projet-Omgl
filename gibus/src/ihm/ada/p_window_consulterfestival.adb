

package body P_window_consulterfestival is
windowconsulterfestival : Gtk_window; --


---------------------------------------------------------------------------------
procedure init is
XML : Glade_XML;

begin
	Glade.XML.Gtk_New(XML, "./../glade/ConsulterFestival.glade", "windowconsulterfestival");
	
	windowconsulterfestival := Gtk_Window(Get_Widget(XML,"windowconsulterfestival"));
	Glade.XML.signal_connect (XML,"on_buttonFermer_clicked",fermerFenetre'address,Null_Address);

end init;
-------------------------------------------------------------------------
	procedure fermerFenetre is
	begin
		Destroy(windowconsulterfestival);
	end fermerFenetre;
--------------------------------------------------------------------------

end P_window_consulterfestival;
