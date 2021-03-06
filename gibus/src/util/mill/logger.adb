--
-- Created by ada_generator.py on 2011-05-13 13:55:54.206645
-- 
with Ada.Text_IO;
with Ada.Calendar;
with base_types; 
with ada.strings.Unbounded;
with Ada.Characters.Conversions;
--
-- Graham's 10 minute logger
--
package body Logger is

   use Ada.Text_IO;
   use base_types;

   NEW_LINE : String := base_types.UNIX_NEW_LINE;   

   current_level  : Log_Level := info_level;
   target_filename : String := "Standard_Output";
   target_maxsize : integer := -1;
   
   function message_header( message_level : Log_Level ) return String is
      use Ada.Calendar;
      adaTime : Ada.Calendar.Time := Ada.Calendar.Clock;
   begin
      return message_level'Img & 
            Year(adaTime)'Img & 
           ":" & Month( adaTime )'Img & 
           ":" & Day( adaTime )'Img & 
           ":" & Seconds( adaTime )'Img;
   end message_header;
   
   --  type Log_Level is ( debug, info, warn, error );
   
   procedure set_Log_Level( new_level : Log_Level ) is
   begin
      current_level := new_level;
   end set_Log_Level;
   
   procedure open( filename : String; maxSizeKB : integer := -1; line_break : String := base_types.UNIX_NEW_LINE ) is
   begin
      target_filename := filename;
      target_maxsize := maxSizeKB;
      NEW_LINE := line_break;
   end open;
   
  procedure Write( message_level : Log_Level; message : String ) is
  handle : File_Type;
  begin
      if( message_level >= current_level )then
         if( target_filename /= "Standard_Output" ) then
            Create( handle, Append_File, target_filename ); 
            Put( handle, message_header( message_level ) & " : " & message & NEW_LINE);
            Flush( handle );
            Close( handle );
         else
            Put( message_header( message_level ) & " : " & message & NEW_LINE );
         end if;
      end if;
      -- if not stdout 
      --    check filesize
      --       if filesize > max size then reccyle
      --      
   end write;

   procedure debug( message : String ) is
   begin
      write( debug_level, message );
   end debug;
   
   procedure info( message : String ) is
   begin
      write( info_level, message );
   end info;
   
   procedure warn( message : String ) is
   begin
      write( warn_level, message );
   end warn;
   
   procedure error( message : String ) is
   begin
      write( error_level, message );
   end error;

   
end Logger;
