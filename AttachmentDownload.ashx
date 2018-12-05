<%@ WebHandler Language="C#" Class="AttachmentDownload" %>

using System;
using System.Web;
using System.IO;
using System.Text;
using System.Net;

public class AttachmentDownload : IHttpHandler
{

    public void ProcessRequest(HttpContext context)
    {

        string data1 = context.Request.QueryString["path"];

        string file = "";
        try
        {
            file = context.Server.MapPath("EmailAttacements/" +data1);
        }

        catch (Exception)
        {
            context.Response.Write("please try again");
        }

      //  string[] path = Directory.GetFiles(data1);

       // foreach (var item in path)
      // {
        System.IO.FileInfo docu = new FileInfo(file);



            if (docu.Exists)
            {
                context.Response.Clear();
                context.Response.AddHeader("content-disposition", "attachment;filename=\"" + docu.Name + "\"");
                context.Response.AddHeader("content-lenght", docu.ToString());
                context.Response.ContentType = "application/octet-stream";
                context.Response.TransmitFile(docu.FullName);
                context.Response.Flush();

                context.Response.Write("done");


            }
      //  }
    //


    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}