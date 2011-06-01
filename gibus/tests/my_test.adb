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
with p_appli_enregville; use p_appli_enregville;

package body my_Test is

-- test sur les villes

procedure Ville_ajout_Test_normal(  T : in out AUnit.Test_Cases.Test_Case'Class ) is

Ville : tVille;
c  : d.Criteria;

begin
   Logger.info( "** Starting test Ville_ajout cas normal" );

   Ville.Nom_Ville := To_Unbounded_String("grenoble 4");
   Ville.Mel_Contact := To_Unbounded_String("gre@free.fr");
   p_appli_enregville.CreateVille (ville.Nom_Ville,Ville.Mel_Contact);

   assert (not ville_io.is_null(Ville_Io.Retrieve_by_pk(To_Unbounded_String("grenoble 4" ))), "la ville n'a pas été insérée");

   exception
         when EXVilleExistante => assert (false, "exception levée à tord");

end Ville_ajout_Test_normal;

procedure Ville_ajout_Test_doublon(  T : in out AUnit.Test_Cases.Test_Case'Class ) is

Ville : tVille;
c  : d.Criteria;

begin
  Logger.info( "** Starting test Ville_ajout cas_doublon" );

  Ville.Nom_Ville := To_Unbounded_String("grenoble 2");
  Ville.Mel_Contact := To_Unbounded_String("gre@free.fr");
  p_appli_enregville.CreateVille (ville.Nom_Ville,Ville.Mel_Contact) ;

  assert (false, "cas de doublon non pris en compte");

  exception
         when EXVilleExistante => assert (true, "exception de doublon non levée ");

end Ville_ajout_Test_doublon;

--procedure Ville_supp_Test(  T : in out AUnit.Test_Cases.Test_Case'Class ) is
--      --
--Ville : tVille;
--c  : d.Criteria;

--begin
--  Logger.info( "** Starting test Ville_suppression" );

--  Ville.Nom_Ville := To_Unbounded_String("grenoble 4");
--  Ville.Mel_Contact := To_Unbounded_String("gre@free.fr");
--  p_appli_enregville.supprimer_ville (ville) ;

--  assert (is_null(Ville_Io.Retrieve_by_pk(To_Unbounded_String("grenoble 2" ))), "la ville n'a pas été supprimée");

--  exception
--          when exvilleexiste => assert (false, "exception levée à tord");

--end Ville_supp_Test;


procedure Register_Tests (T : in out Test_Case) is
begin
  Register_Routine (T, Ville_ajout_Test_normal'Access, "Test d'ajout d'une Ville cas normal" );
  Register_Routine (T, Ville_ajout_Test_doublon'Access, "Test d'ajout d'une Ville cas doublon" );
--  Register_Routine (T, Ville_supp_Test'Access, "Test de suppression d'une Ville " );

end Register_Tests;

--  Register routines to be run

function Name ( t : Test_Case ) return String_Access is
begin
    return new String'( "my_Test Test Suite" );
end Name;

--  Preparation performed before each routine:
procedure Set_Up( t : in out Test_Case ) is
c: db_commons.criteria;
Ville : tVille;

begin
   Logger.info( "** Starting test Ville_Test" );
   Logger.info( "** Clearing out the table" );
   Ville_io.Delete( c );

   Logger.info( "** Ville_Test: initialisation des données" );
   for i in 1 ..3 loop
         Ville.Nom_Ville := To_Unbounded_String( "grenoble" & i'img );
         Ville.Mel_Contact := To_Unbounded_String("gre@free.fr");
         Ville_io.Save( Ville, False );
    end loop;

end Set_Up;

--  Preparation performed before each routine:
procedure Shut_Down( t : in out Test_Case ) is
begin
      Null;
end Shut_Down;

end my_Test;
