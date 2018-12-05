using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for Linqconnection
/// </summary>
public class Linqconnection : DataClassesDataContext
{
    public Linqconnection()

    // : base(@"Data Source=43.255.152.26;Initial Catalog=emailproject;User ID=emailproject2018;Password=Email@2018")

     : base(@"Data Source=KREYON10-PC\KREYON10;Initial Catalog=EmailTool;User ID=sa;Password=kreyonsys")
    {
        //
        // TODO: Add constructor logic here
        //
    }
}