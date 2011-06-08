
with ada.text_io;





package body p_appli_consultfinalistes is

------------------------------------------------------------------
function GetVilleGroupefinalisteGenre return finaliste_list.vector is

finaliste:finaliste_list.vector;
criteria:db_commons.criteria;
villewithfinaliste:Ville_list.vector:=GetVillesAvecFinaliste;
nom_groupe:unbounded_string;
nom_ville:unbounded_string;
groupes:groupe_list.vector;
genre:tgenre_enum;
j:positive:=1;
fest:festival_list.vector;
gagnants : gagnant_festival_list.Vector;
begin
	
	For i in villewithfinaliste.first_index..villewithfinaliste.last_index loop
	
		fest := Ville_IO.Retrieve_Associated_Festivals(villewithfinaliste.element(i));
		gagnants := festival_io.retrieve_associated_gagnant_festivals(fest.first_element);
		nom_groupe:=gagnants.first_element.groupe;
		
		nom_ville:=villewithfinaliste.element(i).nom_ville;
		
		groupes:=GetGroupes(Ville_IO.Retrieve_Associated_Festivals(villewithfinaliste.element(i)).first_element);
		while groupes.element(j).Nom_Groupe/=nom_groupe loop
		j:=j+1;
		end loop;
		
		genre:=groupes.element(j).genre;
		finaliste_list.Append(finaliste,(nom_groupe,nom_ville,genre));
		j:=1;
	end loop;
		
	return finaliste;

end GetVilleGroupeFinalisteGenre;
-------------------------------------------------------------------------------------------
function GetVillesAvecFinaliste return Ville_list.vector is


VillesAvecFinaliste:Ville_list.vector;
VillesAvecFestival:Ville_list.vector;
festivals:Festival_list.vector;


begin

		
	VillesAvecFestival:=GetVillesAvecFestival;
		
	for i in Ville_list.first_index(VillesAvecFestival)..Ville_list.last_index(VillesAvecFestival) loop
		
			festivals:=Ville_io.Retrieve_Associated_Festivals(VillesAvecFestival.element(i));
			if not Gagnant_festival_io.Is_Empty(festival_io.Retrieve_Associated_Gagnant_Festivals(festivals.first_element)) then
				ville_list.append(VillesAvecFinaliste,ville_list.element(VillesAvecFestival,i));

			end if;		
			
	end loop;
	
	return VillesAvecFinaliste;

end GetVillesAvecFinaliste;
---------------------------------------------------------------------------------------------
function GetGroupes (festival :in tfestival) return Groupe_list.vector is

Jour1festival: tJour_Festival;
Jour2festival: tJour_Festival;
criteria1:db_commons.criteria;
criteria2:db_commons.criteria;
vector:Groupe_list.vector;
begin

	Jour_Festival_IO.Add_Num_Ordre(criteria1,1);
	Jour_Festival_IO.Add_Festival(criteria1,festival.ID_festival);
	Jour1festival:=jour_festival_io.retrieve(criteria1).first_element;

	
	Jour_Festival_IO.Add_Num_Ordre(criteria2,2);

	Jour_Festival_IO.Add_Festival(criteria2,festival.ID_festival);
	if not (integer(jour_festival_io.retrieve(criteria2).length)=0) then
	Jour2festival:=jour_festival_io.retrieve(criteria2).first_element;
	end if;
	vector:=Jour_festival_io.Retrieve_Associated_Groupes(Jour1Festival);
	Groupe_List.Append(vector,Jour_festival_io.Retrieve_Associated_Groupes(Jour2Festival));
	return vector;

end GetGroupes;
-------------------------------------------------------------------------------------------
function GetVillesAvecFestival return Ville_list.vector is


VillesAvecFestival:Ville_list.vector;
Villes:Ville_list.vector;
criteria:db_commons.criteria;


begin

	Villes:=Ville_io.retrieve(criteria);
	
	for i in Ville_list.first_index(Villes)..Ville_list.last_index(Villes) loop
		if not Festival_io.Is_Empty(Ville_io.Retrieve_Associated_Festivals(Villes.element(i))) then
			ville_list.append(VillesAvecFestival,ville_list.element(villes,i));
		end if;		
	end loop;
	return VillesAvecFestival;

end GetVillesAvecFestival;
---------------------------------------------------------------------------------------------






end p_appli_consultfinalistes;
