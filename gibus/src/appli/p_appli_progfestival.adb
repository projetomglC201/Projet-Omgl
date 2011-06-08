with ada.text_io;

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
		GroupesJour2 := Groupe_List.Empty_Vector;
	end if;
end GetGroupes;

function IsJour2(festival : in Unbounded_String) return boolean is
	jours : Jour_Festival_List.Vector;
	criteria : Db_Commons.criteria;
begin
	festival_io.Add_Ville_Festival(criteria,p_conversion.to_string(festival));
	jours := festival_io.Retrieve_Associated_Jour_Festivals(festival_io.retrieve(criteria).first_element);

	return jours.length=2;
end IsJour2;

function MaxGroupes(festival : in Unbounded_String; numjour : in integer) return integer is
	jours : Jour_Festival_List.Vector;
	criteria : Db_Commons.criteria;
begin
	festival_io.Add_Ville_Festival(criteria,p_conversion.to_string(festival));
	jours := festival_io.Retrieve_Associated_Jour_Festivals(festival_io.retrieve(criteria).first_element);
	
	return jours.element(numjour).nbre_concert_max;
end MaxGroupes;

procedure MaJOrdrePassage(liste : in out Groupe_List.Vector) is
	groupe : basec201_data.tGroupe;
begin
	for i in liste.first_index..liste.last_index loop
		groupe := liste.element(i);
		groupe.ordre_passage := i;
		liste.replace_element(i,groupe);
	end loop;
end MaJOrdrePassage;


procedure switchJour(Nom_groupe : in Unbounded_String; Groupes_Jour_ori : in out Groupe_List.vector; Groupes_Jour_Dest : in out Groupe_List.Vector) is
	groupe : basec201_data.tGroupe;
	jour,jourDest : basec201_data.tJour_Festival;
	festival : basec201_data.tFestival;
	pos : integer;
	
begin
	groupe := groupe_Io.retrieve_by_PK(Nom_Groupe);
	jour := jour_festival_IO.retrieve_By_PK(groupe.Jour_Festival);
	festival := festival_IO.retrieve_by_PK(jour.Festival);


	if jour.Num_Ordre = 1 then
		jourDest := festival_io.retrieve_associated_jour_festivals(festival).element(2);
	else
		jourDest := festival_io.retrieve_associated_jour_festivals(festival).element(1);
	end if;
	
	for i in  groupe_list.first_index(groupes_jour_ori)..groupe_list.last_index(groupes_jour_ori) loop
		if groupe_list.element(groupes_jour_ori,i).nom_groupe=nom_groupe then
			pos := i;
			exit;
		end if;
	end loop;
	groupe_list.delete(Groupes_Jour_Ori,pos);

	groupe.jour_festival := (JourDest.id_jour_festival);
	groupe.ordre_passage := groupe_list.last_index(groupes_jour_dest)+1;

	groupe_list.append(Groupes_Jour_Dest, groupe);

	MaJOrdrePassage(Groupes_Jour_Ori);

end switchJour;

procedure up(nomgroupe : in Unbounded_String;liste_groupe : in out Groupe_List.Vector) is
	groupe,PrevGroupe : Basec201_data.tGroupe;
	pos : integer;
begin

	for i in  liste_groupe.first_index..liste_groupe.last_index loop
		if liste_groupe.element(i).nom_groupe=nomgroupe then
			pos := i;
			exit;
		end if;
	end loop;	
	

	if pos = 1 then
		raise EX_DEJA_EN_HAUT;
	else
		groupe := liste_groupe.element(pos);
		PrevGroupe := liste_groupe.element(pos-1);

		PrevGroupe.ordre_passage := pos;		
		groupe.ordre_passage := pos-1;

		liste_groupe.replace_element(pos,PrevGroupe);
		liste_groupe.replace_element(pos-1,groupe);

	end if;

end up;

procedure down(nomgroupe : in Unbounded_String;liste_groupe : in out Groupe_List.Vector) is
	groupe,PrevGroupe : Basec201_data.tGroupe;
	pos : integer;
begin

	for i in  liste_groupe.first_index..liste_groupe.last_index loop
		if liste_groupe.element(i).nom_groupe=nomgroupe then
			pos := i;
			exit;
		end if;
	end loop;	
	

	if pos = liste_groupe.last_index then
		raise EX_DEJA_EN_BAS;
	else
		groupe := liste_groupe.element(pos);
		PrevGroupe := liste_groupe.element(pos+1);

		PrevGroupe.ordre_passage := pos;		
		groupe.ordre_passage := pos+1;

		liste_groupe.replace_element(pos,PrevGroupe);
		liste_groupe.replace_element(pos+1,groupe);

	end if;

end down;

procedure top(nomgroupe : in Unbounded_String; liste_groupe : in out Groupe_List.Vector) is
	groupe : Basec201_data.tGroupe;
	pos : integer;
begin
	for i in  liste_groupe.first_index..liste_groupe.last_index loop
		if liste_groupe.element(i).nom_groupe=nomgroupe then
			pos := i;
			exit;
		end if;
	end loop;
	if pos = 1 then
		raise EX_DEJA_EN_HAUT;
	else
		groupe := liste_groupe.element(pos);
	
		liste_groupe.delete(pos);
		liste_groupe.prepend(groupe);
		MaJOrdrePassage(liste_groupe);
	end if;
end top;

procedure bot(nomgroupe : in Unbounded_String; liste_groupe : in out Groupe_List.Vector) is
	pos : integer;
	groupe : Basec201_data.tGroupe;
begin
	for i in  liste_groupe.first_index..liste_groupe.last_index loop
		if liste_groupe.element(i).nom_groupe=nomgroupe then
			pos := i;
			exit;
		end if;
	end loop;
	if pos = liste_groupe.last_index then
		raise EX_DEJA_EN_BAS;
	else
		groupe := liste_groupe.element(pos);
	
		liste_groupe.delete(pos);
		liste_groupe.append(groupe);
		MaJOrdrePassage(liste_groupe);
	end if;
end bot;


procedure save(groupesJour1, groupesJour2 : in Groupe_List.Vector) is
	jour1,jour2 : Basec201_Data.tJour_Festival;
begin

	jour1 := jour_festival_io.retrieve_by_pk(groupesJour1.first_element.jour_festival);
	if not groupesJour2.is_empty then
		jour2 := jour_festival_io.retrieve_by_pk(groupesJour2.first_element.jour_festival);
	end if;

	if groupesJour1.last_index > jour1.nbre_Concert_Max or groupesJour2.last_index > jour2.nbre_Concert_Max then
		raise EX_TROP_DE_GROUPES;
	else
		for i in groupesJour1.first_index..groupesJour1.last_index loop
			groupe_io.save(groupesJour1.element(i),true);	
		end loop;
		for i in groupesJour2.first_index..groupesJour2.last_index loop
			groupe_io.save(groupesJour2.element(i),true);	
		end loop;
	end if;
end save;

end p_appli_progfestival;
