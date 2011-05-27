







package p_appli_enreggroupe is


function GetVillesAvecFestival return Ville_list.vector;
function GetGroupesJour1 (festival :in tfestival) return Groupe_list.vector;
function GetGroupesJour2 (festival :in tfestival) return Groupe_list.vector;
function GetFestivalAssocie(entryVille: in Unbounded_String) return Festival_List.vector;





end p_appli_enreggroupe;
