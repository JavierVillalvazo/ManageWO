<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="ManageWO.Menu" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta name="description" title="MMC Management" />
    <link href="~/resources/images/icon.ico" rel="shortcut icon" />
    <link rel="stylesheet" href="Resources/CSS/Styles.css" />
    <link rel="stylesheet" href="Resources/CSS/site.css" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" />
    <!-- Font Awesome CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <title>MMC</title>
</head>
<body>
    <form id="form1" runat="server">
        <div id="sidebarMenu" class="collapse d-lg-block sidebar collapse bg-dark">
            <div class="position-sticky  bg-dark">
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#sidebarMenu" aria-controls="sidebarMenu" aria-expanded="false" title="Deployable Menu" aria-label="Toggle navigation"><i class="fas fa-bars"></i></button>
                <div class="list-group list-group-flush mx-3 mt-4 ">
                    <ul class="nav nav-pills flex-column mb-sm-auto mb-0 align-items-start">
                        <li class="dropdown">
                            <asp:LinkButton runat="server" href="#" class="nav-link dropdown-toggle  text-white" ID="dropdown1" data-bs-toggle="dropdown" aria-expanded="false">
                                <i class="fa-fw me-3 bi bi-cpu-fill"></i><span>SMT</span>
                            </asp:LinkButton>
                            <ul class="dropdown-menu text-small shadow " aria-labelledby="dropdown">
                                <li><a class="dropdown-item" href="smtWO.aspx">Work Order</a></li>
                                <li><a class="dropdown-item" href="searchsmtwo.aspx">Search Work Order</a></li>
                                <li><a class="dropdown-item" href="UploadAlterns.aspx">Upload alternate PN</a></li>
                                <li><a class="dropdown-item" href="Alterns.aspx" title="Page for search work order alterns(query)">Search Alternates</a></li>
                                <li><a class="dropdown-item" href="uploaddeviation.aspx" title="Download and review WO deviation">Upload PDF deviation</a></li>
                                <li><a class="dropdown-item" href="deviation.aspx" title="Download and review WO deviation">Search PDF deviation</a></li>
                                <li><a class="dropdown-item" href="FS.aspx">Feeder Setup</a></li>
                                <li><a class="dropdown-item" href="smtkn.aspx">Kitting Note</a></li>
                            </ul>
                        </li>
                    </ul>
                    <ul class="nav nav-pills flex-column mb-sm-auto mb-0 align-items-start">
                        <li class="dropdown">
                            <a href="#" class="nav-link dropdown-toggle  text-white" id="dropdown2" data-bs-toggle="dropdown" aria-expanded="false">
                                <i class="fa-fw me-3 bi bi-motherboard"></i><span>PTH</span>
                            </a>
                            <ul class="dropdown-menu text-small  " aria-labelledby="dropdown">
                                <li><a class="dropdown-item" href="PTHWO.aspx">Work Order</a></li>
                                <li><a class="dropdown-item" href="PTHKN.aspx">Kitting Note</a></li>
                                <li><a class="dropdown-item" href="#">Serial Number</a></li>
                              </ul>
                        </li>
                    </ul>
                    <ul class="nav nav-pills flex-column mb-sm-auto mb-0 align-items-start">
                        <li class="dropdown">
                            <asp:LinkButton runat="server" href="#" class="nav-link dropdown-toggle  text-white" ID="LinkButton1" data-bs-toggle="dropdown" aria-expanded="false">
                                <i class="fa-fw me-3 bi bi-list-columns-reverse"></i><span>Sales Orders</span>
                            </asp:LinkButton>
                            <ul class="dropdown-menu text-small shadow " aria-labelledby="dropdown">
                                <li>
                                    <asp:LinkButton runat="server" CssClass="dropdown-item" href="OpenOrders.aspx">Open Orders</asp:LinkButton></li>
                                <li><a class="dropdown-item" href="#">Past Due</a></li>
                                <li><a class="dropdown-item" href="#">Summary</a></li>
                            </ul>
                        </li>
                    </ul>

                    <asp:LinkButton type="button" ID="logoutBtn" runat="server" class="btn btn-danger fw-bold" OnClick="logoutBtn_Click"><span runat="server" class="bi bi-box-arrow-left">&nbsp;EXIT</span></asp:LinkButton>
                </div>
            </div>
        </div>
        <!-- Sidebar -->
        <nav class="navbar sticky-top navbar-expand-lg navbar-toggleable-sm navbar-toggleable-md  navbar-dark bg-dark ">
            <div class="container-fluid ">
                <a class="navbar-brand m-auto" href="./Default.aspx">
                    <img id="logo" src="./resources/images/inv.png" class="" /></a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#sidebarMenu" aria-controls="sidebarMenu" aria-expanded="false" title="Deployable Menu" aria-label="Toggle navigation"><i class="fas fa-bars"></i></button>
            </div>

        </nav>
        <div class="container ">
            <main>
                <div class="row  ">
                    <div class="d-inline " style="margin: 1rem 0 0 0">
                        <asp:Label runat="server" ID="lblGreeting" Text="" class="h3 text-dark "></asp:Label>
                        <asp:Label runat="server" CssClass="h4 text-secondary " Style="text-transform: uppercase" ID="userDefault"></asp:Label>
                        <asp:Label runat="server" CssClass="form-text" ID="lblDate" Visible="true"></asp:Label>
                        <hr />
                    </div>
                </div>
                <section class="row mx-auto" aria-labelledby="aspnetTitle">
                    <%--<h1 id="aspnetTitle">ASP.NET</h1>--%>
                    <p class="lead fs-6">Recuerde que la información aqui mostrada es para uso único y exclusivo de MMC Inventronics.  </p>
                    <div class="d-inline">
                        <img src="./resources/images/office.jpg" alt="stadium" style="width: 95vw; height: 90%" class="mx-auto img-fluid" />
                    </div>
                </section>
            </main>
        </div>
    </form>
</body>
</html>
