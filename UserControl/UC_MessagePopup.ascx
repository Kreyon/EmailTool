<%@ Control Language="C#" ClassName="UC_MessagePopup" %>

<script runat="server">

</script>

<style type="text/css">
    .Message_box
    {
        height: auto;
        background-color: #fff;
        position: fixed;
        left: 50%;
        top: 25%;
        background-clip: padding-box;
        border: 1px solid rgba(0, 0, 0, .1);
        border-radius: 2px;
        outline: 0;
        -webkit-box-shadow: 0 3px 9px rgba(0, 0, 0, .3);
        box-shadow: 0 3px 9px rgba(0, 0, 0, .3);
        text-align: left;
        overflow: hidden;
        margin-left: -225px;
        width: 450px;
        min-height: 150px;
        display: none;
    }

    .overlay_bg
    {
        width: 100%;
        height: 100%;
        background-color: rgba(0, 0, 0, .5);
        position: fixed;
        left: 0px;
        top: 0px;
        text-align: center;
        z-index: 1051;
        display: none;
    }

    .alert-box
    {
        width: 100%;
        height: 100%;
        position: relative;
    }

    .msg_header
    {
        width: 100%;
        height: auto;
        display: inline-block;
        padding: 10px 15px;
        color: #fff;
    }

    .bg-conf
    {
        background-color: rgba(56, 115, 177, 0.95);
    }

    .bg-warning
    {
        background-color: rgba(236, 154, 37, 0.95);
    }

    .bg-success
    {
        background-color: rgba(54, 148, 54, 0.95) !important;
    }

    .bg-error
    {
        background-color: rgba(208, 23, 19, 0.95);
    }

    .inner_alert
    {
        position: relative;
        overflow: hidden;
    }

    .icons-div
    {
        position: absolute;
        right: 2px;
        font-size: 110px;
        top: -30px;
        z-index: -1;
    }

    .wr-icon
    {
        color: #b56806;
    }

    .sc-icon
    {
        color: #057719;
    }

    .error-icon
    {
        color: #057719;
    }

    .msg_header h3
    {
        margin: 0;
        font-weight: 300;
        font-size: 22px;
        display: inline-block;
    }

    .content_body
    {
        text-align: center;
        padding: 10px 20px;
        color: #fff;
        min-height: 50px;
        font-weight: 300;
        font-size: 16px;
    }
    .content_body p {
    word-break:break-all;
    }

    .footer_btn
    {
        width: 100%;
        height: auto;
        display: inline-block;
        text-align: center;
        padding-bottom: 10px;
        padding-top: 10px;
    }
    /*gradaint Button*/

    .btn-primary-p
    {
        background-repeat: repeat-x;
        border-color: #245580;
        background-image: linear-gradient(to bottom,#337ab7 0,#265a88 100%);
    }

    .btn-danger-d
    {
        background-repeat: repeat-x;
        border-color: #b92c28 !important;
        background-image: linear-gradient(to bottom,#e48481 0,#b51410 100%);
    }

    .btn-success-s
    {
        background-repeat: repeat-x;
        border-color: #3e8f3e;
        background-image: linear-gradient(to bottom,#5cb85c 0,#419641 100%);
    }

    .btn-warning-w
    {
        background-repeat: repeat-x;
        border-color: #e38d13;
        background-image: linear-gradient(to bottom,#f0ad4e 0,#eb9316 100%);
    }

    .btn-default-d
    {
        text-shadow: 0 1px 0 #fff;
        background-repeat: repeat-x;
        border-color: #ccc;
        background-image: linear-gradient(to bottom,#fff 0,#e0e0e0 100%);
    }

    @media (max-width:479px) and (min-width:320px)
    {
        .Message_box
        {
            width: 300px;
            margin-left: -150px;
        }

        .content_body
        {
            font-size: 14px;
        }

        .msg_header h3
        {
            font-size: 20px;
        }
    }
</style>
<script type="text/javascript">

    var msg_Error = 3;
    var msg_Success = 4;
    var msg_Info = 5;

    var MsgData = function (data) {
        this.Msg = data.Msg,
        this.Heading = data.Heading,
        this.IsConfirm = data.IsConfirm,
        this.Type = data.Type,
        this.Event1 = data.Event1,
        this.Event2 = data.Event2
    };

    var Message = function (content, Excute) {

        content.IsConfirm = content.IsConfirm === undefined ? false : content.IsConfirm;
        content.Heading = content.Heading === undefined ? 'Mail Box' : content.Heading;
        content.Type = content.Type === undefined ? msg_Info : content.Type;
        content.Msg = content.Msg === undefined ? 'Welcome to Mail Box' : content.Msg;

        try {
            if (Excute === undefined) {

                window.setTimeout(function () {
                    $('#conf_msgloader').hide();
                    Message(content, "Excute");
                    return false;
                }, 300);

            } else {
                if (content.IsConfirm) {

                    $('#conf_msgpopup').find(".content_body").html("<p>" + content.Msg + "</p>");
                    $('#conf_msgpopup').show();

                } else if (content.Type == msg_Success) {

                    $('#success_msgpopup').find(".content_body").html("<p>" + content.Msg + "</p>");
                    $('#success_msgpopup').show();

                } else if (content.Type == msg_Error) {

                    $('#error_msgpopup').find(".content_body").html("<p>" + content.Msg + "</p>");
                    $('#error_msgpopup').show();

                } else if (content.Type == msg_Info) {

                    $('#info_msgpopup').find(".content_body").html("<p>" + content.Msg + "</p>");
                    $('#info_msgpopup').show();

                }

                $('#overall_lightbox').show();

                // OK CLICK EVENT
                $('#overall_lightbox').find(".Message_box:visible").find('.popupClick').unbind();
                $('#overall_lightbox').find(".Message_box:visible").find('.popupClick').click(function () {
                    $(this).parent().parent().hide();
                    $(this).parent().parent().parent().hide();

                    if (content.Event1 && typeof content.Event1 == 'function') {
                        content.Event1();
                    }
                });

                // CANCEL CLICK EVENT
                $('#overall_lightbox').find(".Message_box:visible").find('.cancelClick').unbind();
                $('#overall_lightbox').find(".Message_box:visible").find('.cancelClick').click(function () {

                    $(this).parent().parent().hide();
                    $(this).parent().parent().parent().hide();

                    if (content.Event2 && typeof content.Event2 == 'function') {
                        content.Event2();
                    }
                });
            }
        } catch (e) { }
    }

    function LoaderShow(Heading, Message) {

        if (Heading === undefined && Message === undefined) {
            $("#loader_heading").html('Inbox');
            $("#loader_message").html('Mails are sending ... <i class="fa fa-spin fa-spinner"></i>');
        } else {
            $("#loader_heading").html(Heading);
            $("#loader_message").html(Message + ' <i class="fa fa-spin fa-spinner"></i>');
        }
        $('#overall_lightbox').fadeIn(); $('#conf_msgloader').fadeIn();

    }

    function LoaderHide() {
        $('#overall_lightbox').hide(); $('#conf_msgloader').hide();
    }
</script>

<div class="overlay_bg" id="overall_lightbox">

    <!-- Success Box -->
    <div class="Message_box" id="success_msgpopup">
        <div class="inner_alert">
            <div class="icons-div sc-icon"><i class="fa fa-check-circle"></i></div>
            <div class="msg_header bg-success" style="border-bottom: 1px solid #177b0d;">
                <h3>Success</h3>
            </div>
            <div class="content_body bg-success" style="border-top: 1px solid #2aad2a;">
                <p>Recored Deleted Successfully</p>
            </div>
        </div>
        <div class="footer_btn">
            <button type="button" class="btn btn-success btn-success-s btn-sm popupClick">OK</button>
        </div>
    </div>

    <!-- Error Box -->
    <div class="Message_box" id="error_msgpopup">
        <div class="inner_alert">
            <div class="icons-div sc-icon"><i class="fa fa-exclamation-triangle"></i></div>
            <div class="msg_header bg-error" style="border-bottom: 1px solid #ad0000;">
                <h3>Error</h3>
            </div>
            <div class="content_body bg-error" style="border-top: 1px solid #e83a37;">
                <p>You have entered wrong email id and password</p>
            </div>
        </div>
        <div class="footer_btn">
            <button type="button" class="btn btn-danger btn-danger-d btn-sm popupClick">OK</button>
        </div>
    </div>

    <!-- Alert Box -->
    <div class="Message_box" id="info_msgpopup">
        <div class="inner_alert">
            <div class="icons-div wr-icon"><i class="fa fa-exclamation-triangle"></i></div>
            <div class="msg_header bg-warning" style="border-bottom: 1px solid #dc860c;">
                <h3>Alert</h3>
            </div>
            <div class="content_body bg-warning" style="border-top: 1px solid #f1aa47;">
                <p>Please select record to delete</p>
            </div>
        </div>
        <div class="footer_btn">
            <button type="button" class="btn btn-warning btn-warning-w btn-sm popupClick">OK</button>
        </div>
    </div>

    <!-- Confirmation Box -->
    <div class="Message_box" id="conf_msgpopup">
        <div class="inner_alert">
            <div class="icons-div conf-icon"><i class="fa fa-exclamation-circle"></i></div>
            <div class="msg_header bg-conf" style="border-bottom: 1px solid #2661a0;">
                <h3>Confirmation</h3>
            </div>
            <div class="content_body bg-conf" style="border-top: 1px solid #5586bb;">
                <p>Do you really want to delete this record</p>
            </div>
        </div>
        <div class="footer_btn">
            <button type="button" class="btn btn-primary btn-primary-p btn-sm popupClick">YES</button>
            <button type="button" class="btn btn-default btn-default-d btn-sm cancelClick">NO</button>
        </div>
    </div>

    <!-- Loader -->
    <div class="Message_box" id="conf_msgloader">
        <div class="inner_alert">
            <div class="icons-div sc-icon"><i class="fa fa-check-circle"></i></div>
            <div class="msg_header bg-success" style="border-bottom: 1px solid #4b8c39;">
                <h3 id="loader_heading">Loader Heading</h3>
            </div>
            <div class="content_body bg-success" style="border-top: 1px solid #70c358;">
                <p id="loader_message">Loading ... <i class="fa fa-spin fa-spinner"></i></p>
            </div>
        </div>
    </div>
</div>

<!-- EXAMPLE
  * HOW TO USE THIS ALERT BOXES
   
    // FOR SUCCESS
   *   Message({ 'Msg': "Updated successfully", 'Type': msg_Success });
    
    // FOR ERROR
   *   Message({ 'Msg': "Updated successfully", 'Type': msg_Error });

    // FOR ALERT
   *   Message({ 'Msg': "Updated successfully", 'Type': msg_Info });

    // FOR CONFIRMATION
   *    Message({
                "Msg": "Do you really want to delete this", "IsConfirm": true, "Event1": function () {

                    // YES BUTTON EXCUTION
                       alert("yes click");
                }
            });
    -->
