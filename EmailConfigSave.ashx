<%@ WebHandler Language="C#" Class="EmailConfigSave" %>

using System;
using System.Web;
using System.Linq;

public class EmailConfigSave : IHttpHandler, System.Web.SessionState.IRequiresSessionState
{
    public void ProcessRequest(HttpContext context)
    {
        string access = context.Request.QueryString["access"];
        string Host = context.Request.QueryString["host"];
        string Username = context.Request.QueryString["username"];
        string Smtphost1 = context.Request.QueryString["smtphost"];
        string SmtpPort = context.Request.QueryString["smtpport"];
        string Password1 = context.Request.QueryString["password"];
        string reply = context.Request.QueryString["reply"];
        string replyall = context.Request.QueryString["replyall"];
        string compose = context.Request.QueryString["compose"];
        string forward = context.Request.QueryString["forward"];
        string signature = context.Request.QueryString["signature"];

        try
        {
            Password1 = Password1.Replace("[{amp}]", "&");
            Password1 = Password1.Replace("[{hash}]", "#");

            string[] mystring = Host.Split(new string[] { "{^*^}" }, StringSplitOptions.None);

            using (Linqconnection dc = new Linqconnection())
            {
                // FORCEFULLY DELETING ALL PREVIOUS RECORDS
                var MasterTableDeleteAllRecords = dc.EmailConfigs;

                foreach (var item in MasterTableDeleteAllRecords)
                {
                    item.IsDeleted = true;
                    dc.SubmitChanges();
                }
                //END

                var MasterTable = dc.EmailConfigs.FirstOrDefault(a => a.Username.ToLower().Trim().Equals(Username.ToLower().Trim()));

                if (MasterTable != null)
                {
                    // THIS IS ENCRYPTING PASSWORD
                    String encryptedText = EncryptAlgo.EncryptText(Password1, EncryptAlgo.theKey, EncryptAlgo.theIV);

                    MasterTable.Access = access;
                    MasterTable.SmtpServer = Smtphost1;
                    MasterTable.SmtpPort = SmtpPort;
                    MasterTable.Password = encryptedText;
                    MasterTable.Host = mystring[0];
                    MasterTable.Port = mystring[1];
                    MasterTable.UserId = 0;
                    MasterTable.IsDeleted = false;
                    MasterTable.Signature = signature;
                    MasterTable.IsReply = (reply == "true" ? true : reply=="false" ? false: false);
                    MasterTable.IsReplyAll = (replyall == "true" ? true : false);
                    MasterTable.IsCompose = (compose == "true" ? true : false);
                    MasterTable.IsForward = (forward == "true" ? true : false);

                    dc.SubmitChanges();

                    // SAVING VALUES IN SESSION
                    context.Session["ConfigId"] = MasterTable.Id;
                }
                else
                {
                    EmailConfig MasterTableObj = new EmailConfig();

                    // THIS IS ENCRYPTING PASSWORD
                    String encryptedText = EncryptAlgo.EncryptText(Password1, EncryptAlgo.theKey, EncryptAlgo.theIV);

                    MasterTableObj.Access = access;
                    MasterTableObj.SmtpServer = Smtphost1;
                    MasterTableObj.SmtpPort = SmtpPort;
                    MasterTableObj.Username = Username;
                    MasterTableObj.Password = encryptedText;
                    MasterTableObj.Host = mystring[0];
                    MasterTableObj.Port = mystring[1];
                    MasterTableObj.UserId = 0;
                    MasterTableObj.IsDeleted = false;
                    MasterTableObj.Signature = signature;
                    MasterTableObj.IsReply = (reply == "true" ? true : false);
                    MasterTableObj.IsReplyAll = (replyall == "true" ? true : false);
                    MasterTableObj.IsCompose = (compose == "true" ? true : false);
                    MasterTableObj.IsForward = (forward == "true" ? true : false);

                    dc.EmailConfigs.InsertOnSubmit(MasterTableObj);
                    dc.SubmitChanges();

                    // SAVING VALUES IN SESSION
                    context.Session["ConfigId"] = MasterTableObj.Id;
                }

                context.Response.Write("done");

            }
            //Linqconnection db = new Linqconnection();

            //EmailConfig ec = new EmailConfig();

            ////string Password = System.Web.Security.MachineKey.Encode(System.Text.Encoding.UTF8.GetBytes(password.Trim()), System.Web.Security.MachineKeyProtection.All);

            //ec.Access = access;
            //ec.SmtpServer = Smtphost1;
            //ec.Username = Username;
            //ec.Password = Password1;
            //ec.Host = mystring[0];
            //ec.Port = mystring[1];
            //ec.UserId = 0;

            //db.EmailConfigs.InsertOnSubmit(ec);
            //db.SubmitChanges();

            //context.Response.Write("done");
        }
        catch (Exception ex)
        {
            context.Response.Write(ex);
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