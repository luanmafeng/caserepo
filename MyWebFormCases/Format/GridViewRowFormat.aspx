﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GridViewRowFormat.aspx.cs" Inherits="WebFormCases.Format.GridViewRowFormat" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
                <asp:GridView ID="GridView1" runat="server" OnRowDataBound="GridView1_RowDataBound" ></asp:GridView>
        </div>
    </form>

</body>
</html>
