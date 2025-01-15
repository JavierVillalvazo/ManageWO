<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="edit_pthkn.aspx.cs" Inherits="ManageWO.edit_pthkn" %>

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
    <%--<link  rel="stylesheet" href="https://cdn.jsdelivr.net/gh/iconoir-icons/iconoir@main/css/iconoir.css" />--%>

    <title>Edit Kitting Note - PTH</title>
</head>
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
                        <li class="nav-item  ">
                            <a class="nav-link " href="#" title="CREATE, UPDATE, DELETE WORK ORDER">WO</a>
                        </li>
                        <li class="nav-item active fw-bold">
                            <a class="nav-link text-white" title="Upload, delete, and update Kitting note pth" href="./pthkn.aspx">KN</a>
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
        <div class="container mt-2 mx-auto">
            <div runat="server" id="alert" visible="false" class=" d-flex align-items-center" role="alert">
                <span id="AlertIcon" runat="server" class=" flex-shrink-0 me-2" role="img"></span>
                <asp:Label runat="server" CssClass="fw-bold" ID="alertText" Text="">
                </asp:Label>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            <div runat="server" id="divFilter" visible="true" class="row d-flex justify-content-end mt-2">
                <div class="col-md-6 text-md-end mb-2">
                    <asp:LinkButton runat="server" ID="addModal" Font-Size="Small" data-bs-target="#exampleModalToggle" data-bs-toggle="modal" CssClass="btn btn-primary " Visible="true">
                     <i class="bi bi-clipboard2-plus"></i> Add PartNumber 
                    </asp:LinkButton>
                    <asp:LinkButton runat="server" ID="btnUploadKN" Font-Size="Small" CssClass="btn btn-dark  " Visible="true" PostBackUrl="~/PTHKN.aspx">
                     <i class="bi bi-folder-plus"></i> Manage KN 
                    </asp:LinkButton>
                    <%-- <asp:LinkButton runat="server" type="button" Font-Size="Small" class="btn btn-secondary " Visible="true" data-bs-target="#ModalUploadKN" data-bs-toggle="modal"><i class="bi bi-folder-plus"></i> Upload KN</asp:LinkButton>--%>
                </div>
                <div class=" col-md-4 col-lg-3 mb-2">
                    <div class="input-group ">
                        <asp:Label runat="server" class="input-group-text fw-bold bg-outline-dark " Font-Size="Small" for="autoSizingSelect">Search by</asp:Label>
                        <asp:DropDownList ID="ddlSearchBy" runat="server" Font-Size="Small" CssClass="form-select  " Visible="true" AutoPostBack="True"
                            OnSelectedIndexChanged="ddlSearchBy_SelectedIndexChanged">
                            <asp:ListItem Text="All"></asp:ListItem>
                            <asp:ListItem Text="WorkOrder"></asp:ListItem>
                            <asp:ListItem Text="PartNumber"></asp:ListItem>
                            <%--<asp:ListItem Text="Preforming"></asp:ListItem>
                            <asp:ListItem Text="PTH"></asp:ListItem>--%>

                        </asp:DropDownList>
                    </div>
                </div>
                <div class="col-md-4 col-lg-3 mb-2 ">
                    <div class="input-group ">
                        <asp:TextBox runat="server" Font-Size="Small" TextMode="Search" CssClass="form-control text-start" Visible="true" ID="txtSearch" OnTextChanged="txtSearch_TextChanged" AutoPostBack="true" aria-describedby="basic-addon1" placeholder="All" AutoCompleteType="Disabled"></asp:TextBox>
                        <asp:LinkButton runat="server" Font-Size="Small" ID="btnSearch" OnClick="btnSearch_Click" Visible="true" class="btn btn-primary"><i class="bi bi-search"></i>
                        </asp:LinkButton>
                        <asp:LinkButton runat="server" ID="btnFilter" Font-Size="Small" OnClick="btnFilter_Click" Visible="false" class="btn btn-danger">
