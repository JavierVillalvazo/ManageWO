<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="test.aspx.cs" Inherits="ManageWO.test" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta name="description" title="Login page MMC Management" />
    <link href="~/resources/images/icon.ico" rel="shortcut icon" />
    <link rel="stylesheet" href="Resources/CSS/login.css" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" />
    <!-- Font Awesome CSS -->
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.2/css/all.css" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
    <title>Login</title>
</head>
<body>
    <div class="container">
        <div class="row mx-auto">
            <div class="offset-md-2 col-lg-5 col-md-7 offset-lg-4 offset-md-3">
                <div class="rounded  bg-white">
                    <div class="text-center panel-heading">
                        <%--<h3 class="pt-3 font-weight-bold">Login</h3>--%>
                        <img class="logo" src="Resources/images/inv.png" />

                    </div>
                    <div class="panel-body p-3">
                        <form action="login_script.php" runat="server" id="form1" method="POST">
                            <div class="form-group py-2 ">
                                <div class="input-field">
                                    <span class="bi bi-person-circle p-2"></span>
                                    <asp:TextBox runat="server" type="text" class="" placeholder="Username or Email" required></asp:TextBox>
                                </div>
                            </div>
                            <div class="form-group py-2">
                                <div class="input-field">
                                    <span class="bi bi-lock-fill p-2"></span>
                                    <input type="password" placeholder="Enter your Password" required>
                                    <i class="bi bi-eye-slash"></i>
                                </div>
                            </div>
                            <div class="form-inline text-end">
                                <a href="#" id="forgot" class="fw-bold link text-body-primary text-end">Forgot password?</a>
                            </div>
                            <div class="btn btn-primary w-100  mt-3 text-center">Login</div>
                            <div class="text-center pt-4 text-body-secondary">Don't have an account? <a href="#" id="signup" class="link">Sign up</a> </div>
                            <div class="text-center border-0">
                            <%--<img class="team img-thumbnail border-0" src="Resources/images/illustration.png" />--%>
                            </div>
                        </form>
                    </div>

                </div>
            </div>
        </div>
    </div>
</body>
</html>
