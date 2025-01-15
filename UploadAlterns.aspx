<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UploadAlterns.aspx.cs" Inherits="ManageWO.UploadAlterns" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta name="description" title="Manage altern parts for SMT" />
    <link href="~/resources/images/icon.ico" rel="shortcut icon" />
    <link rel="stylesheet" href="Resources/CSS/Styles.css" />
    <link rel="stylesheet" href="Resources/CSS/site.css" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous" />
    <title>SMT - Upload Alternate Parts</title>
</head>
<body>
    <form id="form2" runat="server">
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
                            <a class="nav-link text-white" href="#" title="CREATE, UPDATE, DELETE WORK ORDER">UPLOAD ALTERNATE PARTS</a>
                        </li>
                    </ul>
                    <div id="form3" runat="server" class="d-flex " role="search">
                        <div class="btn-group me-2">
                            <asp:LinkButton runat="server" ID="userBtn" class=" btn btn-dark btn-sm " Style="color: aliceblue; --bs-btn-padding-y: .25rem; --bs-btn-padding-x: .5rem; --bs-btn-font-size: .75rem;"><i class="bi bi-person-circle" ></i></asp:LinkButton>
                            <asp:LinkButton runat="server" class=" fw-bold  btn btn-sm btn-dark " ID="lblUser" Text="User" title="User" Style="--bs-btn-padding-y: .25rem; --bs-btn-padding-x: .5rem; --bs-btn-font-size: .75rem;"></asp:LinkButton>
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
            <div class="form-group col-md-0">
                <asp:Label CssClass="" Visible="false" runat="server" for="inputID">ID</asp:Label>
                <asp:TextBox runat="server" require="required" type="text" Visible="false" class="form-control " ID="inputID" aria-describedby="basic-addon1" Enabled="false" placeholder="ID"></asp:TextBox>
            </div>
            <div class="form-group row">
                <div class="form-group col-md-4">
                    <asp:Label CssClass="fw-bold " runat="server">Work Order</asp:Label><span class=" d-inline text-danger fw-bold"> *</span>
                    <asp:TextBox runat="server" class="form-control" ID="inputWorkorder" aria-describedby="basic-addon1" placeholder="M5107-YYMMXXXX" ></asp:TextBox>
                    <asp:RequiredFieldValidator CssClass="text-danger fw-bold mx-2" Font-Size="X-Small" SetFocusOnError="true" ErrorMessage="(*) required" ValidationGroup="fields" ControlToValidate="inputWorkorder" runat="server" />
                </div>
                <div class="form-group col-md-4">
                    <asp:Label runat="server" CssClass="fw-bold  ">Kitting Note</asp:Label><span class=" d-inline text-danger fw-bold"> *</span>
                    <asp:TextBox runat="server" AutoCompleteType="Disabled" AutoPostBack="true" class="form-control" ID="inputKN" placeholder="M5401-YYMMXXXX"></asp:TextBox>
                    <asp:RequiredFieldValidator CssClass="text-danger fw-bold mx-2" Font-Size="X-Small" SetFocusOnError="true" ErrorMessage="(*) required" ValidationGroup="fields" ControlToValidate="inputKN" runat="server" />
                </div>
                <div class="form-group col-md-4">
                    <asp:Label runat="server" CssClass="fw-bold  " for="inputModel">Model</asp:Label><span class=" d-inline text-danger fw-bold"> *</span>
                    <asp:TextBox runat="server" type="text" class="form-control" ID="inputModel" placeholder="MX1 OR MX2"></asp:TextBox>
                    <asp:RequiredFieldValidator CssClass="text-danger fw-bold mx-2 " Font-Size="X-Small" SetFocusOnError="true" ErrorMessage="(*) required" ValidationGroup="fields" ControlToValidate="inputModel" runat="server" />
                </div>
            </div>
            <div class="form-group  row ">
                <div class="form-group col-md-4">
                    <asp:Label runat="server" CssClass="fw-bold  ">Original</asp:Label><span class=" d-inline text-danger fw-bold"> *</span>
                    <asp:TextBox runat="server" type="text" class="form-control" ID="inputOriginal" placeholder="Original part number"></asp:TextBox>
                    <asp:RequiredFieldValidator CssClass="text-danger fw-bold mx-2" Font-Size="X-Small" SetFocusOnError="true" ErrorMessage="(*) required" ValidationGroup="fields" ControlToValidate="inputOriginal" runat="server" />
                </div>
                <div class="form-group col-md-4">
                    <asp:Label runat="server" CssClass="fw-bold  ">Alternate</asp:Label><span class=" d-inline text-danger fw-bold"> *</span>
                    <asp:TextBox runat="server" class="form-control" ID="inputAlternate" placeholder="Alternate part number"></asp:TextBox>
                    <asp:RequiredFieldValidator CssClass="text-danger fw-bold mx-2" Font-Size="X-Small" SetFocusOnError="true" ErrorMessage="(*) required" ValidationGroup="fields" ControlToValidate="inputAlternate" runat="server" />
                </div>
                <div class="form-group col-md-4">
                    <asp:Label runat="server" CssClass="fw-bold  ">ECN</asp:Label>
                    <asp:TextBox runat="server" class="form-control" ID="inputECN" placeholder="ECN-MX(XXXX)"></asp:TextBox>
                </div>
            </div>
            <div class="  form-group mt-3 ">
                <asp:LinkButton ID="NewBtn" runat="server" class=" rounded-3 btn btn-dark " OnClick="NewBtn_Click" Visible="false"><i class="bi bi-file-earmark-plus"></i> Add new alternate part</asp:LinkButton>
                <asp:LinkButton ID="btnReset" runat="server" class=" rounded-3 btn btn-primary" OnClick="btnReset_Click" Visible="false"><i class="bi bi-arrow-repeat"></i> Reset </asp:LinkButton>
                <asp:LinkButton ID="SaveBtn" ValidationGroup="fields" runat="server" class="rounded-3 btn btn-success" OnClick="SaveBtn_Click" Visible="false"><i class="bi bi-floppy2-fill"></i> Save</asp:LinkButton>
                <asp:LinkButton ID="UpdateBtn" runat="server" class="rounded-3  btn btn-warning" OnClick="UpdateBtn_Click" Visible="false"><i class="bi bi-database-fill-check"></i> Update</asp:LinkButton>
                <asp:LinkButton ID="ClearBtn" runat="server" class="rounded-3 btn btn-danger " OnClick="ClearBtn_Click" Visible="false"><span runat="server"  class="bi bi-input-cursor-text"></span> Cancel</asp:LinkButton>
            </div>
        </div>
        <div class="container mt-2">
            <div class="form-group mb-3 ">
                <div class="input-group ">
                    <asp:LinkButton ID="CancelBtn" Visible="false" CssClass=" btn btn-danger fw-bold" runat="server" OnClick="CancelBtn_Click" Text="" ToolTip="Cancel query"><i class="bi bi-x-lg"></i></asp:LinkButton>
                    <asp:LinkButton ID="QueryBtn" Visible="false" CssClass="btn btn-dark fw-bold " OnClick="QueryBtn_Click" runat="server" ToolTip="Click to enable query"><i runat="server" class="bi bi-funnel-fill"></i></asp:LinkButton>
                    <asp:TextBox ID="filterText" CssClass="form-control filter text-center text-body-secondary" Enabled="false" TextMode="Search" AutoPostBack="true" OnTextChanged="filterText_TextChanged" runat="server" class="form-control" placeholder="Search by work order or model, original or alternate partnumber..."></asp:TextBox>
                    <asp:LinkButton ID="SearchBtn" Visible="false" CssClass=" btn btn-dark fw-bold" OnClick="SearchBtn_Click" runat="server" Text="" ToolTip="Search"><i class="bi bi-search"></i></asp:LinkButton>
                    <asp:LinkButton ID="RefreshBtn" Visible="false" CssClass=" btn btn-primary fw-bold" runat="server" OnClick="RefreshBtn_Click" Text="" ToolTip="Refresh table"><i class="bi bi-arrow-clockwise"></i></asp:LinkButton>
                </div>
            </div>
            <div class="form-row">
                <div class="rounded table-responsive table table-secondary ">
                    <asp:GridView runat="server" ID="myTable" OnRowDataBound="myTable_RowDataBound" OnRowCommand="myTable_RowCommand" HeaderStyle-HorizontalAlign="Center" OnPageIndexChanging="myTable_PageIndexChanging" OnSelectedIndexChanged="myTable_SelectedIndexChanged" CssClass="table" ShowHeaderWhenEmpty="true" AutoGenerateColumns="false" DataKeyNames="WorkOrder" AllowPaging="false" BorderStyle="None" PageSize="20" >
                        <HeaderStyle VerticalAlign="Middle" HorizontalAlign="Center" BackColor="#ebebeb" />
                        <RowStyle VerticalAlign="Middle" HorizontalAlign="Center" />
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
                                    <div class="">
                                        <asp:LinkButton runat="server" ID="addButton" CssClass=" btn-default rounded add mt-2" OnClick="addButton_Click"><span class=" bitbi-arrow-clockwise"></span> Add new</asp:LinkButton>
                                    </div>
                                </div>
                            </div>
                        </EmptyDataTemplate>
                        <Columns>
                            <asp:ButtonField ButtonType="Image" Text="Edit" ImageUrl="./Resources/images/icons/pencil.png" CommandName="Editar" HeaderText="Edit" ItemStyle-Width="5%" />
                            <asp:BoundField DataField="ID" HeaderText="ID" ReadOnly="True" InsertVisible="true" />
                            <asp:BoundField DataField="WorkOrder" HeaderText="WorkOrder" ReadOnly="True" ItemStyle-CssClass="fw-bold" ItemStyle-Width="12%" />
                            <asp:BoundField DataField="KittingNote" HeaderText="KN"></asp:BoundField>
                            <asp:BoundField DataField="Model" HeaderText="Model"></asp:BoundField>
                            <asp:BoundField DataField="PartNumber" HeaderText="Original" ItemStyle-CssClass="fw-bold"></asp:BoundField>
                            <asp:BoundField DataField="AlternatePartNumber" HeaderText="Alternate" ItemStyle-CssClass="fw-bold"></asp:BoundField>
                            <asp:BoundField DataField="ECN" HeaderText="ECN"></asp:BoundField>
                            <asp:ButtonField ButtonType="Image" ImageUrl="./Resources/images/icons/trash.png" Text="Delete" CommandName="ComDelete" HeaderText="Eliminar" ItemStyle-Width="5%" />
                        </Columns>
                        <PagerStyle CssClass="GridPager" HorizontalAlign="Center" />
                    </asp:GridView>
                </div>
                <%--   <asp:LinkButton CssClass="btn btn-dark fw-bold" ID="ExportBtn" runat="server" Visible="false" OnClick="ExportBtn_Click">
            <span class="bi bi-printer-fill" aria-hidden="true"></span> &nbsp;Exportar
                </asp:LinkButton>--%>
            </div>
        </div>
        <%--  <div class="input-group mt-2 fixed-bottom">
            <asp:LinkButton ID="LinkButton1" Visible="true" CssClass=" btn btn-success fw-bold" OnClick="ExportBtn_Click" runat="server" Text="EXPORT" ToolTip="Export this table to excel"><i class="bi bi-file-earmark-excel-fill"></i>EXPORT EXCEL</asp:LinkButton>
        </div>--%>
    </form>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>
