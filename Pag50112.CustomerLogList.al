page 50112 CustomerLogList
{
    ApplicationArea = All;
    Caption = 'Kundenaktivität';
    PageType = List;
    SourceTable = CustomerLog;
    UsageCategory = Lists;
    SourceTableView = sorting("Customer No.", Date);
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;
    CardPageId = CustomerLogPage;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
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
    actions
    {
        area(Processing)
        {
            action("New Log")
            {
                Caption = 'Neue Aktivität erfassen';
                ApplicationArea = All;
                trigger OnAction()
                begin
                    Clear(CustomerLog);
                    CustomerLog.Init();
                    CustomerLog.Insert();
                    PageLog.SetRecord(CustomerLog);
                    PageLog.Run();
                end;
            }
            action("Delete Log")
            {
                Caption = 'Aktivität löschen';
                ApplicationArea = All;
                trigger OnAction()
                begin
                    Rec.Delete();
                end;
            }

        }
    }
    var
        PageLog: Page CustomerLogPage;
        CustomerLog: Record CustomerLog;
}