<i class="bi bi-x-circle"></i>
                        </asp:LinkButton>
                    </div>
                </div>
            </div>
            <div class="row mt-1  ">
                <asp:GridView runat="server" ID="myTable" OnRowUpdating="myTable_RowUpdating"
                    ClientIDMode="AutoID"
                    HeaderStyle-BackColor="#ebebeb" CssClass="table table-hover  table-responsive "
                    BorderStyle="None" ShowHeaderWhenEmpty="true" AutoGenerateColumns="false" OnPageIndexChanging="myTable_PageIndexChanging"
                    OnRowEditing="myTable_RowEditing" OnRowCancelingEdit="myTable_RowCancelingEdit"
                    DataKeyNames="WorkOrder" AllowPaging="true" data-bs-theme="light" Height="60%"
                    PageSize="20">
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
                        <asp:TemplateField ShowHeader="true" ItemStyle-Width="10%" ControlStyle-Height="80%" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" FooterText="Actions" HeaderText="Actions" ControlStyle-CssClass=" btn btn-sm btn-secondary  text-center">
                            <ItemTemplate>
                                <asp:LinkButton runat="server" CssClass="btn btn-warning " CommandName="Edit" CausesValidation="True" ID="editBtnGrid"><i class="bi bi-pencil-fill "></i> Edit</asp:LinkButton>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:LinkButton runat="server" CssClass="btn btn-save" CommandName="Update" CausesValidation="True" ID="saveBtnGrid" ToolTip="Click to update partnumber" OnClientClick="return confirm('Are you sure you want to modify this record?');" BackColor="#008959" BorderColor="#008959"><i class="bi bi-floppy2-fill"></i> Save</asp:LinkButton>
                                <asp:LinkButton runat="server" CssClass="btn btn-outline-danger" CommandName="Cancel" ToolTip="Cancel edit operation" CausesValidation="True" BackColor="#cf182e" BorderColor="#cf182e" ID="cancelBtnGrid"> <i class="bi bi-x-circle"></i> Cancel</asp:LinkButton>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="ID" ItemStyle-Width="3%" ItemStyle-HorizontalAlign="Center" ItemStyle-CssClass="text-body-secondary fw-bold">
                            <ItemTemplate>
                                <asp:Label ID="lblID" Font-Size="XX-Small" runat="server" Text='<%# Eval("ID") %>'></asp:Label>
                            </ItemTemplate>

                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="WorkOrder" ItemStyle-Width="5%" ItemStyle-HorizontalAlign="Center" ItemStyle-CssClass="text-body-secondary fw-bold">
                            <ItemTemplate>
                                <asp:Label ID="lblWorkOrder" runat="server" Text='<%# Eval("WorkOrder") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="PartNumber" ItemStyle-Width="8%" ItemStyle-HorizontalAlign="Center" ItemStyle-CssClass="text-body-secondary fw-bold">
                            <ItemTemplate>
                                <asp:Label ID="lblPartNumber" runat="server" Text='<%# Eval("PartNumber") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox runat="server" BackColor="#ffdd73" ID="txtPartNumber" Style="text-transform: uppercase" Text='<%# Eval("PartNumber") %>' CssClass="form-control fw-bold text-center " Font-Size="Small" AutoCompleteType="Disabled"></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Description" ItemStyle-Width="10%" ItemStyle-HorizontalAlign="Center" ItemStyle-CssClass="text-body-secondary fw-bold">
                            <ItemTemplate>
                                <asp:Label ID="lblDescription" Font-Size="Smaller" runat="server" Text='<%# Eval("Description") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox runat="server" BackColor="#ffdd73" ID="txtDescription" Style="text-transform: uppercase" Text='<%# Eval("Description") %>' CssClass="form-control fw-bold text-center  " Font-Size="Small" AutoCompleteType="Disabled"></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Qty to issue" ItemStyle-Width="6%" ItemStyle-HorizontalAlign="Center" ItemStyle-CssClass="text-body-secondary fw-bold">
                            <ItemTemplate>
                                <asp:Label ID="lblKNQty" runat="server" Text='<%# Eval("Quantity") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox BackColor="#ffdd73" runat="server" ID="txtKNQty" Font-Size="Small" Text='<%# Eval("Quantity") %>' CssClass="form-control fw-bold text-center  " AutoCompleteType="Disabled"></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="QPA" ItemStyle-Width="6%" ItemStyle-HorizontalAlign="Center" ItemStyle-CssClass="text-body-secondary fw-bold">
                            <ItemTemplate>
                                <asp:Label ID="lblQPA" runat="server" Text='<%# Eval("QPA") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox BackColor="#ffdd73" runat="server" ID="txtQPA" Font-Size="Small" Text='<%# Eval("QPA") %>' CssClass="form-control fw-bold text-center  " AutoCompleteType="Disabled"></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Delete" ItemStyle-Width="3%" ItemStyle-Height="5px" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center">
                            <ItemTemplate>
                                <asp:LinkButton runat="server" data-bs-target="#exampleModalToggle" data-bs-toggle="modal" CssClass="btn  btn-outline-danger   border border-0" ToolTip="Delete current row" OnClientClick="return window.confirm('Do you want to delete the selected record?');"> <i class="bi bi-trash3-fill"></i></asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <SelectedRowStyle BackColor="Turquoise" />
                    <EditRowStyle BackColor="LightYellow" />
                    <PagerStyle HorizontalAlign="Center" CssClass="GridPager" />
                    <PagerSettings Mode="NextPreviousFirstLast" PageButtonCount="8" FirstPageText="First" LastPageText="Last" />
                </asp:GridView>
            </div>
            <asp:LinkButton CssClass="btn btn-dark fw-bold" ID="ExportBtn" runat="server" Visible="false">
          <span class="bi bi-printer-fill" aria-hidden="true"></span> &nbsp;Exportar
            </asp:LinkButton>
        </div>
        <%-- Modal --%>
        <div class="modal fade" id="exampleModalToggle" runat="server" aria-hidden="true" aria-labelledby="exampleModalToggleLabel" tabindex="-1" data-bs-backdrop="static" data-bs-keyboard="false" data-bs-theme="light">
            <div class="modal-dialog modal-dialog modal-lg modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header bg-dark">
                        <label class="modal-title fs-5 text-white fw-bold" id="exampleModalToggleLabel">Add PartNumber &nbsp;  </label>
                        <i class="bi bi-arrow-right text-success fs-5"></i>&nbsp;
                     <asp:Label runat="server" CssClass=" rounded-pill bg-success px-3 fs-6 text-white" Text="Kitting Note PTH" ID="dataWO"></asp:Label>
                        <asp:Button Style="" runat="server" ForeColor="White" type="button" class="btn-close btn btn-danger text-white" data-bs-dismiss="modal" aria-label="Close"></asp:Button>
                    </div>
                    <div class="modal-body mx-auto w-50" data-bs-theme="dark">
                        <div class="form-group col-auto ">
                            <asp:Label runat="server" CssClass="fw-bold mb-1" for="inputModel">WorkOrder</asp:Label>
                            <asp:TextBox runat="server" class="form-control " Style="text-transform: uppercase" ID="inputWorkOrder" AutoCompleteType="Disabled"></asp:TextBox>
                            <asp:RequiredFieldValidator CssClass="text-danger fw-bold mx-2" Font-Size="X-Small" SetFocusOnError="true" ErrorMessage="(*) required" ValidationGroup="fields" ControlToValidate="inputWorkOrder" runat="server" />
                        </div>
                        <div class="form-group col-auto">
                            <asp:Label runat="server" CssClass="fw-bold mb-1" for="inputModel">PartNumber</asp:Label>
                            <asp:TextBox runat="server" Style="text-transform: uppercase" type="text" class="form-control " ID="inputPartNumber" AutoCompleteType="Disabled"></asp:TextBox>
                            <asp:RequiredFieldValidator CssClass="text-danger fw-bold mx-2" Font-Size="X-Small" SetFocusOnError="true" ErrorMessage="(*) required" ValidationGroup="fields" ControlToValidate="inputPartNumber" runat="server" />
                        </div>
                        <div class="form-group col-auto">
                            <asp:Label runat="server" CssClass="fw-bold mb-1" for="inputModel">Description</asp:Label>
                            <asp:TextBox runat="server" type="text" Style="text-transform: uppercase" class="form-control " ID="inputDescription" AutoCompleteType="Disabled"></asp:TextBox>
                            <asp:RequiredFieldValidator CssClass="text-danger fw-bold mx-2" Font-Size="X-Small" SetFocusOnError="true" ErrorMessage="(*) required" ValidationGroup="fields" ControlToValidate="inputDescription" runat="server" />
                        </div>
                        <div class="row">
                            <div class="form-group col-lg-6 ">
                                <asp:Label runat="server" CssClass="fw-bold mb-1" for="inputModel">Quantity</asp:Label>
                                <asp:TextBox runat="server" TextMode="Number" step="1" class="form-control " ID="inputQty" placeholder="Qty To Issue" AutoCompleteType="Disabled"></asp:TextBox>
                                <asp:RequiredFieldValidator CssClass="text-danger fw-bold mx-2" Font-Size="X-Small" SetFocusOnError="true" ErrorMessage="(*) required" ValidationGroup="fields" ControlToValidate="inputQty" runat="server" />
                            </div>
                            <div class="form-group col-lg-6 ">
                                <asp:Label runat="server" CssClass="fw-bold mb-1" for="inputModel"> QPA</asp:Label>
                                <asp:TextBox runat="server" TextMode="Number" step="1" class="form-control " ID="inputQPA" placeholder="Std QPA" AutoCompleteType="Disabled"></asp:TextBox>
                                <asp:RequiredFieldValidator CssClass="text-danger fw-bold mx-2" Font-Size="X-Small" SetFocusOnError="true" ErrorMessage="(*) required" ValidationGroup="fields" ControlToValidate="inputQPA" runat="server" />
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <asp:LinkButton runat="server" OnClick="btnAdd_Click" CssClass="btn btn-primary" ID="btnAdd" ValidationGroup="fields"><i class="bi bi-clipboard2-plus"></i> Add new</asp:LinkButton>
                        <asp:LinkButton runat="server" CssClass="btn btn-outline-danger" ID="btnCloseModal"><i class="bi bi-x-circle"></i>  Cancel</asp:LinkButton>
                    </div>
                </div>
            </div>
        </div>
        <%-- Modal 2 --%>
        <div class="modal fade" id="ModalUploadKN" tabindex="-1" data-bs-backdrop="static" data-bs-keyboard="false" data-bs-theme="light">
            <div class="modal-dialog modal-dialog modal-dialog modal-lg modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header bg-dark">
                        <label class="modal-title fs-5 text-white fw-bold" id="exampleModalToggleLabel2">Kitting note SMT        - Excel</label>
                        <asp:Button Style="" runat="server" ForeColor="White" type="button" class="btn-close btn btn-danger text-white" data-bs-dismiss="modal" aria-label="Close"></asp:Button>
                    </div>
                    <div class="modal-body w-100  mx-auto w-50" data-bs-theme="light">
                        <div class="input-group mt-3 mb-3  col-sm-12">
                            <asp:FileUpload ID="fuData" CssClass="form-control" runat="server" />

                        </div>
                    </div>
                    <div class="modal-footer">
                        <asp:LinkButton ID="btnUpload" runat="server" CssClass="  btn     btn-primary" OnClick="btnUpload_Click"> <i class="bi bi-cloud-upload"></i>  Upload </asp:LinkButton>
                        <asp:LinkButton runat="server" type="button" class="btn btn-outline-danger" data-dismiss="modal"> <i class="bi bi-x-circle"></i> Close</asp:LinkButton>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
