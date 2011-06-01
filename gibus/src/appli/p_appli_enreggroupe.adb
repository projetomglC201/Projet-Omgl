

package body p_appli_enreggroupe is
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
function GetGroupesJour1 (festival :in tfestival) return Groupe_list.vector is

Jour1festival: tJour_Festival;
criteria:db_commons.criteria;
begin
	Jour_Festival_IO.Add_Num_Ordre(criteria,1);
	Jour_Festival_IO.Add_Festival(criteria,festival.ID_festival);
	
	
	Jour1festival:=jour_festival_io.retrieve(criteria).first_element;

	return Jour_festival_io.Retrieve_Associated_Groupes(Jour1Festival);


end GetGroupesJour1;
------------------------------------------------------------------------------------------------
function GetGroupesJour2 (festival :in tfestival) return Groupe_list.vector is

Jour2festival: tJour_Festival;
criteria:db_commons.criteria;

begin

	Jour_Festival_IO.Add_Num_Ordre(criteria,2);
	Jour_Festival_IO.Add_Festival(criteria,festival.ID_festival);
	
	
	Jour2festival:=jour_festival_io.retrieve(criteria).first_element;

	return Jour_festival_io.Retrieve_Associated_Groupes(Jour2Festival);

end GetGroupesJour2;
---------------------------------------------------------------------------------
function GetFestivalAssocie(entryVille: in Unbounded_String) return Festival_List.vector is
Ville:tville;
begin
	
	Ville:=Ville_io.Retrieve_By_PK(entryville);
	return Ville_io.Retrieve_Associated_Festivals(Ville);


end GetFestivalAssocie;
------------------------------------------------------------------------------------
function Nbgroupeinscrit(Festival : in tfestival; OrdreJour: in integer) return integer is
Jourfestival: tJour_Festival;
criteria:db_commons.criteria;
begin
	Jour_Festival_IO.Add_Num_Ordre(criteria,OrdreJour);
	Jour_Festival_IO.Add_Festival(criteria,festival.ID_festival);
	
	
	Jourfestival:=jour_festival_io.retrieve(criteria).first_element;

	return integer(Groupe_IO.Card(Jour_festival_io.Retrieve_Associated_Groupes(JourFestival)));


end Nbgroupeinscrit;
----------------------------------------------------------------------------------
function GetJourFestivalAssocie(Festival : in tfestival) return Jour_Festival_List.Vector is

begin
	
	return Festival_io.Retrieve_Associated_Jour_Festivals(Festival);


end GetJourFestivalAssocie;
------------------------------------------------------------------------------------------




end p_appli_enreggroupe;
