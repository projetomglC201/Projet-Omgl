--with tp_Intl; use tp_Intl;
with Glade.XML;use Glade.XML;

package body P_window_progfestival is

windowprogfestival:gtk_window;
XML : Glade_XML;

procedure init is

begin
	Glade.XML.Gtk_New(XML, "./src/ihm/glade/ProgrammerFestival.glade", "windowprogrammerfestival");
	windowprogfestival:=Gtk_Window(Get_Widget(XML,"windowprogrammerfestival"));
	Glade.XML.signal_connect (XML,"on_buttonAnnuler1_clicked",fermerFenetre'address,Null_Address);
	Glade.XML.signal_connect (XML,"on_buttonAnnuler2_clicked",selectionregion1'address,Null_Address);
	Glade.XML.signal_connect (XML,"on_buttonValider_clicked",rechercherprog'address,Null_Address);
	Glade.XML.signal_connect (XML,"on_buttonTerminer_clicked",finprogrammation'address,Null_Address);
	Glade.XML.signal_connect (XML,"on_buttonright_clicked",gojour2'address,Null_Address);
	Glade.XML.signal_connect (XML,"on_buttonleft_clicked",gojour1'address,Null_Address);
	
	
	selectionregion1;
end init;
---------------------------------------------------------------------
	procedure fermerFenetre is
	begin
		Destroy(windowprogfestival);
	end fermerFenetre;
----------------------------------------------------------------------
	procedure selectionregion1 is
	begin
		--Desactivations
		Set_Sensitive(Gtk_button(Get_Widget(XML,"buttonAnnuler2")),false);
		Set_Sensitive(Gtk_button(Get_Widget(XML,"buttonTerminer")),false);
		Set_Sensitive(Gtk_button(Get_Widget(XML,"buttonBot")),false);
		Set_Sensitive(Gtk_button(Get_Widget(XML,"buttonDown")),false);
		Set_Sensitive(Gtk_button(Get_Widget(XML,"buttonUp")),false);
		Set_Sensitive(Gtk_button(Get_Widget(XML,"buttonTop")),false);
		Set_Sensitive(Gtk_button(Get_Widget(XML,"buttonright")),false);
		Set_Sensitive(Gtk_button(Get_Widget(XML,"buttonleft")),false);
		--activations
		Set_Sensitive(Gtk_button(Get_Widget(XML,"buttonAnnuler1")),true);
		Set_Sensitive(Gtk_button(Get_Widget(XML,"buttonValider")),true);
	end selectionregion1;
----------------------------------------------------------------------
	procedure selectionregion2 is
	begin
		--Desactivations
		Set_Sensitive(Gtk_button(Get_Widget(XML,"buttonAnnuler1")),false);
		Set_Sensitive(Gtk_button(Get_Widget(XML,"buttonValider")),false);
		--activations
				Set_Sensitive(Gtk_button(Get_Widget(XML,"buttonAnnuler2")),true);
		Set_Sensitive(Gtk_button(Get_Widget(XML,"buttonTerminer")),true);
		Set_Sensitive(Gtk_button(Get_Widget(XML,"buttonBot")),true);
		Set_Sensitive(Gtk_button(Get_Widget(XML,"buttonDown")),true);
		Set_Sensitive(Gtk_button(Get_Widget(XML,"buttonUp")),true);
		Set_Sensitive(Gtk_button(Get_Widget(XML,"buttonTop")),true);
		Set_Sensitive(Gtk_button(Get_Widget(XML,"buttonright")),true);
		Set_Sensitive(Gtk_button(Get_Widget(XML,"buttonleft")),true);		
	end selectionregion2;
---------------------------------------------------------------------------
	procedure rechercherprog is
	begin
		--a completer
		selectionregion2;
	end rechercherprog;
---------------------------------------------------------------------
	procedure finprogrammation is
	b_box:message_dialog_buttons;
	begin
		b_box:=message_dialog("Festival programmée",Information,Button_Ok,Button_Ok);
		
		fermerfenetre;
	end finprogrammation;
-------------------------------------------------------------------------
	procedure gojour2 is
	begin
		null;
	end gojour2;
--------------------------------------------------------------------
	procedure gojour1 is
	begin
		null;
	end gojour1;
--------------------------------------------------------------------
end P_window_progfestival;
