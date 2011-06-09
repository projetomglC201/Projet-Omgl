with p_esiut; use p_esiut;
package body p_window_menu is

windowmenu : Gtk_window;
b_box:message_dialog_buttons;

XML : Glade_XML;
---------------------------------------------------------------------------------
procedure init is

begin
	Glade.XML.Gtk_New(XML, "./src/ihm/glade/menu.glade", "windowmenu");
	
	windowmenu := Gtk_Window(Get_Widget(XML,"windowmenu"));
	
	Glade.XML.signal_connect (XML,"on_menuitemReinit_activate",Reinit'address,Null_Address);
	Glade.XML.signal_connect (XML,"on_menuitemQuit_activate",fermerFenetre'address,Null_Address);
	Glade.XML.signal_connect (XML,"on_menuitemEnregVilles_activate",Openenregvilles'address,Null_Address);
	Glade.XML.signal_connect (XML,"on_menuitemCreerFestival_activate",Opencreerfestival'address,Null_Address);
	Glade.XML.signal_connect (XML,"on_menuitemConsultFestival_activate",Openconsultfestival'address,Null_Address);
	Glade.XML.signal_connect (XML,"on_menuitemProgFestival_activate",Openprogfestival'address,Null_Address);
	Glade.XML.signal_connect (XML,"on_imagemenuEnreggroupe_activate",Openenreggroupe'address,Null_Address);
	Glade.XML.signal_connect (XML,"on_imagemenuitemConsultGroupe_activate",Openconsultgroupe'address,Null_Address);
	Glade.XML.signal_connect (XML,"on_menuitemConsultProgramme_activate",Openconsultprogramme'address,Null_Address);
	Glade.XML.signal_connect (XML,"on_imagemenuitemCreerFinale_activate",Opencreerfinale'address,Null_Address);
	Glade.XML.signal_connect (XML,"on_menuitemEnregGagnant_activate",OpenEnregGagnant'address,Null_Address);
	Glade.XML.signal_connect (XML,"on_menuitemConsultFinalistes_activate",OpenConsultFinalistes'address,Null_Address);	
	Glade.XML.signal_connect (XML,"on_imagemenuitemEnregGagnantFinale_activate",OpenEnregGagnantFinale'address,Null_Address);
	Glade.XML.signal_connect (XML,"on_windowmenu_destroy",fermerFenetre'address,Null_Address);
	Glade.XML.signal_connect (XML,"on_menuitemFestivals_activate", CheckFestival'Address,Null_Address);
	Glade.XML.signal_connect (XML,"on_menuitemGroupes_activate", CheckGroupe'Address,Null_Address);
	Glade.XML.signal_connect (XML,"on_menuitemFinale_activate", CheckFinale'Address,Null_Address);
	

	if not p_appli_menu.AuMoins1Ville then
		Set_Sensitive(Gtk_Image_Menu_Item(Get_Widget(XML,"menuitemCreerFestival")),false);
	end if;

	if not p_appli_menu.AuMoins1Festival then
		Set_Sensitive(Gtk_Image_Menu_Item(Get_Widget(XML,"menuitemConsultFestival")),false);
		Set_Sensitive(Gtk_Image_Menu_Item(Get_Widget(XML,"menuitemProgFestival")),false);
		Set_Sensitive(Gtk_Image_Menu_Item(Get_Widget(XML,"menuitemConsultProgramme")),false);
		Set_Sensitive(Gtk_Image_Menu_Item(Get_Widget(XML,"menuitemEnregGagnant")),false);
		Set_Sensitive(Gtk_Image_Menu_Item(Get_Widget(XML,"menuitemConsultFinalistes")),false);
		Set_Sensitive(Gtk_Image_Menu_Item(Get_Widget(XML,"imagemenuEnreggroupe")),false);
	end if;

	if not p_appli_menu.AuMoins1Groupe then
		Set_Sensitive(Gtk_Image_Menu_Item(Get_Widget(XML,"menuitemEnregGagnant")),false);
		Set_Sensitive(Gtk_Image_Menu_Item(Get_Widget(XML,"imagemenuitemConsultGroupe")),false);
	end if;		
		
	if not p_appli_menu.Is1Finale then
		Set_Sensitive(Gtk_Image_Menu_Item(Get_Widget(XML,"imagemenuitemEnregGagnantFinale")),false);
	else
		Set_Sensitive(Gtk_Image_Menu_Item(Get_Widget(XML,"imagemenuitemCreerFinale")),false);

	end if;
end init;
--------------------------------------------------------------
	procedure Reinit is
	begin
	b_box:=message_dialog("Êtes-vous sûr de vouloir reinit la base de donnée ?",Confirmation,Button_Yes or Button_No,Button_Yes);
	case b_box is
		when 1 => p_appli_menu.reinitDB;
			b_box:=message_dialog("Base reinitialisée",Information,Button_Ok,Button_Ok);
		when others => null;
	end case;
	end Reinit;
-------------------------------------------------------------------------
	procedure fermerFenetre is
	begin
		Gtk.main.main_quit;
	end fermerFenetre;
---------------------------------------------------------------------------
	procedure Openenregvilles is
	begin
		p_window_enregville.init;
	end Openenregvilles;
--------------------------------------------------------------------------
	procedure Opencreerfestival is
	begin
		p_window_creerfestival.init;
	end Opencreerfestival;		
--------------------------------------------------------------------------
	procedure Openconsultfestival is
	begin
		p_window_consulterfestival.init;
	end Openconsultfestival;

--------------------------------------------------------------------------
	procedure Openprogfestival is
	begin
		p_window_progfestival.init;
	end Openprogfestival;
--------------------------------------------------------------------------
	procedure Openenreggroupe is
	begin
		p_window_enreggroupe.init;
	end Openenreggroupe;
--------------------------------------------------------------------------
	procedure Openconsultgroupe is
	begin
		p_window_consultgroupe.init;
	end Openconsultgroupe;
--------------------------------------------------------------------------
	procedure Openconsultprogramme is
	begin
		p_window_consultprogramme.init;
	end Openconsultprogramme;
--------------------------------------------------------------------------
	procedure Opencreerfinale is
	begin
		p_window_creerfinale.init;
	end Opencreerfinale;
--------------------------------------------------------------------
	procedure OpenEnregGagnant is
	begin
		p_window_enreggagnant.init;
	end OpenEnregGagnant;
--------------------------------------------------------------------		
	procedure OpenConsultFinalistes is
	begin
		p_window_ConsultFinalistes.init;
	end OpenConsultFinalistes;
-----------------------------------------------------------------------
	procedure OpenEnregGagnantFinale is
	begin
		p_window_EnregGagnantFinale.init;
	end OpenEnregGagnantFinale;
---------------------------------------------------------------------
	procedure CheckFestival is
	begin
		if not p_appli_menu.AuMoins1Ville then
			Set_Sensitive(Gtk_Image_Menu_Item(Get_Widget(XML,"menuitemCreerFestival")),false);
		else
			Set_Sensitive(Gtk_Image_Menu_Item(Get_Widget(XML,"menuitemCreerFestival")),true);
		end if;

		if not p_appli_menu.AuMoins1Festival then
			Set_Sensitive(Gtk_Image_Menu_Item(Get_Widget(XML,"menuitemConsultFestival")),false);
			Set_Sensitive(Gtk_Image_Menu_Item(Get_Widget(XML,"menuitemProgFestival")),false);
			Set_Sensitive(Gtk_Image_Menu_Item(Get_Widget(XML,"menuitemConsultProgramme")),false);
			Set_Sensitive(Gtk_Image_Menu_Item(Get_Widget(XML,"menuitemEnregGagnant")),false);
		else
			Set_Sensitive(Gtk_Image_Menu_Item(Get_Widget(XML,"menuitemConsultFestival")),true);
			Set_Sensitive(Gtk_Image_Menu_Item(Get_Widget(XML,"menuitemProgFestival")),true);
			Set_Sensitive(Gtk_Image_Menu_Item(Get_Widget(XML,"menuitemConsultProgramme")),true);
			Set_Sensitive(Gtk_Image_Menu_Item(Get_Widget(XML,"menuitemEnregGagnant")),true);
		end if;
	end;
---------------------------------------------------------------------
	procedure CheckGroupe is
	begin
		if not p_appli_menu.AuMoins1Groupe then
			Set_Sensitive(Gtk_Image_Menu_Item(Get_Widget(XML,"imagemenuitemConsultGroupe")),false);
		else
			Set_Sensitive(Gtk_Image_Menu_Item(Get_Widget(XML,"imagemenuitemConsultGroupe")),true);
		end if;		
		
		if not p_appli_menu.AuMoins1Festival then
			Set_Sensitive(Gtk_Image_Menu_Item(Get_Widget(XML,"imagemenuEnreggroupe")),false);
		else
			Set_Sensitive(Gtk_Image_Menu_Item(Get_Widget(XML,"imagemenuEnreggroupe")),true);
		end if;

	end;
---------------------------------------------------------------------
	procedure CheckFinale is
	begin
		if not p_appli_menu.AuMoins1Festival then
			Set_Sensitive(Gtk_Image_Menu_Item(Get_Widget(XML,"menuitemConsultFinalistes")),false);
		else
			Set_Sensitive(Gtk_Image_Menu_Item(Get_Widget(XML,"menuitemConsultFinalistes")),true);
		end if;
		if not p_appli_menu.Is1Finale then
			Set_Sensitive(Gtk_Image_Menu_Item(Get_Widget(XML,"imagemenuitemEnregGagnantFinale")),false);
			Set_Sensitive(Gtk_Image_Menu_Item(Get_Widget(XML,"imagemenuitemCreerFinale")),true);
		else
			Set_Sensitive(Gtk_Image_Menu_Item(Get_Widget(XML,"imagemenuitemCreerFinale")),false);
			if not p_appli_menu.IsGagnantFinale then
				Set_Sensitive(Gtk_Image_Menu_Item(Get_Widget(XML,"imagemenuitemEnregGagnantFinale")),true);
			else
				Set_Sensitive(Gtk_Image_Menu_Item(Get_Widget(XML,"imagemenuitemEnregGagnantFinale")),false);
			end if;
		end if;
	end;
---------------------------------------------------------------------
end p_window_menu;
