pragma Ada_95;
pragma Source_File_Name (ada_main, Spec_File_Name => "b~main.ads");
pragma Source_File_Name (ada_main, Body_File_Name => "b~main.adb");

with System.Restrictions;

package body ada_main is
   pragma Warnings (Off);

   procedure Do_Finalize;
   pragma Import (C, Do_Finalize, "system__standard_library__adafinal");

   Local_Priority_Specific_Dispatching : constant String := "";
   Local_Interrupt_States : constant String := "";

   procedure adainit is
      E022 : Boolean; pragma Import (Ada, E022, "system__secondary_stack_E");
      E018 : Boolean; pragma Import (Ada, E018, "system__soft_links_E");
      E028 : Boolean; pragma Import (Ada, E028, "system__exception_table_E");
      E266 : Boolean; pragma Import (Ada, E266, "ada__calendar_E");
      E073 : Boolean; pragma Import (Ada, E073, "ada__io_exceptions_E");
      E228 : Boolean; pragma Import (Ada, E228, "ada__strings_E");
      E060 : Boolean; pragma Import (Ada, E060, "ada__tags_E");
      E058 : Boolean; pragma Import (Ada, E058, "ada__streams_E");
      E010 : Boolean; pragma Import (Ada, E010, "interfaces__c_E");
      E278 : Boolean; pragma Import (Ada, E278, "gnat__calendar_E");
      E280 : Boolean; pragma Import (Ada, E280, "gnat__calendar__time_io_E");
      E051 : Boolean; pragma Import (Ada, E051, "interfaces__c__strings_E");
      E090 : Boolean; pragma Import (Ada, E090, "system__assertions_E");
      E057 : Boolean; pragma Import (Ada, E057, "system__finalization_root_E");
      E292 : Boolean; pragma Import (Ada, E292, "system__os_lib_E");
      E232 : Boolean; pragma Import (Ada, E232, "ada__strings__maps_E");
      E283 : Boolean; pragma Import (Ada, E283, "ada__strings__maps__constants_E");
      E068 : Boolean; pragma Import (Ada, E068, "system__finalization_implementation_E");
      E055 : Boolean; pragma Import (Ada, E055, "ada__finalization_E");
      E053 : Boolean; pragma Import (Ada, E053, "ada__finalization__list_controller_E");
      E270 : Boolean; pragma Import (Ada, E270, "ada__strings__unbounded_E");
      E361 : Boolean; pragma Import (Ada, E361, "ada__strings__wide_maps_E");
      E293 : Boolean; pragma Import (Ada, E293, "system__file_control_block_E");
      E355 : Boolean; pragma Import (Ada, E355, "ada__streams__stream_io_E");
      E290 : Boolean; pragma Import (Ada, E290, "system__file_io_E");
      E285 : Boolean; pragma Import (Ada, E285, "ada__text_io_E");
      E367 : Boolean; pragma Import (Ada, E367, "ada__text_io__editing_E");
      E303 : Boolean; pragma Import (Ada, E303, "base_types_E");
      E276 : Boolean; pragma Import (Ada, E276, "basec201_data_E");
      E365 : Boolean; pragma Import (Ada, E365, "db_commons_E");
      E399 : Boolean; pragma Import (Ada, E399, "environment_E");
      E357 : Boolean; pragma Import (Ada, E357, "festival_io_E");
      E401 : Boolean; pragma Import (Ada, E401, "gagnant_festival_io_E");
      E178 : Boolean; pragma Import (Ada, E178, "glade_E");
      E007 : Boolean; pragma Import (Ada, E007, "glib_E");
      E105 : Boolean; pragma Import (Ada, E105, "gdk__rectangle_E");
      E092 : Boolean; pragma Import (Ada, E092, "glib__glist_E");
      E113 : Boolean; pragma Import (Ada, E113, "gdk__visual_E");
      E094 : Boolean; pragma Import (Ada, E094, "glib__gslist_E");
      E374 : Boolean; pragma Import (Ada, E374, "gnu__db__sqlcli_E");
      E370 : Boolean; pragma Import (Ada, E370, "db_commons__odbc_E");
      E403 : Boolean; pragma Import (Ada, E403, "gnu__db__sqlcli__bind_E");
      E378 : Boolean; pragma Import (Ada, E378, "gnu__db__sqlcli__dispatch_E");
      E419 : Boolean; pragma Import (Ada, E419, "gnu__db__sqlcli__generic_attr__bitmap_attribute_E");
      E417 : Boolean; pragma Import (Ada, E417, "gnu__db__sqlcli__dispatch__a_bitmap_E");
      E383 : Boolean; pragma Import (Ada, E383, "gnu__db__sqlcli__generic_attr__boolean_attribute_E");
      E381 : Boolean; pragma Import (Ada, E381, "gnu__db__sqlcli__dispatch__a_boolean_E");
      E423 : Boolean; pragma Import (Ada, E423, "gnu__db__sqlcli__generic_attr__boolean_string_attribute_E");
      E421 : Boolean; pragma Import (Ada, E421, "gnu__db__sqlcli__dispatch__a_boolean_string_E");
      E427 : Boolean; pragma Import (Ada, E427, "gnu__db__sqlcli__generic_attr__context_attribute_E");
      E425 : Boolean; pragma Import (Ada, E425, "gnu__db__sqlcli__dispatch__a_context_E");
      E387 : Boolean; pragma Import (Ada, E387, "gnu__db__sqlcli__generic_attr__enumerated_attribute_E");
      E385 : Boolean; pragma Import (Ada, E385, "gnu__db__sqlcli__dispatch__a_enumerated_E");
      E433 : Boolean; pragma Import (Ada, E433, "gnu__db__sqlcli__generic_attr__pointer_attribute_E");
      E431 : Boolean; pragma Import (Ada, E431, "gnu__db__sqlcli__dispatch__a_pointer_E");
      E391 : Boolean; pragma Import (Ada, E391, "gnu__db__sqlcli__generic_attr__string_attribute_E");
      E389 : Boolean; pragma Import (Ada, E389, "gnu__db__sqlcli__dispatch__a_string_E");
      E395 : Boolean; pragma Import (Ada, E395, "gnu__db__sqlcli__generic_attr__unsigned_attribute_E");
      E393 : Boolean; pragma Import (Ada, E393, "gnu__db__sqlcli__dispatch__a_unsigned_E");
      E376 : Boolean; pragma Import (Ada, E376, "gnu__db__sqlcli__environment_attribute_E");
      E409 : Boolean; pragma Import (Ada, E409, "gnu__db__sqlcli__generic_attr__wide_string_attribute_E");
      E407 : Boolean; pragma Import (Ada, E407, "gnu__db__sqlcli__dispatch__a_wide_string_E");
      E405 : Boolean; pragma Import (Ada, E405, "gnu__db__sqlcli__connection_attribute_E");
      E429 : Boolean; pragma Import (Ada, E429, "gnu__db__sqlcli__statement_attribute_E");
      E413 : Boolean; pragma Import (Ada, E413, "gnu__db__sqlcli__info_E");
      E441 : Boolean; pragma Import (Ada, E441, "grande_finale_io_E");
      E439 : Boolean; pragma Import (Ada, E439, "groupe_io_E");
      E086 : Boolean; pragma Import (Ada, E086, "gtkada__c_E");
      E080 : Boolean; pragma Import (Ada, E080, "gtkada__bindings_E");
      E088 : Boolean; pragma Import (Ada, E088, "gtkada__types_E");
      E075 : Boolean; pragma Import (Ada, E075, "glib__object_E");
      E077 : Boolean; pragma Import (Ada, E077, "glib__type_conversion_hooks_E");
      E208 : Boolean; pragma Import (Ada, E208, "glib__types_E");
      E101 : Boolean; pragma Import (Ada, E101, "glib__values_E");
      E111 : Boolean; pragma Import (Ada, E111, "gdk__color_E");
      E158 : Boolean; pragma Import (Ada, E158, "gdk__cursor_E");
      E099 : Boolean; pragma Import (Ada, E099, "glib__generic_properties_E");
      E134 : Boolean; pragma Import (Ada, E134, "gdk__region_E");
      E103 : Boolean; pragma Import (Ada, E103, "gdk__event_E");
      E160 : Boolean; pragma Import (Ada, E160, "gdk__display_E");
      E107 : Boolean; pragma Import (Ada, E107, "gdk__window_E");
      E138 : Boolean; pragma Import (Ada, E138, "gdk__bitmap_E");
      E136 : Boolean; pragma Import (Ada, E136, "gdk__pixmap_E");
      E142 : Boolean; pragma Import (Ada, E142, "glib__properties_E");
      E221 : Boolean; pragma Import (Ada, E221, "gtk__cell_editable_E");
      E115 : Boolean; pragma Import (Ada, E115, "gtk__enums_E");
      E140 : Boolean; pragma Import (Ada, E140, "gtk__object_E");
      E168 : Boolean; pragma Import (Ada, E168, "gtk__accel_group_E");
      E174 : Boolean; pragma Import (Ada, E174, "gtk__adjustment_E");
      E192 : Boolean; pragma Import (Ada, E192, "gtk__tree_model_E");
      E214 : Boolean; pragma Import (Ada, E214, "gtk__tree_sortable_E");
      E182 : Boolean; pragma Import (Ada, E182, "gtk__type_conversion_E");
      E245 : Boolean; pragma Import (Ada, E245, "gtkada__pixmaps_E");
      E437 : Boolean; pragma Import (Ada, E437, "jour_festival_io_E");
      E435 : Boolean; pragma Import (Ada, E435, "logger_E");
      E453 : Boolean; pragma Import (Ada, E453, "p_conversion_E");
      E465 : Boolean; pragma Import (Ada, E465, "p_esiut_E");
      E128 : Boolean; pragma Import (Ada, E128, "pango__enums_E");
      E148 : Boolean; pragma Import (Ada, E148, "pango__attributes_E");
      E120 : Boolean; pragma Import (Ada, E120, "pango__font_E");
      E130 : Boolean; pragma Import (Ada, E130, "gdk__font_E");
      E132 : Boolean; pragma Import (Ada, E132, "gdk__gc_E");
      E150 : Boolean; pragma Import (Ada, E150, "pango__context_E");
      E152 : Boolean; pragma Import (Ada, E152, "pango__tabs_E");
      E146 : Boolean; pragma Import (Ada, E146, "pango__layout_E");
      E162 : Boolean; pragma Import (Ada, E162, "gdk__drawable_E");
      E164 : Boolean; pragma Import (Ada, E164, "gdk__rgb_E");
      E156 : Boolean; pragma Import (Ada, E156, "gdk__pixbuf_E");
      E117 : Boolean; pragma Import (Ada, E117, "gtk__style_E");
      E109 : Boolean; pragma Import (Ada, E109, "gtk__widget_E");
      E180 : Boolean; pragma Import (Ada, E180, "glade__xml_E");
      E443 : Boolean; pragma Import (Ada, E443, "gtk__calendar_E");
      E220 : Boolean; pragma Import (Ada, E220, "gtk__cell_renderer_E");
      E447 : Boolean; pragma Import (Ada, E447, "gtk__cell_layout_E");
      E257 : Boolean; pragma Import (Ada, E257, "gtk__cell_renderer_text_E");
      E172 : Boolean; pragma Import (Ada, E172, "gtk__container_E");
      E170 : Boolean; pragma Import (Ada, E170, "gtk__bin_E");
      E240 : Boolean; pragma Import (Ada, E240, "gtk__box_E");
      E184 : Boolean; pragma Import (Ada, E184, "gtk__button_E");
      E188 : Boolean; pragma Import (Ada, E188, "gtk__editable_E");
      E190 : Boolean; pragma Import (Ada, E190, "gtk__entry_completion_E");
      E186 : Boolean; pragma Import (Ada, E186, "gtk__gentry_E");
      E202 : Boolean; pragma Import (Ada, E202, "gtk__grange_E");
      E196 : Boolean; pragma Import (Ada, E196, "gtk__misc_E");
      E194 : Boolean; pragma Import (Ada, E194, "gtk__label_E");
      E200 : Boolean; pragma Import (Ada, E200, "gtk__scrollbar_E");
      E198 : Boolean; pragma Import (Ada, E198, "gtk__scrolled_window_E");
      E212 : Boolean; pragma Import (Ada, E212, "gtk__selection_E");
      E218 : Boolean; pragma Import (Ada, E218, "gdk__dnd_E");
      E225 : Boolean; pragma Import (Ada, E225, "gtk__tooltips_E");
      E210 : Boolean; pragma Import (Ada, E210, "gtk__tree_dnd_E");
      E204 : Boolean; pragma Import (Ada, E204, "gtk__tree_selection_E");
      E206 : Boolean; pragma Import (Ada, E206, "gtk__tree_store_E");
      E223 : Boolean; pragma Import (Ada, E223, "gtk__tree_view_column_E");
      E216 : Boolean; pragma Import (Ada, E216, "gtk__tree_view_E");
      E445 : Boolean; pragma Import (Ada, E445, "gtk__combo_box_E");
      E154 : Boolean; pragma Import (Ada, E154, "gtk__window_E");
      E253 : Boolean; pragma Import (Ada, E253, "gtk__dialog_E");
      E242 : Boolean; pragma Import (Ada, E242, "gtk__pixmap_E");
      E255 : Boolean; pragma Import (Ada, E255, "p_util_treeview_E");
      E176 : Boolean; pragma Import (Ada, E176, "p_window_consulterfestival_E");
      E259 : Boolean; pragma Import (Ada, E259, "p_window_consultgroupe_E");
      E262 : Boolean; pragma Import (Ada, E262, "p_window_consultprogramme_E");
      E457 : Boolean; pragma Import (Ada, E457, "p_window_enreggroupe_E");
      E469 : Boolean; pragma Import (Ada, E469, "p_window_progfestival_E");
      E451 : Boolean; pragma Import (Ada, E451, "ville_io_E");
      E449 : Boolean; pragma Import (Ada, E449, "p_appli_creerfestival_E");
      E461 : Boolean; pragma Import (Ada, E461, "p_appli_enregville_E");
      E467 : Boolean; pragma Import (Ada, E467, "p_appli_menu_E");
      E264 : Boolean; pragma Import (Ada, E264, "p_window_creerfestival_E");
      E459 : Boolean; pragma Import (Ada, E459, "p_window_enregville_E");
      E463 : Boolean; pragma Import (Ada, E463, "p_window_menu_E");

      Main_Priority : Integer;
      pragma Import (C, Main_Priority, "__gl_main_priority");
      Time_Slice_Value : Integer;
      pragma Import (C, Time_Slice_Value, "__gl_time_slice_val");
      WC_Encoding : Character;
      pragma Import (C, WC_Encoding, "__gl_wc_encoding");
      Locking_Policy : Character;
      pragma Import (C, Locking_Policy, "__gl_locking_policy");
      Queuing_Policy : Character;
      pragma Import (C, Queuing_Policy, "__gl_queuing_policy");
      Task_Dispatching_Policy : Character;
      pragma Import (C, Task_Dispatching_Policy, "__gl_task_dispatching_policy");
      Priority_Specific_Dispatching : System.Address;
      pragma Import (C, Priority_Specific_Dispatching, "__gl_priority_specific_dispatching");
      Num_Specific_Dispatching : Integer;
      pragma Import (C, Num_Specific_Dispatching, "__gl_num_specific_dispatching");
      Interrupt_States : System.Address;
      pragma Import (C, Interrupt_States, "__gl_interrupt_states");
      Num_Interrupt_States : Integer;
      pragma Import (C, Num_Interrupt_States, "__gl_num_interrupt_states");
      Unreserve_All_Interrupts : Integer;
      pragma Import (C, Unreserve_All_Interrupts, "__gl_unreserve_all_interrupts");
      Zero_Cost_Exceptions : Integer;
      pragma Import (C, Zero_Cost_Exceptions, "__gl_zero_cost_exceptions");
      Detect_Blocking : Integer;
      pragma Import (C, Detect_Blocking, "__gl_detect_blocking");
      Default_Stack_Size : Integer;
      pragma Import (C, Default_Stack_Size, "__gl_default_stack_size");
      Leap_Seconds_Support : Integer;
      pragma Import (C, Leap_Seconds_Support, "__gl_leap_seconds_support");

      procedure Install_Handler;
      pragma Import (C, Install_Handler, "__gnat_install_handler");

      Handler_Installed : Integer;
      pragma Import (C, Handler_Installed, "__gnat_handler_installed");
   begin
      Main_Priority := -1;
      Time_Slice_Value := -1;
      WC_Encoding := 'b';
      Locking_Policy := ' ';
      Queuing_Policy := ' ';
      Task_Dispatching_Policy := ' ';
      System.Restrictions.Run_Time_Restrictions :=
        (Set =>
          (False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, True, False, False, False, False, False, False, 
           False, False, False, False, False, False),
         Value => (0, 0, 0, 0, 0, 0, 0),
         Violated =>
          (False, False, True, True, False, True, True, True, 
           True, True, False, False, True, False, False, True, 
           True, False, True, True, True, True, True, True, 
           True, True, True, False, True, False, False, True, 
           False, False, True, False, False, False, True, False, 
           False, True, False, False, False, False, False, False, 
           False, False, True, True, True, False, False, True, 
           False, True, True, True, True, True, True, False, 
           False, False, False, False, False, False),
         Count => (0, 0, 0, 0, 0, 0, 0),
         Unknown => (False, False, False, False, False, False, False));
      Priority_Specific_Dispatching :=
        Local_Priority_Specific_Dispatching'Address;
      Num_Specific_Dispatching := 0;
      Interrupt_States := Local_Interrupt_States'Address;
      Num_Interrupt_States := 0;
      Unreserve_All_Interrupts := 0;
      Zero_Cost_Exceptions := 1;
      Detect_Blocking := 0;
      Default_Stack_Size := -1;
      Leap_Seconds_Support := 0;

      if Handler_Installed = 0 then
         Install_Handler;
      end if;

      System.Soft_Links'Elab_Body;
      E018 := True;
      System.Secondary_Stack'Elab_Body;
      E022 := True;
      System.Exception_Table'Elab_Body;
      E028 := True;
      Ada.Calendar'Elab_Spec;
      Ada.Calendar'Elab_Body;
      E266 := True;
      Ada.Io_Exceptions'Elab_Spec;
      E073 := True;
      Ada.Strings'Elab_Spec;
      E228 := True;
      Ada.Tags'Elab_Spec;
      Ada.Streams'Elab_Spec;
      E058 := True;
      Interfaces.C'Elab_Spec;
      E010 := True;
      Gnat.Calendar'Elab_Spec;
      E278 := True;
      Gnat.Calendar.Time_Io'Elab_Spec;
      Interfaces.C.Strings'Elab_Spec;
      E051 := True;
      System.Assertions'Elab_Spec;
      E090 := True;
      System.Finalization_Root'Elab_Spec;
      E057 := True;
      System.Os_Lib'Elab_Body;
      E292 := True;
      Ada.Strings.Maps'Elab_Spec;
      E232 := True;
      Ada.Strings.Maps.Constants'Elab_Spec;
      E283 := True;
      System.Finalization_Implementation'Elab_Spec;
      System.Finalization_Implementation'Elab_Body;
      E068 := True;
      Ada.Finalization'Elab_Spec;
      E055 := True;
      Ada.Finalization.List_Controller'Elab_Spec;
      E053 := True;
      Ada.Strings.Unbounded'Elab_Spec;
      E270 := True;
      Ada.Strings.Wide_Maps'Elab_Spec;
      E361 := True;
      System.File_Control_Block'Elab_Spec;
      E293 := True;
      Ada.Streams.Stream_Io'Elab_Spec;
      System.File_Io'Elab_Body;
      E290 := True;
      E355 := True;
      Ada.Tags'Elab_Body;
      E060 := True;
      Ada.Text_Io'Elab_Spec;
      Ada.Text_Io'Elab_Body;
      E285 := True;
      E280 := True;
      Ada.Text_Io.Editing'Elab_Spec;
      E367 := True;
      base_types'elab_spec;
      E303 := True;
      Basec201_Data'Elab_Spec;
      E276 := True;
      Db_Commons'Elab_Spec;
      E365 := True;
      E399 := True;
      E178 := True;
      Glib'Elab_Spec;
      E007 := True;
      E105 := True;
      E092 := True;
      Gdk.Visual'Elab_Body;
      E113 := True;
      E094 := True;
      GNU.DB.SQLCLI'ELAB_SPEC;
      GNU.DB.SQLCLI'ELAB_BODY;
      E374 := True;
      E403 := True;
      E378 := True;
      E419 := True;
      E417 := True;
      E383 := True;
      E381 := True;
      E423 := True;
      E421 := True;
      E427 := True;
      E425 := True;
      E387 := True;
      E385 := True;
      E433 := True;
      E431 := True;
      E391 := True;
      E389 := True;
      E395 := True;
      E393 := True;
      GNU.DB.SQLCLI.ENVIRONMENT_ATTRIBUTE'ELAB_SPEC;
      GNU.DB.SQLCLI.ENVIRONMENT_ATTRIBUTE'ELAB_BODY;
      E376 := True;
      E370 := True;
      E409 := True;
      E407 := True;
      GNU.DB.SQLCLI.CONNECTION_ATTRIBUTE'ELAB_SPEC;
      GNU.DB.SQLCLI.CONNECTION_ATTRIBUTE'ELAB_BODY;
      E405 := True;
      GNU.DB.SQLCLI.STATEMENT_ATTRIBUTE'ELAB_SPEC;
      GNU.DB.SQLCLI.STATEMENT_ATTRIBUTE'ELAB_BODY;
      E429 := True;
      GNU.DB.SQLCLI.INFO'ELAB_SPEC;
      GNU.DB.SQLCLI.INFO'ELAB_BODY;
      E413 := True;
      E086 := True;
      E080 := True;
      Gtkada.Types'Elab_Spec;
      E088 := True;
      Glib.Object'Elab_Spec;
      E077 := True;
      E075 := True;
      E208 := True;
      Glib.Values'Elab_Body;
      E101 := True;
      Gdk.Color'Elab_Spec;
      E158 := True;
      Glib.Generic_Properties'Elab_Spec;
      Glib.Generic_Properties'Elab_Body;
      E099 := True;
      E111 := True;
      E134 := True;
      Gdk.Event'Elab_Spec;
      Gdk.Display'Elab_Spec;
      E160 := True;
      E103 := True;
      E138 := True;
      E136 := True;
      E142 := True;
      Gtk.Cell_Editable'Elab_Spec;
      E221 := True;
      E115 := True;
      Gtk.Object'Elab_Spec;
      E140 := True;
      Gtk.Accel_Group'Elab_Spec;
      Gtk.Accel_Group'Elab_Body;
      E168 := True;
      Gtk.Adjustment'Elab_Spec;
      Gtk.Adjustment'Elab_Body;
      E174 := True;
      Gtk.Tree_Model'Elab_Spec;
      Gtk.Tree_Model'Elab_Body;
      E192 := True;
      E214 := True;
      E182 := True;
      Gtkada.Pixmaps'Elab_Spec;
      E245 := True;
      Logger'Elab_Body;
      E435 := True;
      E437 := True;
      E439 := True;
      E441 := True;
      E401 := True;
      E357 := True;
      p_conversion'elab_spec;
      E465 := True;
      E128 := True;
      E148 := True;
      Pango.Font'Elab_Spec;
      E120 := True;
      E130 := True;
      E132 := True;
      Pango.Context'Elab_Spec;
      E150 := True;
      E152 := True;
      Pango.Layout'Elab_Spec;
      E146 := True;
      E162 := True;
      E164 := True;
      Gdk.Pixbuf'Elab_Spec;
      E156 := True;
      Gtk.Style'Elab_Spec;
      Gtk.Style'Elab_Body;
      E117 := True;
      Gtk.Widget'Elab_Spec;
      E107 := True;
      Glade.Xml'Elab_Spec;
      Glade.Xml'Elab_Body;
      E180 := True;
      Gtk.Calendar'Elab_Spec;
      Gtk.Calendar'Elab_Body;
      E443 := True;
      Gtk.Cell_Renderer'Elab_Spec;
      Gtk.Cell_Renderer'Elab_Body;
      E220 := True;
      E447 := True;
      Gtk.Cell_Renderer_Text'Elab_Spec;
      Gtk.Cell_Renderer_Text'Elab_Body;
      E257 := True;
      Gtk.Container'Elab_Spec;
      Gtk.Container'Elab_Body;
      E172 := True;
      Gtk.Bin'Elab_Spec;
      Gtk.Bin'Elab_Body;
      E170 := True;
      Gtk.Box'Elab_Spec;
      Gtk.Box'Elab_Body;
      E240 := True;
      Gtk.Button'Elab_Spec;
      Gtk.Button'Elab_Body;
      E184 := True;
      Gtk.Editable'Elab_Spec;
      Gtk.Editable'Elab_Body;
      E188 := True;
      Gtk.Entry_Completion'Elab_Spec;
      Gtk.Entry_Completion'Elab_Body;
      E190 := True;
      Gtk.Gentry'Elab_Spec;
      Gtk.Gentry'Elab_Body;
      E186 := True;
      Gtk.Grange'Elab_Spec;
      Gtk.Grange'Elab_Body;
      E202 := True;
      Gtk.Misc'Elab_Spec;
      Gtk.Misc'Elab_Body;
      E196 := True;
      Gtk.Label'Elab_Spec;
      Gtk.Label'Elab_Body;
      E194 := True;
      Gtk.Scrollbar'Elab_Spec;
      Gtk.Scrollbar'Elab_Body;
      E200 := True;
      Gtk.Scrolled_Window'Elab_Spec;
      Gtk.Scrolled_Window'Elab_Body;
      E198 := True;
      Gtk.Selection'Elab_Spec;
      E212 := True;
      E218 := True;
      Gtk.Tooltips'Elab_Spec;
      Gtk.Tooltips'Elab_Body;
      E225 := True;
      E210 := True;
      Gtk.Tree_Selection'Elab_Spec;
      Gtk.Tree_Selection'Elab_Body;
      E204 := True;
      Gtk.Tree_Store'Elab_Spec;
      Gtk.Tree_Store'Elab_Body;
      E206 := True;
      Gtk.Tree_View_Column'Elab_Spec;
      Gtk.Tree_View_Column'Elab_Body;
      E223 := True;
      Gtk.Tree_View'Elab_Spec;
      Gtk.Tree_View'Elab_Body;
      E216 := True;
      Gtk.Combo_Box'Elab_Spec;
      Gtk.Combo_Box'Elab_Body;
      E445 := True;
      Gtk.Window'Elab_Spec;
      Gtk.Window'Elab_Body;
      E154 := True;
      Gtk.Widget'Elab_Body;
      E109 := True;
      Gtk.Dialog'Elab_Spec;
      Gtk.Dialog'Elab_Body;
      E253 := True;
      Gtk.Pixmap'Elab_Spec;
      Gtk.Pixmap'Elab_Body;
      E242 := True;
      E453 := True;
      E255 := True;
      E176 := True;
      E259 := True;
      E262 := True;
      E457 := True;
      E469 := True;
      E451 := True;
      E449 := True;
      p_appli_enregville'elab_spec;
      E461 := True;
      E467 := True;
      E264 := True;
      p_window_enregville'elab_spec;
      p_window_enregville'elab_body;
      E459 := True;
      E463 := True;
   end adainit;

   procedure adafinal is
   begin
      Do_Finalize;
   end adafinal;

   function main
     (argc : Integer;
      argv : System.Address;
      envp : System.Address)
      return Integer
   is
      procedure initialize (Addr : System.Address);
      pragma Import (C, initialize, "__gnat_initialize");

      procedure finalize;
      pragma Import (C, finalize, "__gnat_finalize");

      procedure Ada_Main_Program;
      pragma Import (Ada, Ada_Main_Program, "_ada_main");

      SEH : aliased array (1 .. 2) of Integer;

      Ensure_Reference : aliased System.Address := Ada_Main_Program_Name'Address;
      pragma Volatile (Ensure_Reference);

   begin
      gnat_argc := argc;
      gnat_argv := argv;
      gnat_envp := envp;

      Initialize (SEH'Address);
      adainit;
      Break_Start;
      Ada_Main_Program;
      Do_Finalize;
      Finalize;
      return (gnat_exit_status);
   end;

--  BEGIN Object file/option list
   --   /users/info/etu-s2/andrepot/Projet-Omgl/gibus/bin/base_types.o
   --   /users/info/etu-s2/andrepot/Projet-Omgl/gibus/bin/basec201_data.o
   --   /users/info/etu-s2/andrepot/Projet-Omgl/gibus/bin/db_commons.o
   --   /users/info/etu-s2/andrepot/Projet-Omgl/gibus/bin/environment.o
   --   /users/info/etu-s2/andrepot/Projet-Omgl/gibus/bin/db_commons-odbc.o
   --   /users/info/etu-s2/andrepot/Projet-Omgl/gibus/bin/logger.o
   --   /users/info/etu-s2/andrepot/Projet-Omgl/gibus/bin/jour_festival_io.o
   --   /users/info/etu-s2/andrepot/Projet-Omgl/gibus/bin/groupe_io.o
   --   /users/info/etu-s2/andrepot/Projet-Omgl/gibus/bin/grande_finale_io.o
   --   /users/info/etu-s2/andrepot/Projet-Omgl/gibus/bin/gagnant_festival_io.o
   --   /users/info/etu-s2/andrepot/Projet-Omgl/gibus/bin/festival_io.o
   --   /users/info/etu-s2/andrepot/Projet-Omgl/gibus/bin/p_esiut.o
   --   /users/info/etu-s2/andrepot/Projet-Omgl/gibus/bin/p_conversion.o
   --   /users/info/etu-s2/andrepot/Projet-Omgl/gibus/bin/p_util_treeview.o
   --   /users/info/etu-s2/andrepot/Projet-Omgl/gibus/bin/p_window_consulterfestival.o
   --   /users/info/etu-s2/andrepot/Projet-Omgl/gibus/bin/p_window_consultgroupe.o
   --   /users/info/etu-s2/andrepot/Projet-Omgl/gibus/bin/p_window_consultprogramme.o
   --   /users/info/etu-s2/andrepot/Projet-Omgl/gibus/bin/p_window_enreggroupe.o
   --   /users/info/etu-s2/andrepot/Projet-Omgl/gibus/bin/p_window_progfestival.o
   --   /users/info/etu-s2/andrepot/Projet-Omgl/gibus/bin/ville_io.o
   --   /users/info/etu-s2/andrepot/Projet-Omgl/gibus/bin/p_appli_creerfestival.o
   --   /users/info/etu-s2/andrepot/Projet-Omgl/gibus/bin/p_appli_enregville.o
   --   /users/info/etu-s2/andrepot/Projet-Omgl/gibus/bin/p_appli_menu.o
   --   /users/info/etu-s2/andrepot/Projet-Omgl/gibus/bin/p_window_creerfestival.o
   --   /users/info/etu-s2/andrepot/Projet-Omgl/gibus/bin/p_window_enregville.o
   --   /users/info/etu-s2/andrepot/Projet-Omgl/gibus/bin/p_window_menu.o
   --   /users/info/etu-s2/andrepot/Projet-Omgl/gibus/bin/main.o
   --   -L/users/info/etu-s2/andrepot/Projet-Omgl/gibus/bin/
   --   -L/usr/lib/ada/adalib/gnadecommon/
   --   -L/usr/lib/ada/adalib/gnadeodbc/
   --   -L/usr/lib/ada/adalib/aunit/
   --   -L/usr/lib/ada/adalib/gtkada2/
   --   -L/users/info/pub/1a/ada/bib/
   --   -L/users/info/pub/2a/reseaux/adalib/obj/
   --   -L/usr/lib/gcc/i486-linux-gnu/4.4.4/adalib/
   --   -lodbc
   --   -lgtkada2_glade
   --   -static
   --   -lgnat
--  END Object file/option list   

end ada_main;
