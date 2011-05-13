--
-- Created by ada_generator.py on 2011-05-13 13:55:53.980473
-- 
with Basec201_Data;
with db_commons;
with base_types;
with ADA.Calendar;
with Ada.Strings.Unbounded;
with Ada.Containers.Vectors;
with Ada.Containers; use Ada.Containers;

package Groupe_IO is
  
   package d renames db_commons;   
   use base_types;
   use Ada.Strings.Unbounded;
   

   --
   -- returns true if the primary key parts of Groupe match the defaults in Basec201_Data.Null_Groupe
   --
   function Is_Null( Groupe : Basec201_Data.tGroupe ) return Boolean;
   
   --
   -- returns true if the container is empty
   --
   function Is_Empty( Groupe_Liste : Basec201_Data.Groupe_List.Vector ) return Boolean;

   --
   -- returns number of items of the container 
   --

   function Card( Groupe_Liste : Basec201_Data.Groupe_List.Vector ) return Count_Type;
  
   --
   -- returns the single Groupe matching the primary key fields, or the Basec201_Data.Null_Groupe record
   -- if no such record exists
   --
   function Retrieve_By_PK( Nom_Groupe : Unbounded_String ) return Basec201_Data.tGroupe;
   
   --
   -- Retrieves a list of Basec201_Data.tGroupe matching the criteria, or throws an exception
   --
   function Retrieve( c : d.Criteria ) return Basec201_Data.Groupe_List.Vector;
   
   --
   -- Retrieves a list of Basec201_Data.tGroupe retrived by the sql string, or throws an exception
   --
   function Retrieve( sqlstr : String ) return Basec201_Data.Groupe_List.Vector;
   
   --
   -- Save the given record, overwriting if it exists and overwrite is true, 
   -- otherwise throws DB_Exception exception. 
   --
   procedure Save( Groupe : Basec201_Data.tGroupe; overwrite : Boolean := True );
   
   --
   -- Delete the given record. Throws DB_Exception exception. Sets value to Basec201_Data.Null_Groupe
   --
   procedure Delete( Groupe : in out Basec201_Data.tGroupe );
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
   function Retrieve_Associated_Gagnant_Festivals( Groupe : Basec201_Data.tGroupe ) return Basec201_Data.Gagnant_Festival_List.Vector;
   function Retrieve_Associated_Grande_Finales( Groupe : Basec201_Data.tGroupe ) return Basec201_Data.Grande_Finale_List.Vector;

   --
   -- functions to add something to a criteria
   --
   procedure Add_Nom_Groupe( c : in out d.Criteria; Nom_Groupe : Unbounded_String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Nom_Groupe( c : in out d.Criteria; Nom_Groupe : String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Jour_Festival( c : in out d.Criteria; Jour_Festival : integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Nom_Contact( c : in out d.Criteria; Nom_Contact : Unbounded_String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Nom_Contact( c : in out d.Criteria; Nom_Contact : String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Coord_Contact( c : in out d.Criteria; Coord_Contact : Unbounded_String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Coord_Contact( c : in out d.Criteria; Coord_Contact : String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Adr_Site( c : in out d.Criteria; Adr_Site : Unbounded_String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Adr_Site( c : in out d.Criteria; Adr_Site : String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Ordre_Passage( c : in out d.Criteria; Ordre_Passage : integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_Genre( c : in out d.Criteria; Genre : tgenre_Enum; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   --
   -- functions to add an ordering to a criteria
   --
   procedure Add_Nom_Groupe_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Jour_Festival_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Nom_Contact_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Coord_Contact_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Adr_Site_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Ordre_Passage_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_Genre_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
 
end Groupe_IO;
