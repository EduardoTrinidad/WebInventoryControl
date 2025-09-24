<%@ Page Title="Inicio" Language="C#"
    MasterPageFile="~/Site.master"
    AutoEventWireup="true"
    CodeBehind="Inicio.aspx.cs"
    Inherits="WebInventoryControl.Inicio" %>

<asp:Content ID="HeadInicio" ContentPlaceHolderID="HeadContent" runat="server">
  <link href="<%= ResolveUrl("~/Content/pages/inicio.css") %>" rel="stylesheet" />
</asp:Content>

<asp:Content ID="MainInicio" ContentPlaceHolderID="MainContent" runat="server">
  <div class="page">
    
    <header class="page-header">
      <div class="heading">
        <h1>Dashboard de Inventario</h1>
        <p>Bienvenido al sistema Toolcrib</p>
      </div>
    </header>

    <div class="table-wrap">
      <table class="info-table">
        <thead>
          <tr>
            <th>Inventario Neto</th>
            <th>Artículos</th>
            <th>Stock en mínimo</th>
            <th>Empleados</th>
            <th>Proveedores</th>
            <th>Depto mayor costo</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td><asp:Literal ID="litInventarioNeto" runat="server" Text="0" /></td>
            <td>
              Total: <asp:Literal ID="litArticulos" runat="server" Text="0" /><br />
              Activos: <asp:Literal ID="litActivos" runat="server" Text="0" /><br />
              No disp: <asp:Literal ID="litDesc" runat="server" Text="0" />
            </td>
            <td><asp:Literal ID="litMinimos" runat="server" Text="0" /></td>
            <td><asp:Literal ID="litEmpleados" runat="server" Text="0" /></td>
            <td><asp:Literal ID="litProveedores" runat="server" Text="0" /></td>
            <td><asp:Literal ID="litDeptoCosto" runat="server" Text="N/A" /></td>
          </tr>
        </tbody>
      </table>

      <table class="info-table">
        <thead>
          <tr>
            <th>Total Entradas</th>
            <th>Total Salidas</th>
            <th>% Entradas</th>
            <th>% Salidas</th>
            <th>% Artículos en mínimo</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td><asp:Literal ID="litEntradas" runat="server" Text="0" /></td>
            <td><asp:Literal ID="litSalidas" runat="server" Text="0" /></td>
            <td id="pctIn">0%</td>
            <td id="pctOut">0%</td>
            <td id="donutPct">0%</td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>

    $.ajax({
              url: 'https://localhost:7059/api/Inventario/Conexion_a_tabla_articulo',
              method: 'GET',
              success: function (data) {
                  const $tbody = $('#tblInventario tbody');
                  $tbody.empty();

                  if (!Array.isArray(data) || data.length === 0) {
                      $tbody.html('<tr><td colspan="6" class="text-center">Sin resultados.</td></tr>');
                      return;
                  }

                  data.forEach(function (item) {

                      const codigo = item.codigo_Articulo ?? item.ccodigo_Articulo ?? item.codigo_Articulo ?? '';
                      const numeroParte = item.numero_Parte_Articulo ?? item.numero_Parte_Articulo ?? '';
                      const descripcion = item.descripcion_Articulo ?? item.descripcion_Articulo ?? '';
                      const stockActual = item.stock_Actual_Articulo ?? item.stock_Actual_Articulo ?? 0;
                      const um = item.unidad_Medida_Articulo ?? item.unidad_Medida_Articulo ?? '';
                      const precio = item.precio_Articulo ?? item.precio_Articulo ?? 0;

                      const row = `
    <tr data-id="${codigo}">
      <td class="id-cell">${codigo}</td>
      <td>${numeroParte}</td>
      <td>${descripcion}</td>
      <td class="text-end">${Number(stockActual).toLocaleString()}</td>
      <td>${um}</td>
      <td class="text-end">${Number(precio).toLocaleString(undefined, { minimumFractionDigits: 2, maximumFractionDigits: 2 })}</td>
    </tr>`;
                      $tbody.append(row);
                  });
              },
              error: function () {
                  $('#tblInventario tbody').html('<tr><td colspan="6" class="text-center text-danger">Error al cargar datos.</td></tr>');
              }
          });

  </script>
</asp:Content>
