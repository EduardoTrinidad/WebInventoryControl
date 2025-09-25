<%@ Page Title="Inventario" Language="C#"
    MasterPageFile="~/Site.master"
    AutoEventWireup="true"
    CodeBehind="Inventario.aspx.cs"
    Inherits="WebInventoryControl.Inventario" %>

<asp:Content ID="HeadInv" ContentPlaceHolderID="HeadContent" runat="server">
  <!-- Bootstrap -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />

  <!-- Tu hoja (con cache-buster) -->
  <link href="<%= ResolveUrl("~/Content/pages/inventario.css?v=20250925") %>" rel="stylesheet" />

  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</asp:Content>

<asp:Content ID="MainInv" ContentPlaceHolderID="MainContent" runat="server">
  <div class="d-flex justify-content-between align-items-center mb-3">
    <h2 class="mb-0">Inventario</h2>
    <div class="d-flex gap-2">
      <button id="btnPrintInv" type="button" class="btn btn-outline-secondary">Imprimir</button>
      <button id="btnCSVInv" type="button" class="btn btn-primary">Exportar CSV</button>
    </div>
  </div>

  <div class="table-responsive">
    <table id="tblInventario" class="table table-sm align-middle" aria-describedby="statusInv">
      <colgroup>
        <col style="width: 140px" />  
        <col style="width: 180px" />  
        <col style="width: 260px" />  
        <col style="width: 140px" /> 
        <col style="width: 110px" />  
        <col style="width: 140px" />  
        <col style="width: 160px" />  
      </colgroup>

      <thead>
        <tr>
          <th scope="col">Código del artículo</th>
          <th scope="col">Número de parte</th>
          <th scope="col">Descripción</th>
          <th scope="col">Stock actual</th>
          <th scope="col">U/M</th>
          <th scope="col">Precio</th>
          <th scope="col">Total</th>
        </tr>
      </thead>

      <tbody>
        <tr><td colspan="7" class="text-center">Cargando…</td></tr>
      </tbody>
    </table>
  </div>

  <div id="statusInv" class="visually-hidden" aria-live="polite">Cargando inventario…</div>

  <script>
      function fmt2(n) {
          const num = Number(n || 0);
          return num.toLocaleString(undefined, { minimumFractionDigits: 2, maximumFractionDigits: 2 });
      }
      function pick(obj, keys, fallback = '') {
          for (const k of keys) {
              if (obj && obj[k] != null && obj[k] !== '') return obj[k];
          }
          return fallback;
      }
      $(async function () {
          const $tbody = $('#tblInventario tbody');
          const $status = $('#statusInv');

          try {
              $status.text('Cargando inventario…');
              
              const url = 'https://localhost:7059/api/Inventario/Conexion_a_tabla_articulo?ts=' + Date.now();

              const res = await fetch(url, { method: 'GET' });
              if (!res.ok) throw new Error('HTTP ' + res.status);

              const data = await res.json();
              $tbody.empty();

              if (!Array.isArray(data) || data.length === 0) {
                  $tbody.html('<tr><td colspan="7" class="text-center">Sin resultados.</td></tr>');
                  $status.text('Sin resultados.');
                  return;
              }

              const rows = [];
              data.forEach(function (item) {
                  const codigo = pick(item, ['codigo_Articulo', 'Codigo_Articulo', 'ccodigo_Articulo'], '');
                  const numeroParte = pick(item, ['numero_Parte_Articulo', 'Numero_Parte_Articulo'], '');
                  const descripcion = pick(item, ['descripcion_Articulo', 'Descripcion_Articulo'], '');
                  const stockActual = Number(pick(item, ['stock_Actual_Articulo', 'Stock_Actual_Articulo'], 0));
                  const um = pick(item, ['unidad_Medida_Articulo', 'Unidad_Medida_Articulo', 'UM'], '');
                  const precio = Number(pick(item, ['precio_Articulo', 'Precio_Articulo'], 0));
                  const total = stockActual * precio;

                  rows.push(`
            <tr data-id="${String(codigo).replace(/"/g, '&quot;')}">
              <td class="id-cell">${codigo}</td>
              <td>${numeroParte}</td>
              <td>${descripcion}</td>         <!-- Descripción: se justifica por CSS (nth-child(3)) -->
              <td class="text-end">${stockActual.toLocaleString()}</td>
              <td>${um}</td>
              <td class="text-end">${fmt2(precio)}</td>
              <td class="text-end">${fmt2(total)}</td>
            </tr>
          `);
              });

              $tbody.html(rows.join(''));
              $status.text(`Cargados ${rows.length} registros.`);
          } catch (e) {
              console.error(e);
              $tbody.html('<tr><td colspan="7" class="text-center text-danger">Error al cargar datos.</td></tr>');
              $('#statusInv').text('Error al cargar inventario.');
          }
      });

      function toCSVInventario() {
          const $table = $('#tblInventario');
          const headers = Array.from($table.find('thead th')).map(th => $(th).text().trim());

          const rows = [];
          $('#tblInventario tbody tr').each(function () {
              if ($(this).css('display') === 'none') return; 
              const cols = Array.from($(this).find('td')).map(td => {
                  const txt = ($(td).text() || '').trim();
                  return '"' + txt.replace(/"/g, '""') + '"';
              });
              if (cols.length) rows.push(cols.join(','));
          });

          if (!rows.length) {
              alert('No hay datos para exportar.');
              return;
          }

          const csvLines = [
              headers.map(h => '"' + h.replace(/"/g, '""') + '"').join(','),
              ...rows
          ];

          const BOM = '\uFEFF';
          const blob = new Blob([BOM + csvLines.join('\n')], { type: 'text/csv;charset=utf-8;' });

          const url = URL.createObjectURL(blob);
          const a = document.createElement('a');
          const fecha = new Date().toISOString().slice(0, 10);
          a.href = url;
          a.download = `inventario_${fecha}.csv`;
          a.click();
          URL.revokeObjectURL(url);
      }

      $(document).on('click', '#btnCSVInv', toCSVInventario);
      $(document).on('click', '#btnPrintInv', () => window.print());
  </script>
</asp:Content>

<asp:Content ID="SidebarInv" ContentPlaceHolderID="SidebarContent" runat="server"></asp:Content>
