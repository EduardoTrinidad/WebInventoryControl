<%@ Page Title="Inventario" Language="C#"
    MasterPageFile="~/Site.master"
    AutoEventWireup="true"
    CodeBehind="Inventario.aspx.cs"
    Inherits="WebInventoryControl.Inventario" %>

<asp:Content ID="HeadInv" ContentPlaceHolderID="HeadContent" runat="server">
  <!-- Bootstrap (solo estilos) -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
  <link href="<%= ResolveUrl("~/Content/pages/inventario.css") %>" rel="stylesheet" />
  <!-- jQuery ANTES de tu script -->
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</asp:Content>

<asp:Content ID="MainInv" ContentPlaceHolderID="MainContent" runat="server">
  <div class="d-flex justify-content-between align-items-center mb-3">
    <h2 class="mb-0">Inventario</h2>
  </div>

  <div class="table-responsive">
    <table id="tblInventario" class="table table-striped table-bordered table-sm align-middle">
      <thead>
        <tr>
          <th>Código del artículo</th>
          <th>Número de parte</th>
          <th>Descripción</th>
          <th>Stock actual</th>
          <th>U/M</th>
          <th>Precio</th>
          <th>Total</th>
        </tr>
      </thead>
      <tbody>
        <tr><td colspan="6" class="text-center">Cargando…</td></tr>
      </tbody>
    </table>
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
                 const total = stockActual * precio;

                 const row = `
     <tr data-id="${codigo}">
       <td class="id-cell">${codigo}</td>
       <td>${numeroParte}</td>
       <td>${descripcion}</td>
       <td class="text-end">${Number(stockActual).toLocaleString()}</td>
       <td>${um}</td>
       <td class="text-end">${precio.toLocaleString(undefined, { minimumFractionDigits: 2, maximumFractionDigits: 2 })}</td>
        <td class="text-end">${total.toLocaleString(undefined, { minimumFractionDigits: 2, maximumFractionDigits: 2 })}</td>
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

<asp:Content ID="SidebarInv" ContentPlaceHolderID="SidebarContent" runat="server"></asp:Content>
