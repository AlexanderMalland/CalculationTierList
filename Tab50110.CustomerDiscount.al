table 50110 CustomerDiscount
{
    Caption = 'Kunden Rabatt';
    DataClassification = CustomerContent;


    fields
    {
        field(1; "ID"; Integer)
        {
            Caption = 'ID';
            AutoIncrement = true;
            Editable = false;
        }
        field(2; "Customer No."; Code[20])
        {
            Caption = 'Kunden Nr.';
            TableRelation = Customer;
            trigger OnValidate()
            var
                Customer: Record Customer;
                SalesTier: Codeunit SalesTier;
            begin
                if Customer.Get(Rec."Customer No.") then begin
                    Rec.Validate("Sales Tier" , SalesTier.GetSalesTier(Customer));
                    Rec.Discount := SalesTier.SetDiscount(Rec."Sales Tier");
                    Customer.CalcFields("Balance (LCY)");
                    Rec."Balance(LCY)" := Customer."Balance (LCY)";
                    Rec."Last Update" := Today;
                end;
            end;
        }
        field(3; "Sales Tier"; Enum "Sales Tier")
        {
            Caption = ' Umsatzklasse';
            trigger OnValidate()
            var
                MyNotification: Notification;
            begin
                    MyNotification.Message('Ihre Umsatzklasse hat sich verändert.');
                    MyNotification.Scope := NotificationScope::LocalScope;
                    MyNotification.Send();
                
            end;
        }
        field(4; "Discount"; Decimal)
        {
            Caption = 'Rabatt';
        }
        field(5; "Last Update"; Date)
        {
            Caption = 'Letzte Aktualisierung';
        }
        field(6; "Balance(LCY)"; Decimal)
        {
            Caption = 'Gesamtumsatz';
        }
    }
    keys
    {
        key(PK; "ID")
        {
            Clustered = true;

        }
        key(SortingKey; "Customer No.", "Sales Tier", "Last Update")
        {
        }
    }
}
