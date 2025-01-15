<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="ManageWO.Home" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml" data-bs-theme="auto">
<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta name="description" title="MMC Management Login" />
    <link href="~/resources/images/icon.ico" rel="shortcut icon" />
    <%--<link rel="stylesheet" href="Resources/CSS/Styles.css" />--%>
    <link rel="stylesheet" href="Resources/CSS/login-media.css" />
    <link rel="stylesheet" href="Resources/CSS/login.css" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" />
    <!-- Font Awesome CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
    <script type="text/javascript" src="Resources/JS/theme.js"></script>

    <title>Login </title>
</head>
<body class="">
    <svg xmlns="http://www.w3.org/2000/svg" class="d-none">
        <symbol id="check2" viewBox="0 0 16 16">
            <path d="M13.854 3.646a.5.5 0 0 1 0 .708l-7 7a.5.5 0 0 1-.708 0l-3.5-3.5a.5.5 0 1 1 .708-.708L6.5 10.293l6.646-6.647a.5.5 0 0 1 .708 0z" />
        </symbol>
        <symbol id="circle-half" viewBox="0 0 16 16">
            <path d="M8 15A7 7 0 1 0 8 1v14zm0 1A8 8 0 1 1 8 0a8 8 0 0 1 0 16z" />
        </symbol>
        <symbol id="moon-stars-fill" viewBox="0 0 16 16">
            <path d="M6 .278a.768.768 0 0 1 .08.858 7.208 7.208 0 0 0-.878 3.46c0 4.021 3.278 7.277 7.318 7.277.527 0 1.04-.055 1.533-.16a.787.787 0 0 1 .81.316.733.733 0 0 1-.031.893A8.349 8.349 0 0 1 8.344 16C3.734 16 0 12.286 0 7.71 0 4.266 2.114 1.312 5.124.06A.752.752 0 0 1 6 .278z" />
            <path d="M10.794 3.148a.217.217 0 0 1 .412 0l.387 1.162c.173.518.579.924 1.097 1.097l1.162.387a.217.217 0 0 1 0 .412l-1.162.387a1.734 1.734 0 0 0-1.097 1.097l-.387 1.162a.217.217 0 0 1-.412 0l-.387-1.162A1.734 1.734 0 0 0 9.31 6.593l-1.162-.387a.217.217 0 0 1 0-.412l1.162-.387a1.734 1.734 0 0 0 1.097-1.097l.387-1.162zM13.863.099a.145.145 0 0 1 .274 0l.258.774c.115.346.386.617.732.732l.774.258a.145.145 0 0 1 0 .274l-.774.258a1.156 1.156 0 0 0-.732.732l-.258.774a.145.145 0 0 1-.274 0l-.258-.774a1.156 1.156 0 0 0-.732-.732l-.774-.258a.145.145 0 0 1 0-.274l.774-.258c.346-.115.617-.386.732-.732L13.863.1z" />
        </symbol>
        <symbol id="sun-fill" viewBox="0 0 16 16">
            <path d="M8 12a4 4 0 1 0 0-8 4 4 0 0 0 0 8zM8 0a.5.5 0 0 1 .5.5v2a.5.5 0 0 1-1 0v-2A.5.5 0 0 1 8 0zm0 13a.5.5 0 0 1 .5.5v2a.5.5 0 0 1-1 0v-2A.5.5 0 0 1 8 13zm8-5a.5.5 0 0 1-.5.5h-2a.5.5 0 0 1 0-1h2a.5.5 0 0 1 .5.5zM3 8a.5.5 0 0 1-.5.5h-2a.5.5 0 0 1 0-1h2A.5.5 0 0 1 3 8zm10.657-5.657a.5.5 0 0 1 0 .707l-1.414 1.415a.5.5 0 1 1-.707-.708l1.414-1.414a.5.5 0 0 1 .707 0zm-9.193 9.193a.5.5 0 0 1 0 .707L3.05 13.657a.5.5 0 0 1-.707-.707l1.414-1.414a.5.5 0 0 1 .707 0zm9.193 2.121a.5.5 0 0 1-.707 0l-1.414-1.414a.5.5 0 0 1 .707-.707l1.414 1.414a.5.5 0 0 1 0 .707zM4.464 4.465a.5.5 0 0 1-.707 0L2.343 3.05a.5.5 0 1 1 .707-.707l1.414 1.414a.5.5 0 0 1 0 .708z" />
        </symbol>
    </svg>

    <form id="form1" runat="server">
        <div class="container">
            <div class="row d-flex align-items-center">
                <div class="col-md-6 ">
                    <div style="" class="mx-auto text-center    p-2 rounded">
                        <%-- alerta --%>
                        <div runat="server" id="alert" visible="false" class="" role="alert">
                            <span id="AlertIcon" runat="server" class=" me-2" role="img"></span>
                            <asp:Label runat="server" CssClass="fw-bold" ID="alertText" Text="">
                        
                            </asp:Label>
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                        <%--<h6 class=" text-center  fw-bold ">WELCOME TO MMC</h6>--%>
                        <img class="mt-2" id="logo" src="Resources/images/inv.png" />
                        <div class="form-group py-2 mb-4 ">
                            <div class="input-field">
                                <span class="bi bi-person-circle p-2"></span>
                                <asp:TextBox runat="server" type="text" placeholder="Username or email      " ToolTip="Enter username    " ID="txtUsername" AutoCompleteType="Disabled" CssClass="text-center form-control  "></asp:TextBox>
                            </div>
                        </div>
                        <div class="form-group py-2 ">
                            <div class=" input-field  ">
                                <span class="bi bi-lock-fill p-2"></span>
                                <asp:TextBox runat="server" ID="txtPassword" name="txtPassword" placeholder="Enter your password" type="password" TextMode="Password" AutoCompleteType="Disabled" class="text-center form-control   "></asp:TextBox>
                                <span class="password-toggle-icon p-0" onclick="password_show_hide();" >
                                    <i class="bi bi-eye-fill" id="show_eye"></i>
                                    <i class="bi bi-eye-slash d-none " id="hide_eye"></i>
                                </span>
                                <%--<i class="bi bi-eye-slash p-0" id="togglePassword"></i>--%>
                            </div>
                        </div>

                        <div class="">
                            <asp:LinkButton runat="server" ID="LoginBtn" CausesValidation="true" class="btn btn-primary w-100 mt-2  " type="button" OnClick="LoginBtn_Click">Login</asp:LinkButton>
                        </div>
                        <p class="small text-end mt-0 "><a class="link-primary" href="#!" style="font-size: small">Forgot password?</a></p>
                        <p class="small  mt-4 " style="font-size: smaller">Don't have an account? <a href="#!" class="link-primary">Register here</a></p>
                    </div>
                </div>
                <div class="col-sm-6 px-0  ">
                    <img src="Resources/images/Illustration.png" alt="Login image" class="d-none d-sm-block img-fluid w-100 vh-100 " style="object-fit: contain; object-position: center;" />
                </div>
            </div>
        </div>

        <div class="dropdown position-fixed top-0 end-0 mb-3 me-3 bd-mode-toggle" data-bs-theme="auto">
            <button class="btn  py-2 dropdown-toggle d-flex align-items-center"
                id="bd-theme"
                type="button"
                aria-expanded="true"
                data-bs-toggle="dropdown"
                aria-label="Toggle theme (auto)">
                <span class="" id="bd-theme-text">Theme </span>
                <svg class="bi my-1 theme-icon-active" width="1em" height="1em">
                    <use href="#circle-half"></use></svg>
            </button>
            <ul class="dropdown-menu dropdown-menu-end shadow" aria-labelledby="bd-theme-text">
                <li>
                    <button type="button" class="dropdown-item d-flex align-items-center" data-bs-theme-value="light" aria-pressed="false">
                        <svg class="bi me-2 opacity-50" width="1em" height="1em">
                            <use href="#sun-fill"></use></svg>
                        Light
            <svg class="bi ms-auto d-none" width="1em" height="1em">
                <use href="#check2"></use></svg>
                    </button>
                </li>
                <li>
                    <button type="button" class="dropdown-item d-flex align-items-center" data-bs-theme-value="dark" aria-pressed="false">
                        <svg class="bi me-2 opacity-50" width="1em" height="1em">
                            <use href="#moon-stars-fill"></use></svg>
                        Dark
            <svg class="bi ms-auto d-none" width="1em" height="1em">
                <use href="#check2"></use></svg>
                    </button>
                </li>
                <li>
                    <button type="button" class="dropdown-item d-flex align-items-center active" data-bs-theme-value="auto" aria-pressed="true">
                        <svg class="bi me-2 opacity-50" width="1em" height="1em">
                            <use href="#circle-half"></use></svg>
                        Auto
            <svg class="bi ms-auto d-none" width="1em" height="1em">
                <use href="#check2"></use></svg>
                    </button>
                </li>
            </ul>
        </div>

    </form>
    <footer class=" text-center text-lg-start fixed-bottom">
        <!-- Copyright -->
        <div class="text-center p-3" style="background-color: rgba(0, 0, 0, 0.05);">
            <a class="text-body fw-medium text-decoration-none" href="#"><%:DateTime.Now.Year%>  &copy; Designed for MMC Inventronics</a>
        </div>
        <!-- Copyright -->
    </footer>



    <script>
        //const togglePassword = document
        //    .querySelector('#togglePassword');
        //const password = document.querySelector('#txtPassword');
        //togglePassword.addEventListener('click', () => {
        //    // Toggle the type attribute using
        //    // getAttribure() method
        //    const type = password
        //        .getAttribute('type') === 'password' ?
        //        'text' : 'password';
        //    password.setAttribute('type', type);
        //    // Toggle the eye and bi-eye icon
        //    this.classList.toggle('bi-eye');
        //});

        function password_show_hide() {
            var x = document.getElementById("txtPassword");
            var show_eye = document.getElementById("show_eye");
            var hide_eye = document.getElementById("hide_eye");
            hide_eye.classList.remove("d-none");
            if (x.type === "password") {
                x.type = "text";
                show_eye.style.display = "none";
                hide_eye.style.display = "block";
            } else {
                x.type = "password";
                show_eye.style.display = "block";
                hide_eye.style.display = "none";
            }
        }
    </script>
</body>
</html>
