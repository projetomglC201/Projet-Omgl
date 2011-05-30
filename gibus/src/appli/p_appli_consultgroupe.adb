


package body p_appli_consultgroupe is


procedure remplirchamp is

begin


null;
end remplirchamp;

function getGroupes return Groupe_List.Vector is
criteria:db_commons.criteria;
begin
	return Groupe_io.retrieve(criteria);
end getGroupes;

function getTGroupe(nomGroupe : in Unbounded_String) return tGroupe is
begin
	return Groupe_io.Retrieve_By_PK(nomGroupe);
end getTGroupe;

end p_appli_consultgroupe;
