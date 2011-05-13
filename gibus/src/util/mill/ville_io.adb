--
-- Created by ada_generator.py on 2011-05-13 13:55:53.919083
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

with Festival_IO;

with Logger;

package body Ville_IO is

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
         "nom_ville, mel_contact " &
         "from ville " ;
   
   --
   -- Insert all variables; substring to be competed with output from some criteria
   --
   INSERT_PART : constant String := "insert into ville (" &
         "nom_ville, mel_contact " &
         " ) values " ;

   
   --
   -- delete all the records identified by the where SQL clause 
   --
   DELETE_PART : constant String := "delete from ville ";
   
   --
   -- update
   --
   UPDATE_PART : constant String := "update ville set  ";
   
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
   -- returns true if the primary key parts of Ville match the defaults in Basec201_Data.Null_Ville
   --
   --
   -- Does this Ville equal the default Basec201_Data.Null_Ville ?
   --
   function Is_Null( Ville : Basec201_Data.tVille ) return Boolean is
   use Basec201_Data;
   begin
      return Ville = Basec201_Data.Null_Ville;
   end Is_Null;


   
   --
   -- returns true if the container is empty
   --
   --
   -- Does this Ville_List empty ?
   --
   function Is_Empty( Ville_Liste : Basec201_Data.Ville_List.Vector ) return Boolean is
   use Basec201_Data;
   begin
      return Ville_List.Is_Empty(Ville_Liste);
   end Is_Empty;



   --
   -- returns number of items of the container 
   --
   --
   -- return number of elements of Ville_List
   --
   function Card( Ville_Liste : Basec201_Data.Ville_List.Vector ) return Count_Type is
   use Basec201_Data;
   begin
      return Ville_List.Length(Ville_Liste);
   end Card;



   --
   -- returns the single Ville matching the primary key fields, or the Basec201_Data.Null_Ville record
   -- if no such record exists
   --
   function Retrieve_By_PK( Nom_Ville : Unbounded_String ) return Basec201_Data.tVille is
      l : Basec201_Data.Ville_List.Vector;
      Ville : Basec201_Data.tVille;
      c : d.Criteria;
   begin      
      Add_Nom_Ville( c, Nom_Ville );
      l := retrieve( c );
      if( not Basec201_Data.Ville_List.is_empty( l ) ) then
         Ville := Basec201_Data.Ville_List.First_Element( l );
      else
         Ville := Basec201_Data.Null_Ville;
      end if;
      return Ville;
   end Retrieve_By_PK;

   
   --
   -- Retrieves a list of Basec201_Data.tVille matching the criteria, or throws an exception
   --
   function Retrieve( c : d.Criteria ) return Basec201_Data.Ville_List.Vector is
   begin      
      return Retrieve( d.to_string( c ) );
   end Retrieve;

   
   --
   -- Retrieves a list of Basec201_Data.tVille retrived by the sql string, or throws an exception
   --
   function Retrieve( sqlstr : String ) return Basec201_Data.Ville_List.Vector is
      type Timestamp_Access is access all SQL_TIMESTAMP_STRUCT;
      type Real_Access is access all Real;
      type String_Access is access all String;

      l : Basec201_Data.Ville_List.Vector;
      ps : SQLHDBC := SQL_NULL_HANDLE;
      has_data : Boolean := false;
      connection : dodbc.Database_Connection := get_connection;
      query : constant String := SELECT_PART & " " & sqlstr;
      --
      -- aliased local versions of fields 
      --
      Nom_Ville: aliased String := 
            "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@";
      Mel_Contact: aliased String := 
            "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@" &
            "@@@@@@@@@@@@@@@@@@@@@@@@@@@@";
      --
      -- access variables for any variables retrieved via access types
      --
      Nom_Ville_access : String_Access := Nom_Ville'access;
      Mel_Contact_access : String_Access := Mel_Contact'access;
      --
      -- length holders for each retrieved variable
      --
      Nom_Ville_len : aliased SQLINTEGER := Nom_Ville'Size;
      Mel_Contact_len : aliased SQLINTEGER := Mel_Contact'Size;
      Ville : Basec201_Data.tVille;
   begin
      logger.info( "retrieve made this as query " & query );
      begin -- exception block
         ps := dodbc.Initialise_Prepared_Statement( connection.connection, query );       
         SQLBindCol(
            StatementHandle  => ps,
            ColumnNumber     => 1,
            TargetType       => SQL_C_CHAR,
            TargetValuePtr   => To_SQLPOINTER( Nom_Ville_access.all'address ),
            BufferLength     => Nom_Ville_len,
            StrLen_Or_IndPtr => Nom_Ville_len'access );
         SQLBindCol(
            StatementHandle  => ps,
            ColumnNumber     => 2,
            TargetType       => SQL_C_CHAR,
            TargetValuePtr   => To_SQLPOINTER( Mel_Contact_access.all'address ),
            BufferLength     => Mel_Contact_len,
            StrLen_Or_IndPtr => Mel_Contact_len'access );
         SQLExecute( ps );
         loop
            dodbc.next_row( ps, has_data );
            if( not has_data ) then
               exit;
            end if;
            Ville.Nom_Ville := Slice_To_Unbounded( Nom_Ville, 1, Natural( Nom_Ville_len ) );
            Ville.Mel_Contact := Slice_To_Unbounded( Mel_Contact, 1, Natural( Mel_Contact_len ) );
            Basec201_Data.Ville_List.append( l, Ville );        
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
   procedure Update( Ville : Basec201_Data.tVille ) is
      ps : sql.SQLHDBC := sql.SQL_NULL_HANDLE;
      connection : dodbc.Database_Connection := get_connection;
      query : Unbounded_String := UPDATE_PART & To_Unbounded_String(" ");
      pk_c : d.Criteria;
      values_c : d.Criteria;
   begin
      --
      -- values to be updated
      --
      Add_Mel_Contact( values_c, Ville.Mel_Contact );
      --
      -- primary key fields
      --
      Add_Nom_Ville( pk_c, Ville.Nom_Ville );
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
   procedure Save( Ville : Basec201_Data.tVille; overwrite : Boolean := True ) is   
      ps : sql.SQLHDBC := sql.SQL_NULL_HANDLE;
      connection : dodbc.Database_Connection;
      query : Unbounded_String := INSERT_PART & To_Unbounded_String(" ");
      c : d.Criteria;
      Ville_Tmp : Basec201_Data.tVille;
   begin
      if( overwrite ) then
         Ville_Tmp := retrieve_By_PK( Ville.Nom_Ville );
         if( not is_Null( Ville_Tmp )) then
            Update( Ville );
            return;
         end if;
      end if;
      Add_Nom_Ville( c, Ville.Nom_Ville );
      Add_Mel_Contact( c, Ville.Mel_Contact );
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
   -- Delete the given record. Throws DB_Exception exception. Sets value to Basec201_Data.Null_Ville
   --

   procedure Delete( Ville : in out Basec201_Data.tVille ) is
         c : d.Criteria;
   begin  
      Add_Nom_Ville( c, Ville.Nom_Ville );
      delete( c );
      Ville := Basec201_Data.Null_Ville;
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
   function Retrieve_Associated_Festivals( Ville : Basec201_Data.tVille ) return Basec201_Data.Festival_List.Vector is
      c : d.Criteria;
   begin
      Festival_IO.Add_Ville_Festival( c, Ville.Nom_Ville );
      return Festival_IO.retrieve( c );
   end Retrieve_Associated_Festivals;



   --
   -- functions to add something to a criteria
   --
   procedure Add_Nom_Ville( c : in out d.Criteria; Nom_Ville : Unbounded_String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "nom_ville", op, join, To_String( Nom_Ville ), 45 );
   begin
      d.add_to_criteria( c, elem );
   end Add_Nom_Ville;


   procedure Add_Nom_Ville( c : in out d.Criteria; Nom_Ville : String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "nom_ville", op, join, Nom_Ville, 45 );
   begin
      d.add_to_criteria( c, elem );
   end Add_Nom_Ville;


   procedure Add_Mel_Contact( c : in out d.Criteria; Mel_Contact : Unbounded_String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "mel_contact", op, join, To_String( Mel_Contact ), 100 );
   begin
      d.add_to_criteria( c, elem );
   end Add_Mel_Contact;


   procedure Add_Mel_Contact( c : in out d.Criteria; Mel_Contact : String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "mel_contact", op, join, Mel_Contact, 100 );
   begin
      d.add_to_criteria( c, elem );
   end Add_Mel_Contact;


   
   --
   -- functions to add an ordering to a criteria
   --
   procedure Add_Nom_Ville_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "nom_ville", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Nom_Ville_To_Orderings;


   procedure Add_Mel_Contact_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "mel_contact", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Mel_Contact_To_Orderings;


   
end Ville_IO;
