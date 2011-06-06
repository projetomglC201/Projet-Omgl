package body p_appli_progfestival is

function GetFestivals return Festival_List.Vector is
	criteria : db_commons.criteria;
begin
	
	return Festival_io.retrieve(criteria);
	
end GetFestivals;

procedure GetGroupes(festival : in Unbounded_String; GroupesJour1 : out Groupe_List.Vector; GroupesJour2 : out Groupe_List.Vector) is
	criteria : db_commons.criteria;
	jours : Jour_Festival_List.Vector;
begin
	festival_io.Add_Ville_Festival(criteria,p_conversion.to_string(festival));
	jours := festival_io.Retrieve_Associated_Jour_Festivals(festival_io.retrieve(criteria).first_element);
	
	if jours.length = 2 then
		if jours.element(1).Num_Ordre = 1 then
			GroupesJour1 := jour_festival_io.Retrieve_Associated_Groupes(jours.element(1));
			GroupesJour2 := jour_festival_io.Retrieve_Associated_Groupes(jours.element(2));
		else
			GroupesJour2 := jour_festival_io.Retrieve_Associated_Groupes(jours.element(1));
			GroupesJour1 := jour_festival_io.Retrieve_Associated_Groupes(jours.element(2));
		end if;
			
	else
		GroupesJour1 := jour_festival_io.Retrieve_Associated_Groupes(jours.first_element);
	end if;
end GetGroupes;



end p_appli_progfestival;
