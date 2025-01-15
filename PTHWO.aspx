<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PTHWO.aspx.cs" EnableEventValidation="false" Inherits="ManageWO.PTHWO" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta name="description" title="Create, update and delete Work Orders for PTH" />
    <link href="~/resources/images/icon.ico" rel="shortcut icon" />
    <link rel="stylesheet" href="Resources/CSS/Styles.css" />
    <link rel="stylesheet" href="Resources/CSS/site.css" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" />
    <!-- Font Awesome CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

    <title>PTH - Work Order Management</title>
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
                            <a class="nav-link text-white" href="#" title="CREATE, UPDATE, DELETE WORK ORDER">WO</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" title="Upload, delete, and update Kitting note pth" href="./pthkn.aspx">KN</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" title="Upload serial numbers" href="#">SN</a>
                        </li>
                        <%--                        <li class="nav-item">
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

        <div class="container mt-1 mx-auto">
            <%-- alerta --%>
            <div runat="server" id="alert" visible="false" class=" d-flex align-items-center" role="alert">
                <span id="AlertIcon" runat="server" class=" flex-shrink-0 me-2" role="img"></span>
                <asp:Label runat="server" CssClass="fw-bold" ID="alertText" Text="">
                </asp:Label>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>

            <div class="form-group col-md-0">
                <asp:Label CssClass="fw-bold" Visible="false" runat="server" for="inputID">ID</asp:Label>
                <asp:TextBox runat="server" require="required" type="text" Visible="false" class="form-control " ID="inputID" aria-describedby="basic-addon1" Enabled="false" placeholder="ID"></asp:TextBox>
            </div>
            <div class="form-group row">
                <div class="form-group col-md-6">
                    <asp:Label CssClass="fw-bold" runat="server">Work Order</asp:Label>
                    <asp:TextBox runat="server" Style="text-transform: uppercase" type="text" class="form-control " ID="inputWorkorder" aria-describedby="basic-addon1" placeholder="WORK ORDER" OnTextChanged="inputWorkorder_TextChanged" AutoCompleteType="Disabled"></asp:TextBox>
                    <asp:RequiredFieldValidator CssClass="text-danger fw-bold mx-2" Font-Size="X-Small" SetFocusOnError="true" ErrorMessage="(*) required" ValidationGroup="fields" ControlToValidate="inputWorkorder" runat="server" />
                </div>
                <div class="form-group col-md-6">
                    <asp:Label runat="server" CssClass="fw-bold" for="inputModel">Model</asp:Label>
                    <asp:TextBox runat="server" Style="text-transform: uppercase" type="text" class="form-control " ID="inputModel" placeholder="MODEL (MX9XXXXXXXXXXX)" AutoCompleteType="Disabled"></asp:TextBox>
                    <asp:RequiredFieldValidator CssClass="text-danger fw-bold mx-2" Font-Size="X-Small" SetFocusOnError="true" ErrorMessage="(*) required" ValidationGroup="fields" ControlToValidate="inputModel" runat="server" />
                </div>
                <div class="form-group col-md-4">
                    <asp:Label runat="server" CssClass="fw-bold">Main</asp:Label>
                    <asp:TextBox runat="server" Style="text-transform: uppercase" AutoCompleteType="Disabled" type="text" class="form-control " ID="inputMain" placeholder="MX1XXXXXXXXXXX"></asp:TextBox>
                    <asp:RequiredFieldValidator CssClass="text-danger fw-bold mx-2" Font-Size="X-Small" SetFocusOnError="true" ErrorMessage="(*) required" ValidationGroup="fields" ControlToValidate="inputMain" runat="server" />
                </div>
                <div class="form-group col-md-3">
                    <asp:Label runat="server" CssClass="fw-bold" for="inputAddress">WO Quantity</asp:Label>
                    <asp:TextBox runat="server" Style="text-transform: uppercase" type="number" step="1" class="form-control " ID="inputQty" placeholder="WO QTY" AutoCompleteType="Disabled"></asp:TextBox>
                    <asp:RequiredFieldValidator CssClass="invalid-feedback" Font-Size="X-Small" SetFocusOnError="true" ErrorMessage="(*) required" ValidationGroup="fields" ControlToValidate="inputQty" runat="server" />
                </div>
                <div class="form-group col-md-3">
                    <asp:Label runat="server" CssClass="fw-bold" for="inputCommit">WO Commit</asp:Label>
                    <asp:TextBox runat="server" Style="text-transform: uppercase" type="number" step="1" class="form-control text-body-secondary" ID="inputCommit" placeholder="Commit qty" AutoCompleteType="Disabled"></asp:TextBox>
                    <asp:RequiredFieldValidator CssClass="text-danger fw-bold mx-2" Font-Size="X-Small" SetFocusOnError="true" ErrorMessage="(*) required" ValidationGroup="fields" ControlToValidate="inputCommit" runat="server" />
                </div>
                <div class="form-group col-md-2">
                    <asp:Label runat="server" CssClass="fw-bold" for="inputUPH">Rate</asp:Label>
                    <asp:TextBox runat="server" Style="text-transform: uppercase" type="number" step="1" class="form-control text-body-secondary" ID="inputUPH" placeholder="UPH(RATE)" AutoCompleteType="Disabled"></asp:TextBox>
                    <asp:RequiredFieldValidator CssClass="text-danger fw-bold mx-2" Font-Size="X-Small" SetFocusOnError="true" ErrorMessage="(*) required" ValidationGroup="fields" ControlToValidate="inputUPH" runat="server" />
                </div>
                <div class=" row g-2">
                    <div class=" botonera form-group mb-3 ">
                        <asp:LinkButton ID="NewBtn" runat="server" type="submit" Text="NEW" class="rounded-2 btn btn-dark " OnClick="NewBtn_Click" Visible="false"><i class="bi bi-file-earmark-plus"></i> NEW WORK ORDER</asp:LinkButton>
                        <asp:LinkButton ID="SaveBtn" runat="server" ValidationGroup="fields" type="submit" Text="SAVE" class="rounded-2 btn btn-success" OnClick="SaveBtn_Click" Visible="false"><i class="bi bi-database-fill-up"></i> Save</asp:LinkButton>
                        <asp:LinkButton ID="DeleteBtn" runat="server" type="submit" Text="DELETE" class="rounded-2 btn btn-danger " OnClick="DeleteBtn_Click" Visible="false"><i class="bi bi-trash3-fill"></i> Delete</asp:LinkButton>
                        <asp:LinkButton ID="ClearBtn" runat="server" type="submit" class="rounded-2 btn btn-danger " OnClick="ClearBtn_Click" Visible="false"><span runat="server" id="icono" class="bi bi-eraser-fill"></span> Cancel </asp:LinkButton>
                        <asp:LinkButton ID="EditBtn" runat="server" type="submit" Text="EDIT" class="rounded-2 btn btn-danger" OnClick="EditBtn_Click" Visible="false"><i class="bi bi-pencil-square"></i> Edit</asp:LinkButton>
                        <asp:LinkButton ID="UpdateBtn" runat="server" type="submit" Text="EDIT" class=" rounded-2 btn btn-success" OnClick="UpdateBtn_Click" Visible="false"><i class="bi bi-database-fill-check"></i> Save changes</asp:LinkButton>
                        <asp:LinkButton ID="AbortBtn" runat="server" type="submit" Text="EDIT" class=" rounded-2 btn btn-warning" OnClick="AbortBtn_Click" Visible="false"><i class="bi bi-database-fill-check"></i> Update </asp:LinkButton>
                    </div>
                </div>
                <div class=" row g-2">
                    <div class="input-group text-end w-100  ">
                        <asp:LinkButton ID="CancelBtn" Visible="false" CssClass=" btn btn-danger fw-bold" runat="server" OnClick="CancelBtn_Click" Text="" ToolTip="Cancel query"><i class="bi bi-x-lg"></i> </asp:LinkButton>
                        <asp:LinkButton ID="QueryBtn" Visible="false" CssClass="btn btn-dark fw-bold " OnClick="QueryBtn_Click" runat="server" ToolTip="Click to enable query"><i runat="server" class="bi bi-funnel-fill"></i></asp:LinkButton>
                        <asp:TextBox ID="filterText" CssClass="form-control   text-center text-body-secondary" Enabled="false" TextMode="Search" AutoPostBack="true" AutoCompleteType="Disabled" OnTextChanged="filterText_TextChanged" runat="server" class="form-control" placeholder="Search by work order or model..."></asp:TextBox>
                        <asp:LinkButton ID="SearchBtn" Visible="false" CssClass=" btn btn-dark fw-bold" OnClick="SearchBtn_Click" runat="server" Text="" ToolTip="Search"><i class="bi bi-search"></i></asp:LinkButton>
                        <asp:LinkButton ID="RefreshBtn" Visible="false" CssClass=" btn btn-primary fw-bold" runat="server" OnClick="RefreshBtn_Click" Text="" ToolTip="Refresh table"><i class="bi bi-arrow-clockwise"></i></asp:LinkButton>

                    </div>
                </div>

                <div class="form-row mt-1 ">
                    <div class="rounded table-responsive  ">
                        <%--<div class="rounded  bg-white table-responsive ">--%>
                        <asp:GridView runat="server" ID="myTable" OnRowDataBound="myTable_RowDataBound" HeaderStyle-BackColor="#ebebeb" OnPageIndexChanging="myTable_PageIndexChanging" OnSelectedIndexChanged="myTable_SelectedIndexChanged" OnRowCommand="myTable_RowCommand" CssClass="table" ShowHeaderWhenEmpty="true" AutoGenerateColumns="false" DataKeyNames="WorkOrder" AutoGenerateSelectButton="false" AllowPaging="true" BorderStyle="None">
                            <HeaderStyle VerticalAlign="Middle" HorizontalAlign="Center" CssClass="table-secondary" />

                            <RowStyle VerticalAlign="Middle" HorizontalAlign="Center" />
                            <EmptyDataTemplate>
                                <span class="placeholder col-6"></span>
                                <span class="placeholder w-75"></span>
                                <span class="placeholder" style="width: 25%;"></span>
                            </EmptyDataTemplate>

                            <Columns>
                                <asp:ButtonField ButtonType="Image" Text="Edit" ImageUrl="./Resources/images/icons/pencil.png" CommandName="Editar" HeaderText="Edit" ItemStyle-Width="5%" />
                                <%--<asp:BoundField DataField="ID" HeaderText="ID" ReadOnly="True" InsertVisible="true" SortExpression="ID" ItemStyle-CssClass="text-body-secondary"  />--%>
                                <asp:BoundField DataField="WorkOrder" HeaderText="WorkOrder" ReadOnly="True" SortExpression="WorkOrder" ItemStyle-CssClass="text-body-secondary fw-bold" ItemStyle-Width="10%" />
                                <asp:BoundField DataField="Model" HeaderText="Model" SortExpression="Model" ItemStyle-CssClass="text-body-secondary" ItemStyle-Width="20%" HeaderStyle-HorizontalAlign="Left" />
                                <asp:BoundField DataField="Main" HeaderText="Main" SortExpression="Main" ItemStyle-CssClass="text-body-secondary" ItemStyle-Width="20%" HeaderStyle-HorizontalAlign="Left" />
                                <asp:BoundField DataField="Quantity" HeaderText="Quantity" SortExpression="Quantity" ItemStyle-CssClass="text-body-secondary" ItemStyle-Width="6%" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" />
                                <asp:BoundField DataField="Rate" HeaderText="Rate" SortExpression="Rate" ItemStyle-CssClass="text-body-secondary" ItemStyle-Width="6%" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" />
                                <asp:BoundField DataField="QtyCommit" HeaderText="Commit" SortExpression="QtyCommit" ItemStyle-CssClass="text-body-secondary" ItemStyle-Width="6%" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" />
                                <asp:ButtonField ButtonType="Image" ImageUrl="./Resources/images/icons/trash.png" Text="Delete" CommandName="ComDelete" HeaderText="Delete" ItemStyle-Width="5%" ItemStyle-CssClass="text-body-secondary" ItemStyle-HorizontalAlign="Center" />
                            </Columns>
                            <PagerStyle HorizontalAlign="Center" CssClass="GridPager" />
                        </asp:GridView>
                    </div>
                    <asp:LinkButton CssClass="btn btn-dark fw-bold" ID="ExportBtn" runat="server" Visible="false" OnClick="ExportBtn_Click">
                            <span class="bi bi-printer-fill" aria-hidden="true"></span> &nbsp;Exportar
                    </asp:LinkButton>
                </div>
                <hr />
            </div>
            <%-- Fin off Gridview --%>
        </div>
    </form>
</body>
</html>
