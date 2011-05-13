--
-- Created by ada_generator.py on 2011-05-13 13:55:53.672974
-- 
package body environment is
   
   SERVER_NAME     : constant String := "basec201";
   USER_NAME       : constant String := "userc201";
   PASSWORD        : Constant String := "chaussette";


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

