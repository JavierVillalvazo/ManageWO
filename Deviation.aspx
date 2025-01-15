<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Deviation.aspx.cs" Inherits="ManageWO.Deviation" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta name="description" title="Create, update and delete Work Orders for SMT" />
    <link href="~/resources/images/icon.ico" rel="shortcut icon" />
    <link rel="stylesheet" href="Resources/CSS/styles.css" />
    <link rel="stylesheet" href="Resources/CSS/site.css" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" />
    <!-- Font Awesome CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
    <title>SMT - Search & Download Deviation</title>
</head>
<body>
    <form id="form1" runat="server">
               <nav class="navbar sticky-top navbar-expand-lg  navbar-dark bg-dark">
           <div class="container-fluid">
               <a class="navbar-brand" href="./Home.aspx">
                   <img id="logo" class="navbar-brand" src="./resources/images/inv.png" title="Go back to Home" /></a>
               <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                   <span class="navbar-toggler-icon"></span>
               </button>
               <div class="collapse navbar-collapse mx-auto" id="navbarSupportedContent">
                   <div class="btn-group ">
                       <asp:LinkButton runat="server" class="btn btn-dark " ID="LinkButton3" Text="Regresar" title="Click para regresar">
                               <span><i class="bi bi-chevron-left fs-5"></i> </span>
                       </asp:LinkButton>
                       <asp:LinkButton runat="server" ID="btnHome" class=" btn btn-dark" title="Inicio -  Homepage" Text="Home">
                               <span><i class="bi bi-house-fill fs-5"></i> </span>
                       </asp:LinkButton>
                       <%--<asp:LinkButton runat="server" ID="LinkButton1" class="btn btn-dark"><i class="bi bi-person-circle fs-5" ></i></asp:LinkButton>--%>
                           <asp:LinkButton type="button" ID="logoutBtn" runat="server" class=" btn btn-dark text-danger fs-5" OnClientClick="if (!confirm('Are you sure you want to log out??')) return false;" PostBackUrl="~/Home.aspx" title="Exit System">
                           <span class="btn-label"><i  class="fa fa-sign-out"></i></span> 
                           </asp:LinkButton>

                   </div>
                   <ul class="navbar-nav mx-auto mb-2 mb-lg-0">
                       <li class="nav-item active fw-bold ">
                           <a class="nav-link text-white" href="#" title="">Search deviation</a>
                   </ul>
                   <div id="form3" runat="server" class="d-flex " role="search">
                       <div class="btn-group ">
                           <asp:LinkButton runat="server" ID="userBtn" class="btn btn-dark"><i class="bi bi-person-circle" ></i></asp:LinkButton>
                           <asp:LinkButton runat="server" class=" btn  btn-dark" ID="LinkButton2" Font-Size="Smaller" Text="Javier " title="User"></asp:LinkButton>
                       </div>

                   </div>
               </div>
           </div>
       </nav>
        <div class="container mt-2 ">
            <%-- alerta --%>
            <div runat="server" id="alert" visible="false" class=" d-flex align-items-center mb-1" role="alert">
                <span id="AlertIcon" runat="server" class=" flex-shrink-0 me-2" role="img"></span>
                <asp:Label runat="server" CssClass="fw-bold" ID="alertText" Text="">
                </asp:Label>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>

            <div class="container mt-4">
                <div class="form-group ">
                    <div class="input-group ">
                        <asp:LinkButton ID="CancelBtn" Visible="false" CssClass=" btn btn-danger fw-bold" runat="server" OnClick="CancelBtn_Click" Text="" ToolTip="Cancel query"><i class="bi bi-x-lg"></i> </asp:LinkButton>
                        <asp:LinkButton ID="QueryBtn" Visible="false" CssClass="btn btn-dark fw-bold " OnClick="QueryBtn_Click" runat="server" ToolTip="Click to enable query"><i runat="server" class="fa fa-search-plus"></i></asp:LinkButton>
                        <asp:TextBox ID="filterText" CssClass="form-control filter" Enabled="false" AutoCompleteType="Disabled" TextMode="Search" AutoPostBack="true" OnTextChanged="filterText_TextChanged" runat="server" class="form-control" placeholder="Search by WorkOrder or Model"></asp:TextBox>
                        <asp:LinkButton ID="SearchBtn" Visible="false" CssClass=" btn btn-dark fw-bold" OnClick="SearchBtn_Click" runat="server" Text="" ToolTip="Search"><i class="bi bi-search"></i></asp:LinkButton>
                        <asp:LinkButton ID="RefreshBtn" Visible="false" CssClass=" btn btn-primary fw-bold" runat="server" OnClick="RefreshBtn_Click" Text="" ToolTip="Refresh table"><i class="bi bi-arrow-clockwise"></i></asp:LinkButton>
                    </div>
                    <hr />
                </div>
                <div class="form-row">
                    <div class="rounded table-responsive ">
                        <asp:GridView runat="server" ID="myTable" OnPageIndexChanging="myTable_PageIndexChanging" OnRowDataBound="myTable_RowDataBound" OnRowCommand="myTable_RowCommand" HeaderStyle-HorizontalAlign="Center" CssClass="table table-striped table-hover table-bordered" ShowHeaderWhenEmpty="false" AutoGenerateColumns="false" DataKeyNames="WorkOrder" AllowPaging="false">
                            <EmptyDataTemplate>
                                <div class="empty-state">
                                    <div class="empty-state__content">
                                        <div class="empty-state__icon">
                                            <img src="./Resources/images/skull.png" alt="...">
                                        </div>
                                        <div class="empty-state__message">No records has been added yet.</div>
                                        <div class="empty-state__help">
                                            Add a new record by simpley clicking the below button.
                                        </div>
                                    </div>
                                </div>
                            </EmptyDataTemplate>
                            <Columns>
                                <asp:BoundField DataField="ID" HeaderText="ID" ReadOnly="True" ItemStyle-HorizontalAlign="Center" />
                                <asp:BoundField DataField="WorkOrder" HeaderText="WorkOrder" ReadOnly="True" ItemStyle-HorizontalAlign="Center" />
                                <asp:BoundField DataField="Model" HeaderText="Model" ReadOnly="True" ItemStyle-HorizontalAlign="Center" />
                                <asp:BoundField DataField="Quantity" HeaderText="Quantity" ReadOnly="True" ItemStyle-HorizontalAlign="Center" />
                                <asp:BoundField DataField="filename" HeaderText="filename" ReadOnly="True" ItemStyle-HorizontalAlign="Center" />
                                <asp:BoundField DataField="uploadedDate" HeaderText="uploadedDate" ReadOnly="True" ItemStyle-HorizontalAlign="Center" />
                                <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lnkDownload" title="click to download PDF" CssClass="btn btn-success" runat="server" Text="Download PDF" OnClick="DownloadFile"
                                            CommandArgument='<%# Eval("Id") %>'><i class="bi bi-filetype-pdf" title="click to download PDF" ></i></asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <PagerStyle CssClass="GridPager" />
                        </asp:GridView>
                    </div>
                </div>

            </div>
        </div>
        <%-- Fin off Gridview --%>
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
