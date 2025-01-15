<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="sidebar.aspx.cs" Inherits="ManageWO.sidebar" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link href="~/resources/images/icon.ico" rel="shortcut icon" />
    <link rel="stylesheet" href="Resources/CSS/Styles.css" />
    <link rel="stylesheet" href="Resources/CSS/Styles.css" />
    <link rel="stylesheet" href="Resources/CSS/site.css" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" />
    <!-- Font Awesome CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <title>Sidebar</title>
</head>
<body class="gradient">
    <form id="form1" runat="server">
        <nav class="navbar navbar-expand-lg  navbar-dark bg-dark">
            <div class="container-fluid">
                <a class="navbar-brand" href="./Default.aspx">
                    <img id="logo" src="./resources/images/inv.png" /></a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                        <li class="nav-item">
                            <a class="nav-link active" aria-current="page" href="#">Home</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#">Link</a>
                        </li>
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">Dropdown
                            </a>
                            <ul class="dropdown-menu">
                                <li><a class="dropdown-item" href="#">Action</a></li>
                                <li><a class="dropdown-item" href="#">Another action</a></li>
                                <li>
                                    <hr class="dropdown-divider">
                                </li>
                                <li><a class="dropdown-item" href="#">Something else here</a></li>
                            </ul>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link disabled" aria-disabled="true">Disabled</a>
                        </li>
                    </ul>
                    <div id="form3" runat="server" class="d-flex" role="search">
                        <asp:LinkButton runat="server" class=" fw-bold btn btn-outline-primary me-2 btn-sm " ID="RegresarBtn" Text="" title="Click to go back"><span class="btn-label"><i class="fa fa-arrow-left"></i></span>  Go Back</asp:LinkButton>
                        <asp:LinkButton type="button" ID="logoutBtn" runat="server" class="fw-bold btn btn-outline-danger btn-sm me-2" title="Exit System">
                           <span class="btn-label"><i  class="fa fa-sign-out"></i></span>  Sign out
                            <%--<i  class="bi bi-box-arrow-left"></i>--%>

                        </asp:LinkButton>
                        <%--<input class="form-control me-2" type="search" placeholder="Search" aria-label="Search">--%>
                        <%--<button class="btn btn-outline-success" type="submit">Search</button>--%>
                    </div>
                </div>
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
