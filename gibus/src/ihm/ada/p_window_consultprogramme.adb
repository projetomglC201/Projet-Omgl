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
	
		Glade.XML.signal_connect(XML,"on_buttonOK_clicked",fermerFenetre'address,Null_Address);
		Glade.XML.signal_connect(XML,"on_treeview1_cursor_changed",selectFest'address,Null_Address);
	
--	initTreeviewFest;
--	initTreeviewJour1;
--	initTreeviewJour2;
end init;
---------------------------------------------------------------------
	procedure fermerFenetre is
	begin
		Destroy(windowconsultprogramme);
	end fermerFenetre;
---------------------------------------------------------------------------
	procedure initTreeviewFest is
	begin
		null;
	end initTreeviewFest;
---------------------------------------------------------------------------
	procedure initTreeviewJour1 is
        begin
		null;
        end initTreeviewJour1;

---------------------------------------------------------------------------
	procedure initTreeviewJour2 is
        begin
		null;
        end initTreeviewJour2;
---------------------------------------------------------------------------
	procedure fillTreeviewJour1 is
        begin
		null;
        end fillTreeviewJour1;
---------------------------------------------------------------------------
	procedure fillTreeviewJour2 is
        begin
		null;
        end fillTreeviewJour2;
---------------------------------------------------------------------------
	procedure selectFest is
	begin
--		set_text
--		set_text
--		filltreeviewjour1;
--
--		if jour 2 then
--			set_text
--			filltreeviewjour2;
--		end if;
		null;
	end selectFest;
--------------------------------------------------------------------
end P_window_consultprogramme;
