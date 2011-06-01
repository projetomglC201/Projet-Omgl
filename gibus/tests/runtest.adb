
with Suite;


with AUnit.Test_results.text_reporter;
with AUnit.Test_runner ;

procedure runtest is

   procedure RunTestSuite is new AUnit.Test_Runner( Suite );
   
begin

   RunTestSuite ;
   
end runtest;
