﻿<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ListViewPagingData.aspx.vb" Inherits="VBWebForm.ListViewPagingData" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/css/bootstrap.min.css" integrity="sha384-Smlep5jCw/wG7hdkwQ/Z5nLIefveQRIY9nfy6xoR1uRYBtpZgI6339F5dgvm/e9B" crossorigin="anonymous">
         <script src="../Scripts/jquery-3.3.1.js"></script>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ListView ID="ListView1" runat="server" DataSourceID="SqlDataSource1" ItemPlaceholderID="itemPlaceHolder" DataKeyNames="id"  OnPagePropertiesChanging="ListView1_PagePropertiesChanging"
            OnDataBound="ListView1_DataBound"
            >

            <LayoutTemplate >
                <table class="table table-striped  table-bordered ">
                
                           <thead>
                                <tr runat="server" style="">
                                 
                                    
                                    <th runat="server">Option1</th>
                                    <th runat="server">Option2</th>
                                    <th runat="server">Option3</th>
                                </tr>
                               </thead>
                    <tbody>
                                <asp:Panel ID="itemPlaceHolder" runat="server"></asp:Panel>
                     <tr >
                        <td  colspan="3" style="">
                            <asp:DataPager ID="DataPager1" runat="server" PageSize="4" >
                                <Fields>
                                    <asp:NumericPagerField ButtonCount="5" 
                            NumericButtonCssClass="numeric_button" 
                            CurrentPageLabelCssClass="current_page"
                                        

                             />
                                   <%-- <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="True" ShowLastPageButton="True" />--%>
                                </Fields>
                            </asp:DataPager>
                        </td>
                    </tr>
                        </tbody>
                            </table>
                        
                   
                </table>
            </LayoutTemplate>

            <ItemTemplate>
                <tr>
                    <td align="left" colspan="3"><%#Eval("Question") %>
                        <asp:HiddenField ID="QuestionDetailID" runat="server" Value='<%#Eval("ID") %>' />
                    </td>
                </tr>
                </div>
                <tr align="left">

                    <td align="left">
                        <asp:Label ID="Option1" runat="server" Text=' <%# Eval ("Option1") %>'></asp:Label><asp:RadioButton ID="rad1" GroupName="Group1" runat="server" /></td>

                    <td align="left">
                        <asp:Label ID="Option2" runat="server" Text=' <%# Eval("Option2") %>'></asp:Label>
                        <asp:RadioButton ID="rad2" GroupName="Group1" runat="server" /></td>

                    <td align="left">
                        <asp:Label ID="Option3" runat="server" Text=' <%# Eval("Option3") %>'></asp:Label>
                        <asp:RadioButton ID="rad3" GroupName="Group1" runat="server" /></td>

                </tr>

            </ItemTemplate>
            
        </asp:ListView>
   

        <asp:HiddenField ID="currentPage" runat="server" />
         <asp:Button ID="Button1" runat="server" Text="save" CssClass="btn btn-primary" OnClick="Button1_Click" />
        <script>
            //$(function () {


               

            //$("table [id*=DataPager1]  span").prevAll().hide()

            //})

        </script>

        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:EntityExeConnectionString %>" SelectCommand="SELECT [id], [Question], [Option1], [Option2], [Option3] FROM [Questions]"></asp:SqlDataSource>
    </form>
</body>
</html>
