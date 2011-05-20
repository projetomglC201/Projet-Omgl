with ada.text_io;
with GNU.DB.SQLCLI;

package body p_appli_enregville is

-------------------------------------------------------------------------------
	function GetVillesExistantes return Ville_List.Vector is

	ListeVille : Basec201_Data.Ville_List.Vector;
	criteria:db_commons.criteria;

	begin
	
	ListeVille:=Ville_io.retrieve(criteria);

	return ListeVille;

	end GetVillesExistantes;
------------------------------------------------------
	procedure CreateVille (resultEntryNomVille : in Unbounded_String; resultEntryMail : Unbounded_String ) is
	
	ville : tville;
	begin
		
	
	
		ville:=(resultEntryNomVille,resultEntryMail,Festival_List.Empty_Vector);
	
		Ville_io.Save(Ville,false);
	
		exception
		when GNU.DB.SQLCLI.INTEGRITY_VIOLATION => raise EXVilleExistante;
	
	end CreateVille;
---------------------------------------------------------------------------





end p_appli_enregville;
