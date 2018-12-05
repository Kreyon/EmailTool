<%@ WebHandler Language="C#" Class="SendMail" %>

using System;
using System.Web;
using System.Linq;
using System.Net.Mail;
using System.Web.SessionState;

public class SendMail : IHttpHandler, IRequiresSessionState
{

    public void ProcessRequest(HttpContext context)
    {
       
            string email = context.Request.QueryString["email"];
            string cc = context.Request.QueryString["cc"];
            string bcc = context.Request.QueryString["bcc"];
            string sub = context.Request.QueryString["sub"];
            string body = context.Request.QueryString["body"];
            string attach = context.Request.QueryString["attach"];
            string success = "";
            Linqconnection db = new Linqconnection();

            var record = (from rec in db.EmailConfigs
                          select rec).AsEnumerable().LastOrDefault();



            //string pass = System.Text.Encoding.UTF8.GetString(System.Web.Security.MachineKey.Decode(record.Password, System.Web.Security.MachineKeyProtection.All));
            string pass = EncryptAlgo.DecryptText(record.Password, EncryptAlgo.theKey, EncryptAlgo.theIV);

            System.Net.Mail.MailMessage oMail = new System.Net.Mail.MailMessage();
            System.Net.Mail.Attachment attachment1;
            oMail.From = new System.Net.Mail.MailAddress(record.Username);

            if (email != "")
            {
                string[] splitemail = email.Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries);
                for (var i = 0; i < splitemail.Length; i++)
                {

                    oMail.To.Add(new System.Net.Mail.MailAddress(splitemail[i]));
                }
            }
            if (bcc != "")
            {
                string[] splitemail = bcc.Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries);
                for (var i = 0; i < splitemail.Length; i++)
                {
                    oMail.Bcc.Add(new System.Net.Mail.MailAddress(splitemail[i]));
                }
                if (email == "")
                {
                    oMail.To.Add(new System.Net.Mail.MailAddress(splitemail[0]));
                }
            }
            if (cc != "")
            {
                string[] splitemail = bcc.Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries);
                for (var i = 0; i < splitemail.Length; i++)
                {
                    oMail.CC.Add(new System.Net.Mail.MailAddress(splitemail[i]));
                }
                if (email == "")
                {
                    oMail.To.Add(new System.Net.Mail.MailAddress(splitemail[0]));
                }
            }

            if (attach != "")
            {
                string[] splitattach = attach.Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries);
                for (var i = 0; i < splitattach.Length; i++)
                {
                    string file = context.Server.MapPath("EmailAttacements" + "/" + splitattach[i]);

                    attachment1 = new System.Net.Mail.Attachment(file);
                    oMail.Attachments.Add(attachment1);
                }


            }

            try
            {

            oMail.ReplyTo = new System.Net.Mail.MailAddress(record.Username);
            oMail.Subject = sub;
            oMail.IsBodyHtml = true; // enumeration
            oMail.Priority = System.Net.Mail.MailPriority.High; // enumeration
            oMail.Body = body;

            // oMail.To = "shefalitiwari1995@gmail.com";

            //2
            //const string SERVER = "smtpout.secureserver.net";





            //Add "Disposition-Notification-To" for Read receipt
            //  oMail.Headers.Add("Disposition-Notification-To", "shefalitiwari1995@gmail.com");
            System.Net.NetworkCredential nc = new System.Net.NetworkCredential(record.Username, pass);
            System.Net.Mail.SmtpClient sC = new System.Net.Mail.SmtpClient();
            int port = 0;
            if (record.Host == "imap-mail.outlook.com")
            {
                port = 587;
            }
            else if (record.Host == "pop3.live.com")
            {
                port = 587;
            }
            else if (record.Host == "pop.gmail.com")
            {
                port = 587;
            }
            else if (record.Host == "imap.gmail.com")
            {
                port = 587;
            }
            else if (record.Host == "pop.mail.yahoo.com")
            {
                port = 465;
            }
            else if (record.Host == "imap.mail.yahoo.com")
            {
                port = 465;
            }
            else
            {
                port = 80;
            }


            string SERVER = record.SmtpServer;
            sC.Host = SERVER;
            sC.Port = port;

            // 3

            sC.Credentials = nc;
            sC.EnableSsl = false;
         

            sC.Send(oMail);
            success = "done";
        }
        catch (Exception ex)
        {

            OutBoxMail ob = new OutBoxMail();

            var unique = DateTime.UtcNow.Ticks;
            int sid = Convert.ToInt32(context.Session["ConfigId"]);

            if (!System.IO.Directory.Exists(System.Web.HttpContext.Current.Server.MapPath("Outbox_Email/") + sid))
            {
                System.IO.Directory.CreateDirectory(System.Web.HttpContext.Current.Server.MapPath("Outbox_Email/") + sid);
            }

            string path = "Outbox_Email/" + sid + "/" + unique + ".xml";

            ob.UserId = Convert.ToInt32(HttpContext.Current.Session["ConfigId"]);
            ob.OutboxMailPath = path;

            db.OutBoxMails.InsertOnSubmit(ob);
            db.SubmitChanges();

            System.Xml.XmlTextWriter writer = new System.Xml.XmlTextWriter(System.Web.HttpContext.Current.Server.MapPath("~/") + path, System.Text.Encoding.UTF8);

            writer.WriteStartDocument(true);
            writer.Formatting = System.Xml.Formatting.Indented;
            writer.Indentation = 2;
            writer.WriteStartElement("Outbox");
            HelperClass.createNode(writer, "id", ob.Id.ToString());
            HelperClass.createNode(writer, "to", email);
            HelperClass.createNode(writer, "cc", cc);
            HelperClass.createNode(writer, "bcc", bcc);
            HelperClass.createNode(writer, "subject", sub);
            HelperClass.createNode(writer, "body", body);
            writer.WriteEndElement();
            writer.WriteEndDocument();
            writer.Close();

            context.Response.Write("Something went wrong mail saved in outbox");
        
        }

        try
        {
            SendedMail sm = new SendedMail();

            var unique = DateTime.UtcNow.Ticks;
            int sid = Convert.ToInt32(context.Session["ConfigId"]);

            if (!System.IO.Directory.Exists(System.Web.HttpContext.Current.Server.MapPath("Sended_Email/") + sid))
            {
                System.IO.Directory.CreateDirectory(System.Web.HttpContext.Current.Server.MapPath("Sended_Email/") + sid);
            }

            string path = "Sended_Email/" + sid + "/" + unique + ".xml";

            sm.UserId = Convert.ToInt32(HttpContext.Current.Session["ConfigId"]);
            sm.SendMailPath = path;

            db.SendedMails.InsertOnSubmit(sm);
            db.SubmitChanges();

            System.Xml.XmlTextWriter writer = new System.Xml.XmlTextWriter(System.Web.HttpContext.Current.Server.MapPath("~/") + path, System.Text.Encoding.UTF8);

            writer.WriteStartDocument(true);
            writer.Formatting = System.Xml.Formatting.Indented;
            writer.Indentation = 2;
            writer.WriteStartElement("Sendedmail");
            HelperClass.createNode(writer, "id", sm.Id.ToString());
            HelperClass.createNode(writer, "to", email);
            HelperClass.createNode(writer, "cc", cc);
            HelperClass.createNode(writer, "bcc", bcc);
            HelperClass.createNode(writer, "subject", sub);
            HelperClass.createNode(writer, "body", body);
            writer.WriteEndElement();
            writer.WriteEndDocument();
            writer.Close();


          


            context.Response.Write(success);
        }
        catch (Exception ex)
        {
            string Path = System.Web.HttpContext.Current.Server.MapPath("~/tempSaveFile.txt");

            System.IO.StreamWriter dynamicSw = new System.IO.StreamWriter(Path, true);
            dynamicSw.WriteLine(ex.Message);
            dynamicSw.Close(); dynamicSw.Dispose();
            context.Response.Write("fail");
        }




    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}


