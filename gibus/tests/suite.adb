--
-- Created by ada_generator.py on 2011-05-13 13:55:54.273370
-- 
with AUnit.Test_Suites; use AUnit.Test_Suites;

with Basec201_Test;

function Suite return Access_Test_Suite is
        result : Access_Test_Suite := new Test_Suite;
begin
        Add_Test( result, new Basec201_Test.test_Case ); -- Adrs_Data_Ada_Tests.Test_Case
        return result;
end Suite;
