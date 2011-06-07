



package body p_appli_creerfinale is

----------------------------------------------------------------------------------------
function FinaleCreee return boolean is

criteria:db_commons.criteria;
begin
	
	
	 return integer(Grande_Finale_IO.Card(Grande_Finale_IO.Retrieve(criteria)))>0;


end FinaleCreee;
-----------------------------------------------------------------------------------
procedure SaveFinale (date : time; prix : integer) is


begin

	

	Grande_Finale_IO.Save((Grande_FInale_IO.Next_Free_Id_Finale,date,prix,Null_Unbounded_String));

end SaveFinale;
--------------------------------------------------------------------------------------------






end p_appli_creerfinale;
