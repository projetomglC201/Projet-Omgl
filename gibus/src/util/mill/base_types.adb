--
-- Created by ada_generator.py on 2011-05-13 13:55:53.706016
-- 
package body base_types is

   function Slice_To_Unbounded( s : String; start : Positive; stop : Natural ) return Unbounded_String is
   begin
      return To_Unbounded_String( Slice( To_Unbounded_String( s ), start, stop ) );
   end Slice_To_Unbounded;


end base_types;
