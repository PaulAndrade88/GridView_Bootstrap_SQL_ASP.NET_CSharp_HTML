<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="ADO.Default" %>
 
<asp:Content ID="ContentPlaceHolder" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"/>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <h3>
        <span style="float:left">
            <asp:Label ID="lblInfo" runat="server" Text="Total of selected items: " CssClass="label label-info" Font-Size="Small"/>
            <asp:Label ID="lblTotalItemsSelected" runat="server" CssClass="badge"/>
        </span>        
        <span style="float:right">
            <small><strong>Total clientes:</strong></small> 
            <asp:Label ID="lblTotalClientes" runat="server" CssClass="label label-warning" />
        </span>
    </h3>
    <br /><br />
    <asp:GridView ID="GridView_Clientes" runat="server" DataSourceID="SqlDataSource1"
        AutoGenerateColumns="False" 
        CssClass="table table-bordered bs-table" 
        DataKeyNames="CustomerID" 
        OnRowDeleted="GridView_Clientes_RowDeleted" 
        OnRowUpdated="GridView_Clientes_RowUpdated" 
        OnRowEditing="GridView_Clientes_RowEditing" 
        OnDataBound="GridView_Clientes_DataBound" 
        allowpaging="true" >
 
        <HeaderStyle BackColor="#337ab7" Font-Bold="True" ForeColor="White" />
        <EditRowStyle BackColor="#ffffcc" />
        <EmptyDataRowStyle forecolor="Red" CssClass="table table-bordered" />
        <emptydatatemplate>
            ¡No hay clientes con los parametros seleccionados!  
        </emptydatatemplate>           
         
        <pagertemplate>
        <div class="row" style="margin-top:20px;">
            <div class="col-lg-1" style="text-align:left;">
                <h5><asp:label id="MessageLabel" text="Ir a la pág." runat="server" /></h5>
            </div>
             <div class="col-lg-1" style="text-align:left;">
                <asp:dropdownlist id="PageDropDownList" Width="70px" autopostback="true" onselectedindexchanged="PageDropDownList_SelectedIndexChanged" runat="server" CssClass="form-control" /></h3>
            </div>
            <div class="col-lg-10" style="text-align:right;">
                <h3><asp:label id="CurrentPageLabel" runat="server" CssClass="label label-warning" /></h3>
            </div>
        </div>        
        </pagertemplate>              
        <Columns> 
            <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="70px" HeaderText="Select">
                <ItemTemplate>
                    <asp:CheckBox ID="chkEliminar" runat="server" AutoPostBack="true" OnCheckedChanged="chk_OnCheckedChanged" />
                </ItemTemplate>
            </asp:TemplateField>                         
  
            <asp:BoundField DataField="CustomerID" HeaderText="Nº" InsertVisible="False" ReadOnly="True" SortExpression="CustomerID" ControlStyle-Width="70px" />
            <asp:BoundField DataField="CustomerID" HeaderText="Cód." InsertVisible="False" ReadOnly="True" SortExpression="CustomerID" ControlStyle-Width="70px" />
            <asp:BoundField DataField="CompanyName" HeaderText="Compañía" ReadOnly="True" SortExpression="CompanyName" ControlStyle-Width="200px" />
            <asp:BoundField DataField="Country" HeaderText="Pais" ReadOnly="True" SortExpression="Country" />
  
            <asp:TemplateField HeaderStyle-Width="250px" HeaderText="Contacto">
                <ItemTemplate>
                    <asp:Label id="lblContactName" runat="server"><%# Eval("ContactName")%></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="TxtContactName" runat="server" Text='<%# Bind("ContactName")%>' CssClass="form-control" ></asp:TextBox>
                </EditItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderStyle-Width="150px" HeaderText="Teléfono">
                <ItemTemplate>
                    <asp:Label id="lblPhone" runat="server"><%# Eval("Phone")%></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="TxtPhone" runat="server" Text='<%# Bind("Phone")%>' CssClass="form-control" ></asp:TextBox>
                </EditItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="200px" HeaderText="Options">
                <ItemTemplate>
                     <asp:Button ID="btnDelete" runat="server" Text="Quitar" CssClass="btn btn-danger" CommandName="Delete" OnClientClick="return confirm('¿Eliminar cliente?');" />
                    <asp:Button ID="btnEdit" runat="server" Text="Editar" CssClass="btn btn-info" CommandName="Edit" />
                </ItemTemplate>
                <edititemtemplate>
                     <asp:Button ID="btnUpdate" runat="server" Text="Grabar" CssClass="btn btn-success" CommandName="Update" OnClientClick="return confirm('¿Seguro que quiere modificar los datos del cliente?');" />
                    <asp:Button ID="btnCancel" runat="server" Text="Cancelar" CssClass="btn btn-default" CommandName="Cancel" />
                </edititemtemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" OnSelected="SqlDataSource1_Selected"
        ConnectionString="<%$ ConnectionStrings:NorthwindConnectionString %>" 
        DeleteCommand="EXECUTE spDelete_Customers @CustomerID"
        SelectCommand="SELECT * FROM [Customers]" 
        UpdateCommand="UPDATE [Customers] SET [ContactName] = @ContactName, [Phone] = @Phone WHERE [CustomerID] = @CustomerID">
        <DeleteParameters>
            <asp:Parameter Name="CustomerID" Type="String" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="ContactName" Type="String" />
            <asp:Parameter Name="Phone" Type="String" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <h3 style="text-align:center">
        <span class="label label-info">
        <asp:LinkButton ID="btnQuitarSeleccionados" runat="server" OnClick="btnQuitarSeleccionados_Click"
            OnClientClick="return confirm('¿Quitar cliente/s de la lista?');"><span style="color:white">Quitar Clientes seleccionados</span>
        </asp:LinkButton>
            </span>
    </h3>
</asp:Content>