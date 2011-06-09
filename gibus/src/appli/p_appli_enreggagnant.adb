with p_esiut; use p_esiut;
with p_appli_consultfinalistes;



package body p_appli_enreggagnant is



-------------------------------------------------------------------------------------------
function GetVillesSansFinaliste return Ville_list.vector is


VillesSansFinaliste:Ville_list.vector;
Villes:Ville_list.vector;
festivals:Festival_list.vector;
criteria:db_commons.criteria;


begin


	Villes:=p_appli_consultfinalistes.GetVillesAvecFestival;
	
	for i in Ville_list.first_index(Villes)..Ville_list.last_index(Villes) loop
			festivals:=Ville_io.Retrieve_Associated_Festivals(Villes.element(i));
		if Gagnant_festival_io.Is_Empty(festival_io.Retrieve_Associated_Gagnant_Festivals(festivals.first_element)) then
		
			ville_list.append(VillesSansFinaliste,ville_list.element(villes,i));
			
		end if;		
	end loop;
	
	return VillesSansFinaliste;

end GetVillesSansFinaliste;
---------------------------------------------------------------------------------------------
function GetGroupes (festival :in tfestival) return Groupe_list.vector is

Jour1festival: tJour_Festival;
Jour2festival: tJour_Festival;
crit1,crit2:db_commons.criteria;
vector:Groupe_list.vector;
begin

	Jour_Festival_IO.Add_Num_Ordre(crit1,1);
	Jour_Festival_IO.Add_Festival(crit1,festival.ID_festival);
	Jour1festival:=jour_festival_io.retrieve(crit1).first_element;

	
	Jour_Festival_IO.Add_Num_Ordre(crit2,2);

	Jour_Festival_IO.Add_Festival(crit2,festival.ID_festival);
	if not (integer(jour_festival_io.retrieve(crit2).length)=0) then
	Jour2festival:=jour_festival_io.retrieve(crit2).first_element;
	end if;
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
procedure SaveGagnantFestival( festival : in tfestival; nom_groupe : in unbounded_string) is

	list_gagnant:gagnant_festival_list.vector;
	Gagnant:tgagnant_festival:=(Gagnant_Festival_IO.Next_Free_Id_Gagnant_Festival,festival.id_festival,nom_groupe);
begin

	gagnant_festival_io.Save(gagnant,false);
	gagnant_festival_list.Append(list_gagnant,gagnant);
	festival_io.Save((festival.Id_Festival,festival.Ville_Festival,festival.Date,festival.Lieu,festival.Prix_place,festival.Jour_Festivals,list_gagnant),true);


end SaveGagnantFestival;
------------------------------------------------------------------------------------------
end p_appli_enreggagnant;
