<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="ManageWO.login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link href="~/resources/images/icon.ico" rel="shortcut icon" />
    <link rel="stylesheet" href="Resources/CSS/Styles.css" />
    <link rel="stylesheet" href="Resources/CSS/site.css" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" />
    <!-- Font Awesome CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <title>Login</title>
    <style>
        a {
            text-decoration: none;
        }

        .form-right i {
            font-size: 100px;
        }
    </style>
</head>



<body class="gradient">
    <div class=" ">
        <div class="row mx-auto">
            <div class="col-lg-10 offset-lg-1">

                <div class="bg-white rounded">
                        <div class="">
                                <form action="" class="row g-4">
                                    <img id="logo" src=".\resources\images\inv.png" />
                                    <div class="col-12">
                                        <label>Username<span class="text-danger">*</span></label>
                                        <div class="input-group">
                                            <div class="input-group-text"><i class="bi bi-person-fill"></i></div>
                                            <input type="text" class="form-control" placeholder="Enter Username">
                                        </div>
                                    </div>

                                    <div class="col-12">
                                        <label>Password<span class="text-danger">*</span></label>
                                        <div class="input-group">
                                            <div class="input-group-text"><i class="bi bi-lock-fill"></i></div>
                                            <input type="text" class="form-control" placeholder="Enter Password">
                                        </div>
                                    </div>

                                    <div class="col-sm-6">
                                            <button type="submit" class="btn btn-lg btn-primary ">login</button>
                                        
                                    </div>

                                    <div class="col-sm-6 ">
                                        <a href="#" class="text-center  text-primary">Forgot Password?</a>
                                    </div>

                                    <div class="col-12">
                                    </div>
                                </form>
                        </div>
                        <%--<div class="col-md-5 ps-0 d-none d-md-block">
                            <div class="form-right h-100  text-white text-center pt-5">
                                <img id="logo" class="img-thumbnail" src="./resources/images/icono.png" />
                               

                                <h2 class="fs-1">Welcome Back!!!</h2>
                            </div>
                        </div>--%>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
