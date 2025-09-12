<%@ Page Title="Inventario" Language="C#"
    MasterPageFile="~/Site.master"
    AutoEventWireup="true"
    CodeBehind="Inventario.aspx"
    Inherits="WebInventoryControl.Inventario" %>

<asp:Content ID="HeadInv" ContentPlaceHolderID="HeadContent" runat="server">
           <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
<link href="<%= ResolveUrl("~/Content/pages/inventario.css") %>" rel="stylesheet" />
</asp:Content>

<asp:Content ID="MainInv" ContentPlaceHolderID="MainContent" runat="server">
    <h2 class="mb-3">Inventario</h2>
<div class="table_component" role="region" tabindex="0">
<table>
    <caption>
        <font>
            <font>Tabla de prueba.</font>
        </font>
    </caption>
    <thead>
        <tr>
            <th>Código del articulo</th>
            <th>Numero de parte</th>
            <th>Descripción&nbsp;</th>
            <th>Stock actual</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
        </tr>
        <tr>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
        </tr>
        <tr>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
        </tr>
        <tr>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
        </tr>
    </tbody>
</table>

</asp:Content>

<asp:Content ID="SidebarInv" ContentPlaceHolderID="SidebarContent" runat="server">
    
  
</asp:Content>
