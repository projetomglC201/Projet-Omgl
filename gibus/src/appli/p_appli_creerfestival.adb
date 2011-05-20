

package body p_appli_creerfestival is



---------------------------------------------------------
function GetVillesSansFestival return Ville_list.vector is

VillesSansFestival,Villes:Ville_list.vector;
criteria:db_commons.criteria;
i:Ada.Containers.Vectors.Index_Type;
j:Ada.Containers.Vectors.Index_Type:=1;

begin


	Villes:=Ville_io.retrieve(criteria);
	
	for i in Villes.first_index..Villes.last_index loop
		if Festival_io.Is_Empty(Ville_io.Retrieve_Associated_Festivals(Villes.element(i))) then
			VillesSansFestival.element(j) := Villes.element(i);
			j := j+1;
		end if;
		
	end loop;
	
	return VillesSansFestival;

end GetVillesSansFestival;
--------------------------------------------------------
procedure CreateFestival (Festival: in tFestival) is

begin
 Festival_io.save(Festival,false);

end CreateFestival;
-----------------------------------------------------------




end p_appli_creerfestival;
