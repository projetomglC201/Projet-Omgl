with p_esiut; use p_esiut;
package body p_window_menu is

windowmenu : Gtk_window;
b_box:message_dialog_buttons;

---------------------------------------------------------------------------------
procedure init is
XML : Glade_XML;
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
	Glade.XML.signal_connect (XML,"on_windowmenu_destroy",fermerFenetre'address,Null_Address);

	
	
end init;
--------------------------------------------------------------------------
	procedure Reinit is
	b_box2:message_dialog_buttons;
	begin
	b_box:=message_dialog("Êtes-vous sûr de vouloir reinit la base de donnée ?",Confirmation,Button_Yes or Button_No,Button_Yes);
	case b_box is
		when 1 => p_appli_menu.reinitDB;
			b_box2:=message_dialog("Base reinit",Information,Button_Ok,Button_Ok);
				
		when 2 => b_box2:=message_dialog("Base non reinit",Information,Button_Ok,Button_Ok);
		when others => null;
	end case;
	end Reinit;
-------------------------------------------------------------------------
	procedure fermerFenetre is
	begin
		Gtk.main.main_quit;
--		Destroy(windowmenu);
--		
--  		p_window_consultgroupe.fermerFenetre;

-- 		p_window_consulterfestival.fermerFenetre;

--  		p_window_creerfestival.fermerFenetre;

-- 		p_window_enregville.fermerFenetre;
--   
--  		p_window_progfestival.fermerFenetre;
--   
--  		p_window_consultprogramme.fermerFenetre;   
--   
--  		p_window_enreggroupe.fermerFenetre;
		
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


end p_window_menu;
