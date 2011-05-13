--
-- Created by ada_generator.py on 2011-05-13 13:55:54.011056
-- 
with Basec201_Data;
with db_commons;
with base_types;
with ADA.Calendar;
with Ada.Strings.Unbounded;
with Ada.Containers.Vectors;
with Ada.Containers; use Ada.Containers;

package Grande_Finale_IO is
  
   package d renames db_commons;   
   use base_types;
   use Ada.Strings.Unbounded;
   
   function Next_Free_Id_Finale return integer;

   --
   -- returns true if the primary key parts of Grande_Finale match the defaults in Basec201_Data.Null_Grande_Finale
   --
   function Is_Null( Grande_Finale : Basec201_Data.tGrande_Finale ) return Boolean;
   
   --
   -- returns true if the container is empty
   --
   function Is_Empty( Grande_Finale_Liste : Basec201_Data.Grande_Finale_List.Vector ) return Boolean;

   --
   -- returns number of items of the container 
   --

   function Card( Grande_Finale_Liste : Basec201_Data.Grande_Finale_List.Vector ) return Count_Type;
  
   --
   -- returns the single Grande_Finale matching the primary key fields, or the Basec201_Data.Null_Grande_Finale record
   -- if no such record exists
   --
   function Retrieve_By_PK( Id_Finale : integer ) return Basec201_Data.tGrande_Finale;
   
   --
   -- Retrieves a list of Basec201_Data.tGrande_Finale matching the criteria, or throws an exception
   --
   function Retrieve( c : d.Criteria ) return Basec201_Data.Grande_Finale_List.Vector;
   
   --
   -- Retrieves a list of Basec201_Data.tGrande_Finale retrived by the sql string, or throws an exception
   --
   function Retrieve( sqlstr : String ) return Basec201_Data.Grande_Finale_List.Vector;
   
   --
   -- Save the given record, overwriting if it exists and overwrite is true, 
   -- otherwise throws DB_Exception exception. 
   --
   procedure Save( Grande_Finale : Basec201_Data.tGrande_Finale; overwrite : Boolean := True );
   
   --
   -- Delete the given record. Throws DB_Exception exception. Sets value to Basec201_Data.Null_Grande_Finale
   --
   procedure Delete( Grande_Finale : in out Basec201_Data.tGrande_Finale );
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
   procedure Add_Id_Finale( c : in out d.Criteria; Id_Finale : integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Date( c : in out d.Criteria; Date : Ada.Calendar.Time; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Prix_Place( c : in out d.Criteria; Prix_Place : integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Gagnant_Finale( c : in out d.Criteria; Gagnant_Finale : Unbounded_String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Gagnant_Finale( c : in out d.Criteria; Gagnant_Finale : String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   --
   -- functions to add an ordering to a criteria
   --
   procedure Add_Id_Finale_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Date_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Prix_Place_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Gagnant_Finale_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
 
end Grande_Finale_IO;
