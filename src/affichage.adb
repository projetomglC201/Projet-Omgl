
with Gtk.Main;
-- module de gestion de la fenêtre
with p_window_consultgroupe;
with p_window_consulterfestival;
with p_window_creerfestival;
with p_window_enregville;
with p_window_progfestival;
with p_window_consultprogramme;
with p_window_enreggroupe;
with p_window_menu;
 
procedure affichage is
 
begin
-- initialisation de variables d'environnement
   Gtk.Main.Set_Locale;
-- Initialisation de Gtk
   Gtk.Main.Init;
-- chargement de la description de la fenêtre principale et affichage
   p_window_menu.init;

--   p_window_consultgroupe.init;

--   p_window_consulterfestival.init;

--   p_window_creerfestival.init;

--   p_window_enregville.init;
--   
--   p_window_progfestival.init;
--   
--   p_window_consultprogramme.init;   
--   
--   p_window_enreggroupe.init;
   
--Lancement de la boucle évènementielle de Gtk
   Gtk.Main.Main;
end affichage;
