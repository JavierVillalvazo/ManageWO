<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="OpenOrders.aspx.cs" Inherits="ManageWO.OpenOrders" EnableEventValidation="true" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta name="description" content="tracking  open sales orders" />
    <link href="~/resources/images/icon.ico" rel="shortcut icon" />
    <link rel="stylesheet" href="Resources/CSS/Styles.css" />
    <link rel="stylesheet" href="Resources/CSS/site.css" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" />
    <!-- Font Awesome CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

    <title>Open - Sales orders</title>
</head>
<body>
    <form id="form2" runat="server">
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
                            <a class="nav-link text-white" href="#" title="CREATE, UPDATE, DELETE OPEN ORDERS">Open orders</a>
                        </li>
                        <%--  <li class="nav-item">
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
        <div class="container-fluid">
            <div class="container-xxl">
                <%-- alert --%>
                <div runat="server" id="alert" visible="false" class=" d-flex align-items-center" role="alert">
                    <span id="AlertIcon" runat="server" class=" flex-shrink-0 me-2" role="img"></span>
                    <asp:Label runat="server" CssClass="fw-bold" ID="alertText" Text="">
                    </asp:Label>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
                <div class="">
                    <div class="form-group  row">
                        <div class="form-group col-md-0">
                            <asp:Label CssClass="fw-bold form-control label" Visible="false" runat="server" for="inputID">ID</asp:Label>
                            <asp:TextBox runat="server" require="required" type="text" Visible="false" class="form-control" ID="inputID" aria-describedby="basic-addon1" Enabled="false" placeholder="ID"></asp:TextBox>
                        </div>
                        <div class="form-group col-md-4">
                            <asp:Label runat="server" CssClass="fw-bold form-control label">Date</asp:Label>
                            <asp:TextBox runat="server" AutoCompleteType="Disabled" AutoPostBack="false" TextMode="Date" Enabled="false" class="form-control" ID="txtDate"></asp:TextBox>
                            <asp:RequiredFieldValidator CssClass="text-danger fw-bold mx-2" Font-Size="X-Small" SetFocusOnError="true" ErrorMessage="(*) required" ValidationGroup="fields" ControlToValidate="txtWeekNo" runat="server" />
                        </div>
                        <div class="form-group col-md-4">
                            <asp:Label runat="server" CssClass="fw-bold form-control label">Week No</asp:Label>
                            <asp:TextBox runat="server" AutoCompleteType="Disabled" AutoPostBack="false" TextMode="Number" Enabled="false" class="form-control" ID="txtWeekNo"></asp:TextBox>
                            <asp:RequiredFieldValidator CssClass="text-danger fw-bold mx-2" Font-Size="X-Small" SetFocusOnError="true" ErrorMessage="(*) required" ValidationGroup="fields" ControlToValidate="txtWeekNo" runat="server" />
                            <%--<asp:RegularExpressionValidator ID="RegularExpressionValidator4" CssClass="text-danger fw-bold" Font-Size="X-Small" ControlToValidate="txtWeekNo" runat="server" ErrorMessage="only numbers allowed" ValidationExpression="^[0-9]\d{0,2}$" SetFocusOnError="true"> </asp:RegularExpressionValidator>--%>
                        </div>
                    </div>
                    <div class="form-group  row">
                        <div class="form-group col-md-4">
                            <asp:Label runat="server" CssClass="fw-bold form-control label">On time</asp:Label>
                            <asp:TextBox runat="server" TextMode="Number" AutoCompleteType="Disabled" AutoPostBack="false" Enabled="false" class="form-control" ID="txtOntime"></asp:TextBox>
                            <asp:RequiredFieldValidator CssClass="text-danger fw-bold mx-2" Font-Size="X-Small" SetFocusOnError="true" ErrorMessage="(*) required" ValidationGroup="fields" ControlToValidate="txtOntime" runat="server" />
                            <%--<asp:RegularExpressionValidator ID="RegularExpressionValidator1" CssClass="text-danger fw-bold" Font-Size="X-Small" ControlToValidate="txtOntime" runat="server" ErrorMessage="only numbers allowed" ValidationExpression="^[0-9]\d{0,2}$" SetFocusOnError="true"> </asp:RegularExpressionValidator>--%>
                        </div>
                        <div class="form-group col-md-4">
                            <asp:Label runat="server" CssClass="fw-bold form-control label">Wrong Date</asp:Label>
                            <asp:TextBox runat="server" AutoCompleteType="Disabled" AutoPostBack="false" Enabled="false" TextMode="Number" class="form-control" ID="txtWrongDate"></asp:TextBox>
                            <asp:RequiredFieldValidator CssClass="text-danger fw-bold mx-2 my-0" Font-Size="X-Small" SetFocusOnError="true" ErrorMessage="(*) required" ValidationGroup="fields" ControlToValidate="txtWrongDate" runat="server" />
                            <%--<asp:RegularExpressionValidator ID="RegularExpressionValidator3" CssClass="text-danger fw-bold" Font-Size="X-Small" ControlToValidate="txtWrongDate" runat="server" ErrorMessage="only numbers allowed" ValidationExpression="^[0-9]\d{0,2}$" SetFocusOnError="true"> </asp:RegularExpressionValidator>--%>
                        </div>
                        <div class="form-group col-md-4">
                            <asp:Label runat="server" CssClass="fw-bold form-control label">Past Due</asp:Label>
                            <asp:TextBox runat="server" AutoCompleteType="Disabled" AutoPostBack="false" TextMode="Number" class="form-control" Enabled="false" ID="txtPastDue"></asp:TextBox>
                            <asp:RequiredFieldValidator CssClass="text-danger fw-bold mx-2" Font-Size="X-Small" SetFocusOnError="true" ErrorMessage="(*) required" ValidationGroup="fields" ControlToValidate="txtPastDue" runat="server" />
                            <%--<asp:RegularExpressionValidator ID="RegularExpressionValidator2" CssClass="text-danger fw-bold" Font-Size="X-Small" ControlToValidate="txtPastDue" runat="server" ErrorMessage="only numbers allowed" ValidationExpression="^[0-9]\d{0,2}$" SetFocusOnError="true"> </asp:RegularExpressionValidator>--%>
                        </div>
                        <div class="form-group col-md-0">
                            <asp:Label runat="server" Visible="false" CssClass="fw-bold form-control label">Balance To Build</asp:Label>
                            <asp:TextBox runat="server" Visible="false" AutoCompleteType="Disabled" AutoPostBack="false" Enabled="false" TextMode="Number" class="form-control" ID="txtBalanceToBuild"></asp:TextBox>
                        </div>
                    </div>

                    <br />
                    <div class="form-group mb-3">
                        <asp:LinkButton ID="NewBtn" runat="server" class="btn btn-primary " OnClick="NewBtn_Click" Visible="false"><i class="bi bi-file-earmark-plus"></i> Create</asp:LinkButton>
                        <asp:LinkButton ID="SaveBtn" runat="server" class=" btn btn-success " OnClick="SaveBtn_Click" Visible="false" ValidationGroup="fields"><i class="bi bi-floppy2-fill"></i> Save</asp:LinkButton>
                        <asp:LinkButton ID="UpdateBtn" runat="server" class=" btn btn-warning " OnClick="UpdateBtn_Click" Visible="false"><i class="bi bi-database-fill-check"></i> Update</asp:LinkButton>
                        <asp:LinkButton ID="AbortBtn" runat="server" class=" btn btn-danger " OnClick="AbortBtn_Click" Visible="false"><i class="bi bi-input-cursor-text"></i> Cancel</asp:LinkButton>
                        <asp:LinkButton ID="btnRefresh" runat="server" class=" btn btn-info  text-white" OnClick="btnRefresh_Click" Visible="false"><i class="bi bi-arrow-repeat"></i>  REFRESH</asp:LinkButton>

                    </div>
                    <div class="input-group mt-2 fixed-bottom">
                        <asp:LinkButton ID="ExportBtn" Visible="true" CssClass=" btn btn-success fw-bold" OnClick="ExportBtn_Click" runat="server" Text="EXPORT"><i class="bi bi-filetype-xlsx"></i> EXPORT TO EXCEL</asp:LinkButton>
                    </div>
                </div>

                <div class="form-row">
                    <div class="rounded  table-responsive">
                        <asp:GridView runat="server" ID="table" HeaderStyle-HorizontalAlign="Left" OnRowCommand="table_RowCommand" OnRowDataBound="table_RowDataBound" CssClass="table table-striped table-hover table-bordered" ShowHeaderWhenEmpty="true" AutoGenerateColumns="false" DataSourceID="SqlDataSource1" OnSelectedIndexChanged="table_SelectedIndexChanged">
                            <EmptyDataTemplate>
                                <span class="placeholder col-6"></span>
                                <span class="placeholder w-75"></span>
                                <span class="placeholder" style="width: 25%;"></span>
                            </EmptyDataTemplate>
                            <Columns>
                                <asp:ButtonField ButtonType="Image" Text="Edit" ImageUrl="./Resources/images/icons/pencil.png" CommandName="Editar" HeaderText="Edit" ControlStyle-CssClass="btn btn-warning fw-bold" ItemStyle-Width="4%" />
                                <asp:BoundField DataField="ID" Visible="true" HeaderText="ID" ReadOnly="True" InsertVisible="False" SortExpression="ID" ItemStyle-Width="5%"></asp:BoundField>
                                <asp:BoundField DataField="Date" DataFormatString="{0:yyyy-mm-dd}" HeaderText="Date" SortExpression="Date" ItemStyle-Width="12%"></asp:BoundField>
                                <asp:BoundField DataField="WeekNumber" HeaderText="WeekNumber" SortExpression="WeekNumber" ItemStyle-Width="12%"></asp:BoundField>
                                <asp:BoundField DataField="OnTime" DataFormatString="{0:N0}" HeaderText="OnTime" SortExpression="OnTime" ItemStyle-Width="12%"></asp:BoundField>
                                <asp:BoundField DataField="WrongDate" DataFormatString="{0:N0}" HeaderText="WrongDate" SortExpression="WrongDate" ItemStyle-Width="12%"></asp:BoundField>
                                <asp:BoundField DataField="PastDue" DataFormatString="{0:N0}" HeaderText="PastDue" SortExpression="PastDue" ItemStyle-Width="12%"></asp:BoundField>
                                <asp:BoundField DataField="BalanceToBuild" DataFormatString="{0:N0}" HeaderText="BalanceToBuild" SortExpression="BalanceToBuild" ItemStyle-Width="12%"></asp:BoundField>
                                <asp:ButtonField ButtonType="Image" ImageUrl="./Resources/images/icons/trash.png" Text="Delete" CommandName="ComDelete" HeaderText="Eliminar" ControlStyle-CssClass="btn btn-danger fw-bold text-white" ItemStyle-Width="5%" />
                            </Columns>
                            <PagerStyle CssClass="GridPager" />
                        </asp:GridView>
                        <asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString="<%$ ConnectionStrings:mmc %>" SelectCommand=" select [ID], convert(varchar(10),[Date],23) as [Date],[WeekNumber],[OnTime],[WrongDate],[PastDue],[BalanceToBuild] from OpenOrders  Order by [Date] asc"></asp:SqlDataSource>
                    </div>
                </div>
            </div>
        </div>
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
