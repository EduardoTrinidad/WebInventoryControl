<%@ Page Title="Proveedores" Language="C#"
    MasterPageFile="~/Site.master"
    AutoEventWireup="true"
    Inherits="System.Web.UI.Page" %>

<asp:Content ID="HeadProveedores" ContentPlaceHolderID="HeadContent" runat="server">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
  <link href="<%= ResolveUrl("~/Content/pages/provedores.css") %>" rel="stylesheet" />

  <style>
    .top-tabs {
      display:flex; align-items:center; gap:.75rem;
    }
    .top-tabs .title {
      font-weight:600; font-size:1.1rem;
    }

    .radio-inputs {
      display:inline-flex; gap:.25rem; padding:.35rem;
      border-radius:14px; background:#d7ded9;
      box-shadow:0 2px 6px rgba(0,0,0,.08) inset, 0 1px 2px rgba(0,0,0,.06);
    }
    .radio-inputs .radio { position:relative; }
    .radio-inputs .radio input { display:none; }

    .radio-inputs .radio .name{
      display:inline-block; padding:.45rem 1rem; border-radius:10px;
      font-size:.95rem; font-weight:500; color:#2e2e2e; cursor:pointer;
      transition:all .2s ease;
    }
    .radio-inputs .radio .name:hover { background:#c7d0cb; }

    .radio-inputs .radio input:checked + .name{
      color:#fff; box-shadow:0 2px 6px rgba(0,0,0,.12);
      background:linear-gradient(135deg,#3bb78f 0%, #0bab64 100%);
    }


    .mode-badge{
      font-size:.85rem; padding:.25rem .5rem; border-radius:999px;
      background:#eef7f1; color:#136a3b; border:1px solid #cfe9db;
      display:inline-flex; align-items:center; gap:.4rem;
    }
    .mode-badge .dot{
      width:.5rem;height:.5rem;border-radius:999px;background:#18a166;display:inline-block;
    }
    .tidy tr.selected { outline:2px solid #0bab64; background: #e9faf2; }
  </style>
</asp:Content>

<asp:Content ID="MainProveedores" ContentPlaceHolderID="MainContent" runat="server">
  <div class="wrap">
    <div class="card">
      <div class="card-header d-flex justify-content-between align-items-center">
        <div class="top-tabs">
          <div class="title">Proveedores</div>
          <span id="modeChip" class="mode-badge" title="Modo actual">
            <span class="dot"></span> <b>Registrar</b>
          </span>
        </div>


        <div class="radio-inputs" id="modeRadios">
          <label class="radio">
            <input type="radio" name="modo" value="registrar" checked />
            <span class="name">Registrar</span>
          </label>
          <label class="radio">
            <input type="radio" name="modo" value="actualizar" />
            <span class="name">Actualizar</span>
          </label>
        </div>
      </div>

      <div class="card-body">
        <div class="toolbar">
          <input id="txtBuscar" type="text" class="input" placeholder="Buscar por nombre, ciudad, estado, país o teléfono…" />
          <button id="btnBuscar" type="button" class="btn">Buscar</button>
          <button id="btnLimpiar" type="button" class="btn">Limpiar</button>
        </div>

        <div class="table-wrap">
          <table class="tidy">
            <thead>
              <tr>
                <th>Id proveedor</th>
                <th>Nombre</th>
                <th>Dirección</th>
                <th>Ciudad</th>
                <th>Estado/Provincia</th>
                <th>Código Postal</th>
                <th>País</th>
                <th>Teléfono</th>
              </tr>
            </thead>
            <tbody id="tbodyProveedores"></tbody>
          </table>
        </div>
      </div>
    </div>
  </div>

  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

  <script>
      const API_URL = 'https://localhost:7059/api/proveedores/Proveedores_tabla';

      let _cacheProveedores = [];
      let currentMode = 'registrar';   // registrar | actualizar
      let selectedId = null;

      function pick(item, variants, autoRegex) {
          for (const key of variants) {
              if (key in item && item[key] != null) return item[key];
              const found = Object.keys(item).find(k => k.toLowerCase() === key.toLowerCase());
              if (found && item[found] != null) return item[found];
          }
          if (autoRegex) {
              const k = Object.keys(item).find(k => autoRegex.test(k.toLowerCase()));
              if (k && item[k] != null) return item[k];
          }
          return '';
      }

      function pintarTabla(rows) {
          const $tbody = $('#tbodyProveedores');
          $tbody.empty();

          if (!Array.isArray(rows) || rows.length === 0) {
              $tbody.html('<tr><td colspan="8" class="text-center">Sin resultados.</td></tr>');
              return;
          }

          rows.forEach(item => {
              const ID_Proveedor = pick(item,
                  ['ID_Proveedor', 'Id_Proveedor', 'id_Proveedor', 'id_proveedor', 'IdProveedor', 'ProveedorID', 'Proveedor_Id', 'Id', 'ID'],
                  /(^id.*proveedor$)|(^id$)|(^proveedor.*id$)/i
              );
              const Nombre = pick(item, ['Nombre_Proveedor', 'nombre_Proveedor', 'Nombre', 'nombre']);
              const Direccion = pick(item, ['Direccion', 'direccion', 'Dirección', 'dirección']);
              const Ciudad = pick(item, ['Ciudad', 'ciudad']);
              const State_Prov = pick(item, ['State_Prov', 'state_Prov', 'Estado', 'estado', 'Estado_Provincia', 'estado_provincia']);
              const Codigo_Postal = pick(item, ['Codigo_Postal', 'codigo_Postal', 'CP', 'cp', 'CodigoPostal', 'codigoPostal']);
              const Pais = pick(item, ['Pais', 'pais', 'País', 'país']);
              const Telefono = pick(item, ['Telefono', 'telefono', 'Tel', 'tel']);

              const row = `
          <tr data-id="${ID_Proveedor}">
            <td class="id-cell">${ID_Proveedor}</td>
            <td>${Nombre}</td>
            <td>${Direccion}</td>
            <td>${Ciudad}</td>
            <td>${State_Prov}</td>
            <td>${Codigo_Postal}</td>
            <td>${Pais}</td>
            <td>${Telefono}</td>
          </tr>`;
              $tbody.append(row);
          });
      }

      function cargarProveedores() {
          const $tbody = $('#tbodyProveedores');
          $tbody.html('<tr><td colspan="8" class="text-center">Cargando…</td></tr>');

          $.ajax({
              url: API_URL,
              method: 'GET',
              success: function (data) {
                  _cacheProveedores = Array.isArray(data) ? data : (Array.isArray(data?.datos) ? data.datos : []);
                  if (_cacheProveedores.length) console.log('Ejemplo proveedor:', _cacheProveedores[0]);
                  pintarTabla(_cacheProveedores);
              },
              error: function (xhr) {
                  $('#tbodyProveedores').html(
                      '<tr><td colspan="8" class="text-center text-danger">Error al cargar datos.</td></tr>'
                  );
                  console.error('Error API proveedores:', xhr?.status, xhr?.responseText);
              }
          });
      }

      function normalizarTexto(t) {
          return (t ?? '').toString().toLowerCase().trim();
      }

      function filtrar() {
          const q = normalizarTexto($('#txtBuscar').val());
          if (!q) { pintarTabla(_cacheProveedores); return; }

          const filtrados = _cacheProveedores.filter(item => {
              const id = normalizarTexto(pick(item,
                  ['ID_Proveedor', 'Id_Proveedor', 'id_proveedor', 'IdProveedor', 'ProveedorID', 'Id', 'ID'],
                  /(^id.*proveedor$)|(^id$)|(^proveedor.*id$)/i
              ));
              const nombre = normalizarTexto(pick(item, ['Nombre_Proveedor', 'Nombre']));
              const ciudad = normalizarTexto(pick(item, ['Ciudad']));
              const estado = normalizarTexto(pick(item, ['State_Prov', 'Estado']));
              const pais = normalizarTexto(pick(item, ['Pais']));
              const telefono = normalizarTexto(pick(item, ['Telefono']));

              return (
                  id.includes(q) || nombre.includes(q) || ciudad.includes(q) ||
                  estado.includes(q) || pais.includes(q) || telefono.includes(q)
              );
          });
          pintarTabla(filtrados);
      }
      function updateModeBadge() {
          const text = (currentMode === 'registrar') ? 'Registrar' : 'Actualizar';
          $('#modeChip b').text(text);
      }

      $(function () {
          cargarProveedores();

          // Buscar / Limpiar
          $('#btnBuscar').on('click', filtrar);
          $('#txtBuscar').on('keypress', e => { if (e.which === 13) filtrar(); });
          $('#btnLimpiar').on('click', function () {
              $('#txtBuscar').val('');
              pintarTabla(_cacheProveedores);
              $('#txtBuscar').focus();
          });

          $('#modeRadios input[name="modo"]').on('change', function () {
              currentMode = this.value;           // 'registrar' | 'actualizar'
              updateModeBadge();
              selectedId = null;
              $('#tbodyProveedores tr').removeClass('selected');
              console.log('Modo actual:', currentMode);
          });

          $('#tbodyProveedores').on('click', 'tr', function () {
              if (currentMode !== 'actualizar') return;

              $('#tbodyProveedores tr').removeClass('selected');
              $(this).addClass('selected');

              selectedId = $(this).data('id');
              console.log('Fila seleccionada (para actualizar):', selectedId);

              $('#modeChip').attr('title', 'ID seleccionado: ' + selectedId);
          });
      });
  </script>
</asp:Content>
