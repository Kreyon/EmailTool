<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<%@ Register Src="~/UserControl/UC_MessagePopup.ascx" TagPrefix="uc1" TagName="UC_MessagePopup" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Email Box</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <script src="js/jquery-1.9.1.min.js"></script>
    <script src="js/jquery.mousewheel.min.js" type="text/javascript"></script>
    <script src="js/popper.min.js" type="text/javascript"></script>
    <script src="js/bootstrap.min.js" type="text/javascript"></script>
    <%-- <script src="js/custom.js" type="text/javascript"></script>--%>
    <script src="js/selectize.min.js" type="text/javascript"></script>
    <link href="css/style.css?1255" rel="stylesheet" />
    <link href="css/font-awesome.min.css" rel="stylesheet" />
    <link href="css/custom.css" rel="stylesheet" />
    <link href="css/font-face.css" rel="stylesheet" />
    <link href="css/materialdesignicons.min.css" rel="stylesheet" />
    <script src="js/editor.js" type="text/javascript"></script>
    <link href="css/editor.css?78" rel="stylesheet" />
    <link href="css/My.css?656" rel="stylesheet" />
    <link href="css/Media.css?566" rel="stylesheet" />
    <link href="css/Loadergmail.css" rel="stylesheet" />
    <link href="css/selectize.default.css?89" rel="stylesheet" />


    <script src="js/paginationForlisting.js?47" type="text/javascript"></script>
    <script src="js/DocumentViewer.js" type="text/javascript"></script>
    <link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700" rel="stylesheet" />
    <style type="text/css">
        .row1, .row2 {
            display: none;
        }



        .select-file {
            position: absolute;
            left: 0;
            top: 0;
            bottom: 0;
            height: 100%;
            width: 100%;
            opacity: 0;
        }

        .att {
            width: 50px;
            float: left;
            height: 39px;
            line-height: 25px;
            text-align: center;
            font-size: 18px;
            border-radius: 2px;
            position: relative;
            color: rgb(255, 255, 255);
            background-color: rgb(108, 117, 125);
            border-color: rgb(108, 117, 125);
        }

        .errormsgbox {
            text-align: CENTER;
            background-color: #10c877;
            margin-top: 100px;
            color: #fff;
            padding: 20px;
        }

        .srch_btn {
            position: absolute;
            top: 3px;
            background-color: transparent;
            border: none;
            right: 10px;
            font-size: 18px;
            color: #b7b7b7;
        }



        @media (max-width:767px) and (min-width:320px) {

            .file-attachted-name {
                -webkit-line-clamp: 1;
                max-height: 30px;
            }
        }
    </style>
    <script type="text/javascript">
        $(document).ready(function () {
            $(function () {
                $('[data-toggle="tooltip"]').tooltip()
            })
        });
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true"></asp:ScriptManager>
        <div class="box_loader" id="loader" style="display: none">
            <div style="bottom: 0; left: 0; overflow: hidden; position: absolute; right: 0; top: 0">
                <div style="animation: a-h .5s 1.25s 1 linear forwards,a-nt .6s 1.25s 1 cubic-bezier(0,0,.2,1); -webkit-animation: a-h .5s 1.25s 1 linear forwards,a-nt .6s 1.25s 1 cubic-bezier(0,0,.2,1); -moz-animation: a-h .5s 1.25s 1 linear forwards,a-nt .6s 1.25s 1 cubic-bezier(0,0,.2,1); background: #eee; border-radius: 50%; height: 800px; left: 50%; margin: -448px -400px 0; position: absolute; top: 50%; transform: scale(0); -webkit-transform: scale(0); -moz-transform: scale(0); width: 800px"></div>
            </div>
            <div style="height: 100%; text-align: center">
                <div style="height: 50%; margin: 0 0 -140px"></div>
                <div style="height: 128px; margin: 0 auto; position: relative; width: 176px">
                    <div style="animation: a-s .5s .5s 1 linear forwards,a-e 1.75s .5s 1 cubic-bezier(0,0,.67,1) forwards; -moz-animation: a-s .5s .5s 1 linear forwards,a-e 1.75s .5s 1 cubic-bezier(0,0,.67,1) forwards; -webkit-animation: a-s .5s .5s 1 linear forwards,a-e 1.75s .5s 1 cubic-bezier(0,0,.67,1) forwards; opacity: 0; transform: scale(.68); -webki-transform: scale(.68); -moz-transform: scale(.68)">
                        <div style="background: #ddd; border-radius: 12px; box-shadow: 0 15px 15px -15px rgba(0,0,0,.3); -webkit-box-shadow: 0 15px 15px -15px rgba(0,0,0,.3); -moz-box-shadow: 0 15px 15px -15px rgba(0,0,0,.3); height: 128px; left: 0; overflow: hidden; position: absolute; top: 0; transform: scale(1); -webkit-transform: scale(1); -moz-transform: scale(1); width: 176px">
                            <div style="animation: a-nt .667s 1.5s 1 cubic-bezier(.4,0,.2,1) forwards; background: #10c877; border-radius: 50%; height: 270px; left: 88px; margin: -135px; position: absolute; top: 25px; transform: scale(.5); width: 270px"></div>
                            <div style="height: 128px; left: 20px; overflow: hidden; position: absolute; top: 0; transform: scale(1); -webkit-transform: scale(1); -moz-transform: scale(1); width: 136px">
                                <div style="background: #e1e1e1; height: 128px; left: 0; position: absolute; top: 0; width: 68px">
                                    <div style="animation: a-h .25s 1.25s 1 forwards; -webkit-animation: a-h .25s 1.25s 1 forwards; -moz-animation: a-h .25s 1.25s 1 forwards; background: #eee; height: 128px; left: 0; opacity: 1; position: absolute; top: 0; width: 68px"></div>
                                </div>
                                <div style="background: #eee; height: 100px; left: 1px; position: absolute; top: 56px; transform: scaleY(.73)rotate(135deg); -webkit-transform: scaleY(.73)rotate(135deg); -moz-transform: scaleY(.73)rotate(135deg); width: 200px"></div>
                            </div>
                            <div style="background: #bbb; height: 176px; left: 0; position: absolute; top: -100px; transform: scaleY(.73)rotate(135deg); -moz-transform: scaleY(.73)rotate(135deg); -webkit-transform: scaleY(.73)rotate(135deg); width: 176px">
                                <div style="background: #eee; border-radius: 12px 12px 0 0; bottom: 117px; height: 12px; left: 55px; position: absolute; transform: rotate(-135deg)scaleY(1.37); -webkit-transform: rotate(-135deg)scaleY(1.37); -moz-transform: rotate(-135deg)scaleY(1.37); width: 136px"></div>
                                <div style="background: #eee; height: 96px; position: absolute; right: 0; top: 0; width: 96px"></div>
                                <div style="box-shadow: inset 0 0 10px #888; -webkit-box-shadow: inset 0 0 10px #888; -moz-box-shadow: inset 0 0 10px #888; height: 155px; position: absolute; right: 0; top: 0; width: 155px"></div>
                            </div>
                            <div style="animation: a-s .167s 1.283s 1 linear forwards,a-es 1.184s 1.283s 1 cubic-bezier(.4,0,.2,1) forwards; -webkit-animation: a-s .167s 1.283s 1 linear forwards,a-es 1.184s 1.283s 1 cubic-bezier(.4,0,.2,1) forwards; -moz-animation: a-s .167s 1.283s 1 linear forwards,a-es 1.184s 1.283s 1 cubic-bezier(.4,0,.2,1) forwards; background: linear-gradient(0,rgba(38,38,38,0),rgba(38,38,38,.2)); background: -webkit-linear-gradient(0,rgba(38,38,38,0),rgba(38,38,38,.2)); background: -moz-linear-gradient(0,rgba(38,38,38,0),rgba(38,38,38,.2)); height: 225px; left: 0; opacity: 0; position: absolute; top: 0; transform: rotate(-43deg); -webkit-transform: rotate(-43deg); -moz-transform: rotate(-43deg); transform-origin: 0 13px; -moz-transform-origin: 0 13px; -webkit-transform-origin: 0 13px; width: 176px"></div>
                        </div>
                        <div style="animation: a-ef 1.184s 1.283s 1 cubic-bezier(.4,0,.2,1) forwards; -moz-animation: a-ef 1.184s 1.283s 1 cubic-bezier(.4,0,.2,1) forwards; -webkit-animation: a-ef 1.184s 1.283s 1 cubic-bezier(.4,0,.2,1) forwards; border-radius: 12px; height: 100px; left: 0; overflow: hidden; position: absolute; top: 0; transform: scaleY(1); -webkit-transform: scaleY(1); -moz-transform: scaleY(1); transform-origin: top; -moz-transform-origin: top; -webkit-transform-origin: top; width: 176px">
                            <div style="height: 176px; left: 0; position: absolute; top: -100px; transform: scaleY(.73)rotate(135deg); -webkit-transform: scaleY(.73)rotate(135deg); -moz-transform: scaleY(.73)rotate(135deg); width: 176px">
                                <div style="animation: a-s .167s 1.283s 1 linear forwards; box-shadow: -5px 0 12px rgba(0,0,0,.5); -moz-box-shadow: -5px 0 12px rgba(0,0,0,.5); -webkit-box-shadow: -5px 0 12px rgba(0,0,0,.5); height: 176px; left: 0; opacity: 0; position: absolute; top: 0; width: 176px"></div>
                                <div style="background: #ddd; height: 176px; left: 0; overflow: hidden; position: absolute; top: 0; width: 176px">
                                    <div style="animation: a-nt .667s 1.25s 1 cubic-bezier(.4,0,.2,1) forwards; -webkit-animation: a-nt .667s 1.25s 1 cubic-bezier(.4,0,.2,1) forwards; -moz-animation: a-nt .667s 1.25s 1 cubic-bezier(.4,0,.2,1) forwards; background: #10c877; border-radius: 50%; bottom: 41px; height: 225px; left: 41px; position: absolute; transform: scale(0); -moz-transform: scale(0); -webkit-transform: scale(0); width: 225px"></div>
                                    <div style="background: #f1f1f1; height: 128px; left: 24px; position: absolute; top: 24px; transform: rotate(90deg); -webkit-transform: rotate(90deg); -moz-transform: rotate(90deg); width: 128px"></div>
                                    <div style="animation: a-efs 1.184s 1.283s 1 cubic-bezier(.4,0,.2,1) forwards; -moz-animation: a-efs 1.184s 1.283s 1 cubic-bezier(.4,0,.2,1) forwards; -webkit-animation: a-efs 1.184s 1.283s 1 cubic-bezier(.4,0,.2,1) forwards; background: #fff; height: 176px; opacity: 0; transform: rotate(90deg); -webkit-transform: rotate(90deg); -moz-transform: rotate(90deg); width: 176px"></div>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div id="nlpt"></div>
                <div style="animation: a-s .25s 1.25s 1 forwards; opacity: 0" class="msg">Loading&hellip;</div>
            </div>
            <%-- <div class="loader">
                <span></span>
                <span></span>
                <span></span>
            </div>--%>
        </div>
       
        <div>
            <div class="top-bar head_topbar">
                <div class="container">
                    <div class="row d-flex align-items-center">
                        <div class="col-md-6 col-6 d-md-block div_left">
                            <h2 class="mrn-btm0">Mail Box</h2>
                        </div>
                        <div class="col-md-6 col-6 d-md-block div_left">
                            <i class="mdi mdi-menu mobmenubar" id="menu-bar"></i>
                            <div class="configure_mail">
                                <a data-toggle="modal" data-target="#SigInModal"><span class="fa fa-gear"></span></a>
                            </div>
                               
                        </div>
                    </div>
                </div>
            </div>
            </div>
         
            <div class="email_cont">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="content-wrapper px-3 pt-0 pb-0">
                            <div class="email-wrapper wrapper">
                                <div class="row align-items-stretch">
                                    <div class="mail-sidebar d-lg-block col-md-3 col-lg-2 pt-3 bg-lightgry mob-padding0" id="slide-menu">
                                        <div class="menu-bar">
                                            <ul class="menu-items menu_list_option">
                                                <li class="compose mb-3">
                                                    <a href="javascript:;" class="btn btn-dark btn-block" style="width: 100%;" onclick="opencompose();">Compose</a></li>
                                                <li class="active" id="inboxli" onclick="openinbox();"><a href="javascript:;"><i class="mdi mdi-email-outline"></i>Inbox</a><span class="badge badge-pill badge-success" id="count"></span></li>
                                                <li id="sendboxli" onclick="opensendbox(1);"><a href="javascript:;"><i class="mdi mdi-share"></i>Sent</a><span class="badge badge-pill badge-primary" id="sendcount" runat="server">0</span></li>
                                                <li id="draftli" onclick="showdraft(1);"><a href="javascript:;"><i class="mdi mdi-file-outline"></i>Draft</a><span id="draftcount" runat="server" class="badge badge-pill badge-warning">0</span></li>
                                                <li id="outboxli" onclick="openoutbox(1);"><a href="javascript:;"><i class="mdi mdi-upload"></i>Outbox</a><span class="badge badge-pill badge-info" id="outboxcount" runat="server">0</span></li>
                                                <li id="starli" onclick="staroutbox(1);"><a href="javascript:;"><i class="mdi mdi-star-outline"></i>Starred</a><span class="badge badge-pill badge-danger" id="starredcount" runat="server">0</span></li>
                                                <li id="trashli" onclick="opentrash(1);"><a href="javascript:;"><i class="mdi mdi-delete"></i>Trash</a><span class="badge badge-pill badge-dark" id="trashcount" runat="server">0</span></li>
                                            </ul>
                                            <%--<div class="wrapper">
                    <div class="online-status d-flex justify-content-between align-items-center">
                    <p class="chat">Chats</p> <span class="status offline online"></span></div>
                  </div>--%>
                                            <%--<ul class="profile-list">
                    <li class="profile-list-item"> <a href="#"> <span class="pro-pic"><img src="https://placehold.it/100x100" alt=""></span><div class="user"><p class="u-name">David</p><p class="u-designation">Python Developer</p></div> </a></li>
                    <li class="profile-list-item"> <a href="#"> <span class="pro-pic"><img src="https://placehold.it/100x100" alt=""></span><div class="user"><p class="u-name">Stella Johnson</p><p class="u-designation">SEO Expert</p></div> </a></li>
                    <li class="profile-list-item"> <a href="#"> <span class="pro-pic"><img src="https://placehold.it/100x100" alt=""></span><div class="user"><p class="u-name">Catherine</p><p class="u-designation">IOS Developer</p></div> </a></li>
                    <li class="profile-list-item"> <a href="#"> <span class="pro-pic"><img src="https://placehold.it/100x100" alt=""></span><div class="user"><p class="u-name">John Doe</p><p class="u-designation">Business Analyst</p></div> </a></li>
                    <li class="profile-list-item"> <a href="#"> <span class="pro-pic"><img src="https://placehold.it/100x100" alt=""></span><div class="user"><p class="u-name">Daniel Russell</p><p class="u-designation">Tester</p></div> </a></li>
                    <li class="profile-list-item"> <a href="#"> <span class="pro-pic"><img src="https://placehold.it/100x100" alt=""></span><div class="user"><p class="u-name">Sarah Graves</p><p class="u-designation">Admin</p></div> </a></li>
                    <li class="profile-list-item"> <a href="#"> <span class="pro-pic"><img src="https://placehold.it/100x100" alt=""></span><div class="user"><p class="u-name">Sophia Lara</p><p class="u-designation">UI/UX</p></div> </a></li>
                    <li class="profile-list-item"> <a href="#"> <span class="pro-pic"><img src="https://placehold.it/100x100" alt=""></span><div class="user"><p class="u-name">Catherine Myers</p><p class="u-designation">Business Analyst</p></div> </a></li>
                    <li class="profile-list-item"> <a href="#"> <span class="pro-pic"><img src="https://placehold.it/100x100" alt=""></span><div class="user"><p class="u-name">Tim</p><p class="u-designation">PHP Developer</p></div> </a></li>
                  </ul>--%>
                                        </div>
                                    </div>
                                    <div class="mail-view col-md-9 col-lg-10 bg-white pd_left-right10 newmailview">
                                        <div class="row">
                                            <%--inbox/sent--%>
                                            <div class="inbox-div col-md-12 col-lg-12 " id="inbox">
                                                <div class="row">

                                                    <div class="mail-list-container inbox_mail_listcontainer col-lg-4 col-md-5 pt-4 pb-4 border-right bg-white mob-paddingrt_left0 mob_contnrinboxlist div_left">
                                                        <div class="mb-3 px-2">
                                                            <div class="form-group">
                                                                <h3 class="mob_visble" id="headtag">Inbox</h3>
                                                                <div class="searchbox" id="SearchDivInbox">
                                                                    <input class="form-control inpsearch_inbox w-100" type="search" placeholder="Search mail" id="txtSearchmail" />
                                                                    <button type="button" class="srch_btn" onclick="" id="SearchMailBtn"><span class="mdi mdi-magnify"></span></button>

                                                                </div>
                                                                <div class="searchbox" id="SearchDivSent" style="display: none">
                                                                    <input class="form-control inpsearch_inbox w-100" type="search" placeholder="Search mail" id="txtSearchSentBox" />
                                                                    <button type="button" class="srch_btn" onclick="" id="SearchSentBtn"><span class="mdi mdi-magnify"></span></button>

                                                                </div>
                                                                <div class="searchbox" id="SearchDivoutBox" style="display: none">
                                                                    <input class="form-control inpsearch_inbox w-100" type="search" placeholder="Search mail" id="txtSearchOut" />
                                                                    <button type="button" class="srch_btn" onclick="" id="btnSearchOut"><span class="mdi mdi-magnify"></span></button>

                                                                </div>
                                                                <div class="searchbox" id="SearchDivDraft" style="display: none">
                                                                    <input class="form-control inpsearch_inbox w-100" type="search" placeholder="Search mail" id="txtSearchDraft" />
                                                                    <button type="button" class="srch_btn" onclick="" id="btnSearchDraft"><span class="mdi mdi-magnify"></span></button>

                                                                </div>

                                                                <div class="searchbox" id="SearchDivTrash" style="display: none">
                                                                    <input class="form-control inpsearch_inbox w-100" type="search" placeholder="Search mail" id="txtSearchTrash" />
                                                                    <button type="button" class="srch_btn" onclick="" id="btnSearchTrash"><span class="mdi mdi-magnify"></span></button>

                                                                </div>

                                                                <div class="searchbox" id="SearchDivStar" style="display: none">
                                                                    <input class="form-control inpsearch_inbox w-100" type="search" placeholder="Search mail" id="txtSearchDivstar" />
                                                                    <button type="button" class="srch_btn" onclick="" id="btnSearchDivstar"><span class="mdi mdi-magnify"></span></button>

                                                                </div>
                                                                <div id="BulkDeleteInbox" class="deletall_inboxcheck">
                                                                    <div class="form-check check_inptblock chk_inbox">
                                                                        <div class="checkbox" data-toggle="tooltip" data-placement="top" title="Select All" data-original-title="Select All" aria-describedby="">
                                                                            <label>
                                                                                <input type="checkbox" id="CheckboxHead" /><span class="cr"><i class="cr-icon mdi mdi-check"></i></span></label>
                                                                        </div>
                                                                    </div>
                                                                    <button type="button" onclick="InboxBulkDelete();" class="btn btn-sm btn-danger btn_selcalldelte" data-toggle="tooltip" data-placement="top" title="Delete" data-original-title="Delete"><span class="mdi mdi-delete"></span></button>
                                                                </div>
                                                                <div id="BulkDeleteSent" class="deletall_inboxcheck" style="display: none;">
                                                                    <div class="form-check check_inptblock chk_inbox">
                                                                        <div class="checkbox" data-toggle="tooltip" data-placement="top" title="Select All" data-original-title="Select All" aria-describedby="">
                                                                            <label>
                                                                                <input type="checkbox" id="CheckboxHeadSent" /><span class="cr"><i class="cr-icon mdi mdi-check"></i></span></label>
                                                                        </div>
                                                                    </div>
                                                                    <button type="button" onclick="SentBulkDelete();" class="btn btn-sm btn-danger btn_selcalldelte" data-toggle="tooltip" data-placement="top" title="Delete" data-original-title="Delete"><span class="mdi mdi-delete"></span></button>
                                                                </div>
                                                                <div id="BulkDeleteDraft" class="deletall_inboxcheck" style="display: none;">
                                                                    <div class="form-check check_inptblock chk_inbox">
                                                                        <div class="checkbox" data-toggle="tooltip" data-placement="top" title="Select All" data-original-title="Select All" aria-describedby="">
                                                                            <label>
                                                                                <input type="checkbox" id="CheckboxHeadDraft" /><span class="cr"><i class="cr-icon mdi mdi-check"></i></span></label>
                                                                        </div>
                                                                    </div>
                                                                    <button type="button" onclick="DraftBulkDelete();" class="btn btn-sm btn-danger btn_selcalldelte" data-toggle="tooltip" data-placement="top" title="Delete" data-original-title="Delete"><span class="mdi mdi-delete"></span></button>
                                                                </div>
                                                                <div id="BulkDeleteOutbox" class="deletall_inboxcheck" style="display: none;">
                                                                    <div class="form-check check_inptblock chk_inbox">
                                                                        <div class="checkbox" data-toggle="tooltip" data-placement="top" title="Select All" data-original-title="Select All" aria-describedby="">
                                                                            <label>
                                                                                <input type="checkbox" id="CheckboxHeadOutbox" /><span class="cr"><i class="cr-icon mdi mdi-check"></i></span></label>
                                                                        </div>
                                                                    </div>
                                                                    <button type="button" onclick="OutboxBulkDelete();" class="btn btn-sm btn-danger btn_selcalldelte" data-toggle="tooltip" data-placement="top" title="Delete" data-original-title="Delete"><span class="mdi mdi-delete"></span></button>
                                                                </div>
                                                                <div id="BulkDeleteTrash" class="deletall_inboxcheck" style="display: none;">
                                                                    <div class="form-check check_inptblock chk_inbox">
                                                                        <div class="checkbox" data-toggle="tooltip" data-placement="top" title="Select All" data-original-title="Select All" aria-describedby="">
                                                                            <label>
                                                                                <input type="checkbox" id="CheckboxHeadTrash" /><span class="cr"><i class="cr-icon mdi mdi-check"></i></span></label>
                                                                        </div>
                                                                    </div>
                                                                    <button type="button" onclick="TrashBulkDelete();" class="btn btn-sm btn-danger btn_selcalldelte" data-toggle="tooltip" data-placement="top" title="Delete" data-original-title="Delete"><span class="mdi mdi-delete"></span></button>
                                                                    <button type="button" onclick="TrashBulkRestore();" class="btn btn-sm btn-danger btn_selcalldelte" data-toggle="tooltip" data-placement="top" title="Restore" data-original-title="Restore"><span class="mdi mdi-restore"></span></button>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="inbox_mail_list " id="inboxlist">
                                                            <%-- <div class="mail-list">
                                       
                                        <div class="form-check check_inptblock chk_inbox">
                                            <div class="checkbox">
                                                <label>
                                                    <input type="checkbox" id="Checkbox1" /><span class="cr"><i class="cr-icon mdi mdi-check"></i></span></label>
                                            </div>
                                        </div>
                                        <div class="details star-inptbox">
                                            <i class="mdi mdi-star-outline"></i>
                                        </div>
                                        <div class="content">
                                            <p class="sender-name">David Moore</p>
                                            <p class="message_text">Hi Emily, Please be informed that the new project presentation is due Monday.</p>
                                        </div>
                                       
                                    </div>
                                    <div class="mail-list new_mail">
                                       <div class="form-check check_inptblock chk_inbox">
                                            <div class="checkbox">
                                                <label>
                                                    <input type="checkbox" id="Checkbox2" /><span class="cr"><i class="cr-icon mdi mdi-check"></i></span></label>
                                            </div>
                                        </div>
                                        <div class="details star-inptbox">
                                            <i class="mdi mdi-star favorite"></i>
                                        </div>
                                        <div class="content">
                                            <p class="sender-name">Microsoft Account Password Change</p>
                                            <p class="message_text">Change the password for your Microsoft Account using the security code 35525</p>
                                        </div>
                                    </div>
                                    <div class="mail-list">
                                      <div class="form-check check_inptblock chk_inbox">
                                            <div class="checkbox">
                                                <label>
                                                    <input type="checkbox" id="Checkbox3" /><span class="cr"><i class="cr-icon mdi mdi-check"></i></span></label>
                                            </div>
                                        </div>
                                        <div class="details star-inptbox">
                                            <i class="mdi mdi-star favorite"></i>
                                        </div>
                                        <div class="content">
                                            <p class="sender-name">Sophia Lara</p>
                                            <p class="message_text">Hello, last date for registering for the annual music event is closing in</p>
                                        </div>
                                       
                                    </div>
                                    <div class="mail-list">
                                       <div class="form-check check_inptblock chk_inbox">
                                            <div class="checkbox">
                                                <label>
                                                    <input type="checkbox" id="Checkbox4" /><span class="cr"><i class="cr-icon mdi mdi-check"></i></span></label>
                                            </div>
                                        </div>
                                        <div class="details star-inptbox">
                                            <i class="mdi mdi-star-outline"></i>
                                        </div>
                                        <div class="content">
                                            <p class="sender-name">Stella Davidson</p>
                                            <p class="message_text">Hey there, can you send me this year’s holiday calendar?</p>
                                        </div>
                                       
                                    </div>
                                    <div class="mail-list">
                                        <div class="form-check check_inptblock chk_inbox">
                                            <div class="checkbox">
                                                <label>
                                                    <input type="checkbox" id="Checkbox5" /><span class="cr"><i class="cr-icon mdi mdi-check"></i></span></label>
                                            </div>
                                        </div>
                                        <div class="details star-inptbox">
                                            <i class="mdi mdi-star favorite"></i>
                                        </div>
                                        <div class="content">
                                            <p class="sender-name">David Moore</p>
                                            <p class="message_text">FYI</p>
                                        </div>
                                        
                                    </div>
                                    <div class="mail-list">
                                        <div class="form-check check_inptblock chk_inbox">
                                            <div class="checkbox">
                                                <label>
                                                    <input type="checkbox" id="Checkbox6" /><span class="cr"><i class="cr-icon mdi mdi-check"></i></span></label>
                                            </div>
                                        </div>
                                        <div class="details star-inptbox">
                                            <i class="mdi mdi-star favorite"></i>
                                        </div>
                                        <div class="content">
                                            <p class="sender-name">Daniel Russel</p>
                                            <p class="message_text">Hi, Please find this week’s update..</p>
                                        </div>
                                       
                                    </div>
                                    <div class="mail-list">
                                        <div class="form-check check_inptblock chk_inbox">
                                            <div class="checkbox">
                                                <label>
                                                    <input type="checkbox" id="Checkbox7" /><span class="cr"><i class="cr-icon mdi mdi-check"></i></span></label>
                                            </div>
                                        </div>
                                        <div class="details star-inptbox">
                                            <i class="mdi mdi-star favorite"></i>
                                        </div>
                                        <div class="content">
                                            <p class="sender-name">Sarah Graves</p>
                                            <p class="message_text">Hey, can you send me this year’s holiday calendar ?</p>
                                        </div>
                                       
                                    </div>
                                    <div class="mail-list">
                                       <div class="form-check check_inptblock chk_inbox">
                                            <div class="checkbox">
                                                <label>
                                                    <input type="checkbox" id="Checkbox8" /><span class="cr"><i class="cr-icon mdi mdi-check"></i></span></label>
                                            </div>
                                        </div>
                                        <div class="details star-inptbox">
                                            <i class="mdi mdi-star-outline"></i>
                                        </div>
                                        <div class="content">
                                            <p class="sender-name">Bruno King</p>
                                            <p class="message_text">Hi, Please find this week’s monitoring report in the attachment.</p>
                                        </div>
                                       
                                    </div>
                                    <div class="mail-list">
                                        <div class="form-check check_inptblock chk_inbox">
                                            <div class="checkbox">
                                                <label>
                                                    <input type="checkbox" id="Checkbox9" /><span class="cr"><i class="cr-icon mdi mdi-check"></i></span></label>
                                            </div>
                                        </div>
                                        <div class="details star-inptbox">
                                            <i class="mdi mdi-star favorite"></i>
                                        </div>
                                        <div class="content">
                                            <p class="sender-name">Me, Mark</p>
                                            <p class="message_text">Hi, Testing is complete. The system is ready to go live.</p>
                                        </div>
                                       
                                    </div>
                                    <div class="mail-list">
                                       <div class="form-check check_inptblock chk_inbox">
                                            <div class="checkbox">
                                                <label>
                                                    <input type="checkbox" id="Checkbox10" /><span class="cr"><i class="cr-icon mdi mdi-check"></i></span></label>
                                            </div>
                                        </div>
                                        <div class="details star-inptbox">
                                            <i class="mdi mdi-star-outline"></i>
                                        </div>
                                        <div class="content">
                                            <p class="sender-name">Catherine Myers</p>
                                            <p class="message_text">Template Market: Limited Period Offer!!! 50% Discount on all Templates.</p>
                                        </div>
                                        
                                    </div>
                                    <div class="mail-list">
                                      <div class="form-check check_inptblock chk_inbox">
                                            <div class="checkbox">
                                                <label>
                                                    <input type="checkbox" id="Checkbox11" /><span class="cr"><i class="cr-icon mdi mdi-check"></i></span></label>
                                            </div>
                                        </div>
                                        <div class="details star-inptbox">
                                            <i class="mdi mdi-star favorite"></i>
                                        </div>
                                        <div class="content">
                                            <p class="sender-name">Daniel Russell</p>
                                            <p class="message_text">Hi Emily, Please approve my leaves for 10 days from 10th May to 20th May.</p>
                                        </div>
                                        
                                    </div>
                                    <div class="mail-list">
                                      <div class="form-check check_inptblock chk_inbox">
                                            <div class="checkbox">
                                                <label>
                                                    <input type="checkbox" id="Checkbox12" /><span class="cr"><i class="cr-icon mdi mdi-check"></i></span></label>
                                            </div>
                                        </div>
                                        <div class="details star-inptbox">
                                            <i class="mdi mdi-star favorite"></i>
                                        </div>
                                        <div class="content">
                                            <p class="sender-name">Sarah Graves</p>
                                            <p class="message_text">Hello there, Make the most of the limited period offer. Grab your favorites</p>
                                        </div>
                                        
                                    </div>
                                    <div class="mail-list">
                                       <div class="form-check check_inptblock chk_inbox">
                                            <div class="checkbox">
                                                <label>
                                                    <input type="checkbox" id="Checkbox13" /><span class="cr"><i class="cr-icon mdi mdi-check"></i></span></label>
                                            </div>
                                        </div>
                                        <div class="details star-inptbox">
                                            <i class="mdi mdi-star favorite"></i>
                                        </div>
                                        <div class="content">
                                            <p class="sender-name">John Doe</p>
                                            <p class="message_text">This is the first reminder to complete the online cybersecurity course</p>
                                        </div>
                                       
                                    </div>
                                    <div class="mail-list">
                                       <div class="form-check check_inptblock chk_inbox">
                                            <div class="checkbox">
                                                <label>
                                                    <input type="checkbox" id="Checkbox14" /><span class="cr"><i class="cr-icon mdi mdi-check"></i></span></label>
                                            </div>
                                        </div>
                                        <div class="details star-inptbox">
                                            <i class="mdi mdi-star-outline"></i>
                                        </div>
                                        <div class="content">
                                            <p class="sender-name">Bruno</p>
                                            <p class="message_text">Dear Employee, As per the regulations all employees are required to complete</p>
                                        </div>
                                       
                                    </div>--%>
                                                        </div>
                                                        <div class="paginationbox" id="paginationdiv">
                                                            <nav aria-label="Page navigation example">
                                                                <ul class="pagination justify-content-end pull-right" id="DivPager">
                                                                    <%-- <li class="page-item disabled">
                                                                        <a class="page-link" href="javascript:;" tabindex="-1" id="next">Previous</a>
                                                                    </li>
                                                                                                                                 <li class="page-item"><a class="page-link" href="#">1</a></li>
                                                              <li class="page-item"><a class="page-link" href="#">2</a></li>
                                                              <li class="page-item"><a class="page-link" href="#">3</a></li>
                                                                    <li class="page-item">
                                                                        <a class="page-link" href="javascript:;" id="prev">Next</a>
                                                                    </li>--%>
                                                                </ul>
                                                            </nav>

                                                        </div>
                                                    </div>
                                                    <%--inbox mail--%>
                                                    <div class="mail-view  col-md-7 col-lg-8 bg-white pd_left-right10 mob-inbox mob_contnr-inbox div_left" id="detail">
                                                        <%-- <div class="row">
                                    <div class="col-md-12 mb-4 mt-4 tab_tp_btm10">
                                        <div class="btn-toolbar">
                                            <div class="btn-group tab-mrgnbtm5">
                                                <button type="button" class="btn btn-sm btn-outline-secondary"><i class="mdi mdi-reply text-primary"></i>Reply</button>
                                                <button type="button" class="btn btn-sm btn-outline-secondary"><i class="mdi mdi-reply-all text-primary"></i>Reply All</button>
                                                <button type="button" class="btn btn-sm btn-outline-secondary"><i class="mdi mdi-share text-primary"></i>Forward</button>
                                            </div>
                                            <div class="btn-group">
                                                <button type="button" class="btn btn-sm btn-outline-secondary"><i class="mdi mdi-attachment text-primary"></i>Attach</button>
                                                <button type="button" class="btn btn-sm btn-outline-secondary"><i class="mdi mdi-delete text-primary"></i>Delete</button>
                                            </div>
                                            <div class="inf_inbx">
                                                <i class="mdi mdi-label"></i>
                                                <span>Inbox
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="message-body">
                                    <div class="sender-details">
                                        <img class="img-sm rounded-circle mr-3" alt="" src="images/userprofile.png" />
                                      
                                        <div class="details">
                                            <p class="msg-subject fw600">
                                                Weekly Update - Week 19 (May 8, 2017 - May 14, 2017)
                                            </p>
                                            <p class="sender-email fw600">
                                                Sarah Graves
                        <a href="#">itsmesarah268@gmail.com</a>
                                                &nbsp;<i class="mdi mdi-account-multiple-plus"></i>
                                            </p>
                                        </div>
                                    </div>
                                    <div class="message-content">
                                        <p>Hi Emily,</p>
                                        <p>This week has been a great week and the team is right on schedule with the set deadline. The team has made great progress and achievements this week. At the current rate we will be able to deliver the product right on time and meet the quality that is expected of us. Attached are the seminar report held this week by our team and the final product design that needs your approval at the earliest.</p>
                                        <p>For the coming week the highest priority is given to the development for <a href="http://www.bootstrapdash.com/" target="_blank">http://www.bootstrapdash.com/</a> once the design is approved and necessary improvements are made.</p>
                                        <p>
                                            <br>
                                            <br>
                                            Regards,<br>
                                            Sarah Graves
                                        </p>
                                    </div>
                                    <div class="attachments-sections">
                                        <ul>
                                            <li>
                                                <div class="thumb"><i class="mdi mdi-file-pdf"></i></div>
                                                <div class="details">
                                                    <p class="file-name">Seminar Reports.pdf</p>
                                                    <div class="buttons">
                                                        <p class="file-size">678Kb</p>
                                                        <a href="#" class="view">View</a>
                                                        <a href="#" class="download">Download</a>
                                                    </div>
                                                </div>
                                            </li>
                                            <li>
                                                <div class="thumb"><i class="mdi mdi-file-image"></i></div>
                                                <div class="details">
                                                    <p class="file-name">Product Design.jpg</p>
                                                    <div class="buttons">
                                                        <p class="file-size">1.96Mb</p>
                                                        <a href="#" class="view">View</a>
                                                        <a href="#" class="download">Download</a>
                                                    </div>
                                                </div>
                                            </li>
                                        </ul>
                                    </div>
                                </div>--%>
                                                    </div>


                                                    <div class="mail-view  col-md-7 col-lg-8 bg-white mob-sentbox" style="display: none;">
                                                        <div class="row">
                                                            <div class="col-md-12 mb-4 mt-4 tab_tp_btm10">
                                                                <div class="btn-toolbar">
                                                                    <div class="btn-group tab-mrgnbtm5">
                                                                        <button type="button" class="btn btn-sm btn-outline-secondary"><i class="mdi mdi-reply text-primary"></i>Reply</button>
                                                                        <button type="button" class="btn btn-sm btn-outline-secondary"><i class="mdi mdi-share text-primary"></i>Forward</button>
                                                                    </div>
                                                                    <div class="btn-group">
                                                                        <%--<button type="button" class="btn btn-sm btn-outline-secondary"><i class="mdi mdi-attachment text-primary"></i>Attach</button>--%>
                                                                        <button type="button" class="btn btn-sm btn-outline-secondary"><i class="mdi mdi-delete text-primary"></i>Delete</button>
                                                                        <button type="button" class="btn btn-sm btn-outline-secondary"><i class="mdi mdi-keyboard-backspace text-primary"></i>Back</button>
                                                                    </div>
                                                                    <div class="inf_inbx">
                                                                        <i class="mdi mdi-label"></i>
                                                                        <span>Sentbox
                                                                        </span>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="message-body">

                                                            <div class="boxsent-Title">
                                                                <p class="msg-subjectsent fw600">
                                                                    Weekly Update
                                                                </p>
                                                            </div>
                                                            <div class="sender-details">
                                                                <img class="img-sm rounded-circle mr-3" alt="" src="images/userprofile.png" />

                                                                <div class="details tab_details_sendr">
                                                                    <p class="msg-date">
                                                                        Nov 1, 2018, 8:41 PM 
                                                                    </p>
                                                                    <p class="sender-email fw600">
                                                                        Sarah Graves &nbsp<a href="#">itsmesarah268@gmail.com</a>
                                                                    </p>
                                                                    <p class="msg-sento">
                                                                        <span>To</span>&nbsp Shane warne
                                                                    </p>
                                                                </div>
                                                            </div>
                                                            <div class="message-content">
                                                                <p>This week has been a great week and the team is right on schedule with the set deadline. The team has made great progress and achievements this week. At the current rate we will be able to deliver the product right on time and meet the quality that is expected of us. Attached are the seminar report held this week by our team and the final product design that needs your approval at the earliest.</p>
                                                            </div>
                                                            <div class="forwd_rply">
                                                                <button type="button" class="btn btn-secondary"><i class="mdi mdi-reply text-dark"></i>Reply</button>
                                                                <button type="button" class="btn btn-secondary"><i class="mdi mdi-forward text-dark"></i>Forward</button>
                                                            </div>
                                                            </>
                                                        </div>
                                                        <div class="mail-view col-md-7 col-lg-8 bg-white mob-outbox" style="display: none;">
                                                            <div class="row">
                                                                <div class="col-md-12 mb-4 mt-4">
                                                                    <div class="btn-toolbar">
                                                                        <div class="inf_inbx">
                                                                            <i class="mdi mdi-label"></i>
                                                                            <span>Outbox
                                                                            </span>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="message-body">
                                                                <div class="boxsent-Title">
                                                                    <p class="msg-subjectsent fw600">
                                                                        Team Task
                                                                    </p>
                                                                </div>
                                                                <div class="sender-details">
                                                                    <img class="img-sm rounded-circle mr-3" alt="" src="images/userprofile.png" />

                                                                    <div class="details tab_details_sendr">
                                                                        <p class="msg-date">
                                                                            Nov 2, 2018, 3:50 PM 
                                                                        </p>
                                                                        <p class="sender-email fw600">
                                                                            Sonty Johnes &nbsp<a href="#">Sontyjohnes21@gmail.com</a>
                                                                        </p>
                                                                        <p class="msg-sento">
                                                                            <span>To</span>&nbsp Mark Luise
                                                                        </p>
                                                                    </div>
                                                                </div>
                                                                <div class="message-content">
                                                                    <p>A new Task feed is sent to you by Naveen kumar Yadav for task titled tasknaveen. Please click view details to read the message. Attached are the seminar report held this week by our team and the final product design that needs your approval at the earliest.</p>
                                                                </div>
                                                                <div class="forwd_rply">
                                                                    <button type="button" class="btn btn-secondary"><i class="mdi mdi-send text-dark"></i>Send</button>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="draft-box col-md-12 col-lg-12" style="display: none;">
                                                    <div class="row">
                                                        <div class="mail-list-container inbox_mail_listcontainer col-lg-12 col-md-12 pt-4 pb-4 border-right bg-white mob-paddingrt_left0">
                                                            <div class="border-bottom mb-3 px-3 drft-serch">
                                                                <div class="row">
                                                                    <div class="col-sm-8">
                                                                        <h3>Draft
                                                                        </h3>
                                                                    </div>

                                                                    <div class="col-sm-4">
                                                                        <div class="form-group">
                                                                            <div class="searchbox">
                                                                                <input class="form-control inpsearch_inbox w-100" type="search" placeholder="Search mail" id="Mail-rearch" />
                                                                                <i class="mdi mdi-magnify"></i>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="inbox_mail_list inboxscroll">
                                                                <div class="mail-list tab_mailbox">

                                                                    <div class="form-check check_inptblock">
                                                                        <div class="checkbox">
                                                                            <label>
                                                                                <input type="checkbox" id="Checkbox15" /><span class="cr"><i class="cr-icon mdi mdi-check"></i></span></label>
                                                                        </div>
                                                                    </div>
                                                                    <div class="details star-draft">
                                                                        <i class="mdi mdi-star-outline"></i>
                                                                    </div>
                                                                    <div class="content">
                                                                        <p class="sender-name">David Moore</p>
                                                                        <p class="message_text">Hi Emily, Please be informed that the new project presentation is due Monday.</p>
                                                                    </div>
                                                                    <div class="draft-date tab_dt_Drft">
                                                                        <p>02-11-2018</p>
                                                                    </div>
                                                                </div>
                                                                <div class="mail-list tab_mailbox">
                                                                    <div class="form-check check_inptblock">
                                                                        <div class="checkbox">
                                                                            <label>
                                                                                <input type="checkbox" id="Checkbox16" /><span class="cr"><i class="cr-icon mdi mdi-check"></i></span></label>
                                                                        </div>
                                                                    </div>
                                                                    <div class="details star-draft">
                                                                        <i class="mdi mdi-star-outline"></i>
                                                                    </div>
                                                                    <div class="content">
                                                                        <p class="sender-name">Microsoft Account Password Change</p>
                                                                        <p class="message_text">Change the password for your Microsoft Account using the security code 35525</p>
                                                                    </div>
                                                                    <div class="draft-date tab_dt_Drft">
                                                                        <p>24-10-2018</p>
                                                                    </div>
                                                                </div>
                                                                <div class="mail-list tab_mailbox">
                                                                    <div class="form-check check_inptblock">
                                                                        <div class="checkbox">
                                                                            <label>
                                                                                <input type="checkbox" id="Checkbox17" /><span class="cr"><i class="cr-icon mdi mdi-check"></i></span></label>
                                                                        </div>
                                                                    </div>
                                                                    <div class="details star-draft">
                                                                        <i class="mdi mdi-star favorite"></i>
                                                                    </div>
                                                                    <div class="content">
                                                                        <p class="sender-name">Sophia Lara</p>
                                                                        <p class="message_text">Hello, last date for registering for the annual music event is closing in</p>
                                                                    </div>
                                                                    <div class="draft-date tab_dt_Drft">
                                                                        <p>13-10-2018</p>
                                                                    </div>
                                                                </div>
                                                                <div class="mail-list tab_mailbox">
                                                                    <div class="form-check check_inptblock">
                                                                        <div class="checkbox">
                                                                            <label>
                                                                                <input type="checkbox" id="Checkbox18" /><span class="cr"><i class="cr-icon mdi mdi-check"></i></span></label>
                                                                        </div>
                                                                    </div>
                                                                    <div class="details star-draft">
                                                                        <i class="mdi mdi-star favorite"></i>
                                                                    </div>
                                                                    <div class="content">
                                                                        <p class="sender-name">Stella Davidson</p>
                                                                        <p class="message_text">Hey there, can you send me this year’s holiday calendar?</p>
                                                                    </div>
                                                                    <div class="draft-date tab_dt_Drft">
                                                                        <p>05-10-2018</p>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                                <%--     <div class="compose-box" style="display: none">
                                                <div class="compose_mailcontainer col-lg-12 col-md-12 pt-4 pb-4 mob-padding0">
                                                    <div class="content_block">
                                                        <div class="com-block compose_header">
                                                            <div class="row">
                                                                <div class="col-sm-12">
                                                                    <h2 class="h2_header send_campaign">Compose Mail</h2>
                                                                    <div class="btn-group snt-mail pull-right" style="display: none;">
                                                                        <button type="button" class="btn btn-dark btn-sm mdi mdi-keyboard-backspace"></button>
                                                                        <button type="button" class="btn btn-dark btn-sm"><a href="Javascript:;"></a>Back</button>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="com-block grid-body">
                                                            <div class="com-block">
                                                                <div class="com-block compose-inside">
                                                                    <div class="com-block form-group">
                                                                        <div class="com-block mail-input-block">
                                                                            <div class="input_row">
                                                                                <div class="mail_receipent">
                                                                                    <span>To :</span>
                                                                                </div>
                                                                                <div class="com-block">
                                                                                    <input type="text" id="Text1" class="input-mail" placeholder="Add Recipients" />
                                                                                </div>
                                                                                <div class="mail_rec" style="display: none">
                                                                                    <span><a href="javascript:;" class="cc" data-toggle="tooltip" data-placement="top" title="" data-original-title="Add Cc Recipients">Cc</a></span> <span><a href="javascript:;" class="bcc" data-toggle="tooltip" data-placement="top" title="" data-original-title="Add Bcc Recipients">Bcc</a></span>
                                                                                </div>
                                                                            </div>
                                                                            <div class="input_row row1" id="CM_Cc_Row">
                                                                                <div class="mail_receipent">
                                                                                    <span>Cc :</span>
                                                                                </div>
                                                                                <div class="com-block bdr-btm">
                                                                                    <input type="text" id="cc-input-tags" class="input-mail" placeholder="Add Recipients" />
                                                                                </div>
                                                                            </div>
                                                                            <div class="input_row row2" id="CM_Bcc_Row">
                                                                                <div class="mail_receipent">
                                                                                    <span>Bcc :</span>
                                                                                </div>
                                                                                <div class="com-block bdr-btm">
                                                                                    <input type="text" id="bcc-input-tags" class="input-mail" placeholder="Add Recipients" />
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>

                                                                    <div class="com-block form-group">
                                                                        <div class="input_row">
                                                                            <div class="mail_receipent">
                                                                                <span>Subject :</span>
                                                                            </div>
                                                                            <input type="text" class="input-mail subject-input" maxlength="150" id="Text2" placeholder="Add subject here" />
                                                                        </div>
                                                                    </div>

                                                                    <div class="com-block form-group">
                                                                        <div id="txtEditor"></div>
                                                                    </div>

                                                                    <div class="com-block form-group" style="display: none">
                                                                        <div class="btn-group btn-group-sm" role="group" aria-label="Basic example">
                                                                            <button type="button" class="btn btn-secondary mobpd4"><i class="mdi mdi-paperclip"></i></button>
                                                                            <button type="button" class="btn btn-secondary mobpd4">Attachment</button>
                                                                        </div>
                                                                        <div class="btn-group btn-group-sm" role="group" aria-label="Basic example">
                                                                            <button type="button" class="btn btn-secondary mobpd4"><i class="mdi mdi-folder-open"></i></button>
                                                                            <button type="button" class="btn btn-secondary mobpd4">Existing Document</button>
                                                                        </div>
                                                                    </div>

                                                                    <div class="com-block form-group" style="display: none">
                                                                        <div class="sender-block">
                                                                            <div class="row">
                                                                                <div class="col-sm-6 col-xs-12">
                                                                                    <div class="row form-group">
                                                                                        <div class="col-md-4 col-sm-5 col-xs-4 col-ss-12">
                                                                                            <h4 class="form-text-title text-right title-mail_left">Sender Name :</h4>
                                                                                        </div>
                                                                                        <div class="col-md-8 col-sm-7 col-xs-6 col-ss-12">
                                                                                            <input type="text" class="form-control input-txtbox" placeholder="Enter Sender Name" maxlength="50" />
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                                <div class="col-sm-6 col-xs-12">
                                                                                    <div class="row form-group">
                                                                                        <div class="col-md-4 col-sm-5 col-xs-4 col-ss-12">
                                                                                            <h4 class="form-text-title text-right title-mail_left">Sender Email :</h4>
                                                                                        </div>
                                                                                        <div class="col-md-8 col-sm-7 col-xs-6 col-ss-12">
                                                                                            <input type="text" class="form-control input-txtbox" placeholder="Enter Sender Email" maxlength="50" />
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                                <div class="col-sm-6 col-xs-12">
                                                                                    <div class="row form-group">
                                                                                        <div class="col-md-4 col-sm-5 col-xs-4 col-ss-12">
                                                                                            <h4 class="form-text-title text-right title-mail_left">Reply Email :</h4>
                                                                                        </div>
                                                                                        <div class="col-md-8 col-sm-7 col-xs-6 col-ss-12">
                                                                                            <input type="text" class="form-control input-txtbox" placeholder="Enter Reply Email" maxlength="50" />
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="com-block form-group text-center">
                                                                        <div class="btn-group snt-mail">
                                                                            <button type="button" class="btn btn-success btn-sm mdi mdi-send mobpd4"></button>
                                                                            <button type="button" class="btn btn-success btn-sm mobpd4">Send</button>
                                                                        </div>

                                                                        <div class="btn-group snt-mail" style="display: none">
                                                                            <button type="button" class="btn btn-info btn-sm mdi mdi-undo-variant mobpd4"></button>
                                                                            <button type="button" class="btn btn-info btn-sm mobpd4">Discard</button>
                                                                        </div>

                                                                        <div class="btn-group btn-trash-mail" style="display: none">
                                                                            <button type="button" class="btn btn-danger btn-sm mdi mdi-file-outline mobpd4"></button>
                                                                            <button type="button" class="btn btn-danger btn-sm mobpd4">Draft</button>
                                                                        </div>

                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>--%>
                                            </div>
                                            <div class="compose-box" style="display: none;" id="compose">
                                                <div class="compose_mailcontainer col-lg-12 col-md-12 pt-4 pb-4 mob-padding0">
                                                    <div class="content_block">
                                                        <div class="com-block compose_header">
                                                            <div class="row">
                                                                <div class="col-sm-12">
                                                                    <h2 class="h2_header send_campaign">Compose Mail</h2>
                                                                    <div class="btn-group snt-mail pull-right" style="display: none;">
                                                                        <button type="button" class="btn btn-dark btn-sm mdi mdi-keyboard-backspace"></button>
                                                                        <button type="button" class="btn btn-dark btn-sm"><a href="Javascript:;"></a>Back</button>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="com-block grid-body">
                                                            <div class="com-block">
                                                                <div class="com-block compose-inside">
                                                                    <div class="com-block form-group">
                                                                        <div class="com-block mail-input-block">
                                                                            <div class="input_row">
                                                                                <div class="mail_receipent">
                                                                                    <span>To :</span>
                                                                                </div>
                                                                                <div class="com-block">
                                                                                    <input type="text" id="toemail" class="input-mail" placeholder="Add Recipients" />
                                                                                    <div class="mail_rec">
                                                                                        <span><a href="javascript:;" class="cc" data-toggle="tooltip" data-placement="top" title="" data-original-title="Add Cc Recipients">Cc</a></span> <span><a href="javascript:;" class="bcc" data-toggle="tooltip" data-placement="top" title="" data-original-title="Add Bcc Recipients">Bcc</a></span>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                            <div class="input_row row1" id="CM_Cc_Row">
                                                                                <div class="mail_receipent">
                                                                                    <span>Cc :</span>
                                                                                </div>
                                                                                <div class="com-block">
                                                                                    <input type="text" id="cc-input-tags" class="input-mail" placeholder="Add Recipients" />
                                                                                </div>
                                                                            </div>
                                                                            <div class="input_row row2" id="CM_Bcc_Row">
                                                                                <div class="mail_receipent">
                                                                                    <span>Bcc :</span>
                                                                                </div>
                                                                                <div class="com-block">
                                                                                    <input type="text" id="bcc-input-tags" class="input-mail" placeholder="Add Recipients" />
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>

                                                                    <div class="com-block form-group">
                                                                        <div class="input_row">
                                                                            <div class="mail_receipent">
                                                                                <span>Subject :</span>
                                                                            </div>
                                                                            <input type="text" class="input-mail subject-input" maxlength="150" placeholder="Add subject here" id="subject" />
                                                                        </div>
                                                                    </div>

                                                                    <div class="com-block form-group">
                                                                        <div id="draftmail"></div>
                                                                    </div>
                                                                    <div class="progress upload-br" id="prodiv" style="display: none">
                                                                        <div class="progress-bar bg-danger" id="progress" role="progressbar" style="width: 0%;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div>
                                                                    </div>
                                                                    <div class="file-attachted" id="attach">
                                                                    </div>
                                                                    <div class="com-block form-group">


                                                                        <%--<a href="javascript:;" class="btn btn-secondary att"><span class="mdi mdi-attachment"></span></a>
                                                                        <input type="file" class="select-file" multiple="" id="File1" />--%>

                                                                        <div class="btn-group btn-group-sm div_left" role="group" aria-label="Basic example">
                                                                            <span class="btn btn-secondary mobpd4">
                                                                                <input type="file" class="select-file" multiple="" id="File1" /><i class="mdi mdi-paperclip"></i>Attachment</span>
                                                                            <%--<button type="button" class="btn btn-secondary mobpd4"></button>--%>
                                                                        </div>
                                                                        <%-- <div class="btn-group btn-group-sm" role="group" aria-label="Basic example">
                                                                            <button type="button" class="btn btn-secondary mobpd4"><i class="mdi mdi-folder-open"></i></button>
                                                                            <button type="button" class="btn btn-secondary mobpd4">Existing Document</button>
                                                                        </div>--%>
                                                                    </div>

                                                                    <div class="com-block form-group" style="display: none">
                                                                        <div class="sender-block">
                                                                            <div class="row">
                                                                                <div class="col-sm-6 col-xs-12">
                                                                                    <div class="row form-group">
                                                                                        <div class="col-md-4 col-sm-5 col-xs-4 col-ss-12">
                                                                                            <h4 class="form-text-title text-right title-mail_left">Sender Name :</h4>
                                                                                        </div>
                                                                                        <div class="col-md-8 col-sm-7 col-xs-6 col-ss-12">
                                                                                            <input type="text" class="form-control input-txtbox" placeholder="Enter Sender Name" maxlength="50" />
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                                <div class="col-sm-6 col-xs-12">
                                                                                    <div class="row form-group">
                                                                                        <div class="col-md-4 col-sm-5 col-xs-4 col-ss-12">
                                                                                            <h4 class="form-text-title text-right title-mail_left">Sender Email :</h4>
                                                                                        </div>
                                                                                        <div class="col-md-8 col-sm-7 col-xs-6 col-ss-12">
                                                                                            <input type="text" class="form-control input-txtbox" placeholder="Enter Sender Email" maxlength="50" />
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                                <div class="col-sm-6 col-xs-12">
                                                                                    <div class="row form-group">
                                                                                        <div class="col-md-4 col-sm-5 col-xs-4 col-ss-12">
                                                                                            <h4 class="form-text-title text-right title-mail_left">Reply Email :</h4>
                                                                                        </div>
                                                                                        <div class="col-md-8 col-sm-7 col-xs-6 col-ss-12">
                                                                                            <input type="text" class="form-control input-txtbox" placeholder="Enter Reply Email" maxlength="50" />
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="com-block form-group text-center">
                                                                        <div class="text-center btn-compos_subbox">
                                                                            <div class="btn-group snt-mail div_left">
                                                                                <button type="button" class="btn btn-success btn-sm mobpd4 div_left" id="send"><i class="mdi mdi-send"></i>Send</button>
                                                                            </div>
                                                                            <div class="btn-group btn-trash-mail div_left" onclick="draft()">
                                                                                <button type="button" class="btn btn-dark btn-sm mobpd4 div_left"><i class="mdi mdi-file-outline"></i>Draft</button>
                                                                            </div>
                                                                            <div class="btn-group snt-mail div_left" onclick="openinbox()">
                                                                                <button type="button" class="btn btn-info btn-sm mobpd4 div_left"><i class="mdi mdi-undo-variant"></i>Discard</button>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <%--end--%>
                                            <%--message show--%>
                                            <div class="mail-view  col-md-12 col-lg-12 bg-white pd_left-right10" style="display: none;">
                                                <div class="row">
                                                    <div class="col-md-12 mb-4 mt-4 tab_tp_btm10">
                                                        <div class="btn-toolbar">
                                                            <div class="btn-group tab-mrgnbtm5">
                                                                <button type="button" class="btn btn-sm btn-outline-secondary"><i class="mdi mdi-reply text-primary"></i>Reply</button>
                                                                <button type="button" class="btn btn-sm btn-outline-secondary"><i class="mdi mdi-reply-all text-primary"></i>Reply All</button>
                                                                <button type="button" class="btn btn-sm btn-outline-secondary"><i class="mdi mdi-share text-primary"></i>Forward</button>
                                                            </div>
                                                            <div class="btn-group">
                                                                <button type="button" class="btn btn-sm btn-outline-secondary"><i class="mdi mdi-attachment text-primary"></i>Attach</button>
                                                                <button type="button" class="btn btn-sm btn-outline-secondary"><i class="mdi mdi-delete text-primary"></i>Delete</button>
                                                            </div>
                                                            <div class="inf_inbx">
                                                                <i class="mdi mdi-label"></i>
                                                                <span>Inbox
                                                                </span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="message-body">
                                                    <div class="msg_continr">
                                                        <div class="sender-details">
                                                            <img class="img-sm rounded-circle mr-3" alt="" src="images/userprofile.png" />
                                                            <%--<img  src="https://placehold.it/100x100" >--%>
                                                            <div class="details">
                                                                <p class="msg-subject fw600">
                                                                    Weekly Update - Week 19 (May 8, 2017 - May 14, 2017)
                                                                </p>
                                                                <p class="sender-email fw600">
                                                                    Sarah Graves
                        <a href="#">itsmesarah268@gmail.com</a>
                                                                    &nbsp;<i class="mdi mdi-account-multiple-plus"></i>
                                                                </p>
                                                            </div>
                                                        </div>
                                                        <div class="message-content">
                                                            <p>Hi Emily,</p>
                                                            <p>This week has been a great week and the team is right on schedule with the set deadline. The team has made great progress and achievements this week. At the current rate we will be able to deliver the product right on time and meet the quality that is expected of us. Attached are the seminar report held this week by our team and the final product design that needs your approval at the earliest.</p>
                                                            <p>For the coming week the highest priority is given to the development for <a href="http://www.bootstrapdash.com/" target="_blank">http://www.bootstrapdash.com/</a> once the design is approved and necessary improvements are made.</p>
                                                            <p>
                                                                <br>
                                                                <br>
                                                                Regards,<br>
                                                                Sarah Graves
                                                            </p>
                                                        </div>
                                                        <div class="attachments-sections">
                                                            <ul>
                                                                <li>
                                                                    <div class="thumb"><i class="mdi mdi-file-pdf"></i></div>
                                                                    <div class="details">
                                                                        <p class="file-name">Seminar Reports.pdf</p>
                                                                        <div class="buttons">
                                                                            <p class="file-size">678Kb</p>
                                                                            <a href="#" class="view">View</a>
                                                                            <a href="#" class="download">Download</a>
                                                                        </div>
                                                                    </div>
                                                                </li>
                                                                <li>
                                                                    <div class="thumb"><i class="mdi mdi-file-image"></i></div>
                                                                    <div class="details">
                                                                        <p class="file-name">Product Design.jpg</p>
                                                                        <div class="buttons">
                                                                            <p class="file-size">1.96Mb</p>
                                                                            <a href="#" class="view">View</a>
                                                                            <a href="#" class="download">Download</a>
                                                                        </div>
                                                                    </div>
                                                                </li>
                                                            </ul>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <%--end--%>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="mobilebg"></div>
        <div class="modal fade" id="SigInModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-md">
                <div class="modal-content bg_white">

                    <!-- Modal Header -->
                    <div class="modal-header configure-mail-header">
                        <h4 class="modal-title">Configure Email</h4>
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </div>

                    <!-- Modal body -->

                    <div class="modal-body mail-configure-body">

                        <div class="form-group modal_wd100block">
                            <div class="row">
                                <div class="col-sm-4 div_left">
                                    <p class="configure-title" data-toggle="tooltip" data-placement="top" title="Specify Protocol">Access With : </p>
                                </div>
                                <div class="col-sm-6 div_left">
                                    <div class="input-group">
                                        <select class="form-control custom-select selectoptn_confg" id="access" runat="server">
                                            <option value="select">Select</option>
                                            <option value="pop">POP</option>
                                            <option value="imap">IMAP</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <%--  <div class="form-group">
                            <div class="row">
                                <div class="col-sm-4">
                                    <p class="configure-title" data-toggle="tooltip" data-placement="top" title="Outgoing Email Port">Host : </p>
                                </div>
                                <div class="col-sm-6">
                                    <div class="input-group">
                                        <select class="form-control custom-select" id="host" runat="server">
                                            <option value="select">Select</option>
                                            <option value="pop.gmail.com{^*^}995" data-id="Gmail">Gmail-POP</option>
                                            <option value="imap.gmail.com{^*^}993" data-id="Gmail">Gmail-IMAP</option>
                                            <option value="pop3.live.com{^*^}995" data-id="Hotmail">Hotmail-POP</option>
                                            <option value="imap-mail.outlook.com{^*^}993" data-id="Hotmail">Hotmail-IMAP</option>
                                            <option value="pop.mail.yahoo.com{^*^}995" data-id="Yahoo">Yahoo-POP</option>
                                            <option value="imap.mail.yahoo.com{^*^}993" data-id="Yahoo">Yahoo-IMAP</option>
                                            <option value="otr">Other</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                        </div>--%>
                        <div class="form-group modal_wd100block">
                            <div class="row">
                                <div class="col-sm-4 div_left">
                                    <p class="configure-title" data-toggle="tooltip" data-placement="top" title="Outgoing Email Server">SMTP Host : </p>
                                </div>
                                <div class="col-sm-6 div_left">
                                    <input type="text" class="form-control" placeholder="SMTP Host Name" id="smtphost" runat="server" />
                                </div>
                            </div>
                        </div>
                        <div class="form-group modal_wd100block">
                            <div class="row">
                                <div class="col-sm-4 div_left">
                                    <p class="configure-title">SMTP Port : </p>
                                </div>
                                <div class="col-sm-6 div_left">
                                    <input type="text" class="form-control" placeholder="SMTP Host Name" id="smtpport" runat="server" />
                                </div>
                            </div>
                        </div>
                        <div class="hide_box">
                            <div class="form-group modal_wd100block">
                                <div class="row">
                                    <div class="col-sm-4 div_left">
                                        <p class="configure-title" data-toggle="tooltip" data-placement="top" title="Incoming Email Server">Incoming Host : </p>
                                    </div>
                                    <div class="col-sm-6 div_left">
                                        <input type="text" class="form-control" placeholder="Host" id="othost" runat="server" />
                                    </div>
                                </div>
                            </div>
                            <div class="form-group modal_wd100block">
                                <div class="row">
                                    <div class="col-sm-4 div_left">
                                        <p class="configure-title" data-toggle="tooltip" data-placement="top" title="Incoming Email Port">Incoming Port : </p>
                                    </div>
                                    <div class="col-sm-6 div_left">
                                        <input type="text" class="form-control" placeholder="Port" id="otport" runat="server" />
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="form-group modal_wd100block">
                            <div class="row">
                                <div class="col-sm-4 div_left">
                                    <p class="configure-title">Email Id : </p>
                                </div>
                                <div class="col-sm-6 div_left">
                                    <input type="text" class="form-control" placeholder="Username" id="username" runat="server" />
                                </div>
                            </div>
                        </div>
                        <div class="form-group modal_wd100block">
                            <div class="row">
                                <div class="col-sm-4 div_left">
                                    <p class="configure-title">Password : </p>
                                </div>
                                <div class="col-sm-6 div_left">
                                    <input type="password" class="form-control" placeholder="Password" id="password" runat="server" />
                                </div>
                            </div>
                        </div>
                        <div class="form-group modal_wd100block">
                            <div class="row">
                                <div class="col-sm-4 div_left">
                                    <p class="configure-title">Include Signature : </p>
                                </div>
                                <div class="col-sm-6 div_left">
                                    <div class="checkbox checkbox-prop chckmodl signt_sliddown">
                                        <label>
                                            <input type="checkbox" class="includesig" value="">
                                            <span class="cr"><i class="cr-icon mdi mdi-check"></i></span>
                                        </label>
                                    </div>
                                </div>
                            </div>

                        </div>
                        <div class="form-group modal_wd100block" id="signaturedtrbox">
                            <div class="row">
                                <div class="sig_box">
                                    <textarea class="signatureeditor" id="signatureditor"></textarea>
                                </div>
                                <button type="button" class="btn btn-dark btn-uploadimg">
                                    <i class="mdi mdi-folder-image"></i>
                                    <input type="file" id="sigpic" />
                                    <span>Upload Image</span>
                                </button>
                                <div class="send_confgoptn">
                                    <div class="checkbox checkbox-prop chckmodl">
                                        <label>
                                            <input type="checkbox" name="sigtype" class="rply" value="reply">
                                            <span class="cr"><i class="cr-icon mdi mdi-check"></i></span>
                                        </label>
                                        Reply
                                    </div>
                                    <div class="checkbox checkbox-prop chckmodl">
                                        <label>
                                            <input type="checkbox" name="sigtype" class="rplyall" value="replyall">
                                            <span class="cr"><i class="cr-icon mdi mdi-check"></i></span>
                                        </label>
                                        Reply All
                                    </div>
                                    <div class="checkbox checkbox-prop chckmodl">
                                        <label>
                                            <input type="checkbox" name="sigtype" class="frward" value="forward">
                                            <span class="cr"><i class="cr-icon mdi mdi-check"></i></span>
                                        </label>
                                        Forward
                                    </div>
                                    <div class="checkbox checkbox-prop chckmodl">
                                        <label>
                                            <input type="checkbox" name="sigtype" class="comp" value="compose">
                                            <span class="cr"><i class="cr-icon mdi mdi-check"></i></span>
                                        </label>
                                        Compose
                                    </div>
                                </div>
                            </div>

                        </div>

                    </div>
                    <!-- Modal footer -->
                    <div class="modal-footer mail-configure-footer">
                        <button type="button" class="btn btn-success btn-sm" id="SubBtn">Save</button>
                        <button type="button" class="btn btn-dark btn-sm" id="resetbtn">Reset</button>
                        <button type="button" class="btn btn-danger btn-sm" data-dismiss="modal">Close</button>
                    </div>

                </div>
            </div>
        </div>
        <div class="modal fade paddingleft02" id="GLOBAL_PreviewMe" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog modal-lg modal-document" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title modal-h2" id="H2"><i class="mdi mdi-file-document i-tag"></i>Document Preview</h4>
                    <button type="button" class="close cls_btn modal_close" data-dismiss="modal" aria-label="Close" onclick="ResetProductMoreInfoLightbox()">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    
                </div>
                <div class="modal-body padding20">
                    <table class="table table-responsive table-bordered table-striped table_job grid-respons table-document" id="GLOBAL_TitleTable">
                        <tbody>
                        </tbody>
                    </table>
                    <div class="defaultscroll doc-imgbody" id="GLOBAL_Preview_Container">
                        <div class="ext-link"><a href="#" class="embed"></a></div>
                    </div>
                </div>
                <div class="modal-footer modal_footer">
                    <button type="button" class="btn btn-default br2" data-dismiss="modal" onclick="ResetProductMoreInfoLightbox()">
                        Close
                    </button>
                </div>
            </div>
        </div>
    </div>
            <uc1:UC_MessagePopup runat="server" ID="UC_MessagePopup" />

        <input type="hidden" id="serverhost" runat="server" />
        <input type="hidden" id="accesswithserver" runat="server" />
        <input type="hidden" id="serverport" runat="server" />
        <input type="hidden" id="signa" runat="server" />
        <input type="hidden" id="isreply" runat="server" />
        <input type="hidden" id="isreplyall" runat="server" />
        <input type="hidden" id="iscompose" runat="server" />
        <input type="hidden" id="isforward" runat="server" />
        <script type="text/javascript">
            var Global_ContainerEmailCollection = [];
            function preview_doc(filename) {

                var ext = filename.substring(filename.lastIndexOf(".") + 1, filename.length).toLowerCase();
                var validFiles = ["tiff", "pdf", "ppt", "pptx", "jpg", "jpeg", "doc", "docx", "txt", "png", "xls", "xlsx"];
                for (var i = 0; i < validFiles.length; i++) {
                    if (validFiles[i] == ext) {
                        break;
                    }
                }
                if (i >= validFiles.length) {
                    Message({ 'Msg': "Preview available for following file extensions:" + validFiles.join(", ") + " Type", 'Type': '5' });

                    return false;
                }
                $("#GLOBAL_DocTitle").html(filename);


                var hostname = window.location.hostname; // Returns hostname only -- localhost

                if (ext == "jpeg" || ext == "jpg" || ext == "png") {
                    var Wholepath = "http://emailproject.kreyonsystems.com/EmailAttacements/" + filename;
                    $("#GLOBAL_Preview_Container").html('<div class="ext-link"><img src="' + Wholepath + '"/></div>');
                }
                else {
                    var Wholepath = "http://emailproject.kreyonsystems.com/EmailAttacements/" + filename;
                    $("#GLOBAL_Preview_Container").html('<div class="ext-link"><a href="' + Wholepath + '" class="embed"></a></div>');
                    $('a.embed').gdocsViewer();
                }
                $("#GLOBAL_PreviewMe").modal("show")
               

            }
            var temp = 0;
            var array = [];
            var array2 = [];
            var picname = "";
            function Timezone() {
                var SystemTimeZone = 0;
                try {
                    var SystemDate = new Date();
                    SystemTimeZone = ((-1) * SystemDate.getTimezoneOffset());
                } catch (e) {

                }
                return SystemTimeZone;
            }
            $(document).ready(function () {


                var srh = "";
                $("#SearchMailBtn").click(function () {
                    InboxMail(1);
                });
                $("#txtSearchmail").keyup(function (e) {
                    if (e.keyCode == 13) {
                        InboxMail(1);
                    }
                });
                $("#SearchSentBtn").click(function () {
                    opensendbox(1);
                });
                $("#txtSearchSentBox").keyup(function (e) {
                    if (e.keyCode == 13) {
                        opensendbox(1);
                    }
                });
                $("#btnSearchOut").click(function () {
                    openoutbox(1);
                });
                $("#txtSearchOut").keyup(function (e) {
                    if (e.keyCode == 13) {
                        openoutbox(1);
                    }
                });
                $("#btnSearchDraft").click(function () {
                    showdraft(1);
                });
                $("#txtSearchDraft").keyup(function (e) {
                    if (e.keyCode == 13) {
                        showdraft(1);
                    }
                });
                $("#btnSearchTrash").click(function () {
                    opentrash(1);
                });
                $("#txtSearchTrash").keyup(function (e) {
                    if (e.keyCode == 13) {
                        opentrash(1);
                    }
                });
                $("#btnSearchDivstar").click(function () {
                    staroutbox(1);
                });
                $("#txtSearchDivstar").keyup(function (e) {
                    if (e.keyCode == 13) {
                        staroutbox(1);
                    }
                });
                InboxMail(1);



                var serverhost = $("#serverhost").val();
                var accesswithserver = $("#accesswithserver").val();
                var serverport = $("#serverport").val();

                if (accesswithserver == "pop") {
                    $("#access").val("pop");
                }
                else if (accesswithserver == "imap") {
                    $("#access").val("imap");
                }

                //if (serverhost == "pop.gmail.com") {
                //    $('.hide_box').hide();
                //    $("#host").val("pop.gmail.com{^*^}995");
                //}
                //else if (serverhost == "imap.gmail.com") {
                //    $('.hide_box').hide();
                //    $("#host").val("imap.gmail.com{^*^}993");
                //}
                //else if (serverhost == "pop3.live.com") {
                //    $('.hide_box').hide();
                //    $("#host").val("pop3.live.com{^*^}995");
                //}
                //else if (serverhost == "imap-mail.outlook.com") {
                //    $('.hide_box').hide();
                //    $("#host").val("imap-mail.outlook.com{^*^}993");
                //}
                //else if (serverhost == "pop.mail.yahoo.com") {
                //    $('.hide_box').hide();
                //    $("#host").val("pop.mail.yahoo.com{^*^}995");
                //}
                //else if (serverhost == "imap.mail.yahoo.com") {
                //    $('.hide_box').hide();
                //    $("#host").val("imap.mail.yahoo.com{^*^}993");
                //}
                //else if (serverhost == "") {
                //    $('.hide_box').hide();
                //    $("#host").val("select");
                //}
                // else {
                $('.hide_box').show();
                $("#othost").val(serverhost);
                $("#otport").val(serverport);
                $("#host").val("otr");
                // }



                $("#SubBtn").click(function () {


                    var access = $("#access").val();
                    var host = $("#host").val();
                    var Username = $("#username").val();
                    var Password1 = $("#password").val();
                    var smtphost1 = $("#smtphost").val();
                    var smtpport1 = $("#smtpport").val();
                    var ddltype = "";
                    var siganature = $("#signatureditor").parent().find(".Editor-editor").html();
                    var rly = "";
                    var rlyall = "";
                    var forwrd = "";
                    var comp = "";

                    if ($("input[class='rply']").prop("checked") == true) {

                        rly = "true";

                    }
                    else {
                        rly = "false";
                    }
                    if ($("input[class='rplyall']").prop("checked") == true) {

                        rlyall = "true";

                    }
                    else {
                        rlyall = "false";
                    }
                    if ($("input[class='frward']").prop("checked") == true) {

                        forwrd = "true";

                    }
                    else {
                        forwrd = "false";
                    }
                    if ($("input[class='comp']").prop("checked") == true) {

                        comp = "true";

                    }
                    else {
                        comp = "false";
                    }


                    var depass = Password1.replace("&", "[{amp}]");
                    depass = Password1.replace("#", "[{hash}]");


                    var isvalidate = true;


                    if ($('#othost').val() == "") {

                        document.getElementById("othost").style.borderColor = "red";
                        isvalidate = false;
                    }
                    else {
                        document.getElementById("othost").style.borderColor = "#dadada";
                    }


                    if ($('#otport').val() == "") {

                        document.getElementById("otport").style.borderColor = "red";
                        isvalidate = false;
                    }
                    else {
                        document.getElementById("otport").style.borderColor = "#dadada";
                    }


                    ddltype = $('#othost').val() + "{^*^}" + $('#otport').val()





                    if (access == "select") {
                        document.getElementById("access").style.borderColor = "red";

                        isvalidate = false;
                    } else {
                        document.getElementById("access").style.borderColor = "#dadada";
                    }

                    if (smtphost1 == "") {
                        document.getElementById("smtphost").style.borderColor = "red";
                        isvalidate = false;
                    } else {
                        document.getElementById("smtphost").style.borderColor = "#dadada";
                    }

                    if (smtpport1 == "") {
                        document.getElementById("smtpport").style.borderColor = "red";
                        isvalidate = false;
                    } else {
                        document.getElementById("smtpport").style.borderColor = "#dadada";
                    }


                    if (Username == "") {
                        document.getElementById("username").style.borderColor = "red";
                        isvalidate = false;
                    } else {
                        document.getElementById("username").style.borderColor = "#dadada";
                    }

                    if (depass == "") {
                        document.getElementById("password").style.borderColor = "red";
                        isvalidate = false;
                    } else {
                        document.getElementById("password").style.borderColor = "#dadada";
                    }


                    if ($("input[class=includesig]").prop("checked") == true) {

                        if (siganature == "") {
                            Message({ 'Msg': 'Enter Some Signature text Or image', 'Type': msg_Error });
                            isvalidate = false;
                        }
                        else {



                        }

                        //var sarray=[];

                        //$("input[name=sigtype]").prop("ckecked").each(function () {


                        //    var val = $(this).val();

                        //    sarray.push(val);
                        //});

                        if ($("input[name=sigtype]:checked").length == 0) {
                            Message({ 'Msg': 'Select atleast one option', 'Type': msg_Error });
                            isvalidate = false;
                        }

                    }


                    if (!isvalidate) {
                        return false;
                    }



                    PageMethods.EmailConfigSave(access, ddltype, Username, depass, smtphost1, smtpport1, siganature, rly, rlyall, forwrd, comp, function (response) {

                        if (response == "done") {

                            Message({
                                "Msg": "Credentials saved successfully", "Type": msg_Success, "Event1": function () {
                                    window.location.href = "Default.aspx";
                                }
                            });

                        }
                        else {
                            console.log(response);
                            Message({ 'Msg': 'Something went wrong. Please try again later', 'Type': msg_Error });
                        }

                    });


                });

                $('#host').change(function () {
                    var val = $(this).val();
                    if (val == 'Select') {

                    } else {
                        if (val == 'otr') {
                            $('.hide_box').show();
                        } else {
                            $('.hide_box').hide();
                        }

                    }
                });

                $("#send").click(function () {


                    sendmail();


                });

                $("#File1").change(function () {

                    var sizefile = Number(this.files[0].size);
                    temp = temp + sizefile;

                    var threeMb = 3 * 1024 * 1024;
                    var fivemb = 6 * 1024 * 1024;
                    if (sizefile > threeMb) {
                        var cursize = parseFloat(this.files[0].size / 1048576).toFixed(2);
                        Message({
                            "Msg": "Your file size " + cursize + " MB. File size should not exceed 3 MB", "Type": msg_Info
                        });

                        $(this).val('');
                        return false;
                    }
                    if (temp > fivemb) {

                        Message({
                            "Msg": "Yor total file size is greater than 6 MB. File size should not exceed 6MB", "Type": msg_Info
                        });

                        $(this).val('');
                        temp = temp - sizefile;
                        return false;
                    }

                    var validFiles = ["jpg", "jpeg", "png", "doc", "pdf", "docx", "txt", "xlsm", "xltx", "xlsx", "xltm", "xls", "xlt", "ppt", "PDF", "pptx"];

                    var source = $(this).val();
                    var ext = source.substring(source.lastIndexOf(".") + 1, source.length).toLowerCase();
                    for (var i = 0; i < validFiles.length; i++) {
                        if (validFiles[i] == ext) {
                            break;
                        }
                    }
                    if (i >= validFiles.length) {

                        Message({ "Msg": "Only following  file extensions are allowed : " + validFiles.join(","), "Type": msg_Error });

                        $(this).val('');
                        $('#filetxt').val('');
                        return false;
                    }

                    var files = new FormData();
                    var file = document.getElementById("File1").files[0];
                    files.append('files[0]', file);

                    $.ajax({
                        url: 'FileUpload.ashx',
                        type: 'POST',
                        data: files,
                        cache: false,
                        dataType: 'json',
                        processData: false,
                        contentType: false,
                        xhr: function () {
                            //upload Progress
                            var xhr = $.ajaxSettings.xhr();
                            if (xhr.upload) {
                                xhr.upload.addEventListener('progress', function (event) {
                                    var percent = 0;
                                    var position = event.loaded || event.position;
                                    var total = event.total;
                                    if (event.lengthComputable) {
                                        percent = Math.ceil(position / total * 100);
                                    }
                                    //update progressbar
                                    console.log(" .progress-bar", percent + "%");
                                    console.log(" .status", percent + "%");

                                    $(".progress-overall .status").text(percent + "%");
                                    $(".progress-overall .progress-bar").css("width", +percent + "%");
                                    $(".progress-overall .sr-only").text(percent + "%"); // CURRENTLY NOT USING . STILL CHANGING
                                    $("#prodiv").show();
                                    $("#progress").css("width", +percent + "%");
                                    $("#progress").text(percent + "%");
                                    UploadingIsInProgress = true; // ONLY USING FOR CONDITION WHEN WE CLICK SUBMIT BUTTON WHILE ATTACHMENT FILE STILL NOT UPLOAD

                                    //try { $(".btnExistDocument").find("button").attr("disabled", "disabled"); } catch (e) { }

                                }, true);
                            }
                            return xhr;
                        },
                        success: function (data) {
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                        },
                        complete: function (jqXHR, textStatus) {
                            //debugger;

                            //$('#GloblizedfileSelect').removeAttr("disabled");


                            // UploadingIsInProgress = false; // ONLY USING FOR CONDITION WHEN WE CLICK SUBMIT BUTTON WHILE ATTACHMENT FILE STILL NOT UPLOAD

                            //try { $(".btnExistDocument").find("button").removeAttr("disabled"); } catch (e) { }




                            var thumb = jqXHR.responseText;
                            if (thumb != 'un') {


                                var splimage = thumb.split('[|]');

                                if (picname == "") {
                                    picname = splimage[1];

                                }
                                else {
                                    picname = picname + "," + splimage[1];
                                }
                                array.push(splimage[1]);
                                var ext2 = splimage[1].split('.');

                                if (ext2[1] == "doc" || ext2[1] == "docx") {
                                    $("#attach").append('<div class="img-thumbnail img-attachment"><img src="images/word-icon.png" /><span class="file-attachted-name">' + splimage[0] + '</span> <span class="file-attachted-size"></span><div class="doc_downlod_hovr"><i class="mdi mdi-close" onclick=\'delpic(this,"' + splimage[1] + '");\'></i></div></div>');
                                }
                                else if (ext2[1] == "xlsx" || ext2[1] == "xlsm" || ext2[1] == "xltx" || ext2[1] == "xltm" || ext2[1] == "xls" || ext2[1] == "xlt") {
                                    $("#attach").append('<div class="img-thumbnail img-attachment"><img src="images/excel-icon.png" /><span class="file-attachted-name">' + splimage[0] + '</span> <span class="file-attachted-size"></span><div class="doc_downlod_hovr"><i class="mdi mdi-close" onclick=\'delpic(this,"' + splimage[1] + '");\'></i></div></div>');
                                }
                                else if (ext2[1] == "jpg" || ext2[1] == "jpeg" || ext2[1] == "png") {
                                    $("#attach").append('<div class="img-thumbnail img-attachment"><img src="images/img-large-icon.png" /><span class="file-attachted-name">' + splimage[0] + '</span> <span class="file-attachted-size"></span><div class="doc_downlod_hovr"><i class="mdi mdi-close" onclick=\'delpic(this,"' + splimage[1] + '");\'></i></div></div>');
                                }
                                else if (ext2[1] == "pdf" || ext2[1] == "PDF") {
                                    $("#attach").append('<div class="img-thumbnail img-attachment"><img src="images/pdf-large-icon.png" /><span class="file-attachted-name">' + splimage[0] + '</span><span class="file-attachted-size"></span><div class="doc_downlod_hovr"><i class="mdi mdi-close" onclick=\'delpic(this,"' + splimage[1] + '");\'></i></div></div>');
                                }
                                else if (ext2[1] == "txt") {
                                    $("#attach").append('<div class="img-thumbnail img-attachment"><img src="images/text-large-icon.png" /><span class="file-attachted-name">' + splimage[0] + '</span><span class="file-attachted-size"></span><div class="doc_downlod_hovr"><i class="mdi mdi-close" onclick=\'delpic(this,"' + splimage[1] + '");\'></i></div></div>');
                                }
                                else if (ext2[1] == "pptx" || ext2[1] == "ppt") {
                                    $("#attach").append('<div class="img-thumbnail img-attachment"><img src="images/PowerPoint-icon.png" /><span class="file-attachted-name">' + splimage[0] + '</span> <span class="file-attachted-size"></span><div class="doc_downlod_hovr"><i class="mdi mdi-close" onclick=\'delpic(this,"' + splimage[1] + '");\'></i></div></div>');
                                }


                                // $("#picdiv").append('<div class="col-sm-3"><div class="slct-imgbox"><img src="../PropertyImage/' + thumb + '.jpg" /><span onclick="delpic(this,\'' + thumb + '\')" class="mdi mdi-close span-close" aria-hidden="true"></span><div class="checkbox checkbox-prop"><label><input type="checkbox" class="chkall" value="' + thumb + '"><span class="cr"><i class="cr-icon mdi mdi-check"></i></span></label></div></div></div>')
                                $("#prodiv").hide();
                                $('#File1').val('');
                            }
                        }
                    });

                });




                $("#sigpic").change(function () {

                    var sizefile = Number(this.files[0].size);
                    temp = temp + sizefile;

                    var threeMb = 3 * 1024 * 1024;
                    var fivemb = 6 * 1024 * 1024;
                    if (sizefile > threeMb) {
                        var cursize = parseFloat(this.files[0].size / 1048576).toFixed(2);
                        Message({
                            "Msg": "Your file size " + cursize + " MB. File size should not exceed 3 MB", "Type": msg_Info
                        });

                        $(this).val('');
                        return false;
                    }
                    if (temp > fivemb) {

                        Message({
                            "Msg": "Yor total file size is greater than 6 MB. File size should not exceed 6MB", "Type": msg_Info
                        });

                        $(this).val('');
                        temp = temp - sizefile;
                        return false;
                    }

                    var validFiles = ["jpg", "jpeg", "png"];

                    var source = $(this).val();
                    var ext = source.substring(source.lastIndexOf(".") + 1, source.length).toLowerCase();
                    for (var i = 0; i < validFiles.length; i++) {
                        if (validFiles[i] == ext) {
                            break;
                        }
                    }
                    if (i >= validFiles.length) {

                        Message({ "Msg": "Only following  file extensions are allowed : " + validFiles.join(","), "Type": msg_Error });

                        $(this).val('');
                        $('#filetxt').val('');
                        return false;
                    }

                    var files = new FormData();
                    var file = document.getElementById("sigpic").files[0];
                    files.append('files[0]', file);

                    $.ajax({
                        url: 'SignaturePic.ashx',
                        type: 'POST',
                        data: files,
                        cache: false,
                        dataType: 'json',
                        processData: false,
                        contentType: false,
                        xhr: function () {
                            //upload Progress
                            var xhr = $.ajaxSettings.xhr();
                            if (xhr.upload) {
                                xhr.upload.addEventListener('progress', function (event) {
                                    var percent = 0;
                                    var position = event.loaded || event.position;
                                    var total = event.total;
                                    if (event.lengthComputable) {
                                        percent = Math.ceil(position / total * 100);
                                    }
                                    //update progressbar
                                    console.log(" .progress-bar", percent + "%");
                                    console.log(" .status", percent + "%");

                                    //$(".progress-overall .status").text(percent + "%");
                                    //$(".progress-overall .progress-bar").css("width", +percent + "%");
                                    //$(".progress-overall .sr-only").text(percent + "%"); // CURRENTLY NOT USING . STILL CHANGING
                                    //$("#prodiv").show();
                                    //$("#progress").css("width", +percent + "%");
                                    //$("#progress").text(percent + "%");
                                    //UploadingIsInProgress = true; // ONLY USING FOR CONDITION WHEN WE CLICK SUBMIT BUTTON WHILE ATTACHMENT FILE STILL NOT UPLOAD

                                    //try { $(".btnExistDocument").find("button").attr("disabled", "disabled"); } catch (e) { }

                                }, true);
                            }
                            return xhr;
                        },
                        success: function (data) {
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                        },
                        complete: function (jqXHR, textStatus) {


                            //$('#GloblizedfileSelect').removeAttr("disabled");


                            // UploadingIsInProgress = false; // ONLY USING FOR CONDITION WHEN WE CLICK SUBMIT BUTTON WHILE ATTACHMENT FILE STILL NOT UPLOAD

                            //try { $(".btnExistDocument").find("button").removeAttr("disabled"); } catch (e) { }




                            var thumb = jqXHR.responseText;
                            if (thumb != 'un') {


                                $("#signatureditor").parent().find(".Editor-editor").append("<img src='" + thumb + "' />");


                                $('#sigpic').val('');
                            }
                        }
                    });

                });


                // RESET BUTTON
                $("#resetbtn").click(function () {

                    PageMethods.ResetCredentails(function (data) {

                        if (data == "done") {

                            Message({
                                "Msg": "Credentials reset successfully", "Type": msg_Error, "Event1": function () {
                                    window.location.href = "Default.aspx";
                                }
                            });

                        }
                        else {
                            console.log(data);
                            Message({ "Msg": "Can not connect to server this time. Please try again later", "Type": msg_Error });
                        }

                    }, function (error) {
                        Message({ "Msg": "Can not connect to server this time. Please try again later", "Type": msg_Error });
                    });

                });


            });


            function delpic(that, picname2) {

                PageMethods.Deletepic(picname2, function (response) {

                    if (response != "") {



                        var img = picname.split(',')
                        picname = "";
                        for (var i = 0; i < img.length; i++) {
                            if (img[i] != picname2 && img[i] != "") {
                                picname += img[i] + ",";
                            }
                        }
                        $(that).parent().parent().remove();
                    }

                });
            }

            function closedetail() {

                $(".mob_contnrinboxlist").css('margin-left', '0');
                $(".mob_contnr-inbox").css('margin-left', '-100%');
            }

            function ShowHideSearchDiv(Type) {
               
                if (Type == "Inbox") {
                    $("#SearchDivSent").hide();
                    $("#SearchDivoutBox").hide();
                    $("#SearchDivDraft").hide();
                    $("#SearchDivTrash").hide();
                    $("#SearchDivStar").hide();
                    $("#SearchDivInbox").show();

                    $("#BulkDeleteInbox").show();
                    $("#BulkDeleteSent").hide();
                    $("#BulkDeleteDraft").hide();
                    $("#BulkDeleteOutbox").hide();
                    $("#BulkDeleteTrash").hide();
                }
                else if (Type == "OutBox") {
                    $("#SearchDivSent").hide();
                    $("#SearchDivoutBox").show();
                    $("#SearchDivDraft").hide();
                    $("#SearchDivTrash").hide();
                    $("#SearchDivStar").hide();
                    $("#SearchDivInbox").hide();

                    $("#BulkDeleteOutbox").show();
                    $("#BulkDeleteInbox").hide();
                    $("#BulkDeleteSent").hide();
                    $("#BulkDeleteDraft").hide();
                    $("#BulkDeleteTrash").hide();
                }
                else if (Type == "Sent") {
                    $("#SearchDivSent").show();
                    $("#SearchDivoutBox").hide();
                    $("#SearchDivDraft").hide();
                    $("#SearchDivTrash").hide();
                    $("#SearchDivStar").hide();
                    $("#SearchDivInbox").hide();

                    $("#BulkDeleteSent").show();
                    $("#BulkDeleteInbox").hide();
                    $("#BulkDeleteDraft").hide();
                    $("#BulkDeleteOutbox").hide();
                    $("#BulkDeleteTrash").hide();
                }
                else if (Type == "Draft") {
                    $("#SearchDivSent").hide();
                    $("#SearchDivoutBox").hide();
                    $("#SearchDivDraft").show();
                    $("#SearchDivTrash").hide();
                    $("#SearchDivStar").hide();
                    $("#SearchDivInbox").hide();

                    $("#BulkDeleteDraft").show();
                    $("#BulkDeleteInbox").hide();
                    $("#BulkDeleteSent").hide();
                    $("#BulkDeleteOutbox").hide();
                    $("#BulkDeleteTrash").hide();
                }
                else if (Type == "Star") {
                    $("#SearchDivSent").hide();
                    $("#SearchDivoutBox").hide();
                    $("#SearchDivDraft").hide();
                    $("#SearchDivTrash").hide();
                    $("#SearchDivStar").show();
                    $("#SearchDivInbox").hide();

                    $("#BulkDeleteInbox").hide();
                    $("#BulkDeleteSent").hide();
                    $("#BulkDeleteDraft").hide();
                    $("#BulkDeleteOutbox").hide();
                    $("#BulkDeleteTrash").hide();
                }
                else {
                    $("#SearchDivSent").hide();
                    $("#SearchDivoutBox").hide();
                    $("#SearchDivDraft").hide();
                    $("#SearchDivTrash").show();
                    $("#SearchDivStar").hide();
                    $("#SearchDivInbox").hide();

                    $("#BulkDeleteTrash").show();
                    $("#BulkDeleteInbox").hide();
                    $("#BulkDeleteSent").hide();
                    $("#BulkDeleteDraft").hide();
                    $("#BulkDeleteOutbox").hide();
                    
                }
            }
            function sendmail() {

                var toemail = $("#toemail").val();
                var sub = $("#subject").val();
                var body = $(".Editor-editor").html();
                var cc = $("#cc-input-tags").val();
                var bcc = $("#bcc-input-tags").val();

                if (toemail == "" && cc == "" && bcc == "") {
                    Message({ "Msg": "Please specify at least one recipient.", "Type": msg_Info });
                    return false;
                }

                array2 = [];
                $("#loader").show();
                for (var i = 0; i < array.length; i++) {
                    array2.push(array[i]);
                }
                var attach = array2.join(',');
                var SystemTimeZone = Timezone();
                PageMethods.SendMail(toemail, body, sub, cc, bcc, picname, SystemTimeZone, function (response) {
                    var SplitResplonse = response.split("[!]");
                    if (SplitResplonse[0] == "done") {
                        $("#loader").hide();

                        Message({ "Msg": "Mail sent successfully." + ( SplitResplonse[2] !="" ? "Except these invalid Email ID: "+SplitResplonse[2] :""), "Type": msg_Success });
                        $("#compose").hide();
                        $("#inbox").show();
                        picname = "";
                        GetTabsCount('<%=StaticKeywordClass.Sent %>');

                    }
                    else {
                        $("#loader").hide();
                        if (response == "configureerror") {
                            Message({ "Msg": response, "Type": msg_Error });
                            GetTabsCount('<%=StaticKeywordClass.Outbox %>');
                        } else {
                            Message({ "Msg": "Mail did not sent this time. Please try again later", "Type": msg_Error });
                            GetTabsCount('<%=StaticKeywordClass.Outbox %>');
                        }
                    }
                });
            }

            function opencompose() {
               
                array = [];
                picname = "";
                if ($('#slide-menu').hasClass('left-menu-open')) {
                    $('#slide-menu').removeClass('left-menu-open');
                    $('.mobilebg').fadeOut(300);
                }
                $("#compose").show();
                $("#inbox").hide();
                $("#inboxli").removeClass("active");
                $("#trashli").removeClass("active");
                $("#draftli").removeClass("active");
                $("#sendboxli").removeClass("active");
                $("#outboxli").removeClass("active");
                $("#toemail").val("");
                $("#cc-input-tags").val("");
                $("#bcc-input-tags").val("");
                $("#subject").val("");
                $("#draftmail").parent().find(".Editor-editor").empty();
                $("#attach").empty();
                $('#File1').val('');
                $('#toemail').selectize()[0].selectize.clearOptions();
                $('#cc-input-tags').selectize()[0].selectize.clearOptions();
                $('#bcc-input-tags').selectize()[0].selectize.clearOptions();
                $('#CM_Cc_Row').slideUp(300);
                $('#CM_Bcc_Row').slideUp(300);
                $(".cc").show();
                $(".bcc").show();
                var checkcom = $("#iscompose").val();
                if (checkcom == "True") {
                    var sig = $("#signa").val();


                    $("#draftmail").parent().find(".Editor-editor").html("<br /><br />" + sig);

                }

            }

            function openinbox() {
                $("#compose").hide();
                $("#inbox").show();
                InboxMail(1);
            }


            function showdraft(skip) {



                if ($('#slide-menu').hasClass('left-menu-open')) {
                    $('#slide-menu').removeClass('left-menu-open');
                    $('.mobilebg').fadeOut(300);
                }
                $("#headtag").html("Draft");

                ShowHideSearchDiv("Draft");
                $("#inbox").show();
                $("#compose").hide();
                $("#paginationdiv").hide();
                $("#inboxli").removeClass("active");
                $("#trashli").removeClass("active");
                $("#draftli").addClass("active");
                $("#starli").removeClass("active");
                $("#sendboxli").removeClass("active");
                $("#outboxli").removeClass("active");
                $("#inboxlist").empty();
                $("#detail").empty();
                var search = $("#txtSearchDraft").val();
                var SystemTimeZone = Timezone();
                PageMethods.DraftMessage(search, skip,SystemTimeZone, function (data) {
                    var width = $(window).width();

                    var inboxdata = data.split("{*^*}");

                    if (inboxdata[2] == "done") {
                        $("#loader").hide();
                        $("#draftcount").html(inboxdata[1]);
                        $("#inboxlist").html(inboxdata[0]);


                        if (width >= 768) {
                            $("#first").click();
                        }
                        else {
                            closedetail();
                        }



                        if (inboxdata[1] > 10) {
                            $("#paginationdiv").show();
                        }
                        else {

                            $("#paginationdiv").hide();
                        }


                        //if (Number(RecordShow) < Number(TotalRecord)) {

                        var PaginationString = '<li class="page-item"><a class="page-link" href="javascript:;"  onclick="GoToPrevSegment();"><span aria-hidden=\"true\">&laquo;</span></a></li>'

                        for (var i = 1; i <= Number(inboxdata[3]) ; i++) {

                            PaginationString += "<li " + (skip == i ? "class='currentuse active page-item'" : "class='currentuse page-item'") + "><a class='page-link' href='javascript:;'  Onclick='showdraft(" + i + ");'>" + i + " " + (skip == i ? "<span class='sr-only'>(current)</span>" : "") + "</a></li>";
                        }

                        PaginationString += '<li class="page-item"><a class="page-link" href="javascript:;" onclick="GoToNextSegment();"><span aria-hidden=\"true\">&raquo;</span></a></li>'

                        $("#DivPager").html(PaginationString);
                        //$("#defaultfooter").show();

                        // How many page will be visible SETTING
                        PaginationVisiblePages(skip);


                        // }


                        //$("#next").attr('onclick','inboxdata()');
                        //$("#prev").attr('onclick','inboxdata()');

                    }
                    else if (inboxdata[2] == "fail"){
                        $("#DivPager").empty();
                        Message({ 'Msg': 'No draft mail(s) found this time. Please try again later', 'Type': msg_Error });
                        $("#loader").hide();
                    }
                    else if (inboxdata[2] == "nomessage") {
                        $("#DivPager").empty();
                        $("#detail").html("<div class='errormsgbox'>No message Found</div>");
                        if (width >= 320 && width < 767) {
                            $("#inboxlist").html("<div class='errormsgbox'>No message Found</div>");
                        }
                        $("#loader").hide();
                    }

                }, function (error) {
                    console.log(error);
                    $("#DivPager").empty();
                    Message({ 'Msg': 'No draft mail(s) found this time. Please try again later', 'Type': msg_Error });
                });
            }

            function opensendbox(skip) {

                if ($('#slide-menu').hasClass('left-menu-open')) {
                    $('#slide-menu').removeClass('left-menu-open');
                    $('.mobilebg').fadeOut(300);
                }
                $("#headtag").html("Sent");

                ShowHideSearchDiv("Sent");
                $("#inbox").show();
                $("#compose").hide();
                $("#paginationdiv").show();

                $("#inboxli").removeClass("active");
                $("#draftli").removeClass("active");
                $("#starli").removeClass("active");
                $("#trashli").removeClass("active");
                $("#sendboxli").addClass("active");
                $("#outboxli").removeClass("active");
                $("#inboxlist").empty();
                $("#detail").empty();
                var Search = $("#txtSearchSentBox").val();
                var SystemTimeZone = Timezone();
                PageMethods.SendBoxMsg(Search, skip, SystemTimeZone, function (data) {

                    var inboxdata = data.split("{*^*}");
                    var width = $(window).width();
                    if (inboxdata[2] == "done") {
                        $("#loader").hide();
                        $("#sendcount").html(inboxdata[1]);
                        $("#inboxlist").html(inboxdata[0]);


                        if (width >= 768) {

                            $("#first").click();
                        } else {
                            closedetail();
                        }

                        if (inboxdata[1] > 10) {
                            $("#paginationdiv").show();
                        }
                        else {

                            $("#paginationdiv").hide();
                        }


                        //if (Number(RecordShow) < Number(TotalRecord)) {

                        var PaginationString = '<li class="page-item"><a class="page-link" href="javascript:;"  onclick="GoToPrevSegment();"><span aria-hidden=\"true\">&laquo;</span></a></li>'

                        for (var i = 1; i <= Number(inboxdata[3]) ; i++) {

                            PaginationString += "<li " + (skip == i ? "class='currentuse active page-item'" : "class='currentuse page-item'") + "><a class='page-link' href='javascript:;'  Onclick='opensendbox(" + i + ");'>" + i + " " + (skip == i ? "<span class='sr-only'>(current)</span>" : "") + "</a></li>";
                        }

                        PaginationString += '<li class="page-item"><a class="page-link" href="javascript:;" onclick="GoToNextSegment();"><span aria-hidden=\"true\">&raquo;</span></a></li>'

                        $("#DivPager").html(PaginationString);
                        //$("#defaultfooter").show();

                        // How many page will be visible SETTING
                        PaginationVisiblePages(skip);

                        // }


                        //$("#next").attr('onclick','inboxdata()');
                        //$("#prev").attr('onclick','inboxdata()');

                    }
                    else if (inboxdata[2] == "fail") {
                        Message({ 'Msg': 'Looks like we encountered an issue, please refresh the page', 'Type': msg_Error });
                        $("#loader").hide();
                        $("#DivPager").empty();
                    }

                    else if (inboxdata[2] == "nomessage") {
                        $("#detail").html("<div class='errormsgbox'>No message Found</div>");
                        if (width >= 320 && width < 767) {
                            $("#inboxlist").html("<div class='errormsgbox'>No message Found</div>");
                        }
                        $("#loader").hide();
                        $("#DivPager").empty();

                    }

                }, function (error) {
                    console.log(error);
                    Message({ 'Msg': 'Looks like we encountered an issue, please refresh the page', 'Type': msg_Error });
                    $("#DivPager").empty();
                });
            }

            function InboxMail(PageClick) {

                if ($('#slide-menu').hasClass('left-menu-open')) {
                    $('#slide-menu').removeClass('left-menu-open');
                    $('.mobilebg').fadeOut(300);
                }

                $("#headtag").html("Inbox");
                ShowHideSearchDiv("Inbox");
                $("#loader").show();
                $("#inbox").show();
                $("#paginationdiv").show();
                $("#inboxli").addClass("active");
                $("#trashli").removeClass("active");
                $("#starli").removeClass("active");
                $("#draftli").removeClass("active");
                $("#sendboxli").removeClass("active");
                $("#outboxli").removeClass("active");
                $("#inboxlist").empty();
                $("#detail").empty();
                var search = $("#txtSearchmail").val();
                var SystemTimeZone = Timezone();
                PageMethods.GetEmailsWithHost(PageClick, search, SystemTimeZone, function (data) {

                    $("#detail").empty();
                    var inboxdata = data.split("{*^*}");
                    var width = $(window).width();
                    if (inboxdata[3] == "done") {
                        $("#loader").hide();
                        $("#count").html(inboxdata[0]);
                        $("#inboxlist").html(inboxdata[1]);


                        if (width >= 768) {

                            $("#first").click();
                        }
                        else {
                            closedetail();
                        }



                        //if (Number(RecordShow) < Number(TotalRecord)) {

                        var PaginationString = '<li class="page-item"><a class="page-link" href="javascript:;"  onclick="GoToPrevSegment();"><span aria-hidden=\"true\">&laquo;</span></a></li>'

                        for (var i = 1; i <= Number(inboxdata[2]) ; i++) {

                            PaginationString += "<li " + (PageClick == i ? "class='currentuse active page-item'" : "class='currentuse page-item'") + "><a class='page-link' href='javascript:;'  Onclick='InboxMail(" + i + ");'>" + i + " " + (PageClick == i ? "<span class='sr-only'>(current)</span>" : "") + "</a></li>";
                        }

                        PaginationString += '<li class="page-item"><a class="page-link" href="javascript:;" onclick="GoToNextSegment();"><span aria-hidden=\"true\">&raquo;</span></a></li>'

                        $("#DivPager").html(PaginationString);
                        //$("#defaultfooter").show();

                        // How many page will be visible SETTING
                        PaginationVisiblePages(PageClick);

                        // }


                        //$("#next").attr('onclick','inboxdata()');
                        //$("#prev").attr('onclick','inboxdata()');

                    }
                    else if (inboxdata[3] == "fail") {
                        $("#detail").html("<div class='errormsgbox'>Invalid Credentials</div>");
                        if (width >= 320 && width < 767) {
                            $("#inboxlist").html("<div class='errormsgbox'>Invalid Credentials</div>");
                        }
                        $("#loader").hide();
                        $("#DivPager").empty();

                    }

                    else if (inboxdata[3] == "norecord") {
                        $("#detail").html("<div class='errormsgbox'>Please Enter Credentials</div>");
                        if (width >= 320 && width < 767) {
                            $("#inboxlist").html("<div class='errormsgbox'>Please Enter Credentials</div>");
                        }
                        $("#loader").hide();
                        $("#DivPager").empty();
                    }
                    else if (inboxdata[3] == "nomessage") {
                        $("#count").html(inboxdata[0]);
                        $("#detail").html("<div class='errormsgbox'>No message Found</div>");
                        if (width >= 320 && width < 767) {
                            $("#inboxlist").html("<div class='errormsgbox'>No message Found</div>");
                        }
                        $("#loader").hide();
                        $("#DivPager").empty();
                    }

                }, function (error) {

                    $("#detail").html("<div class='errormsgbox'>Looks like we encountered an issue, please refresh the page</div>");
                    if (width >= 320 && width < 767) {
                        $("#inboxlist").html("<div class='errormsgbox'>Looks like we encountered an issue, please refresh the page</div>");
                    }
                    $("#loader").hide();
                    $("#DivPager").empty();
                });
            }


            function opentrash(skip) {
               
                if ($('#slide-menu').hasClass('left-menu-open')) {
                    $('#slide-menu').removeClass('left-menu-open');
                    $('.mobilebg').fadeOut(300);
                }
                $("#headtag").html("Trash");

                ShowHideSearchDiv("trash");
                $("#inbox").show();
                $("#compose").hide();
                $("#loader").show();
                $("#paginationdiv").hide();
                $("#inboxlist").empty();
                $("#detail").empty();
                $("#inboxli").removeClass("active");
                $("#trashli").addClass("active");
                $("#starli").removeClass("active");
                $("#draftli").removeClass("active");
                $("#sendboxli").removeClass("active");
                $("#outboxli").removeClass("active");
                var search = $("#txtSearchTrash").val();
                var SystemTimeZone = Timezone();
                PageMethods.OpenTrash(search, skip, SystemTimeZone, function (data) {


                    $("#detail").empty();

                    $("#loader").hide();
                    var width = $(window).width();

                    var inboxdata = data.split("{*^*}");
                    if (inboxdata[2] == "done") {

                        $("#trashcount").html(inboxdata[1]);
                        $("#inboxlist").html(inboxdata[0]);

                        if (width >= 768) {

                            $("#first").click();
                        }
                        else {
                            closedetail();
                        }



                        if (inboxdata[1] > 10) {
                            $("#paginationdiv").show();
                        }
                        else {

                            $("#paginationdiv").hide();
                        }


                        //if (Number(RecordShow) < Number(TotalRecord)) {

                        var PaginationString = '<li class="page-item"><a class="page-link" href="javascript:;"  onclick="GoToPrevSegment();"><span aria-hidden=\"true\">&laquo;</span></a></li>'

                        for (var i = 1; i <= Number(inboxdata[3]) ; i++) {

                            PaginationString += "<li " + (skip == i ? "class='currentuse active page-item'" : "class='currentuse page-item'") + "><a class='page-link' href='javascript:;'  Onclick='opentrash(" + i + ");'>" + i + " " + (skip == i ? "<span class='sr-only'>(current)</span>" : "") + "</a></li>";
                        }

                        PaginationString += '<li class="page-item"><a class="page-link" href="javascript:;" onclick="GoToNextSegment();"><span aria-hidden=\"true\">&raquo;</span></a></li>'

                        $("#DivPager").html(PaginationString);
                        //$("#defaultfooter").show();

                        // How many page will be visible SETTING
                        PaginationVisiblePages(skip);

                    }
                    else if (inboxdata[2] == "fail") {
                        $("#DivPager").empty();
                        $("#detail").html("<div class='errormsgbox'>Looks like we encountered an issue, please refresh the page</div>");
                        if (width >= 320 && width < 767) {
                            $("#inboxlist").html("<div class='errormsgbox'>Looks like we encountered an issue, please refresh the page</div>");
                    }
                    }
                    else if (inboxdata[2] == "Norecord") {
                        $("#DivPager").empty();
                        $("#detail").html("<div class='errormsgbox'>Please Enter Credentials</div>");
                        if (width >= 320 && width < 767) {
                            $("#inboxlist").html("<div class='errormsgbox'>Please Enter Credentials</div>");
                        }

                    }
                    else if (inboxdata[2] == "nomessage") {
                        $("#DivPager").empty();
                        $("#detail").html("<div class='errormsgbox'>No message Found</div>");
                        if (width >= 320 && width < 767) {
                            $("#inboxlist").html("<div class='errormsgbox'>No message Found</div>");
                    }
                    }
                    else if (inboxdata[2] == "nocre") {
                        $("#DivPager").empty();
                        $("#detail").html("<div class='errormsgbox'>Please Enter Credentials</div>");
                        if (width >= 320 && width < 767) {
                            $("#inboxlist").html("<div class='errormsgbox'>Please Enter Credentials</div>");
                        }
                        $("#loader").hide();
                    }

                }, function (error) {
                    $("#DivPager").empty();
                    $("#detail").html("<div class='errormsgbox'>Invalid Credentials/div.");
                    if (width >= 320 && width < 767) {
                        $("#inboxlist").html("<div class='errormsgbox'>Invalid Credentials</div>");
                    }
                    $("#loader").hide();

                });

            }


            function openoutbox(skip) {


                if ($('#slide-menu').hasClass('left-menu-open')) {
                    $('#slide-menu').removeClass('left-menu-open');
                    $('.mobilebg').fadeOut(300);
                }
                $("#headtag").html("Outbox");

                ShowHideSearchDiv("OutBox");
                $("#inbox").show();
                $("#compose").hide();
                $("#loader").show();
                $("#paginationdiv").hide();
                $("#inboxlist").empty();
                $("#detail").empty();
                $("#inboxli").removeClass("active");
                $("#starli").removeClass("active");
                $("#trashli").removeClass("active");
                $("#draftli").removeClass("active");
                $("#sendboxli").removeClass("active");
                $("#outboxli").addClass("active");
                var Search = $("#txtSearchOut").val();
                var SystemTimezone = Timezone();
                PageMethods.OpenOutBox(Search, skip, SystemTimezone, function (data) {

                    $("#detail").empty();

                    $("#loader").hide();
                    var width = $(window).width();
                    var inboxdata = data.split("{*^*}");
                    if (inboxdata[2] == "done") {

                        $("#outboxcount").html(inboxdata[1]);
                        $("#inboxlist").html(inboxdata[0]);



                        if (width >= 768) {
                            $("#first").click();
                        } else {
                            closedetail();
                        }



                        if (inboxdata[1] > 10) {
                            $("#paginationdiv").show();
                        }
                        else {

                            $("#paginationdiv").hide();
                        }


                        //if (Number(RecordShow) < Number(TotalRecord)) {

                        var PaginationString = '<li class="page-item"><a class="page-link" href="javascript:;"  onclick="GoToPrevSegment();"><span aria-hidden=\"true\">&laquo;</span></a></li>'

                        for (var i = 1; i <= Number(inboxdata[3]) ; i++) {

                            PaginationString += "<li " + (skip == i ? "class='currentuse active page-item'" : "class='currentuse page-item'") + "><a class='page-link' href='javascript:;'  Onclick='openoutbox(" + i + ");'>" + i + " " + (skip == i ? "<span class='sr-only'>(current)</span>" : "") + "</a></li>";
                        }

                        PaginationString += '<li class="page-item"><a class="page-link" href="javascript:;" onclick="GoToNextSegment();"><span aria-hidden=\"true\">&raquo;</span></a></li>'

                        $("#DivPager").html(PaginationString);
                        //$("#defaultfooter").show();

                        // How many page will be visible SETTING
                        PaginationVisiblePages(skip);


                    }
                    else if (inboxdata[2] == "fail") {
                        $("#DivPager").empty();
                        $("#detail").html("<div class='errormsgbox'>Looks like we encountered an issue, please refresh the page</div>");
                        if (width >= 320 && width < 767) {
                            $("#inboxlist").html("<div class='errormsgbox'>Looks like we encountered an issue, Please refresh the Page.</div>");
                    }
                    }
                    else if (inboxdata[2] == "Norecord") {
                        $("#DivPager").empty();
                        $("#detail").html("<div class='errormsgbox'>Please Enter Credentials</div>");
                        if (width >= 320 && width < 767) {
                            $("#inboxlist").html("<div class='errormsgbox'>Please Enter credentials.</div>");
                        }

                    }
                    else if (inboxdata[2] == "nomessage") {
                        $("#DivPager").empty();
                        $("#detail").html("<div class='errormsgbox'>No message Found</div>");
                        if (width >= 320 && width < 767) {
                            $("#inboxlist").html("<div class='errormsgbox'>No message Found</div>");
                        }
                    }
                    else if (inboxdata[2] == "nocre") {
                        $("#DivPager").empty();
                        $("#detail").html("<div class='errormsgbox'>Please Enter Credentials</div>");
                        if (width >= 320 && width < 767) {
                            $("#inboxlist").html("<div class='errormsgbox'>Please Enter Credentials</div>");
                        }
                        $("#loader").hide();
                    }
                }, function (error) {
                    $("#DivPager").empty();
                    $("#detail").html("<div class='errormsgbox'>Invalid Credentials</div>");
                    if (width >= 320 && width < 767) {
                        $("#inboxlist").html("<div class='errormsgbox'>Invalid Credentials</div>");
                    }
                    $("#loader").hide();

                });

            }


            function GetInboxEmaildetails(dis) {
               
                $(".mail-list").removeClass("new_mail");

                $(dis).find(".mail-list").addClass("new_mail");

                var width = $(window).width();

                if (width < 768) {
                    $(".mob_contnrinboxlist").css('margin-left', '-100%');
                    $(".mob_contnr-inbox").css('margin-left', '0');

                }


                var Subject = $(dis).find('.mysub').html();
                var ccmails = $(dis).find('.ccmails').html();
                var bccmails = $(dis).find('.bccmails').html();
                var tomails = $(dis).find('.tomails').html();
                var replyallmails = $(dis).find('.replyallmails').html();
                var attach = $(dis).find('.attach').html();
                var attachname = $(dis).find('.attachname').html();
                var spl = "";
                if (attach != "") {
                    spl = attach.split("{bt}");
                }

                var uid = $(dis).find('.uid').html();
                var mdate = $(dis).find('.maildate').html();
                var fromaddress = $(dis).find('.fromad').html();

                var splitto = tomails.split(",");
                var splitcc = ccmails.split(",");
                var splitreplyall = replyallmails.split(",");

                if (Subject == "" || Subject == null) {
                    Subject = "No Subject";
                }
                var Headers = $(dis).find('.nwinb_mailcont').text();
                var Body = $(dis).find('.nwinb_chkbox').find('.thisemailbody').html();
                Body = Body.replace("\r\n", "<br />");
                //var Body = "Kreyon Systems\r\n\r\nSign-in attempt was blocked\r\nkreyonsoftwares@gmail.com\r\nSomeone just used your password to try to sign in to your account. Google\r\nblocked them, but you should check what happened.\r\n\r\n\r\n\r\nCheck activity\r\n<https://accounts.google.com/AccountChooser?Email=kreyonsoftwares@gmail.com&continue=https://myaccount.google.com/alert/nt/1542188152000?rfn%3D6%26rfnc%3D1%26eid%3D7076505028597882858%26et%3D0%26asae%3D2%26anexp%3Dgivab-fa>\r\n<https://accounts.google.com/AccountChooser?Email=kreyonsoftwares@gmail.com&continue=https://myaccount.google.com/alert/nt/1542188152000?rfn%3D6%26rfnc%3D1%26eid%3D7076505028597882858%26et%3D0%26asae%3D2%26anexp%3Dgivab-fa>\r\n\r\n\r\nYou received this email to let you know about important changes to your\r\nGoogle Account and services.\r\n?? 2018 Google LLC,1600 Amphitheatre Parkway, Mountain View, CA 94043, USA\r\n1542188152000000\r\n";

                var Tos = $(dis).find(".mytos").text();
                var str = "";

                //////////////Details/////////////////////////////////////////////////////////////////////////////////////
                if (Body == "" || Body == null) {
                    Body = "No Details";
                }
                var mainfile = "";
                var attname = attachname.split("{at}");
                var attfile = attach.split("{bt}");

                for (var i = 0; i < attname.length; i++) {
                    if (attname[i] != "") {

                        mainfile += '<div  class="file-attachted">   <div class="img-thumbnail img-attachment"><img src="images/word-icon.png" /><span class="file-attachted-name">' + attname[i] + '</span> <span class="file-attachted-size"></span><div class="doc_downlod_hovr"><span class="mdi mdi-download"  onclick=\'AttachmentDowmload("' + attfile[i] + "{bt}" + attname[i] + '")\' ></span><span class="mdi mdi-eye"></span></div></div>   </div></div>  ';
                    }
                }


                var ccbcclist = '<a class="dropdown-item" href="#"><span class="col-2 col-sm-2 col-md-3 col-lg-2  mail_cc_option_left">To :</span><p class="col-10 col-sm-10 col-md-9 col-lg-10 mail_cc_option_right">';

                for (var i = 0; i < splitto.length; i++) {

                    if (splitto[i] != "") {
                        ccbcclist += '<span><span class="frm_email">' + splitto[i] + '</span></span><br/>';
                    }
                }
                ccbcclist += '</p></a>';

                if (ccmails != "") {
                    ccbcclist += '<a class="dropdown-item" href="#"><span class="col-2 col-sm-2 col-md-3 col-lg-2  mail_cc_option_left">Cc :</span><p class="col-10 col-sm-10 col-md-9 col-lg-10 mail_cc_option_right">';
                    for (var i = 0; i < splitcc.length; i++) {
                        if (splitcc[i] != "") {
                            ccbcclist += '<span><span class="frm_email">' + splitcc[i] + '</span></span><br/>';
                        }
                    }
                    ccbcclist += '</p></a>';

                }

                if (bccmails != "") {
                    ccbcclist += '<a class="dropdown-item" href="#"><span class="col-2 col-sm-2 col-md-3 col-lg-2  mail_cc_option_left">Bcc :</span><p class="col-10 col-sm-10 col-md-9 col-lg-10 mail_cc_option_right">';

                    ccbcclist += '<span><span class="frm_email">' + bccmails + '</span></span>';

                    ccbcclist += '</p></a>';
                }

                var replyalldiv = "";
                if (splitreplyall.length > 1) {
                    replyalldiv = '  <button type="button" class="btn btn-sm btn-outline-secondary" onclick="ReplyAllemail(this)"><i class="mdi mdi-reply-all text-primary"></i>Reply All</button> '
                }

                var htmldata = ' <div class="row">' +
       '                                    <div class="col-md-12 mb-4 mt-4 tab_tp_btm10">                                                                                                                          ' +
       '                                                <button type="button" class="btn btn-sm btn-secondary btn-backmob" onclick="closedetail()"><i class="mdi mdi-arrow-left"></i>Back</button>                                                    ' +
       '                                        <div class="btn-toolbar">                                                                                                                                           ' +
       '                                            <div class="btn-group tab-mrgnbtm5 div_left">                                                                                                                            ' +
       '                                                <button type="button" class="btn btn-sm btn-outline-secondary" onclick="Replyemail(this)"><i class="mdi mdi-reply text-primary"></i>Reply</button>                                     ' +
       '                                              ' + replyalldiv + '                         ' +
       '                                                <button type="button" class="btn btn-sm btn-outline-secondary" onclick="Forwardemail(this)"><i class="mdi mdi-share text-primary"></i>Forward</button>                                   ' +
       '                                            </div>                                                                                                                                                          ' +
       '                                            <div class="btn-group tab-mrgnbtm5 div_left">                                                                                                                                         ' +
       //'                                                <button type="button" class="btn btn-sm btn-outline-secondary"><i class="mdi mdi-attachment text-primary"></i>Attach</button>                               ' +
       '                                                <button type="button" class="btn btn-sm btn-outline-secondary" onclick=\'Deletemail("' + uid + '");\'><i class="mdi mdi-delete text-primary"></i>Delete</button>                                   ' +
       '                                            </div>                                                                                                                                                          ' +
       '                                            <div class="inf_inbx div_left">                                                                                                                                          ' +
       '                                                <i class="mdi mdi-label"></i>                                                                                                                               ' +
       '                                                <span>Inbox                                                                                                                                                 ' +
       '                                                </span>                                                                                                                                                     ' +
       '                                            </div>                                                                                                                                                          ' +
       '                                        </div>                                                                                                                                                              ' +
       '                                    </div>                                                                                                                                                                  ' +
       '                                </div>                                                                                                                                                                      ' +
       '                                <div class="message-body">                                                                                                                                                  ' +
       '                                    <div class="msgs_container inboxscroll">                                                                                                                                                          ' +
       '                                    <div class="sender-details">                                                                                                                                            ' +
       '                                        <img class="img-sm rounded-circle mr-3" alt="" src="images/userprofile.png" />                                                                                      ' +
       '                                                                                                                                                                                                            ' +
       '                                        <div class="details">                                                                                                                                               ' +
      ' <p class="msg-date">' + mdate + ' </p>' +
       '                                            <p class="msg-subject fw600 inboxsub">                                                                                                                                   ' +
       '                                                ' + Subject + '                                                                                                       ' +
       '                </p>  </br>                                                                                                                                                                                      ' +
       '                <p class="sender-email fw600">                                                                                                                                                              ' +
       '                                                                                                                                                                                          ' +
       '<a href="#" class="inboxfrom">' + Tos + '</a>                                                                                                                                                                     ' +
        '<a style="display:none" href="#" class="inboxfromaddress">' + fromaddress + '</a>                                                                                                                                                                     ' +
            '<a style="display:none" href="#" class="inboxccmails">' + ccmails + '</a>                                                                                                                                                                     ' +
                '<a style="display:none" href="#" class="inboxbccmails">' + bccmails + '</a>                                                                                                                                                                     ' +
                    '<a style="display:none" href="#" class="inboxreplyallmails">' + replyallmails + '</a>                                                                                                                                                                     ' +
       '                        &nbsp;<div class="dropdown-toggle drp_icon_Cc" data-toggle="dropdown" id="dropdownMenuLink">                                                                                                                                ' +
   //    '    <div class="dropdown-menu dropmenu_ccbox" aria-labelledby="dropdownMenuLink"><a class="dropdown-item " href="#"><span class="col-sm-3 mail_cc_option_left">From :</span><p class="col-sm-9 mail_cc_option_right"><span class="frm_name">Sagar</span><span class="frm_email">sagargupta091@gmail.com</span></p></a><a class="dropdown-item" href="#"><span class="col-sm-3 mail_cc_option_left">To :</span><p class="col-sm-9 mail_cc_option_right"><span><span class="to_name">sindhu</span><span class="frm_email">sindhu09@gmail.com</span></span></br><span><span class="to_name">sindhu</span><span class="frm_email">sindhu09@gmail.com</span></span></p></a></div></div>                                                       ' +
        '    <div class="dropdown-menu dropmenu_ccbox" aria-labelledby="dropdownMenuLink" ><a class="dropdown-item" role="menu" href="#"><span class="col-2 col-sm-2 col-md-3 col-lg-2  mail_cc_option_left">From :</span><p class="col-10 col-sm-10 col-md-9 col-lg-10 mail_cc_option_right"><span class="frm_email">' + fromaddress + '</span></p></a>' + ccbcclist + '</div></div>                                                       ' +
       '                    </p>                                                                                                                                                                                    ' +
       '                </div>                                                                                                                                                                                      ' +
       '            </div>                                                                                                                                                                                          ' +
       '            <div class="message-content inboxbody">                                                                                                                                                                   ' +
       '                ' + Body + '                                                                                                                                                                                       ' +
       '            </div>                                                                                                                                                                                          ' +
       '            </div>                                                                                                                                                                                         ' +

      ' ' + mainfile + '' +

       //'            <div class="attachments-sections">                                                                                                                                                              ' +
       //'                <ul>                                                                                                                                                                                        ' +
       //'                    <li>                                                                                                                                                                                    ' +
       //'                        <div class="thumb"><i class="mdi mdi-file-pdf"></i></div>                                                                                                                           ' +
       //'                        <div class="details">                                                                                                                                                               ' +
       //'                            <p class="file-name">Seminar Reports.pdf</p>                                                                                                                                    ' +
       //'                            <div class="buttons">                                                                                                                                                           ' +
       //'                                <p class="file-size">678Kb</p>                                                                                                                                              ' +
       //'                                <a href="#" class="view">View</a>                                                                                                                                           ' +
       //'                                <a href="#" class="download">Download</a>                                                                                                                                   ' +
       //'                            </div>                                                                                                                                                                          ' +
       //'                        </div>                                                                                                                                                                              ' +
       //'                    </li>                                                                                                                                                                                   ' +
       //'                    <li>                                                                                                                                                                                    ' +
       //'                        <div class="thumb"><i class="mdi mdi-file-image"></i></div>                                                                                                                         ' +
       //'                        <div class="details">                                                                                                                                                               ' +
       //'                            <p class="file-name">Product Design.jpg</p>                                                                                                                                     ' +
       //'                            <div class="buttons">                                                                                                                                                           ' +
       //'                                <p class="file-size">1.96Mb</p>                                                                                                                                             ' +
       //'                                <a href="#" class="view">View</a>                                                                                                                                           ' +
       //'                                <a href="#" class="download">Download</a>                                                                                                                                   ' +
       //'                            </div>                                                                                                                                                                          ' +
       //'                        </div>                                                                                                                                                                              ' +
       //'                    </li>                                                                                                                                                                                   ' +
       //'                </ul>                                                                                                                                                                                       ' +
       //'            </div>                                                                                                                                                                                          ' +
       '        </div>';

                $("#detail").html(htmldata);
                //var div = document.createElement("div");
                // div.innerHTML = htmldata;
                // document.getElementById('detail').appendChild(div);

                //document.getElementById('detail').insertAdjacentHTML('beforeend', '<div id="idChild"> ' + htmldata + ' </div>');


            }

            function GetStarEmaildetails(dis) {
                $(".mail-list").removeClass("new_mail");

                $(dis).find(".mail-list").addClass("new_mail");

                var width = $(window).width();

                if (width < 768) {
                    $(".mob_contnrinboxlist").css('margin-left', '-100%');
                    $(".mob_contnr-inbox").css('margin-left', '0');

                }


                var Subject = $(dis).find('.mysub').html();
                var ccmails = $(dis).find('.ccmails').html();
                var bccmails = $(dis).find('.bccmails').html();
                var tomails = $(dis).find('.tomails').html();
                var replyallmails = $(dis).find('.replyallmails').html();
                var attach = $(dis).find('.attach').html();
                var attachname = $(dis).find('.attachname').html();
                var spl = "";
                if (attach != "") {
                    spl = attach.split("{bt}");
                }

                var uid = $(dis).find('.uid').html();
                var mdate = $(dis).find('.maildate').html();
                var fromaddress = $(dis).find('.fromad').html();

                var splitto = tomails.split(",");
                var splitcc = ccmails.split(",");
                var splitreplyall = replyallmails.split(",");

                if (Subject == "" || Subject == null) {
                    Subject = "No Subject";
                }
                var Headers = $(dis).find('.nwinb_mailcont').text();
                var Body = $(dis).find('.nwinb_chkbox').find('.thisemailbody').html();
                Body = Body.replace("\r\n", "<br />");
                //var Body = "Kreyon Systems\r\n\r\nSign-in attempt was blocked\r\nkreyonsoftwares@gmail.com\r\nSomeone just used your password to try to sign in to your account. Google\r\nblocked them, but you should check what happened.\r\n\r\n\r\n\r\nCheck activity\r\n<https://accounts.google.com/AccountChooser?Email=kreyonsoftwares@gmail.com&continue=https://myaccount.google.com/alert/nt/1542188152000?rfn%3D6%26rfnc%3D1%26eid%3D7076505028597882858%26et%3D0%26asae%3D2%26anexp%3Dgivab-fa>\r\n<https://accounts.google.com/AccountChooser?Email=kreyonsoftwares@gmail.com&continue=https://myaccount.google.com/alert/nt/1542188152000?rfn%3D6%26rfnc%3D1%26eid%3D7076505028597882858%26et%3D0%26asae%3D2%26anexp%3Dgivab-fa>\r\n\r\n\r\nYou received this email to let you know about important changes to your\r\nGoogle Account and services.\r\n?? 2018 Google LLC,1600 Amphitheatre Parkway, Mountain View, CA 94043, USA\r\n1542188152000000\r\n";

                var Tos = $(dis).find(".mytos").text();
                var str = "";

                //////////////Details/////////////////////////////////////////////////////////////////////////////////////
                if (Body == "" || Body == null) {
                    Body = "No Details";
                }
                var mainfile = "";
                var attname = attachname.split("{at}");
                var attfile = attach.split("{bt}");

                for (var i = 0; i < attname.length; i++) {
                    if (attname[i] != "") {

                        mainfile += '<div  class="file-attachted">   <div class="img-thumbnail img-attachment"><img src="images/word-icon.png" /><span class="file-attachted-name">' + attname[i] + '</span> <span class="file-attachted-size"></span><div class="doc_downlod_hovr"><span class="mdi mdi-download"  onclick=\'AttachmentDowmload("' + attfile[i] + "{bt}" + attname[i] + '")\' ></span><span class="mdi mdi-eye"></span></div></div>   </div></div>  ';
                    }
                }


                var ccbcclist = '<a class="dropdown-item" href="#"><span class="col-sm-3 col-2 mail_cc_option_left">To :</span><p class="col-sm-9 col-10 mail_cc_option_right">';

                for (var i = 0; i < splitto.length; i++) {

                    if (splitto[i] != "") {
                        ccbcclist += '<span><span class="frm_email">' + splitto[i] + '</span></span><br/>';
                    }
                }
                ccbcclist += '</p></a>';

                if (ccmails != "") {
                    ccbcclist += '<a class="dropdown-item" href="#"><span class="col-sm-3 col-2 mail_cc_option_left">Cc :</span><p class="col-sm-9 col-10 mail_cc_option_right">';
                    for (var i = 0; i < splitcc.length; i++) {
                        if (splitcc[i] != "") {
                            ccbcclist += '<span><span class="frm_email">' + splitcc[i] + '</span></span><br/>';
                        }
                    }
                    ccbcclist += '</p></a>';

                }

                if (bccmails != "") {
                    ccbcclist += '<a class="dropdown-item" href="#"><span class="col-sm-3 col-2 mail_cc_option_left">Bcc :</span><p class="col-sm-9 col-10 mail_cc_option_right">';

                    ccbcclist += '<span><span class="frm_email">' + bccmails + '</span></span>';

                    ccbcclist += '</p></a>';
                }

                var replyalldiv = "";
                if (splitreplyall.length > 1) {
                    replyalldiv = '  <button type="button" class="btn btn-sm btn-outline-secondary" onclick="ReplyAllemail(this)"><i class="mdi mdi-reply-all text-primary"></i>Reply All</button> '
                }

                var htmldata = ' <div class="row">' +
       '                                    <div class="col-md-12 mb-4 mt-4 tab_tp_btm10">                                                                                                                          ' +
       '                                                <button type="button" class="btn btn-sm btn-secondary btn-backmob" onclick="closedetail()"><i class="mdi mdi-arrow-left"></i>Back</button>                                                    ' +
       '                                        <div class="btn-toolbar">                                                                                                                                           ' +
       '                                            <div class="btn-group tab-mrgnbtm5 div_left">                                                                                                                            ' +
       '                                                <button type="button" class="btn btn-sm btn-outline-secondary" onclick="Replyemail(this)"><i class="mdi mdi-reply text-primary"></i>Reply</button>                                     ' +
       '                                              ' + replyalldiv + '                         ' +
       '                                                <button type="button" class="btn btn-sm btn-outline-secondary" onclick="Forwardemail(this)"><i class="mdi mdi-share text-primary"></i>Forward</button>                                   ' +
       '                                            </div>                                                                                                                                                          ' +
       '                                            <div class="btn-group tab-mrgnbtm5 div_left">                                                                                                                                         ' +
       //'                                                <button type="button" class="btn btn-sm btn-outline-secondary"><i class="mdi mdi-attachment text-primary"></i>Attach</button>                               ' +
      // '                                                <button type="button" class="btn btn-sm btn-outline-secondary" onclick=\'Deletemail("' + uid + '");\'><i class="mdi mdi-delete text-primary"></i>Delete</button>                                   ' +
       '                                            </div>                                                                                                                                                          ' +
       '                                            <div class="inf_inbx div_left">                                                                                                                                          ' +
       '                                                <i class="mdi mdi-label"></i>                                                                                                                               ' +
       '                                                <span>Starred                                                                                                                                                ' +
       '                                                </span>                                                                                                                                                     ' +
       '                                            </div>                                                                                                                                                          ' +
       '                                        </div>                                                                                                                                                              ' +
       '                                    </div>                                                                                                                                                                  ' +
       '                                </div>                                                                                                                                                                      ' +
       '                                <div class="message-body">                                                                                                                                                  ' +
       '                                    <div class="msgs_container inboxscroll">                                                                                                                                                          ' +
       '                                    <div class="sender-details">                                                                                                                                            ' +
       '                                        <img class="img-sm rounded-circle mr-3" alt="" src="images/userprofile.png" />                                                                                      ' +
       '                                                                                                                                                                                                            ' +
       '                                        <div class="details">                                                                                                                                               ' +
      ' <p class="msg-date">' + mdate + ' </p>' +
       '                                            <p class="msg-subject fw600 inboxsub">                                                                                                                                   ' +
       '                                                ' + Subject + '                                                                                                       ' +
       '                </p>  </br>                                                                                                                                                                                      ' +
       '                <p class="sender-email fw600">                                                                                                                                                              ' +
       '                                                                                                                                                                                          ' +
       '<a href="#" class="inboxfrom">' + Tos + '</a>                                                                                                                                                                     ' +
        '<a style="display:none" href="#" class="inboxfromaddress">' + fromaddress + '</a>                                                                                                                                                                     ' +
            '<a style="display:none" href="#" class="inboxccmails">' + ccmails + '</a>                                                                                                                                                                     ' +
                '<a style="display:none" href="#" class="inboxbccmails">' + bccmails + '</a>                                                                                                                                                                     ' +
                    '<a style="display:none" href="#" class="inboxreplyallmails">' + replyallmails + '</a>                                                                                                                                                                     ' +
       '                        &nbsp;<div class="dropdown drp_icon_Cc"><i class="dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"></i>                                                                                                                                 ' +
   //    '    <div class="dropdown-menu dropmenu_ccbox" aria-labelledby="dropdownMenuLink"><a class="dropdown-item " href="#"><span class="col-sm-3 mail_cc_option_left">From :</span><p class="col-sm-9 mail_cc_option_right"><span class="frm_name">Sagar</span><span class="frm_email">sagargupta091@gmail.com</span></p></a><a class="dropdown-item" href="#"><span class="col-sm-3 mail_cc_option_left">To :</span><p class="col-sm-9 mail_cc_option_right"><span><span class="to_name">sindhu</span><span class="frm_email">sindhu09@gmail.com</span></span></br><span><span class="to_name">sindhu</span><span class="frm_email">sindhu09@gmail.com</span></span></p></a></div></div>                                                       ' +
        '    <div class="dropdown-menu dropmenu_ccbox" aria-labelledby="dropdownMenuLink"><a class="dropdown-item " href="#"><span class="col-sm-3 col-2 mail_cc_option_left">From :</span><p class="col-sm-9 col-10 mail_cc_option_right"><span class="frm_email">' + fromaddress + '</span></p></a>' + ccbcclist + '</div></div>                                                       ' +
       '                    </p>                                                                                                                                                                                    ' +
       '                </div>                                                                                                                                                                                      ' +
       '            </div>                                                                                                                                                                                          ' +
       '            <div class="message-content inboxbody">                                                                                                                                                                   ' +
       '                ' + Body + '                                                                                                                                                                                       ' +
       '            </div>                                                                                                                                                                                          ' +
       '            </div>                                                                                                                                                                                         ' +

      ' ' + mainfile + '' +

       //'            <div class="attachments-sections">                                                                                                                                                              ' +
       //'                <ul>                                                                                                                                                                                        ' +
       //'                    <li>                                                                                                                                                                                    ' +
       //'                        <div class="thumb"><i class="mdi mdi-file-pdf"></i></div>                                                                                                                           ' +
       //'                        <div class="details">                                                                                                                                                               ' +
       //'                            <p class="file-name">Seminar Reports.pdf</p>                                                                                                                                    ' +
       //'                            <div class="buttons">                                                                                                                                                           ' +
       //'                                <p class="file-size">678Kb</p>                                                                                                                                              ' +
       //'                                <a href="#" class="view">View</a>                                                                                                                                           ' +
       //'                                <a href="#" class="download">Download</a>                                                                                                                                   ' +
       //'                            </div>                                                                                                                                                                          ' +
       //'                        </div>                                                                                                                                                                              ' +
       //'                    </li>                                                                                                                                                                                   ' +
       //'                    <li>                                                                                                                                                                                    ' +
       //'                        <div class="thumb"><i class="mdi mdi-file-image"></i></div>                                                                                                                         ' +
       //'                        <div class="details">                                                                                                                                                               ' +
       //'                            <p class="file-name">Product Design.jpg</p>                                                                                                                                     ' +
       //'                            <div class="buttons">                                                                                                                                                           ' +
       //'                                <p class="file-size">1.96Mb</p>                                                                                                                                             ' +
       //'                                <a href="#" class="view">View</a>                                                                                                                                           ' +
       //'                                <a href="#" class="download">Download</a>                                                                                                                                   ' +
       //'                            </div>                                                                                                                                                                          ' +
       //'                        </div>                                                                                                                                                                              ' +
       //'                    </li>                                                                                                                                                                                   ' +
       //'                </ul>                                                                                                                                                                                       ' +
       //'            </div>                                                                                                                                                                                          ' +
       '        </div>';

                $("#detail").html(htmldata);
                //var div = document.createElement("div");
                // div.innerHTML = htmldata;
                // document.getElementById('detail').appendChild(div);

                //document.getElementById('detail').insertAdjacentHTML('beforeend', '<div id="idChild"> ' + htmldata + ' </div>');


            }


            function DraftEmaildetails(dis) {

                $(".mail-list").removeClass("new_mail");

                $(dis).find(".mail-list").addClass("new_mail");
                var width = $(window).width();

                if (width < 768) {
                    $(".mob_contnrinboxlist").css('margin-left', '-100%');
                    $(".mob_contnr-inbox").css('margin-left', '0');

                }

                var Subject = $(dis).find('.mysub').html();
                var uid = $(dis).find('.uid').html();
                var mdate = $(dis).find('.maildate').html();
                var ccmails = $(dis).find('.ccmails').html();
                var bccmails = $(dis).find('.bccmails').html();
                if (Subject == "" || Subject == null) {
                    Subject = "No Subject";
                }
                var Headers = $(dis).find('.nwinb_mailcont').text();
                var Body = $(dis).find('.nwinb_chkbox').find('.thisemailbody').html();

                //var Body = "Kreyon Systems\r\n\r\nSign-in attempt was blocked\r\nkreyonsoftwares@gmail.com\r\nSomeone just used your password to try to sign in to your account. Google\r\nblocked them, but you should check what happened.\r\n\r\n\r\n\r\nCheck activity\r\n<https://accounts.google.com/AccountChooser?Email=kreyonsoftwares@gmail.com&continue=https://myaccount.google.com/alert/nt/1542188152000?rfn%3D6%26rfnc%3D1%26eid%3D7076505028597882858%26et%3D0%26asae%3D2%26anexp%3Dgivab-fa>\r\n<https://accounts.google.com/AccountChooser?Email=kreyonsoftwares@gmail.com&continue=https://myaccount.google.com/alert/nt/1542188152000?rfn%3D6%26rfnc%3D1%26eid%3D7076505028597882858%26et%3D0%26asae%3D2%26anexp%3Dgivab-fa>\r\n\r\n\r\nYou received this email to let you know about important changes to your\r\nGoogle Account and services.\r\n?? 2018 Google LLC,1600 Amphitheatre Parkway, Mountain View, CA 94043, USA\r\n1542188152000000\r\n";

                var Tos = $(dis).find(".mytos").text();
                var str = "";

                //////////////Details/////////////////////////////////////////////////////////////////////////////////////
                if (Body == "" || Body == null) {
                    Body = "No Details";
                }
                var Attach = $(dis).find('.myattach').html();
                var splitto = Tos.split(",");
                var splitcc = ccmails.split(",");
                var bccsplit = bccmails.split(",");
                var replyallmails = $(dis).find('.replyallmails').html();
                var splitreplyall = replyallmails.split(",");
                var replyalldiv = "";
                if (splitreplyall.length > 2) {
                    replyalldiv = '  <button type="button" class="btn btn-sm btn-outline-secondary" onclick="ReplyAllemail(this)"><i class="mdi mdi-reply-all text-primary"></i>Reply All</button> '
                }

                var SystemTimeZone = 0;
                try {
                    var SystemDate = new Date();
                    SystemTimeZone = ((-1) * SystemDate.getTimezoneOffset());
                } catch (e) {

                }


                var ccbcclist = '<a class="dropdown-item" href="#"><span class="col-2 col-sm-2 col-md-3 col-lg-2  mail_cc_option_left">To :</span><p class="col-10 col-sm-10 col-md-9 col-lg-10 mail_cc_option_right">';

                for (var i = 0; i < splitto.length; i++) {

                    if (splitto[i] != "") {
                        ccbcclist += '<span><span class="frm_email">' + splitto[i] + '</span></span><br/>';
                    }
                }
                ccbcclist += '</p></a>';

                if (ccmails != "") {
                    ccbcclist += '<a class="dropdown-item" href="#"><span class="col-2 col-sm-2 col-md-3 col-lg-2  mail_cc_option_left">Cc :</span><p class="col-10 col-sm-10 col-md-9 col-lg-10 mail_cc_option_right">';
                    for (var i = 0; i < splitcc.length; i++) {
                        if (splitcc[i] != "") {
                            ccbcclist += '<span><span class="frm_email">' + splitcc[i] + '</span></span><br/>';
                        }
                    }
                    ccbcclist += '</p></a>';

                }

                if (bccmails != "") {
                    ccbcclist += '<a class="dropdown-item" href="#"><span class="col-2 col-sm-2 col-md-3 col-lg-2  mail_cc_option_left">Bcc :</span><p class="col-10 col-sm-10 col-md-9 col-lg-10 mail_cc_option_right">';
                    for (var i = 0; i < bccsplit.length; i++) {
                        if (bccsplit[i] != "") {
                            ccbcclist += '<span><span class="frm_email">' + bccsplit[i] + '</span></span><br/>';
                        }
                    }

                    ccbcclist += '</p></a>';
                }


                $("#detail").html(' <div class="row">' +

    '                                    <div class="col-md-12 mb-4 mt-4 tab_tp_btm10">                                                                                                                          ' +
     '                                                <button type="button" class="btn btn-sm btn-secondary btn-backmob" onclick="closedetail()"><i class="mdi mdi-arrow-left"></i>Back</button>                                                    ' +
    '                                        <div class="btn-toolbar">                                                                                                                                           ' +
    '                                            <div class="btn-group tab-mrgnbtm5">                                                                                                                            ' +
    '                                                <button type="button" class="btn btn-sm btn-outline-secondary" onclick="Replyemail(this)"><i class="mdi mdi-reply text-primary"></i>Reply</button>                                     ' +
    '                                                '+replyalldiv+'' +
    '                                                <button type="button" class="btn btn-sm btn-outline-secondary" onclick="Forwardemail(this)"><i class="mdi mdi-share text-primary"></i>Forward</button>                                   ' +
    '                                            </div>                                                                                                                                                          ' +
    '                                            <div class="btn-group">                                                                                                                                         ' +
  //  '                                                <button type="button" class="btn btn-sm btn-outline-secondary"><i class="mdi mdi-attachment text-primary"></i>Attach</button>                               ' +
    '                                                <button type="button" class="btn btn-sm btn-outline-secondary" onclick=\'DeleteDraftMail("' + uid + '");\'><i class="mdi mdi-delete text-primary"></i>Delete</button>                                   ' +
    '                                            </div>                                                                                                                                                          ' +
    '                                            <div class="inf_inbx">                                                                                                                                          ' +
    '                                                <i class="mdi mdi-label"></i>                                                                                                                               ' +
    '                                                <span>Draft                                                                                                                                                 ' +
    '                                                </span>                                                                                                                                                     ' +
    '                                            </div>                                                                                                                                                          ' +
    '                                        </div>                                                                                                                                                              ' +
    '                                    </div>                                                                                                                                                                  ' +
    '                                </div>                                                                                                                                                                      ' +
    '                                <div class="message-body">                                                                                                                                                  ' +
    '                                                 <div class="msgs_container inboxscroll">                                                                                                                   ' +
    '                                    <div class="sender-details">                                                                                                                                            ' +
    '                                        <img class="img-sm rounded-circle mr-3" alt="" src="images/userprofile.png" />                                                                                      ' +
    '                                                                                                                                                                                                            ' +
    '                                        <div class="details">                                                                                                                                               ' +
    ' <p class="msg-date">' + mdate + ' </p>' +
    '                                            <p class="msg-subject fw600 inboxsub">                                                                                                                                   ' +
    '                                                ' + Subject + '                                                                                                       ' +
    '                </p>        </br>                                                                                                                                                                                ' +
    '                <p class="sender-email fw600">                                                                                                                                                              ' +
    '                                                                                                                                                                                          ' +
    '<a href="#" class="inboxfromaddress">' + Tos + '</a>                                                                                                                                                                     ' +
        '<a style="display:none" href="#" class="inboxccmails">' + ccmails + '</a>                                                                                                                                                                     ' +
                '<a style="display:none" href="#" class="inboxbccmails">' + bccmails + '</a>                                                                                                                                                                     ' +
               '<a style="display:none" href="#" class="inboxreplyallmails">' + replyallmails + '</a>                                                                                                                                                                     ' +
  '                        &nbsp;<div class="dropdown drp_icon_Cc"><i class="dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"></i>                                                                                                                                 ' +
   //    '    <div class="dropdown-menu dropmenu_ccbox" aria-labelledby="dropdownMenuLink"><a class="dropdown-item " href="#"><span class="col-sm-3 mail_cc_option_left">From :</span><p class="col-sm-9 mail_cc_option_right"><span class="frm_name">Sagar</span><span class="frm_email">sagargupta091@gmail.com</span></p></a><a class="dropdown-item" href="#"><span class="col-sm-3 mail_cc_option_left">To :</span><p class="col-sm-9 mail_cc_option_right"><span><span class="to_name">sindhu</span><span class="frm_email">sindhu09@gmail.com</span></span></br><span><span class="to_name">sindhu</span><span class="frm_email">sindhu09@gmail.com</span></span></p></a></div></div>                                                       ' +
        '    <div class="dropdown-menu dropmenu_ccbox" aria-labelledby="dropdownMenuLink">' + ccbcclist + '</div></div>                                                       ' +
    '                    </p>                                                                                                                                                                                    ' +
    '                </div>                                                                                                                                                                                      ' +
    '            </div>                                                                                                                                                                                          ' +
    '            <div class="message-content inboxbody">                                                                                                                                                                   ' +
    '                ' + Body + '                                                                                                                                                                                       ' +
     '            </div><div class="file-attachted inboxattach">' + Attach + '                                                                                                                                                                                         ' +
    '            </div>   </div>                                                                                                                                                                                       ' +
    '           <div class="footerbox_main">                                                                                                                                                                      ' +
    '      <div class="btn-group snt-mail Draft_send_btn" onclick="DraftToComp();"><button type="button" class="btn btn-success btn-sm mobpd4" id="send"><i class="mdi mdi-send"></i>Send</button></div>                                                                                                                                                                                      ' +
    '                               </div>                                                                                                                                                                         ' +
    '                               </div>                                                                                                                                                                         ' +
    //'            <div class="attachments-sections">                                                                                                                                                              ' +
    //'                <ul>                                                                                                                                                                                        ' +
    //'                    <li>                                                                                                                                                                                    ' +
    //'                        <div class="thumb"><i class="mdi mdi-file-pdf"></i></div>                                                                                                                           ' +
    //'                        <div class="details">                                                                                                                                                               ' +
    //'                            <p class="file-name">Seminar Reports.pdf</p>                                                                                                                                    ' +
    //'                            <div class="buttons">                                                                                                                                                           ' +
    //'                                <p class="file-size">678Kb</p>                                                                                                                                              ' +
    //'                                <a href="#" class="view">View</a>                                                                                                                                           ' +
    //'                                <a href="#" class="download">Download</a>                                                                                                                                   ' +
    //'                            </div>                                                                                                                                                                          ' +
    //'                        </div>                                                                                                                                                                              ' +
    //'                    </li>                                                                                                                                                                                   ' +
    //'                    <li>                                                                                                                                                                                    ' +
    //'                        <div class="thumb"><i class="mdi mdi-file-image"></i></div>                                                                                                                         ' +
    //'                        <div class="details">                                                                                                                                                               ' +
    //'                            <p class="file-name">Product Design.jpg</p>                                                                                                                                     ' +
    //'                            <div class="buttons">                                                                                                                                                           ' +
    //'                                <p class="file-size">1.96Mb</p>                                                                                                                                             ' +
    //'                                <a href="#" class="view">View</a>                                                                                                                                           ' +
    //'                                <a href="#" class="download">Download</a>                                                                                                                                   ' +
    //'                            </div>                                                                                                                                                                          ' +
    //'                        </div>                                                                                                                                                                              ' +
    //'                    </li>                                                                                                                                                                                   ' +
    //'                </ul>                                                                                                                                                                                       ' +
    //'            </div>                                                                                                                                                                                          ' +
    '        </div>');

            }

            function SendEmaildetails(dis) {

                $(".mail-list").removeClass("new_mail");

                $(dis).find(".mail-list").addClass("new_mail");

                var width = $(window).width();

                if (width < 768) {
                    $(".mob_contnrinboxlist").css('margin-left', '-100%');
                    $(".mob_contnr-inbox").css('margin-left', '0');

                }


                var Subject = $(dis).find('.mysub').html();
                var uid = $(dis).find('.uid').html();
                var mdate = $(dis).find('.maildate').html();
                var ccmails = $(dis).find('.ccmails').html();
                var bccmails = $(dis).find('.bccmails').html();
                var replyallmails = $(dis).find('.replyallmails').html();
                if (Subject == "" || Subject == null) {
                    Subject = "No Subject";
                }
                var Attach = $(dis).find('.myattach').html();
                var Headers = $(dis).find('.nwinb_mailcont').text();
                var Body = $(dis).find('.nwinb_chkbox').find('.thisemailbody').html();

                //var Body = "Kreyon Systems\r\n\r\nSign-in attempt was blocked\r\nkreyonsoftwares@gmail.com\r\nSomeone just used your password to try to sign in to your account. Google\r\nblocked them, but you should check what happened.\r\n\r\n\r\n\r\nCheck activity\r\n<https://accounts.google.com/AccountChooser?Email=kreyonsoftwares@gmail.com&continue=https://myaccount.google.com/alert/nt/1542188152000?rfn%3D6%26rfnc%3D1%26eid%3D7076505028597882858%26et%3D0%26asae%3D2%26anexp%3Dgivab-fa>\r\n<https://accounts.google.com/AccountChooser?Email=kreyonsoftwares@gmail.com&continue=https://myaccount.google.com/alert/nt/1542188152000?rfn%3D6%26rfnc%3D1%26eid%3D7076505028597882858%26et%3D0%26asae%3D2%26anexp%3Dgivab-fa>\r\n\r\n\r\nYou received this email to let you know about important changes to your\r\nGoogle Account and services.\r\n?? 2018 Google LLC,1600 Amphitheatre Parkway, Mountain View, CA 94043, USA\r\n1542188152000000\r\n";

                var Tos = $(dis).find(".mytos").text();
                var str = "";

                //////////////Details/////////////////////////////////////////////////////////////////////////////////////
                if (Body == "" || Body == null) {
                    Body = "No Details";
                }

                var splitto = Tos.split(",");
                var splitcc = ccmails.split(",");
                var bccsplit = bccmails.split(",");
                var splitreplyall = replyallmails.split(",");
                var ccbcclist = '<a class="dropdown-item" href="#"><span class="col-sm-2 col-2 mail_cc_option_left">To :</span><p class="col-sm-10 col-10 mail_cc_option_right">';

                for (var i = 0; i < splitto.length; i++) {

                    if (splitto[i] != "") {
                        ccbcclist += '<span><span class="frm_email">' + splitto[i] + '</span></span><br/>';
                    }
                }
                ccbcclist += '</p></a>';

                if (ccmails != "") {
                    ccbcclist += '<a class="dropdown-item" href="#"><span class="col-2 col-sm-2 col-md-3 col-lg-2  mail_cc_option_left">Cc :</span><p class="col-10 col-sm-10 col-md-9 col-lg-10 mail_cc_option_right">';
                    for (var i = 0; i < splitcc.length; i++) {
                        if (splitcc[i] != "") {
                            ccbcclist += '<span><span class="frm_email">' + splitcc[i] + '</span></span><br/>';
                        }
                    }
                    ccbcclist += '</p></a>';

                }

                if (bccmails != "") {
                    ccbcclist += '<a class="dropdown-item" href="#"><span class="col-2 col-sm-2 col-md-3 col-lg-2  mail_cc_option_left">Bcc :</span><p class="col-10 col-sm-10 col-md-9 col-lg-10 mail_cc_option_right">';
                    for (var i = 0; i < bccsplit.length; i++) {
                        if (bccsplit[i] != "") {
                            ccbcclist += '<span><span class="frm_email">' + bccsplit[i] + '</span></span><br/>';
                        }
                    }

                    ccbcclist += '</p></a>';
                }

                var replyalldiv = "";
                if (splitreplyall.length > 2) {
                    replyalldiv = '<button type="button" class="btn btn-sm btn-outline-secondary" onclick="ReplyAllemail(this)"><i class="mdi mdi-reply-all text-primary"></i>Reply All</button> '
                }
                $("#detail").html(' <div class="row">' +
    '                                    <div class="col-md-12 mb-4 mt-4 tab_tp_btm10">                                                                                                                          ' +
     '                                                <button type="button" class="btn btn-sm btn-secondary btn-backmob" onclick="closedetail()"><i class="mdi mdi-arrow-left"></i>Back</button>                                                    ' +
    '                                        <div class="btn-toolbar">                                                                                                                                           ' +
    '                                            <div class="btn-group tab-mrgnbtm5">                                                                                                                            ' +
    '                                                <button type="button" class="btn btn-sm btn-outline-secondary" onclick="Replyemail(this)"><i class="mdi mdi-reply text-primary"></i>Reply</button>                                     ' +
    '                                                '+replyalldiv+
    '                                                <button type="button" class="btn btn-sm btn-outline-secondary" onclick="Forwardemail(this)"><i class="mdi mdi-share text-primary"></i>Forward</button>                                   ' +
    '                                            </div>                                                                                                                                                          ' +
    '                                            <div class="btn-group">                                                                                                                                         ' +
  //  '                                                <button type="button" class="btn btn-sm btn-outline-secondary"><i class="mdi mdi-attachment text-primary"></i>Attach</button>                               ' +
    '                                                <button type="button" class="btn btn-sm btn-outline-secondary" onclick=\'DeleteSentMail("' + uid + '");\'><i class="mdi mdi-delete text-primary"></i>Delete</button>                                   ' +
    '                                            </div>                                                                                                                                                          ' +
    '                                            <div class="inf_inbx">                                                                                                                                          ' +
    '                                                <i class="mdi mdi-label"></i>                                                                                                                               ' +
    '                                                <span>Sent                                                                                                                                                 ' +
    '                                                </span>                                                                                                                                                     ' +
    '                                            </div>                                                                                                                                                          ' +
    '                                        </div>                                                                                                                                                              ' +
    '                                    </div>                                                                                                                                                                  ' +
    '                                </div>                                                                                                                                                                      ' +
    '                                <div class="message-body">                                                                                                                                                  ' +
    '                                           <div class="msgs_container inboxscroll">                                                                                                                         ' +
    '                                    <div class="sender-details">                                                                                                                                            ' +
    '                                        <img class="img-sm rounded-circle mr-3" alt="" src="images/userprofile.png" />                                                                                      ' +
    '                                                                                                                                                                                                            ' +
    '                                        <div class="details">                                                                                                                                               ' +
    ' <p class="msg-date">' + mdate + ' </p>' +
    '                                            <p class="msg-subject fw600 inboxsub">                                                                                                                                   ' +
    '                                                ' + Subject + '                                                                                                       ' +
    '                </p>    </br>                                                                                                                                                                                    ' +
    '                <p class="sender-email fw600">                                                                                                                                                              ' +
    '                                                                                                                                                                                          ' +
    '<a href="#" class="inboxfromaddress">' + Tos + '</a>                                                                                                                                                                     ' +
  '                        &nbsp;<a style="display:none" href="#" class="inboxreplyallmails">' + replyallmails + '</a><div class="dropdown drp_icon_Cc"><i class="dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"></i>                                                                                                                                 ' +
   //    '    <div class="dropdown-menu dropmenu_ccbox" aria-labelledby="dropdownMenuLink"><a class="dropdown-item " href="#"><span class="col-sm-3 mail_cc_option_left">From :</span><p class="col-sm-9 mail_cc_option_right"><span class="frm_name">Sagar</span><span class="frm_email">sagargupta091@gmail.com</span></p></a><a class="dropdown-item" href="#"><span class="col-sm-3 mail_cc_option_left">To :</span><p class="col-sm-9 mail_cc_option_right"><span><span class="to_name">sindhu</span><span class="frm_email">sindhu09@gmail.com</span></span></br><span><span class="to_name">sindhu</span><span class="frm_email">sindhu09@gmail.com</span></span></p></a></div></div>                                                       ' +
        '    <div class="dropdown-menu dropmenu_ccbox" aria-labelledby="dropdownMenuLink">' + ccbcclist + '</div></div>                                                       ' +
    '                    </p>                                                                                                                                                                                    ' +
    '                </div>                                                                                                                                                                                      ' +
    '            </div>                                                                                                                                                                                          ' +
    '            <div class="message-content inboxbody">                                                                                                                                                                   ' +
    '                ' + Body + '                                                                                                                                                                                       ' +
    '            </div><div class="file-attachted">' + Attach + '                                                                                                                                                                                         ' +
    '                       </div></div>                                                                                                                                                                                 ' +
    //'            <div class="attachments-sections">                                                                                                                                                              ' +
    //'                <ul>                                                                                                                                                                                        ' +
    //'                    <li>                                                                                                                                                                                    ' +
    //'                        <div class="thumb"><i class="mdi mdi-file-pdf"></i></div>                                                                                                                           ' +
    //'                        <div class="details">                                                                                                                                                               ' +
    //'                            <p class="file-name">Seminar Reports.pdf</p>                                                                                                                                    ' +
    //'                            <div class="buttons">                                                                                                                                                           ' +
    //'                                <p class="file-size">678Kb</p>                                                                                                                                              ' +
    //'                                <a href="#" class="view">View</a>                                                                                                                                           ' +
    //'                                <a href="#" class="download">Download</a>                                                                                                                                   ' +
    //'                            </div>                                                                                                                                                                          ' +
    //'                        </div>                                                                                                                                                                              ' +
    //'                    </li>                                                                                                                                                                                   ' +
    //'                    <li>                                                                                                                                                                                    ' +
    //'                        <div class="thumb"><i class="mdi mdi-file-image"></i></div>                                                                                                                         ' +
    //'                        <div class="details">                                                                                                                                                               ' +
    //'                            <p class="file-name">Product Design.jpg</p>                                                                                                                                     ' +
    //'                            <div class="buttons">                                                                                                                                                           ' +
    //'                                <p class="file-size">1.96Mb</p>                                                                                                                                             ' +
    //'                                <a href="#" class="view">View</a>                                                                                                                                           ' +
    //'                                <a href="#" class="download">Download</a>                                                                                                                                   ' +
    //'                            </div>                                                                                                                                                                          ' +
    //'                        </div>                                                                                                                                                                              ' +
    //'                    </li>                                                                                                                                                                                   ' +
    //'                </ul>                                                                                                                                                                                       ' +
    //'            </div>                                                                                                                                                                                          ' +
    '        </div>');

            }

            function OutboxEmaildetails(dis) {

                $(".mail-list").removeClass("new_mail");

                $(dis).find(".mail-list").addClass("new_mail");

                var width = $(window).width();

                if (width < 768) {
                    $(".mob_contnrinboxlist").css('margin-left', '-100%');
                    $(".mob_contnr-inbox").css('margin-left', '0');

                }

                var Subject = $(dis).find('.mysub').html();
                var uid = $(dis).find('.uid').html();
                var mdate = $(dis).find('.maildate').html();
                if (Subject == "" || Subject == null) {
                    Subject = "No Subject";
                }
                var Headers = $(dis).find('.nwinb_mailcont').text();
                var Body = $(dis).find('.nwinb_chkbox').find('.thisemailbody').html();

                //var Body = "Kreyon Systems\r\n\r\nSign-in attempt was blocked\r\nkreyonsoftwares@gmail.com\r\nSomeone just used your password to try to sign in to your account. Google\r\nblocked them, but you should check what happened.\r\n\r\n\r\n\r\nCheck activity\r\n<https://accounts.google.com/AccountChooser?Email=kreyonsoftwares@gmail.com&continue=https://myaccount.google.com/alert/nt/1542188152000?rfn%3D6%26rfnc%3D1%26eid%3D7076505028597882858%26et%3D0%26asae%3D2%26anexp%3Dgivab-fa>\r\n<https://accounts.google.com/AccountChooser?Email=kreyonsoftwares@gmail.com&continue=https://myaccount.google.com/alert/nt/1542188152000?rfn%3D6%26rfnc%3D1%26eid%3D7076505028597882858%26et%3D0%26asae%3D2%26anexp%3Dgivab-fa>\r\n\r\n\r\nYou received this email to let you know about important changes to your\r\nGoogle Account and services.\r\n?? 2018 Google LLC,1600 Amphitheatre Parkway, Mountain View, CA 94043, USA\r\n1542188152000000\r\n";

                var Tos = $(dis).find(".mytos").text();
                var str = "";

                //////////////Details/////////////////////////////////////////////////////////////////////////////////////
                if (Body == "" || Body == null) {
                    Body = "No Details";
                }





                $("#detail").html(' <div class="row">' +
    '                                    <div class="col-md-12 mb-4 mt-4 tab_tp_btm10">                                                                                                                          ' +
     '                                                <button type="button" class="btn btn-sm btn-secondary btn-backmob"  onclick="closedetail()"><i class="mdi mdi-arrow-left"></i>Back</button>                                                    ' +
    '                                        <div class="btn-toolbar">                                                                                                                                           ' +
    '                                            <div class="btn-group tab-mrgnbtm5" style="display:none">                                                                                                                            ' +
    '                                                <button type="button" class="btn btn-sm btn-outline-secondary"><i class="mdi mdi-reply text-primary"></i>Reply</button>                                     ' +
    '                                                <button type="button" class="btn btn-sm btn-outline-secondary"><i class="mdi mdi-reply-all text-primary"></i>Reply All</button>                             ' +
    '                                                <button type="button" class="btn btn-sm btn-outline-secondary"><i class="mdi mdi-share text-primary"></i>Forward</button>                                   ' +
    '                                            </div>                                                                                                                                                          ' +
    '                                            <div class="btn-group">                                                                                                                                         ' +
  //  '                                                <button type="button" class="btn btn-sm btn-outline-secondary"><i class="mdi mdi-attachment text-primary"></i>Attach</button>                               ' +
    '                                                <button type="button" class="btn btn-sm btn-outline-secondary" onclick=\'DeleteOutboxMail("' + uid + '");\'><i class="mdi mdi-delete text-primary"></i>Delete</button>                                   ' +
    '                                            </div>                                                                                                                                                          ' +
    '                                            <div class="inf_inbx">                                                                                                                                          ' +
    '                                                <i class="mdi mdi-label"></i>                                                                                                                               ' +
    '                                                <span>Outbox                                                                                                                                                 ' +
    '                                                </span>                                                                                                                                                     ' +
    '                                            </div>                                                                                                                                                          ' +
    '                                        </div>                                                                                                                                                              ' +
    '                                    </div>                                                                                                                                                                  ' +
    '                                </div>                                                                                                                                                                      ' +
    '                                <div class="message-body">                                                                                                                                                  ' +
    '                                                   <div class="msgs_container inboxscroll">                                                                                                                 ' +
    '                                    <div class="sender-details">                                                                                                                                            ' +
    '                                        <img class="img-sm rounded-circle mr-3" alt="" src="images/userprofile.png" />                                                                                      ' +
    '                                                                                                                                                                                                            ' +
    '                                        <div class="details">                                                                                                                                               ' +
   ' <p class="msg-date">' + mdate + ' </p>' +
    '                                            <p class="msg-subject fw600">                                                                                                                                   ' +
    '                                                ' + Subject + '                                                                                                       ' +
    '                </p>     </br>                                                                                                                                                                                   ' +
    '                <p class="sender-email fw600">                                                                                                                                                              ' +
    '                                                                                                                                                                                          ' +
    '<a href="#">' + Tos + '</a>                                                                                                                                                                     ' +
    '                        &nbsp;<i class="mdi mdi-account-multiple-plus"></i>                                                                                                                                 ' +
    '                    </p>                                                                                                                                                                                    ' +
    '                </div>                                                                                                                                                                                      ' +
    '            </div>                                                                                                                                                                                          ' +
    '            <div class="message-content">                                                                                                                                                                   ' +
    '                ' + Body + '                                                                                                                                                                                       ' +
    '            </div>                                                                                                                                                                                          ' +
    '                    </div>                                                                                                                                                                                    ' +
    //'            <div class="attachments-sections">                                                                                                                                                              ' +
    //'                <ul>                                                                                                                                                                                        ' +
    //'                    <li>                                                                                                                                                                                    ' +
    //'                        <div class="thumb"><i class="mdi mdi-file-pdf"></i></div>                                                                                                                           ' +
    //'                        <div class="details">                                                                                                                                                               ' +
    //'                            <p class="file-name">Seminar Reports.pdf</p>                                                                                                                                    ' +
    //'                            <div class="buttons">                                                                                                                                                           ' +
    //'                                <p class="file-size">678Kb</p>                                                                                                                                              ' +
    //'                                <a href="#" class="view">View</a>                                                                                                                                           ' +
    //'                                <a href="#" class="download">Download</a>                                                                                                                                   ' +
    //'                            </div>                                                                                                                                                                          ' +
    //'                        </div>                                                                                                                                                                              ' +
    //'                    </li>                                                                                                                                                                                   ' +
    //'                    <li>                                                                                                                                                                                    ' +
    //'                        <div class="thumb"><i class="mdi mdi-file-image"></i></div>                                                                                                                         ' +
    //'                        <div class="details">                                                                                                                                                               ' +
    //'                            <p class="file-name">Product Design.jpg</p>                                                                                                                                     ' +
    //'                            <div class="buttons">                                                                                                                                                           ' +
    //'                                <p class="file-size">1.96Mb</p>                                                                                                                                             ' +
    //'                                <a href="#" class="view">View</a>                                                                                                                                           ' +
    //'                                <a href="#" class="download">Download</a>                                                                                                                                   ' +
    //'                            </div>                                                                                                                                                                          ' +
    //'                        </div>                                                                                                                                                                              ' +
    //'                    </li>                                                                                                                                                                                   ' +
    //'                </ul>                                                                                                                                                                                       ' +
    //'            </div>                                                                                                                                                                                          ' +
    '        </div>');

            }

            function TrashEmaildetails(dis) {

                $(".mail-list").removeClass("new_mail");

                $(dis).find(".mail-list").addClass("new_mail");
                var ccmails = $(dis).find('.ccmails').html();
                var bccmails = $(dis).find('.bccmails').html();
                var width = $(window).width();

                if (width < 768) {
                    $(".mob_contnrinboxlist").css('margin-left', '-100%');
                    $(".mob_contnr-inbox").css('margin-left', '0');

                }

                var Subject = $(dis).find('.mysub').html();
                var uid = $(dis).find('.uid').html();
                var mdate = $(dis).find('.maildate').html();
                if (Subject == "" || Subject == null) {
                    Subject = "No Subject";
                }
                var Headers = $(dis).find('.nwinb_mailcont').text();
                var Body = $(dis).find('.nwinb_chkbox').find('.thisemailbody').html();

                //var Body = "Kreyon Systems\r\n\r\nSign-in attempt was blocked\r\nkreyonsoftwares@gmail.com\r\nSomeone just used your password to try to sign in to your account. Google\r\nblocked them, but you should check what happened.\r\n\r\n\r\n\r\nCheck activity\r\n<https://accounts.google.com/AccountChooser?Email=kreyonsoftwares@gmail.com&continue=https://myaccount.google.com/alert/nt/1542188152000?rfn%3D6%26rfnc%3D1%26eid%3D7076505028597882858%26et%3D0%26asae%3D2%26anexp%3Dgivab-fa>\r\n<https://accounts.google.com/AccountChooser?Email=kreyonsoftwares@gmail.com&continue=https://myaccount.google.com/alert/nt/1542188152000?rfn%3D6%26rfnc%3D1%26eid%3D7076505028597882858%26et%3D0%26asae%3D2%26anexp%3Dgivab-fa>\r\n\r\n\r\nYou received this email to let you know about important changes to your\r\nGoogle Account and services.\r\n?? 2018 Google LLC,1600 Amphitheatre Parkway, Mountain View, CA 94043, USA\r\n1542188152000000\r\n";

                var Tos = $(dis).find(".mytos").text();

                var splitto = Tos.split(",");
                var splitcc = ccmails.split(",");
                var bccsplit = bccmails.split(",");

                var str = "";

                //////////////Details/////////////////////////////////////////////////////////////////////////////////////
                if (Body == "" || Body == null) {
                    Body = "No Details";
                }

                var replyallmails = $(dis).find('.replyallmails').html();
                var splitreplyall = replyallmails.split(",");
                var replyalldiv = "";
                if (splitreplyall.length > 2) {
                    replyalldiv = '<button type="button" class="btn btn-sm btn-outline-secondary" onclick="ReplyAllemail(this)"><i class="mdi mdi-reply-all text-primary"></i>Reply All</button> '
                }

                var ccbcclist = '<a class="dropdown-item" href="#"><span class="col-sm-2 col-2 mail_cc_option_left">To :</span><p class="col-sm-10 col-10 mail_cc_option_right">';

                for (var i = 0; i < splitto.length; i++) {

                    if (splitto[i] != "") {
                        ccbcclist += '<span><span class="frm_email">' + splitto[i] + '</span></span><br/>';
                    }
                }
                ccbcclist += '</p></a>';

                if (ccmails != "") {
                    ccbcclist += '<a class="dropdown-item" href="#"><span class="col-sm-2 col-2 mail_cc_option_left">Cc :</span><p class="col-sm-10 col-10 mail_cc_option_right">';
                    for (var i = 0; i < splitcc.length; i++) {
                        if (splitcc[i] != "") {
                            ccbcclist += '<span><span class="frm_email">' + splitcc[i] + '</span></span><br/>';
                        }
                    }
                    ccbcclist += '</p></a>';

                }

                if (bccmails != "") {
                    ccbcclist += '<a class="dropdown-item" href="#"><span class="col-sm-2 col-2 mail_cc_option_left">Bcc :</span><p class="col-sm-10 col-10 mail_cc_option_right">';
                    for (var i = 0; i < bccsplit.length; i++) {
                        if (bccsplit[i] != "") {
                            ccbcclist += '<span><span class="frm_email">' + bccsplit[i] + '</span></span><br/>';
                        }
                    }

                    ccbcclist += '</p></a>';
                }

                $("#detail").html(' <div class="row">' +
    '                                    <div class="col-md-12 mb-4 mt-4 tab_tp_btm10">                                                                                                                          ' +
     '                                                <button type="button" class="btn btn-sm btn-secondary btn-backmob" onclick="closedetail()"><i class="mdi mdi-arrow-left"></i>Back</button>                                                    ' +
    '                                        <div class="btn-toolbar">                                                                                                                                           ' +
    '                                            <div class="btn-group tab-mrgnbtm5">                                                                                                                            ' +
    '                                                <button type="button" class="btn btn-sm btn-outline-secondary" onclick="Replyemail(this)"><i class="mdi mdi-reply text-primary"></i>Reply</button>                                     ' +
    '                                                '+replyalldiv+'  ' +
    '                                                <button type="button" class="btn btn-sm btn-outline-secondary" onclick="Forwardemail(this)"><i class="mdi mdi-share text-primary"></i>Forward</button>                                   ' +
    '                                            </div>                                                                                                                                                          ' +
    '                                            <div class="btn-group" >                                                                                                                                         ' +
  //  '                                                <button type="button" class="btn btn-sm btn-outline-secondary"><i class="mdi mdi-attachment text-primary"></i>Attach</button>                               ' +
    '                                                <button type="button" class="btn btn-sm btn-outline-secondary" onclick=\'Delettrashemail("' + uid + '");\'><i class="mdi mdi-delete text-primary"></i>Delete</button>                                   ' +
       '                                                <button type="button" class="btn btn-sm btn-outline-secondary" onclick=\'Restoretrashemail("' + uid + '");\'>Restore</button>                                   ' +
    '                                            </div>                                                                                                                                                          ' +
    '                                            <div class="inf_inbx">                                                                                                                                          ' +
    '                                                <i class="mdi mdi-label"></i>                                                                                                                               ' +
    '                                                <span>Trash                                                                                                                                                 ' +
    '                                                </span>                                                                                                                                                     ' +
    '                                            </div>                                                                                                                                                          ' +
    '                                        </div>                                                                                                                                                              ' +
    '                                    </div>                                                                                                                                                                  ' +
    '                                </div>                                                                                                                                                                      ' +
    '                                <div class="message-body">                                                                                                                                                  ' +
    '                                           <div class="msgs_container inboxscroll">                                                                                                                                  ' +
    '                                    <div class="sender-details">                                                                                                                                            ' +
    '                                        <img class="img-sm rounded-circle mr-3" alt="" src="images/userprofile.png" />                                                                                      ' +
    '                                                                                                                                                                                                            ' +
    '                                        <div class="details">                                                                                                                                               ' +
     ' <p class="msg-date">' + mdate + ' </p>' +
    '                                            <p class="msg-subject fw600 inboxsub">                                                                                                                                   ' +
    '                                                ' + Subject + '                                                                                                       ' +
    '                </p>        </br>                                                                                                                                                                                ' +
    '                <p class="sender-email fw600">                                                                                                                                                              ' +
    '                                                                                                                                                                                          ' +
    '<a href="#" class="inboxfromaddress" >' + Tos + '</a><a href="#" class="inboxreplyallmails" style="display:none">' + replyallmails + '</a><div class="dropdown drp_icon_Cc"><i class="dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"></i>                                                                                                                                 ' +
   //    '    <div class="dropdown-menu dropmenu_ccbox" aria-labelledby="dropdownMenuLink"><a class="dropdown-item " href="#"><span class="col-sm-3 mail_cc_option_left">From :</span><p class="col-sm-9 mail_cc_option_right"><span class="frm_name">Sagar</span><span class="frm_email">sagargupta091@gmail.com</span></p></a><a class="dropdown-item" href="#"><span class="col-sm-3 mail_cc_option_left">To :</span><p class="col-sm-9 mail_cc_option_right"><span><span class="to_name">sindhu</span><span class="frm_email">sindhu09@gmail.com</span></span></br><span><span class="to_name">sindhu</span><span class="frm_email">sindhu09@gmail.com</span></span></p></a></div></div>                                                       ' +
        '    <div class="dropdown-menu dropmenu_ccbox" aria-labelledby="dropdownMenuLink">' + ccbcclist + '</div></div>' +
   
    '                    </p>                                                                                                                                                                                    ' +
    '                </div>                                                                                                                                                                                      ' +
    '            </div>                                                                                                                                                                                          ' +
    '            <div class="message-content inboxbody">                                                                                                                                                                   ' +
    '                ' + Body + '                                                                                                                                                                                       ' +
    '            </div>                                                                                                                                                                                          ' +
    '                    </div>                  ' +
    //'            <div class="attachments-sections">                                                                                                                                                              ' +
    //'                <ul>                                                                                                                                                                                        ' +
    //'                    <li>                                                                                                                                                                                    ' +
    //'                        <div class="thumb"><i class="mdi mdi-file-pdf"></i></div>                                                                                                                           ' +
    //'                        <div class="details">                                                                                                                                                               ' +
    //'                            <p class="file-name">Seminar Reports.pdf</p>                                                                                                                                    ' +
    //'                            <div class="buttons">                                                                                                                                                           ' +
    //'                                <p class="file-size">678Kb</p>                                                                                                                                              ' +
    //'                                <a href="#" class="view">View</a>                                                                                                                                           ' +
    //'                                <a href="#" class="download">Download</a>                                                                                                                                   ' +
    //'                            </div>                                                                                                                                                                          ' +
    //'                        </div>                                                                                                                                                                              ' +
    //'                    </li>                                                                                                                                                                                   ' +
    //'                    <li>                                                                                                                                                                                    ' +
    //'                        <div class="thumb"><i class="mdi mdi-file-image"></i></div>                                                                                                                         ' +
    //'                        <div class="details">                                                                                                                                                               ' +
    //'                            <p class="file-name">Product Design.jpg</p>                                                                                                                                     ' +
    //'                            <div class="buttons">                                                                                                                                                           ' +
    //'                                <p class="file-size">1.96Mb</p>                                                                                                                                             ' +
    //'                                <a href="#" class="view">View</a>                                                                                                                                           ' +
    //'                                <a href="#" class="download">Download</a>                                                                                                                                   ' +
    //'                            </div>                                                                                                                                                                          ' +
    //'                        </div>                                                                                                                                                                              ' +
    //'                    </li>                                                                                                                                                                                   ' +
    //'                </ul>                                                                                                                                                                                       ' +
    //'            </div>                                                                                                                                                                                          ' +
    '        </div>');

            }


            function Deletemail(deleteid) {

                if (deleteid == "") {
                    Message({ 'Msg': 'We can not delete this email', 'Type': msg_Error });
                    return false;
                }

                var body = $(".inboxbody").html();
                var from = $(".inboxfromaddress").html();
                var subject = $(".inboxsub").html().trim();
                var CCmails = $(".inboxccmails").html().trim();
                var Bccmail = $(".inboxbccmails").html().trim();
                var Replyallmail = $(".inboxreplyallmails").html().trim();
                var SystemTimeZone = Timezone();
                PageMethods.DeleteMail(deleteid, from, subject, body, SystemTimeZone,CCmails,Bccmail, function OnSuccessInserEmailTamplate(data) {
                    if (data == "done") {
                        Message({
                            'Msg': 'Mail successfully moved to Trash', 'Type': msg_Success, 'Event1': function () {
                                window.location.href = "Default.aspx";
                            }
                        });
                    }
                });

            }


            function draft() {


                var toemail = $("#toemail").val();
                var sub = $("#subject").val();
                var body = $(".Editor-editor").html();
                var cc = $("#cc-input-tags").val();
                var bcc = $("#bcc-input-tags").val();

                if (toemail == "" && sub == "" && body == "<br><br>" && cc == "" && bcc == "") {
                    $("#compose").hide();
                    $("#inbox").show();
                    return false;
                }

                var systemTimeZone = Timezone();
                PageMethods.Draftmail(toemail, body, sub, cc, bcc, systemTimeZone, picname, function (response) {
                    if (response == "done") {

                        Message({ 'Msg': 'Mail successfully saved as a draft', 'Type': msg_Success });

                        GetTabsCount('<%=StaticKeywordClass.Draft %>');

                        $("#toemail").val("");
                        $("#subject").val("");
                        $('#toemail').selectize()[0].selectize.clearOptions();
                        $('#cc-input-tags').selectize()[0].selectize.clearOptions();
                        $('#bcc-input-tags').selectize()[0].selectize.clearOptions();
                        $(".Editor-editor").empty();
                        $("#attach").empty();
                        $('#File1').val('');
                        $("#compose").hide();
                        $("#inbox").show();
                    }

                    else {
                        Message({ 'Msg': 'Mail did not save this time. Please try again later', 'Type': msg_Error });
                    }
                }, function (error) {
                    Message({ 'Msg': 'Mail did not save this time. Please try again later', 'Type': msg_Error });
                });
            }

            function ReplyAllemail(that) {
                $('#CM_Cc_Row').slideUp(300);
                $('#CM_Bcc_Row').slideUp(300);
                $(".cc").show();
                $(".bcc").show();
                $("#toemail").val("");
                $("#cc-input-tags").val("");
                $("#bcc-input-tags").val("");
                $("#subject").val("");
                $("#draftmail").parent().find(".Editor-editor").empty();
                $("#attach").empty();
                $('#File1').val('');
                $('#toemail').selectize()[0].selectize.clearOptions();
                $('#cc-input-tags').selectize()[0].selectize.clearOptions();
                $('#bcc-input-tags').selectize()[0].selectize.clearOptions();
                $("#compose").show();
                $("#inbox").hide();
                $("#inboxli").removeClass("active");
                $("#trashli").removeClass("active");
                $("#draftli").removeClass("active");
                $("#sendboxli").removeClass("active");
                $("#outboxli").removeClass("active");
                var body = $(".inboxbody").html();
                var from = $(".inboxreplyallmails").html();
                var subject = $(".inboxsub").html().trim();

                var sign = "";

                var checkcom = $("#isreplyall").val();
                if (checkcom == "True") {
                    sign = $("#signa").val();



                }


                var myreplyhtml = "";
                try {
                    myreplyhtml += '<br/><br/><br/>';
                    myreplyhtml += sign;
                    myreplyhtml += '<b>Subject:</b> Re: ' + subject + "<br/>";

                    myreplyhtml += '<b>To:</b> ' + from;

                    myreplyhtml += '<br/><br/>';
                    myreplyhtml += body;


                } catch (e) { }


                var $select = $("#toemail").selectize();
                var selectize = $select[0].selectize;
                selectize.addOption({ text:from, value: from });
                selectize.setValue(from);
                
                $("#subject").val(subject);
                $("#draftmail").parent().find(".Editor-editor").html(myreplyhtml);
                $("#cc-input-tags").val();
                $("#bcc-input-tags").val();

                // $('#toemail').selectize()[0].selectize.clearOptions();
                //  $('#cc-input-tags').selectize()[0].selectize.clearOptions();
                //  $('#bcc-input-tags').selectize()[0].selectize.clearOptions();

            }

            function Replyemail(that) {

                $('#CM_Cc_Row').slideUp(300);
                $('#CM_Bcc_Row').slideUp(300);
                $(".cc").show();
                $(".bcc").show();
                $("#toemail").val("");
                $("#cc-input-tags").val("");
                $("#bcc-input-tags").val("");
                $("#subject").val("");
                $("#draftmail").parent().find(".Editor-editor").empty();
                $("#attach").empty();
                $('#File1').val('');
                $('#toemail').selectize()[0].selectize.clearOptions();
                $('#cc-input-tags').selectize()[0].selectize.clearOptions();
                $('#bcc-input-tags').selectize()[0].selectize.clearOptions();
                $("#compose").show();
                $("#inbox").hide();
                $("#inboxli").removeClass("active");
                $("#trashli").removeClass("active");
                $("#draftli").removeClass("active");
                $("#sendboxli").removeClass("active");
                $("#outboxli").removeClass("active");
                var body = $(".inboxbody").html();
                var from = $(".inboxfromaddress").html();
                var subject = $(".inboxsub").html().trim();


                var sign = "";

                var checkcom = $("#isreply").val();
                if (checkcom == "True") {
                    sign = $("#signa").val();



                }


                var myreplyhtml = "";
                try {
                    myreplyhtml += '<br/><br/><br/>';
                    myreplyhtml += sign;
                    myreplyhtml += '<b>Subject:</b> Re: ' + subject + "<br/>";

                    myreplyhtml += '<b>To:</b> ' + from;

                    myreplyhtml += '<br/><br/>';
                    myreplyhtml += body;


                } catch (e) { }


               
                var $select = $("#toemail").selectize();
                var selectize = $select[0].selectize;
                $("#toemail").val(from);
                selectize.addOption({ text: from, value: from });
               
                selectize.setValue(from);
               // selectize.setValue(from,true);
               
                
                $("#subject").val("Re: " + subject);
                $("#draftmail").parent().find(".Editor-editor").html(myreplyhtml);
                $("#cc-input-tags").val();
                $("#bcc-input-tags").val();

                //$('#toemail').selectize()[0].selectize.destroy();
                //$('#cc-input-tags').selectize()[0].selectize.clearOptions();
                // $('#bcc-input-tags').selectize()[0].selectize.clearOptions();

            }

            function Forwardemail(that) {
                $('#CM_Cc_Row').slideUp(300);
                $('#CM_Bcc_Row').slideUp(300);
                $(".cc").show();
                $(".bcc").show();
                $("#toemail").val("");
                $("#cc-input-tags").val("");
                $("#bcc-input-tags").val("");
                $("#subject").val("");
                $("#draftmail").parent().find(".Editor-editor").empty();
                $("#attach").empty();
                $('#File1').val('');
                $('#toemail').selectize()[0].selectize.clearOptions();
                $('#cc-input-tags').selectize()[0].selectize.clearOptions();
                $('#bcc-input-tags').selectize()[0].selectize.clearOptions();
                $("#compose").show();
                $("#inbox").hide();
                $("#inboxli").removeClass("active");
                $("#trashli").removeClass("active");
                $("#draftli").removeClass("active");
                $("#sendboxli").removeClass("active");
                $("#outboxli").removeClass("active");
                var body = $(".inboxbody").html();
                var from = $(".inboxfromaddress").html();
                var subject = $(".inboxsub").html().trim();

                var sign = "";

                var checkcom = $("#isforward").val();
                if (checkcom == "True") {
                    sign = $("#signa").val();



                }

                var myreplyhtml = "";
                try {
                    myreplyhtml += '<br/><br/><br/>';
                    myreplyhtml += sign;
                    myreplyhtml += "<b>-------------------- Forwarded message --------------------</b><br/>";
                    myreplyhtml += '<b>Subject:</b> Re:' + subject + "<br/>";
                    // myreplyhtml += '<b>Sent on:</b> ' + $('#getdetaislfortime').text() + "<br/>";
                    myreplyhtml += '<b>To:</b> ' + from;
                    myreplyhtml += '<br/><br/>';
                    myreplyhtml += body;



                } catch (e) { }





                $("#subject").val("Re: " + subject);
                $("#draftmail").parent().find(".Editor-editor").html(myreplyhtml);
                $("#cc-input-tags").val();
                $("#bcc-input-tags").val();

                 $('#toemail').selectize()[0].selectize.clearOptions();
                 $('#cc-input-tags').selectize()[0].selectize.clearOptions();
                 $('#bcc-input-tags').selectize()[0].selectize.clearOptions();

            }

            function DraftToComp() {
                $('#CM_Cc_Row').slideUp(300);
                $('#CM_Bcc_Row').slideUp(300);
                $(".cc").show();
                $(".bcc").show();
                $("#toemail").val("");
                $("#cc-input-tags").val("");
                $("#bcc-input-tags").val("");
                $("#subject").val("");
                $(".Editor-editor").empty();
                $("#attach").empty();
                $('#File1').val('');
                $('#toemail').selectize()[0].selectize.clearOptions();
                $('#cc-input-tags').selectize()[0].selectize.clearOptions();
                $('#bcc-input-tags').selectize()[0].selectize.clearOptions();
                $("#compose").show();
                $("#inbox").hide();
                $("#inboxli").removeClass("active");
                $("#trashli").removeClass("active");
                $("#draftli").removeClass("active");
                $("#sendboxli").removeClass("active");
                $("#outboxli").removeClass("active");
                var body = $(".inboxbody").html();
                var from = $(".inboxfromaddress").html();
                var subject = $(".inboxsub").html().trim();
                var cc = $(".inboxccmails").html().trim();
                var bcc = $(".inboxbccmails").html().trim();
                var attach = $(".inboxattach").html().trim();

                var $select = $("#toemail").selectize();
                var selectize = $select[0].selectize;
                selectize.addOption({ text: from, value: from });
                selectize.setValue(from);
                $("#subject").val(subject);
                $(".Editor-editor").html(body);
                $("#cc-input-tags").val();
                $("#bcc-input-tags").val();

                if (bcc != "") {
                    $('#CM_Bcc_Row').slideDown(300);
                    var $select = $("#bcc-input-tags").selectize();
                    var selectize = $select[0].selectize;
                    selectize.addOption({ text: bcc, value: bcc });
                    selectize.setValue(bcc);
                }
                if (cc != "") {
                    $('#CM_Cc_Row').slideDown(300);
                    var $select = $("#cc-input-tags").selectize();
                    var selectize = $select[0].selectize;
                    selectize.addOption({ text: cc, value: cc });
                    selectize.setValue(cc);
                }
                if (attach != "") {
                    $("#attach").html(attach);
                }

                // $('#toemail').selectize()[0].selectize.clearOptions();
                //  $('#cc-input-tags').selectize()[0].selectize.clearOptions();
                //   $('#bcc-input-tags').selectize()[0].selectize.clearOptions();

            }

            function Delettrashemail(id) {

                PageMethods.DeleteTrashEmail(id, function (response) {

                    if (response == "done") {
                        Message({
                            'Msg': 'Mail Deleted successfully', 'Type': msg_Success, 'Event1': function () {
                                opentrash(1);
                                GetTabsCount('<%=StaticKeywordClass.Trash %>');
                            }
                        });
                    }
                    else if (response == "fail") {

                        Message({ 'Msg': 'Looks like we encountered an issue, please refresh the page', 'Type': msg_Error });
                    }

                    else if (response == "noid") {
                        Message({ 'Msg': 'Looks like we encountered an issue, please refresh the page', 'Type': msg_Error });
                    }
                    else if (response == "nocre") {

                        $("#detail").html("<div class='errormsgbox'>Please Enter Credentials</div>");

                        $("#loader").hide();
                    }

                }, function (error) {
                    Message({ 'Msg': 'Looks like we encountered an issue, please refresh the page', 'Type': msg_Error });
                });

            }

            function Restoretrashemail(id) {

                PageMethods.RestoreTrashEmail(id, function (response) {

                    if (response == "done") {
                        Message({
                            'Msg': 'Mail successfully Restored ', 'Type': msg_Success, 'Event1': function () {
                                opentrash(1);
                                GetTabsCount('<%=StaticKeywordClass.Trash %>');
                                GetTabsCount('<%=StaticKeywordClass.Draft %>');
                                GetTabsCount('<%=StaticKeywordClass.Outbox %>');
                                GetTabsCount('<%=StaticKeywordClass.Sent %>');
                            }
                        });
                    }
                    else if (response == "fail") {

                        Message({ 'Msg': 'Looks like we encountered an issue, please refresh the page', 'Type': msg_Error });
                    }



                }, function (error) {
                    Message({ 'Msg': 'Looks like we encountered an issue, please refresh the page', 'Type': msg_Error });
                });

            }

            function SaveStar(that, labeltype, id) {



                PageMethods.StarredSave(id, labeltype, function (response) {
                    if (response == "done") {
                        $(that).html('<i class="mdi mdi-star favorite"></i>');
                        $(that).attr('onclick', 'RemoveStar(this,\"' + labeltype + '","' + id + '"\)');
                        GetTabsCount('<%=StaticKeywordClass.Starred %>');
                        // $(that).attr('onclick', 'RemoveStar(\"' + id + '\",\"' + $(that) + '"\")');
                    }


                }, function (error) {


                });


            }

            function RemoveStar(that, labeltype, id) {

                $(that).html('<i class="mdi mdi-star-outline"></i>');
                $(that).attr('onclick', 'SaveStar(this,\"' + labeltype + '","' + id + '"\)');

                PageMethods.RemoveStarEmail(id, function (response) {
                    if (response == "done") {
                        GetTabsCount('<%=StaticKeywordClass.Starred %>');

                    }


                }, function (error) {


                });


            }


            function staroutbox(PageClick) {



                if ($('#slide-menu').hasClass('left-menu-open')) {
                    $('#slide-menu').removeClass('left-menu-open');
                    $('.mobilebg').fadeOut(300);
                }
                $("#headtag").html("Starred");


                ShowHideSearchDiv("Star");
                $("#loader").show();
                $("#inbox").show();
                $("#paginationdiv").hide();
                $("#inboxli").removeClass("active");
                $("#starli").addClass("active");
                $("#trashli").removeClass("active");
                $("#draftli").removeClass("active");
                $("#sendboxli").removeClass("active");
                $("#outboxli").removeClass("active");
                $("#inboxlist").empty();
                $("#detail").empty();

                var search = $("#txtSearchDivstar").val();
                var SystemTimeZone = Timezone();
                PageMethods.OpenStarList(SystemTimeZone, search, PageClick, function (data) {
                    
                    $("#detail").empty();
                    var inboxdata = data.split("{*^*}");
                    var width = $(window).width();
                    if (inboxdata[3] == "done") {
                        $("#loader").hide();
                        // $("#count").html(inboxdata[0]);
                        $("#inboxlist").html(inboxdata[1]);



                        if (width >= 768) {
                            $("#first").click();
                        }
                        else {
                            closedetail();
                        }

                        if (inboxdata[2] > 1) {
                            $("#paginationdiv").show();
                        }
                        else {

                            $("#paginationdiv").hide();
                        }

                        

                        var PaginationString = '<li class="page-item"><a class="page-link" href="javascript:;"  onclick="GoToPrevSegment();"><span aria-hidden=\"true\">&laquo;</span></a></li>'

                        for (var i = 1; i <= Number(inboxdata[2]) ; i++) {

                            PaginationString += "<li " + (PageClick == i ? "class='currentuse active page-item'" : "class='currentuse page-item'") + "><a class='page-link' href='javascript:;'  Onclick='staroutbox(" + i + ");'>" + i + " " + (PageClick == i ? "<span class='sr-only'>(current)</span>" : "") + "</a></li>";
                        }

                        PaginationString += '<li class="page-item"><a class="page-link" href="javascript:;" onclick="GoToNextSegment();"><span aria-hidden=\"true\">&raquo;</span></a></li>'

                        $("#DivPager").html(PaginationString);
                            
                        //$("#defaultfooter").show();

                        // How many page will be visible SETTING
                        PaginationVisiblePages(PageClick);

                         


                        //$("#next").attr('onclick','inboxdata()');
                        //$("#prev").attr('onclick','inboxdata()');

                    }
                    else if (inboxdata[3] == "fail") {
                        $("#DivPager").empty();
                        $("#detail").html("<div class='errormsgbox'>Invalid Credentials</div>");
                        if (width >= 320 && width < 767) {
                            $("#inboxlist").html("<div class='errormsgbox'>Invalid Credentials</div>");
                        }
                        $("#loader").hide();
                    }

                    else if (inboxdata[3] == "norecord") {
                        $("#DivPager").empty();
                        $("#detail").html("<div class='errormsgbox'>Please Enter Credentials</div>");
                        if (width >= 320 && width < 767) {
                            $("#inboxlist").html("<div class='errormsgbox'>Please Enter Credentials</div>");
                        }
                        $("#loader").hide();
                    }
                    else if (inboxdata[3] == "nomessage") {
                        $("#DivPager").empty();
                        $("#count").html(inboxdata[0]);
                        $("#detail").html("<div class='errormsgbox'>No message Found</div>");
                        if (width >= 320 && width < 767) {
                            $("#inboxlist").html("<div class='errormsgbox'>No message Found</div>");
                        }
                        $("#loader").hide();
                    }

                }, function (error) {
                    $("#DivPager").empty();
                    $("#detail").html("<div class='errormsgbox'>Looks like we encountered an issue, Please refresh the page.</div>");
                    if (width >= 320 && width < 767) {
                        $("#inboxlist").html("<div class='errormsgbox'>No message Found</div>");
                    }
                    $("#loader").hide();

                });
            }

            function DeleteAllInbox() {

            }

            function AttachmentDowmload(data) {

                PageMethods.AttDownload(data, function (path) {


                    window.location.href = "AttachmentDownload.aspx?path=" + path;



                }, function (error) {

                });

            }

        </script>

        <script type="text/javascript">
            //$(document).ready(function () {
            //    $("#summernote").summernote({
            //        height: 200,
            //        popover: false,
            //        placeholder: 'Type your Message',

            //    });
            //});
            $(function () {
                $('#toemail, #cc-input-tags, #bcc-input-tags').selectize({
                    plugins: ['remove_button'],
                    delimiter: ',',
                    persist: false,
               
                    create: function (input) {
                       return {
                            value: input,
                            text: input
                        }
                    },
            
                });
                $("#txtEditor").Editor();
                $("#signatureditor").Editor();

                
                //$("#signatureditor").summernote({
                //    height: 200,
                //    popover: false,
                //    //placeholder:"aaaaaaaaaa"


                //});


                var signature = $("#signa").val();
                var reply = $("#isreply").val();
                var replyall = $("#isreplyall").val();
                var compose = $("#iscompose").val();
                var forward = $("#isforward").val();




                if (signature != "") {

                    $("input[class=includesig]").prop("checked", true);

                    $('#signaturedtrbox').slideDown(300);
                    $("#signatureditor").parent().find(".Editor-editor").html(signature);

                    if (reply == "True") {

                        $("input[class=rply]").prop("checked", true);

                    }
                    if (replyall == "True") {

                        $("input[class=rplyall]").prop("checked", true);

                    }
                    if (compose == "True") {

                        $("input[class=comp]").prop("checked", true);

                    }
                    if (forward == "True") {

                        $("input[class=frward]").prop("checked", true);

                    }


                }
                else {
                    $("input[name=sigtype]").prop("checked", true);
                }

                //  $("#signatureditor").next().find('.note-btn[aria-label="Picture"]').remove();
                $("#signatureditor").next().find('.note-btn[aria-label="Video"]').remove();
                $("#draftmail").Editor();
                $('.cc').click(function () {
                    $(this).hide();
                    $('#CM_Cc_Row').slideDown(300);
                });

                $('.bcc').click(function () {
                    $(this).hide();
                    $('#CM_Bcc_Row').slideDown(300);
                });

                $('.includesig').change(function () {



                    if ($("input[class='includesig']").prop("checked") == true) {




                        $('#signaturedtrbox').slideDown(300);
                    }
                    else {

                        $("#signatureditor").parent().find(".Editor-editor").empty();
                        //  $("input[name=sigtype]").prop("checked", false);

                        $('#signaturedtrbox').slideUp(300);

                    }


                });

            });



        </script>
        <script type="text/javascript">

            function DeleteDraftMail(ID) {

                try {

                    $("#loader").show();

                    PageMethods.DeleteDraftMail(ID, function OnSuccessInserEmailTamplate(data) {

                        $("#loader").hide();

                        if (data == "done") {
                            Message({
                                'Msg': 'Mail successfully moved to Trash ', 'Type': msg_Success, 'Event1': function () {
                                    showdraft(1);
                                    GetTabsCount('<%=StaticKeywordClass.Draft %>');
                                    GetTabsCount('<%=StaticKeywordClass.Trash %>');
                                }
                            });
                        }
                    });

                } catch (e) {

                }

            }

            function DeleteSentMail(ID) {

                try {

                    $("#loader").show();

                    PageMethods.DeleteSentMail(ID, function OnSuccessInserEmailTamplate(data) {

                        $("#loader").hide();

                        if (data == "done") {
                            Message({
                                'Msg': 'Mail successfully moved  to Trash ', 'Type': msg_Success, 'Event1': function () {
                                    opensendbox(1);
                                    GetTabsCount('<%=StaticKeywordClass.Sent %>');
                                    GetTabsCount('<%=StaticKeywordClass.Trash %>');
                                }
                            });
                        }
                    });

                } catch (e) {

                }

            }

            function DeleteOutboxMail(ID) {

                try {

                    $("#loader").show();

                    PageMethods.DeleteOutboxMail(ID, function OnSuccessInserEmailTamplate(data) {

                        $("#loader").hide();

                        if (data == "done") {
                            Message({
                                'Msg': 'Mail successfully moved to Trash ', 'Type': msg_Success, 'Event1': function () {
                                    openoutbox(1);
                                    GetTabsCount('<%=StaticKeywordClass.Outbox %>');
                                }
                            });
                        }
                    });

                } catch (e) {

                }

            }

            function GetTabsCount(TabType) {

                try {

                    PageMethods.GetTabsCount(TabType, function (data) {

                        if (TabType == '<%=StaticKeywordClass.Sent %>') {
                            $("#sendcount").html(data);
                        } else if (TabType == '<%=StaticKeywordClass.Draft %>') {
                            $("#draftcount").html(data);
                        } else if (TabType == '<%=StaticKeywordClass.Outbox %>') {
                            $("#outboxcount").html(data);
                        } else if (TabType == '<%=StaticKeywordClass.Starred %>') {
                            $("#starredcount").html(data);
                        } else if (TabType == '<%=StaticKeywordClass.Trash %>') {
                            $("#trashcount").html(data);
                        }
                    });

    } catch (e) {

    }

}
        </script>
        <script type="text/javascript">
            $(document).ready(function () {

                $("#menu-bar").click(function () {

                    if ($('#slide-menu').hasClass('left-menu-open')) {
                        $('#slide-menu').removeClass('left-menu-open');
                        $('.mobilebg').fadeOut(300);
                    }
                    else {
                        $('#slide-menu').addClass('left-menu-open');
                        $('.mobilebg').fadeIn(300);
                    }
                });
                $(".mobilebg").click(function () {
                    $(this).fadeOut(300);
                    $('#slide-menu').removeClass('left-menu-open');

                });
            });

        </script>

        <script type="text/javascript">

            $(document).ready(function () {

                $("#CheckboxHead").change(function () {
                    $('input[name="InboxcheckboxChild"]').prop("checked", $(this).prop("checked"));
                });

            });

            function InboxBulkDelete() {

                if (Number($('input[name="InboxcheckboxChild"]:checked').length) == 0) {
                    Message({ 'Msg': "Please select record first", 'Type': msg_Error });
                    return false;
                }

                var IDs = [];

                var TotalLength = $('input[name="InboxcheckboxChild"]:checked').length;

                $('input[name="InboxcheckboxChild"]:checked').each(function (index) {

                    var ID = $(this).val();
                    if (ID != "") {
                        IDs.push(ID);
                    }

                    var innercounter = index + 1;

                    if (TotalLength == innercounter) {

                        CallFinalDelete(IDs);
                    }
                });

            }

            var TemporaryCounter = 0;

            function CallFinalDelete(IDs) {

                var IDsArray = IDs;

                console.log(IDsArray);

                var TotalLength = IDsArray.length;

                var SystemTimeZone = Timezone();

                TemporaryCounter = 0;

                $("#loader").show();

                for (var i = 0; i < Number(IDs.length) ; i++) {

               
                    var DeleteID = IDsArray[i];
                  
                    var body = $.trim($('.nwinb_chkbox[data-inboxdelid="' + DeleteID + '"]').find(".thisemailbody").html());
                    var from = $.trim($('.nwinb_chkbox[data-inboxdelid="' + DeleteID + '"]').find(".fromad").html());
                    var subject = $.trim($('.nwinb_chkbox[data-inboxdelid="' + DeleteID + '"]').find(".mysub").html());
                    var CCmails = $.trim($('.nwinb_chkbox[data-inboxdelid="' + DeleteID + '"]').find(".ccmails").html());
                    var Bccmails = $.trim($('.nwinb_chkbox[data-inboxdelid="' + DeleteID + '"]').find(".bccmails").html());
                    console.log("DeleteID", DeleteID);
                    //console.log("body", body);
                    //console.log("from", from);
                    //console.log("subject", subject);

                    PageMethods.DeleteMail(DeleteID, from, subject, body, SystemTimeZone,CCmails,Bccmails, function (data) {

                        //console.log("Successfully Called", DeleteID);

                        //SUCCESS
                        CallAnotherOneOfTrail(i, TotalLength);

                    }, function (error) {

                        // FAILURE IN ANY CASE
                        CallAnotherOneOfTrail(i, TotalLength);
                    });

                }

            }

            function CallAnotherOneOfTrail(i, TotalLength) {

                TemporaryCounter++;

                //if (Number(TemporaryCounter) == Number(TotalLength)) {
                if (Number(i) == Number(TotalLength)) {

                    $("#loader").hide();

                    Message({
                        'Msg': 'Mails successfully moved to trash', 'Type': msg_Success, 'Event1': function () {
                            window.location.href = "Default.aspx";
                        }
                    });
                }
            }

        </script>
        <script type="text/javascript">

            // SENT DELETE
            $(document).ready(function () {

                $("#CheckboxHeadSent").change(function () {
                    $('input[name="SentcheckboxChild"]').prop("checked", $(this).prop("checked"));
                });

            });

            function SentBulkDelete() {

                if (Number($('input[name="SentcheckboxChild"]:checked').length) == 0) {
                    Message({ 'Msg': "Please select record first", 'Type': msg_Error });
                    return false;
                }

                var IDs = [];

                var TotalLength = $('input[name="SentcheckboxChild"]:checked').length;

                $('input[name="SentcheckboxChild"]:checked').each(function (index) {

                    var ID = $(this).val();
                    if (ID != "") {
                        IDs.push(ID);
                    }

                    var innercounter = index + 1;

                    if (TotalLength == innercounter) {

                        SentCallFinalDelete(IDs);
                    }
                });

            }

            var SentTemporaryCounter = 0;

            function SentCallFinalDelete(IDs) {

                var IDsArray = IDs;

                var TotalLength = IDsArray.length;

                var SystemTimeZone = Timezone();

                SentTemporaryCounter = 0;

                $("#loader").show();

                for (var i = 0; i < Number(IDs.length) ; i++) {

                    var DeleteID = IDsArray[i];

                    PageMethods.DeleteSentMail(Number(DeleteID), function (data) {

                        //SUCCESS
                        SentCallAnotherOneOfTrail(i, TotalLength);

                    }, function (error) {

                        // FAILURE IN ANY CASE
                        SentCallAnotherOneOfTrail(i, TotalLength);
                    });

                }

            }

            function SentCallAnotherOneOfTrail(i, TotalLength) {

                SentTemporaryCounter++;

                //if (Number(SentTemporaryCounter) == Number(TotalLength)) {
                if (Number(i) == Number(TotalLength)) {

                    $("#loader").hide();

                    Message({
                        'Msg': 'Mails moved to trash successfully', 'Type': msg_Success, 'Event1': function () {
                            opensendbox(1);
                            GetTabsCount('<%=StaticKeywordClass.Sent %>');
                            GetTabsCount('<%=StaticKeywordClass.Trash %>');
                        }
                    });
                }
            }

        </script>
        <script type="text/javascript">

            // DRAFT DELETE
            $(document).ready(function () {

                $("#CheckboxHeadDraft").change(function () {
                    $('input[name="DraftcheckboxChild"]').prop("checked", $(this).prop("checked"));
                });

            });

            function DraftBulkDelete() {

                if (Number($('input[name="DraftcheckboxChild"]:checked').length) == 0) {
                    Message({ 'Msg': "Please select record first", 'Type': msg_Error });
                    return false;
                }

                var IDs = [];

                var TotalLength = $('input[name="DraftcheckboxChild"]:checked').length;

                $('input[name="DraftcheckboxChild"]:checked').each(function (index) {

                    var ID = $(this).val();
                    if (ID != "") {
                        IDs.push(ID);
                    }

                    var innercounter = index + 1;

                    if (TotalLength == innercounter) {

                        DraftCallFinalDelete(IDs);
                    }
                });

            }

            var DraftTemporaryCounter = 0;

            function DraftCallFinalDelete(IDs) {

                var IDsArray = IDs;

                var TotalLength = IDsArray.length;

                var SystemTimeZone = Timezone();

                DraftTemporaryCounter = 0;

                $("#loader").show();

                for (var i = 0; i < Number(IDs.length) ; i++) {

                    var DeleteID = IDsArray[i];

                    PageMethods.DeleteDraftMail(Number(DeleteID), function (data) {

                        //SUCCESS
                        DraftCallAnotherOneOfTrail(i, TotalLength);

                    }, function (error) {

                        // FAILURE IN ANY CASE
                        DraftCallAnotherOneOfTrail(i, TotalLength);
                    });

                }

            }

            function DraftCallAnotherOneOfTrail(i, TotalLength) {

                DraftTemporaryCounter++;

                //if (Number(DraftTemporaryCounter) == Number(TotalLength)) {
                if (Number(i) == Number(TotalLength)) {

                    $("#loader").hide();

                    Message({
                        'Msg': 'Mails moved to trash successfully', 'Type': msg_Success, 'Event1': function () {
                            showdraft(1);
                            GetTabsCount('<%=StaticKeywordClass.Draft %>');
                            GetTabsCount('<%=StaticKeywordClass.Trash %>');
                        }
                    });
                }
            }

        </script>
        <script type="text/javascript">

            // OUTBOX DELETE
            $(document).ready(function () {

                $("#CheckboxHeadOutbox").change(function () {
                    $('input[name="OutboxcheckboxChild"]').prop("checked", $(this).prop("checked"));
                });

            });

            function OutboxBulkDelete() {

                if (Number($('input[name="OutboxcheckboxChild"]:checked').length) == 0) {
                    Message({ 'Msg': "Please select record first", 'Type': msg_Error });
                    return false;
                }

                var IDs = [];

                var TotalLength = $('input[name="OutboxcheckboxChild"]:checked').length;

                $('input[name="OutboxcheckboxChild"]:checked').each(function (index) {

                    var ID = $(this).val();
                    if (ID != "") {
                        IDs.push(ID);
                    }

                    var innercounter = index + 1;

                    if (TotalLength == innercounter) {

                        OutboxCallFinalDelete(IDs);
                    }
                });

            }

            var OutboxTemporaryCounter = 0;

            function OutboxCallFinalDelete(IDs) {

                var IDsArray = IDs;

                var TotalLength = IDsArray.length;

                var SystemTimeZone = Timezone();

                OutboxTemporaryCounter = 0;

                $("#loader").show();

                for (var i = 0; i < Number(IDs.length) ; i++) {

                    var DeleteID = IDsArray[i];

                    PageMethods.DeleteOutboxMail(Number(DeleteID), function (data) {

                        //SUCCESS
                        OutboxCallAnotherOneOfTrail(i, TotalLength);

                    }, function (error) {

                        // FAILURE IN ANY CASE
                        OutboxCallAnotherOneOfTrail(i, TotalLength);
                    });

                }

            }

            function OutboxCallAnotherOneOfTrail(i, TotalLength) {

                OutboxTemporaryCounter++;

                //if (Number(OutboxTemporaryCounter) == Number(TotalLength)) {
                if (Number(i) == Number(TotalLength)) {

                    $("#loader").hide();

                    Message({
                        'Msg': 'Mails moved to trash successfully', 'Type': msg_Success, 'Event1': function () {
                            openoutbox(1);
                            GetTabsCount('<%=StaticKeywordClass.Outbox %>');
                            GetTabsCount('<%=StaticKeywordClass.Trash %>');
                        }
                    });
                }
            }

        </script>
        <script type="text/javascript">

            // TRASH DELETE
            $(document).ready(function () {

                $("#CheckboxHeadTrash").change(function () {
                    $('input[name="TrashcheckboxChild"]').prop("checked", $(this).prop("checked"));
                });

            });

            function TrashBulkDelete() {

                if (Number($('input[name="TrashcheckboxChild"]:checked').length) == 0) {
                    Message({ 'Msg': "Please select record first", 'Type': msg_Error });
                    return false;
                }

                var IDs = [];

                var TotalLength = $('input[name="TrashcheckboxChild"]:checked').length;

                $('input[name="TrashcheckboxChild"]:checked').each(function (index) {

                    var ID = $(this).val();
                    if (ID != "") {
                        IDs.push(ID);
                    }

                    var innercounter = index + 1;

                    if (TotalLength == innercounter) {

                        TrashCallFinalDelete(IDs);
                    }
                });

            }

            var TrashTemporaryCounter = 0;

            function TrashCallFinalDelete(IDs) {

                var IDsArray = IDs;

                var TotalLength = IDsArray.length;

                var SystemTimeZone = Timezone();

                TrashTemporaryCounter = 0;

                $("#loader").show();

                for (var i = 0; i < Number(IDs.length) ; i++) {

                    var DeleteID = IDsArray[i];

                    PageMethods.DeleteTrashEmail(Number(DeleteID), function (data) {

                        //SUCCESS
                        TrashCallAnotherOneOfTrail(i, TotalLength);

                    }, function (error) {

                        // FAILURE IN ANY CASE
                        TrashCallAnotherOneOfTrail(i, TotalLength);
                    });

                }

            }

            function TrashCallAnotherOneOfTrail(i, TotalLength) {

                TrashTemporaryCounter++;

                //if (Number(TrashTemporaryCounter) == Number(TotalLength)) {
                if (Number(i) == Number(TotalLength)) {

                    $("#loader").hide();

                    Message({
                        'Msg': 'Mails permanent delete successfully', 'Type': msg_Success, 'Event1': function () {
                            opentrash(1);
                            GetTabsCount('<%=StaticKeywordClass.Trash %>');
                        }
                    });
                }
            }

            // BULK RESTORE
            function TrashBulkRestore() {

                if (Number($('input[name="TrashcheckboxChild"]:checked').length) == 0) {
                    Message({ 'Msg': "Please select record first", 'Type': msg_Error });
                    return false;
                }

                var IDs = [];

                var TotalLength = $('input[name="TrashcheckboxChild"]:checked').length;

                $('input[name="TrashcheckboxChild"]:checked').each(function (index) {

                    var ID = $(this).val();
                    if (ID != "") {
                        IDs.push(ID);
                    }

                    var innercounter = index + 1;

                    if (TotalLength == innercounter) {

                        TrashCallFinalRestore(IDs);
                    }
                });

            }

            var TrashTemporaryCounterRestore = 0;

            function TrashCallFinalRestore(IDs) {

                var IDsArray = IDs;

                var TotalLength = IDsArray.length;

                var SystemTimeZone = Timezone();

                TrashTemporaryCounterRestore = 0;

                $("#loader").show();

                for (var i = 0; i < Number(IDs.length) ; i++) {

                    var DeleteID = IDsArray[i];

                    PageMethods.RestoreTrashEmail(Number(DeleteID), function (data) {

                        //SUCCESS
                        TrashCallAnotherOneOfTrailRestore(i, TotalLength);

                    }, function (error) {

                        // FAILURE IN ANY CASE
                        TrashCallAnotherOneOfTrailRestore(i, TotalLength);
                    });

                }

            }

            function TrashCallAnotherOneOfTrailRestore(i, TotalLength) {

                TrashTemporaryCounterRestore++;

                //if (Number(TrashTemporaryCounterRestore) == Number(TotalLength)) {
                if (Number(i) == Number(TotalLength)) {

                    $("#loader").hide();

                    Message({
                        'Msg': 'Mails restored successfully', 'Type': msg_Success, 'Event1': function () {
                            opentrash(1);
                            GetTabsCount('<%=StaticKeywordClass.Trash %>');
                            GetTabsCount('<%=StaticKeywordClass.Draft %>');
                            GetTabsCount('<%=StaticKeywordClass.Outbox %>');
                            GetTabsCount('<%=StaticKeywordClass.Sent %>');
                        }
                    });
                }
            }

        </script>

    </form>

</body>
</html>
