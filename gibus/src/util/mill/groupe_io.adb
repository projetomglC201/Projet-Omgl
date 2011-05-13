--
-- Created by ada_generator.py on 2011-05-13 13:55:53.992515
-- 
with Basec201_Data;


with Ada.Containers.Vectors;
with Ada.Containers; use Ada.Containers;

with environment;

with db_commons; 
with db_commons.odbc; 

with GNU.DB.SQLCLI;  
with GNU.DB.SQLCLI.Bind;
with GNU.DB.SQLCLI.Info;
with GNU.DB.SQLCLI.Environment_Attribute;
with GNU.DB.SQLCLI.Connection_Attribute;

with Ada.Exceptions;  
with Ada.Strings; 
with Ada.Strings.Wide_Fixed;
with Ada.Characters.Conversions;
with Ada.Strings.Unbounded; 
with text_io;
with Ada.Strings.Maps;

with Gagnant_Festival_IO;
with Grande_Finale_IO;

with Logger;

package body Groupe_IO is

   use Ada.Strings.Unbounded;
   use Ada.Exceptions;
   use Ada.Strings;

   package dodbc renames db_commons.odbc;
   package sql renames GNU.DB.SQLCLI;
   package sql_info renames GNU.DB.SQLCLI.Info;
   use sql;
   use base_types;
   --
   -- generic packages to handle each possible type of decimal, if any, go here
   --
   
   --
   -- Select all variables; substring to be competed with output from some criteria
   --
   SELECT_PART : constant String := "select " &
         "nom_groupe, jour_festival, nom_contact, coord_contact, adr_site, ordre_passage, genre " &
         "from groupe " ;
   
   --
   -- Insert all variables; substring to be competed with output from some criteria
   --
   INSERT_PART : constant String := "insert into groupe (" &
         "nom_groupe, jour_festival, nom_contact, coord_contact, adr_site, ordre_passage, genre " &
         " ) values " ;

   
   --
   -- delete all the records identified by the where SQL clause 
   --
   DELETE_PART : constant String := "delete from groupe ";
   
   --
   -- update
   --
   UPDATE_PART : constant String := "update groupe set  ";
   
   function get_connection return dodbc.Database_Connection is
      use dodbc;
      con : dodbc.Database_Connection := dodbc.Null_Database_Connection;
   begin
      con := dodbc.connect( 
            environment.Get_Server_Name, 
            environment.Get_Username, 
            environment.Get_Password );
      return con;
      exception 
      when Error : others =>  
         Logger.error( "exception " & Exception_Information(Error) ); 
         Raise_Exception( d.DB_Exception'Identity, 
            "getConnection: exception thrown " & Exception_Information(Error) );
   end get_connection;
   

   --
   -- returns true if the primary key parts of Groupe match the defaults in Basec201_Data.Null_Groupe
   --
   --
   -- Does this Groupe equal the default Basec201_Data.Null_Groupe ?
   --
   function Is_Null( Groupe : Basec201_Data.tGroupe ) return Boolean is
   use Basec201_Data;
   begin
      return Groupe = Basec201_Data.Null_Groupe;
   end Is_Null;


   
   --
   -- returns true if the container is empty
   --
   --
   -- Does this Groupe_List empty ?
   --
   function Is_Empty( Groupe_Liste : Basec201_Data.Groupe_List.Vector ) return Boolean is
   use Basec201_Data;
   begin
      return Groupe_List.Is_Empty(Groupe_Liste);
   end Is_Empty;



   --
   -- returns number of items of the container 
   --
   --
   -- return number of elements of Groupe_List
   --
   function Card( Groupe_Liste : Basec201_Data.Groupe_List.Vector ) return Count_Type is
   use Basec201_Data;
   begin
      return Groupe_List.Length(Groupe_Liste);
   end Card;



   --
   -- returns the single Groupe matching the primary key fields, or the Basec201_Data.Null_Groupe record
   -- if no such record exists
   --
   function Retrieve_By_PK( Nom_Groupe : Unbounded_String ) return Basec201_Data.tGroupe is
      l : Basec201_Data.Groupe_List.Vector;
      Groupe : Basec201_Data.tGroupe;
      c : d.Criteria;
   begin      
      Add_Nom_Groupe( c, Nom_Groupe );
      l := retrieve( c );
      if( not Basec201_Data.Groupe_List.is_empty( l ) ) then
         Groupe := Basec201_Data.Groupe_List.First_Element( l );
      else
         Groupe := Basec201_Data.Null_Groupe;
      end if;
      return Groupe;
   end Retrieve_By_PK;

   
   --
   -- Retrieves a list of Basec201_Data.tGroupe matching the criteria, or throws an exception
   --
   function Retrieve( c : d.Criteria ) return Basec201_Data.Groupe_List.Vector is
   begin      
      return Retrieve( d.to_string( c ) );
   end Retrieve;

   
   --
   -- Retrieves a list of Basec201_Data.tGroupe retrived by the sql string, or throws an exception
   --
   function Retrieve( sqlstr : String ) return Basec201_Data.Groupe_List.Vector is
      type Timestamp_Access is access all SQL_TIMESTAMP_STRUCT;
      type Real_Access is access all Real;
      type String_Access is access all String;

      l : Basec201_Data.Groupe_List.Vector;
      ps : SQLHDBC := SQL_NULL_HANDLE;
      has_data : Boolean := false;
      connection : dodbc.Database_Connection := get_connection;
      query : constant String := SELECT_PART & " " & sqlstr;
      --
      -- aliased local versions of fields 
      --
      Nom_Groupe: aliased String := 
            "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@" &
            "@@@@@@@@@@@@@@@@@@@@@@@@@@@@";
      Jour_Festival: aliased integer;
      Nom_Contact: aliased String := 
            "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@";
      Coord_Contact: aliased String := 
            "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@" &
            "@@@@@@@@@@@@@@@@@@@@@@@@@@@@";
      Adr_Site: aliased String := 
            "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@" &
            "@@@@@@@@@@@@@@@@@@@@@@@@@@@@";
      Ordre_Passage: aliased integer;
      Genre: aliased Integer;
      --
      -- access variables for any variables retrieved via access types
      --
      Nom_Groupe_access : String_Access := Nom_Groupe'access;
      Nom_Contact_access : String_Access := Nom_Contact'access;
      Coord_Contact_access : String_Access := Coord_Contact'access;
      Adr_Site_access : String_Access := Adr_Site'access;
      --
      -- length holders for each retrieved variable
      --
      Nom_Groupe_len : aliased SQLINTEGER := Nom_Groupe'Size;
      Jour_Festival_len : aliased SQLINTEGER := Jour_Festival'Size;
      Nom_Contact_len : aliased SQLINTEGER := Nom_Contact'Size;
      Coord_Contact_len : aliased SQLINTEGER := Coord_Contact'Size;
      Adr_Site_len : aliased SQLINTEGER := Adr_Site'Size;
      Ordre_Passage_len : aliased SQLINTEGER := Ordre_Passage'Size;
      Genre_len : aliased SQLINTEGER := Genre'Size;
      Groupe : Basec201_Data.tGroupe;
   begin
      logger.info( "retrieve made this as query " & query );
      begin -- exception block
         ps := dodbc.Initialise_Prepared_Statement( connection.connection, query );       
         SQLBindCol(
            StatementHandle  => ps,
            ColumnNumber     => 1,
            TargetType       => SQL_C_CHAR,
            TargetValuePtr   => To_SQLPOINTER( Nom_Groupe_access.all'address ),
            BufferLength     => Nom_Groupe_len,
            StrLen_Or_IndPtr => Nom_Groupe_len'access );
         dodbc.I_Out_Binding.SQLBindCol(
            StatementHandle  => ps,
            ColumnNumber     => 2,
            TargetValue      => Jour_Festival'access,
            IndPtr           => Jour_Festival_len'access );
         SQLBindCol(
            StatementHandle  => ps,
            ColumnNumber     => 3,
            TargetType       => SQL_C_CHAR,
            TargetValuePtr   => To_SQLPOINTER( Nom_Contact_access.all'address ),
            BufferLength     => Nom_Contact_len,
            StrLen_Or_IndPtr => Nom_Contact_len'access );
         SQLBindCol(
            StatementHandle  => ps,
            ColumnNumber     => 4,
            TargetType       => SQL_C_CHAR,
            TargetValuePtr   => To_SQLPOINTER( Coord_Contact_access.all'address ),
            BufferLength     => Coord_Contact_len,
            StrLen_Or_IndPtr => Coord_Contact_len'access );
         SQLBindCol(
            StatementHandle  => ps,
            ColumnNumber     => 5,
            TargetType       => SQL_C_CHAR,
            TargetValuePtr   => To_SQLPOINTER( Adr_Site_access.all'address ),
            BufferLength     => Adr_Site_len,
            StrLen_Or_IndPtr => Adr_Site_len'access );
         dodbc.I_Out_Binding.SQLBindCol(
            StatementHandle  => ps,
            ColumnNumber     => 6,
            TargetValue      => Ordre_Passage'access,
            IndPtr           => Ordre_Passage_len'access );
         dodbc.I_Out_Binding.SQLBindCol(
            StatementHandle  => ps,
            ColumnNumber     => 7,
            TargetValue      => Genre'access,
            IndPtr           => Genre_len'access );
         SQLExecute( ps );
         loop
            dodbc.next_row( ps, has_data );
            if( not has_data ) then
               exit;
            end if;
            Groupe.Nom_Groupe := Slice_To_Unbounded( Nom_Groupe, 1, Natural( Nom_Groupe_len ) );
            Groupe.Jour_Festival := Jour_Festival;
            Groupe.Nom_Contact := Slice_To_Unbounded( Nom_Contact, 1, Natural( Nom_Contact_len ) );
            Groupe.Coord_Contact := Slice_To_Unbounded( Coord_Contact, 1, Natural( Coord_Contact_len ) );
            Groupe.Adr_Site := Slice_To_Unbounded( Adr_Site, 1, Natural( Adr_Site_len ) );
            Groupe.Ordre_Passage := Ordre_Passage;
            Groupe.Genre := tgenre_Enum'Val( Genre );
            Basec201_Data.Groupe_List.append( l, Groupe );        
         end loop;
         logger.info( "retrieve: Query Run OK" );
      exception 
         when No_Data => Null; 
         when Error : others =>
            --Raise_Exception( d.DB_Exception'Identity, 
              -- "retrieve: exception " & Exception_Information(Error) );
		Reraise_Occurrence(Error);

      end; -- exception block
      begin
         dodbc.Close_Prepared_Statement( ps );
         dodbc.Disconnect( connection );
      exception 
         when Error : others =>
         --   Raise_Exception( d.DB_Exception'Identity, 
           --    "retrieve: exception " & Exception_Information(Error) );
	Reraise_Occurrence(Error);

      end; -- exception block
      return l;
   end Retrieve;

   
   --
   -- Update the given record 
   -- otherwise throws DB_Exception exception. 
   --
   procedure Update( Groupe : Basec201_Data.tGroupe ) is
      ps : sql.SQLHDBC := sql.SQL_NULL_HANDLE;
      connection : dodbc.Database_Connection := get_connection;
      query : Unbounded_String := UPDATE_PART & To_Unbounded_String(" ");
      pk_c : d.Criteria;
      values_c : d.Criteria;
   begin
      --
      -- values to be updated
      --
      Add_Jour_Festival( values_c, Groupe.Jour_Festival );
      Add_Nom_Contact( values_c, Groupe.Nom_Contact );
      Add_Coord_Contact( values_c, Groupe.Coord_Contact );
      Add_Adr_Site( values_c, Groupe.Adr_Site );
      Add_Ordre_Passage( values_c, Groupe.Ordre_Passage );
      Add_Genre( values_c, Groupe.Genre );
      --
      -- primary key fields
      --
      Add_Nom_Groupe( pk_c, Groupe.Nom_Groupe );
      query := query & d.To_String( values_c, "," ) & d.to_string( pk_c );
      Logger.info( "update; executing query" & To_String(query) );
      begin -- exception block      
         ps := dodbc.Initialise_Prepared_Statement( connection.connection, query );       
         SQLExecute( ps );
         Logger.info( "update; execute query OK" );
      exception 
         when No_Data => Null; -- ignore if no updates made
         when Error : others =>
            Logger.error( "update: failed with message " & Exception_Information(Error)  );
            -- Raise_Exception( d.DB_Exception'Identity, 
               -- "update: exception thrown " & Exception_Information(Error) );
	Reraise_Occurrence(Error);

      end; -- exception block
      dodbc.Close_Prepared_Statement( ps );
      dodbc.Disconnect( connection );
   end Update;


   --
   -- Save the compelete given record 
   -- otherwise throws DB_Exception exception. 
   --
   procedure Save( Groupe : Basec201_Data.tGroupe; overwrite : Boolean := True ) is   
      ps : sql.SQLHDBC := sql.SQL_NULL_HANDLE;
      connection : dodbc.Database_Connection;
      query : Unbounded_String := INSERT_PART & To_Unbounded_String(" ");
      c : d.Criteria;
      Groupe_Tmp : Basec201_Data.tGroupe;
   begin
      if( overwrite ) then
         Groupe_Tmp := retrieve_By_PK( Groupe.Nom_Groupe );
         if( not is_Null( Groupe_Tmp )) then
            Update( Groupe );
            return;
         end if;
      end if;
      Add_Nom_Groupe( c, Groupe.Nom_Groupe );
      Add_Jour_Festival( c, Groupe.Jour_Festival );
      Add_Nom_Contact( c, Groupe.Nom_Contact );
      Add_Coord_Contact( c, Groupe.Coord_Contact );
      Add_Adr_Site( c, Groupe.Adr_Site );
      Add_Ordre_Passage( c, Groupe.Ordre_Passage );
      Add_Genre( c, Groupe.Genre );
      query := query & "( "  & d.To_Crude_Array_Of_Values( c ) & " )";
      Logger.info( "save; executing query" & To_String(query) );
      begin
         connection := get_connection;
         ps := dodbc.Initialise_Prepared_Statement( connection.connection, query );       
         SQLExecute( ps );
         Logger.info( "save; execute query OK" );
         
      exception 
         when Error : others =>
            Logger.error( "save; execute query failed with message " & Exception_Information(Error)  );
            Reraise_Occurrence(Error);
      end;
      begin
         dodbc.Close_Prepared_Statement( ps );
         dodbc.Disconnect( connection );
      exception 
         when Error : others =>
            Logger.error( "save/close " & Exception_Information(Error)  );
            Raise_Exception( d.DB_Exception'Identity, 
               "save/close: exception " & Exception_Information(Error) );
      end;
      
   end Save;


   
   --
   -- Delete the given record. Throws DB_Exception exception. Sets value to Basec201_Data.Null_Groupe
   --

   procedure Delete( Groupe : in out Basec201_Data.tGroupe ) is
         c : d.Criteria;
   begin  
      Add_Nom_Groupe( c, Groupe.Nom_Groupe );
      delete( c );
      Groupe := Basec201_Data.Null_Groupe;
      Logger.info( "delete record; execute query OK" );
   end Delete;


   --
   -- delete the records indentified by the criteria
   --
   procedure Delete( c : d.Criteria ) is
   begin      
      delete( d.to_string( c ) );
      Logger.info( "delete criteria; execute query OK" );
   end Delete;
   
   procedure Delete( where_Clause : String ) is
      ps : sql.SQLHDBC := sql.SQL_NULL_HANDLE;
      connection : dodbc.Database_Connection;
      query : Unbounded_String := DELETE_PART & To_Unbounded_String(" ");
   begin
      query := query & where_Clause;
      begin -- try catch block for execute
         Logger.info( "delete; executing query" & To_String(query) );
         connection := get_connection;
         ps := dodbc.Initialise_Prepared_Statement( connection.connection, query );       
         SQLExecute( ps );
         Logger.info( "delete; execute query OK" );
      exception 
         when Error : No_Data => Null; -- silently ignore no data exception, which is hardly exceptional
         when Error : others =>
            Logger.error( "delete; execute query failed with message " & Exception_Information(Error)  );
            -- Raise_Exception( d.DB_Exception'Identity, 
               -- "delete: exception thrown " & Exception_Information(Error) );
	Reraise_Occurrence(Error);

      end;
      begin -- try catch block for close
         dodbc.Close_Prepared_Statement( ps );
         dodbc.Disconnect( connection );
      exception 
         when Error : others =>
            Logger.error( "delete; execute query failed with message " & Exception_Information(Error)  );
            --Raise_Exception( d.DB_Exception'Identity, 
              -- "delete: exception thrown " & Exception_Information(Error) );
	Reraise_Occurrence(Error);

      end;
   end Delete;


   --
   -- functions to retrieve records from tables with foreign keys
   -- referencing the table modelled by this package
   --
   function Retrieve_Associated_Gagnant_Festivals( Groupe : Basec201_Data.tGroupe ) return Basec201_Data.Gagnant_Festival_List.Vector is
      c : d.Criteria;
   begin
      Gagnant_Festival_IO.Add_Groupe( c, Groupe.Nom_Groupe );
      return Gagnant_Festival_IO.retrieve( c );
   end Retrieve_Associated_Gagnant_Festivals;


   function Retrieve_Associated_Grande_Finales( Groupe : Basec201_Data.tGroupe ) return Basec201_Data.Grande_Finale_List.Vector is
      c : d.Criteria;
   begin
      Grande_Finale_IO.Add_Gagnant_Finale( c, Groupe.Nom_Groupe );
      return Grande_Finale_IO.retrieve( c );
   end Retrieve_Associated_Grande_Finales;



   --
   -- functions to add something to a criteria
   --
   procedure Add_Nom_Groupe( c : in out d.Criteria; Nom_Groupe : Unbounded_String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "nom_groupe", op, join, To_String( Nom_Groupe ), 100 );
   begin
      d.add_to_criteria( c, elem );
   end Add_Nom_Groupe;


   procedure Add_Nom_Groupe( c : in out d.Criteria; Nom_Groupe : String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "nom_groupe", op, join, Nom_Groupe, 100 );
   begin
      d.add_to_criteria( c, elem );
   end Add_Nom_Groupe;


   procedure Add_Jour_Festival( c : in out d.Criteria; Jour_Festival : integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "jour_festival", op, join, Jour_Festival );
   begin
      d.add_to_criteria( c, elem );
   end Add_Jour_Festival;


   procedure Add_Nom_Contact( c : in out d.Criteria; Nom_Contact : Unbounded_String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "nom_contact", op, join, To_String( Nom_Contact ), 50 );
   begin
      d.add_to_criteria( c, elem );
   end Add_Nom_Contact;


   procedure Add_Nom_Contact( c : in out d.Criteria; Nom_Contact : String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "nom_contact", op, join, Nom_Contact, 50 );
   begin
      d.add_to_criteria( c, elem );
   end Add_Nom_Contact;


   procedure Add_Coord_Contact( c : in out d.Criteria; Coord_Contact : Unbounded_String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "coord_contact", op, join, To_String( Coord_Contact ), 100 );
   begin
      d.add_to_criteria( c, elem );
   end Add_Coord_Contact;


   procedure Add_Coord_Contact( c : in out d.Criteria; Coord_Contact : String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "coord_contact", op, join, Coord_Contact, 100 );
   begin
      d.add_to_criteria( c, elem );
   end Add_Coord_Contact;


   procedure Add_Adr_Site( c : in out d.Criteria; Adr_Site : Unbounded_String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "adr_site", op, join, To_String( Adr_Site ), 100 );
   begin
      d.add_to_criteria( c, elem );
   end Add_Adr_Site;


   procedure Add_Adr_Site( c : in out d.Criteria; Adr_Site : String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "adr_site", op, join, Adr_Site, 100 );
   begin
      d.add_to_criteria( c, elem );
   end Add_Adr_Site;


   procedure Add_Ordre_Passage( c : in out d.Criteria; Ordre_Passage : integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "ordre_passage", op, join, Ordre_Passage );
   begin
      d.add_to_criteria( c, elem );
   end Add_Ordre_Passage;


   procedure Add_Genre( c : in out d.Criteria; Genre : tgenre_Enum; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "genre", op, join, tgenre_Enum'Pos( Genre ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_Genre;


   
   --
   -- functions to add an ordering to a criteria
   --
   procedure Add_Nom_Groupe_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "nom_groupe", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Nom_Groupe_To_Orderings;


   procedure Add_Jour_Festival_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "jour_festival", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Jour_Festival_To_Orderings;


   procedure Add_Nom_Contact_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "nom_contact", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Nom_Contact_To_Orderings;


   procedure Add_Coord_Contact_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "coord_contact", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Coord_Contact_To_Orderings;


   procedure Add_Adr_Site_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "adr_site", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Adr_Site_To_Orderings;


   procedure Add_Ordre_Passage_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ordre_passage", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Ordre_Passage_To_Orderings;


   procedure Add_Genre_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "genre", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Genre_To_Orderings;


   
end Groupe_IO;
