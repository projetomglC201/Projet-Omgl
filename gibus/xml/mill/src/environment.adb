--
-- Created by ada_generator.py on 2010-02-14 12:16:47.859714
-- 
package body environment is
   
   SERVER_NAME     : constant String := "simple_pg";
   USER_NAME       : constant String := "postgres";
   PASSWORD        : Constant String := "";


   function Get_Server_Name return String is
   begin
      return SERVER_NAME;
   end Get_Server_Name;
   
   function Get_Username return String is
   begin
      return USER_NAME;
   end Get_Username;
   
   function Get_Password return String is
   begin
      return PASSWORD;
   end Get_Password;

end environment;

