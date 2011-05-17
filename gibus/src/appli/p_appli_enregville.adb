

package body p_appli_enregville is

-------------------------------------------------------------------------------
	function GetVillesExistantes return Basec201_Data.Ville_List.Vector is

	Ville_Liste : Basec201_Data.Ville_List.Vector;
	criteria:db_commons.criteria;

	begin

	Ville_liste:=Ville_io.retrieve(criteria);

	return Ville_liste;

	end GetVillesExistantes;
------------------------------------------------------







end p_appli_enregville;
