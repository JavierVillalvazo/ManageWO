<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Homepage.aspx.cs" Inherits="ManageWO.Homepage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml" data-bs-theme="light">
<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta name="description" title="Create, update and delete Work Orders for SMT" />
    <link href="~/resources/images/icon.ico" rel="shortcut icon" />
    <%--<link rel="stylesheet" href="Resources/CSS/sidebars.css" />--%>
    <%--<link rel="stylesheet" href="Resources/CSS/site.css" />--%>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" />
    <!-- Font Awesome CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <title>Sidebars · Bootstrap v5.3</title>
    <style>
        @media (min-width: 576px) {
            .h-sm-100 {
                height: 100%;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">

        <div class="container-fluid overflow-hidden">
            <div class="row vh-100 overflow-auto">
                <div class="col-12 col-sm-3 col-xl-2 px-sm-2 px-0 bg-dark d-flex sticky-top">
                    <div class="d-flex flex-sm-column flex-row flex-grow-1 align-items-center align-items-sm-start px-3 pt-2 text-white">
                        <a href="/" class="d-flex align-items-center pb-sm-3 mb-md-0 me-md-auto text-white text-decoration-none">



                            <span class="fs-5">
                                <img src="./resources/images/icono.png" style="width: 25px;" alt="Alternate Text" /><img class="d-none d-sm-inline p-2" src="./resources/images/inv.png" style="width: 150px;" /></span>
                        </a>
                        <ul class="nav nav-pills flex-sm-column flex-row flex-nowrap flex-shrink-1 flex-sm-grow-0 flex-grow-1 mb-sm-auto mb-0 justify-content-center align-items-center align-items-sm-start" id="menu">
                            <li class="nav-item">
                                <a href="#" class="nav-link px-sm-0 px-2">
                                    <i class="fs-5 bi-house"></i><span class="ms-1 d-none d-sm-inline">Home</span>
                                </a>
                            </li>
                            <li>
                                <a href="#submenu1" data-bs-toggle="collapse" class="nav-link px-sm-0 px-2">
                                    <i class="fs-5 bi-speedometer2"></i><span class="ms-1 d-none d-sm-inline">Dashboard</span> </a>
                            </li>


                            <li class="dropdown">
                                <a href="#" class="nav-link dropdown-toggle px-sm-0 px-1" id="dropdown2" data-bs-toggle="dropdown" aria-expanded="false">
                                    <i class="fs-5 bi bi-cpu-fill"></i><span class="ms-1 d-none d-sm-inline">SMT</span>
                                </a>
                                <ul class="dropdown-menu dropdown-menu-dark text-small shadow" aria-labelledby="dropdown">
                                    <li><a class="dropdown-item" href="#">Work order</a></li>
                                    <li><a class="dropdown-item" href="#">Upload PDF deviation</a></li>
                                    <li><a class="dropdown-item" href="#">Download PDF deviation</a></li>
                                    <li><a class="dropdown-item" href="#">Search alterns</a></li>
                                    <li><a class="dropdown-item" href="#">Feeder setup</a></li>
                                    <li><a class="dropdown-item" href="#">Kitting note</a></li>
                                </ul>
                            </li>




                            <li class="dropdown">
                                <a href="#" class="nav-link dropdown-toggle px-sm-0 px-1" id="dropdown" data-bs-toggle="dropdown" aria-expanded="false">
                                    <i class="fs-5 bi-bootstrap"></i><span class="ms-1 d-none d-sm-inline">Bootstrap</span>
                                </a>
                                <ul class="dropdown-menu dropdown-menu-dark text-small shadow" aria-labelledby="dropdown">
                                    <li><a class="dropdown-item" href="#">New project...</a></li>
                                    <li><a class="dropdown-item" href="#">Settings</a></li>
                                    <li><a class="dropdown-item" href="#">Profile</a></li>
                                    <li>
                                        <hr class="dropdown-divider">
                                    </li>
                                    <li><a class="dropdown-item" href="#">Sign out</a></li>
                                </ul>
                            </li>
                            <li>
                                <a href="#" class="nav-link px-sm-0 px-2">
                                    <i class="fs-5 bi-grid"></i><span class="ms-1 d-none d-sm-inline">Products</span></a>
                            </li>
                            <li>
                                <a href="#" class="nav-link px-sm-0 px-2">
                                    <i class="fs-5 bi-people"></i><span class="ms-1 d-none d-sm-inline">Customers</span> </a>
                            </li>
                        </ul>
                        <div class="dropdown py-sm-4 mt-sm-auto ms-auto ms-sm-0 flex-shrink-1">
                            <a href="#" class="d-flex align-items-center text-white text-decoration-none dropdown-toggle" id="dropdownUser1" data-bs-toggle="dropdown" aria-expanded="false">
                                <img src="https://github.com/mdo.png" alt="hugenerd" width="28" height="28" class="rounded-circle">
                                <span class="d-none d-sm-inline mx-1">Joe</span>
                            </a>
                            <ul class="dropdown-menu dropdown-menu-dark text-small shadow" aria-labelledby="dropdownUser1">
                                <li><a class="dropdown-item" href="#">New project...</a></li>
                                <li><a class="dropdown-item" href="#">Settings</a></li>
                                <li><a class="dropdown-item" href="#">Profile</a></li>
                                <li>
                                    <hr class="dropdown-divider">
                                </li>
                                <li><a class="dropdown-item" href="#">Sign out</a></li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="col d-flex flex-column h-sm-100">
                    <main class="row overflow-auto">
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
                    </main>
                    <footer class="row bg-light py-4 mt-auto">
                        <div class="col">Footer content here... </div>
                    </footer>
                </div>
            </div>
        </div>
    </form>



    <%--<script src="Resources/JS/sidebars.js"></script>--%>
</body>


</html>
