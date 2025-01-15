<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UploadDeviation.aspx.cs" EnableEventValidation="true" Inherits="ManageWO.UploadDeviation" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml" data-bs-theme="light">
<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta name="description" title="Create, update and delete Work Orders for SMT" />
    <link href="~/resources/images/icon.ico" rel="shortcut icon" />
    <link rel="stylesheet" href="Resources/CSS/styles.css" />
    <link rel="stylesheet" href="Resources/CSS/site.css" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" />
    <!-- Font Awesome CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
    <title>SMT - Upload Deviation</title>
    <style type="text/css">
        #pdf_container {
            background: #ccc;
            text-align: center;
            display: none;
            padding: 5px;
            height: 820px;
            overflow: auto;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <nav class="navbar sticky-top navbar-expand-lg  navbar-dark bg-dark">
            <div class="container-fluid">
                <a class="navbar-brand" href="./Home.aspx">
                    <img id="logo" class="navbar-brand" src="./resources/images/inv.png" title="Go back to Home" /></a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse mx-auto" id="navbarSupportedContent">
                    <div class="btn-group ">
                        <asp:LinkButton runat="server" class="btn btn-dark " ID="LinkButton3" Text="Regresar" title="Click para regresar">
                               <span><i class="bi bi-chevron-left fs-5"></i> </span>
                        </asp:LinkButton>
                        <asp:LinkButton runat="server" ID="btnHome" class=" btn btn-dark" title="Inicio -  Homepage" Text="Home">
                               <span><i class="bi bi-house-fill fs-5"></i> </span>
                        </asp:LinkButton>
                        <%--<asp:LinkButton runat="server" ID="LinkButton1" class="btn btn-dark"><i class="bi bi-person-circle fs-5" ></i></asp:LinkButton>--%>
                        <asp:LinkButton type="button" ID="logoutBtn" runat="server" class=" btn btn-dark text-danger fs-5" OnClientClick="if (!confirm('Are you sure you want to log out??')) return false;" PostBackUrl="~/Home.aspx" title="Exit System">
                           <span class="btn-label"><i  class="fa fa-sign-out"></i></span> 
                        </asp:LinkButton>

                    </div>
                    <ul class="navbar-nav mx-auto mb-2 mb-lg-0">
                        <li class="nav-item active fw-bold ">
                            <a class="nav-link text-white" href="#" title="">Upload deviation</a>
                    </ul>
                    <div id="form3" runat="server" class="d-flex " role="search">
                        <div class="btn-group ">
                            <asp:LinkButton runat="server" ID="userBtn" class="btn btn-dark"><i class="bi bi-person-circle" ></i></asp:LinkButton>
                            <asp:LinkButton runat="server" class=" btn  btn-dark" ID="LinkButton2" Font-Size="Smaller" Text="Javier " title="User"></asp:LinkButton>
                        </div>

                    </div>
                </div>
            </div>
        </nav>
        <div class="container ">
            <%-- alerta --%>
            <div runat="server" id="alert" visible="false" class="mt-3 d-flex align-items-center mb-1" role="alert">
                <span id="AlertIcon" runat="server" class=" flex-shrink-0 me-2" role="img"></span>
                <asp:Label runat="server" CssClass="fw-bold" ID="alertText" Text="">
                </asp:Label>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            <div class="card   border border-0 mx-auto">
                <div class="card-body ">

                    <div class="mb-3 ">
                        <label for="basic-url" class="form-label fw-bold">Work order</label>
                        <div class="input-group">
                            <asp:TextBox runat="server" Enabled="true" AutoCompleteType="Disabled" class="form-control w-75" ID="inputWorkorder" aria-describedby="basic-addon1" ToolTip="M5107-YYMMXXXX" OnTextChanged="inputWorkorder_TextChanged"></asp:TextBox>

                            <asp:LinkButton runat="server" class="input-group-text btn btn-primary w-25 text-white" ID="Validate" OnClick="Validate_Click"><i class="bi bi-check-circle-fill"></i> Validate</asp:LinkButton>
                        </div>
                        <div class="form-text" id="basic-addon4"><i class="bi bi-info-circle-fill"></i>First you need to type the workorder, then click on the check icon...</div>
                    </div>

                    <div class="form-group row">
                        <div class="form-group col-md-6" runat="server" id="divModel" visible="false">
                            <asp:Label CssClass=" fw-bold" runat="server" ID="lblModel" Visible="true">Model</asp:Label>
                            <asp:TextBox runat="server" Style="text-transform: uppercase" Enabled="false" Visible="true" AutoCompleteType="Disabled" class="form-control" ID="inputModel" aria-describedby="basic-addon1"></asp:TextBox>
                        </div>
                        <div class="form-group col-md-6" runat="server" id="divQty" visible="false">
                            <asp:Label CssClass=" fw-bold" runat="server" ID="lblQty" Visible="true">Quantity</asp:Label>
                            <asp:TextBox runat="server" Style="text-transform: uppercase" Enabled="false" Visible="true" AutoCompleteType="Disabled" class="form-control" ID="inputQty" aria-describedby="basic-addon1"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="mt-3">
                            <button runat="server" id="selectPDF" visible="false" type="button" class="btn btn-primary " data-bs-toggle="modal" data-bs-target="#exampleModal">
                                Select PDF
                            </button>
                            <asp:LinkButton ID="ClearBtn" runat="server" class=" btn btn-danger " OnClick="ClearBtn_Click" Visible="false"><span runat="server"  class="bi bi-input-cursor-text"></span> Cancel</asp:LinkButton>
                            <%--<asp:LinkButton ID="SaveBtn" ValidationGroup="fields" runat="server" class=" btn btn-success" OnClick="SaveBtn_Click" Visible="false"><i class="bi bi-floppy2-fill"></i> Save</asp:LinkButton>
                            <asp:LinkButton ID="UpdateBtn" runat="server" class="  btn btn-warning" OnClick="UpdateBtn_Click" Visible="false"><i class="bi bi-database-fill-check"></i> Update</asp:LinkButton>--%>
                        </div>
                    </div>
                    <!-- Modal -->
                    <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                        <div class="modal-dialog modal-dialog-centered">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h1 class="modal-title fs-5" id="exampleModalLabel">Select pdf file to upload</h1>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body">
                                    <div class="">
                                        <asp:FileUpload Width="100%" ID="fuData" CssClass="form-control form-control " runat="server" AllowMultiple="false" />
                                        <asp:RequiredFieldValidator CssClass="text-danger fw-bold mx-2" Font-Size="X-Small" SetFocusOnError="true" ErrorMessage="(*) required" ValidationGroup="fields" ControlToValidate="fuData" runat="server" />
                                        <label class="custom-file-label fw-bold "></label>
                                        <asp:Label runat="server" ID="label1" Font-Size="XX-Small" class=" form-control label text-start text-body-secondary">Supported format: PDF</asp:Label>
                                    </div>
                                    <label id="filename" class="fw-bold"></label>
                                </div>
                                <div class="modal-footer">
                                    <%--<asp:LinkButton runat="server" ID="Reset" OnClick="Reset_Click" CssClass="btn  btn-outline-danger"><span runat="server"  class="bi bi-arrow-clockwise" title="click to cancel action, click to select another files"></span> Reset </asp:LinkButton>--%>
                                    <asp:LinkButton runat="server" ID="Reset" OnClick="Reset_Click" CssClass="btn  btn-danger"><span runat="server"  class="bi bi-arrow-clockwise" title="click to cancel action, click to select another files"></span> Reset </asp:LinkButton>
                                    <asp:LinkButton ID="btnFile" runat="server" type="submit" CssClass=" btn btn-primary " OnClick="btnFile_Click" Visible="true" ToolTip="Click to upload files to server(you can select multiple files if you want.)"><span runat="server"  class="bi bi-cloud-arrow-up-fill"></span> Upload</asp:LinkButton>
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <br />

            </div>
            <div class="container mt-0">
                <div class="form-group ">
                    <hr />
                    <h4 style="text-align: center;" class="">DATA FILTER</h4>
                    <div class="input-group ">
                        <asp:LinkButton ID="CancelBtn" Visible="false" CssClass=" btn btn-danger fw-bold" runat="server" OnClick="CancelBtn_Click" Text="" ToolTip="Cancel query"><i class="bi bi-x-lg"></i> </asp:LinkButton>
                        <asp:LinkButton ID="QueryBtn" Visible="false" CssClass="btn btn-dark fw-bold " OnClick="QueryBtn_Click" runat="server" ToolTip="Click to enable query"><i runat="server" class="fa fa-search-plus"></i></asp:LinkButton>
                        <asp:TextBox ID="filterText" CssClass="form-control filter" Enabled="false" TextMode="Search" AutoPostBack="true" OnTextChanged="filterText_TextChanged" runat="server" class="form-control" placeholder="Search by WorkOrder or Model"></asp:TextBox>
                        <asp:LinkButton ID="SearchBtn" Visible="false" CssClass=" btn btn-dark fw-bold" OnClick="SearchBtn_Click" runat="server" Text="" ToolTip="Search"><i class="bi bi-search"></i></asp:LinkButton>
                        <asp:LinkButton ID="RefreshBtn" Visible="false" CssClass=" btn btn-primary fw-bold" runat="server" OnClick="RefreshBtn_Click" Text="" ToolTip="Refresh table"><i class="bi bi-arrow-clockwise"></i></asp:LinkButton>
                    </div>
                    <hr />
                </div>
                <div class="form-row">
                    <div class="rounded table-responsive ">
                        <asp:GridView runat="server" ID="myTable" OnPageIndexChanging="myTable_PageIndexChanging" OnRowDataBound="myTable_RowDataBound" OnRowCommand="myTable_RowCommand" HeaderStyle-HorizontalAlign="Center" CssClass="table table-striped table-hover table-bordered" ShowHeaderWhenEmpty="false" AutoGenerateColumns="false" DataKeyNames="WorkOrder" AllowPaging="false">
                            <HeaderStyle CssClass="table-dark" />
                            <EmptyDataTemplate>
                                <div class="empty-state">
                                    <div class="empty-state__content">
                                        <div class="empty-state__icon">
                                            <img src="./Resources/images/skull.png" alt="...">
                                        </div>
                                        <div class="empty-state__message">No records has been added yet.</div>
                                        <div class="empty-state__help">
                                            Add a new record by simpley clicking the below button.
                                        </div>
                                        <div class="">
                                            <asp:LinkButton runat="server" ID="addButton" CssClass=" btn-default rounded add mt-2" OnClick="addButton_Click"><span class=" bitbi-arrow-clockwise"></span> Add new</asp:LinkButton>

                                        </div>
                                    </div>
                                </div>
                            </EmptyDataTemplate>
                            <Columns>
                                <asp:BoundField DataField="ID" HeaderText="ID" ReadOnly="True" ItemStyle-HorizontalAlign="Center" />
                                <asp:BoundField DataField="WorkOrder" HeaderText="WorkOrder" ReadOnly="True" ItemStyle-HorizontalAlign="Center" />
                                <asp:BoundField DataField="Model" HeaderText="Model" ReadOnly="True" ItemStyle-HorizontalAlign="Center" />
                                <asp:BoundField DataField="Quantity" HeaderText="Quantity" ReadOnly="True" ItemStyle-HorizontalAlign="Center" />
                                <asp:BoundField DataField="filename" HeaderText="filename" ReadOnly="True" ItemStyle-HorizontalAlign="Center" />
                                <asp:BoundField DataField="uploadedDate" HeaderText="uploadedDate" ReadOnly="True" ItemStyle-HorizontalAlign="Center" />
                                <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lnkDownload" title="click to download PDF" CssClass="btn btn-success" runat="server" Text="Download PDF" OnClick="DownloadFile"
                                            CommandArgument='<%# Eval("Id") %>'><i class="bi bi-filetype-pdf" title="click to download PDF" ></i></asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:ButtonField ButtonType="Image" ImageUrl="./Resources/images/icons/trash.png" Text="Delete" CommandName="ComDelete" HeaderText="Eliminar" ControlStyle-CssClass="btn btn-danger fw-bold text-white" ItemStyle-Width="5%" />
                                <%--                       <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lnkDownload" title="click to preview PDF" CssClass="view btn btn-primary" runat="server" Text="View PDF" href="javascript:;" rel='<%# Eval("Id") %>'
                                            CommandArgument='<%# Eval("Id") %>'><i class="bi bi-eye-fill" title="click to download PDF" ></i></asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>--%>
                            </Columns>
                            <PagerStyle CssClass="GridPager" />
                        </asp:GridView>
                    </div>
                </div>

            </div>
        </div>






        <div id="pdf_container">
        </div>
    </form>
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/pdf.js/2.6.347/pdf.min.js"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/pdf.js/2.6.347/pdf_viewer.min.css"
        rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        $(function () {
            $("[id*=myTable] .view").click(function () {
                var fileId = $(this).attr("rel");
                $.ajax({
                    type: "POST",
                    url: "UploadDeviation.aspx/GetPDF",
                    data: "{fileId: " + fileId + "}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (r) {
                        LoadPdfFromBlob(r.d.Data);
                    }
                });
            });
        });

        var pdfjsLib = window['pdfjs-dist/build/pdf'];
        pdfjsLib.GlobalWorkerOptions.workerSrc = 'https://cdnjs.cloudflare.com/ajax/libs/pdf.js/2.6.347/pdf.worker.min.js';
        var pdfDoc = null;
        var scale = 1; //Set Scale for zooming PDF.
        var resolution = 1; //Set Resolution to Adjust PDF clarity.

        function LoadPdfFromBlob(blob) {
            //Read PDF from BLOB.
            pdfjsLib.getDocument({ data: blob }).promise.then(function (pdfDoc_) {
                pdfDoc = pdfDoc_;

                //Reference the Container DIV.
                var pdf_container = document.getElementById("pdf_container");
                pdf_container.innerHTML = "";
                pdf_container.style.display = "block";

                //Loop and render all pages.
                for (var i = 1; i <= pdfDoc.numPages; i++) {
                    RenderPage(pdf_container, i);
                }
            });
        };
        function RenderPage(pdf_container, num) {
            pdfDoc.getPage(num).then(function (page) {
                //Create Canvas element and append to the Container DIV.
                var canvas = document.createElement('canvas');
                canvas.id = 'pdf-' + num;
                ctx = canvas.getContext('2d');
                pdf_container.appendChild(canvas);

                //Create and add empty DIV to add SPACE between pages.
                var spacer = document.createElement("div");
                spacer.style.height = "20px";
                pdf_container.appendChild(spacer);

                //Set the Canvas dimensions using ViewPort and Scale.
                var viewport = page.getViewport({ scale: scale });
                canvas.height = resolution * viewport.height;
                canvas.width = resolution * viewport.width;

                //Render the PDF page.
                var renderContext = {
                    canvasContext: ctx,
                    viewport: viewport,
                    transform: [resolution, 0, 0, resolution, 0, 0]
                };

                page.render(renderContext);
            });
        };
    </script>
    <%-- Fin off Gridview --%>
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
