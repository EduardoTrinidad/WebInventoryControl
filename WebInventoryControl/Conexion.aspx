<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Conexion.aspx.cs" Inherits="WebInventoryControl.Conexion" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

    <title></title>

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-Fy6S3B9q64WdZWQUiU+q4/2Lc9npb8tCaSX9FK7E8HnRr0Jz8D6OP9dO5Vg3Q9ct" crossorigin="anonymous"></script>
   
</head>
<body>
    <form id="form1" runat="server">
         <div class="d-flex justify-content-between align-items-center mb-3">
    <h2 class="mb-0">Inventario</h2>
    <button id="btnRefrescar" type="button" class="btn btn-outline-primary btn-sm">Refrescar</button>
  </div>

  <!-- Tu tabla (sin cambios) -->
<div class="table-responsive">
  <table id="tblInventario" class="table table-striped table-bordered table-sm align-middle">
    <thead class="thead-dark">
      <tr>
        <th>Código del artículo</th>
        <th>Número de parte</th>
        <th>Descripción</th>
        <th>Stock actual</th>
        <th>U/M</th>
        <th>Precio</th>
      </tr>
    </thead>
    <tbody></tbody>
  </table>
</div>

    </form>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        // Solo la petición AJAX, adaptada a #tblInventario
        $.ajax({
            url: 'https://localhost:7059/api/Inventario/Conexion_a_tabla_articulo',
            method: 'GET',
            // Si tienes filtros, pásalos aquí:
            // data: { fechaInicio, fechaFin, Order: order, Method: method, Customer: customer },
            success: function (data) {
                const $tbody = $('#tblInventario tbody');
                $tbody.empty();

                if (!Array.isArray(data) || data.length === 0) {
                    $tbody.html('<tr><td colspan="6" class="text-center">Sin resultados.</td></tr>');
                    return;
                }

                data.forEach(function (item) {
                    // Ajusta estas claves según tu API:
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
</body>
</html>
