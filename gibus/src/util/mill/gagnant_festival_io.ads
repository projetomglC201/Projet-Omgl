--
-- Created by ada_generator.py on 2011-05-13 13:55:53.998322
-- 
with Basec201_Data;
with db_commons;
with base_types;
with ADA.Calendar;
with Ada.Strings.Unbounded;
with Ada.Containers.Vectors;
with Ada.Containers; use Ada.Containers;

package Gagnant_Festival_IO is
  
   package d renames db_commons;   
   use base_types;
   use Ada.Strings.Unbounded;
   
   function Next_Free_Id_Gagnant_Festival return integer;

   --
   -- returns true if the primary key parts of Gagnant_Festival match the defaults in Basec201_Data.Null_Gagnant_Festival
   --
   function Is_Null( Gagnant_Festival : Basec201_Data.tGagnant_Festival ) return Boolean;
   
   --
   -- returns true if the container is empty
   --
   function Is_Empty( Gagnant_Festival_Liste : Basec201_Data.Gagnant_Festival_List.Vector ) return Boolean;

   --
   -- returns number of items of the container 
   --

   function Card( Gagnant_Festival_Liste : Basec201_Data.Gagnant_Festival_List.Vector ) return Count_Type;
  
   --
   -- returns the single Gagnant_Festival matching the primary key fields, or the Basec201_Data.Null_Gagnant_Festival record
   -- if no such record exists
   --
   function Retrieve_By_PK( Id_Gagnant_Festival : integer ) return Basec201_Data.tGagnant_Festival;
   
   --
   -- Retrieves a list of Basec201_Data.tGagnant_Festival matching the criteria, or throws an exception
   --
   function Retrieve( c : d.Criteria ) return Basec201_Data.Gagnant_Festival_List.Vector;
   
   --
   -- Retrieves a list of Basec201_Data.tGagnant_Festival retrived by the sql string, or throws an exception
   --
   function Retrieve( sqlstr : String ) return Basec201_Data.Gagnant_Festival_List.Vector;
   
   --
   -- Save the given record, overwriting if it exists and overwrite is true, 
   -- otherwise throws DB_Exception exception. 
   --
   procedure Save( Gagnant_Festival : Basec201_Data.tGagnant_Festival; overwrite : Boolean := True );
   
   --
   -- Delete the given record. Throws DB_Exception exception. Sets value to Basec201_Data.Null_Gagnant_Festival
   --
   procedure Delete( Gagnant_Festival : in out Basec201_Data.tGagnant_Festival );
   --
   -- delete the records indentified by the criteria
   --
   procedure Delete( c : d.Criteria );
   --
   -- delete all the records identified by the where SQL clause 
   --
   procedure Delete( where_Clause : String );
   --
   -- functions to retrieve records from tables with foreign keys
   -- referencing the table modelled by this package
   --

   --
   -- functions to add something to a criteria
   --
   procedure Add_Id_Gagnant_Festival( c : in out d.Criteria; Id_Gagnant_Festival : integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Festival( c : in out d.Criteria; Festival : integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Groupe( c : in out d.Criteria; Groupe : Unbounded_String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Groupe( c : in out d.Criteria; Groupe : String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   --
   -- functions to add an ordering to a criteria
   --
   procedure Add_Id_Gagnant_Festival_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Festival_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Groupe_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
 
end Gagnant_Festival_IO;
