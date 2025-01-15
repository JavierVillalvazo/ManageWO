<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SMTKN.aspx.cs" Inherits="ManageWO.SMTKN" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta name="description" title="Editar numeros de parte del KN SMT" />
    <link href="~/resources/images/icon.ico" rel="shortcut icon" />
    <link rel="stylesheet" href="Resources/CSS/Styles.css" />
    <link rel="stylesheet" href="Resources/CSS/site.css" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" />
    <!-- Font Awesome CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <title>Kitting Note SMT</title>
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
                            <a class="nav-link text-white" href="#" title="CREATE, UPDATE, DELETE WORK ORDER">WO</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" title="Upload, delete, and update Kitting note smt" href="./smtkn.aspx">KN</a>
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

        <div class="container-fluid mt-3 mx-auto ">
            <div class="container ">
                <div runat="server" id="alert" visible="false" class=" d-flex align-items-center" role="alert">
                    <span id="AlertIcon" runat="server" class=" flex-shrink-0 me-2" role="img"></span>
                    <asp:Label runat="server" CssClass="fw-bold" ID="alertText" Text="">
                        
                    </asp:Label>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
                <div class="form-group">
                    <br />
                    <div class="  form-group mb-3">
                        <button type="button" class="btn btn-primary fw-bold w-100" visible="true" data-bs-target="#myModal" data-bs-toggle="modal"><i class="bi bi-folder-plus"></i>UPLOAD A KITTING NOTE FILE</button>
                    </div>
                </div>
                <div class="card-body" runat="server">
                    <div class="modal fade" id="myModal" tabindex="-1" data-bs-backdrop="static" data-bs-keyboard="false" data-bs-theme="light">
                        <div class="modal-dialog modal-dialog modal-dialog modal-lg modal-dialog-centered">
                            <div class="modal-content">
                                <div class="modal-header bg-dark">
                                    <label class="modal-title fs-5 text-white fw-bold" id="exampleModalToggleLabel">Kitting note SMT        - Excel</label>
                                    <asp:Button Style="" runat="server" ForeColor="White" type="button" class="btn-close btn btn-danger text-white" data-bs-dismiss="modal" aria-label="Close"></asp:Button>
                                </div>
                                <div class="modal-body w-100  mx-auto w-50" data-bs-theme="light">
                                    <div class="input-group mt-3 mb-3  col-sm-12">
                                        <asp:FileUpload ID="fuData" CssClass="form-control" runat="server" />

                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <asp:LinkButton ID="btnKN" runat="server" CssClass=" fw-bold btn     btn-primary" OnClick="btnUpload_Click"> <i class="bi bi-cloud-arrow-up-fill"></i> Upload </asp:LinkButton>
                                    <asp:LinkButton runat="server" type="button" class="btn btn-outline-danger" data-dismiss="modal"> <i class="bi bi-x-circle"></i> Close</asp:LinkButton>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="container mt-0">

                <div class="form-group mb-3 ">
                    <%--<h4 style="text-align: center;" class="">DATA FILTER</h4>--%>
                    <div class="input-group ">
                        <asp:LinkButton ID="CancelBtn" Visible="false" CssClass=" btn btn-danger fw-bold" runat="server" OnClick="CancelBtn_Click" Text="" ToolTip="Cancel query"><i class="bi bi-x-lg"></i> </asp:LinkButton>
                        <asp:LinkButton ID="QueryBtn" Visible="false" CssClass="btn btn-dark fw-bold " OnClick="QueryBtn_Click" runat="server" ToolTip="Click to enable query"><i runat="server" class="bi bi-funnel-fill"></i></asp:LinkButton>
                        <asp:TextBox ID="filterText" CssClass="form-control filter text-center text-body-secondary" Enabled="false" TextMode="Search" AutoPostBack="true" OnTextChanged="filterText_TextChanged" runat="server" class="form-control" placeholder="Search by work order or model..."></asp:TextBox>
                        <asp:LinkButton ID="SearchBtn" Visible="false" CssClass=" btn btn-dark fw-bold" OnClick="SearchBtn_Click" runat="server" Text="" ToolTip="Search"><i class="bi bi-search"></i></asp:LinkButton>
                        <asp:LinkButton ID="RefreshBtn" Visible="false" CssClass=" btn btn-primary fw-bold" runat="server" OnClick="RefreshBtn_Click" Text="" ToolTip="Refresh table"><i class="bi bi-arrow-clockwise"></i></asp:LinkButton>
                    </div>
                </div>
                <div class="form-row">
                    <div class="table-responsive">
                        <asp:GridView runat="server" ID="tableKN" HeaderStyle-BackColor="#ebebeb" OnPageIndexChanging="tableKN_PageIndexChanging" OnSelectedIndexChanged="tableKN_SelectedIndexChanged" OnRowCommand="tableKN_RowCommand" OnSelectedIndexChanging="tableKN_SelectedIndexChanging" CssClass="table table-hover table-responsive" ShowHeaderWhenEmpty="true" BorderStyle="None" AutoGenerateColumns="false" OnRowDataBound="tableKN_RowDataBound" DataKeyNames="WorkOrder" AllowPaging="true" HorizontalAlign="Center" GridLines="Horizontal" Width="100%" Height="60%" PageSize="10">

                            <HeaderStyle VerticalAlign="Middle" HorizontalAlign="Center" CssClass="table-secondary" />
                            <RowStyle VerticalAlign="Middle" HorizontalAlign="Center" />

                            <EmptyDataTemplate>
                                <span class="placeholder col-6"></span>
                                <span class="placeholder w-75"></span>
                                <span class="placeholder" style="width: 25%;"></span>
                                <span class="placeholder w-75"></span>
                                <span class="placeholder col-6"></span>
                                <span class="placeholder w-75"></span>
                                <span class="placeholder w-25"></span>
                                <span class="placeholder w-100"></span>
                                <span class="placeholder w-25"></span>
                                <span class="placeholder w-100"></span>
                                <span class="placeholder w-50"></span>
                            </EmptyDataTemplate>
                            <Columns>
                                  <asp:ButtonField ButtonType="image" ImageUrl="./Resources/images/icons/download2.png"   CommandName="DownloadKN" HeaderText="Download" ItemStyle-Width="5%" ControlStyle-CssClass="btn " />
                                <asp:BoundField DataField="WorkOrder" HeaderText="WorkOrder" ItemStyle-CssClass="text-body-secondary fw-bold" ReadOnly="True" SortExpression="WorkOrder">
                                    <ItemStyle Width="25%"></ItemStyle>
                                </asp:BoundField>
                                <asp:BoundField DataField="Model" HeaderText="Model" ItemStyle-CssClass="text-body-secondary fw-bold" SortExpression="Model">
                                    <ItemStyle Width="25%"></ItemStyle>
                                </asp:BoundField>
                                <asp:BoundField DataField="Quantity" HeaderText="Quantity" ItemStyle-CssClass="text-body-secondary fw-bold" SortExpression="Quantity">
                                    <ItemStyle Width="25%"></ItemStyle>
                                </asp:BoundField>
                                  <asp:ButtonField ButtonType="image" ImageUrl="./Resources/images/icons/trash.png" Text="DELETE" CommandName="DeleteKN" HeaderText="Delete" ItemStyle-Width="5%" />
                                  <%--<asp:TemplateField HeaderText="Delete" ItemStyle-Width="3%" ItemStyle-Height="5px" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:LinkButton CommandName="DownloadKN" runat="server" CssClass="btn btn-lg  btn-outline-success border border-0 fw-bold" ToolTip="Delete current row" OnClientClick="return window.confirm('Do you want to download the selected record?');" CommandArgument='<%# Eval("WorkOrder") %>'> <i class="bi bi-cloud-arrow-down-fill"></i></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>--%>
                                <%--<asp:TemplateField HeaderText="Actions" ItemStyle-Width="15%" ItemStyle-Height="5px" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:LinkButton CommandName="DownloadKN" runat="server" CssClass="btn btn-lg  btn-outline-success  border border-0   fw-bold" ToolTip="download KN    " OnClientClick="return window.confirm('Do you want to download the selected record?');"> <i class="bi bi-cloud-arrow-down-fill" ></i></asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Actions" ItemStyle-Width="15%" ItemStyle-Height="5px" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:LinkButton CommandName="DeleteKN" runat="server" CssClass="btn btn-lg  btn-outline-danger   border border-0" ToolTip="Delete current row" OnClientClick="return window.confirm('Do you want to delete the selected record?');"> <i class="bi bi-trash3-fill"></i></asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>--%>





                            </Columns>

                            <PagerStyle HorizontalAlign="Center" CssClass="GridPager" />
                            <PagerSettings Mode="NextPreviousFirstLast" PageButtonCount="8" FirstPageText="First" LastPageText="Last" />
                        </asp:GridView>
                    </div>
                </div>
            </div>
            <!-- contenedor wo-->
        </div>

        <%--content-wo        --%>
    </form>
</body>
</html>
