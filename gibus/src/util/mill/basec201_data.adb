--
-- Created by ada_generator.py on 2011-05-13 13:55:53.634578
-- 

with GNAT.Calendar.Time_IO;

package body Basec201_Data is

   use ada.strings.Unbounded;
   package tio renames GNAT.Calendar.Time_IO;

   function To_String( rec : tGrande_Finale ) return String is
   begin
      return  "Grande_Finale: " &
         "Id_Finale = " & rec.Id_Finale'Img &
         "Date = " & tio.Image( rec.Date, tio.ISO_Date ) &
         "Prix_Place = " & rec.Prix_Place'Img &
         "Gagnant_Finale = " & To_String( rec.Gagnant_Finale );
   end to_String;



   function To_String( rec : tGagnant_Festival ) return String is
   begin
      return  "Gagnant_Festival: " &
         "Id_Gagnant_Festival = " & rec.Id_Gagnant_Festival'Img &
         "Festival = " & rec.Festival'Img &
         "Groupe = " & To_String( rec.Groupe );
   end to_String;



   function To_String( rec : tGroupe ) return String is
   begin
      return  "Groupe: " &
         "Nom_Groupe = " & To_String( rec.Nom_Groupe ) &
         "Jour_Festival = " & rec.Jour_Festival'Img &
         "Nom_Contact = " & To_String( rec.Nom_Contact ) &
         "Coord_Contact = " & To_String( rec.Coord_Contact ) &
         "Adr_Site = " & To_String( rec.Adr_Site ) &
         "Ordre_Passage = " & rec.Ordre_Passage'Img &
         "Genre = " & rec.Genre'Img;
   end to_String;



   function To_String( rec : tJour_Festival ) return String is
   begin
      return  "Jour_Festival: " &
         "Id_Jour_Festival = " & rec.Id_Jour_Festival'Img &
         "Festival = " & rec.Festival'Img &
         "Num_Ordre = " & rec.Num_Ordre'Img &
         "Nbre_Concert_Max = " & rec.Nbre_Concert_Max'Img &
         "Heure_Debut = " & rec.Heure_Debut'Img;
   end to_String;



   function To_String( rec : tFestival ) return String is
   begin
      return  "Festival: " &
         "Id_Festival = " & rec.Id_Festival'Img &
         "Ville_Festival = " & To_String( rec.Ville_Festival ) &
         "Date = " & tio.Image( rec.Date, tio.ISO_Date ) &
         "Lieu = " & To_String( rec.Lieu ) &
         "Prix_Place = " & rec.Prix_Place'Img;
   end to_String;



   function To_String( rec : tVille ) return String is
   begin
      return  "Ville: " &
         "Nom_Ville = " & To_String( rec.Nom_Ville ) &
         "Mel_Contact = " & To_String( rec.Mel_Contact );
   end to_String;



        

end Basec201_Data;
