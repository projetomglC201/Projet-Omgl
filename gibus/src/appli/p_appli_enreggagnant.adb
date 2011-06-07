




package body p_appli_enreggagnant is



-------------------------------------------------------------------------------------------
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
---------------------------------------------------------------------------------------------
function GetGroupes (festival :in tfestival) return Groupe_list.vector is

Jour1festival: tJour_Festival;
Jour2festival: tJour_Festival;
criteria:db_commons.criteria;
vector:Groupe_list.vector;
begin
	Jour_Festival_IO.Add_Num_Ordre(criteria,1);
	Jour_Festival_IO.Add_Festival(criteria,festival.ID_festival);
	Jour1festival:=jour_festival_io.retrieve(criteria).first_element;
	
	Jour_Festival_IO.Add_Num_Ordre(criteria,2);
	Jour_Festival_IO.Add_Festival(criteria,festival.ID_festival);
	Jour2festival:=jour_festival_io.retrieve(criteria).first_element;
	
	vector:=Jour_festival_io.Retrieve_Associated_Groupes(Jour1Festival);
	Groupe_List.Append(vector,Jour_festival_io.Retrieve_Associated_Groupes(Jour2Festival));
	return vector;

end GetGroupes;
-------------------------------------------------------------------------------------------
function GetFestivalAssocie(entryVille: in Unbounded_String) return tfestival is
Ville:tville;
begin
	
	Ville:=Ville_io.Retrieve_By_PK(entryville);
	return Ville_io.Retrieve_Associated_Festivals(Ville).first_element;


end GetFestivalAssocie;
-------------------------------------------------------------------------------------







end p_appli_enreggagnant;
