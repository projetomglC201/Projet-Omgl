with ada.text_io;

package body p_appli_enregville is

-------------------------------------------------------------------------------
	function GetVillesExistantes return Ville_List.Vector is

	ListeVille : Basec201_Data.Ville_List.Vector;
	criteria:db_commons.criteria;

	begin
	
	ada.text_io.put_line("Avant retrieve");
	ListeVille:=Ville_io.retrieve(criteria);
	ada.text_io.put_line("Apres retrieve");

	return ListeVille;

	end GetVillesExistantes;
------------------------------------------------------
	procedure CreateVille ( Ville_item : in Basec201_Data.tVille) is
	
	
	begin
	
		Ville_io.Save(Ville_Item,false);
	end CreateVille;
---------------------------------------------------------------------------





end p_appli_enregville;
