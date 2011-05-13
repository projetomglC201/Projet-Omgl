--with tp_Intl; use tp_Intl;
with Glade.XML;use Glade.XML;

package body P_window_enregville is

windowenregville:gtk_window;

procedure init is
XML : Glade_XML;
begin
	Glade.XML.Gtk_New(XML, "./../glade/EnregistrerVilles.glade", "windowenregville");
	windowenregville:=Gtk_Window(Get_Widget(XML,"windowenregville"));
	Glade.XML.signal_connect (XML,"on_buttonAnnuler_clicked",fermerFenetre'address,Null_Address);
	Glade.XML.signal_connect (XML,"on_buttonSuivant_clicked",villesuivante'address,Null_Address);
	Glade.XML.signal_connect (XML,"on_buttonTerminer_clicked",finenregistrementville'address,Null_Address);
end init;
---------------------------------------------------------------------
	procedure fermerFenetre is
	begin
		Destroy(windowenregville);
	end fermerFenetre;
--------------------------------------------------------------------------
	procedure villesuivante is
	--Enregistre la ville, efface le contenu des entry et met à jour la liste
	b_box:message_dialog_buttons;
	begin
		b_box:=message_dialog("Ville enregistrée !",Information,Button_Ok,Button_Ok);
		--a completer
	end villesuivante;
------------------------------------------------------------------------
	procedure finenregistrementville is
	b_box:message_dialog_buttons;
	begin
		b_box:=message_dialog("Ville enregistrée !",Information,Button_Ok,Button_Ok);
		--enregistrement
		Destroy(windowenregville);
	end finenregistrementville;
------------------------------------------------------------------------------
end P_window_enregville;
