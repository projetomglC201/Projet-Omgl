with basec201_data; use basec201_data;
with ada.strings.unbounded; use ada.strings.unbounded;
with db_commons;
with Groupe_io;

package p_appli_consultgroupe is


procedure remplirchamp;
function getGroupes return Groupe_List.Vector ;

function getTGroupe(nomGroupe : in Unbounded_String) return tGroupe;



end p_appli_consultgroupe;
