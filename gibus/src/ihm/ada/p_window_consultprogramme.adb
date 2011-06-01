--with tp_Intl; use tp_Intl;
with Glade.XML;use Glade.XML;

package body P_window_consultprogramme is


windowconsultprogramme:gtk_window;

-------------------------------------------------------------------
procedure init is
XML : Glade_XML;
begin
	Glade.XML.Gtk_New(XML, "./src/ihm/glade/consultProgramme.glade", "windowconsulterprogramme");
	windowconsultprogramme:=Gtk_Window(Get_Widget(XML,"windowconsulterprogramme"));
	
		Glade.XML.signal_connect (XML,"on_buttonOK_clicked",fermerFenetre'address,Null_Address);
end init;
---------------------------------------------------------------------
	procedure fermerFenetre is
	begin
		Destroy(windowconsultprogramme);
	end fermerFenetre;
---------------------------------------------------------------------------
end P_window_consultprogramme;
