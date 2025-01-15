<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SearchAlterns.aspx.cs" Inherits="ManageWO.WebForm1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta name="description" title="Search SMT alterns parts for workorders" />
    <link href="~/resources/images/icon.ico" rel="shortcut icon" />
    <link rel="stylesheet" href="Resources/CSS/Styles.css" />
    <link rel="stylesheet" href="Resources/CSS/site.css" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" />
    <!-- Font Awesome CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <title>SMT - Search alterns NP</title>
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
                    <ul class="navbar-nav mx-auto mb-2 mb-lg-0">
                        <li class="nav-item active fw-bold ">
                            <a class="nav-link text-white" href="#" title="Search alterns for work orders">Search alterns</a>
                        </li>
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


          <div class="container mt-3 mx-auto">
            <%-- alerta --%>
            <div runat="server" id="alert" visible="false" class="mt-3 d-flex align-items-center mb-1" role="alert">
                <span id="AlertIcon" runat="server" class=" flex-shrink-0 me-2" role="img"></span>
                <asp:Label runat="server" CssClass="fw-bold" ID="alertText" Text="">
                </asp:Label>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </div>
        <div class="container mt-2">
            <div class="form-group mb-3 ">
                <div class="input-group ">
                    <asp:LinkButton ID="CancelBtn" Visible="false" CssClass=" btn btn-danger fw-bold" runat="server" OnClick="CancelBtn_Click" Text="" ToolTip="Cancel query"><i class="bi bi-x-lg"></i> </asp:LinkButton>
                    <asp:LinkButton ID="QueryBtn" Visible="false" CssClass="btn btn-dark fw-bold " OnClick="QueryBtn_Click" runat="server" ToolTip="Click to enable query"><i runat="server" class="fa fa-search-plus"></i></asp:LinkButton>
                    <asp:TextBox ID="filterText" CssClass="form-control filter" Enabled="false"  TextMode="Search" AutoPostBack="true" OnTextChanged="filterText_TextChanged" runat="server" class="form-control" placeholder="Search by WorkOrder " AutoCompleteType="Disabled"></asp:TextBox>
                    <asp:LinkButton ID="SearchBtn" Visible="false" CssClass=" btn btn-dark fw-bold" OnClick="SearchBtn_Click" runat="server" Text="" ToolTip="Search"><i class="bi bi-search"></i></asp:LinkButton>
                    <asp:LinkButton ID="RefreshBtn" Visible="false" CssClass=" btn btn-primary fw-bold" runat="server" OnClick="RefreshBtn_Click" Text="" ToolTip="Refresh table"><i class="bi bi-arrow-clockwise"></i></asp:LinkButton>
                </div>
            </div>
            <div class="form-row">
                <div class="rounded table-responsive ">
                    <asp:GridView runat="server" ID="myTable" OnRowDataBound="myTable_RowDataBound"  HeaderStyle-HorizontalAlign="Center" OnPageIndexChanging="myTable_PageIndexChanging"  CssClass="table  table-hover table-bordered " ShowHeaderWhenEmpty="true" AutoGenerateColumns="false" DataKeyNames="WorkOrder" AllowPaging="false">
                        <HeaderStyle CssClass="table-dark" />

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
                            <asp:BoundField DataField="ID" HeaderText="ID" ReadOnly="True"  ItemStyle-Width="7%" ItemStyle-HorizontalAlign="Center"/>
                            <asp:BoundField DataField="WorkOrder" HeaderText="WorkOrder" ReadOnly="True" ItemStyle-Width="15%" ItemStyle-HorizontalAlign="Center"/>
                            <asp:BoundField DataField="KittingNote" HeaderText="KittingNote" ReadOnly="True" ItemStyle-Width="15%" ItemStyle-HorizontalAlign="Center"/>
                            <asp:BoundField DataField="Model" HeaderText="Model" SortExpression="Model" ItemStyle-Width="20%" ItemStyle-HorizontalAlign="Center"></asp:BoundField>
                            <asp:BoundField DataField="PartNumber" HeaderText="PartNumber" ReadOnly="True"  ItemStyle-Width="25%" ItemStyle-HorizontalAlign="Center"/>
                            <asp:BoundField DataField="AlternatePartNumber" HeaderText="AlternatePartNumber" ReadOnly="True"  ItemStyle-Width="25%" ItemStyle-HorizontalAlign="Center"/>
                            <asp:BoundField DataField="ECN" HeaderText="ECN" ReadOnly="True"  ItemStyle-Width="10%" ItemStyle-HorizontalAlign="Center"/>
                        </Columns>
                        <PagerStyle CssClass="GridPager" />
                    </asp:GridView>
                </div>
                <%--<asp:LinkButton CssClass="btn btn-dark fw-bold" ID="ExportBtn" runat="server" Visible="false" OnClick="ExportBtn_Click">
                <span class="bi bi-printer-fill" aria-hidden="true"></span> &nbsp;Exportar
                </asp:LinkButton>--%>
            </div>

        </div>
        <div class="input-group mt-2 fixed-bottom">
            <asp:LinkButton ID="btnExcel" Visible="true" CssClass=" btn btn-success fw-bold" OnClick="btnExcel_Click" runat="server" Text="EXPORT" ToolTip="Export this table to excel"><i class="bi bi-file-earmark-excel-fill"></i>EXPORT EXCEL</asp:LinkButton>
        </div>
        <%-- Fin off Gridview --%>
        <footer class="bg-body-tertiary text-center text-lg-start fixed-bottom">
            <!-- Copyright -->
            <div class="text-center p-3" style="background-color: rgba(0, 0, 0, 0.05);">
                <a class="text-body fw-medium text-decoration-none" href="#">&copy; 2024 Copyright: MMC Inventronics</a>
            </div>
            <!-- Copyright -->
        </footer>

    </form>
</body>
</html>
