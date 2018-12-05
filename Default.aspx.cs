using S22.Imap;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;
using System.Xml;
using System.IO;
using System.Windows.Forms;


public partial class _Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        int sent = 0;
        int draft = 0;
        int outbox = 0;
        int starred = 0;
        int trash = 0;

        if (!Page.IsPostBack)
        {
            int MasterID = Convert.ToInt32(HttpContext.Current.Session["ConfigId"] ?? "0");

            using (Linqconnection dc = new Linqconnection())
            {
                // 
                if (MasterID > 0)
                {
                    var record = (from rec in dc.EmailConfigs.AsEnumerable()
                                  where rec.Id == MasterID
                                  select rec).LastOrDefault();

                    if (record != null)
                    {
                        MasterID = record.Id;
                        HttpContext.Current.Session["ConfigId"] = record.Id;

                        String Decryptpassword = EncryptAlgo.DecryptText(record.Password, EncryptAlgo.theKey, EncryptAlgo.theIV);

                        smtphost.Value = record.SmtpServer;
                        smtpport.Value = record.SmtpPort;
                        password.Value = Decryptpassword;
                        username.Value = record.Username;
                        accesswithserver.Value = record.Access;
                        serverhost.Value = record.Host;
                        serverport.Value = record.Port;
                        signa.Value = record.Signature;
                        isreply.Value = record.IsReply.ToString();
                        isreplyall.Value = record.IsReplyAll.ToString();
                        iscompose.Value = record.IsCompose.ToString();
                        isforward.Value = record.IsForward.ToString();

                        trash = record.TrashMailsTables.Where(a => a.IsDeleted == false).Count();
                        sent = record.SendedMails.Count();
                        draft = record.DraftEmailTables.Count(); ;
                        outbox = record.OutBoxMails.Count();
                        starred = record.StarredEmailTables.Count();

                    }
                    else
                    {
                        // ERROR : NO EMAIL CREDENTIALS SET

                    }
                }
                else
                {
                    var record = (from rec in dc.EmailConfigs.AsEnumerable()
                                  where !(rec.IsDeleted ?? false)
                                  select rec).LastOrDefault();

                    if (record != null)
                    {
                        MasterID = record.Id;
                        HttpContext.Current.Session["ConfigId"] = record.Id;

                        String Decryptpassword = EncryptAlgo.DecryptText(record.Password, EncryptAlgo.theKey, EncryptAlgo.theIV);

                        smtphost.Value = record.SmtpServer;
                        smtpport.Value = record.SmtpPort;
                        password.Value = Decryptpassword;
                        username.Value = record.Username;
                        accesswithserver.Value = record.Access;
                        serverhost.Value = record.Host;
                        serverport.Value = record.Port;
                        signa.Value = record.Signature;
                        isreply.Value = record.IsReply.ToString();
                        isreplyall.Value = record.IsReplyAll.ToString();
                        iscompose.Value = record.IsCompose.ToString();
                        isforward.Value = record.IsForward.ToString();

                        trash = record.TrashMailsTables.Count();
                        sent = record.SendedMails.Count();
                        draft = record.DraftEmailTables.Count(); ;
                        outbox = record.OutBoxMails.Count();
                        starred = record.StarredEmailTables.Count();
                    }
                    else
                    {
                        // ERROR : NO EMAIL CREDENTIALS SET
                    }
                }
            }
        }

        trashcount.InnerHtml = trash.ToString();
        sendcount.InnerHtml = sent.ToString();
        draftcount.InnerHtml = draft.ToString();
        outboxcount.InnerHtml = outbox.ToString();
        starredcount.InnerHtml = starredcount.ToString();

        starredcount.InnerHtml = starred.ToString();

    }
    
    [System.Web.Services.WebMethod(EnableSession = true)]
    public static string GetEmailsWithHost(int skip, string search, double SystemTimezone)
    {
         int MasterID = Convert.ToInt32(HttpContext.Current.Session["ConfigId"] ?? "0");

        using (Linqconnection dc = new Linqconnection())
        {
            // 
            if (MasterID > 0)
            {
                var record = (from rec in dc.EmailConfigs.AsEnumerable()
                              where rec.Id == MasterID
                              select rec).LastOrDefault();

                if (record != null)
                {
                    MasterID = record.Id;
                    HttpContext.Current.Session["ConfigId"] = record.Id;
                }
                else
                {
                    // ERROR : NO EMAIL CREDENTIALS SET
                }
            }
            else
            {
                var record = (from rec in dc.EmailConfigs.AsEnumerable()
                              where !(rec.IsDeleted ?? false)
                              select rec).LastOrDefault();

                if (record != null)
                {
                    MasterID = record.Id;
                    HttpContext.Current.Session["ConfigId"] = record.Id;
                }
                else
                {
                    // ERROR : NO EMAIL CREDENTIALS SET
                }
            }

        }

        try
        {

            Linqconnection db = new Linqconnection();

            var record = (from rec in db.EmailConfigs.AsEnumerable()
                          where rec.Id == MasterID && !(rec.IsDeleted ?? false)
                          select rec).LastOrDefault();

            if (record == null)
            {
                return "0" + "{*^*}" + "0" + "{*^*}" + "0" + "{*^*}" + "norecord"; ;
            }

            HttpContext.Current.Session["ConfigId"] = record.Id;

            var delid = (from re in db.TrashMailsTables.AsEnumerable()
                         where re.UserID == record.Id && !string.IsNullOrEmpty(re.InboxMailThreadID)
                         select re.InboxMailThreadID).ToArray();

            var StarId = (from re in db.StarredEmailTables.AsEnumerable()
                          where re.UserId == record.Id && re.IsInbox == true
                          select re.EmailId).ToArray();

            // THIS IS ENCRYPTING PASSWORD
            String Decryptpassword = EncryptAlgo.DecryptText(record.Password, EncryptAlgo.theKey, EncryptAlgo.theIV);


            string pass = record.Password;

            string resp = "";

            int counter = 0;
            int mailcount = 0;
            int pagecount = 0;

            StringBuilder ss = new StringBuilder();

            if (record.Access == "imap")
            {
                using (ImapClient Iclient = new ImapClient(record.Host, Convert.ToInt32(record.Port), record.Username, Decryptpassword, S22.Imap.AuthMethod.Login, true, null))
                {

                    IEnumerable<uint> uids = Iclient.Search(S22.Imap.SearchCondition.All(), "INBOX");

                    //IEnumerable<uint> uidseen = Iclient.Search(S22.Imap.SearchCondition.Seen(), "INBOX");
                    var total = uids.Count();
                    if (uids.Count() > 0)
                    {
                        IEnumerable<System.Net.Mail.MailMessage> Iunseenmessages = null;
                        //IEnumerable<System.Net.Mail.MailMessage> ISeenmessages = null;
                        var RecordSkip = (skip - 1) * 10;

                        //try
                        //{
                        //    ISeenmessages = Iclient.GetMessages(uidseen.OrderByDescending(u => u).Skip(((int)skip)).Take(20), true, "INBOX");
                        //}
                        //catch { }
                        try
                        {
                            if (!search.Equals(""))
                            {
                                Iunseenmessages = Iclient.GetMessages(uids.OrderByDescending(u => u), false, "INBOX");
                                Iunseenmessages = Iunseenmessages.Where(s => ((string.IsNullOrEmpty(s.From.User) ? "" : s.From.User).ToLower().Trim().Contains(search.ToLower().Trim())) || ((string.IsNullOrEmpty(s.Subject) ? "" : s.Subject).ToLower().Trim().Contains(search.ToLower().Trim())) || ((string.IsNullOrEmpty(s.From.DisplayName) ? "" : s.From.DisplayName).ToLower().Trim().Contains(search.ToLower().Trim())) || ((string.IsNullOrEmpty(s.From.Address) ? "" : s.From.Address).ToLower().Trim().Contains(search.ToLower().Trim())) || ((string.IsNullOrEmpty(s.Body) ? "" : s.Body).ToLower().Trim().Contains(search.ToLower().Trim())));
                                pagecount = Iunseenmessages.Count();
                            }
                            else
                            {

                                Iunseenmessages = Iclient.GetMessages(uids.OrderByDescending(u => u).Skip(((int)RecordSkip)).Take(10), false, "INBOX");
                                pagecount = total;
                            }


                        }
                        catch { }
                        var Imessages = Iunseenmessages.OrderByDescending(d => Convert.ToDateTime(d.Headers["date"].Substring(0, d.Headers["date"].LastIndexOf(':') + 3).Trim()));
                        int cnt = Imessages.Count();
                        if (cnt > 0)
                        {

                            List<string> maildatecollection = new List<string>();
                            System.Text.StringBuilder str = new System.Text.StringBuilder();

                            foreach (var item in Imessages)
                            {

                                if (!delid.Contains(item.Headers["Date"]))
                                {

                                    string tos = "";
                                    string ccmails = "";
                                    string bccmails = "";
                                    string tomails = "";
                                    tos += item.From.Address;
                                    if (item.To.Count > 0)
                                    {
                                        foreach (var ts in item.To)
                                        {
                                            if (!record.Username.Contains(ts.Address))
                                            {
                                                tos += ts.Address + ",";
                                            }
                                            tomails += ts.Address + ",";

                                        }
                                    }

                                    if (item.CC.Count > 0)
                                    {
                                        foreach (var ts in item.CC)
                                        {
                                            if (!record.Username.Contains(ts.Address))
                                            {
                                                tos += ts.Address + ",";
                                            }
                                            ccmails += ts.Address + ",";
                                        }
                                    }

                                    if (item.Bcc.Count > 0)
                                    {
                                        foreach (var ts in item.Bcc)
                                        {

                                            bccmails += ts.Address + ",";
                                        }
                                    }

                                    string attch = "";

                                    string attchname = "";
                                    byte[] allBytes = null;
                                    if (item.Attachments.Count > 0)
                                    {
                                        foreach (var at in item.Attachments)
                                        {
                                            int size = 1;
                                            try
                                            {
                                                allBytes = new byte[at.ContentStream.Length];
                                                int bytesRead = at.ContentStream.Read(allBytes, 0, (int)at.ContentStream.Length);

                                                var result = Convert.ToBase64String(allBytes);
                                                //size = (int)at.ContentStream.ReadByte();
                                                attch += result + "{bt}";
                                                attchname += at.Name + "{at}";

                                            }
                                            catch { size = 1; }

                                        }
                                    }
                                    //str.Append("<div id='attach' style='display:none;'>" + attch + "</div>");

                                    string subjects = "";
                                    subjects = (string.IsNullOrEmpty(item.Subject) ? "(no subject)" : item.Subject);
                                    string displayname = "";
                                    try
                                    {
                                        if (item.From != null)
                                        {
                                            displayname = (string.IsNullOrEmpty(item.From.DisplayName) ? (string.IsNullOrEmpty(item.From.User) ? "-" : DecodeQuotedPrintables(item.From.User, "")) : DecodeQuotedPrintables(item.From.DisplayName, "").Replace("<notification+", ""));
                                        }
                                        else { displayname = subjects; }
                                    }
                                    catch { displayname = (string.IsNullOrEmpty(item.From.DisplayName) ? (string.IsNullOrEmpty(item.From.User) ? "-" : DecodeQuotedPrintables(item.From.User, "")) : item.From.DisplayName); }
                                    string depart = "";
                                    string fromadd = "";
                                    try
                                    {
                                        if (item.From != null)
                                        {

                                            depart = (string.IsNullOrEmpty(item.From.User) ? "-" : DecodeQuotedPrintables(item.From.User, "")) + " (" + (string.IsNullOrEmpty(item.From.Address) ? "-" : DecodeQuotedPrintables(item.From.Address, "")) + ")";
                                            fromadd = item.From.Address;
                                        }
                                        else { depart = "-"; }
                                    }
                                    catch { depart = subjects; }


                                    if (counter == 0)
                                    {
                                        ss.Append("<div class='nwinb_read' id='first'  onclick='GetInboxEmaildetails(this);'>");
                                    }
                                    else
                                    {
                                        ss.Append("<div class='nwinb_read'  onclick='GetInboxEmaildetails(this);'>");
                                    }

                                    string[] splitdate = null;
                                    string dat = item.Headers["Date"];

                                    if (dat.Contains("+"))
                                    {
                                        splitdate = dat.Split(new char[] { '+' }, StringSplitOptions.RemoveEmptyEntries);
                                    }
                                    else
                                    {
                                        splitdate = dat.Split(new char[] { '-' }, StringSplitOptions.RemoveEmptyEntries);
                                    }
                                    var Date = splitdate[0].Split(',');
                                    DateTime TodayDate = DateTime.UtcNow.AddMinutes(SystemTimezone);
                                    DateTime testdate;
                                    if (Date.Length == 1)
                                    {
                                        testdate = Convert.ToDateTime(Date[0]);
                                    }
                                    else
                                    {
                                        testdate = Convert.ToDateTime(Date[1]);
                                    }
                                    string HowManyHours = Math.Round(TodayDate.Subtract(testdate).TotalHours, 2).ToString();
                                    string HowManyMinutes = Math.Round(TodayDate.Subtract(testdate).TotalMinutes, 2).ToString();
                                    string[] dt = HowManyHours.Split(new string[] { "." }, StringSplitOptions.RemoveEmptyEntries);
                                    string[] dt1 = HowManyMinutes.Split(new string[] { "." }, StringSplitOptions.RemoveEmptyEntries);
                                    string FinalDate = (Convert.ToDateTime(testdate).Date == DateTime.UtcNow.Date ? (dt[0] != "0" ? dt[0] + " hours ago" : dt1[0] + " minutes ago") : (Convert.ToDateTime(testdate)).Date == DateTime.UtcNow.AddDays(-1).Date ? "Yesterday " + Convert.ToDateTime(testdate).ToString("hh:mm tt") : Convert.ToDateTime(testdate).ToString("dd MMM yyyy hh:mm tt"));
                                    var bodyhtml = item.Body;
                                    bodyhtml = bodyhtml.Replace("\r\n", "<br>");
                                    ss.Append("<div class='nwinb_chkbox' data-inboxdelid='" + item.Headers["Date"] + "'>");

                                    ss.Append("<div class='cbdiv'></div><div class='thisemailbody' style='display:none;'>" + (string.IsNullOrEmpty(bodyhtml) ? "-" : (bodyhtml)) + "</div>");
                                    ss.Append("<div class='mysub'  style='display:none;'>" + subjects + "</div>");
                                    ss.Append("<div class='attach'   style='display:none;'>" + attch + "</div>");
                                    ss.Append("<div class='attachname'   style='display:none;'>" + attchname + "</div>");
                                    ss.Append("<div class='uid'  style='display:none;'>" + item.Headers["Date"] + "</div>");
                                    ss.Append("<div class='fromad'  style='display:none;'>" + fromadd + "</div>");
                                    ss.Append("<div class='replyallmails'  style='display:none;'>" + tos + "</div>");
                                    ss.Append("<div class='ccmails'  style='display:none;'>" + ccmails + "</div>");
                                    ss.Append("<div class='bccmails'  style='display:none;'>" + bccmails + "</div>");
                                    ss.Append("<div class='tomails'  style='display:none;'>" + tomails + "</div>");
                                    ss.Append("<div class='maildate'  style='display:none;'>" + FinalDate + "</div>");
                                    ss.Append("<div class='mytos'  style='display:none;'>" + depart + "</div></div>");


                                    ss.Append("<div class='mail-list'>");

                                    ss.Append("<div class='form-check check_inptblock chk_inbox'>");
                                    ss.Append("<div class='checkbox'><label><input type='checkbox' name='InboxcheckboxChild' value='" + item.Headers["Date"] + "' /><span class='cr'><i class='cr-icon mdi mdi-check'></i></span></label></div>");
                                    ss.Append("</div>");

                                    if (StarId.Contains(item.Headers["Date"]))
                                    {
                                        ss.Append(" <div class='details star-inptbox' onclick=\"RemoveStar(this,'inbox','" + item.Headers["Date"] + "')\">                                                                                             ");
                                        ss.Append("     <i class='mdi mdi-star favorite'></i>                                                                                       ");
                                        ss.Append(" </div>                                                                                                                         ");
                                    }
                                    else
                                    {
                                        ss.Append(" <div class='details star-inptbox' onclick=\"SaveStar(this,'inbox','" + item.Headers["Date"] + "')\">                                                                                             ");
                                        ss.Append("     <i class='mdi mdi-star-outline'></i>                                                                                       ");
                                        ss.Append(" </div>                                                                                                                         ");
                                    }
                                    ss.Append(" <div class='content'>                                                                                                          ");
                                    ss.Append("     <p class='sender-name' >" + displayname + "</p>                                        ");
                                    ss.Append("     <p class='message_text nwinb_mailcont'>" + subjects + "</p>                                                                         ");
                                    ss.Append(" </div>                                                                                                                         ");
                                    ss.Append("                                                                                                                                ");
                                    ss.Append(" </div> </div>");
                                    maildatecollection.Add(item.Headers["Date"]);
                                    counter++;

                                    mailcount++;

                                    // if (item.Attachments.Count() > 0)
                                    // {
                                    //     str.Append("<div class='nwinb_mailattach'></div>");
                                    //  }
                                    //string tempdate = item.Headers["Date"].ToString();
                                    //var dtt = Convert.ToDateTime(tempdate.Substring(0, tempdate.LastIndexOf(':') + 3).Trim());
                                    //if (DateTime.UtcNow.Date == dtt.Date)
                                    //{ tempdate = String.Format("{0:t}", dtt.Date); }
                                    //else
                                    //{
                                    //    tempdate = String.Format("{MMM dd}", dtt.Date);
                                    //}
                                    //str.Append("<div class='nwinb_mailtime'>" + tempdate + "</div></div>");
                                }
                            }
                            int RecordShow = 10;
                            if (search.Equals(""))
                            {
                                if (mailcount != 10)
                                {

                                    // int leftmail = RecordShow - mailcount;
                                    // int getleftmail = RecordSkip + leftmail;
                                    IEnumerable<System.Net.Mail.MailMessage> Iunseenmessages2 = null;

                                    try
                                    {
                                        // HERE WE ARE taking this because if more then 10 records are deleted then we have to take more 
                                        int DeletedRecordsCountPlusTenMore = delid.Count() + 10;

                                        Iunseenmessages2 = Iclient.GetMessages(uids.OrderByDescending(u => u).Skip(((int)RecordSkip)).Take(DeletedRecordsCountPlusTenMore), false, "INBOX");
                                    }
                                    catch { }
                                    //try
                                    //{
                                    //    ISeenmessages = Iclient.GetMessages(uidseen.OrderByDescending(u => u).Skip(((int)skip)).Take(20), true, "INBOX");
                                    //}
                                    //catch { }

                                    var Imessages2 = Iunseenmessages.OrderByDescending(d => Convert.ToDateTime(d.Headers["date"].Substring(0, d.Headers["date"].LastIndexOf(':') + 3).Trim()));
                                    int cnt2 = Imessages.Count();
                                    if (cnt > 0)
                                    {
                                        //int mailcount2 = 0;
                                        //List<string> maildatecollection = new List<string>();
                                        // System.Text.StringBuilder str = new System.Text.StringBuilder();
                                        foreach (var item in Imessages2)
                                        {

                                            if (!delid.Contains(item.Headers["Date"]))
                                            {
                                                if (!maildatecollection.Contains(item.Headers["Date"]))
                                                {

                                                    string tos = "";
                                                    string ccmails = "";
                                                    string bccmails = "";
                                                    string tomails = "";
                                                    tos += item.From.Address;
                                                    if (item.To.Count > 0)
                                                    {
                                                        foreach (var ts in item.To)
                                                        {
                                                            if (!record.Username.Contains(ts.Address))
                                                            {
                                                                tos += ts.Address + ",";
                                                            }
                                                            tomails += ts.Address + ",";

                                                        }
                                                    }

                                                    if (item.CC.Count > 0)
                                                    {
                                                        foreach (var ts in item.CC)
                                                        {
                                                            if (!record.Username.Contains(ts.Address))
                                                            {
                                                                tos += ts.Address + ",";
                                                            }
                                                            ccmails += ts.Address + ",";
                                                        }
                                                    }

                                                    if (item.Bcc.Count > 0)
                                                    {
                                                        foreach (var ts in item.Bcc)
                                                        {

                                                            bccmails += ts.Address + ",";
                                                        }
                                                    }

                                                    string attch = "";
                                                    string attchname = "";
                                                    byte[] allBytes = null;
                                                    if (item.Attachments.Count > 0)
                                                    {
                                                        foreach (var at in item.Attachments)
                                                        {
                                                            int size = 1;
                                                            try
                                                            {
                                                                allBytes = new byte[at.ContentStream.Length];
                                                                int bytesRead = at.ContentStream.Read(allBytes, 0, (int)at.ContentStream.Length);

                                                                var result = Convert.ToBase64String(allBytes);
                                                                //size = (int)at.ContentStream.ReadByte();
                                                                attch += result + "{bt}";
                                                                attchname += at.Name + "{at}";

                                                            }
                                                            catch { size = 1; }
                                                        }
                                                    }
                                                    //str.Append("<div id='attach' style='display:none;'>" + attch + "</div>");

                                                    string subjects = "";
                                                    subjects = (string.IsNullOrEmpty(item.Subject) ? "(no subject)" : item.Subject);
                                                    string displayname = "";
                                                    try
                                                    {
                                                        if (item.From != null)
                                                        {
                                                            displayname = (string.IsNullOrEmpty(item.From.DisplayName) ? (string.IsNullOrEmpty(item.From.User) ? "-" : DecodeQuotedPrintables(item.From.User, "")) : DecodeQuotedPrintables(item.From.DisplayName, "").Replace("<notification+", ""));
                                                        }
                                                        else { displayname = subjects; }
                                                    }
                                                    catch { displayname = (string.IsNullOrEmpty(item.From.DisplayName) ? (string.IsNullOrEmpty(item.From.User) ? "-" : DecodeQuotedPrintables(item.From.User, "")) : item.From.DisplayName); }
                                                    string depart = "";
                                                    string fromadd = "";
                                                    try
                                                    {
                                                        if (item.From != null)
                                                        {

                                                            depart = (string.IsNullOrEmpty(item.From.User) ? "-" : DecodeQuotedPrintables(item.From.User, "")) + " (" + (string.IsNullOrEmpty(item.From.Address) ? "-" : DecodeQuotedPrintables(item.From.Address, "")) + ")";
                                                            fromadd = item.From.Address;
                                                        }
                                                        else { depart = "-"; }
                                                    }
                                                    catch { depart = subjects; }


                                                    if (counter == 0)
                                                    {
                                                        ss.Append("<div class='nwinb_read' id='first'  onclick='GetInboxEmaildetails(this);'>");
                                                    }
                                                    else
                                                    {
                                                        ss.Append("<div class='nwinb_read'  onclick='GetInboxEmaildetails(this);'>");
                                                    }

                                                    string[] splitdate = null;
                                                    string dat = item.Headers["Date"];

                                                    if (dat.Contains("+"))
                                                    {
                                                        splitdate = dat.Split(new char[] { '+' }, StringSplitOptions.RemoveEmptyEntries);
                                                    }
                                                    else
                                                    {
                                                        splitdate = dat.Split(new char[] { '-' }, StringSplitOptions.RemoveEmptyEntries);
                                                    }
                                                    var Date = splitdate[0].Split(',');
                                                    DateTime TodayDate = DateTime.UtcNow.AddMinutes(SystemTimezone);
                                                    DateTime testdate;
                                                    if (Date.Length == 1)
                                                    {
                                                        testdate = Convert.ToDateTime(Date[0]);
                                                    }
                                                    else
                                                    {
                                                        testdate = Convert.ToDateTime(Date[1]);
                                                    }
                                                    string HowManyHours = Math.Round(TodayDate.Subtract(testdate).TotalHours, 2).ToString();
                                                    string HowManyMinutes = Math.Round(TodayDate.Subtract(testdate).TotalMinutes, 2).ToString();
                                                    string[] dt = HowManyHours.Split(new string[] { "." }, StringSplitOptions.RemoveEmptyEntries);
                                                    string[] dt1 = HowManyMinutes.Split(new string[] { "." }, StringSplitOptions.RemoveEmptyEntries);
                                                    string FinalDate = (Convert.ToDateTime(testdate).Date == DateTime.UtcNow.Date ? (dt[0] != "0" ? dt[0] + " hours ago" : dt1[0] + " minutes ago") : (Convert.ToDateTime(testdate)).Date == DateTime.UtcNow.AddDays(-1).Date ? "Yesterday " + Convert.ToDateTime(testdate).ToString("hh:mm tt") : Convert.ToDateTime(testdate).ToString("dd MMM yyyy hh:mm tt"));
                                                    var bodyhtml = item.Body;
                                                    bodyhtml = bodyhtml.Replace("\r\n", "<br>");

                                                    ss.Append("<div class='nwinb_chkbox' data-inboxdelid='" + item.Headers["Date"] + "'>");

                                                    ss.Append("<div class='cbdiv'></div><div class='thisemailbody' style='display:none;'>" + (string.IsNullOrEmpty(bodyhtml) ? "-" : (bodyhtml)) + "</div>");
                                                    ss.Append("<div class='mysub'  style='display:none;'>" + subjects + "</div>");
                                                    ss.Append("<div class='attach'   style='display:none;'>" + attch + "</div>");
                                                    ss.Append("<div class='attachname'   style='display:none;'>" + attchname + "</div>");
                                                    ss.Append("<div class='uid'  style='display:none;'>" + item.Headers["Date"] + "</div>");
                                                    ss.Append("<div class='fromad'  style='display:none;'>" + fromadd + "</div>");
                                                    ss.Append("<div class='replyallmails'  style='display:none;'>" + tos + "</div>");
                                                    ss.Append("<div class='ccmails'  style='display:none;'>" + ccmails + "</div>");
                                                    ss.Append("<div class='bccmails'  style='display:none;'>" + bccmails + "</div>");
                                                    ss.Append("<div class='tomails'  style='display:none;'>" + tomails + "</div>");
                                                    ss.Append("<div class='maildate'  style='display:none;'>" + FinalDate + "</div>");
                                                    ss.Append("<div class='mytos'  style='display:none;'>" + depart + "</div></div>");


                                                    ss.Append("<div class='mail-list'>");

                                                    ss.Append("<div class='form-check check_inptblock chk_inbox'>");
                                                    ss.Append("<div class='checkbox'><label><input type='checkbox' name='InboxcheckboxChild' value='" + item.Headers["Date"] + "' /><span class='cr'><i class='cr-icon mdi mdi-check'></i></span></label></div>");
                                                    ss.Append("</div>");

                                                    if (StarId.Contains(item.Headers["Date"]))
                                                    {
                                                        ss.Append(" <div class='details star-inptbox' onclick=\"RemoveStar(this,'inbox','" + item.Headers["Date"] + "')\">                                                                                             ");
                                                        ss.Append("     <i class='mdi mdi-star favorite'></i>                                                                                       ");
                                                        ss.Append(" </div>                                                                                                                         ");
                                                    }
                                                    else
                                                    {
                                                        ss.Append(" <div class='details star-inptbox' onclick=\"SaveStar(this,'inbox','" + item.Headers["Date"] + "')\">                                                                                             ");
                                                        ss.Append("     <i class='mdi mdi-star-outline'></i>                                                                                       ");
                                                        ss.Append(" </div>                                                                                                                         ");
                                                    }
                                                    ss.Append(" <div class='content'>                                                                                                          ");
                                                    ss.Append("     <p class='sender-name' >" + displayname + "</p>                                        ");
                                                    ss.Append("     <p class='message_text nwinb_mailcont'>" + subjects + "</p>                                                                         ");
                                                    ss.Append(" </div>                                                                                                                         ");
                                                    ss.Append("                                                                                                                                ");
                                                    ss.Append(" </div> </div>");
                                                    maildatecollection.Add(item.Headers["Date"]);
                                                    counter++;

                                                    mailcount++;
                                                    if (mailcount == 10)
                                                    {
                                                        break;
                                                    }
                                                }
                                            }
                                        }
                                    }

                                }
                            }
                            //  htmlstring = str.ToString();

                            var PageLinks = total % RecordShow == 0 ? (total / RecordShow) : (total / RecordShow) + 1;
                            resp = total.ToString() + "{*^*}" + ss + "{*^*}" + PageLinks + "{*^*}" + "done";
                        }
                        else { resp = total.ToString() + "{*^*}" + "0" + "{*^*}" + "0" + "{*^*}" + "nomessage"; }
                    }
                    else { resp = total.ToString() + "{*^*}" + "0" + "{*^*}" + "0" + "{*^*}" + "nomessage"; }

                }
            }
            else if (record.Access == "pop")
            {
                using (S22.Pop3.Pop3Client popclient = new S22.Pop3.Pop3Client(record.Host, Convert.ToInt32(record.Port), record.Username, Decryptpassword, S22.Pop3.AuthMethod.Login, true, null))
                {

                    var total = popclient.GetMessageNumbers().Count();
                    if (total > 0)
                    {

                        var RecordSkip = (skip - 1) * 10;
                        uint[] mylist;
                        System.Net.Mail.MailMessage[] messages = null;
                        //S22.Pop3.MessageInfo[] emailint = popclient.GetStatus();
                        if (!search.Equals(""))
                        {
                            mylist = popclient.GetMessageNumbers().OrderByDescending(c => c).ToArray();
                            messages = popclient.GetMessages(mylist);
                            messages = messages.Where(s => ((string.IsNullOrEmpty(s.From.User) ? "" : s.From.User).ToLower().Trim().Contains(search.ToLower().Trim())) || ((string.IsNullOrEmpty(s.Subject) ? "" : s.Subject).ToLower().Trim().Contains(search.ToLower().Trim())) || ((string.IsNullOrEmpty(s.From.DisplayName) ? "" : s.From.DisplayName).ToLower().Trim().Contains(search.ToLower().Trim())) || ((string.IsNullOrEmpty(s.From.Address) ? "" : s.From.Address).ToLower().Trim().Contains(search.ToLower().Trim())) || ((string.IsNullOrEmpty(s.Body) ? "" : s.Body).ToLower().Trim().Contains(search.ToLower().Trim()))).ToArray();
                            pagecount = messages.Count();
                        }
                        else
                        {
                            mylist = popclient.GetMessageNumbers().OrderByDescending(c => c).Skip(RecordSkip).Take(10).ToArray();
                            messages = popclient.GetMessages(mylist);
                            pagecount = total;
                        }


                        System.Text.StringBuilder str = new System.Text.StringBuilder();
                        List<string> maildatecollection = new List<string>();
                        if (messages.Count() != 0)
                        {
                        foreach (var item in messages)
                        {

                            if (!delid.Contains(item.Headers["Date"]))
                            {



                                item.IsBodyHtml = true;
                                string tos = "";
                                string ccmails = "";
                                string bccmails = "";
                                string tomails = "";
                                tos += item.From.Address;
                                if (item.To.Count > 0)
                                {
                                    foreach (var ts in item.To)
                                    {
                                        if (!record.Username.Contains(ts.Address))
                                        {
                                            tos += ts.Address + ",";
                                        }
                                        tomails += ts.Address + ",";

                                    }
                                }

                                if (item.CC.Count > 0)
                                {
                                    foreach (var ts in item.CC)
                                    {
                                        if (!record.Username.Contains(ts.Address))
                                        {
                                            tos += ts.Address + ",";
                                        }
                                        ccmails += ts.Address + ",";
                                    }
                                }

                                if (item.Bcc.Count > 0)
                                {
                                    foreach (var ts in item.Bcc)
                                    {

                                        bccmails += ts.Address + ",";
                                    }
                                }




                                string attch = "";
                                string attchname = "";
                                byte[] allBytes = null;
                                if (item.Attachments.Count > 0)
                                {
                                    foreach (var at in item.Attachments)
                                    {
                                        int size = 1;
                                        try
                                        {
                                            allBytes = new byte[at.ContentStream.Length];
                                            int bytesRead = at.ContentStream.Read(allBytes, 0, (int)at.ContentStream.Length);

                                            var result = Convert.ToBase64String(allBytes);
                                            //size = (int)at.ContentStream.ReadByte();
                                            attch += result + "{bt}";
                                            attchname += at.Name + "{at}";

                                        }
                                        catch { size = 1; }





                                        //  string destinationFile = @"C:\\Path\\" + at.Name;
                                        // BinaryWriter writer = new BinaryWriter(new FileStream(destinationFile, FileMode.OpenOrCreate, FileAccess.Write, FileShare.None));
                                        // writer.Write(allBytes);
                                        //writer.Close();
                                    }
                                }
                                //str.Append("<div id='attach' style='display:none;'>" + attch + "</div>");

                                string subjects = "";
                                    subjects = (string.IsNullOrEmpty(item.Subject) ? "(no subject)" : item.Subject);
                                string displayname = "";
                                try
                                {
                                    if (item.From != null)
                                    {
                                        displayname = (string.IsNullOrEmpty(item.From.DisplayName) ? (string.IsNullOrEmpty(item.From.User) ? "-" : DecodeQuotedPrintables(item.From.User, "")) : DecodeQuotedPrintables(item.From.DisplayName, "").Replace("<notification+", ""));
                                    }
                                    else { displayname = subjects; }
                                }
                                catch { displayname = (string.IsNullOrEmpty(item.From.DisplayName) ? (string.IsNullOrEmpty(item.From.User) ? "-" : DecodeQuotedPrintables(item.From.User, "")) : item.From.DisplayName); }
                                string depart = "";
                                string fromadd = "";
                                try
                                {
                                    if (item.From != null)
                                    {
                                        depart = (string.IsNullOrEmpty(item.From.User) ? "-" : DecodeQuotedPrintables(item.From.User, "")) + " (" + (string.IsNullOrEmpty(item.From.Address) ? "-" : DecodeQuotedPrintables(item.From.Address, "")) + ")";
                                        fromadd = item.From.Address;

                                    }
                                    else { depart = "-"; }
                                }
                                catch { depart = subjects; }


                                if (counter == 0)
                                {
                                    ss.Append("<div class='nwinb_read' id='first'  onclick='GetInboxEmaildetails(this);'>");
                                }
                                else
                                {
                                    ss.Append("<div class='nwinb_read'  onclick='GetInboxEmaildetails(this);'>");
                                }
                                string[] splitdate = null;
                                string dat = item.Headers["Date"];

                                if (dat.Contains("+"))
                                {
                                    splitdate = dat.Split(new char[] { '+' }, StringSplitOptions.RemoveEmptyEntries);
                                }
                                else
                                {
                                    splitdate = dat.Split(new char[] { '-' }, StringSplitOptions.RemoveEmptyEntries);
                                }
                                var Date = splitdate[0].Split(',');
                                DateTime TodayDate = DateTime.UtcNow.AddMinutes(SystemTimezone);
                                DateTime testdate;
                                if (Date.Length == 1)
                                {
                                    testdate = Convert.ToDateTime(Date[0]);
                                }
                                else
                                {
                                    testdate = Convert.ToDateTime(Date[1]);
                                }


                                string HowManyHours = Math.Round(TodayDate.Subtract(testdate).TotalHours, 2).ToString();
                                string HowManyMinutes = Math.Round(TodayDate.Subtract(testdate).TotalMinutes, 2).ToString();
                                string[] dt = HowManyHours.Split(new string[] { "." }, StringSplitOptions.RemoveEmptyEntries);
                                string[] dt1 = HowManyMinutes.Split(new string[] { "." }, StringSplitOptions.RemoveEmptyEntries);
                                string FinalDate = (Convert.ToDateTime(testdate).Date == DateTime.UtcNow.Date ? (dt[0] != "0" ? dt[0] + " hours ago" : dt1[0] + " minutes ago") : (Convert.ToDateTime(testdate)).Date == DateTime.UtcNow.AddDays(-1).Date ? "Yesterday " + Convert.ToDateTime(testdate).ToString("hh:mm tt") : Convert.ToDateTime(testdate).ToString("dd MMM yyyy hh:mm tt"));
                                var bodyhtml = item.Body;
                                bodyhtml = bodyhtml.Replace("\r\n", "<br>");

                                ss.Append("<div class='nwinb_chkbox' data-inboxdelid='" + item.Headers["Date"] + "'>");

                                ss.Append("<div class='cbdiv'></div><div class='thisemailbody'  style='display:none;'>" + (string.IsNullOrEmpty(bodyhtml) ? "-" : (bodyhtml)) + "</div>");
                                ss.Append("<div class='mysub'  style='display:none;'>" + subjects + "</div>");
                                ss.Append("<div class='attach'   style='display:none;'>" + attch + "</div>");
                                ss.Append("<div class='attachname'   style='display:none;'>" + attchname + "</div>");
                                ss.Append("<div class='uid'  style='display:none;'>" + item.Headers["Date"] + "</div>");
                                ss.Append("<div class='fromad'  style='display:none;'>" + fromadd + "</div>");
                                ss.Append("<div class='replyallmails'  style='display:none;'>" + tos + "</div>");
                                ss.Append("<div class='ccmails'  style='display:none;'>" + ccmails + "</div>");
                                ss.Append("<div class='bccmails'  style='display:none;'>" + bccmails + "</div>");
                                ss.Append("<div class='tomails'  style='display:none;'>" + tomails + "</div>");
                                ss.Append("<div class='maildate'  style='display:none;'>" + FinalDate + "</div>");
                                ss.Append("<div class='mytos'  style='display:none;'>" + depart + "</div></div>");

                                ss.Append("<div class='mail-list'>");

                                ss.Append("<div class='form-check check_inptblock chk_inbox'>");
                                ss.Append("<div class='checkbox'><label><input type='checkbox' name='InboxcheckboxChild' value='" + item.Headers["Date"] + "' /><span class='cr'><i class='cr-icon mdi mdi-check'></i></span></label></div>");
                                ss.Append("</div>");

                                if (StarId.Contains(item.Headers["Date"]))
                                {
                                    ss.Append(" <div class='details star-inptbox' onclick=\"RemoveStar(this,'inbox','" + item.Headers["Date"] + "')\">                                                                                             ");
                                    ss.Append("     <i class='mdi mdi-star favorite'></i>                                                                                       ");
                                    ss.Append(" </div>                                                                                                                         ");
                                }
                                else
                                {
                                    ss.Append(" <div class='details star-inptbox' onclick=\"SaveStar(this,'inbox','" + item.Headers["Date"] + "')\">                                                                                             ");
                                    ss.Append("     <i class='mdi mdi-star-outline'></i>                                                                                       ");
                                    ss.Append(" </div>                                                                                                                         ");
                                }
                                ss.Append(" <div class='content'>                                                                                                          ");
                                ss.Append("     <p class='sender-name' >" + displayname + "</p>                                        ");
                                ss.Append("     <p class='message_text nwinb_mailcont'>" + subjects + "</p>                                                                         ");
                                ss.Append(" </div>                                                                                                                         ");
                                ss.Append("                                                                                                                                ");
                                ss.Append(" </div> </div>");
                                maildatecollection.Add(item.Headers["Date"]);
                                counter++;

                                mailcount++;


                                // if (item.Attachments.Count() > 0)
                                //  {
                                //     str.Append("<div class='nwinb_mailattach'></div>");
                                //  }
                                //string tempdate = item.Headers["Date"].ToString();
                                //var dtt = Convert.ToDateTime(tempdate.Substring(0, tempdate.LastIndexOf(':') + 3).Trim());
                                //if (DateTime.UtcNow.Date == dtt.Date)
                                //{ tempdate = String.Format("{0:t}", dtt.Date); }
                                //else
                                //{
                                //    tempdate = String.Format("{MMM dd}", dtt.Date);
                                //}
                                //str.Append("<div class='nwinb_mailtime'>" + tempdate + "</div></div>");
                            }
                        }
                        if (search.Equals(""))
                        {
                            if (mailcount != 10)
                            {
                                // HERE WE ARE taking this because if more then 10 records are deleted then we have to take more 
                                int DeletedRecordsCountPlusTenMore = delid.Count() + 10;

                                uint[] mylist2 = popclient.GetMessageNumbers().OrderByDescending(c => c).Skip(RecordSkip).Take(DeletedRecordsCountPlusTenMore).ToArray();

                                System.Net.Mail.MailMessage[] messages2 = popclient.GetMessages(mylist2);
                                if (!search.Equals(""))
                                {
                                    messages2 = messages2.Where(s => (s.From.User.ToLower().Trim().Contains(search.ToLower().Trim())) || (s.Subject.ToLower().Trim().Contains(search.ToLower().Trim()))).ToArray();

                                }
                                foreach (var item in messages2)
                                {

                                    if (!delid.Contains(item.Headers["Date"]))
                                    {
                                        if (!maildatecollection.Contains(item.Headers["Date"]))
                                        {

                                            item.IsBodyHtml = true; string tos = "";
                                            string ccmails = "";
                                            string bccmails = "";
                                            string tomails = "";
                                            tos += item.From.Address;
                                            if (item.To.Count > 0)
                                            {
                                                foreach (var ts in item.To)
                                                {
                                                    if (!record.Username.Contains(ts.Address))
                                                    {
                                                        tos += ts.Address + ",";
                                                    }
                                                    tomails += ts.Address + ",";

                                                }
                                            }

                                            if (item.CC.Count > 0)
                                            {
                                                foreach (var ts in item.CC)
                                                {
                                                    if (!record.Username.Contains(ts.Address))
                                                    {
                                                        tos += ts.Address + ",";
                                                    }
                                                    ccmails += ts.Address + ",";
                                                }
                                            }

                                            if (item.Bcc.Count > 0)
                                            {
                                                foreach (var ts in item.Bcc)
                                                {

                                                    bccmails += ts.Address + ",";
                                                }
                                            }


                                            string attch = "";
                                            string attchname = "";
                                            byte[] allBytes = null;
                                            if (item.Attachments.Count > 0)
                                            {
                                                foreach (var at in item.Attachments)
                                                {
                                                    int size = 1;
                                                    try
                                                    {
                                                        allBytes = new byte[at.ContentStream.Length];
                                                        int bytesRead = at.ContentStream.Read(allBytes, 0, (int)at.ContentStream.Length);

                                                        var result = Convert.ToBase64String(allBytes);
                                                        //size = (int)at.ContentStream.ReadByte();
                                                        attch += result + "{bt}";
                                                        attchname += at.Name + "{at}";

                                                    }
                                                    catch { size = 1; }
                                                }
                                            }
                                            //str.Append("<div id='attach' style='display:none;'>" + attch + "</div>");

                                            string subjects = "";
                                                subjects = (string.IsNullOrEmpty(item.Subject) ? "(no subject)" : item.Subject);
                                            string displayname = "";
                                            try
                                            {
                                                if (item.From != null)
                                                {
                                                    displayname = (string.IsNullOrEmpty(item.From.DisplayName) ? (string.IsNullOrEmpty(item.From.User) ? "-" : DecodeQuotedPrintables(item.From.User, "")) : DecodeQuotedPrintables(item.From.DisplayName, "").Replace("<notification+", ""));
                                                }
                                                else { displayname = subjects; }
                                            }
                                            catch { displayname = (string.IsNullOrEmpty(item.From.DisplayName) ? (string.IsNullOrEmpty(item.From.User) ? "-" : DecodeQuotedPrintables(item.From.User, "")) : item.From.DisplayName); }
                                            string depart = "";
                                            string fromadd = "";
                                            try
                                            {
                                                if (item.From != null)
                                                {
                                                    depart = (string.IsNullOrEmpty(item.From.User) ? "-" : DecodeQuotedPrintables(item.From.User, "")) + " (" + (string.IsNullOrEmpty(item.From.Address) ? "-" : DecodeQuotedPrintables(item.From.Address, "")) + ")";
                                                    fromadd = item.From.Address;
                                                }
                                                else { depart = "-"; }
                                            }
                                            catch { depart = subjects; }


                                            if (counter == 0)
                                            {
                                                ss.Append("<div class='nwinb_read' id='first'  onclick='GetInboxEmaildetails(this);'>");
                                            }
                                            else
                                            {
                                                ss.Append("<div class='nwinb_read'  onclick='GetInboxEmaildetails(this);'>");
                                            }

                                            string[] splitdate = null;
                                            string dat = item.Headers["Date"];

                                            if (dat.Contains("+"))
                                            {
                                                splitdate = dat.Split(new char[] { '+' }, StringSplitOptions.RemoveEmptyEntries);
                                            }
                                            else
                                            {
                                                splitdate = dat.Split(new char[] { '-' }, StringSplitOptions.RemoveEmptyEntries);
                                            }
                                            var Date = splitdate[0].Split(',');
                                            DateTime TodayDate = DateTime.UtcNow.AddMinutes(SystemTimezone);
                                            DateTime testdate;
                                            if (Date.Length == 1)
                                            {
                                                testdate = Convert.ToDateTime(Date[0]);
                                            }
                                            else
                                            {
                                                testdate = Convert.ToDateTime(Date[1]);
                                            }
                                            string HowManyHours = Math.Round(TodayDate.Subtract(testdate).TotalHours, 2).ToString();
                                            string HowManyMinutes = Math.Round(TodayDate.Subtract(testdate).TotalMinutes, 2).ToString();
                                            string[] dt = HowManyHours.Split(new string[] { "." }, StringSplitOptions.RemoveEmptyEntries);
                                            string[] dt1 = HowManyMinutes.Split(new string[] { "." }, StringSplitOptions.RemoveEmptyEntries);
                                            string FinalDate = (Convert.ToDateTime(testdate).Date == DateTime.UtcNow.Date ? (dt[0] != "0" ? dt[0] + " hours ago" : dt1[0] + " minutes ago") : (Convert.ToDateTime(testdate)).Date == DateTime.UtcNow.AddDays(-1).Date ? "Yesterday " + Convert.ToDateTime(testdate).ToString("hh:mm tt") : Convert.ToDateTime(testdate).ToString("dd MMM yyyy hh:mm tt"));

                                            var bodyhtml = item.Body;
                                            bodyhtml = bodyhtml.Replace("\r\n", "<br>");

                                            ss.Append("<div class='nwinb_chkbox' data-inboxdelid='" + item.Headers["Date"] + "'>");

                                            ss.Append("<div class='cbdiv'></div><div class='thisemailbody'  style='display:none;'>" + (string.IsNullOrEmpty(bodyhtml) ? "-" : (bodyhtml)) + "</div>");
                                            ss.Append("<div class='mysub'  style='display:none;'>" + subjects + "</div>");
                                            ss.Append("<div class='attach'   style='display:none;'>" + attch + "</div>");
                                            ss.Append("<div class='attachname'   style='display:none;'>" + attchname + "</div>");
                                            ss.Append("<div class='uid'  style='display:none;'>" + item.Headers["Date"] + "</div>");
                                            ss.Append("<div class='fromad'  style='display:none;'>" + fromadd + "</div>");
                                            ss.Append("<div class='replyallmails'  style='display:none;'>" + tos + "</div>");
                                            ss.Append("<div class='ccmails'  style='display:none;'>" + ccmails + "</div>");
                                            ss.Append("<div class='bccmails'  style='display:none;'>" + bccmails + "</div>");
                                            ss.Append("<div class='tomails'  style='display:none;'>" + tomails + "</div>");
                                            ss.Append("<div class='maildate'  style='display:none;'>" + FinalDate + "</div>");
                                            ss.Append("<div class='mytos'  style='display:none;'>" + depart + "</div></div>");


                                            ss.Append("<div class='mail-list'>");

                                            ss.Append("<div class='form-check check_inptblock chk_inbox'>");
                                            ss.Append("<div class='checkbox'><label><input type='checkbox' name='InboxcheckboxChild' value='" + item.Headers["Date"] + "' /><span class='cr'><i class='cr-icon mdi mdi-check'></i></span></label></div>");
                                            ss.Append("</div>");
                                           
                                            if (StarId.Contains(item.Headers["Date"]))
                                            {
                                                ss.Append(" <div class='details star-inptbox' onclick=\"RemoveStar(this,'inbox','" + item.Headers["Date"] + "')\">                                                                                             ");
                                                ss.Append("     <i class='mdi mdi-star favorite'></i>                                                                                       ");
                                                ss.Append(" </div>                                                                                                                         ");
                                            }
                                            else
                                            {
                                                ss.Append(" <div class='details star-inptbox' onclick=\"SaveStar(this,'inbox','" + item.Headers["Date"] + "')\">                                                                                             ");
                                                ss.Append("     <i class='mdi mdi-star-outline'></i>                                                                                       ");
                                                ss.Append(" </div>                                                                                                                         ");
                                            }
                                            ss.Append(" <div class='content'>                                                                                                          ");
                                            ss.Append("     <p class='sender-name' >" + displayname + "</p>                                        ");
                                            ss.Append("     <p class='message_text nwinb_mailcont'>" + subjects + "</p>                                                                         ");
                                            ss.Append(" </div>                                                                                                                         ");
                                            ss.Append("                                                                                                                                ");
                                            ss.Append(" </div> </div>");
                                            maildatecollection.Add(item.Headers["Date"]);
                                            counter++;

                                            mailcount++;

                                            if (mailcount == 10)
                                            { break; }


                                            // if (item.Attachments.Count() > 0)
                                            //  {
                                            //     str.Append("<div class='nwinb_mailattach'></div>");
                                            //  }
                                            //string tempdate = item.Headers["Date"].ToString();
                                            //var dtt = Convert.ToDateTime(tempdate.Substring(0, tempdate.LastIndexOf(':') + 3).Trim());
                                            //if (DateTime.UtcNow.Date == dtt.Date)
                                            //{ tempdate = String.Format("{0:t}", dtt.Date); }
                                            //else
                                            //{
                                            //    tempdate = String.Format("{MMM dd}", dtt.Date);
                                            //}
                                            //str.Append("<div class='nwinb_mailtime'>" + tempdate + "</div></div>");
                                        }
                                    }
                                }

                            }
                        }

                        int RecordShow = 10;
                        var PageLinks = pagecount % RecordShow == 0 ? (pagecount / RecordShow) : (pagecount / RecordShow) + 1;
                        resp = total.ToString() + "{*^*}" + ss.ToString() + "{*^*}" + PageLinks + "{*^*}" + "done";
                    }
                        else
                        {
                            resp = total.ToString() + "{*^*}" + "0" + "{*^*}" + "0" + "{*^*}" + "nomessage";
                        }
                    }
                    else { resp = total.ToString() + "{*^*}<div class='nwinb_read' style='height:300px;'><sapn class='nofound nofoundmargin'>&lt; No Message available &gt;</span></div>"; }
                }
            }
            else { resp = "acmethod"; }


            return resp;

        }

        catch (Exception ex)
        {
            string Path = System.Web.HttpContext.Current.Server.MapPath("~/tempSaveFile.txt");

            System.IO.StreamWriter dynamicSw = new System.IO.StreamWriter(Path, true);
            dynamicSw.WriteLine(ex.Message);
            dynamicSw.Close(); dynamicSw.Dispose();

            return "0" + "{*^*}" + "0" + "{*^*}" + "0" + "{*^*}" + "fail"; ;
        }
    }

    [System.Web.Services.WebMethod(EnableSession = true)]
    public static string DeleteMail(string did, string to, string subject, string body, double Timezone,string cc,string bcc)
    {
        try
        {
            Linqconnection db = new Linqconnection();

            TrashMailsTable dm = new TrashMailsTable();

            var unique = DateTime.UtcNow.Ticks;
            int sid = Convert.ToInt32(HttpContext.Current.Session["ConfigId"]);

            if (!System.IO.Directory.Exists(System.Web.HttpContext.Current.Server.MapPath("Trash_Email/") + sid))
            {
                System.IO.Directory.CreateDirectory(System.Web.HttpContext.Current.Server.MapPath("Trash_Email/") + sid);
            }

            string path = "Trash_Email/" + sid + "/" + unique + ".xml";

            dm.InboxMailThreadID = did;
            dm.UserID = Convert.ToInt32(HttpContext.Current.Session["ConfigId"]);
            dm.EmailType = StaticKeywordClass.Inbox;
            dm.XMLPath = path;
            dm.IsDeleted = false;
            db.TrashMailsTables.InsertOnSubmit(dm);
            db.SubmitChanges();

            System.Xml.XmlTextWriter writer = new System.Xml.XmlTextWriter(System.Web.HttpContext.Current.Server.MapPath("~/") + path, System.Text.Encoding.UTF8);

            writer.WriteStartDocument(true);
            writer.Formatting = System.Xml.Formatting.Indented;
            writer.Indentation = 2;
            writer.WriteStartElement(StaticKeywordClass.Inbox);
            createNode(writer, "id", dm.ID.ToString());
            createNode(writer, "to", to);
            createNode(writer, "cc", cc);
             createNode(writer, "bcc", bcc);
            createNode(writer, "subject", subject);
            createNode(writer, "body", body);
            createNode(writer, "date", DateTime.UtcNow.AddMinutes(Timezone).ToString("MMM-dd-yyyy hh:mm tt"));
            writer.WriteEndElement();
            writer.WriteEndDocument();
            writer.Close();

            return "done";
        }
        catch (Exception)
        {
            return "fail";
        }

    }

    [System.Web.Services.WebMethod(EnableSession = true)]
    public static string DeleteDraftMail(int ID)
    {
        try
        {
            using (Linqconnection dc = new Linqconnection())
            {

                var DraftTable = dc.DraftEmailTables.FirstOrDefault(a => a.Id == ID);

                if (DraftTable != null)
                {
                    TrashMailsTable TMT = new TrashMailsTable();

                    TMT.UserID = DraftTable.UserId;
                    TMT.XMLPath = DraftTable.Draftpath;
                    TMT.EmailType = StaticKeywordClass.Draft;
                    TMT.IsDeleted = false;

                    dc.TrashMailsTables.InsertOnSubmit(TMT);
                    dc.SubmitChanges();

                    if (System.IO.File.Exists(System.Web.HttpContext.Current.Server.MapPath(TMT.XMLPath)))
                    {


                        string path = System.Web.HttpContext.Current.Server.MapPath(TMT.XMLPath);
                        XmlDocument xml = new System.Xml.XmlDocument();
                        xml.Load(path);
                        XmlNode eid = xml.DocumentElement.SelectSingleNode("/" + StaticKeywordClass.Draft + "/id");
                        eid.InnerText = TMT.ID.ToString();

                        xml.Save(path);
                    }

                    dc.DraftEmailTables.DeleteOnSubmit(DraftTable);
                    dc.SubmitChanges();
                }

                return "done";
            }
        }
        catch (Exception)
        { }

        return "";
    }

    [System.Web.Services.WebMethod(EnableSession = true)]
    public static string DeleteSentMail(int ID)
    {
        try
        {
            using (Linqconnection dc = new Linqconnection())
            {

                var SendedMails = dc.SendedMails.FirstOrDefault(a => a.Id == ID);

                if (SendedMails != null)
                {
                    TrashMailsTable TMT = new TrashMailsTable();

                    TMT.UserID = SendedMails.UserId;
                    TMT.XMLPath = SendedMails.SendMailPath;
                    TMT.EmailType = StaticKeywordClass.Sent;
                    TMT.IsDeleted = false;

                    dc.TrashMailsTables.InsertOnSubmit(TMT);
                    dc.SubmitChanges();


                    if (System.IO.File.Exists(System.Web.HttpContext.Current.Server.MapPath(TMT.XMLPath)))
                    {
                        string path = System.Web.HttpContext.Current.Server.MapPath(TMT.XMLPath);
                        XmlDocument xml = new System.Xml.XmlDocument();
                        xml.Load(path);
                        XmlNode eid = xml.DocumentElement.SelectSingleNode("/" + StaticKeywordClass.Sent + "/id");
                        eid.InnerText = TMT.ID.ToString();

                        try
                        {
                            xml.Save(path);
                        }
                        catch (Exception)
                        { }
                        
                    }


                    dc.SendedMails.DeleteOnSubmit(SendedMails);
                    dc.SubmitChanges();
                }

                return "done";
            }
        }
        catch (Exception)
        { }

        return "";
    }


    [System.Web.Services.WebMethod(EnableSession = true)]
    public static string DeleteOutboxMail(int ID)
    {
        try
        {
            using (Linqconnection dc = new Linqconnection())
            {

                var OutBoxMails = dc.OutBoxMails.FirstOrDefault(a => a.Id == ID);

                if (OutBoxMails != null)
                {
                    TrashMailsTable TMT = new TrashMailsTable();

                    TMT.UserID = OutBoxMails.UserId;
                    TMT.XMLPath = OutBoxMails.OutboxMailPath;
                    TMT.EmailType = StaticKeywordClass.Outbox;
                    TMT.IsDeleted = false;

                    dc.TrashMailsTables.InsertOnSubmit(TMT);
                    dc.SubmitChanges();

                    if (System.IO.File.Exists(System.Web.HttpContext.Current.Server.MapPath(TMT.XMLPath)))
                    {


                        string path = System.Web.HttpContext.Current.Server.MapPath(TMT.XMLPath);
                        XmlDocument xml = new System.Xml.XmlDocument();
                        xml.Load(path);
                        XmlNode eid = xml.DocumentElement.SelectSingleNode("/" + StaticKeywordClass.Outbox + "/id");
                        eid.InnerText = TMT.ID.ToString();

                        xml.Save(path);
                    }

                    dc.OutBoxMails.DeleteOnSubmit(OutBoxMails);
                    dc.SubmitChanges();
                }

                return "done";
            }
        }
        catch (Exception)
        { }

        return "";
    }

    [System.Web.Services.WebMethod()]
    public static string OpenTrash(string search, int skip, double SystemTimeZone)
    {
        List<ListMailDetails> Collection = new List<ListMailDetails>();
        try
        {
            Linqconnection db = new Linqconnection();

            int sid = Convert.ToInt32(HttpContext.Current.Session["ConfigId"]);

            if (sid == 0)
            {
                return "0" + "{*^*}" + "0" + "{*^*}" + "nocre" + "{*^*}" + "0";
            }

            var record = from rec in db.TrashMailsTables
                         where rec.UserID == sid && rec.IsDeleted == false
                         select rec;
            int count = record.Count();
            var RecordSkip = (skip - 1) * 10;
            record = record.OrderByDescending(a => a.ID);

            int counter = 0;


            if (count == 0)
            {
                return "0" + "{*^*}" + "0" + "{*^*}" + "nomessage" + "{*^*}" + "0";
            }

            StringBuilder ss = new StringBuilder();
            foreach (var item in record)
            {
                System.Xml.XmlDocument doc = new System.Xml.XmlDocument();

                try
                {
                    doc.Load(System.Web.HttpContext.Current.Server.MapPath(item.XMLPath));
                }
                catch (Exception)
                {
                    continue;
                }

                System.Xml.XmlNode id = doc.DocumentElement.SelectSingleNode("/" + item.EmailType + "/id");
                System.Xml.XmlNode to = doc.DocumentElement.SelectSingleNode("/" + item.EmailType + "/to");
                System.Xml.XmlNode sub = doc.DocumentElement.SelectSingleNode("/" + item.EmailType + "/subject");
                System.Xml.XmlNode body = doc.DocumentElement.SelectSingleNode("/" + item.EmailType + "/body");
                System.Xml.XmlNode cc = doc.DocumentElement.SelectSingleNode("/" + item.EmailType + "/cc");
                System.Xml.XmlNode bcc = doc.DocumentElement.SelectSingleNode("/" + item.EmailType + "/bcc");
                System.Xml.XmlNode date = doc.DocumentElement.SelectSingleNode("/" + item.EmailType + "/date");
                var tos = "";
                string[] spltto = to.InnerText.Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries);
                if (cc != null)
                {
                    string[] spltcc = cc.InnerText.Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries);
                    for (int i = 0; i < spltcc.Length; i++)
                    {
                        if (spltcc[i] != "")
                        {
                            tos += spltcc[i] + ",";
                        }
                    }
                }
                for (int i = 0; i < spltto.Length; i++)
                {
                    if (spltto[i] != "")
                    {
                        tos += spltto[i] + ",";
                    }
                }
               
                Collection.Add(new ListMailDetails { ID = id.InnerText, Subject = (string.IsNullOrEmpty(sub.InnerText) ? "" : sub.InnerText), Body = (string.IsNullOrEmpty(body.InnerText) ? "" : body.InnerText), CC = (cc != null ? (string.IsNullOrEmpty(cc.InnerText) ? "" : cc.InnerText) : ""), BCC = (bcc != null ? (string.IsNullOrEmpty(bcc.InnerText) ? "" : bcc.InnerText) : ""), Date = date.InnerText, To = (string.IsNullOrEmpty(to.InnerText) ? "" : to.InnerText),Replyall=tos });

            }
            if (!search.Equals(""))
            {
                Collection = Collection.Where(a => (string.IsNullOrEmpty(a.Subject) ? "" : a.Subject).ToLower().Trim().Contains(search.ToLower().Trim()) || (string.IsNullOrEmpty(a.To) ? "" : a.To).ToLower().Trim().Contains(search.ToLower().Trim())).ToList();
            }
            var CollectionCount = Collection.Count();
            Collection = Collection.Skip(RecordSkip).Take(10).ToList();

                foreach(var items in Collection){

                    DateTime TodayDate = DateTime.UtcNow.AddMinutes(SystemTimeZone);
                    DateTime ItemDate;
                    string FinalDate = "";
                    try
                    {
                        ItemDate = Convert.ToDateTime(items.Date);
                        string HowManyHours = Math.Round(TodayDate.Subtract(ItemDate).TotalHours, 2).ToString();
                        string HowManyMinutes = Math.Round(TodayDate.Subtract(ItemDate).TotalMinutes, 2).ToString();
                        string[] dt = HowManyHours.Split(new string[] { "." }, StringSplitOptions.RemoveEmptyEntries);
                        string[] dt1 = HowManyMinutes.Split(new string[] { "." }, StringSplitOptions.RemoveEmptyEntries);
                        FinalDate = (Convert.ToDateTime(ItemDate).Date == DateTime.UtcNow.Date ? (dt[0] != "0" ? dt[0] + " hours ago" : dt1[0] + " minutes ago") : (Convert.ToDateTime(ItemDate)).Date == DateTime.UtcNow.AddDays(-1).Date ? "Yesterday " + Convert.ToDateTime(ItemDate).ToString("hh:mm tt") : Convert.ToDateTime(ItemDate).ToString("dd MMM yyyy hh:mm tt"));
                    }
                    catch
                    {
                        FinalDate = items.Date;
                    }
                    if (counter == 0)
                    {
                        ss.Append("<div class='nwinb_read' id='first'  onclick='TrashEmaildetails(this);'>");
                    }
                    else
                    {
                        ss.Append("<div class='nwinb_read'  onclick='TrashEmaildetails(this);'>");
                    }



                    ss.Append("<div class='nwinb_chkbox'>");

                    ss.Append("<div class='cbdiv'></div><div class='thisemailbody' style='display:none;'>" + (string.IsNullOrEmpty(items.Body) ? "-" : (DecodeQuotedPrintables(items.Body, ""))) + "</div>");
                    ss.Append("<div class='mysub'  style='display:none;'>" + items.Subject + "</div>");
                    ss.Append("<div class='uid'  style='display:none;'>" + items.ID + "</div>");
                    ss.Append("<div class='maildate'  style='display:none;'>" + FinalDate + "</div>");
                    ss.Append("<div class='ccmails'  style='display:none;'>" + items.CC + "</div>");
                    ss.Append("<div class='bccmails'  style='display:none;'>" + items.BCC + "</div>");
                    ss.Append("<div class='mytos'  style='display:none;'>" + items.To + "</div>");
                    ss.Append("<div class='replyallmails'  style='display:none;'>" + items.Replyall + "</div></div>");
                    ss.Append("<div class='mail-list'>");

                    ss.Append("<div class='form-check check_inptblock chk_inbox'><div class='checkbox'><label><input type='checkbox' name='TrashcheckboxChild' value='" + items.ID + "' /><span class='cr'><i class='cr-icon mdi mdi-check'></i></span></label></div></div>");
                    //ss.Append("<div class='form-check check_inptblock chk_inbox' style='display:none;'>");
                    //ss.Append("     <div class='checkbox'>                                                                                                     ");
                    //ss.Append("         <label>                                                                                                                ");
                    //ss.Append("             <input type='checkbox' name='Checkbox1' value='" + items.ID + "' /><span class='cr'><i class='cr-icon mdi mdi-check'></i></span></label>      ");
                    //ss.Append("     </div>                                                                                                                     ");
                    //ss.Append(" </div>                                                                                                                         ");

                    ss.Append(" <div class='details star-inptbox'>                                                                                             ");
                    ss.Append("     <i class='mdi mdi-star-outline'></i>                                                                                       ");
                    ss.Append(" </div>                                                                                                                         ");
                    ss.Append(" <div class='content'>                                                                                                          ");
                    ss.Append("     <p class='sender-name' >" + items.To + "</p>                                        ");
                    ss.Append("     <p class='message_text nwinb_mailcont'>" + items.Subject + "</p>                                                                         ");
                    ss.Append(" </div>                                                                                                                         ");
                    ss.Append("                                                                                                                                ");
                    ss.Append(" </div> </div>");
                    counter++;
               

            }


            if (counter == 0)
            {
                return "0" + "{*^*}" + "0" + "{*^*}" + "nomessage" + "{*^*}" + "0";
            }
            int RecordShow = 10;
            var PageLinks = CollectionCount % RecordShow == 0 ? (CollectionCount / RecordShow) : (CollectionCount / RecordShow) + 1;

            return ss.ToString() + "{*^*}" + count + "{*^*}" + "done" + "{*^*}" + PageLinks;
        }

        catch (Exception ex)
        {
            return "0" + "{*^*}" + "0" + "{*^*}" + "fail" + "{*^*}" + "0";
        }

    }

    [System.Web.Services.WebMethod(EnableSession = true)]
    public static string ResetCredentails()
    {
        int MasterID = Convert.ToInt32(HttpContext.Current.Session["ConfigId"] ?? "0");

        try
        {
            using (Linqconnection dc = new Linqconnection())
            {
                var MasterTable = dc.EmailConfigs.FirstOrDefault(a => a.Id == MasterID);

                if (MasterTable != null)
                {
                    MasterTable.IsDeleted = true;
                    dc.SubmitChanges();
                }

                HttpContext.Current.Session["ConfigId"] = null;
            }

            //Linqconnection db = new Linqconnection();

            //var record = from rec in db.EmailConfigs
            //             select rec;

            //db.EmailConfigs.DeleteAllOnSubmit(record);
            //db.SubmitChanges();
            return "done";
        }
        catch (Exception ex)
        {
            return ex.Message.ToString();
        }

    }

    [System.Web.Services.WebMethod(EnableSession = true)]
    public static string Draftmail(string to, string body, string sub, string cc, string bcc, double systemTimeZone, string attach)
    {

        try
        {
            Linqconnection db = new Linqconnection();

            DraftEmailTable de = new DraftEmailTable();

            var unique = DateTime.UtcNow.Ticks;
            int sid = Convert.ToInt32(HttpContext.Current.Session["ConfigId"]);

            if (!System.IO.Directory.Exists(System.Web.HttpContext.Current.Server.MapPath("Draft_Email/") + sid))
            {
                System.IO.Directory.CreateDirectory(System.Web.HttpContext.Current.Server.MapPath("Draft_Email/") + sid);
            }

            string path = "Draft_Email/" + sid + "/" + unique + ".xml";

            de.UserId = Convert.ToInt32(HttpContext.Current.Session["ConfigId"]);
            de.Draftpath = path;

            db.DraftEmailTables.InsertOnSubmit(de);
            db.SubmitChanges();

            System.Xml.XmlTextWriter writer = new System.Xml.XmlTextWriter(System.Web.HttpContext.Current.Server.MapPath("~/") + path, System.Text.Encoding.UTF8);

            writer.WriteStartDocument(true);
            writer.Formatting = System.Xml.Formatting.Indented;
            writer.Indentation = 2;
            writer.WriteStartElement(StaticKeywordClass.Draft);
            createNode(writer, "id", de.Id.ToString());
            createNode(writer, "to", to);
            createNode(writer, "cc", cc);
            createNode(writer, "bcc", bcc);
            createNode(writer, "subject", sub);
            createNode(writer, "body", body);
            createNode(writer, "attach", attach);
            createNode(writer, "date", DateTime.UtcNow.AddMinutes(systemTimeZone).ToString("MMM-dd-yyyy HH:mm tt"));
            writer.WriteEndElement();
            writer.WriteEndDocument();
            writer.Close();




            return "done";
        }
        catch (Exception ex)
        {
            return "fail";
        }

    }


    [System.Web.Services.WebMethod(EnableSession = true)]
    public static string DraftMessage(string search, int skip, double SystemTimeZone)
    {
        List<ListMailDetails>Collection=new List<ListMailDetails>();
        try
        {
            Linqconnection db = new Linqconnection();

            int sid = Convert.ToInt32(HttpContext.Current.Session["ConfigId"]);

            var record = from rec in db.DraftEmailTables
                         where rec.UserId == sid
                         select rec;

            var StarId = (from re in db.StarredEmailTables.AsEnumerable()
                          where re.UserId == sid && re.IsInbox == false
                          select re.EmailId).ToArray();
            var RecordSkip = (skip - 1) * 10;
            int count = record.Count();
            record = record.OrderByDescending(a => a.Id);


            int counter = 0;


            if (count == 0)
            {
                return "0" + "{*^*}" + "0" + "{*^*}" + "nomessage" + "{*^*}" + "0";
            }

            StringBuilder ss = new StringBuilder();
            foreach (var item in record)
            {


                System.Xml.XmlDocument doc = new System.Xml.XmlDocument();
                try
                {
                    doc.Load(System.Web.HttpContext.Current.Server.MapPath(item.Draftpath));
                }
                catch (Exception)
                {
                    continue;
                }

                System.Xml.XmlNode id = doc.DocumentElement.SelectSingleNode("/" + StaticKeywordClass.Draft + "/id");
                System.Xml.XmlNode to = doc.DocumentElement.SelectSingleNode("/" + StaticKeywordClass.Draft + "/to");
                System.Xml.XmlNode sub = doc.DocumentElement.SelectSingleNode("/" + StaticKeywordClass.Draft + "/subject");
                System.Xml.XmlNode body = doc.DocumentElement.SelectSingleNode("/" + StaticKeywordClass.Draft + "/body");
                System.Xml.XmlNode cc = doc.DocumentElement.SelectSingleNode("/" + StaticKeywordClass.Draft + "/cc");
                System.Xml.XmlNode bcc = doc.DocumentElement.SelectSingleNode("/" + StaticKeywordClass.Draft + "/bcc");
                System.Xml.XmlNode Attachement = doc.DocumentElement.SelectSingleNode("/" + StaticKeywordClass.Draft + "/attach");
                System.Xml.XmlNode date = doc.DocumentElement.SelectSingleNode("/" + StaticKeywordClass.Draft + "/date");

                var tos = "";
                string[] spltto = to.InnerText.Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries);
                string[] spltcc = cc.InnerText.Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries);

                for (int i = 0; i < spltto.Length; i++)
                {
                    if (spltto[i] != "")
                    {
                        tos += spltto[i] + ",";
                    }
                }
                for (int i = 0; i < spltcc.Length; i++)
                {
                    if (spltcc[i] != "")
                    {
                        tos += spltcc[i] + ",";
                    }
                }
                // Adding Records in List Collection 
                Collection.Add(new ListMailDetails { ID = id.InnerText, To = to.InnerText, Body = (string.IsNullOrEmpty(body.InnerText) ? "" : body.InnerText), Subject = (string.IsNullOrEmpty(sub.InnerText) ? "" : sub.InnerText), CC = (string.IsNullOrEmpty(cc.InnerText) ? "" : cc.InnerText), BCC = (string.IsNullOrEmpty(bcc.InnerText) ? "" : bcc.InnerText), Attachement = (Attachement != null ? (string.IsNullOrEmpty(Attachement.InnerText) ? "" : Attachement.InnerText) : ""), Date = date.InnerText,Replyall=tos });
            }

                if(!search.Equals("")){
                    Collection = Collection.Where(s => (string.IsNullOrEmpty(s.Subject) ? "" : s.Subject).ToLower().Trim().Contains(search.ToLower().Trim()) || (string.IsNullOrEmpty(s.To) ? "" : s.To).ToLower().Trim().Contains(search.ToLower().Trim())).ToList();
                }
                var CollectionCount = Collection.Count();
            Collection=Collection.Skip(RecordSkip).Take(10).ToList();

                  foreach(var item in Collection)
                {
                    DateTime TodayDate = DateTime.UtcNow.AddMinutes(SystemTimeZone);
                    DateTime ItemDate;
                    string FinalDate = "";
                    try
                    {
                        ItemDate = Convert.ToDateTime(item.Date);
                        string HowManyHours = Math.Round(TodayDate.Subtract(ItemDate).TotalHours, 2).ToString();
                        string HowManyMinutes = Math.Round(TodayDate.Subtract(ItemDate).TotalMinutes, 2).ToString();
                        string[] dt = HowManyHours.Split(new string[] { "." }, StringSplitOptions.RemoveEmptyEntries);
                        string[] dt1 = HowManyMinutes.Split(new string[] { "." }, StringSplitOptions.RemoveEmptyEntries);
                       FinalDate = (Convert.ToDateTime(ItemDate).Date == DateTime.UtcNow.Date ? (dt[0] != "0" ? dt[0] + " hours ago" : dt1[0] + " minutes ago") : (Convert.ToDateTime(ItemDate)).Date == DateTime.UtcNow.AddDays(-1).Date ? "Yesterday " + Convert.ToDateTime(ItemDate).ToString("hh:mm tt") : Convert.ToDateTime(ItemDate).ToString("dd MMM yyyy hh:mm tt"));
                    }
                    catch
                    {
                        FinalDate = item.Date;
                    }
                    

                   if (counter == 0)
                    {
                        ss.Append("<div class='nwinb_read' id='first'  onclick='DraftEmaildetails(this);'>");
                    }
                    else
                    {
                        ss.Append("<div class='nwinb_read'  onclick='DraftEmaildetails(this);'>");
                    }



                    ss.Append("<div class='nwinb_chkbox'>");

                    ss.Append("<div class='cbdiv'></div><div class='thisemailbody' style='display:none;'>" + (item.Body) + "</div>");
                    ss.Append("<div class='mysub'  style='display:none;'>" + item.Subject + "</div>");
                    ss.Append("<div class='uid'  style='display:none;'>" +item.ID + "</div>");
                    ss.Append("<div class='maildate'  style='display:none;'>" + FinalDate + "</div>");
                    ss.Append("<div class='ccmails'  style='display:none;'>" + item.CC+ "</div>");
                    ss.Append("<div class='bccmails'  style='display:none;'>" + item.BCC + "</div>");
                    ss.Append("<div class='mytos'  style='display:none;'>" + item.To + "</div>");
                    ss.Append("<div class='replyallmails'  style='display:none;'>" + item.Replyall + "</div></div>");
                    ss.Append("<div class='file-attachted myattach' style='display:none;'>");
                    if (item.Attachement != null)
                    {
                        if (item.Attachement != "")
                        {
                            string[] attachsplit = item.Attachement.Split(',');
                            for (var i = 0; i < attachsplit.Length; i++)
                            {
                                var ext2 = attachsplit[i].Split('.');
                                if (ext2[1] == "doc" || ext2[1] == "docx")
                                {
                                    ss.Append("<a href='AttachmentDownload.ashx?path=" + attachsplit[i] + "'><div class='img-thumbnail img-attachment'><img src='images/word-icon.png' /><span class='file-attachted-name'>" + attachsplit[i] + "</span> <span class='file-attachted-size'></span><div class='doc_downlod_hovr'><span class='mdi mdi-download' onclick=''></span></div></div></a>");
                                }
                                else if (ext2[1] == "xlsx" || ext2[1] == "xlsm" || ext2[1] == "xltx" || ext2[1] == "xltm" || ext2[1] == "xls" || ext2[1] == "xlt")
                                {
                                    ss.Append("<a href='AttachmentDownload.ashx?path=" + attachsplit[i] + "'><div class='img-thumbnail img-attachment'><img src='images/excel-icon.png' /><span class='file-attachted-name'>" + attachsplit[i] + "</span> <span class='file-attachted-size'></span><div class='doc_downlod_hovr'><span class='mdi mdi-download' onclick=''></span></div></div></a>");
                                }
                                else if (ext2[1] == "jpg" || ext2[1] == "jpeg" || ext2[1] == "png")
                                {
                                    ss.Append("<a href='AttachmentDownload.ashx?path=" + attachsplit[i] + "'><div class='img-thumbnail img-attachment'><img src='images/img-large-icon.png' /><span class='file-attachted-name'>" + attachsplit[i] + "</span> <span class='file-attachted-size'></span><div class='doc_downlod_hovr'><span class='mdi mdi-download' onclick=''></span></div></div></a>");
                                }
                                else if (ext2[1] == "pdf" || ext2[1] == "PDF")
                                {
                                    ss.Append("<a href='AttachmentDownload.ashx?path=" + attachsplit[i] + "'><div class='img-thumbnail img-attachment'><img src='images/pdf-large-icon.png' /><span class='file-attachted-name'>" + attachsplit[i] + "</span><span class='file-attachted-size'></span><div class='doc_downlod_hovr'><span class='mdi mdi-download' onclick=''></span></div></div></a>");
                                }
                                else if (ext2[1] == "txt")
                                {
                                    ss.Append("<a href='AttachmentDownload.ashx?path=" + attachsplit[i] + "'><div class='img-thumbnail img-attachment'><img src='images/text-large-icon.png' /><span class='file-attachted-name'>" + attachsplit[i] + "</span><span class='file-attachted-size'></span><div class='doc_downlod_hovr'><span class='mdi mdi-download' onclick=''></span></div></div></a>");
                                }
                                else if (ext2[1] == "pptx" || ext2[1] == "ppt")
                                {
                                    ss.Append("<a href='AttachmentDownload.ashx?path=" + attachsplit[i] + "'><div class='img-thumbnail img-attachment'><img src='images/PowerPoint-icon.png' /><span class='file-attachted-name'>" + attachsplit[i] + "</span> <span class='file-attachted-size'></span><div class='doc_downlod_hovr'><span class='mdi mdi-download' onclick=''></span></div></div></a>");
                                }

                            }
                        }
                    }

                    ss.Append("</div>");
                    ss.Append("<div class='mail-list'>");

                    ss.Append("<div class='form-check check_inptblock chk_inbox'><div class='checkbox'><label><input type='checkbox' name='DraftcheckboxChild' value='" + item.ID + "' /><span class='cr'><i class='cr-icon mdi mdi-check'></i></span></label></div></div>");
                    //ss.Append("<div class='form-check check_inptblock chk_inbox' style='display:none;'>");
                    //ss.Append("     <div class='checkbox'>                                                                                                     ");
                    //ss.Append("         <label>                                                                                                                ");
                    //ss.Append("             <input type='checkbox' name='Checkbox1' value='" + item.ID + "' /><span class='cr'><i class='cr-icon mdi mdi-check'></i></span></label>      ");
                    //ss.Append("     </div>                                                                                                                     ");
                    //ss.Append(" </div>                                                                                                                         ");
                    if (StarId.Contains(item.ID))
                    {
                        ss.Append(" <div class='details star-inptbox' onclick=\"RemoveStar(this,'draft''" + item.ID + "')\">                                                                                             ");
                        ss.Append("     <i class='mdi mdi-star favorite'></i>                                                                                       ");
                        ss.Append(" </div>                                                                                                                         ");
                    }
                    else
                    {
                        ss.Append(" <div class='details star-inptbox' onclick=\"SaveStar(this,'draft','" + item.ID + "')\">                                                                                             ");
                        ss.Append("     <i class='mdi mdi-star-outline'></i>                                                                                       ");
                        ss.Append(" </div>                                                                                                                         ");
                    }
                    ss.Append(" <div class='content'>                                                                                                          ");
                    ss.Append("     <p class='sender-name' >" + (string.IsNullOrEmpty(item.To) ? "(no recipients)" : item.To) + "</p>                                        ");
                    ss.Append("     <p class='message_text nwinb_mailcont'>" + (string.IsNullOrEmpty(item.Subject) ? "(no subject)" : item.Subject) + "</p>                                                                         ");
                    ss.Append(" </div>                                                                                                                         ");
                    ss.Append("                                                                                                                                ");
                    ss.Append(" </div> </div>");
                    counter++;
              
            }

            if (counter == 0)
            {
                return "0" + "{*^*}" + "0" + "{*^*}" + "nomessage" + "{*^*}" + "0";
            }
            int RecordShow = 10;
            var PageLinks = CollectionCount % RecordShow == 0 ? (CollectionCount / RecordShow) : (CollectionCount / RecordShow) + 1;

            return ss.ToString() + "{*^*}" + count + "{*^*}" + "done" + "{*^*}" + PageLinks;
        }
        catch (Exception ex)
        {

            return "0" + "{*^*}" + "0" + "{*^*}" + "fail" + "{*^*}" + "0";
        }
    }

    [System.Web.Services.WebMethod(EnableSession = true)]
    public static string SendBoxMsg(string search, int skip, double SystemTimeZone)
    {
        List<ListMailDetails>Collection=new List<ListMailDetails>();
        try
        {

            Linqconnection db = new Linqconnection();

            int sid = Convert.ToInt32(HttpContext.Current.Session["ConfigId"]);

            var record = from rec in db.SendedMails
                         where rec.UserId == sid
                         select rec;

            var StarId = (from re in db.StarredEmailTables.AsEnumerable()
                          where re.UserId == sid && re.IsInbox == false
                          select re.EmailId).ToArray();
            int count = record.Count();
            var RecordSkip = (skip - 1) * 10;
            record=record.OrderByDescending(a=>a.Id);

            int counter = 0;


            if (count == 0)
            {
                return "0" + "{*^*}" + "0" + "{*^*}" + "nomessage" + "{*^*}" + "0";
            }

            StringBuilder ss = new StringBuilder();
            foreach (var item in record)
            {
                System.Xml.XmlDocument doc = new System.Xml.XmlDocument();

                try
                {
                    doc.Load(System.Web.HttpContext.Current.Server.MapPath(item.SendMailPath));
                }
                catch (Exception)
                {
                    continue;
                }
                System.Xml.XmlNode id = doc.DocumentElement.SelectSingleNode("/" + StaticKeywordClass.Sent + "/id");
                System.Xml.XmlNode to = doc.DocumentElement.SelectSingleNode("/" + StaticKeywordClass.Sent + "/to");
                System.Xml.XmlNode sub = doc.DocumentElement.SelectSingleNode("/" + StaticKeywordClass.Sent + "/subject");
                System.Xml.XmlNode body = doc.DocumentElement.SelectSingleNode("/" + StaticKeywordClass.Sent + "/body");
                System.Xml.XmlNode cc = doc.DocumentElement.SelectSingleNode("/" + StaticKeywordClass.Sent + "/cc");
                System.Xml.XmlNode bcc = doc.DocumentElement.SelectSingleNode("/" + StaticKeywordClass.Sent + "/bcc");
                System.Xml.XmlNode date = doc.DocumentElement.SelectSingleNode("/" + StaticKeywordClass.Sent + "/date");
                System.Xml.XmlNode Attachement = doc.DocumentElement.SelectSingleNode("/" + StaticKeywordClass.Sent + "/Attachement");
                var tos = "";
                string[] spltto = to.InnerText.Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries);
                string[] spltcc = cc.InnerText.Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries);

                for (int i = 0; i < spltto.Length; i++)
                {
                    if (spltto[i] != "")
                    {
                        tos += spltto[i] + ",";
                    }
                }
                for (int i = 0; i < spltcc.Length; i++)
                {
                    if (spltcc[i] != "")
                    {
                        tos += spltcc[i] + ",";
                    }
                }

                
                Collection.Add(new ListMailDetails { ID = id.InnerText, To = to.InnerText, Subject = (string.IsNullOrEmpty(sub.InnerText) ? "" : sub.InnerText), Body = (string.IsNullOrEmpty(body.InnerText) ? "" : body.InnerText), CC = (string.IsNullOrEmpty(cc.InnerText) ? "" : cc.InnerText), BCC = (string.IsNullOrEmpty(bcc.InnerText) ? "" : bcc.InnerText), Date = date.InnerText, Attachement = (Attachement != null ? (string.IsNullOrEmpty(Attachement.InnerText) ? "" : Attachement.InnerText) : ""),Replyall=tos });
            }

            if(!search.Equals("")){
                Collection=Collection.Where(s=>s.To.ToLower().Trim().Contains(search.ToLower().Trim())||s.Subject.ToLower().Trim().Contains(search.ToLower().Trim())).ToList();
            }
            var CollectionCount = Collection.Count();
            Collection = Collection.Skip(RecordSkip).Take(10).ToList();
        
            foreach(var item in Collection)
            {
                DateTime TodayDate = DateTime.UtcNow.AddMinutes(SystemTimeZone);
                DateTime ItemDate;
                string FinalDate = "";
                try
                {
                    ItemDate = Convert.ToDateTime(item.Date);
                    string HowManyHours = Math.Round(TodayDate.Subtract(ItemDate).TotalHours, 2).ToString();
                    string HowManyMinutes = Math.Round(TodayDate.Subtract(ItemDate).TotalMinutes, 2).ToString();
                    string[] dt = HowManyHours.Split(new string[] { "." }, StringSplitOptions.RemoveEmptyEntries);
                    string[] dt1 = HowManyMinutes.Split(new string[] { "." }, StringSplitOptions.RemoveEmptyEntries);
                    FinalDate = (Convert.ToDateTime(ItemDate).Date == DateTime.UtcNow.Date ? (dt[0] != "0" ? dt[0] + " hours ago" : dt1[0] + " minutes ago") : (Convert.ToDateTime(ItemDate)).Date == DateTime.UtcNow.AddDays(-1).Date ? "Yesterday " + Convert.ToDateTime(ItemDate).ToString("hh:mm tt") : Convert.ToDateTime(ItemDate).ToString("dd MMM yyyy hh:mm tt"));
                }
                catch
                {
                    FinalDate = item.Date;
                }
                    if (counter == 0)
                    {
                        ss.Append("<div class='nwinb_read' id='first'  onclick='SendEmaildetails(this);'>");
                    }
                    else
                    {
                        ss.Append("<div class='nwinb_read'  onclick='SendEmaildetails(this);'>");
                    }



                    ss.Append("<div class='nwinb_chkbox'>");

                    ss.Append("<div class='cbdiv'></div><div class='thisemailbody' style='display:none;'>" + (string.IsNullOrEmpty(item.Body) ? "-" : (DecodeQuotedPrintables(item.Body, ""))) + "</div>");
                    ss.Append("<div class='mysub'  style='display:none;'>" + item.Subject + "</div>");
                    ss.Append("<div class='uid'  style='display:none;'>" + item.ID + "</div>");
                    ss.Append("<div class='maildate'  style='display:none;'>" + FinalDate + "</div>");
                    ss.Append("<div class='ccmails'  style='display:none;'>" + item.CC + "</div>");
                    ss.Append("<div class='bccmails'  style='display:none;'>" + item.BCC + "</div>");
                    ss.Append("<div class='mytos'  style='display:none;'>" + item.To + "</div>");
                    ss.Append("<div class='replyallmails'  style='display:none;'>" + item.Replyall + "</div></div>");
                    ss.Append("<div class='file-attachted myattach' style='display:none;'>");
                    if (item.Attachement != null)
                    {
                        if (item.Attachement != "")
                        {
                            string[] attachsplit = item.Attachement.Split(',');
                            for (var i = 0; i < attachsplit.Length; i++)
                            {
                                var ext2 = attachsplit[i].Split('.');
                                if (ext2[1] == "doc" || ext2[1] == "docx")
                                {
                                    ss.Append("<a href='AttachmentDownload.ashx?path=" + attachsplit[i] + "'><div class='img-thumbnail img-attachment'><img src='images/word-icon.png' /><span class='file-attachted-name'>" + attachsplit[i] + "</span> <span class='file-attachted-size'></span><div class='doc_downlod_hovr'><span class='mdi mdi-download' onclick=''></span></div></div></a>");
                                }
                                else if (ext2[1] == "xlsx" || ext2[1] == "xlsm" || ext2[1] == "xltx" || ext2[1] == "xltm" || ext2[1] == "xls" || ext2[1] == "xlt")
                                {
                                    ss.Append("<a href='AttachmentDownload.ashx?path=" + attachsplit[i] + "'><div class='img-thumbnail img-attachment'><img src='images/excel-icon.png' /><span class='file-attachted-name'>" + attachsplit[i] + "</span> <span class='file-attachted-size'></span><div class='doc_downlod_hovr'><span class='mdi mdi-download' onclick=''></span></div></div></a>");
                                }
                                else if (ext2[1] == "jpg" || ext2[1] == "jpeg" || ext2[1] == "png")
                                {
                                    ss.Append("<a href='AttachmentDownload.ashx?path=" + attachsplit[i] + "'><div class='img-thumbnail img-attachment'><img src='images/img-large-icon.png' /><span class='file-attachted-name'>" + attachsplit[i] + "</span> <span class='file-attachted-size'></span><div class='doc_downlod_hovr'><span class='mdi mdi-download' onclick=''></span></div></div></a>");
                                }
                                else if (ext2[1] == "pdf" || ext2[1] == "PDF")
                                {
                                    ss.Append("<a href='AttachmentDownload.ashx?path=" + attachsplit[i] + "'><div class='img-thumbnail img-attachment'><img src='images/pdf-large-icon.png' /><span class='file-attachted-name'>" + attachsplit[i] + "</span><span class='file-attachted-size'></span><div class='doc_downlod_hovr'><span class='mdi mdi-download' onclick=''></span></div></div></a>");
                                }
                                else if (ext2[1] == "txt")
                                {
                                    ss.Append("<a href='AttachmentDownload.ashx?path=" + attachsplit[i] + "'><div class='img-thumbnail img-attachment'><img src='images/text-large-icon.png' /><span class='file-attachted-name'>" + attachsplit[i] + "</span><span class='file-attachted-size'></span><div class='doc_downlod_hovr'><span class='mdi mdi-download' onclick=''></span></div></div></a>");
                                }
                                else if (ext2[1] == "pptx" || ext2[1] == "ppt")
                                {
                                    ss.Append("<a href='AttachmentDownload.ashx?path=" + attachsplit[i] + "'><div class='img-thumbnail img-attachment'><img src='images/PowerPoint-icon.png' /><span class='file-attachted-name'>" + attachsplit[i] + "</span> <span class='file-attachted-size'></span><div class='doc_downlod_hovr'><span class='mdi mdi-download' onclick=''></span></div></div></a>");
                                }

                            }
                        }
                    }

                    ss.Append("</div>");

                    ss.Append("<div class='mail-list'>");

                    ss.Append("<div class='form-check check_inptblock chk_inbox'><div class='checkbox'><label><input type='checkbox' name='SentcheckboxChild' value='" + item.ID + "' /><span class='cr'><i class='cr-icon mdi mdi-check'></i></span></label></div></div>");

                    if (StarId.Contains(item.ID))
                    {
                        ss.Append(" <div class='details star-inptbox' onclick=\"RemoveStar(this,'sent','" + item.ID + "')\">                                                                                             ");
                        ss.Append("     <i class='mdi mdi-star favorite'></i>                                                                                       ");
                        ss.Append(" </div>                                                                                                                         ");
                    }
                    else
                    {
                        ss.Append(" <div class='details star-inptbox' onclick=\"SaveStar(this,'sent','" + item.ID + "')\">                                                                                             ");
                        ss.Append("     <i class='mdi mdi-star-outline'></i>                                                                                       ");
                        ss.Append(" </div>                                                                                                                         ");
                    }

                    ss.Append(" <div class='content'>                                                                                                          ");
                    ss.Append("     <p class='sender-name' >" + item.To + "</p>                                        ");
                    ss.Append("     <p class='message_text nwinb_mailcont'>" + item.Subject + "</p>                                                                         ");
                    ss.Append(" </div>                                                                                                                         ");
                    ss.Append("                                                                                                                                ");
                    ss.Append(" </div> </div>");
                    counter++;
                

            }


            if (counter == 0)
            {
                return "0" + "{*^*}" + "0" + "{*^*}" + "nomessage" + "{*^*}" + "0";
            }


            int RecordShow = 10;
            var PageLinks = CollectionCount % RecordShow == 0 ? (CollectionCount / RecordShow) : (CollectionCount / RecordShow) + 1;
            return ss.ToString() + "{*^*}" + count + "{*^*}" + "done" + "{*^*}" + PageLinks;
        }
        catch (Exception ex)
        {
            return "0" + "{*^*}" + "0" + "{*^*}" + "fail" + "{*^*}" + "0";
        }
    }

    [System.Web.Services.WebMethod(EnableSession = true)]
    public static string OpenOutBox(string search, int skip, double SystemTimezone)
    {
        List<ListMailDetails>Collection=new List<ListMailDetails>();
        try
        {

            Linqconnection db = new Linqconnection();

            int sid = Convert.ToInt32(HttpContext.Current.Session["ConfigId"] ?? "0");

            if (sid == 0)
            {
                return "0" + "{*^*}" + "0" + "{*^*}" + "nocre" + "{*^*}" + "0";
            }

            var record = from rec in db.OutBoxMails
                         where rec.UserId == sid
                         select rec;
            int count = record.Count();
           var RecordSkip = (skip - 1) * 10;
            record = record.OrderByDescending(a => a.Id);
            int counter = 0;


            if (count == 0)
            {
                return "0" + "{*^*}" + "0" + "{*^*}" + "nomessage" + "{*^*}" + "0";
            }

            StringBuilder ss = new StringBuilder();
            foreach (var item in record)
            {
                System.Xml.XmlDocument doc = new System.Xml.XmlDocument();
                doc.Load(System.Web.HttpContext.Current.Server.MapPath(item.OutboxMailPath));
                System.Xml.XmlNode id = doc.DocumentElement.SelectSingleNode("/" + StaticKeywordClass.Outbox + "/id");
                System.Xml.XmlNode to = doc.DocumentElement.SelectSingleNode("/" + StaticKeywordClass.Outbox + "/to");
                System.Xml.XmlNode sub = doc.DocumentElement.SelectSingleNode("/" + StaticKeywordClass.Outbox + "/subject");
                System.Xml.XmlNode body = doc.DocumentElement.SelectSingleNode("/" + StaticKeywordClass.Outbox + "/body");
                System.Xml.XmlNode cc = doc.DocumentElement.SelectSingleNode("/" + StaticKeywordClass.Outbox + "/cc");
                System.Xml.XmlNode bcc = doc.DocumentElement.SelectSingleNode("/" + StaticKeywordClass.Outbox + "/bcc");
                System.Xml.XmlNode date = doc.DocumentElement.SelectSingleNode("/" + StaticKeywordClass.Outbox + "/date");
                System.Xml.XmlNode Attachement = doc.DocumentElement.SelectSingleNode("/" + StaticKeywordClass.Sent + "/Attachement");

                Collection.Add(new ListMailDetails { ID = id.InnerText, To = to.InnerText, Subject = (string.IsNullOrEmpty(sub.InnerText) ? "" : sub.InnerText), Date = date.InnerText, Body = (string.IsNullOrEmpty(body.InnerText) ? "" : body.InnerText), CC = (string.IsNullOrEmpty(cc.InnerText) ? "" : cc.InnerText), BCC = (string.IsNullOrEmpty(bcc.InnerText) ? "" : bcc.InnerText), Attachement = (Attachement != null ? (string.IsNullOrEmpty(Attachement.InnerText) ? "" : Attachement.InnerText) : "") });
                
            }
            if(!search.Equals("")){
                Collection = Collection.Where(s => s.To.ToLower().Trim().Contains(search.ToLower().Trim()) || (string.IsNullOrEmpty(s.Subject) ? "" : s.Subject).ToLower().Trim().Contains(search.ToLower().Trim())).ToList();
            }
            var Collectioncount = Collection.Count();
            Collection=Collection.Skip(RecordSkip).Take(10).ToList();
            foreach(var item in Collection)
            {
                DateTime TodayDate = DateTime.UtcNow.AddMinutes(SystemTimezone);
                DateTime ItemDate;
                string FinalDate = "";
                try
                {
                    ItemDate = Convert.ToDateTime(item.Date);
                    string HowManyHours = Math.Round(TodayDate.Subtract(ItemDate).TotalHours, 2).ToString();
                    string HowManyMinutes = Math.Round(TodayDate.Subtract(ItemDate).TotalMinutes, 2).ToString();
                    string[] dt = HowManyHours.Split(new string[] { "." }, StringSplitOptions.RemoveEmptyEntries);
                    string[] dt1 = HowManyMinutes.Split(new string[] { "." }, StringSplitOptions.RemoveEmptyEntries);
                    FinalDate = (Convert.ToDateTime(ItemDate).Date == DateTime.UtcNow.Date ? (dt[0] != "0" ? dt[0] + " hours ago" : dt1[0] + " minutes ago") : (Convert.ToDateTime(ItemDate)).Date == DateTime.UtcNow.AddDays(-1).Date ? "Yesterday " + Convert.ToDateTime(ItemDate).ToString("hh:mm tt") : Convert.ToDateTime(ItemDate).ToString("dd MMM yyyy hh:mm tt"));
                }
                catch
                {
                    FinalDate = item.Date;
                }

                   if (counter == 0)
                    {
                        ss.Append("<div class='nwinb_read' id='first'  onclick='OutboxEmaildetails(this);'>");
                    }
                    else
                    {
                        ss.Append("<div class='nwinb_read'  onclick='OutboxEmaildetails(this);'>");
                    }



                    ss.Append("<div class='nwinb_chkbox'>");

                    ss.Append("<div class='cbdiv'></div><div class='thisemailbody' style='display:none;'>" + (string.IsNullOrEmpty(item.Body) ? "-" : (DecodeQuotedPrintables(item.Body, ""))) + "</div>");
                    ss.Append("<div class='mysub'  style='display:none;'>" + item.Subject + "</div>");
                    ss.Append("<div class='uid'  style='display:none;'>" + item.ID + "</div>");
                    ss.Append("<div class='maildate'  style='display:none;'>" + FinalDate + "</div>");
                    ss.Append("<div class='mytos'  style='display:none;'>" + item.To + "</div></div>");
                    if (item.Attachement != null && item.Attachement !="")
                    {
                        string[] attachsplit = item.Attachement.Split(',');
                        for (var i = 0; i < attachsplit.Length; i++)
                        {
                            var ext2 = attachsplit[i].Split('.');
                            if (ext2[1] == "doc" || ext2[1] == "docx")
                            {
                                ss.Append("<div class='img-thumbnail img-attachment'><img src='images/word-icon.png' /><span class='file-attachted-name'>" + attachsplit[i] + "</span> <span class='file-attachted-size'></span><div class='doc_downlod_hovr'><span class='mdi mdi-download' onclick=''></span></div></div>");
                            }
                            else if (ext2[1] == "xlsx" || ext2[1] == "xlsm" || ext2[1] == "xltx" || ext2[1] == "xltm" || ext2[1] == "xls" || ext2[1] == "xlt")
                            {
                                ss.Append("<div class='img-thumbnail img-attachment'><img src='images/excel-icon.png' /><span class='file-attachted-name'>" + attachsplit[i] + "</span> <span class='file-attachted-size'></span><div class='doc_downlod_hovr'><span class='mdi mdi-download' onclick=''></span></div></div>");
                            }
                            else if (ext2[1] == "jpg" || ext2[1] == "jpeg" || ext2[1] == "png")
                            {
                                ss.Append("<div class='img-thumbnail img-attachment'><img src='images/img-large-icon.png' /><span class='file-attachted-name'>" + attachsplit[i] + "</span> <span class='file-attachted-size'></span><div class='doc_downlod_hovr'><span class='mdi mdi-download' onclick=''></span></div></div>");
                            }
                            else if (ext2[1] == "pdf" || ext2[1] == "PDF")
                            {
                                ss.Append("<div class='img-thumbnail img-attachment'><img src='images/pdf-large-icon.png' /><span class='file-attachted-name'>" + attachsplit[i] + "</span><span class='file-attachted-size'></span><div class='doc_downlod_hovr'><span class='mdi mdi-download' onclick=''></span></div></div>");
                            }
                            else if (ext2[1] == "txt")
                            {
                                ss.Append("<div class='img-thumbnail img-attachment'><img src='images/text-large-icon.png' /><span class='file-attachted-name'>" + attachsplit[i] + "</span><span class='file-attachted-size'></span><div class='doc_downlod_hovr'><span class='mdi mdi-download' onclick=''></span></div></div>");
                            }
                            else if (ext2[1] == "pptx" || ext2[1] == "ppt")
                            {
                                ss.Append("<div class='img-thumbnail img-attachment'><img src='images/PowerPoint-icon.png' /><span class='file-attachted-name'>" + attachsplit[i] + "</span> <span class='file-attachted-size'></span><div class='doc_downlod_hovr'><span class='mdi mdi-download' onclick=''></span></div></div>");
                            }

                        }
                    }

                    ss.Append("<div class='mail-list'>");

                    ss.Append("<div class='form-check check_inptblock chk_inbox'><div class='checkbox'><label><input type='checkbox' name='OutboxcheckboxChild' value='" + item.ID + "' /><span class='cr'><i class='cr-icon mdi mdi-check'></i></span></label></div></div>");
                    //ss.Append("<div class='form-check check_inptblock chk_inbox' style='display:none;'>");
                    //ss.Append("     <div class='checkbox'>                                                                                                     ");
                    //ss.Append("         <label>                                                                                                                ");
                    //ss.Append("             <input type='checkbox' name='Checkbox1' value='" + item.ID + "' /><span class='cr'><i class='cr-icon mdi mdi-check'></i></span></label>      ");
                    //ss.Append("     </div>                                                                                                                     ");
                    //ss.Append(" </div>                                                                                                                         ");

                    ss.Append(" <div class='details star-inptbox'>                                                                                             ");
                    ss.Append("     <i class='mdi mdi-star-outline'></i>                                                                                       ");
                    ss.Append(" </div>                                                                                                                         ");
                    ss.Append(" <div class='content'>                                                                                                          ");
                    ss.Append("     <p class='sender-name' >" + item.To + "</p>                                        ");
                    ss.Append("     <p class='message_text nwinb_mailcont'>" + item.Subject + "</p>                                                                         ");
                    ss.Append(" </div>                                                                                                                         ");
                    ss.Append("                                                                                                                                ");
                    ss.Append(" </div> </div>");
                    counter++;
              
            }

            if (counter == 0)
            {
                return "0" + "{*^*}" + "0" + "{*^*}" + "nomessage" + "{*^*}" + "0";
            }

            int RecordShow = 10;
            var PageLinks = Collectioncount % RecordShow == 0 ? (Collectioncount / RecordShow) : (Collectioncount / RecordShow) + 1;

            return ss.ToString() + "{*^*}" + count + "{*^*}" + "done" + "{*^*}" + PageLinks;
        }
        catch (Exception ex)
        {
            return "0" + "{*^*}" + "0" + "{*^*}" + "fail" + "{*^*}" + "0";
        }
    }


    [System.Web.Services.WebMethod(EnableSession = true)]
    public static string SendMail(string email, string body, string sub, string cc, string bcc, string attach, double SystemTimeZone)
    {
        Linqconnection db = new Linqconnection();

        int MasterID = Convert.ToInt32(HttpContext.Current.Session["ConfigId"] ?? "0");

        if (MasterID == 0)
            return "Please configure your email account first.";

        var record = (from rec in db.EmailConfigs
                      where rec.Id == MasterID
                      select rec).AsEnumerable().LastOrDefault();

        if (record == null)
        {
            return "Please configure your email account first.";
        }

        string success = "";
        string wrongemail="";
        string sucessemail="";
        string sucessto = "";
        string sucessCc = "";
        string sucessBcc = "";
        string pass = EncryptAlgo.DecryptText(record.Password, EncryptAlgo.theKey, EncryptAlgo.theIV);

        System.Net.Mail.MailMessage oMail = new System.Net.Mail.MailMessage();
        System.Net.Mail.Attachment attachment1;
        oMail.From = new System.Net.Mail.MailAddress(record.Username);

        if (email != "")
        {
            string[] splitemail = email.Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries);
            for (var i = 0; i < splitemail.Length; i++)
            {
                Regex regex = new Regex(@"^([\w\.\-]+)@([\w\-]+)((\.(\w){2,3})+)$");
                Match match = regex.Match(splitemail[i]);
                if (match.Success)
                {
                    oMail.To.Add(new System.Net.Mail.MailAddress(splitemail[i]));
                   sucessemail += splitemail[i];
                   sucessto += splitemail[i] + ",";
                }
                else
                {
                    wrongemail += splitemail[i] + ",";
                }

            }

        }
        if (bcc != "")
        {
            string[] splitemail = bcc.Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries);
            for (var i = 0; i < splitemail.Length; i++)
            {
                Regex regex = new Regex(@"^([\w\.\-]+)@([\w\-]+)((\.(\w){2,3})+)$");
                Match match = regex.Match(splitemail[i]);
                if (match.Success)
                {
                    oMail.Bcc.Add(new System.Net.Mail.MailAddress(splitemail[i]));
                    sucessemail += splitemail[i] + ",";
                    sucessBcc += splitemail[i] + ",";
                }
                else
                {
                    wrongemail += splitemail[i] + ",";
                }
            }
            //if (email == "")
            //{
            //    oMail.To.Add(new System.Net.Mail.MailAddress(splitemail[0]));
            //}
        }
        if (cc != "")
        {
            string[] splitemail = cc.Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries);
            for (var i = 0; i < splitemail.Length; i++)
            {
                Regex regex = new Regex(@"^([\w\.\-]+)@([\w\-]+)((\.(\w){2,3})+)$");
                Match match = regex.Match(splitemail[i]);
                if (match.Success)
                {
                    oMail.CC.Add(new System.Net.Mail.MailAddress(splitemail[i]));
                    sucessemail += splitemail[i];
                    sucessCc += splitemail[i] +",";
                }
                else
                {
                    wrongemail += splitemail[i]+",";
                }
            }
            //if (email == "")
            //{
            //    oMail.To.Add(new System.Net.Mail.MailAddress(splitemail[0]));
            //}
        }

        if (attach != "")
        {
            string[] splitattach = attach.Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries);
            for (var i = 0; i < splitattach.Length; i++)
            {
                string file = HttpContext.Current.Server.MapPath("EmailAttacements" + "/" + splitattach[i]);

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
            //int sid = Convert.ToInt32(HttpContext.Current.Session["ConfigId"]);

            if (!System.IO.Directory.Exists(System.Web.HttpContext.Current.Server.MapPath("Outbox_Email/") + MasterID))
            {
                System.IO.Directory.CreateDirectory(System.Web.HttpContext.Current.Server.MapPath("Outbox_Email/") + MasterID);
            }

            string path = "Outbox_Email/" + MasterID + "/" + unique + ".xml";

            ob.UserId = Convert.ToInt32(HttpContext.Current.Session["ConfigId"]);
            ob.OutboxMailPath = path;

            db.OutBoxMails.InsertOnSubmit(ob);
            db.SubmitChanges();

            System.Xml.XmlTextWriter writer = new System.Xml.XmlTextWriter(System.Web.HttpContext.Current.Server.MapPath("~/") + path, System.Text.Encoding.UTF8);

            writer.WriteStartDocument(true);
            writer.Formatting = System.Xml.Formatting.Indented;
            writer.Indentation = 2;
            writer.WriteStartElement(StaticKeywordClass.Outbox);
            HelperClass.createNode(writer, "id", ob.Id.ToString());
            HelperClass.createNode(writer, "to", sucessto);
            HelperClass.createNode(writer, "cc", sucessCc);
            HelperClass.createNode(writer, "bcc", sucessBcc);
            HelperClass.createNode(writer, "subject", sub);
            HelperClass.createNode(writer, "body", body);
            HelperClass.createNode(writer, "Attachement", attach);
            HelperClass.createNode(writer, "date", DateTime.UtcNow.AddMinutes(SystemTimeZone).ToString("MMM-dd-yyyy hh:mm tt"));
            writer.WriteEndElement();
            writer.WriteEndDocument();
            writer.Close();

            return "Something went wrong mail saved in outbox" + "[!]"+sucessemail +"[!]"+wrongemail;

        }

        try
        {
            SendedMail sm = new SendedMail();

            var unique = DateTime.UtcNow.Ticks;
            //int sid = Convert.ToInt32(HttpContext.Current.Session["ConfigId"]);

            if (!System.IO.Directory.Exists(System.Web.HttpContext.Current.Server.MapPath("Sended_Email/") + MasterID))
            {
                System.IO.Directory.CreateDirectory(System.Web.HttpContext.Current.Server.MapPath("Sended_Email/") + MasterID);
            }

            string path = "Sended_Email/" + MasterID + "/" + unique + ".xml";

            sm.UserId = Convert.ToInt32(HttpContext.Current.Session["ConfigId"]);
            sm.SendMailPath = path;

            db.SendedMails.InsertOnSubmit(sm);
            db.SubmitChanges();

            System.Xml.XmlTextWriter writer = new System.Xml.XmlTextWriter(System.Web.HttpContext.Current.Server.MapPath("~/") + path, System.Text.Encoding.UTF8);

            writer.WriteStartDocument(true);
            writer.Formatting = System.Xml.Formatting.Indented;
            writer.Indentation = 2;
            writer.WriteStartElement(StaticKeywordClass.Sent);
            HelperClass.createNode(writer, "id", sm.Id.ToString());
            HelperClass.createNode(writer, "to", sucessto);
            HelperClass.createNode(writer, "cc", sucessCc);
            HelperClass.createNode(writer, "bcc", sucessBcc);
            HelperClass.createNode(writer, "subject", sub);
            HelperClass.createNode(writer, "body", body);
            HelperClass.createNode(writer, "Attachement", attach);

            HelperClass.createNode(writer, "date", DateTime.UtcNow.AddMinutes(SystemTimeZone).ToString("MMM-dd-yyyy hh:mm tt"));
            writer.WriteEndElement();
            writer.WriteEndDocument();
            writer.Close();




            return success + "[!]" + sucessemail + "[!]" + wrongemail;
        }
        catch (Exception ex)
        {
            string Path = System.Web.HttpContext.Current.Server.MapPath("~/tempSaveFile.txt");

            System.IO.StreamWriter dynamicSw = new System.IO.StreamWriter(Path, true);
            dynamicSw.WriteLine(ex.Message);
            dynamicSw.Close(); dynamicSw.Dispose();
            return "fail";
        }

    }

    [System.Web.Services.WebMethod(EnableSession = true)]
    public static string DeleteTrashEmail(int id)
    {
        try
        {



            int MasterID = Convert.ToInt32(HttpContext.Current.Session["ConfigId"] ?? "0");

            using (Linqconnection dc = new Linqconnection())
            {
                // 
                if (MasterID > 0)
                {
                    var record = (from rec in dc.TrashMailsTables
                                  where rec.ID == id
                                  select rec).FirstOrDefault();

                    if (record != null)
                    {
                        record.IsDeleted = true;
                        dc.SubmitChanges();
                        return "done";

                    }
                    else
                    {

                        return "noid";
                        // ERROR : NO EMAIL CREDENTIALS SET
                    }
                }
                else
                {

                    return "nocre";

                }
            }
        }
        catch (Exception)
        {

            return "fail";
        }

    }

    [System.Web.Services.WebMethod(EnableSession = true)]
    public static string RestoreTrashEmail(int ID)
    {
        try
        {

            int MasterID = Convert.ToInt32(HttpContext.Current.Session["ConfigId"] ?? "0");
            using (Linqconnection dc = new Linqconnection())
            {

                var TrashTable = dc.TrashMailsTables.FirstOrDefault(a => a.ID == ID);

                if (TrashTable != null)
                {


                    if (TrashTable.EmailType == StaticKeywordClass.Draft)
                    {
                        DraftEmailTable TMT = new DraftEmailTable();

                        TMT.Draftpath = TrashTable.XMLPath;
                        TMT.UserId = MasterID;

                        dc.DraftEmailTables.InsertOnSubmit(TMT);
                        dc.SubmitChanges();

                        if (System.IO.File.Exists(System.Web.HttpContext.Current.Server.MapPath(TMT.Draftpath)))
                        {


                            string path = System.Web.HttpContext.Current.Server.MapPath(TMT.Draftpath);
                            XmlDocument xml = new System.Xml.XmlDocument();
                            xml.Load(path);
                            XmlNode eid = xml.DocumentElement.SelectSingleNode("/" + StaticKeywordClass.Draft + "/id");
                            eid.InnerText = TMT.Id.ToString();

                            xml.Save(path);
                        }
                    }
                    else if (TrashTable.EmailType == StaticKeywordClass.Outbox)
                    {
                        OutBoxMail TMT = new OutBoxMail();

                        TMT.OutboxMailPath = TrashTable.XMLPath;
                        TMT.UserId = MasterID;

                        dc.OutBoxMails.InsertOnSubmit(TMT);
                        dc.SubmitChanges();

                        if (System.IO.File.Exists(System.Web.HttpContext.Current.Server.MapPath(TMT.OutboxMailPath)))
                        {


                            string path = System.Web.HttpContext.Current.Server.MapPath(TMT.OutboxMailPath);
                            XmlDocument xml = new System.Xml.XmlDocument();
                            xml.Load(path);
                            XmlNode eid = xml.DocumentElement.SelectSingleNode("/" + StaticKeywordClass.Outbox + "/id");
                            eid.InnerText = TMT.Id.ToString();

                            xml.Save(path);
                        }

                    }
                    else if (TrashTable.EmailType == StaticKeywordClass.Sent)
                    {

                        SendedMail TMT = new SendedMail();

                        TMT.SendMailPath = TrashTable.XMLPath;
                        TMT.UserId = MasterID;

                        dc.SendedMails.InsertOnSubmit(TMT);
                        dc.SubmitChanges();

                        if (System.IO.File.Exists(System.Web.HttpContext.Current.Server.MapPath(TMT.SendMailPath)))
                        {


                            string path = System.Web.HttpContext.Current.Server.MapPath(TMT.SendMailPath);
                            XmlDocument xml = new System.Xml.XmlDocument();
                            xml.Load(path);
                            XmlNode eid = xml.DocumentElement.SelectSingleNode("/" + StaticKeywordClass.Sent + "/id");
                            eid.InnerText = TMT.Id.ToString();

                            xml.Save(path);
                        }

                    }
                    //else if (TrashTable.EmailType == StaticKeywordClass.Inbox)
                    //{



                    //}





                    dc.TrashMailsTables.DeleteOnSubmit(TrashTable);
                    dc.SubmitChanges();
                }

                return "done";
            }
        }
        catch (Exception)
        {
            return "fail";
        }


    }

    [System.Web.Services.WebMethod(EnableSession = true)]
    public static string StarredSave(string id, string label)
    {
        int MasterID = Convert.ToInt32(HttpContext.Current.Session["ConfigId"] ?? "0");

        Linqconnection db = new Linqconnection();

        StarredEmailTable st = new StarredEmailTable();
        var check = (from rec in db.StarredEmailTables
                     where rec.EmailId == id
                     select rec).FirstOrDefault();

        if (check == null)
        {

            if (label == "sent")
            {
                var record = (from rec in db.SendedMails
                              where rec.Id == Convert.ToInt32(id)
                              select rec).FirstOrDefault();

                st.XmlPath = record.SendMailPath;
                st.IsInbox = false;
                st.From1 = StaticKeywordClass.Sent;
            }
            else if (label == "draft")
            {

                var record = (from rec in db.DraftEmailTables
                              where rec.Id == Convert.ToInt32(id)
                              select rec).FirstOrDefault();

                st.XmlPath = record.Draftpath;
                st.IsInbox = false;
                st.From1 = StaticKeywordClass.Draft;
            }
            else if (label == "inbox")
            {
                st.IsInbox = true;
                st.From1 = StaticKeywordClass.Inbox;
            }

            st.EmailId = id;
            st.UserId = MasterID;


            db.StarredEmailTables.InsertOnSubmit(st);
            db.SubmitChanges();
            db.Connection.Close();
        }

        return "done";



    }

    [System.Web.Services.WebMethod(EnableSession = true)]
    public static string RemoveStarEmail(string id)
    {
        int MasterID = Convert.ToInt32(HttpContext.Current.Session["ConfigId"] ?? "0");

        Linqconnection db = new Linqconnection();

        var record = (from rec in db.StarredEmailTables
                      where rec.EmailId == id
                      select rec).FirstOrDefault();



        db.StarredEmailTables.DeleteOnSubmit(record);
        db.SubmitChanges();
        db.Connection.Close();

        return "done";



    }

    [System.Web.Services.WebMethod(EnableSession = true)]
    public static string OpenStarList(double SystemTimeZone,string Search ,int PageClick)
    {
        int MasterID = Convert.ToInt32(HttpContext.Current.Session["ConfigId"] ?? "0");
        List<starList> starCollection = new List<starList>();
        using (Linqconnection dc = new Linqconnection())
        {
            // 
            if (MasterID > 0)
            {
                var record = (from rec in dc.EmailConfigs.AsEnumerable()
                              where rec.Id == MasterID
                              select rec).LastOrDefault();

                if (record != null)
                {
                    MasterID = record.Id;
                    HttpContext.Current.Session["ConfigId"] = record.Id;
                }
                else
                {
                    // ERROR : NO EMAIL CREDENTIALS SET
                }
            }
            else
            {
                var record = (from rec in dc.EmailConfigs.AsEnumerable()
                              where !(rec.IsDeleted ?? false)
                              select rec).LastOrDefault();

                if (record != null)
                {
                    MasterID = record.Id;
                    HttpContext.Current.Session["ConfigId"] = record.Id;
                }
                else
                {
                    // ERROR : NO EMAIL CREDENTIALS SET
                }
            }

        }

        try
        {

            Linqconnection db = new Linqconnection();

            var record = (from rec in db.EmailConfigs.AsEnumerable()
                          where rec.Id == MasterID && !(rec.IsDeleted ?? false)
                          select rec).LastOrDefault();

            if (record == null)
            {
                return "0" + "{*^*}" + "0" + "{*^*}" + "0" + "{*^*}" + "norecord"; 
            }

            HttpContext.Current.Session["ConfigId"] = record.Id;

            //var delid = (from re in db.TrashMailsTables.AsEnumerable()
            //             where re.UserID == record.Id && !string.IsNullOrEmpty(re.InboxMailThreadID)
            //             select re.InboxMailThreadID).ToArray();

            var StarId = (from re in db.StarredEmailTables.AsEnumerable()
                          where re.UserId == record.Id && re.IsInbox == true
                          select re.EmailId).ToArray();

            // THIS IS ENCRYPTING PASSWORD
            String Decryptpassword = EncryptAlgo.DecryptText(record.Password, EncryptAlgo.theKey, EncryptAlgo.theIV);


            string pass = record.Password;

            string resp = "";

            int counter = 0;
            int mailcount = 0;
            int total = 0;

            StringBuilder ss = new StringBuilder();
            if (StarId.Count() != 0)
            {
                if (record.Access == "imap")
                {
                    using (ImapClient Iclient = new ImapClient(record.Host, Convert.ToInt32(record.Port), record.Username, Decryptpassword, S22.Imap.AuthMethod.Login, true, null))
                    {

                        IEnumerable<uint> uids = Iclient.Search(S22.Imap.SearchCondition.All(), "INBOX");

                        //IEnumerable<uint> uidseen = Iclient.Search(S22.Imap.SearchCondition.Seen(), "INBOX");
                        total = uids.Count();
                        if (uids.Count() > 0)
                        {
                            IEnumerable<System.Net.Mail.MailMessage> Iunseenmessages = null;
                            //IEnumerable<System.Net.Mail.MailMessage> ISeenmessages = null;
                            //var RecordSkip = (skip - 1) * 10;
                            try
                            {
                                Iunseenmessages = Iclient.GetMessages(uids.OrderByDescending(u => u), false, "INBOX");
                            }
                            catch { }
                            //try
                            //{
                            //    ISeenmessages = Iclient.GetMessages(uidseen.OrderByDescending(u => u).Skip(((int)skip)).Take(20), true, "INBOX");
                            //}
                            //catch { }

                            var Imessages = Iunseenmessages.OrderByDescending(d => Convert.ToDateTime(d.Headers["date"].Substring(0, d.Headers["date"].LastIndexOf(':') + 3).Trim()));
                            int cnt = Imessages.Count();
                            if (cnt > 0)
                            {

                                List<string> maildatecollection = new List<string>();
                                System.Text.StringBuilder str = new System.Text.StringBuilder();
                                foreach (var item in Imessages)
                                {

                                    //if (!delid.Contains(item.Headers["Date"]))
                                    //  {
                                    if (StarId.Contains(item.Headers["Date"]))
                                    {

                                        string tos = "";
                                        string ccmails = "";
                                        string bccmails = "";
                                        string tomails = "";
                                        tos += item.From.Address;
                                        if (item.To.Count > 0)
                                        {
                                            foreach (var ts in item.To)
                                            {
                                                if (!record.Username.Contains(ts.Address))
                                                {
                                                    tos += ts.Address + ",";
                                                }
                                                tomails += ts.Address + ",";

                                            }
                                        }

                                        if (item.CC.Count > 0)
                                        {
                                            foreach (var ts in item.CC)
                                            {
                                                if (!record.Username.Contains(ts.Address))
                                                {
                                                    tos += ts.Address + ",";
                                                }
                                                ccmails += ts.Address + ",";
                                            }
                                        }

                                        if (item.Bcc.Count > 0)
                                        {
                                            foreach (var ts in item.Bcc)
                                            {

                                                bccmails += ts.Address + ",";
                                            }
                                        }

                                        string attch = "";
                                        string attchname = "";
                                        byte[] allBytes = null;
                                        if (item.Attachments.Count > 0)
                                        {
                                            foreach (var at in item.Attachments)
                                            {
                                                int size = 1;
                                                try
                                                {
                                                    allBytes = new byte[at.ContentStream.Length];
                                                    int bytesRead = at.ContentStream.Read(allBytes, 0, (int)at.ContentStream.Length);

                                                    var result = Convert.ToBase64String(allBytes);
                                                    //size = (int)at.ContentStream.ReadByte();
                                                    attch += result + "{bt}";
                                                    attchname += at.Name + "{at}";

                                                }
                                                catch { size = 1; }
                                            }
                                        }
                                        //str.Append("<div id='attach' style='display:none;'>" + attch + "</div>");

                                        string subjects = "";
                                        subjects = (string.IsNullOrEmpty(item.Subject) ? "-" : item.Subject);
                                        string displayname = "";
                                        try
                                        {
                                            if (item.From != null)
                                            {
                                                displayname = (string.IsNullOrEmpty(item.From.DisplayName) ? (string.IsNullOrEmpty(item.From.User) ? "-" : DecodeQuotedPrintables(item.From.User, "")) : DecodeQuotedPrintables(item.From.DisplayName, "").Replace("<notification+", ""));
                                            }
                                            else { displayname = subjects; }
                                        }
                                        catch { displayname = (string.IsNullOrEmpty(item.From.DisplayName) ? (string.IsNullOrEmpty(item.From.User) ? "-" : DecodeQuotedPrintables(item.From.User, "")) : item.From.DisplayName); }
                                        string depart = "";
                                        string fromadd = "";
                                        try
                                        {
                                            if (item.From != null)
                                            {

                                                depart = (string.IsNullOrEmpty(item.From.User) ? "-" : DecodeQuotedPrintables(item.From.User, "")) + " (" + (string.IsNullOrEmpty(item.From.Address) ? "-" : DecodeQuotedPrintables(item.From.Address, "")) + ")";
                                                fromadd = item.From.Address;
                                            }
                                            else { depart = "-"; }
                                        }
                                        catch { depart = subjects; }


                                      

                                        string[] splitdate = null;
                                        string dat = item.Headers["Date"];

                                        if (dat.Contains("+"))
                                        {
                                            splitdate = dat.Split(new char[] { '+' }, StringSplitOptions.RemoveEmptyEntries);
                                        }
                                        else
                                        {
                                            splitdate = dat.Split(new char[] { '-' }, StringSplitOptions.RemoveEmptyEntries);
                                        }
                                        var Date = splitdate[0].Split(',');
                                        DateTime TodayDate = DateTime.UtcNow.AddMinutes(SystemTimeZone);
                                        DateTime testdate;
                                        if (Date.Length == 1)
                                        {
                                            testdate = Convert.ToDateTime(Date[0]);
                                        }
                                        else
                                        {
                                            testdate = Convert.ToDateTime(Date[1]);
                                        }
                                        string HowManyHours = Math.Round(TodayDate.Subtract(testdate).TotalHours, 2).ToString();
                                        string HowManyMinutes = Math.Round(TodayDate.Subtract(testdate).TotalMinutes, 2).ToString();
                                        string[] dt = HowManyHours.Split(new string[] { "." }, StringSplitOptions.RemoveEmptyEntries);
                                        string[] dt1 = HowManyMinutes.Split(new string[] { "." }, StringSplitOptions.RemoveEmptyEntries);
                                        string FinalDate = (Convert.ToDateTime(testdate).Date == DateTime.UtcNow.Date ? (dt[0] != "0" ? dt[0] + " hours ago" : dt1[0] + " minutes ago") : (Convert.ToDateTime(testdate)).Date == DateTime.UtcNow.AddDays(-1).Date ? "Yesterday " + Convert.ToDateTime(testdate).ToString("hh:mm tt") : Convert.ToDateTime(testdate).ToString("dd MMM yyyy hh:mm tt"));
                                        var bodyhtml = item.Body;
                                        bodyhtml = bodyhtml.Replace("\r\n", "<br>");

                                        starCollection.Add(new starList { Body = (string.IsNullOrEmpty(bodyhtml) ? "" : bodyhtml), Subjects = subjects, Attachement = attch, AttachName = attchname, Date = item.Headers["Date"], FromAdd = fromadd, To = tomails, Cc = ccmails, Bcc = bccmails, Depart = depart, DisplayName = displayname, ISInbox = true,replyallmail=tos,FinalDate=FinalDate});
                                       
                                        // if (item.Attachments.Count() > 0)
                                        // {
                                        //     str.Append("<div class='nwinb_mailattach'></div>");
                                        //  }
                                        //string tempdate = item.Headers["Date"].ToString();
                                        //var dtt = Convert.ToDateTime(tempdate.Substring(0, tempdate.LastIndexOf(':') + 3).Trim());
                                        //if (DateTime.UtcNow.Date == dtt.Date)
                                        //{ tempdate = String.Format("{0:t}", dtt.Date); }
                                        //else
                                        //{
                                        //    tempdate = String.Format("{MMM dd}", dtt.Date);
                                        //}
                                        //str.Append("<div class='nwinb_mailtime'>" + tempdate + "</div></div>");
                                    }
                                    // }
                                }

                            }
                            else { resp = total.ToString() + "{*^*}<div class='nwinb_read' style='height:300px;'><sapn class='nofound nofoundmargin'>&lt; No Message available &gt;</span></div>"; }
                        }
                        else { resp = total.ToString() + "{*^*}" + "0" + "{*^*}" + "0" + "{*^*}" + "nomessage"; }

                    }
                }
                else if (record.Access == "pop")
                {
                    using (S22.Pop3.Pop3Client popclient = new S22.Pop3.Pop3Client(record.Host, Convert.ToInt32(record.Port), record.Username, Decryptpassword, S22.Pop3.AuthMethod.Login, true, null))
                    {

                        total = popclient.GetMessageNumbers().Count();
                        if (total > 0)
                        {
                            //var RecordSkip = (skip - 1) * 10;
                            uint[] mylist = popclient.GetMessageNumbers().OrderByDescending(c => c).ToArray();


                            System.Net.Mail.MailMessage[] messages = popclient.GetMessages(mylist);
                            //S22.Pop3.MessageInfo[] emailint = popclient.GetStatus();

                            System.Text.StringBuilder str = new System.Text.StringBuilder();
                            List<string> maildatecollection = new List<string>();
                            foreach (var item in messages)
                            {

                                //    if (!delid.Contains(item.Headers["Date"]))
                                //   {
                                if (StarId.Contains(item.Headers["Date"]))
                                {


                                    string tos = "";
                                    string ccmails = "";
                                    string bccmails = "";
                                    string tomails = "";
                                    tos += item.From.Address;
                                    if (item.To.Count > 0)
                                    {
                                        foreach (var ts in item.To)
                                        {
                                            if (!record.Username.Contains(ts.Address))
                                            {
                                                tos += ts.Address + ",";
                                            }
                                            tomails += ts.Address + ",";

                                        }
                                    }

                                    if (item.CC.Count > 0)
                                    {
                                        foreach (var ts in item.CC)
                                        {
                                            if (!record.Username.Contains(ts.Address))
                                            {
                                                tos += ts.Address + ",";
                                            }
                                            ccmails += ts.Address + ",";
                                        }
                                    }

                                    if (item.Bcc.Count > 0)
                                    {
                                        foreach (var ts in item.Bcc)
                                        {

                                            bccmails += ts.Address + ",";
                                        }
                                    }


                                    string attch = "";
                                    string attchname = "";
                                    byte[] allBytes = null;
                                    if (item.Attachments.Count > 0)
                                    {
                                        foreach (var at in item.Attachments)
                                        {
                                            int size = 1;
                                            try
                                            {
                                                allBytes = new byte[at.ContentStream.Length];
                                                int bytesRead = at.ContentStream.Read(allBytes, 0, (int)at.ContentStream.Length);

                                                var result = Convert.ToBase64String(allBytes);
                                                //size = (int)at.ContentStream.ReadByte();
                                                attch += result + "{bt}";
                                                attchname += at.Name + "{at}";

                                            }
                                            catch { size = 1; }
                                        }
                                    }
                                    //str.Append("<div id='attach' style='display:none;'>" + attch + "</div>");

                                    string subjects = "";
                                    subjects = (string.IsNullOrEmpty(item.Subject) ? "-" : item.Subject);
                                    string displayname = "";
                                    try
                                    {
                                        if (item.From != null)
                                        {
                                            displayname = (string.IsNullOrEmpty(item.From.DisplayName) ? (string.IsNullOrEmpty(item.From.User) ? "-" : DecodeQuotedPrintables(item.From.User, "")) : DecodeQuotedPrintables(item.From.DisplayName, "").Replace("<notification+", ""));
                                        }
                                        else { displayname = subjects; }
                                    }
                                    catch { displayname = (string.IsNullOrEmpty(item.From.DisplayName) ? (string.IsNullOrEmpty(item.From.User) ? "-" : DecodeQuotedPrintables(item.From.User, "")) : item.From.DisplayName); }
                                    string depart = "";
                                    string fromadd = "";
                                    try
                                    {
                                        if (item.From != null)
                                        {
                                            depart = (string.IsNullOrEmpty(item.From.User) ? "-" : DecodeQuotedPrintables(item.From.User, "")) + " (" + (string.IsNullOrEmpty(item.From.Address) ? "-" : DecodeQuotedPrintables(item.From.Address, "")) + ")";
                                            fromadd = item.From.Address;
                                        }
                                        else { depart = "-"; }
                                    }
                                    catch { depart = subjects; }


                                    

                                    string[] splitdate = null;
                                    string dat = item.Headers["Date"];

                                    if (dat.Contains("+"))
                                    {
                                        splitdate = dat.Split(new char[] { '+' }, StringSplitOptions.RemoveEmptyEntries);
                                    }
                                    else
                                    {
                                        splitdate = dat.Split(new char[] { '-' }, StringSplitOptions.RemoveEmptyEntries);
                                    }
                                    var Date = splitdate[0].Split(',');
                                    DateTime TodayDate = DateTime.UtcNow.AddMinutes(SystemTimeZone);
                                    DateTime testdate;
                                    if (Date.Length == 1)
                                    {
                                        testdate = Convert.ToDateTime(Date[0]);
                                    }
                                    else
                                    {
                                        testdate = Convert.ToDateTime(Date[1]);
                                    }
                                    string HowManyHours = Math.Round(TodayDate.Subtract(testdate).TotalHours, 2).ToString();
                                    string HowManyMinutes = Math.Round(TodayDate.Subtract(testdate).TotalMinutes, 2).ToString();
                                    string[] dt = HowManyHours.Split(new string[] { "." }, StringSplitOptions.RemoveEmptyEntries);
                                    string[] dt1 = HowManyMinutes.Split(new string[] { "." }, StringSplitOptions.RemoveEmptyEntries);
                                    string FinalDate = (Convert.ToDateTime(testdate).Date == DateTime.UtcNow.Date ? (dt[0] != "0" ? dt[0] + " hours ago" : dt1[0] + " minutes ago") : (Convert.ToDateTime(testdate)).Date == DateTime.UtcNow.AddDays(-1).Date ? "Yesterday " + Convert.ToDateTime(testdate).ToString("hh:mm tt") : Convert.ToDateTime(testdate).ToString("dd MMM yyyy hh:mm tt"));
                                    var bodyhtml = item.Body;
                                    bodyhtml = bodyhtml.Replace("\r\n", "<br>");
                                    starCollection.Add(new starList { Body = (string.IsNullOrEmpty(bodyhtml) ? "" : bodyhtml), Subjects = subjects, Attachement = attch, AttachName = attchname, Date = item.Headers["Date"], FromAdd = fromadd, To = tomails, Cc = ccmails, Bcc = bccmails, Depart = depart, DisplayName = displayname, ISInbox = true,replyallmail=tos,FinalDate=FinalDate });

                                    

                                    //  ss.Append("<div class='form-check check_inptblock chk_inbox'>");
                                    //  ss.Append("     <div class='checkbox'>                                                                                                     ");
                                    // ss.Append("         <label>                                                                                                                ");
                                    // ss.Append("             <input type='checkbox' name='Checkbox1' value='" + item.Headers["Date"] + "' /><span class='cr'><i class='cr-icon mdi mdi-check'></i></span></label>      ");
                                    // ss.Append("     </div>                                                                                                                     ");
                                    // ss.Append(" </div>                                                                                                                         ");
                                    
                                    maildatecollection.Add(item.Headers["Date"]);
                                    counter++;

                                    mailcount++;


                                    // if (item.Attachments.Count() > 0)
                                    //  {
                                    //     str.Append("<div class='nwinb_mailattach'></div>");
                                    //  }
                                    //string tempdate = item.Headers["Date"].ToString();
                                    //var dtt = Convert.ToDateTime(tempdate.Substring(0, tempdate.LastIndexOf(':') + 3).Trim());
                                    //if (DateTime.UtcNow.Date == dtt.Date)
                                    //{ tempdate = String.Format("{0:t}", dtt.Date); }
                                    //else
                                    //{
                                    //    tempdate = String.Format("{MMM dd}", dtt.Date);
                                    //}
                                    //str.Append("<div class='nwinb_mailtime'>" + tempdate + "</div></div>");
                                }
                                // }
                            }



                        }
                        else { resp = total.ToString() + "{*^*}<div class='nwinb_read' style='height:300px;'><sapn class='nofound nofoundmargin'>&lt; No Message available &gt;</span></div>"; }
                    }
                }
                else { resp = "acmethod"; }
            }


            var detail = from rec in db.StarredEmailTables
                         where rec.UserId == MasterID && rec.IsInbox == false
                         select rec;

            var StarId2 = (from re in db.StarredEmailTables.AsEnumerable()
                           where re.UserId == record.Id && re.IsInbox == false
                           select re.EmailId).ToArray();

            if (detail.Count() != 0)
            {

                int ccc = 0;
                foreach (var item in detail)
                {
                    System.Xml.XmlDocument doc = new System.Xml.XmlDocument();

                    try
                    {
                        doc.Load(System.Web.HttpContext.Current.Server.MapPath(item.XmlPath));
                    }
                    catch (Exception)
                    {
                        continue;
                    }

                    System.Xml.XmlNode id = doc.DocumentElement.SelectSingleNode("/" + item.From1 + "/id");
                    System.Xml.XmlNode to = doc.DocumentElement.SelectSingleNode("/" + item.From1 + "/to");
                    System.Xml.XmlNode sub = doc.DocumentElement.SelectSingleNode("/" + item.From1 + "/subject");
                    System.Xml.XmlNode body = doc.DocumentElement.SelectSingleNode("/" + item.From1 + "/body");
                    System.Xml.XmlNode cc = doc.DocumentElement.SelectSingleNode("/" + item.From1 + "/cc");
                    System.Xml.XmlNode bcc = doc.DocumentElement.SelectSingleNode("/" + item.From1 + "/bcc");
                    System.Xml.XmlNode date = doc.DocumentElement.SelectSingleNode("/" + item.From1 + "/date");


                    var tos = "";
                    string[] spltto = to.InnerText.Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries);
                    string[] spltcc = cc.InnerText.Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries);

                    for (int i = 0; i < spltto.Length; i++)
                    {
                        if (spltto[i] != "")
                        {
                            tos += spltto[i] + ",";
                        }
                    }
                    for (int i = 0; i < spltcc.Length; i++)
                    {
                        if (spltcc[i] != "")
                        {
                            tos += spltcc[i] + ",";
                        }
                    }

                    tos += to.InnerText;

                    var attch = "";

                    DateTime TodayDate = DateTime.UtcNow.AddMinutes(SystemTimeZone);
                    DateTime ItemDate;
                    string FinalDate = "";
                    try
                    {
                        ItemDate = Convert.ToDateTime(date.InnerText);
                        string HowManyHours = Math.Round(TodayDate.Subtract(ItemDate).TotalHours, 2).ToString();
                        string HowManyMinutes = Math.Round(TodayDate.Subtract(ItemDate).TotalMinutes, 2).ToString();
                        string[] dt = HowManyHours.Split(new string[] { "." }, StringSplitOptions.RemoveEmptyEntries);
                        string[] dt1 = HowManyMinutes.Split(new string[] { "." }, StringSplitOptions.RemoveEmptyEntries);
                        FinalDate = (Convert.ToDateTime(ItemDate).Date == DateTime.UtcNow.Date ? (dt[0] != "0" ? dt[0] + " hours ago" : dt1[0] + " minutes ago") : (Convert.ToDateTime(ItemDate)).Date == DateTime.UtcNow.AddDays(-1).Date ? "Yesterday " + Convert.ToDateTime(ItemDate).ToString("hh:mm tt") : Convert.ToDateTime(ItemDate).ToString("dd MMM yyyy hh:mm tt"));
                    }
                    catch
                    {
                        FinalDate = date.InnerText;
                    }
                    starCollection.Add(new starList { Body = (string.IsNullOrEmpty(body.InnerText) ? "-" : (DecodeQuotedPrintables(body.InnerText, ""))), Subjects = sub.InnerText, Attachement = attch, AttachName = attch, Date = date.InnerText, FromAdd = to.InnerText, To = to.InnerText, Cc = cc.InnerText, Bcc = bcc.InnerText, Depart = to.InnerText, DisplayName = to.InnerText, ISInbox = false,replyallmail=tos,ID=id.InnerText,FinalDate=FinalDate});
                   

                    //  ss.Append("<div class='form-check check_inptblock chk_inbox'>");
                    //  ss.Append("     <div class='checkbox'>                                                                                                     ");
                    // ss.Append("         <label>                                                                                                                ");
                    // ss.Append("             <input type='checkbox' name='Checkbox1' value='" + item.Headers["Date"] + "' /><span class='cr'><i class='cr-icon mdi mdi-check'></i></span></label>      ");
                    // ss.Append("     </div>                                                                                                                     ");
                    // ss.Append(" </div>                                                                                                                         ");
                    
                    


                }
            }
            if (!Search.Equals(""))
            {
                starCollection = starCollection.Where(a => ((string.IsNullOrEmpty(a.DisplayName) ? "" : a.DisplayName).ToLower().Trim().Contains(Search.ToLower().Trim()) || (string.IsNullOrEmpty(a.Subjects) ? "" : a.Subjects).ToLower().Trim().Contains(Search.ToLower().Trim()))).ToList();
            }
            var collectioncount = starCollection.Count();
            var RecordSkip = (PageClick - 1) * 10;
            starCollection = starCollection.Skip(RecordSkip).Take(10).ToList();
            int Zerocunter = 0;
            if (collectioncount == 0)
            {
                return "0" + "{*^*}" + "0" + "{*^*}" + "0" + "{*^*}" + "nomessage"; 
            }
            foreach (var item in starCollection)
            {
                if (Zerocunter == 0)
                {
                    ss.Append("<div class='nwinb_read' id='first'  onclick='GetStarEmaildetails(this);'>");
                }
                else
                {
                    ss.Append("<div class='nwinb_read'  onclick='GetStarEmaildetails(this);'>");
                }
                ss.Append("<div class='nwinb_chkbox'>");

                ss.Append("<div class='cbdiv'></div><div class='thisemailbody'  style='display:none;'>" + (string.IsNullOrEmpty(item.Body) ? "-" : (item.Body)) + "</div>");
                ss.Append("<div class='mysub'  style='display:none;'>" + item.Subjects + "</div>");
                ss.Append("<div class='attach'   style='display:none;'>" + item.Attachement + "</div>");
                ss.Append("<div class='attachname'   style='display:none;'>" + item.AttachName + "</div>");
                ss.Append("<div class='uid'  style='display:none;'>" + item.Date + "</div>");
                ss.Append("<div class='fromad'  style='display:none;'>" + item.FromAdd + "</div>");
                ss.Append("<div class='replyallmails'  style='display:none;'>" + item.replyallmail + "</div>");
                ss.Append("<div class='ccmails'  style='display:none;'>" + item.Cc + "</div>");
                ss.Append("<div class='bccmails'  style='display:none;'>" + item.Bcc + "</div>");
                ss.Append("<div class='tomails'  style='display:none;'>" + item.To + "</div>");
                ss.Append("<div class='maildate'  style='display:none;'>" + item.FinalDate + "</div>");
                ss.Append("<div class='mytos'  style='display:none;'>" + item.Depart + "</div></div>");


                ss.Append("<div class='mail-list'>");
                if (item.ISInbox)
                {
                    if (StarId.Contains(item.Date))
                    {
                        ss.Append(" <div class='details star-inptbox' onclick=\"RemoveStar(this,'star','" + item.Date + "')\">                                                                                             ");
                        ss.Append("     <i class='mdi mdi-star favorite'></i>                                                                                       ");
                        ss.Append(" </div>                                                                                                                         ");
                    }
                    else
                    {
                        ss.Append(" <div class='details star-inptbox' onclick=\"SaveStar(this,'star','" + item.Date + "')\">                                                                                             ");
                        ss.Append("     <i class='mdi mdi-star-outline'></i>                                                                                       ");
                        ss.Append(" </div>                                                                                                                         ");
                    }

                }
                else
                {
                    if (StarId2.Contains(item.ID))
                    {
                        ss.Append(" <div class='details star-inptbox' onclick=\"RemoveStar(this,'star','" + item.ID + "')\">                                                                                             ");
                        ss.Append("     <i class='mdi mdi-star favorite'></i>                                                                                       ");
                        ss.Append(" </div>                                                                                                                         ");
                    }
                    else
                    {
                        ss.Append(" <div class='details star-inptbox' onclick=\"SaveStar(this,'star','" + item.ID + "')\">                                                                                             ");
                        ss.Append("     <i class='mdi mdi-star-outline'></i>                                                                                       ");
                        ss.Append(" </div>                                                                                                                         ");
                    }
                }
                ss.Append(" <div class='content'>                                                                                                          ");
                ss.Append("     <p class='sender-name' >" + item.DisplayName + "</p>                                        ");
                ss.Append("     <p class='message_text nwinb_mailcont'>" + item.Subjects + "</p>                                                                         ");
                ss.Append(" </div>                                                                                                                         ");
                ss.Append("                                                                                                                                ");
                ss.Append(" </div> </div>");
                Zerocunter++;
            }


            int RecordShow = 10;
            var PageLinks = collectioncount % RecordShow == 0 ? (collectioncount / RecordShow) : (collectioncount / RecordShow) + 1;
            resp = total.ToString() + "{*^*}" + ss.ToString() + "{*^*}" + PageLinks + "{*^*}" + "done";

            return resp;

        }

        catch (Exception ex)
        {
            string Path = System.Web.HttpContext.Current.Server.MapPath("~/tempSaveFile.txt");

            System.IO.StreamWriter dynamicSw = new System.IO.StreamWriter(Path, true);
            dynamicSw.WriteLine(ex.Message);
            dynamicSw.Close(); dynamicSw.Dispose();

            return "0" + "{*^*}" + "0" + "{*^*}" + "0" + "{*^*}" + "fail"; ;
        }
    }

    [System.Web.Services.WebMethod(EnableSession = true)]
    public static string AttDownload(string data)
    {
        string[] response = data.Split(new[] { "{bt}" }, StringSplitOptions.None);

        var res = Convert.FromBase64String(response[0]);

        //using (var open = new FolderBrowserDialog())
        //{
        //    DialogResult result = open.ShowDialog();

        //    if (result == DialogResult.OK)
        //    {

        //        string folder = open.SelectedPath;
        //    }
        //}
        //byte[] allBytes = new byte[byt];
        //int bytesRead = attachment.ContentStream.Read(allBytes, 0, (int)attachment.ContentStream.Length);
        var path1 = DateTime.UtcNow.Ticks + response[1];
        var path = HttpContext.Current.Server.MapPath("Attachment/" + path1);
        string destinationFile = path;
        BinaryWriter writer = new BinaryWriter(new FileStream(destinationFile, FileMode.OpenOrCreate, FileAccess.Write, FileShare.None));
        writer.Write(res);
        writer.Close();

        return path1;

    }


    [System.Web.Services.WebMethod(EnableSession = true)]
    public static string EmailConfigSave(string access, string Host, string Username, string Password1, string Smtphost1, string SmtpPort, string signature, string reply, string replyall, string forward, string compose)
    {

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
                    MasterTable.IsReply = (reply == "true" ? true : reply == "false" ? false : false);
                    MasterTable.IsReplyAll = (replyall == "true" ? true : false);
                    MasterTable.IsCompose = (compose == "true" ? true : false);
                    MasterTable.IsForward = (forward == "true" ? true : false);

                    dc.SubmitChanges();

                    // SAVING VALUES IN SESSION
                    HttpContext.Current.Session["ConfigId"] = MasterTable.Id;
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
                    HttpContext.Current.Session["ConfigId"] = MasterTableObj.Id;
                }

                return "done";

            }

        }
        catch (Exception ex)
        {
            return ex.ToString();
        }

    }

    [System.Web.Services.WebMethod(EnableSession = true)]
    public static string Deletepic(string imgname2)
    {

        //string[] strarray = imgname2.Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries);
        //for (var i = 0; i < strarray.Length; i++)
        //{
        if (System.IO.File.Exists(HttpContext.Current.Server.MapPath("EmailAttacements/" + imgname2)))
        {
            System.IO.File.SetAttributes(HttpContext.Current.Server.MapPath("EmailAttacements/" + imgname2), System.IO.FileAttributes.Normal);

            System.IO.File.Delete(HttpContext.Current.Server.MapPath("EmailAttacements/" + imgname2));
        }
        // }
        string d = "done";
        return imgname2;

    }

    private static string DecodeQuotedPrintables(string input, string charSet)
    {
        try
        {
            if (string.IsNullOrEmpty(charSet))
            {
                var charSetOccurences = new Regex(@"=\?.*\?Q\?", RegexOptions.IgnoreCase);
                var charSetMatches = charSetOccurences.Matches(input);
                foreach (Match match in charSetMatches)
                {
                    charSet = match.Groups[0].Value.Replace("=?", "").Replace("?Q?", "");
                    input = input.Replace(match.Groups[0].Value, "").Replace("?=", "");
                }
            }

            Encoding enc = new ASCIIEncoding();
            if (!string.IsNullOrEmpty(charSet))
            {
                try
                {
                    enc = Encoding.GetEncoding(charSet);
                }
                catch
                {
                    enc = new ASCIIEncoding();
                }
            }

            //decode iso-8859-[0-9]
            var occurences = new Regex(@"=[0-9A-Z]{2}", RegexOptions.Multiline);
            var matches = occurences.Matches(input);
            foreach (Match match in matches)
            {
                try
                {
                    byte[] b = new byte[] { byte.Parse(match.Groups[0].Value.Substring(1), System.Globalization.NumberStyles.AllowHexSpecifier) };
                    char[] hexChar = enc.GetChars(b);
                    input = input.Replace(match.Groups[0].Value, hexChar[0].ToString());
                }
                catch
                { }
            }

            //decode base64String (utf-8?B?)
            occurences = new Regex(@"\?utf-8\?B\?.*\?", RegexOptions.IgnoreCase);
            matches = occurences.Matches(input);
            foreach (Match match in matches)
            {
                byte[] b = Convert.FromBase64String(match.Groups[0].Value.Replace("?utf-8?B?", "").Replace("?UTF-8?B?", "").Replace("?", ""));
                string temp = Encoding.UTF8.GetString(b);
                input = input.Replace(match.Groups[0].Value, temp);
            }

            input = input.Replace("=\r\n", "").Replace('_', ' ');
            input = System.Web.HttpUtility.HtmlEncode(input);
            input = System.Net.WebUtility.HtmlDecode(input);
        }
        catch
        {
            input = "";
        }
        return input;
    }

    private static void createNode(System.Xml.XmlTextWriter writer, string StartElementName, string ElementValue)
    {
        writer.WriteStartElement(StartElementName);
        writer.WriteString(ElementValue);
        writer.WriteEndElement();
    }


    [System.Web.Services.WebMethod(EnableSession = true)]
    public static int GetTabsCount(string TabType)
    {
        int MasterID = Convert.ToInt32(HttpContext.Current.Session["ConfigId"] ?? "0");

        int ReturnCounter = 0;

        try
        {

            using (Linqconnection dc = new Linqconnection())
            {
                var record = (from rec in dc.EmailConfigs
                              where rec.Id == MasterID
                              select rec).AsEnumerable().LastOrDefault();

                if (TabType.Equals(StaticKeywordClass.Sent))
                {
                    ReturnCounter = record.SendedMails.Count();
                }
                else if (TabType.Equals(StaticKeywordClass.Draft))
                {
                    ReturnCounter = record.DraftEmailTables.Count();
                }
                else if (TabType.Equals(StaticKeywordClass.Outbox))
                {
                    ReturnCounter = record.OutBoxMails.Count();
                }
                else if (TabType.Equals(StaticKeywordClass.Starred))
                {
                    ReturnCounter = record.StarredEmailTables.Count();
                }
                else if (TabType.Equals(StaticKeywordClass.Trash))
                {
                    ReturnCounter = record.TrashMailsTables.Where(a => !(a.IsDeleted.HasValue ? a.IsDeleted.Value : true)).Count();
                }
            }
        }
        catch (Exception)
        { }

        return ReturnCounter;
    }


}
public class ListMailDetails{
  public string ID{get;set;}
  public string Attachement{get;set;}
  public string BCC{get;set;}
  public string CC{get;set;}
  public string Body{get;set;}
  public string Subject{get;set;}
  public string To{get;set;}
  public string Date{get;set;}
  public string Replyall { get; set; }
}
public class starList
{
    public string DisplayName { get; set; }
    public string Attachement { get; set; }
    public string AttachName { get; set; }
    public string Bcc { get; set; }
    public string Cc { get; set; }
    public string Body { get; set; }
    public string To { get; set; } // Multiple To
    public string FromAdd { get; set; }
    public string Depart { get; set; }
    public string ID { get; set; }
    public string Date { get; set; }
    public bool ISInbox { get; set; }
    public string Subjects { get; set; }
    public string replyallmail { get; set; }
    public string FinalDate { get; set; }
}





