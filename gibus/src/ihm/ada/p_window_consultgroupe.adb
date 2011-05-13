--with tp_Intl; use tp_Intl;
with Glade.XML;use Glade.XML;

package body P_window_consultgroupe is

windowconsultgroupe:Gtk_window;
--treeview_groupe:Gtk_Tree_View;
--modele_groupe:Gtk_Tree_Store;
--rang_groupe:Gtk_tree_iter:=Null_Iter;





------------------------------------------------------------------------
	procedure init is
		XML : Glade_XML;
	begin
	--Initialisation de la fenetre
		Glade.XML.Gtk_New(XML, "./../glade/ConsultGroupe.glade", "windowconsultgroupe");
		windowconsultgroupe:=Gtk_Window(Get_Widget(XML,"windowconsultgroupe"));
	--connections aux handler
		Glade.XML.signal_connect (XML,"on_buttonFermer_clicked",fermerFenetre'address,Null_Address);
		Glade.XML.signal_connect (XML,"on_combobox1_changed",remplirinfo'address,Null_Address);
	--preparation de latreeview
--		creerColonne("Nom du groupe",treeview_groupe,false);
--		creerModele(treeview_groupe,modele_groupe);

	end init;
---------------------------------------------------------------------
	procedure fermerFenetre is
	begin
		Destroy(windowconsultgroupe);
	end fermerFenetre;
--------------------------------------------------------------------------
	procedure remplirinfo is
	begin
		null;
	end remplirinfo;
--------------------------------------------------------------------------

	end P_window_consultgroupe;

