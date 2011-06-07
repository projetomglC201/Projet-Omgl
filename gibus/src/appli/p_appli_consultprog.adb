package body p_appli_consultprog is

procedure getFestInfo (nomville : in Unbounded_string; nomlieu : out Unbounded_string; jour1 : out unbounded_string; jour2 : out unbounded_string; idjour1 : out integer; idjour2 : out integer; isJour2 : out boolean) is
	festival : basec201_data.tFestival;
	criteria : db_commons.criteria;
begin
	isjour2:=false;
	festival_io.add_ville_festival(criteria, nomville);
	festival := festival_list.first_element(festival_io.retrieve(criteria));
	
	nomlieu := festival.lieu;

	jour1 := to_unbounded_string(integer'image(Day(Festival.Date))&"/"&integer'image(Month(festival.Date))&"/"&integer'image(Year(festival.Date)));

	
	idjour1 := festival_io.Retrieve_Associated_Jour_Festivals(festival).first_element.id_jour_festival;

	if integer(jour_festival_list.length(festival_io.Retrieve_Associated_Jour_Festivals(festival))) > 1 then
		jour2 := to_unbounded_string(integer'image(Day(Festival.Date+86400.0))&"/"&integer'image(Month(festival.Date+86400.0))&"/"&integer'image(Year(festival.Date+86400.0)));
		idjour2 := festival_io.Retrieve_Associated_Jour_Festivals(festival).element(2).id_jour_festival;
		isJour2 := true;
	end if;
	
end getFestInfo;

procedure getGroupInfo(idjour : in integer; groupes : out Groupe_List.Vector) is
	criteria : db_commons.criteria;
begin
	groupe_io.add_jour_festival(criteria,idjour);
	groupes := groupe_io.retrieve(criteria);

end getGroupInfo;


end p_appli_consultprog;
