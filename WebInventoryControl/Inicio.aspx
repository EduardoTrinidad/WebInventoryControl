<%@ Page Title="Inicio" Language="C#"
    MasterPageFile="~/Site.master"
    AutoEventWireup="true"
    CodeBehind="Inicio.aspx.cs"
    Inherits="WebInventoryControl.Inicio" %>

<asp:Content ID="HeadInicio" ContentPlaceHolderID="HeadContent" runat="server">
    <link href="<%= ResolveUrl("~/Content/pages/inicio.css") %>" rel="stylesheet" />

</asp:Content>

<asp:Content ID="MainInicio" ContentPlaceHolderID="MainContent" runat="server">
  <div class="container mt-4">
    <h1>Herramientas</h1>
    <p>Bienvenido al sistema Toolcrib</p>

    <div class="dashboard">

      <div class="card">
        <div class="card-info">
          <p class="title">Inventario Neto</p>
          <h2>648,969.32</h2>
          <p>Unidades en stock</p>
        </div>
      </div>

      <div class="card">
        <div class="card-info">
          <p class="title">Articulos</p>
          <h2>1435</h2>
          <p>Artículos registrados</p>
        </div>
      </div>

      <div class="card">
        <div class="card-info">
          <p class="title">Articulos en Stock (minimo)</p>
          <h2>221</h2>
        </div>
      </div>

      <div class="card">
        <div class="card-info">
          <p class="title">Entradas</p>
          <h2>23,000.14</h2>
        </div>
      </div>

        <div class="card">
  <div class="card-info">
    <p class="title">Salidas</p>
    <h2>25,203.90</h2>
  </div>
</div>

<div class="card">
  <div class="card-info">
    <p class="title">Empleados</p>
    <h2>926</h2>
  </div>
</div>

<div class="card">
  <div class="card-info">
    <p class="title">Provedores</p>
    <h2>30</h2>
  </div>
</div>

<div class="card">
  <div class="card-info">
    <p class="title">Departamentos que generan mas costos</p>
    <h2>PR</h2>
  </div>
</div>
    </div>
  </div>
</asp:Content>

<asp:Content ID="SidebarInicio" ContentPlaceHolderID="SidebarContent" runat="server">
</asp:Content>
