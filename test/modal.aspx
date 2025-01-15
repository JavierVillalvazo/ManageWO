<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="modal.aspx.cs" Inherits="ManageWO.test.test" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>test</title>
     <meta name="viewport" content="width=device-width, initial-scale=1.0" />
 <meta name="description" title="Create, update and delete Work Orders for PTH" />
 <link href="~/resources/images/icon.ico" rel="shortcut icon" />
 <link rel="stylesheet" href="Resources/CSS/Styles.css" />
 <link rel="stylesheet" href="Resources/CSS/site.css" />
 <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" />
 <!-- Font Awesome CSS -->
 <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous" />
 <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous" />
 <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

</head>
<body>
    


        <asp:Content ContentPlaceHolderID="headcontent" runat="server">
    <script type="text/javascript">
        function ShowStatus() {
            $(document).ready(function () {
                $("#SubscriptionPopUp").modal("show");
            })
        }

        function closeModal(e) {
            e.preventDefault();
            $("#SubscriptionPopUp").modal("hide");
            return false;  // don't want a post back
        }
    </script>
</asp:Content>

<asp:Content ContentPlaceHolderID="MainContentHolder" runat="server">
    <asp:GridView ID="gvTest" runat="server" AutoGenerateColumns="false" OnRowDataBound="gvTest_RowDataBound" OnRowCommand="gvTest_RowCommand">
        <Columns>
            <asp:TemplateField>
                <ItemTemplate>
                    <div class="row">
                        <asp:Button ID="btnShowSubscription" runat="server" CommandName="Subscription" Text="Show Subscription Data" />
                    </div>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>


    <div id="SubscriptionPopUp" class="modal fade" role="dialog">
        <div class="modal-dialog modal-dialog-scrollable modal-dialog-centered modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title">Subscription Details</h4>
                </div>
                <div class="modal-body">
                    <asp:Label ID="lblTestOutput" runat="server" />
                </div>
                <div class="modal-footer">
                    <button id="btnClose" onclick="closeModal(event)" class="btn btn-success">Close</button>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

       
        <script type="text/javascript">
            const exampleModal = document.getElementById('exampleModal')
            if (exampleModal) {
                exampleModal.addEventListener('show.bs.modal', event => {
                    // Button that triggered the modal
                    const button = event.relatedTarget
                    // Extract info from data-bs-* attributes
                    const recipient = button.getAttribute('data-bs-whatever')
                    // If necessary, you could initiate an Ajax request here
                    // and then do the updating in a callback.

                    // Update the modal's content.
                    const modalTitle = exampleModal.querySelector('.modal-title')
                    const modalBodyInput = exampleModal.querySelector('.modal-body input')

                    modalTitle.textContent = `New message to ${recipient}`
                    modalBodyInput.value = recipient
                })
            }
        </script>
  <%--          <div class="modal fade" id="exampleModalToggle" aria-hidden="true" aria-labelledby="exampleModalToggleLabel" tabindex="-1">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="exampleModalToggleLabel">Modal 1</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        Show a second modal and hide this one with the button below.
      </div>
      <div class="modal-footer">
        <button class="btn btn-primary" data-bs-target="#exampleModalToggle2" data-bs-toggle="modal">Open second modal</button>
      </div>
    </div>
  </div>
</div>
<div class="modal fade" id="exampleModalToggle2" aria-hidden="true" aria-labelledby="exampleModalToggleLabel2" tabindex="-1">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="exampleModalToggleLabel2">Modal 2</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        Hide this modal and show the first with the button below.
      </div>
      <div class="modal-footer">
        <button class="btn btn-primary" data-bs-target="#exampleModalToggle" data-bs-toggle="modal">Back to first</button>
      </div>
    </div>
  </div>
</div>
<button class="btn btn-primary" data-bs-target="#exampleModalToggle" data-bs-toggle="modal">Open first modal</button>--%>



</body>
</html>
