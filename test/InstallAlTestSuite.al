codeunit 80000 "InstallALTestSuite_TPTE"
{
    Subtype = Install;

    trigger OnInstallAppPerCompany()
    var
        MyObject: Record AllObjWithCaption;
        TestSuite: Record "AL Test Suite";
        TestMethodLine: Record "Test Method Line";
        TestSuiteMgt: Codeunit "Test Suite Mgt.";
        TestSuiteName: Code[10];
    begin
        TestSuiteName := 'TRM Test';

        // First, create a new Test Suite
        if TestSuite.Get(TestSuiteName) then begin
            TestSuiteMgt.DeleteAllMethods(TestSuite);
        end else begin
            TestSuiteMgt.CreateTestSuite(TestSuiteName);
            TestSuite.Get(TestSuiteName);
        end;

        // Second, pull in the test codeunits
        MyObject.SetRange("Object Type", MyObject."Object Type"::Codeunit);
        MyObject.SetFilter("Object ID", '80000..80149');
        MyObject.SetRange("Object Subtype", 'Test');

        if MyObject.FindSet() then begin
            repeat
                TestSuiteMgt.GetTestMethods(TestSuite, MyObject);
            until MyObject.Next() = 0;
        end;

        // Third, run the tests. This is of course an optional step
        // TestMethodLine.SetRange("Test Suite", TestSuiteName);
        // TestSuiteMgt.RunSelectedTests(TestMethodLine);
    end;
}