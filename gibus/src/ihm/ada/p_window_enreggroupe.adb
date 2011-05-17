--with tp_Intl; use tp_Intl;
with Glade.XML;use Glade.XML;




package body P_window_enreggroupe is

window:Gtk_window;

----------------------------------------------------------------------------
procedure init is
XML : Glade_XML;
begin
	Glade.XML.Gtk_New(XML, "./src/ihm/glade/enregGroupe.glade", "windowenreggroupe");
	window := Gtk_Window(Get_Widget(XML,"windowenreggroupe"));
	Glade.XML.signal_connect (XML,"on_buttonAnnuler_clicked",fermerFenetre'address,Null_Address);
	Glade.XML.signal_connect (XML,"on_buttonEnregistrer_clicked",enregistrergroupe'address,Null_Address);

end init;
------------------------------------------------------------------------------
	procedure fermerFenetre is
	begin
		Destroy(window);
	end fermerFenetre;
---------------------------------------------------------------------------
	procedure enregistrergroupe is
		b_box : message_dialog_buttons;
	begin
		b_box:=message_dialog("Groupe enregistré !",Information,Button_Ok,Button_Ok);
	end enregistrergroupe;
-----------------------------------------------------------------------------

end P_window_enreggroupe;




