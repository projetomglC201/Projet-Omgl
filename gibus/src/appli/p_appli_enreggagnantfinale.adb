package body p_appli_enreggagnantFinale is

function IsFinale return boolean is
	criteria : db_commons.criteria;
begin
	return grande_finale_io.retrieve(criteria).first_element.Gagnant_Finale /=  Ada.Strings.Unbounded.Null_Unbounded_String;
end IsFinale;

function GetInscritsFinale return Basec201_data.Gagnant_Festival_List.Vector is
	criteria : db_commons.criteria;
begin
	return gagnant_festival_io.retrieve(criteria);
end GetInscritsFinale;

procedure Save(groupe : in Unbounded_String) is
	finale : Basec201_data.tGrande_Finale;
	criteria : db_commons.criteria;
begin
	finale := grande_finale_io.retrieve(criteria).first_element;
	finale.Gagnant_Finale := groupe;
	grande_finale_io.save (finale, true);
end Save;

end p_appli_enregGagnantFinale;
