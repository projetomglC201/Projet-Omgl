--
-- Created by ada_generator.py on 2011-05-13 13:55:53.932729
-- 
with Basec201_Data;
with db_commons;
with base_types;
with ADA.Calendar;
with Ada.Strings.Unbounded;
with Ada.Containers.Vectors;
with Ada.Containers; use Ada.Containers;

package Festival_IO is
  
   package d renames db_commons;   
   use base_types;
   use Ada.Strings.Unbounded;
   
   function Next_Free_Id_Festival return integer;

   --
   -- returns true if the primary key parts of Festival match the defaults in Basec201_Data.Null_Festival
   --
   function Is_Null( Festival : Basec201_Data.tFestival ) return Boolean;
   
   --
   -- returns true if the container is empty
   --
   function Is_Empty( Festival_Liste : Basec201_Data.Festival_List.Vector ) return Boolean;

   --
   -- returns number of items of the container 
   --

   function Card( Festival_Liste : Basec201_Data.Festival_List.Vector ) return Count_Type;
  
   --
   -- returns the single Festival matching the primary key fields, or the Basec201_Data.Null_Festival record
   -- if no such record exists
   --
   function Retrieve_By_PK( Id_Festival : integer ) return Basec201_Data.tFestival;
   
   --
   -- Retrieves a list of Basec201_Data.tFestival matching the criteria, or throws an exception
   --
   function Retrieve( c : d.Criteria ) return Basec201_Data.Festival_List.Vector;
   
   --
   -- Retrieves a list of Basec201_Data.tFestival retrived by the sql string, or throws an exception
   --
   function Retrieve( sqlstr : String ) return Basec201_Data.Festival_List.Vector;
   
   --
   -- Save the given record, overwriting if it exists and overwrite is true, 
   -- otherwise throws DB_Exception exception. 
   --
   procedure Save( Festival : Basec201_Data.tFestival; overwrite : Boolean := True );
   
   --
   -- Delete the given record. Throws DB_Exception exception. Sets value to Basec201_Data.Null_Festival
   --
   procedure Delete( Festival : in out Basec201_Data.tFestival );
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
   function Retrieve_Associated_Jour_Festivals( Festival : Basec201_Data.tFestival ) return Basec201_Data.Jour_Festival_List.Vector;
   function Retrieve_Associated_Gagnant_Festivals( Festival : Basec201_Data.tFestival ) return Basec201_Data.Gagnant_Festival_List.Vector;

   --
   -- functions to add something to a criteria
   --
   procedure Add_Id_Festival( c : in out d.Criteria; Id_Festival : integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Ville_Festival( c : in out d.Criteria; Ville_Festival : Unbounded_String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Ville_Festival( c : in out d.Criteria; Ville_Festival : String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Date( c : in out d.Criteria; Date : Ada.Calendar.Time; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Lieu( c : in out d.Criteria; Lieu : Unbounded_String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Lieu( c : in out d.Criteria; Lieu : String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Prix_Place( c : in out d.Criteria; Prix_Place : integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   --
   -- functions to add an ordering to a criteria
   --
   procedure Add_Id_Festival_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Ville_Festival_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Date_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Lieu_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Prix_Place_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
 
end Festival_IO;
