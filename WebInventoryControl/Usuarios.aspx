<%@ Page Title="Usuarios" Language="C#"
    MasterPageFile="~/Site.master"
    AutoEventWireup="true"
    CodeBehind="Usuarios.aspx.cs"
    Inherits="WebInventoryControl.Usuarios" %>

<asp:Content ID="HeadUsuarios" ContentPlaceHolderID="HeadContent" runat="server">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
  <link href="<%= ResolveUrl("~/Content/pages/usuario.css") %>" rel="stylesheet" />

  <script>
    document.addEventListener('DOMContentLoaded', function () {
      var lbl = document.getElementById('clientTime');
      if (lbl) { lbl.textContent = "Cliente: " + new Date().toLocaleString(); }
    });
  </script>
</asp:Content>

<asp:Content ID="MainUsuarios" ContentPlaceHolderID="MainContent" runat="server">
  <div class="wrap">
    <div class="card">
      <div class="card-header d-flex justify-content-between align-items-center">
        <div class="title">Empleados</div>
        <div class="subtle"><span id="clientTime">Cliente: --/--/---- --:--</span></div>
      </div>

      <div class="card-body">
        <div class="row g-2 align-items-end mb-3">
          <div class="col-12 col-md-6">
            <label for="txtBuscar" class="form-label mb-1">Buscar</label>
            <input id="txtBuscar" type="text" class="form-control form-control-sm"
                   placeholder="Número de reloj o nombre…" />
          </div>
          <div class="col-8 col-md-4">
            <label for="selDepto" class="form-label mb-1">Departamento</label>
            <select id="selDepto" class="form-select form-select-sm">
              <option value="">Todos</option>
            </select>
          </div>
          <div class="col-4 col-md-2 d-grid">
            <button id="btnLimpiar" class="btn btn-outline-secondary btn-sm">Limpiar</button>
          </div>
        </div>

        <div class="table-wrap">
          <table class="table table-borderless table-sleek" id="tblUsuarios">
            <thead>
              <tr>
                <th>Número de reloj</th>
                <th>Nombre del empleado</th>
                <th>Puesto del empleado</th>
                <th>Departamento</th>
                <th>Turno</th>
              </tr>
            </thead>
            <tbody id="tbodyUsuarios">
            </tbody>
          </table>
        </div>
      </div>
    </div>
  </div>

  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script>
      let _usuariosCache = [];

      function cargarUsuarios() {
          $.ajax({
              url: 'https://localhost:7059/api/usuario/usuario_tabla',
              method: 'GET',
              success: function (data) {
                  _usuariosCache = Array.isArray(data) ? data : [];
                  llenarDeptos(_usuariosCache);
                  pintarUsuarios(_usuariosCache);
              },
              error: function () {
                  $('#tbodyUsuarios').html('<tr><td colspan="5" class="text-center text-danger">Error al cargar datos.</td></tr>');
              }
          });
      }

      function llenarDeptos(lista) {
          const deptos = [...new Set(lista
              .map(u => (u.dpto_Empleado ?? u.Dpto_Empleado ?? '').trim())
              .filter(Boolean))].sort();

          const $sel = $('#selDepto');
          $sel.find('option:not(:first)').remove();
          deptos.forEach(d => $sel.append(`<option value="${d}">${d}</option>`));
      }
      function pintarUsuarios(lista) {
          const $tbody = $('#tbodyUsuarios');
          $tbody.empty();

          if (!Array.isArray(lista) || lista.length === 0) {
              $tbody.html('<tr><td colspan="5" class="text-center">Sin resultados.</td></tr>');
              return;
          }

          lista.forEach(item => {
              const numReloj = item.num_Reloj_Empleado ?? item.Num_Reloj_Empleado ?? '';
              const nombre = item.nombre_Empleado ?? item.Nombre_Empleado ?? '';
              const puesto = item.puesto_Empleado ?? item.Puesto_Empleado ?? '';
              const dpto = item.dpto_Empleado ?? item.Dpto_Empleado ?? '';
              const turno = item.turno_Empleado ?? item.Turno_Empleado ?? '';

              const row = `
          <tr data-id="${numReloj}">
            <td class="id-cell">${numReloj}</td>
            <td>${nombre}</td>
            <td>${puesto}</td>
            <td>${dpto}</td>
            <td>${turno}</td>
          </tr>`;
              $tbody.append(row);
          });
      }
      function aplicarFiltros() {
          const q = ($('#txtBuscar').val() || '').toLowerCase().trim();
          const deptoSel = $('#selDepto').val();

          const filtrados = _usuariosCache.filter(u => {
              const num = (u.num_Reloj_Empleado ?? u.Num_Reloj_Empleado ?? '').toString().toLowerCase();
              const nom = (u.nombre_Empleado ?? u.Nombre_Empleado ?? '').toLowerCase();
              const dpto = u.dpto_Empleado ?? u.Dpto_Empleado ?? '';

              const coincideTexto = !q || num.includes(q) || nom.includes(q);
              const coincideDepto = !deptoSel || dpto === deptoSel;

              return coincideTexto && coincideDepto;
          });

          pintarUsuarios(filtrados);
      }

      $('#txtBuscar').on('input', aplicarFiltros);
      $('#selDepto').on('change', aplicarFiltros);
      $('#btnLimpiar').on('click', function () {
          $('#txtBuscar').val('');
          $('#selDepto').val('');
          pintarUsuarios(_usuariosCache);
      });

      $(document).ready(cargarUsuarios);
  </script>
</asp:Content>
