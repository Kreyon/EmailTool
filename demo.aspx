<%@ Page Language="C#" AutoEventWireup="true" CodeFile="demo.aspx.cs" Inherits="demo" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="http://code.jquery.com/jquery-1.9.1.js"></script>

</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true"></asp:ScriptManager>
        <div>
        </div>


        <script type="text/javascript">

            $(document).ready(function () {
                PageMethods.GetEmailsWithHost(function (data) {
                    debugger;
                }, function (error) {
                    debugger;
                });
            });


        </script>
    </form>
</body>
</html>
