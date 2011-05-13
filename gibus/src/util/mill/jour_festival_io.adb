--
-- Created by ada_generator.py on 2011-05-13 13:55:53.975312
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

with Groupe_IO;

with Logger;

package body Jour_Festival_IO is

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
         "id_jour_festival, festival, num_ordre, nbre_concert_max, heure_debut " &
         "from jour_festival " ;
   
   --
   -- Insert all variables; substring to be competed with output from some criteria
   --
   INSERT_PART : constant String := "insert into jour_festival (" &
         "id_jour_festival, festival, num_ordre, nbre_concert_max, heure_debut " &
         " ) values " ;

   
   --
   -- delete all the records identified by the where SQL clause 
   --
   DELETE_PART : constant String := "delete from jour_festival ";
   
   --
   -- update
   --
   UPDATE_PART : constant String := "update jour_festival set  ";
   
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
   -- Next highest avaiable value of Id_Jour_Festival - useful for saving  
   --
   function Next_Free_Id_Jour_Festival return integer is
      ps : sql.SQLHDBC := sql.SQL_NULL_HANDLE;
      connection : dodbc.Database_Connection := get_connection;
      query : constant String := "select max( id_jour_festival ) from jour_festival";
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
   end Next_Free_Id_Jour_Festival;



   --
   -- returns true if the primary key parts of Jour_Festival match the defaults in Basec201_Data.Null_Jour_Festival
   --
   --
   -- Does this Jour_Festival equal the default Basec201_Data.Null_Jour_Festival ?
   --
   function Is_Null( Jour_Festival : Basec201_Data.tJour_Festival ) return Boolean is
   use Basec201_Data;
   begin
      return Jour_Festival = Basec201_Data.Null_Jour_Festival;
   end Is_Null;


   
   --
   -- returns true if the container is empty
   --
   --
   -- Does this Jour_Festival_List empty ?
   --
   function Is_Empty( Jour_Festival_Liste : Basec201_Data.Jour_Festival_List.Vector ) return Boolean is
   use Basec201_Data;
   begin
      return Jour_Festival_List.Is_Empty(Jour_Festival_Liste);
   end Is_Empty;



   --
   -- returns number of items of the container 
   --
   --
   -- return number of elements of Jour_Festival_List
   --
   function Card( Jour_Festival_Liste : Basec201_Data.Jour_Festival_List.Vector ) return Count_Type is
   use Basec201_Data;
   begin
      return Jour_Festival_List.Length(Jour_Festival_Liste);
   end Card;



   --
   -- returns the single Jour_Festival matching the primary key fields, or the Basec201_Data.Null_Jour_Festival record
   -- if no such record exists
   --
   function Retrieve_By_PK( Id_Jour_Festival : integer ) return Basec201_Data.tJour_Festival is
      l : Basec201_Data.Jour_Festival_List.Vector;
      Jour_Festival : Basec201_Data.tJour_Festival;
      c : d.Criteria;
   begin      
      Add_Id_Jour_Festival( c, Id_Jour_Festival );
      l := retrieve( c );
      if( not Basec201_Data.Jour_Festival_List.is_empty( l ) ) then
         Jour_Festival := Basec201_Data.Jour_Festival_List.First_Element( l );
      else
         Jour_Festival := Basec201_Data.Null_Jour_Festival;
      end if;
      return Jour_Festival;
   end Retrieve_By_PK;

   
   --
   -- Retrieves a list of Basec201_Data.tJour_Festival matching the criteria, or throws an exception
   --
   function Retrieve( c : d.Criteria ) return Basec201_Data.Jour_Festival_List.Vector is
   begin      
      return Retrieve( d.to_string( c ) );
   end Retrieve;

   
   --
   -- Retrieves a list of Basec201_Data.tJour_Festival retrived by the sql string, or throws an exception
   --
   function Retrieve( sqlstr : String ) return Basec201_Data.Jour_Festival_List.Vector is
      type Timestamp_Access is access all SQL_TIMESTAMP_STRUCT;
      type Real_Access is access all Real;
      type String_Access is access all String;

      l : Basec201_Data.Jour_Festival_List.Vector;
      ps : SQLHDBC := SQL_NULL_HANDLE;
      has_data : Boolean := false;
      connection : dodbc.Database_Connection := get_connection;
      query : constant String := SELECT_PART & " " & sqlstr;
      --
      -- aliased local versions of fields 
      --
      Id_Jour_Festival: aliased integer;
      Festival: aliased integer;
      Num_Ordre: aliased integer;
      Nbre_Concert_Max: aliased integer;
      Heure_Debut: aliased integer;
      --
      -- access variables for any variables retrieved via access types
      --
      --
      -- length holders for each retrieved variable
      --
      Id_Jour_Festival_len : aliased SQLINTEGER := Id_Jour_Festival'Size;
      Festival_len : aliased SQLINTEGER := Festival'Size;
      Num_Ordre_len : aliased SQLINTEGER := Num_Ordre'Size;
      Nbre_Concert_Max_len : aliased SQLINTEGER := Nbre_Concert_Max'Size;
      Heure_Debut_len : aliased SQLINTEGER := Heure_Debut'Size;
      Jour_Festival : Basec201_Data.tJour_Festival;
   begin
      logger.info( "retrieve made this as query " & query );
      begin -- exception block
         ps := dodbc.Initialise_Prepared_Statement( connection.connection, query );       
         dodbc.I_Out_Binding.SQLBindCol(
            StatementHandle  => ps,
            ColumnNumber     => 1,
            TargetValue      => Id_Jour_Festival'access,
            IndPtr           => Id_Jour_Festival_len'access );
         dodbc.I_Out_Binding.SQLBindCol(
            StatementHandle  => ps,
            ColumnNumber     => 2,
            TargetValue      => Festival'access,
            IndPtr           => Festival_len'access );
         dodbc.I_Out_Binding.SQLBindCol(
            StatementHandle  => ps,
            ColumnNumber     => 3,
            TargetValue      => Num_Ordre'access,
            IndPtr           => Num_Ordre_len'access );
         dodbc.I_Out_Binding.SQLBindCol(
            StatementHandle  => ps,
            ColumnNumber     => 4,
            TargetValue      => Nbre_Concert_Max'access,
            IndPtr           => Nbre_Concert_Max_len'access );
         dodbc.I_Out_Binding.SQLBindCol(
            StatementHandle  => ps,
            ColumnNumber     => 5,
            TargetValue      => Heure_Debut'access,
            IndPtr           => Heure_Debut_len'access );
         SQLExecute( ps );
         loop
            dodbc.next_row( ps, has_data );
            if( not has_data ) then
               exit;
            end if;
            Jour_Festival.Id_Jour_Festival := Id_Jour_Festival;
            Jour_Festival.Festival := Festival;
            Jour_Festival.Num_Ordre := Num_Ordre;
            Jour_Festival.Nbre_Concert_Max := Nbre_Concert_Max;
            Jour_Festival.Heure_Debut := Heure_Debut;
            Basec201_Data.Jour_Festival_List.append( l, Jour_Festival );        
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
   procedure Update( Jour_Festival : Basec201_Data.tJour_Festival ) is
      ps : sql.SQLHDBC := sql.SQL_NULL_HANDLE;
      connection : dodbc.Database_Connection := get_connection;
      query : Unbounded_String := UPDATE_PART & To_Unbounded_String(" ");
      pk_c : d.Criteria;
      values_c : d.Criteria;
   begin
      --
      -- values to be updated
      --
      Add_Festival( values_c, Jour_Festival.Festival );
      Add_Num_Ordre( values_c, Jour_Festival.Num_Ordre );
      Add_Nbre_Concert_Max( values_c, Jour_Festival.Nbre_Concert_Max );
      Add_Heure_Debut( values_c, Jour_Festival.Heure_Debut );
      --
      -- primary key fields
      --
      Add_Id_Jour_Festival( pk_c, Jour_Festival.Id_Jour_Festival );
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
   procedure Save( Jour_Festival : Basec201_Data.tJour_Festival; overwrite : Boolean := True ) is   
      ps : sql.SQLHDBC := sql.SQL_NULL_HANDLE;
      connection : dodbc.Database_Connection;
      query : Unbounded_String := INSERT_PART & To_Unbounded_String(" ");
      c : d.Criteria;
      Jour_Festival_Tmp : Basec201_Data.tJour_Festival;
   begin
      if( overwrite ) then
         Jour_Festival_Tmp := retrieve_By_PK( Jour_Festival.Id_Jour_Festival );
         if( not is_Null( Jour_Festival_Tmp )) then
            Update( Jour_Festival );
            return;
         end if;
      end if;
      Add_Id_Jour_Festival( c, Jour_Festival.Id_Jour_Festival );
      Add_Festival( c, Jour_Festival.Festival );
      Add_Num_Ordre( c, Jour_Festival.Num_Ordre );
      Add_Nbre_Concert_Max( c, Jour_Festival.Nbre_Concert_Max );
      Add_Heure_Debut( c, Jour_Festival.Heure_Debut );
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
   -- Delete the given record. Throws DB_Exception exception. Sets value to Basec201_Data.Null_Jour_Festival
   --

   procedure Delete( Jour_Festival : in out Basec201_Data.tJour_Festival ) is
         c : d.Criteria;
   begin  
      Add_Id_Jour_Festival( c, Jour_Festival.Id_Jour_Festival );
      delete( c );
      Jour_Festival := Basec201_Data.Null_Jour_Festival;
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
   function Retrieve_Associated_Groupes( Jour_Festival : Basec201_Data.tJour_Festival ) return Basec201_Data.Groupe_List.Vector is
      c : d.Criteria;
   begin
      Groupe_IO.Add_Jour_Festival( c, Jour_Festival.Id_Jour_Festival );
      return Groupe_IO.retrieve( c );
   end Retrieve_Associated_Groupes;



   --
   -- functions to add something to a criteria
   --
   procedure Add_Id_Jour_Festival( c : in out d.Criteria; Id_Jour_Festival : integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "id_jour_festival", op, join, Id_Jour_Festival );
   begin
      d.add_to_criteria( c, elem );
   end Add_Id_Jour_Festival;


   procedure Add_Festival( c : in out d.Criteria; Festival : integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "festival", op, join, Festival );
   begin
      d.add_to_criteria( c, elem );
   end Add_Festival;


   procedure Add_Num_Ordre( c : in out d.Criteria; Num_Ordre : integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "num_ordre", op, join, Num_Ordre );
   begin
      d.add_to_criteria( c, elem );
   end Add_Num_Ordre;


   procedure Add_Nbre_Concert_Max( c : in out d.Criteria; Nbre_Concert_Max : integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "nbre_concert_max", op, join, Nbre_Concert_Max );
   begin
      d.add_to_criteria( c, elem );
   end Add_Nbre_Concert_Max;


   procedure Add_Heure_Debut( c : in out d.Criteria; Heure_Debut : integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.make_Criterion_Element( "heure_debut", op, join, Heure_Debut );
   begin
      d.add_to_criteria( c, elem );
   end Add_Heure_Debut;


   
   --
   -- functions to add an ordering to a criteria
   --
   procedure Add_Id_Jour_Festival_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "id_jour_festival", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Id_Jour_Festival_To_Orderings;


   procedure Add_Festival_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "festival", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Festival_To_Orderings;


   procedure Add_Num_Ordre_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "num_ordre", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Num_Ordre_To_Orderings;


   procedure Add_Nbre_Concert_Max_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "nbre_concert_max", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Nbre_Concert_Max_To_Orderings;


   procedure Add_Heure_Debut_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "heure_debut", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_Heure_Debut_To_Orderings;


   
end Jour_Festival_IO;
