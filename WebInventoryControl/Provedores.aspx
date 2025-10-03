<%@ Page Title="Proveedores" Language="C#"
    MasterPageFile="~/Site.master"
    AutoEventWireup="true"
    Inherits="System.Web.UI.Page" %>

<asp:Content ID="HeadProvedores" ContentPlaceHolderID="HeadContent" runat="server">
  <meta charset="utf-8" />
  <meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate" />
  <meta http-equiv="Pragma" content="no-cache" />
  <meta http-equiv="Expires" content="0" />
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
  <!-- CSS real (una sola “e”) + cache-buster -->
  <link href="<%= ResolveUrl("~/Content/pages/provedores.css?v=6") %>" rel="stylesheet" />
</asp:Content>

<asp:Content ID="MainProvedores" ContentPlaceHolderID="MainContent" runat="server">
  <div class="wrap">

    <!-- ===== Header ===== -->
    <div class="card">
      <div class="card-header d-flex justify-content-between align-items-center">
        <div class="top-tabs">
          <div class="title">Proveedores</div>
          <span id="modeChip" class="mode-badge" title="Modo actual">
            <span class="dot"></span> <b>—</b>
          </span>
        </div>
        <div class="actions">
          <button id="btnOpenRegistrar" type="button" class="btn-ghost">Registrar</button>
          <button id="btnOpenActualizar" type="button" class="btn-ghost alt" title="Actualizar proveedor seleccionado">Actualizar</button>
        </div>
      </div>
    </div>

    <!-- ===== Card superior: FORM (oculto por defecto) ===== -->
    <section id="formPane" class="card form-pane hidden" aria-live="polite">
      <div class="form-head">
        <h6 id="formTitle" class="m-0">Formulario</h6>
        <button id="btnClosePane" type="button" class="icon-btn" title="Cerrar">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>

      <form id="provForm" novalidate autocomplete="off">
        <input type="hidden" id="fldId" />
        <div class="grid">
          <label class="f"><span>Nombre</span><input id="fldNombre" class="input" required /></label>
          <label class="f"><span>Dirección</span><input id="fldDireccion" class="input" /></label>
          <label class="f"><span>Ciudad</span><input id="fldCiudad" class="input" /></label>
          <label class="f"><span>Estado / Provincia</span><input id="fldEstado" class="input" /></label>
          <label class="f"><span>Código Postal</span><input id="fldCP" class="input" /></label>
          <label class="f"><span>País</span><input id="fldPais" class="input" /></label>
          <label class="f"><span>Teléfono</span><input id="fldTel" class="input" /></label>
        </div>
        <div class="form-actions">
          <button id="btnSubmit" type="button" class="btn">Guardar</button>
          <button id="btnReset" type="button" class="btn soft">Limpiar</button>
        </div>
      </form>

      <p id="hintSeleccion" class="hint hidden">Selecciona un proveedor en la tabla para actualizar.</p>
    </section>

    <!-- ===== Card inferior: BUSCADOR + TABLA ===== -->
    <div class="card">
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

      const BASE = 'https://localhost:7059/api/proveedores';
      const API_GET = BASE + '/Proveedores_tabla';
      const API_POST = BASE + '/registrar';
      const API_PUT = BASE + '/actualizar'; 

 
      let _cacheProveedores = [];
      let currentMode = null;    
      let selectedId = null;

      const $tbody = () => $('#tbodyProveedores');
      const $pane = () => $('#formPane');

      function setMode(mode) {
          currentMode = mode;
          $('#modeChip b').text(mode ? (mode === 'registrar' ? 'Registrar' : 'Actualizar') : '—');
      }
      function openPane(mode) {
          setMode(mode);
          $('#formTitle').text(mode === 'registrar' ? 'Registrar proveedor' : 'Actualizar proveedor');
          $('#hintSeleccion').toggleClass('hidden', mode !== 'actualizar');
          $pane().removeClass('hidden');
          if (mode === 'registrar') {
              clearForm();
              selectedId = null;
              $('#tbodyProveedores tr').removeClass('selected');
          } else if (mode === 'actualizar') {
              if (selectedId) fillFormFromRow(selectedId);
              else { clearForm(); }
          }
      }
      function closePane() { $pane().addClass('hidden'); setMode(null); }

      function pick(obj, keys, autoRegex) {
          for (const k of keys) {
              if (k in obj && obj[k] != null) return obj[k];
              const f = Object.keys(obj).find(x => x.toLowerCase() === k.toLowerCase());
              if (f && obj[f] != null) return obj[f];
          }
          if (autoRegex) {
              const k = Object.keys(obj).find(x => autoRegex.test(x.toLowerCase()));
              if (k && obj[k] != null) return obj[k];
          }
          return '';
      }

      function pintarTabla(rows) {
          const $t = $tbody(); $t.empty();
          if (!Array.isArray(rows) || !rows.length) {
              $t.html('<tr><td colspan="8" class="text-center">Sin resultados.</td></tr>'); return;
          }
          rows.forEach(item => {
              const ID_Proveedor = pick(item, ['ID_Proveedor', 'Id_Proveedor', 'id_proveedor', 'IdProveedor', 'ProveedorID', 'Id', 'ID'],
                  /(^id.*proveedor$)|(^id$)|(^proveedor.*id$)/i);
              const Nombre = pick(item, ['Nombre_Proveedor', 'Nombre', 'nombre']);
              const Direccion = pick(item, ['Direccion', 'Dirección', 'direccion']);
              const Ciudad = pick(item, ['Ciudad']);
              const Estado = pick(item, ['State_Prov', 'Estado', 'Estado_Provincia']);
              const CP = pick(item, ['Codigo_Postal', 'CP', 'CodigoPostal']);
              const Pais = pick(item, ['Pais', 'País']);
              const Tel = pick(item, ['Telefono', 'Tel']);
              $t.append(`<tr data-id="${ID_Proveedor}">
          <td class="id-cell">${ID_Proveedor}</td>
          <td>${Nombre}</td><td>${Direccion}</td><td>${Ciudad}</td>
          <td>${Estado}</td><td>${CP}</td><td>${Pais}</td><td>${Tel}</td>
        </tr>`);
          });
      }

      function cargarProveedores() {
          $tbody().html('<tr><td colspan="8" class="text-center">Cargando…</td></tr>');
          $.ajax({
              url: API_GET,
              method: 'GET',
              success: (data) => {
                  _cacheProveedores = Array.isArray(data) ? data : (Array.isArray(data?.datos) ? data.datos : []);
                  pintarTabla(_cacheProveedores);
              },
              error: (xhr) => {
                  $tbody().html('<tr><td colspan="8" class="text-center text-danger">Error al cargar datos.</td></tr>');
                  console.error('API GET error:', xhr?.status, xhr?.responseText);
              }
          });
      }

      function normalizar(t) { return (t ?? '').toString().toLowerCase().trim(); }
      function filtrar() {
          const q = normalizar($('#txtBuscar').val());
          if (!q) { pintarTabla(_cacheProveedores); return; }
          const r = _cacheProveedores.filter(item => {
              const id = normalizar(pick(item, ['ID_Proveedor', 'Id', 'ID']));
              const n = normalizar(pick(item, ['Nombre_Proveedor', 'Nombre']));
              const c = normalizar(pick(item, ['Ciudad']));
              const e = normalizar(pick(item, ['State_Prov', 'Estado']));
              const p = normalizar(pick(item, ['Pais']));
              const t = normalizar(pick(item, ['Telefono']));
              return id.includes(q) || n.includes(q) || c.includes(q) || e.includes(q) || p.includes(q) || t.includes(q);
          });
          pintarTabla(r);
      }

      function fillFormFromRow(idBuscado) {
          const it = _cacheProveedores.find(x => {
              const id = pick(x, ['ID_Proveedor', 'Id_Proveedor', 'id_proveedor', 'IdProveedor', 'ProveedorID', 'Id', 'ID'],
                  /(^id.*proveedor$)|(^id$)|(^proveedor.*id$)/i);
              return String(id) === String(idBuscado);
          });
          if (!it) return;
          $('#fldId').val(idBuscado);
          $('#fldNombre').val(pick(it, ['Nombre_Proveedor', 'Nombre']));
          $('#fldDireccion').val(pick(it, ['Direccion', 'Dirección']));
          $('#fldCiudad').val(pick(it, ['Ciudad']));
          $('#fldEstado').val(pick(it, ['State_Prov', 'Estado', 'Estado_Provincia']));
          $('#fldCP').val(pick(it, ['Codigo_Postal', 'CP', 'CodigoPostal']));
          $('#fldPais').val(pick(it, ['Pais', 'País']));
          $('#fldTel').val(pick(it, ['Telefono', 'Tel']));
      }

      function payloadFromForm() {
          return {
              ID_Proveedor: $('#fldId').val() || null,
              Nombre_Proveedor: $('#fldNombre').val(),
              Direccion: $('#fldDireccion').val(),
              Ciudad: $('#fldCiudad').val(),
              State_Prov: $('#fldEstado').val(),
              Codigo_Postal: $('#fldCP').val(),
              Pais: $('#fldPais').val(),
              Telefono: $('#fldTel').val()
          };
      }

      // ===== Limpieza =====
      function clearForm() {
          const $f = $('#provForm');
          if ($f.length && $f[0].reset) $f[0].reset();
          $f.find('input').each(function () { $(this).val(''); });
          $('#fldId').val('');
      }

      // ===== Validar / Guardar =====
      function validar() {
          const nombre = $('#fldNombre').val().trim();
          if (!nombre) { alert('El nombre es obligatorio.'); $('#fldNombre').focus(); return false; }
          return true;
      }

      function guardar() {
          if (!validar()) return;
          const body = payloadFromForm();

          if (currentMode === 'registrar') {
              $.ajax({
                  url: API_POST,
                  method: 'POST',
                  contentType: 'application/json; charset=utf-8',
                  data: JSON.stringify(body),
                  success: () => { alert('Proveedor registrado.'); closePane(); cargarProveedores(); },
                  error: (xhr) => { console.error('POST error', xhr?.status, xhr?.responseText); alert('Error al registrar.'); }
              });
          } else if (currentMode === 'actualizar') {
              const id = $('#fldId').val() || selectedId;
              if (!id) { alert('Selecciona un proveedor.'); return; }
              $.ajax({
                  url: API_PUT + '/' + encodeURIComponent(id), // /actualizar/{id}
                  method: 'PUT',
                  contentType: 'application/json; charset=utf-8',
                  data: JSON.stringify(body),
                  success: () => { alert('Proveedor actualizado.'); closePane(); cargarProveedores(); },
                  error: (xhr) => { console.error('PUT error', xhr?.status, xhr?.responseText); alert('Error al actualizar.'); }
              });
          }
      }

      // ===== Init =====
      $(function () {
          cargarProveedores();

          // Buscar / Limpiar (tabla)
          $('#btnBuscar').on('click', filtrar);
          $('#txtBuscar').on('keypress', e => { if (e.which === 13) filtrar(); });
          $('#btnLimpiar').on('click', function () {
              $('#txtBuscar').val('');
              pintarTabla(_cacheProveedores);
              $('#txtBuscar').focus();
          });

          // Abrir / cerrar pane
          $('#btnOpenRegistrar').on('click', () => openPane('registrar'));
          $('#btnOpenActualizar').on('click', () => openPane('actualizar'));
          $('#btnClosePane').on('click', closePane);

          // Selección de fila (para actualizar)
          $('#tbodyProveedores').on('click', 'tr', function () {
              $('#tbodyProveedores tr').removeClass('selected');
              $(this).addClass('selected');
              selectedId = $(this).data('id');
              if (currentMode === 'actualizar' && !$pane().hasClass('hidden')) {
                  fillFormFromRow(selectedId);
              }
          });

          // Guardar / Limpiar (formulario)
          $('#btnSubmit').on('click', guardar);
          $('#btnReset').on('click', function (e) {
              e.preventDefault();
              clearForm(); 
          });
      });
  </script>
</asp:Content>
