<%@ WebHandler Language="C#" Class="FileUpload" %>

using System;
using System.Web;
using System.IO;

public class FileUpload : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {



        HttpFileCollection files = context.Request.Files;
        HttpPostedFile file1 = files[0];
        string filename = DateTime.UtcNow.Ticks.ToString();
        string path = context.Server.MapPath("EmailAttacements/");
        string fname = file1.FileName;
        string ext = Path.GetExtension(fname);
        file1.SaveAs(path + filename + ext);

       context.Response.Write( fname + "[|]" + filename + ext);
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}