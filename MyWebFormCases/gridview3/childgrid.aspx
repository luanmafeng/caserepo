﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="childgrid.aspx.cs" Inherits="MyWebFormCases.gridview3.childgrid" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <asp:GridView ID="GridView1" runat="server" OnRowDataBound="GridView1_RowDataBound" AutoGenerateColumns="false">

            <Columns>
                <asp:BoundField DataField="department_name"  HeaderText="department_name"  />
                <asp:TemplateField HeaderText="employees">
                    <ItemTemplate>
                        <asp:HiddenField ID="HiddenField1" runat="server" Value='<%# Eval("id") %>' /> <!--store the id of department-->
                        <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="false" ShowHeader="false" DataKeyNames="id" AutoGenerateDeleteButton="true" AutoGenerateEditButton="true" OnRowEditing="GridView2_RowEditing" OnRowDeleting="GridView2_RowDeleting" OnRowUpdating="GridView2_RowUpdating" 
                             OnRowCancelingEdit="GridView2_RowCancelingEdit">
                           <Columns>
                               <asp:BoundField DataField="name" />
                               <asp:BoundField DataField="salary" />
                           </Columns>
                        </asp:GridView>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>

        </asp:GridView>
        <asp:Label ID="Label1" runat="server" Text="name"></asp:Label>&nbsp;<asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
        <br />
        <asp:Label ID="Label2" runat="server" Text="salary"></asp:Label><asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
        <br />
        department<asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="SqlDataSource1" DataTextField="department_name" DataValueField="id"></asp:DropDownList><asp:Button ID="create" runat="server" Text="create" OnClick="create_Click" />
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:EntityDb %>" SelectCommand="SELECT [id], [department_name] FROM [department]"></asp:SqlDataSource>
    </form>
</body>
</html>
