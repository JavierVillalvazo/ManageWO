<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UsersManagement.aspx.cs" Inherits="ManageWO.UsersManagement" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link href="~/resources/images/icon.ico" rel="shortcut icon" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.4/font/bootstrap-icons.css" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://ajax.aspnetcdn.com/ajax/jquery/jquery-1.9.0.min.js"></script>

    <link rel="stylesheet" href="https://necolas.github.io/normalize.css/8.0.1/normalize.css" />
    <link rel="stylesheet" href="Resources/CSS/Styles.css" />
    <link rel="stylesheet" href="Resources/CSS/site.css" />
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" />
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@300;400;700&display=swap" rel="stylesheet" />
    <%--TODO: agregar script js--%>
    <script type="text/javascript">
        function disableBack() { window.history.forward(); } -
            setTimeout("disableBack()", 0);
        window.onunload = function () { null };
    </script>
    <title>Manage users</title>
</head>
<body>
<form id="form1" runat="server">
        <nav class="navbar sticky-top navbar-expand-lg navbar-toggleable-sm navbar-dark bg-dark ">
            <div class="container-lg">
                <a class="navbar-brand m-auto" href="./Default.aspx">
                    <img id="logo" src="./resources/images/inv.png" /></a>
                <button type="button" class="navbar-toggler" data-bs-toggle="collapse" data-bs-target=".navbar-collapse" title="Toggle navigation" aria-controls="navbarSupportedContent"
                    aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse  d-sm-inline-flex mx-auto">
                    <ul class="navbar-nav mx-auto">
                        <li>
                            <h4 style="text-align: center;" class=" text-white d-inline">ADMINISTRACIÓN DE USUARIOS MMC</h4>
                        </li>
                    </ul>
                </div>
            </div>
            <ul class=" navbar-collapse collapse navbar-nav">
                <li>
                    <asp:Label runat="server" ID="lblUser" CssClass="text-warning fw-bold me-auto p-2 " Text="" ToolTip="Usuario Actual"></asp:Label>
                    <asp:LinkButton runat="server" ID="RegresarBtn" class=" fw-bold btn btn-primary    " type="button" title="Regresar al Menu"><span class=" fw-bold bi bi-arrow-left-circle" ></span></asp:LinkButton>
                    <asp:LinkButton type="button" ID="logoutBtn" runat="server" class="btn btn-danger fw-bold  " title="Salir del Sistema"><span runat="server" class=" fw-bold bi bi-box-arrow-left"></span></asp:LinkButton>
                </li>
            </ul>
        </nav>
        <div class="container-fluid">
            <div class="container-xl ">
                <%-- Input serial number --%>
                <div class="form-floating mx-auto p-2  mt-2">
                    <%-- ALerta --%>
                    <div runat="server" id="alert" visible="false" class=" d-flex align-items-center mt-2" role="alert">
                        <span id="AlertIcon" runat="server" class=" flex-shrink-0 me-2" role="img"></span>
                        <asp:Label runat="server" CssClass="fw-bold" ID="alertText" Text=""></asp:Label>
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </div>
                <%-- Tarjeta --%>
                  <hr />
                    <div class="row g-2 " runat="server" id="FormUser" visible="false">
                        <div class="col-md">
                            <div class="form-floating">
                                <asp:TextBox class="form-control text-primary fw-bold " AutoCompleteType="Disabled" ID="dataFullName" runat="server"></asp:TextBox>
                                <label for="dataLocation" class=" text-black fw-bold">Nombre completo</label>
                            </div>
                        </div>
                        <div class="col-md">
                            <div class="form-floating">
                                <asp:TextBox class="form-control text-primary fw-bold " AutoCompleteType="Disabled" ID="DataEmployeeNumber" runat="server"></asp:TextBox>
                                <label for="dataLocation" class="text-black fw-bold"># Empleado</label>
                            </div>
                        </div>
                        <div class="col-md">
                            <div class="form-floating">
                                <asp:DropDownList runat="server" ID="dataArea" DataTextField="Text" DataValueField="Value" CssClass="form-select col-md-4 text-primary fw-bold " aria-label="Floating label select example" AutoPostBack="false">
                                    <asp:ListItem Enabled="true" hidden="true" Selected="True" Text="Selecciona una opción"></asp:ListItem>
                                    <asp:ListItem Value="IT">IT</asp:ListItem>
                                    <asp:ListItem Value="Planeacion">Planeacion</asp:ListItem>
                                    <asp:ListItem Value="Calidad">Calidad</asp:ListItem>
                                    <asp:ListItem Value="Compras">Compras</asp:ListItem>
                                    <asp:ListItem Value="Manager">Manager</asp:ListItem>
                                    <asp:ListItem Value="Manufactura">Manufactura</asp:ListItem>
                                    <asp:ListItem Value="Ingenieria">Ingenieria</asp:ListItem>
                                </asp:DropDownList>
                                <label for="floatingTextarea" class="text-black fw-bold">Area</label>
                            </div>
                        </div>
                    <div class="row g-2 mt-4  " runat="server">
                        <div class="col-md  ">
                            <div class="form-floating">
                                <asp:TextBox class="form-control text-primary fw-bold " ID="dataUsername" AutoCompleteType="Disabled" runat="server"></asp:TextBox>
                                <label for="dataLocation" class="text-black fw-bold">Usuario</label>
                            </div>
                        </div>
                        <div class="col-md ">
                            <div class="form-floating">
                                <asp:TextBox class="form-control text-primary fw-bold "  ID="dataPassword" AutoCompleteType="Disabled"  runat="server"></asp:TextBox>
                                <label for="dataLocation" class="text-black fw-bold">Password</label>
                            </div>
                        </div>
                    </div>
                 <div class="row g-2 mt-4 mb-3 " runat="server">
                     <div class="col-md mx-auto">
                            <div class=" form-check mx-auto">
                                <asp:CheckBox runat="server" ID="CheckBox1" />
                                <label class="form-check-label fw-bold" for="exampleCheck1">¿Usuario Administrador?</label>
                            </div>
                        </div>
                      <div class="col-md ">
                            <div class=" form-check">
                                <asp:CheckBox runat="server"  ID="CheckBox2" />
                                <label class="form-check-label fw-bold" for="exampleCheck1">¿Capacitado?</label>
                            </div>
                        </div>
                    </div>
                        </div>
                    <div class="  form-group mb-3  ">
                        <asp:LinkButton ID="CREATE" ToolTip="NUEVO USUARIO" runat="server" type="submit" Text="REGISTRAR NUEVO USUARIO" class=" btn btn-primary  btn-lg  fw-bold " Visible="false" OnClick="CREATE_Click"><i class="bi bi-person-fill-add"></i> REGISTRAR NUEVO USUARIO</asp:LinkButton>
                        <asp:LinkButton ID="SaveChanges" ToolTip="GUARDAR MODIFICACIONES" runat="server" type="submit" Text="GUARDAR" OnClick="SaveChanges_Click" class=" btn btn-info btn-lg   fw-bold" Visible="false"><i class="bi bi-person-fill-gear"></i> MODIFICAR</asp:LinkButton>
                        <asp:LinkButton ID="SAVE"  ToolTip="AGREGAR" runat="server" type="submit" Text="GUARDAR" class=" btn btn-success btn-lg fw-bold   fw-bold" Visible="false" OnClick="SAVE_Click"><i class="bi bi-person-fill-check"></i> AGREGAR</asp:LinkButton>
                        <asp:LinkButton ID="CancelUser" runat="server" type="submit" Text="Cancelar" OnClientClick="return confirm('Desea cancelar registro de usuario?')" class=" btn btn-danger  btn-lg fw-bold " Visible="false" OnClick="CancelUser_Click"><i class="bi bi-x-circle-fill"></i> CANCELAR</asp:LinkButton>
                    </div>
                      <hr />
                <br />
                <div class="form-row">
                        <div class="col-md-12s col-md-offset-1">
                            <div class="form-group">
                                <div class="rounded shadow bg-white table-responsive ">
                                    <asp:GridView runat="server" ID="myTable" OnRowCommand="myTable_RowCommand" OnRowDataBound="myTable_RowDataBound" OnPageIndexChanging="myTable_PageIndexChanging" OnSelectedIndexChanged="myTable_SelectedIndexChanged" HeaderStyle-CssClass="bg-secondary text-white" CssClass="table table-bordered table-condensed table-responsive table-hover small-top-margin" ShowHeaderWhenEmpty="true" AutoGenerateColumns="false" DataKeyNames="" AutoGenerateSelectButton="false" AllowPaging="true" >
                                        <AlternatingRowStyle BackColor="White" />
                                        <RowStyle BackColor="#f5f5f5" />
                                        <SelectedRowStyle BackColor="#00404d" CssClass="opacity" Font-Bold="true" ForeColor="White" />
                                        <EmptyDataTemplate>
                                            <div class="text-center">Sin registros</div>
                                        </EmptyDataTemplate>
                                        <Columns>
                                            <asp:ButtonField ButtonType="Button" Text="Editar" CommandName="EditUser" HeaderText="Editar"  ControlStyle-CssClass="btn btn-warning fw-bold" />
                                            <asp:BoundField DataField="Fullname" HeaderText="Nombre" ReadOnly="True" SortExpression="Fullname" />
                                            <asp:BoundField DataField="EmployeeNumber" HeaderText="# Empleado" SortExpression="EmployeeNumber"></asp:BoundField>
                                            <asp:BoundField DataField="Area" HeaderText="Area" SortExpression="Area"></asp:BoundField>
                                            <asp:BoundField DataField="UserName" HeaderText="Usuario" ReadOnly="True" InsertVisible="true" SortExpression="UserName" />
                                            <asp:BoundField DataField="Password" HeaderText="Contraseña" SortExpression="Password"></asp:BoundField>                                            
                                            <asp:BoundField DataField="IsAdmin" HeaderText="Admin" SortExpression="IsAdmin"></asp:BoundField>
                                            <asp:BoundField DataField="Trained" HeaderText="Capacitado" SortExpression="Trained"></asp:BoundField>
                                            <asp:BoundField DataField="CreationDate" HeaderText="Fecha Creación" SortExpression="CreationDate"></asp:BoundField>
                                            <asp:ButtonField ButtonType="Button" Text="Borrar" CommandName="DeleteUser" HeaderText="Eliminar"  ControlStyle-CssClass="btn btn-danger fw-bold" />
                                        </Columns>
                                        <PagerStyle HorizontalAlign="Left" BackColor="#69757D" CssClass="GridPager"  />
                                    </asp:GridView>
                                </div>
                            </div>
                        </div>
                    </div>
                    <hr />
                </div>
                <%-- Fin off Gridview --%>
            </div>
    </form>
    <footer>
        <div class="  pt-4 fw-bold" style="">
            <p class="text-center"><%:DateTime.Now.Year%>  &copy; MMC Inventronics <%:DateTime.Now.Day%>-<%:DateTime.Now.Month%>-<%:DateTime.Now.Year%></p>
        </div>
    </footer>
</body>
</html>
