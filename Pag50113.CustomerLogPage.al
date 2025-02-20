page 50113 CustomerLogPage
{
    ApplicationArea = All;
    Caption = 'CustomerLogPage';
    PageType = Card;
    SourceTable = CustomerLog;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                field(ID; Rec.ID)
                {
                    ApplicationArea = All;
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Activity Type"; Rec."Activity Type")
                {
                    ApplicationArea = All;
                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = All;
                }

            }
        }
    }
}
