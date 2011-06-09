with basec201_data; use basec201_data;
with ada.strings.unbounded; use ada.strings.unbounded;
with db_commons;
with Groupe_io;
with jour_festival_io;
with ville_io;
with festival_io;

package p_appli_consultgroupe is


function getGroupes return Groupe_List.Vector ;

function getTGroupe(nomGroupe : in Unbounded_String) return tGroupe;

function getVilleGroupe(Groupe: in tGroupe) return Unbounded_String;

procedure delete(nomgroupe : in Unbounded_String);

end p_appli_consultgroupe;
