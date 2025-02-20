codeunit 50110 SalesTier implements ISalesTier
{
    TableNo = CustomerDiscount;

    procedure GetSalesTier(cust: Record Customer): Enum "Sales Tier"
    begin
        cust.CalcFields("Balance (LCY)");

        if cust."Balance (LCY)" <= 10000 then
            exit(Enum::"Sales Tier"::Bronze)
        else if cust."Balance (LCY)" <= 50000 then
            exit("Sales Tier"::Silver)
        else if cust."Balance (LCY)" <= 100000 then
            exit("Sales Tier"::Gold)
        else
            exit("Sales Tier"::Platinum);
    end;

    procedure SetDiscount(SalesTier: Enum "Sales Tier"): Decimal
    begin
        case SalesTier of
            SalesTier::Bronze:
                exit(0.1);
            SalesTier::Silver:
                exit(0.2);
            SalesTier::Gold:
                exit(0.3);
            SalesTier::Platinum:
                exit(0.4);


        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", OnAfterPostSalesDoc, '', false, false)]
    local procedure OnCustomerSalesUpdated(var SalesHeader: Record "Sales Header")
    var
        Log: Record CustomerLog;
        Discount: Record CustomerDiscount;
        Customer: Record Customer;
        SalesTier: Codeunit SalesTier;
    begin
        Discount.SetRange("Customer No.", SalesHeader."Sell-to Customer No.");

        if not Discount.FindFirst() then begin
            Discount.Init();
            Discount.Validate("Customer No.", SalesHeader."Sell-to Customer No."); 
            Discount.Insert();
        end;

        if Customer.Get(SalesHeader."Sell-to Customer No.") then begin
            Discount.Reset();
            Discount.SetRange("Customer No.", Customer."No.");

            if Discount.FindSet() then
                repeat
                    Discount."Sales Tier" := GetSalesTier(Customer);
                    Discount.Modify();
                until Discount.Next() = 0;

            Log.Init();
            Log.Validate("Customer No.", Customer."No.");
            Log."Activity Type" := Log."Activity Type"::Other;
            Log.Comment := 'Berechnung der neuen Umsatzklasse';
            Log.Insert();

        end;
    end;
}
