<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="NotFound.aspx.cs" Inherits="ManageWO.NotFound" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta name="description" title="Opps.... Sorry, an error has occured, Requested page not found!" />
    <link href="~/resources/images/icon.ico" rel="shortcut icon" />
    <link rel="stylesheet" href="Resources/CSS/Styles.css" />
    <link rel="stylesheet" href="Resources/CSS/site.css" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" />
    <!-- Font Awesome CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

    <title>Sorry, an error has occured, Requested page not found!</title>
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
                        <%-- <li class="nav-item active fw-bold ">
                            <a class="nav-link text-white" href="#" title="CREATE, UPDATE, DELETE WORK ORDER">WO</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" title="Upload, delete, and update Kitting note smt" href="./smtkn.aspx">KN</a>
                        </li>--%>
                        <%-- <li class="nav-item">
                    <a class="nav-link icon-link icon-link-hover disabled" aria-disabled="true">Create, update and delete WO</a>
                </li>--%>
                    </ul>
                    <div id="form3" runat="server" class="d-flex" role="search">
                        <%--<asp:LinkButton runat="server" class=" fw-bold btn btn-outline-primary me-2 btn-sm " ID="RegresarBtn" Text="" PostBackUrl="~/Default.aspx" title="Click to go back"><span class="btn-label"><i class="fa fa-arrow-left"></i></span>  Go Back</asp:LinkButton>--%>
<%--                        <asp:LinkButton type="button" ID="logoutBtn" runat="server" class="btn btn-outline-primary btn-sm me-2" PostBackUrl="~/Home.aspx" title="Click to go to  login page">
                   <span class="btn-label"><i  class="fa fa-user"></i></span>  Log in
                        </asp:LinkButton>--%>
                    </div>
                </div>
            </div>
        </nav>

        <div class="container-fluid">
            <div class="d-flex align-items-center justify-content-center vh-100">
                <div class="text-center row">
                    <div class=" col-md-6">
                        <img src="./resources/images/error.png" alt=""
                            class="img-fluid">
                    </div>
                    <div class=" col-md-6">
                        <img src="./resources/images/inv.png" alt=""
                            class="img-fluid">
                        <p class="fs-3"><span class="text-danger">Opps!</span> Page not found.</p>
                        <p class="lead">
                            The page you’re looking for doesn’t exist.
                        </p>
                        <asp:LinkButton type="button" ID="LinkButton1" runat="server" class="btn btn-primary btn-sm me-2" PostBackUrl="~/Home.aspx" title="Exit System">
                   <span class="btn-label"><i  class="fa fa-home"></i></span>   Go home
                        </asp:LinkButton>
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



