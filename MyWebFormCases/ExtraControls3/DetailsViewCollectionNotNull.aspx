﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DetailsViewCollectionNotNull.aspx.cs" Inherits="MyWebFormCases.ExtraControls3.DetailsViewCollectionNotNull" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">

        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
        <ajaxToolkit:HtmlEditorExtender ID="HtmlEditorExtender1" runat="server" TargetControlID="TextBox1" ></ajaxToolkit:HtmlEditorExtender>

        <asp:DetailsView ID="DetailsView1" runat="server" Height="50px" Width="125px" AutogenerateRows="true" DataKeyNames="SID"  OnItemInserting="DetailsView1_ItemInserting" OnModeChanging="DetailsView1_ModeChanging" EmptyDataText="no data"  AllowPaging="true" OnPageIndexChanging="DetailsView1_PageIndexChanging" >
            <Fields>
               <%-- <asp:BoundField DataField="SID" HeaderText="SID" InsertVisible="False" ReadOnly="True" SortExpression="SID" />
                <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                <asp:BoundField DataField="City" HeaderText="City" SortExpression="City" />--%>
                <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" ShowInsertButton="True" />
            </Fields>
        </asp:DetailsView>
      
    </form>
</body>
</html>
