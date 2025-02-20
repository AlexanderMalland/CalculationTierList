page 50111 CustomerDiscountManagementList
{
    ApplicationArea = All;
    Caption = 'Rabatt Management Liste';
    PageType = List;
    SourceTable = CustomerDiscount;
    UsageCategory = Lists;
    CardPageId = CustomerDiscountManagementPage;
    Editable = false;
    SourceTableView = sorting("Customer No.", "Sales Tier", "Last Update");

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(ID; Rec.ID)
                {
                    Caption = 'ID';
                    ApplicationArea = All;
                }
                field("Customer No."; Rec."Customer No.")
                {
                    Caption = 'Kunden Nr.';
                    ApplicationArea = All;
                }
                field("Sales Tier"; Rec."Sales Tier")
                {
                    Caption = ' Umsatzklasse';
                    ApplicationArea = All;
                }
                field(Discount; Rec.Discount)
                {
                    Caption = 'Rabatt';
                    ApplicationArea = All;
                }
                field("Last Update"; Rec."Last Update")
                {
                    Caption = 'Letzte Aktualisierung';
                    ApplicationArea = All;
                }
                field("Balance(LCY)"; Rec."Balance(LCY)")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        if Customer.Get(Rec."Customer No.") then begin
            Customer.CalcFields("Balance (LCY)");
            Rec."Balance(LCY)" := Customer."Balance (LCY)";
            Rec.Modify();
        end;
    end;

    var 
        Customer: Record Customer;
}
