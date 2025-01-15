<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="test-fileupload.aspx.cs" Inherits="ManageWO.test_fileupload" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <asp:FileUpload runat="server" ID="FileUpload1" />
        <asp:Button runat="server" ID="btnUpload" Text="Upload" OnClick="Upload" />
        <hr />
        <asp:Label runat="server" ID="lblMessage" ForeColor="Green" />
    </form>
</body>
</html>
