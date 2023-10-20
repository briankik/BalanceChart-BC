page 50120 "Balance Chart"
{
    Caption = 'Balance Chart';
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            group(General)
            {
                usercontrol(Chart; "Chart Control")
                {
                    ApplicationArea = All;

                    trigger ControlReady()
                    begin
                        DrawChart();
                    end;
                }
            }
        }
    }

    local procedure DrawChart()
    var
        Customer: Record Customer;
        LabelJsonArray, DataJsonArray : JsonArray;
        CustomerJsonValue, DataJsonValue : JsonValue;
    begin
        Customer.SetFilter("Balance (LCY)", '>%1', 0);
        if Customer.FindSet() then
            repeat
                Customer.CalcFields("Balance (LCY)");
                CustomerJsonValue.SetValue(Customer.Name);
                LabelJsonArray.Add(CustomerJsonValue.Clone());
                DataJsonValue.SetValue(Customer."Balance (LCY)");
                DataJsonArray.Add(DataJsonValue.Clone());
            until Customer.Next() = 0;

        CurrPage.Chart.drawChart(LabelJsonArray, DataJsonArray);
    end;
}
