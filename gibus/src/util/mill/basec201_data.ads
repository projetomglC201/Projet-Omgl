--
-- Created by ada_generator.py on 2011-05-13 13:55:53.614170
-- 
with Ada.Containers.Vectors;
--
-- FIXME: may not be needed
--
with Ada.Calendar;

with base_types; use base_types;

with Ada.Strings.Unbounded;

package Basec201_Data is

   use Ada.Strings.Unbounded;

      --
      -- record modelling grande_finale : La Grande Finale des Festivals
      --
      type tGrande_Finale is record
         Id_Finale : integer := MISSING_I_KEY;
         Date : Ada.Calendar.Time := FIRST_DATE;
         Prix_Place : integer := 0;
         Gagnant_Finale : Unbounded_String := Ada.Strings.Unbounded.Null_Unbounded_String;
      end record;
      --
      -- container for grande_finale : La Grande Finale des Festivals
      --
      package Grande_Finale_List is new Ada.Containers.Vectors
         (Element_Type => tGrande_Finale,
         Index_Type => Positive );
      --
      -- default value for grande_finale : La Grande Finale des Festivals
      --
      Null_Grande_Finale : constant tGrande_Finale := (
         Id_Finale => MISSING_I_KEY,
         Date => FIRST_DATE,
         Prix_Place => 0,
         Gagnant_Finale => Ada.Strings.Unbounded.Null_Unbounded_String
      );
      --
      -- simple print routine for grande_finale : La Grande Finale des Festivals
      --
      function To_String( rec : tGrande_Finale ) return String;

      --
      -- record modelling gagnant_festival : Les gagnants des festivals
      --
      type tGagnant_Festival is record
         Id_Gagnant_Festival : integer := MISSING_I_KEY;
         Festival : integer := 0;
         Groupe : Unbounded_String := Ada.Strings.Unbounded.Null_Unbounded_String;
      end record;
      --
      -- container for gagnant_festival : Les gagnants des festivals
      --
      package Gagnant_Festival_List is new Ada.Containers.Vectors
         (Element_Type => tGagnant_Festival,
         Index_Type => Positive );
      --
      -- default value for gagnant_festival : Les gagnants des festivals
      --
      Null_Gagnant_Festival : constant tGagnant_Festival := (
         Id_Gagnant_Festival => MISSING_I_KEY,
         Festival => 0,
         Groupe => Ada.Strings.Unbounded.Null_Unbounded_String
      );
      --
      -- simple print routine for gagnant_festival : Les gagnants des festivals
      --
      function To_String( rec : tGagnant_Festival ) return String;

      --
      -- record modelling groupe : Les groupes
      --
      type tGroupe is record
         Nom_Groupe : Unbounded_String := MISSING_W_KEY;
         Jour_Festival : integer := 0;
         Nom_Contact : Unbounded_String := Ada.Strings.Unbounded.Null_Unbounded_String;
         Coord_Contact : Unbounded_String := Ada.Strings.Unbounded.Null_Unbounded_String;
         Adr_Site : Unbounded_String := Ada.Strings.Unbounded.Null_Unbounded_String;
         Ordre_Passage : integer := 0;
         Genre : tgenre_Enum := hard;
         Gagnant_Festivals : Gagnant_Festival_List.Vector;
         Grande_Finales : Grande_Finale_List.Vector;
      end record;
      --
      -- container for groupe : Les groupes
      --
      package Groupe_List is new Ada.Containers.Vectors
         (Element_Type => tGroupe,
         Index_Type => Positive );
      --
      -- default value for groupe : Les groupes
      --
      Null_Groupe : constant tGroupe := (
         Nom_Groupe => MISSING_W_KEY,
         Jour_Festival => 0,
         Nom_Contact => Ada.Strings.Unbounded.Null_Unbounded_String,
         Coord_Contact => Ada.Strings.Unbounded.Null_Unbounded_String,
         Adr_Site => Ada.Strings.Unbounded.Null_Unbounded_String,
         Ordre_Passage => 0,
         Genre => hard,
         Gagnant_Festivals => Gagnant_Festival_List.Empty_Vector,
         Grande_Finales => Grande_Finale_List.Empty_Vector
      );
      --
      -- simple print routine for groupe : Les groupes
      --
      function To_String( rec : tGroupe ) return String;

      --
      -- record modelling jour_festival : Les journees des festivals
      --
      type tJour_Festival is record
         Id_Jour_Festival : integer := MISSING_I_KEY;
         Festival : integer := 0;
         Num_Ordre : integer := 0;
         Nbre_Concert_Max : integer := 0;
         Heure_Debut : integer := 0;
         Groupes : Groupe_List.Vector;
      end record;
      --
      -- container for jour_festival : Les journees des festivals
      --
      package Jour_Festival_List is new Ada.Containers.Vectors
         (Element_Type => tJour_Festival,
         Index_Type => Positive );
      --
      -- default value for jour_festival : Les journees des festivals
      --
      Null_Jour_Festival : constant tJour_Festival := (
         Id_Jour_Festival => MISSING_I_KEY,
         Festival => 0,
         Num_Ordre => 0,
         Nbre_Concert_Max => 0,
         Heure_Debut => 0,
         Groupes => Groupe_List.Empty_Vector
      );
      --
      -- simple print routine for jour_festival : Les journees des festivals
      --
      function To_String( rec : tJour_Festival ) return String;

      --
      -- record modelling festival : Les festivals
      --
      type tFestival is record
         Id_Festival : integer := MISSING_I_KEY;
         Ville_Festival : Unbounded_String := Ada.Strings.Unbounded.Null_Unbounded_String;
         Date : Ada.Calendar.Time := FIRST_DATE;
         Lieu : Unbounded_String := Ada.Strings.Unbounded.Null_Unbounded_String;
         Prix_Place : integer := 0;
         Jour_Festivals : Jour_Festival_List.Vector;
         Gagnant_Festivals : Gagnant_Festival_List.Vector;
      end record;
      --
      -- container for festival : Les festivals
      --
      package Festival_List is new Ada.Containers.Vectors
         (Element_Type => tFestival,
         Index_Type => Positive );
      --
      -- default value for festival : Les festivals
      --
      Null_Festival : constant tFestival := (
         Id_Festival => MISSING_I_KEY,
         Ville_Festival => Ada.Strings.Unbounded.Null_Unbounded_String,
         Date => FIRST_DATE,
         Lieu => Ada.Strings.Unbounded.Null_Unbounded_String,
         Prix_Place => 0,
         Jour_Festivals => Jour_Festival_List.Empty_Vector,
         Gagnant_Festivals => Gagnant_Festival_List.Empty_Vector
      );
      --
      -- simple print routine for festival : Les festivals
      --
      function To_String( rec : tFestival ) return String;

      --
      -- record modelling ville : Les villes
      --
      type tVille is record
         Nom_Ville : Unbounded_String := MISSING_W_KEY;
         Mel_Contact : Unbounded_String := Ada.Strings.Unbounded.Null_Unbounded_String;
         Festivals : Festival_List.Vector;
      end record;
      --
      -- container for ville : Les villes
      --
      package Ville_List is new Ada.Containers.Vectors
         (Element_Type => tVille,
         Index_Type => Positive );
      --
      -- default value for ville : Les villes
      --
      Null_Ville : constant tVille := (
         Nom_Ville => MISSING_W_KEY,
         Mel_Contact => Ada.Strings.Unbounded.Null_Unbounded_String,
         Festivals => Festival_List.Empty_Vector
      );
      --
      -- simple print routine for ville : Les villes
      --
      function To_String( rec : tVille ) return String;

        

end Basec201_Data;
