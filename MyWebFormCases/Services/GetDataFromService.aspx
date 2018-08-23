﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GetDataFromService.aspx.cs" Inherits="MyWebFormCases.Services.GetDataFromService" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="../Scripts/jquery-3.3.1.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
          <table id="myTable">

          </table>
        </div>
    </form>
</body>

    <script>
        $.ajax({
            
                    url: ' /Services/ArrayData.asmx/GetData',
                    type: "post",
                    dataType: "json",
                    contentType: "application/json; charset=utf-8",
                  
            success: function (data) {
                         var str = "";
                               for (var i = 0; i <data.d.length; i++) {
                    str += "<tr><td>" + data.d[i].EmpId + "</td><td>" + data.d[i].FName + "</td></tr>";
                }
                $("#myTable").html(str);
               var test= data.f.length;
                    }
                });
       
    </script>
</html>