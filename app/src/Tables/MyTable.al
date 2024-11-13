table 50000 "MyTable_PTE"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; MyField; Integer)
        {
            Caption = 'English', Comment = 'DAN="Danish", DEU="German"';
            ToolTip = 'English', Comment = 'DAN="Danish", DEU="German"';
        }
    }

    keys
    {
        key(PK; "MyField")
        {
            Clustered = true;
        }
    }
}