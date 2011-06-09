with Ada.Calendar;use Ada.Calendar;
with Ada.Containers.Vectors;
with Ada.Exceptions;use Ada.Exceptions;
with Ada.Strings.Unbounded;use Ada.Strings.Unbounded;

with AUnit.Assertions;use AUnit.Assertions;
with AUnit.Test_Cases.Registration;use AUnit.Test_Cases.Registration;
with AUnit.Test_Results ; use AUnit.Test_Results ;

with logger;
with base_types;use base_types;
with environment;
with db_commons.odbc;
with db_commons;use db_commons;
with Basec201_Data;use Basec201_Data;

with Ville_io;use ville_io;
with groupe_io;
with festival_io;
with jour_festival_io;
with    p_appli_enreggroupe; use    p_appli_enreggroupe;

package body my_Test2 is

-- test sur les groupes



procedure Groupe_Ajout_Test_Normal(  T : in out AUnit.Test_Cases.Test_Case'Class ) is

Nom,Contact,Coord,Site : Unbounded_String;
genre : string(1..4);
ordre,jour : positive;

begin
   Logger.info( "** Starting test Groupe_ajout cas normal" );

   Nom := To_Unbounded_String("groupe 4");
   Contact := To_Unbounded_String("Contact 1");
   Coord :=  To_Unbounded_String("Contact 1");
   Site := To_Unbounded_String("Contact 1");
   genre := "Hard";
   ordre := 1;
   jour:=1;
   p_appli_enreggroupe.SaveGroupe (Nom,Contact,Coord,Site,genre,ordre,jour);

   assert (not groupe_io.is_null(groupe_io.Retrieve_by_pk(To_Unbounded_String("groupe 4" ))), "le groupe n'a pas été insérée");

   exception
         when EXGroupeExistant => assert (false, "exception levée à tord");
end Groupe_Ajout_Test_Normal;
------------------------------
procedure Groupe_ajout_Test_doublon(  T : in out AUnit.Test_Cases.Test_Case'Class ) is

Nom,Contact,Coord,Site : Unbounded_String;
genre : string(1..4);
ordre,jour : positive;
c  : d.Criteria;

begin
  Logger.info( "** Starting test Ville_ajout cas_doublon" );

   Nom := To_Unbounded_String("groupe 1");
   Contact := To_Unbounded_String("Contact 1");
   Coord :=  To_Unbounded_String("Contact 1");
   Site := To_Unbounded_String("Contact 1");
   genre := "Hard";
   ordre := 1;
   jour:=1;
   p_appli_enreggroupe.SaveGroupe (Nom,Contact,Coord,Site,genre,ordre,jour);

  assert (false, "cas de doublon non pris en compte");

  exception
         when EXGroupeExistant => assert (true, "exception de doublon non levée ");

end Groupe_ajout_Test_doublon;
----------------------------

procedure Groupe_recherche_Test(  T : in out AUnit.Test_Cases.Test_Case'Class ) is

festival:tfestival;

begin
festival.id_festival:=1;
  Logger.info( "** Starting test Ville_ajout cas_doublon" );


  assert (p_appli_enreggroupe.GetGroupesJour(festival,1).first_element.nom_groupe="groupe 1", "Resultat erroné");


end Groupe_recherche_Test;
----------------------
procedure Register_Tests (T : in out Test_Case) is
begin

  Register_Routine (T, Groupe_Ajout_Test_Normal'Access, "Test d'ajout d'un Groupe cas normal" );
  Register_Routine (T, Groupe_ajout_Test_doublon'Access, "Test d'ajout d'un Groupe cas erroné" );
  Register_Routine (T, Groupe_recherche_Test'Access, "Test de recherche de groupe" );
end Register_Tests;

--  Register routines to be run

function Name ( t : Test_Case ) return String_Access is
begin
    return new String'( "my_Test2 Test Suite" );
end Name;

--  Preparation performed before each routine:
procedure Set_Up( t : in out Test_Case ) is
c: db_commons.criteria;
groupe : tgroupe;
ville:tville;
festival:tfestival;
jour_festival:tjour_festival;
begin
   Logger.info( "** Starting test groupe_Test" );
   Logger.info( "** Clearing out the table" );
   ville_io.delete(c);
   groupe_io.Delete( c );
   festival_io.delete(c);
   jour_festival_io.delete(c);
   Logger.info( "** Groupe_Test: initialisation des données" );

   for i in 1 ..3 loop
         Ville.Nom_Ville := To_Unbounded_String( "grenoble" & i'img );
         Ville.Mel_Contact := To_Unbounded_String("gre@free.fr");
         Ville_io.Save( Ville, False );
   end loop;
   for i in 1 ..3 loop
       	Festival.Id_festival := i;
       	Festival.Ville_festival:= To_Unbounded_String( "grenoble" & i'img );
        festival_io.Save( festival, False );
   end loop;
   for i in 1 ..3 loop
       	Jour_Festival.Id_Jour_Festival := i;
       	Jour_Festival.festival:= i;
       	Jour_festival.num_ordre:=1;
        Jour_festival_io.Save( jour_festival, False );
   end loop;
   for i in 1 ..3 loop
         groupe.Nom_groupe:= To_Unbounded_String( "groupe" & i'img );
         groupe.Jour_festival:=i;
         groupe_io.Save( groupe, False );
    end loop;

end Set_Up;

--  Preparation performed before each routine:
procedure Shut_Down( t : in out Test_Case ) is
c: db_commons.criteria;
begin
      Groupe_io.Delete( c );
      jour_festival_io.delete(c);      
      festival_io.delete(c);
      ville_io.delete(c);
end Shut_Down;

end my_Test2;
