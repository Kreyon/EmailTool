using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AttachmentDownload : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        try
        {
            string path1 = Request.QueryString["path"];

            string path = Server.MapPath("Attachment/" + path1);

            System.Net.WebClient wc = new System.Net.WebClient();
            byte[] DownloadData = wc.DownloadData(path);

            HttpResponse response = HttpContext.Current.Response;

            response.Clear();
            response.ClearContent();
            response.ClearHeaders();

            response.Buffer = true;
            response.AddHeader("Content-Disposition", "attachment;filename=\"" + path1 + "\"");
            response.BinaryWrite(DownloadData);
            response.End();

        }
        catch (Exception)
        { }

    }
}