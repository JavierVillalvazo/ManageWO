<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="grid.aspx.cs" Inherits="ManageWO.grid" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

</head>
<body>
    <form id="form1" runat="server">
        
            <asp:GridView ID="gvCustomers" runat="server" AutoGenerateColumns="false" CssClass="Grid"
                DataKeyNames="WorkOrder" OnRowDataBound="gvCustomers_RowDataBound">
                <EmptyDataTemplate>
                    sinregistros 
                </EmptyDataTemplate>
                <Columns>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <img alt="" style="cursor: pointer" src="images/plus.png" />
                            <img alt="" style="cursor: pointer; display: none" src="images/minus.png" />
                            <asp:Panel ID="pnlOrders" runat="server" Style="display: none">
                                <asp:GridView ID="gvOrders" runat="server" AutoGenerateColumns="false" CssClass="ChildGrid">
                                    <Columns>
                                        <asp:BoundField ItemStyle-Width="150px" DataField="WorkOrder" HeaderText="WorkOrder" />
                                        <asp:BoundField ItemStyle-Width="150px" DataField="Partnumber" HeaderText="Partnumber" />

                                        <%--<asp:BoundField ItemStyle-Width="150px" DataField="AlternatePartNumber" HeaderText="AlternatePartNumber" />--%>
                                    </Columns>
                                </asp:GridView>
                            </asp:Panel>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField ItemStyle-Width="150px" DataField="Workorder" HeaderText="Workorder" />
                    <asp:BoundField ItemStyle-Width="150px" DataField="Model" HeaderText="Model" />
                </Columns>
            </asp:GridView>

            <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
            <script type="text/javascript">
                $("[src*=plus]").on("click", function () {
                    $(this).closest("tr").after("<tr><td></td><td class='orders' colspan = '999'>" + $(this).closest("tr").find("[id*=Workorder]").html() + "</td></tr>");
                    $(this).closest("tr").find("[src*=minus]").show();
                    $(this).hide();
                });
                $("[src*=minus]").on("click", function () {
                    $(this).closest("tr").next().remove();
                    $(this).closest("tr").find("[src*=plus]").show();
                    $(this).hide();
                });
            </script>
    </form>
</body>
</html>
