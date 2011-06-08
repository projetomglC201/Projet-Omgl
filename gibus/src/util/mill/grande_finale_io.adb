--
-- Created by ada_generator.py on 2011-05-09 16:04:28.552522
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


with Logger;

package body Grande_Finale_IO is

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
         "id_finale, date, prix_place, case when (gagnant_finale is null)then '' else 'gagnant_finale' end from grande_finale " ;

   --
   -- Insert all variables; substring to be competed with output from some criteria
   --
   INSERT_PART : constant String := "insert into grande_finale (" &
         "id_finale, date, prix_place, gagnant_finale " &
         " ) values " ;


   --
   -- delete all the records identified by the where SQL clause
   --
   DELETE_PART : constant String := "delete from grande_finale ";

   --
   -- update
   --
   UPDATE_PART : constant String := "update grande_finale set  ";

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
   -- Next highest avaiable value of Id_Finale - useful for saving
   --
   function Next_Free_Id_Finale return integer is
      ps : sql.SQLHDBC := sql.SQL_NULL_HANDLE;
      connection : dodbc.Database_Connection := get_connection;
      query : constant String := "select max( id_finale ) from grande_finale";
      ai : aliased Integer;
      has_data : boolean := true;
      output_len : aliased sql.SQLINTEGER;
   begin
      ps := dodbc.Initialise_Prepared_Statement( connection.connection, query );
      dodbc.I_Out_Binding.SQLBindCol(
            StatementHandle  => ps,
            ColumnNumber     => 1,
            TargetValue      => ai'access,
            IndPtr           => output_len'Access );
      SQLExecute( ps );
      loop
         dodbc.next_row( ps, has_data );
         if( not has_data ) then
            exit;
         end if;
         if( ai = base_types.MISSING_I_KEY ) then
            ai := 1;
         else
            ai := ai + 1;
         end if;
      end loop;
      dodbc.Close_Prepared_Statement( ps );
      dodbc.Disconnect( connection );
      return ai;
   exception
      when Error : others =>
         Raise_Exception( d.DB_Exception'Identity,
            "next_free_user_id: exception thrown " & Exception_Information(Error) );
      return  base_types.MISSING_I_KEY;
   end Next_Free_Id_Finale;



   --
   -- returns true if the primary key parts of Grande_Finale match the defaults in basec201_Data.Null_Grande_Finale
   --
   --
   -- Does this Grande_Finale equal the default basec201_Data.Null_Grande_Finale ?
   --
   function Is_Null( Grande_Finale : basec201_Data.tGrande_Finale ) return Boolean is
   use basec201_Data;
   begin
      return Grande_Finale = basec201_Data.Null_Grande_Finale;
   end Is_Null;



   --
   -- returns true if the container is empty
   --
   --
   -- Does this Grande_Finale_List empty ?
   --
   function Is_Empty( Grande_Finale_Liste : basec201_Data.Grande_Finale_List.Vector ) return Boolean is
   use basec201_Data;
   begin
      return Grande_Finale_List.Is_Empty(Grande_Finale_Liste);
   end Is_Empty;



   --
   -- returns number of items of the container
   --
   --
   -- return number of elements of Grande_Finale_List
   --
   function Card( Grande_Finale_Liste : basec201_Data.Grande_Finale_List.Vector ) return Count_Type is
   use basec201_Data;
   begin
      return Grande_Finale_List.Length(Grande_Finale_Liste);
   end Card;



   --
   -- returns the single Grande_Finale matching the primary key fields, or the basec201_Data.Null_Grande_Finale record
   -- if no such record exists
   --
   function Retrieve_By_PK( Id_Finale : integer ) return basec201_Data.tGrande_Finale is
      l : basec201_Data.Grande_Finale_List.Vector;
      Grande_Finale : basec201_Data.tGrande_Finale;
      c : d.Criteria;
   begin
      Add_Id_Finale( c, Id_Finale );
      l := retrieve( c );
      if( not basec201_Data.Grande_Finale_List.is_empty( l ) ) then
         Grande_Finale := basec201_Data.Grande_Finale_List.First_Element( l );
      else
         Grande_Finale := basec201_Data.Null_Grande_Finale;
      end if;
      return Grande_Finale;
   end Retrieve_By_PK;


   --
   -- Retrieves a list of basec201_Data.tGrande_Finale matching the criteria, or throws an exception
   --
   function Retrieve( c : d.Criteria ) return basec201_Data.Grande_Finale_List.Vector is
   begin
      return Retrieve( d.to_string( c ) );
   end Retrieve;


   --
   -- Retrieves a list of basec201_Data.tGrande_Finale retrived by the sql string, or throws an exception
   --
   function Retrieve( sqlstr : String ) return basec201_Data.Grande_Finale_List.Vector is
      type Timestamp_Access is access all SQL_TIMESTAMP_STRUCT;
      type Real_Access is access all Real;
      type String_Access is access all String;

      l : basec201_Data.Grande_Finale_List.Vector;
      ps : SQLHDBC := SQL_NULL_HANDLE;
      has_data : Boolean := false;
      connection : dodbc.Database_Connection := get_connection;
      query : constant String := SELECT_PART & " " & sqlstr;
      --
      -- aliased local versions of fields
      --
      Id_Finale: aliased integer;
      Date: aliased SQL_TIMESTAMP_STRUCT;
      Prix_Place: aliased integer;
      Gagnant_Finale: aliased String :=
            "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@" &
            "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@";
      --
      -- access variables for any variables retrieved via access types
      --
      Date_access : Timestamp_Access := Date'access;
      Gagnant_Finale_access : String_Access := Gagnant_Finale'access;
      --
      -- length holders for each retrieved variable
      --
      Id_Finale_len : aliased SQLINTEGER := Id_Finale'Size;
      Date_len : aliased SQLINTEGER := Date'Size;
      Prix_Place_len : aliased SQLINTEGER := Prix_Place'Size;
      Gagnant_Finale_len : aliased SQLINTEGER := Gagnant_Finale'Size;
      Grande_Finale : basec201_Data.tGrande_Finale;
   begin
      logger.info( "retrieve made this as query " & query );
      begin -- exception block
         ps := dodbc.Initialise_Prepared_Statement( connection.connection, query );
         dodbc.I_Out_Binding.SQLBindCol(
            StatementHandle  => ps,
            ColumnNumber     => 1,
            TargetValue      => Id_Finale'access,
            IndPtr           => Id_Finale_len'access );
         SQLBindCol(
            StatementHandle  => ps,
            TargetType       => SQL_C_TYPE_TIMESTAMP,
            ColumnNumber     => 2,
            TargetValuePtr   => To_SQLPOINTER( Date_access.all'address ),
            BufferLength     => 0,
            StrLen_Or_IndPtr => Date_len'access );
         dodbc.I_Out_Binding.SQLBindCol(
            StatementHandle  => ps,
            ColumnNumber     => 3,
            TargetValue      => Prix_Place'access,
            IndPtr           => Prix_Place_len'access );
          SQLBindCol(
            StatementHandle  => ps,
            ColumnNumber     => 4,
            TargetType       => SQL_C_CHAR,
            TargetValuePtr   => To_SQLPOINTER( Gagnant_Finale_access.all'address ),
            BufferLength     => Gagnant_Finale_len,
            StrLen_Or_IndPtr => Gagnant_Finale_len'access );
         SQLExecute( ps );
         loop
            dodbc.next_row( ps, has_data );
            if( not has_data ) then
               exit;
            end if;
            Grande_Finale.Id_Finale := Id_Finale;
            Grande_Finale.Date:= dodbc.Timestamp_To_Ada_Time( Date_access.all );
            Grande_Finale.Prix_Place := Prix_Place;
            Grande_Finale.Gagnant_Finale := Slice_To_Unbounded( Gagnant_Finale, 1, Natural( Gagnant_Finale_len ) );

            basec201_Data.Grande_Finale_List.append( l, Grande_Finale );
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
   procedure Update( Grande_Finale : basec201_Data.tGrande_Finale ) is
      ps : sql.SQLHDBC := sql.SQL_NULL_HANDLE;
      connection : dodbc.Database_Connection := get_connection;
      query : Unbounded_String := UPDATE_PART & To_Unbounded_String(" ");
      pk_c : d.Criteria;
      values_c : d.Criteria;
   begin
      --
      -- values to be updated
      --
      Add_Date( values_c, Grande_Finale.Date );
      Add_Prix_Place( values_c, Grande_Finale.Prix_Place );
      Add_Gagnant_Finale( values_c, Grande_Finale.Gagnant_Finale );
      --
      -- primary key fields
      --
      Add_Id_Finale( pk_c, Grande_Finale.Id_Finale );
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
   procedure Save( Grande_Finale : basec201_Data.tGrande_Finale; overwrite : Boolean := True ) is
      ps : sql.SQLHDBC := sql.SQL_NULL_HANDLE;
      connection : dodbc.Database_Connection;
      query : Unbounded_String := INSERT_PART & To_Unbounded_String(" ");
      c : d.Criteria;
      Grande_Finale_Tmp : basec201_Data.tGrande_Finale;
   begin
      if( overwrite ) then
         Grande_Finale_Tmp := retrieve_By_PK( Grande_Finale.Id_Finale );
         if( not is_Null( Grande_Finale_Tmp )) then
            Update( Grande_Finale );
            return;
         end if;
      end if;
      Add_Id_Finale( c, Grande_Finale.Id_Finale );
      Add_Date( c, Grande_Finale.Date );
      Add_Prix_Place( c, Grande_Finale.Prix_Place );

      query := query & "( "  & d.To_Crude_Array_Of_Values( c ) ;
      if Grande_Finale.Gagnant_Finale= Ada.Strings.Unbounded.Null_Unbounded_String
      then
		query := query & ",null";
      else
		query := query & ",'" & Grande_Finale.Gagnant_Finale &"'";end if;
      query := query & ")";
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
   -- Delete the given record. Throws DB_Exception exception. Sets value to basec201_Data.Null_Grande_Finale
   --

   procedure Delete( Grande_Finale : in out basec201_Data.tGrande_Finale ) is
         c : d.Criteria;
   begin
      Add_Id_Finale( c, Grande_Finale.Id_Finale );
      delete( c );
      Grande_Finale := basec201_Data.Null_Grande_Finale;
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

   --
   -- functions to add something to a criteria
   --
   procedure Add_Id_Finale( c : in out d.Criteria; Id_Finale : integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is
   elem : d.Criterion := d.make_Criterion_Element( "id_finale", op, join, Id_Finale );
   begin
      d.add_to_criteria( c, elem );
   end Add_Id_Finale;


   procedure Add_Date( c : in out d.Criteria; Date : Ada.Calendar.Time; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is
   elem : d.Criterion := d.make_Criterion_Element( "date", op, join, Date );
   begin
      d.add_to_criteria( c, elem );
   end Add_Date;


   procedure Add_Prix_Place( c : in out d.Criteria; Prix_Place : integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is
   elem : d.Criterion := d.make_Criterion_Element( "prix_place", op, join, Prix_Place );
   begin
      d.add_to_criteria( c, elem );
   end Add_Prix_Place;


   procedure Add_Gagnant_Finale( c : in out d.Criteria; Gagnant_Finale : Unbounded_String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is
   elem : d.Criterion := d.make_Criterion_Element( "gagnant_finale", op, join, To_String( Gagnant_Finale ), 100 );
   begin
      d.add_to_criteria( c, elem );
   end Add_Gagnant_Finale;


   procedure Add_Gagnant_Finale( c : in out d.Criteria; Gagnant_Finale : String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is
   elem : d.Criterion := d.make_Criterion_Element( "gagnant_finale", op, join, Gagnant_Finale, 100 );
   begin
      d.add_to_criteria( c, elem );
   end Add_Gagnant_Finale;



   --
   -- functions to add an ordering to a criteria
   --
   procedure Add_Id_Finale_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is
   elem : d.Order_By_Element := d.Make_Order_By_Element( "id_finale", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Id_Finale_To_Orderings;


   procedure Add_Date_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is
   elem : d.Order_By_Element := d.Make_Order_By_Element( "date", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Date_To_Orderings;


   procedure Add_Prix_Place_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is
   elem : d.Order_By_Element := d.Make_Order_By_Element( "prix_place", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Prix_Place_To_Orderings;


   procedure Add_Gagnant_Finale_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is
   elem : d.Order_By_Element := d.Make_Order_By_Element( "gagnant_finale", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Gagnant_Finale_To_Orderings;



end Grande_Finale_IO;
