

package body p_appli_creerfestival is



---------------------------------------------------------
function GetVillesSansFestival return Ville_list.vector is


VillesSansFestival:Ville_list.vector;
Villes:Ville_list.vector;
criteria:db_commons.criteria;


begin


	Villes:=Ville_io.retrieve(criteria);
	
	for i in Ville_list.first_index(Villes)..Ville_list.last_index(Villes) loop
		if Festival_io.Is_Empty(Ville_io.Retrieve_Associated_Festivals(Villes.element(i))) then
			ville_list.append(VillesSansFestival,ville_list.element(villes,i));
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
procedure CreateJourFestival (Jour_Festival : in tJour_Festival) is

begin

jour_festival_io.save(Jour_Festival,false);
end CreateJourFestival;
-----------------------------------------------------------


end p_appli_creerfestival;
