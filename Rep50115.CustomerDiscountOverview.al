report 50115 CustomerDiscountOverview
{
    ApplicationArea = All;
    Caption = 'Kundenrabatt Übersicht';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(CustomerDiscount; CustomerDiscount)
        {
                column(ID;ID)
                {
                }
                column(Customer_No_;"Customer No.")
                {
                }
                column(Sales_Tier;"Sales Tier")
                {
                }
                column(Discount;Discount)
                {
                }
                column(Last_Update;"Last Update")
                {
                }
                column(Balance_LCY_;"Balance(LCY)")
                {
                }
        }
    }
    // requestpage
    // {
    //     layout
    //     {
    //         area(Content)
    //         {
    //             group(GroupName)
    //             {
    //             }
    //         }
    //     }
    //     actions
    //     {
    //         area(Processing)
    //         {
    //         }
    //     }
    // }
}
