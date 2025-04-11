codeunit 50540 "Auto Post Receipt On Release"
{

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Purchase Document", 'OnAfterReleasePurchaseDoc', '', false, false)]
    local procedure OnAfterReleasePurchaseDoc(var PurchaseHeader: Record "Purchase Header"; PreviewMode: Boolean; var LinesWereModified: Boolean; SkipWhseRequestOperations: Boolean)
    var
        PurchPost: Codeunit "Purch.-Post";
        FreshPurchHeader: Record "Purchase Header";
    begin

        if (PurchaseHeader."Document Type" <> PurchaseHeader."Document Type"::Order) or
           (PurchaseHeader.Status <> PurchaseHeader.Status::Released) then
            exit;

        if not FreshPurchHeader.Get(PurchaseHeader."Document Type", PurchaseHeader."No.") then
            exit;

        FreshPurchHeader.Receive := true;
        FreshPurchHeader.Invoice := false;

        PurchPost.Run(FreshPurchHeader);

    end;
}

