with ada.strings.unbounded; use ada.strings.unbounded;
with db_commons;
with basec201_data; use basec201_data;
with festival_io;
with groupe_io;
with ada.containers.vectors;
with ada.calendar; use ada.calendar;

package p_appli_consultprog is

procedure getFestInfo (nomville : in Unbounded_string; nomlieu : out Unbounded_string; jour1 : out unbounded_string; jour2 : out unbounded_string; idjour1 : out integer; idjour2 : out integer; isJour2: out boolean) ;
	--affecte nomlieu,jour1,jour2,idjour1,idjour2 et isjour2 avec les infos du festival de la ville "nomville"
	--isJour2 vaut 'vrai' si le festival a deux jours
procedure getGroupInfo(idjour : in integer; groupes : out Groupe_List.Vector);
	--affecte à 'groupes' la liste des groupes du jour d'id 'idjour'

end p_appli_consultprog;
