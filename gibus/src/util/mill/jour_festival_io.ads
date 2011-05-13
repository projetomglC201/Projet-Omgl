--
-- Created by ada_generator.py on 2011-05-13 13:55:53.966135
-- 
with Basec201_Data;
with db_commons;
with base_types;
with ADA.Calendar;
with Ada.Strings.Unbounded;
with Ada.Containers.Vectors;
with Ada.Containers; use Ada.Containers;

package Jour_Festival_IO is
  
   package d renames db_commons;   
   use base_types;
   use Ada.Strings.Unbounded;
   
   function Next_Free_Id_Jour_Festival return integer;

   --
   -- returns true if the primary key parts of Jour_Festival match the defaults in Basec201_Data.Null_Jour_Festival
   --
   function Is_Null( Jour_Festival : Basec201_Data.tJour_Festival ) return Boolean;
   
   --
   -- returns true if the container is empty
   --
   function Is_Empty( Jour_Festival_Liste : Basec201_Data.Jour_Festival_List.Vector ) return Boolean;

   --
   -- returns number of items of the container 
   --

   function Card( Jour_Festival_Liste : Basec201_Data.Jour_Festival_List.Vector ) return Count_Type;
  
   --
   -- returns the single Jour_Festival matching the primary key fields, or the Basec201_Data.Null_Jour_Festival record
   -- if no such record exists
   --
   function Retrieve_By_PK( Id_Jour_Festival : integer ) return Basec201_Data.tJour_Festival;
   
   --
   -- Retrieves a list of Basec201_Data.tJour_Festival matching the criteria, or throws an exception
   --
   function Retrieve( c : d.Criteria ) return Basec201_Data.Jour_Festival_List.Vector;
   
   --
   -- Retrieves a list of Basec201_Data.tJour_Festival retrived by the sql string, or throws an exception
   --
   function Retrieve( sqlstr : String ) return Basec201_Data.Jour_Festival_List.Vector;
   
   --
   -- Save the given record, overwriting if it exists and overwrite is true, 
   -- otherwise throws DB_Exception exception. 
   --
   procedure Save( Jour_Festival : Basec201_Data.tJour_Festival; overwrite : Boolean := True );
   
   --
   -- Delete the given record. Throws DB_Exception exception. Sets value to Basec201_Data.Null_Jour_Festival
   --
   procedure Delete( Jour_Festival : in out Basec201_Data.tJour_Festival );
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
   function Retrieve_Associated_Groupes( Jour_Festival : Basec201_Data.tJour_Festival ) return Basec201_Data.Groupe_List.Vector;

   --
   -- functions to add something to a criteria
   --
   procedure Add_Id_Jour_Festival( c : in out d.Criteria; Id_Jour_Festival : integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Festival( c : in out d.Criteria; Festival : integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Num_Ordre( c : in out d.Criteria; Num_Ordre : integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Nbre_Concert_Max( c : in out d.Criteria; Nbre_Concert_Max : integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Heure_Debut( c : in out d.Criteria; Heure_Debut : integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   --
   -- functions to add an ordering to a criteria
   --
   procedure Add_Id_Jour_Festival_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Festival_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Num_Ordre_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Nbre_Concert_Max_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Heure_Debut_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
 
end Jour_Festival_IO;
