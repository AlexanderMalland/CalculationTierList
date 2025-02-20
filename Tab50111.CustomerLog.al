table 50111 CustomerLog
{
    Caption = 'Kundenaktivität';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "ID"; Integer)
        {
            Caption = 'ID';
            AutoIncrement = true;
        }
        field(2; "Customer No."; Code[20])
        {
            TableRelation = Customer;
            Caption = 'Kunden Nr.';

            trigger OnValidate()
            begin
                Date := CurrentDateTime();
            end;
        }
        field(3; Date; DateTime)
        {
            Caption = 'Datum';


        }
        field(4; "Activity Type"; Enum ActivityType)
        {
            Caption = 'Aktivitätstyp';
        }
        field(5; Comment; Text[250])
        {
            Caption = 'Notiz';
        }

    }
    keys
    {
        key(PK; "ID")
        {
            Clustered = true;
        }
        key(SortingKey; "Customer No.", Date)
        {
        }
    }
}
