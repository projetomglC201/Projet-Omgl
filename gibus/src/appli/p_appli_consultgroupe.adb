package body p_appli_consultgroupe is

-----------------------------------------------------

function getGroupes return Groupe_List.Vector is
criteria:db_commons.criteria;
begin
	return Groupe_io.retrieve(criteria);
end getGroupes;

-----------------------------------------------------

function getTGroupe(nomGroupe : in Unbounded_String) return tGroupe is
begin
	return Groupe_io.Retrieve_By_PK(nomGroupe);
end getTGroupe;
-----------------------------------------------------

function getVilleGroupe(Groupe : in tGroupe) return Unbounded_String is
	ville : tVille;
	jour : tJour_Festival;
	festival : tFestival;
begin
	jour := jour_festival_io.retrieve_by_pk(Groupe.Jour_Festival);
	festival := festival_io.retrieve_by_pk(jour.Festival);
	ville := ville_io.retrieve_by_pk(festival.ville_festival);
	

	return ville.Nom_Ville;
end getVilleGroupe;

----------------------------------------------------
end p_appli_consultgroupe;
