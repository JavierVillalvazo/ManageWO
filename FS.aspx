<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FS.aspx.cs" Inherits="ManageWO.FS" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link href="~/resources/images/icon.ico" rel="shortcut icon" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" />
    <!-- Font Awesome CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous" />
        <link href="resources/css/styles.css" rel="stylesheet" />
    <link rel="stylesheet" href="Resources/CSS/site.css"/>
    <title>Feeder Setup</title>
</head>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

<body>
    <form id="form1" runat="server">
        <nav class="navbar sticky-top navbar-expand-lg  navbar-dark bg-dark">
            <div class="container-fluid">
                <a class="navbar-brand" href="./Home.aspx">
                    <img id="logo" src="./resources/images/inv.png" title="Go back to Home" /></a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav mx-auto mb-2 mb-lg-0">
                        <li class="nav-item active fw-bold ">
                            <a class="nav-link text-white" href="#" title="Feeder setup management">Feeder setup</a>
                        </li>
                        <%-- <li class="nav-item">
                           <a class="nav-link" href="./smtkn.aspx">KN</a>
                       </li>--%>
                        <%-- <li class="nav-item">
                           <a class="nav-link icon-link icon-link-hover disabled" aria-disabled="true">Create, update and delete WO</a>
                       </li>--%>
                    </ul>
                    <div id="form3" runat="server" class="d-flex " role="search">
                        <div class="btn-group me-2">
                            <asp:LinkButton runat="server" ID="userBtn" class=" btn btn-dark btn-sm " Style="color: aliceblue; --bs-btn-padding-y: .25rem; --bs-btn-padding-x: .5rem; --bs-btn-font-size: .75rem;"><i class="bi bi-person-circle" ></i></asp:LinkButton>
                            <asp:LinkButton runat="server" class=" fw-bold  btn btn-sm btn-dark " ID="LinkButton2" Text="User" title="User" Style="--bs-btn-padding-y: .25rem; --bs-btn-padding-x: .5rem; --bs-btn-font-size: .75rem;"></asp:LinkButton>
                        </div>
                        <asp:LinkButton type="button" ID="logoutBtn" runat="server" class="fw-bold btn btn-outline-danger btn-sm me-2" OnClientClick="if (!confirm('Are you sure you want to log out??')) return false;" PostBackUrl="~/Home.aspx" title="Exit System">
                            <span class="btn-label"><i  class="fa fa-sign-out"></i></span>  Sign out
                        </asp:LinkButton>
                    </div>
                </div>
            </div>
        </nav>
        <div class="container ">
            <div runat="server" id="alert" visible="false" class=" d-flex align-items-center" role="alert">
                <span id="AlertIcon" runat="server" class=" flex-shrink-0 me-2" role="img"></span>
                <asp:Label runat="server" CssClass="fw-bold" ID="alertText" Text="">
                        
                </asp:Label>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            <%--<h4 style="text-align: center;" class="">UPLOAD FEEDER SETUP</h4>--%>

            <div class="card mt-3 mb-2 border border-primary p-2 mb-2 border-opacity-25 ">
                <div class="card-body">
                    <div class="form-group row mx-auto " style="text-align: center;">
                        <label class="fw-bold h4 ">Choose feeder setup file(s)</label>
                        <div class="">
                            <asp:Label runat="server" ID="label1" Font-Size="XX-Small" class="d-block m-0 fs-6 text-start text-body-secondary " for="multiple_files">Upload multiple files</asp:Label>
                            <asp:FileUpload Width="100%" ID="fuData" CssClass="form-control form-control " runat="server" AllowMultiple="true" />
                            <label class="custom-file-label fw-bold "></label>
                        </div>
                        <label id="filename" class="fw-bold"></label>
                        <div class="input-group-append ">
                            <%--<asp:Button Text="Upload" ID="btnUpload" runat="server" Enabled="true" CssClass=" fw-bold btn btn-primary" OnClick="btnUpload_Click" />--%>
                            <%--<asp:Button Text="Cancelar" ID="ClearBtn" runat="server" Enabled="true" CssClass=" fw-bold btn btn-danger" OnClick="ClearBtn_Click" />--%>
                            <asp:LinkButton ID="btnFile" runat="server" type="submit" class=" btn btn-primary " OnClick="btnUpload_Click" Visible="true" ToolTip="Click to upload files to server(you can select multiple files if you want.)"><span runat="server"  class="bi bi-file-arrow-up"></span> Upload FS</asp:LinkButton>

                            <asp:LinkButton ID="ClearBtn" runat="server" type="submit" class=" btn btn-danger " OnClick="ClearBtn_Click" Visible="true"><span runat="server"  class="bi bi-x-square-fill" title="click to cancel action, click to select another files"></span> Cancel</asp:LinkButton>

                        </div>
                        <asp:Label ID="lblMessage" CssClass="h5 " runat="server" />
                    </div>
                </div>
            </div>
        </div>

        <div class="container mt-2">
            <div class="form-group">
                <div class="input-group ">
                    <asp:LinkButton ID="CancelBtn" Visible="false" CssClass=" btn btn-danger fw-bold" runat="server" OnClick="CancelBtn_Click" Text="" ToolTip="Cancel query"><i class="bi bi-x-lg"></i> </asp:LinkButton>
                    <asp:LinkButton ID="QueryBtn" Visible="false" CssClass="btn btn-dark fw-bold " OnClick="QueryBtn_Click" runat="server" ToolTip="Click to enable query"><i runat="server" class="fa fa-search-plus"></i></asp:LinkButton>
                    <asp:TextBox ID="filterText" CssClass="form-control filter" Enabled="false"  TextMode="Search" AutoPostBack="true" OnTextChanged="filterText_TextChanged" runat="server" class="form-control" placeholder="Search by WorkOrder or Model"></asp:TextBox>
                    <asp:LinkButton ID="SearchBtn" Visible="false" CssClass=" btn btn-dark fw-bold" OnClick="SearchBtn_Click" runat="server" Text="" ToolTip="Search"><i class="bi bi-search"></i></asp:LinkButton>
                    <asp:LinkButton ID="RefreshBtn" Visible="false" CssClass=" btn btn-primary fw-bold" runat="server" OnClick="RefreshBtn_Click" Text="" ToolTip="Refresh able"><i class="bi bi-arrow-clockwise"></i></asp:LinkButton>
                </div>
                <hr />
            </div>
            <div class="form-row ">
                <div class="rounded table-responsive">
                    <asp:GridView runat="server" ID="tableFS" HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" OnPageIndexChanging="tableFS_PageIndexChanging" OnSelectedIndexChanged="tableFS_SelectedIndexChanged" OnRowCommand="tableFS_RowCommand" OnSelectedIndexChanging="tableFS_SelectedIndexChanging" CssClass="table table-striped table-hover table-bordered" ShowHeaderWhenEmpty="true" AutoGenerateColumns="false" OnRowDataBound="tableFS_RowDataBound" DataKeyNames="WorkOrder" AllowPaging="true">
                        <EmptyDataTemplate>
                            <span class="placeholder col-6"></span>
                            <span class="placeholder w-75"></span>
                            <span class="placeholder" style="width: 25%;"></span>
                        </EmptyDataTemplate>
                        <Columns>
                            <asp:BoundField DataField="WorkOrder" ItemStyle-HorizontalAlign="Center" HeaderText="WorkOrder" ReadOnly="True" SortExpression="WorkOrder">
                                <ItemStyle Width="25%"></ItemStyle>
                            </asp:BoundField>
                            <asp:BoundField DataField="Model" ItemStyle-HorizontalAlign="Center" HeaderText="Model" SortExpression="Model">
                                <ItemStyle Width="25%"></ItemStyle>
                            </asp:BoundField>
                            <asp:ButtonField ButtonType="Image" ItemStyle-Width="10%" ItemStyle-HorizontalAlign="Center" ControlStyle-CssClass="btn btn-success" ImageUrl="./Resources/images/icons/download.png" CommandName="DownloadFS" HeaderText="Download" />
                            <asp:ButtonField ButtonType="Image" ItemStyle-Width="10%" ItemStyle-HorizontalAlign="Center" ImageUrl="./Resources/images/icons/trash.png" ControlStyle-CssClass="btn " CommandName="DeleteFS" HeaderText="Delete" />
                        </Columns>
                        <PagerStyle CssClass="GridPager" />
                    </asp:GridView>
                </div>
            </div>
        </div>

       <%-- <footer class="bg-body-tertiary text-center text-lg-start fixed-bottom">
            <!-- Copyright -->
            <div class="text-center p-3" style="background-color: rgba(0, 0, 0, 0.05);">
                <a class="text-body fw-medium text-decoration-none" href="#">&copy; 2024 Copyright: MMC Inventronics</a>
            </div>
            <!-- Copyright -->
        </footer>--%>
    </form>
</body>
</html>
