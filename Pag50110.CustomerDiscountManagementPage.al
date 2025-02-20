page 50110 CustomerDiscountManagementPage
{
    ApplicationArea = All;
    Caption = 'Rabatt Management';
    PageType = Card;
    SourceTable = CustomerDiscount;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
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
                    Editable = false;
                }
                field(Discount; Rec.Discount)
                {
                    Caption = 'Rabatt';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Last Update"; Rec."Last Update")
                {
                    Caption = 'Letzte Aktualisierung';
                    ApplicationArea = All;
                    Editable = false;

                }
                field("Balance(LCY)"; Rec."Balance(LCY)")
                {

                    ApplicationArea = All;
                }

            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(DiscountCalculation)
            {
                ApplicationArea = All;
                Caption = 'Rabatt neu berechnen';
                trigger OnAction()
                var
                    cust: Record Customer;
                    SalesTier: Codeunit SalesTier;
                begin
                    if cust.Get(Rec."Customer No.") then begin
                        cust.CalcFields("Balance (LCY)");
                        Rec."Balance(LCY)" := cust."Balance (LCY)" * (1 - Rec.Discount);
                        Rec.Modify();
                    end;
                end;
            }
        }
    }
}
