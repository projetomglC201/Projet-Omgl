

with p_esiut; use p_esiut;



package body p_window_consultfinalistes is



XML : Glade_XML;
window:Gtk_window;


treeview_finalistes: Gtk_Tree_View;
modele_finalistes: Gtk_Tree_Store; -- le modèle associé à la vue
rang_finalistes: Gtk_Tree_Iter := Null_Iter; -- ligne dans le modèle





----------------------------------------------------------------------------
procedure init is

begin
	Glade.XML.Gtk_New(XML, "./src/ihm/glade/ConsultFinaliste.glade", "windowConsultFinalistes");
	window := Gtk_Window(Get_Widget(XML,"windowConsultFinalistes"));
	treeview_finalistes:=Gtk_Tree_View(Get_Widget(XML,"treeviewfinalistes"));

	
	Glade.XML.signal_connect (XML,"on_buttonFermer_clicked",fermerFenetre'address,Null_Address);

	
	inittreeviewfinalistes;
	remplirtreeviewfinalistes;

end init;
------------------------------------------------------------------------------
	procedure fermerFenetre is
	begin
		Destroy(window);
	end fermerFenetre;
---------------------------------------------------------------------------------
	procedure inittreeviewfinalistes is
	

	begin
		
<<<<<<< HEAD
=======
		
>>>>>>> d1107d5cc6553276e5afafb5b6fff3827d022a49
		creerColonne("Groupe", treeview_finalistes, true);
		
		creerColonne("Ville",treeview_finalistes, true);
		creerColonne("Genre",treeview_finalistes, true);
		creerModele(treeview_finalistes,modele_finalistes);
		
	
	end inittreeviewfinalistes;
------------------------------------------------------------------------
	procedure remplirtreeviewfinalistes  is
	
		liste_finaliste:p_appli_consultfinalistes.finaliste_List.Vector;
	
		procedure alimente( pos : finaliste_List.Cursor ) is
			finaliste : p_appli_consultfinalistes.tfinaliste;
		begin
			  finaliste := finaliste_List.element( pos );
			  append (modele_finalistes, rang_finalistes, Null_Iter);
			  Set (modele_finalistes, rang_finalistes, 0, p_conversion.to_string(finaliste.Groupe));
			  Set (modele_finalistes, rang_finalistes, 1, p_conversion.to_string(finaliste.ville));
			  Set (modele_finalistes, rang_finalistes, 2, tgenre_Enum'image(finaliste.Genre));
		end alimente;
	begin
		CreerModele(treeview_finalistes,modele_finalistes);
		Clear(modele_finalistes);

		liste_finaliste :=p_appli_consultfinalistes.GetVilleGroupefinalisteGenre;
		
		finaliste_list.iterate(liste_finaliste, alimente'Access);
		
	end remplirtreeviewfinalistes;
-------------------------------------------------------------------------


end p_window_consultfinalistes;
