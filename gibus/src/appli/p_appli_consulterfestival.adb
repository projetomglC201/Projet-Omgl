



package body p_appli_consulterfestival is

-----------------------------------------------------------------
function GetVille(entryVille: in Unbounded_String) return tville is

begin
	return Ville_io.Retrieve_By_PK(entryville);
end GetVille;

--------------------------------------------------------
function GetFestivalAssocie(entryVille: in Unbounded_String) return Festival_List.vector is
Ville:tville;
begin
	
	Ville:=Ville_io.Retrieve_By_PK(entryville);
	return Ville_io.Retrieve_Associated_Festivals(Ville);


end GetFestivalAssocie;
------------------------------------------------------------
function GetJoursFestivalAssocie(IdFestival: in integer) return Jour_Festival_List.vector is

Festival:tfestival;
begin
	
	Festival:=Festival_io.Retrieve_By_PK(IdFestival);
	return Festival_io.Retrieve_Associated_Jour_Festivals(Festival);


end GetJoursFestivalAssocie;
----------------------------------------------------------------------
function GetVillesAvecFestival return Ville_list.vector is


VillesSansFestival:Ville_list.vector;
Villes:Ville_list.vector;
criteria:db_commons.criteria;


begin


	Villes:=Ville_io.retrieve(criteria);
	
	for i in Ville_list.first_index(Villes)..Ville_list.last_index(Villes) loop
		if not Festival_io.Is_Empty(Ville_io.Retrieve_Associated_Festivals(Villes.element(i))) then
			ville_list.append(VillesSansFestival,ville_list.element(villes,i));
		end if;		
	end loop;
	
	return VillesSansFestival;

end GetVillesAvecFestival;
-----------------------------------------------------------------------

end p_appli_consulterfestival;
