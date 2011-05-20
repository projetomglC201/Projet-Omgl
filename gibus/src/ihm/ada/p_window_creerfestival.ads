--with tp_Intl; use tp_Intl;
with Glade.XML;use Glade.XML;
with System; use System;
with Gtk.Main;
with Gtkada.Dialogs;use Gtkada.Dialogs;

-- pour gérer les composants de la fenetre
with Gtk.Window; use Gtk.Window;
with Gtk.Button; use Gtk.Button;
with Gtk.Gentry; use Gtk.Gentry;
with Gtk.Tree_View; use Gtk.Tree_View;
with Gtk.Label; use Gtk.Label;
with Gtk.Scrolled_Window; use Gtk.Scrolled_Window; 
with Gtk.combo_box; use Gtk.combo_box;
with Gtk.calendar; Use Gtk.calendar;


with p_appli_creerfestival; use p_appli_creerfestival;
with Basec201_Data; use basec201_data;
with Ada.Containers.Vectors;
with p_conversion; use p_conversion;

with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

package P_window_creerfestival is
  procedure init;
  procedure fermerFenetre;
  procedure validerfestival;
end P_window_creerfestival;
