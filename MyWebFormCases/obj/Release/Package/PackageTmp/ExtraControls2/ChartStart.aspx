﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ChartStart.aspx.cs" Inherits="MyWebFormCases.ExtraControls2.ChartStart" %>

<%@ Register Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
        </div>
    </form>
    <asp:Chart ID="Chart1" runat="server" Width="1000px" >
        <Series>
            
            <asp:Series  ></asp:Series>
        </Series>
        <ChartAreas>
            
            <asp:ChartArea Name="ChartArea1"  ></asp:ChartArea>
        </ChartAreas>
    </asp:Chart>
</body>
</html>
