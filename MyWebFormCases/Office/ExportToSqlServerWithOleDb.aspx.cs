﻿using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.OleDb;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MyWebFormCases.Office
{
    public partial class ExportToSqlServerWithOleDb : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {

          
            string conString = string.Empty;
            string extension = Path.GetExtension(FileUpload1.PostedFile.FileName);
            switch (extension)
            {
                case ".xls": //Excel 97-03
                    FileUpload1.SaveAs(@"D:\files\101.xls");
                    conString = @"Provider=Microsoft.Jet.OLEDB.4.0;Data Source=D:\files\101.xls;Extended Properties='Excel 8.0;HDR=YES'";
                    break;
                case ".xlsx": //Excel 07 or higher
                    FileUpload1.SaveAs(@"D:\files\101.xlsx");
                    conString = @"Provider=Microsoft.ACE.OLEDB.12.0;Data Source=D:\files\101.xlsx;Extended Properties='Excel 8.0;HDR=YES'";
                    break;
            }
        

            using (OleDbConnection excel_con = new OleDbConnection(conString))
            {
                excel_con.Open();
                string sheet1 = excel_con.GetOleDbSchemaTable(OleDbSchemaGuid.Tables, null).Rows[0]["TABLE_NAME"].ToString();
                DataTable dtExcelData = new DataTable();
                //[OPTIONAL]: It is recommended as otherwise the data will be considered as String by default.
                dtExcelData.Columns.AddRange(new DataColumn[3] { new DataColumn("Id", typeof(int)),
new DataColumn("Name", typeof(string)),
new DataColumn("Salary",typeof(decimal)) });
                using (OleDbDataAdapter oda = new OleDbDataAdapter("SELECT * FROM [" + sheet1 + "]", excel_con))
                {
                    oda.Fill(dtExcelData);
                }
                excel_con.Close();
                string consString = ConfigurationManager.ConnectionStrings["UserItemDb3"].ConnectionString;
                using (SqlConnection con = new SqlConnection(consString))
                {
                    using (SqlBulkCopy sqlBulkCopy = new SqlBulkCopy(con))
                    {
                        //Set the database table name
                        sqlBulkCopy.DestinationTableName = "dbo.salary1";
                        //[OPTIONAL]: Map the Excel columns with that of the database table
                        sqlBulkCopy.ColumnMappings.Add("Id", "id");
                   
                        sqlBulkCopy.ColumnMappings.Add("Name", "name");
                        sqlBulkCopy.ColumnMappings.Add("Salary", "salary");
                        con.Open();
                        sqlBulkCopy.WriteToServer(dtExcelData);
                        con.Close();
                    }
                }
            }
        }
    }
}