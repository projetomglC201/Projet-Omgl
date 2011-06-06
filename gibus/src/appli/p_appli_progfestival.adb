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

procedure switchJour(Nom_groupe : in Unbounded_String; nbjour : in integer) is
	groupe : basec201_data.tGroupe;
	jour,jourDest : basec201_data.tJour_Festival;
	festival : basec201_data.tFestival;
begin
	groupe := groupe_Io.retrieve_by_PK(Nom_Groupe);
	jour := jour_festival_IO.retrieve_By_PK(groupe.Jour_Festival);
	festival := festival_IO.retrieve_by_PK(jour.Festival);

	if jour.Num_Ordre = 1 then
		jourDest := festival_io.retrieve_associated_jour_festivals(festival).element(2);
		if card(Retrieve_Associated_Groupes(jourDest)) < jourDest.nbre_Concert_Max then
			groupe.jour_festival := (JourDest.id_jour_festival);
		else
			raise EX_TROP_DE_GROUPES;
		end if;
	else
		jourDest := festival_io.retrieve_associated_jour_festivals(festival).element(1);
                if card(Retrieve_Associated_Groupes(jourDest)) < jourDest.nbre_Concert_Max then
                        groupe.jour_festival := (JourDest.id_jour_festival);
                else
                        raise EX_TROP_DE_GROUPES;
                end if;

	end if;

	groupe_io.save(groupe,true);

end switchJour;


end p_appli_progfestival;
