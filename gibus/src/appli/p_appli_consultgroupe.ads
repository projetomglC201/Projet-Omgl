with basec201_data; use basec201_data;
with ada.strings.unbounded; use ada.strings.unbounded;
with db_commons;
with Groupe_io;
with jour_festival_io;
with ville_io;
with festival_io;

package p_appli_consultgroupe is


function getGroupes return Groupe_List.Vector ;
	--retourne la liste des groupes
function getTGroupe(nomGroupe : in Unbounded_String) return tGroupe;
	--retourne la structure du groupe de nom "nomGroupe"
function getVilleGroupe(Groupe: in tGroupe) return Unbounded_String;
	--retourne la nom de la ville du festival auquel est inscrit le groupe 'Groupe'
procedure delete(nomgroupe : in Unbounded_String);
	--supprime le groupe de nom "nomgroupe"
end p_appli_consultgroupe;
