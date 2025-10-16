<%@ Page Title="Entrada de Material" Language="C#"
    MasterPageFile="~/Site.master"
    AutoEventWireup="true" CodeBehind="Entrada.aspx.cs"
    Inherits="WebInventoryControl.Entrada" %>

<asp:Content ID="HeadEntrada" ContentPlaceHolderID="HeadContent" runat="server">
  <link rel="stylesheet" href="<%= ResolveUrl("~/Content/pages/entrada.css") %>" />
  <style>
    .muted{color:#94a3b8}
    .card{margin-top:1rem;background:#fff;border:1px solid rgba(0,0,0,.06);border-radius:16px;box-shadow:0 8px 24px rgba(0,0,0,.06)}
    .card-h{display:flex;align-items:center;gap:.5rem;padding:1rem;border-bottom:1px solid rgba(0,0,0,.06)}
    .card-b{padding:1rem}
    .badge{font-size:.8rem;background:#e5f2ff;color:#0369a1;border:1px solid #bae6fd;border-radius:1rem;padding:.1rem .5rem}
    .grid{display:grid;grid-template-columns:repeat(4,minmax(0,1fr));gap:1rem}
    .field{display:flex;flex-direction:column;gap:.25rem}
    .control{padding:.5rem .6rem;border:1px solid #d1d5db;border-radius:.5rem}
    .row{display:flex;align-items:center;gap:.5rem}
    .btn{padding:.5rem .8rem;border-radius:.5rem;border:1px solid #d1d5db;background:#f8fafc;cursor:pointer}
    .btn-primary{background:#0ea5e9;border-color:#0284c7;color:white}
    .btn-outline{background:white}
    .users-table{width:100%;border-collapse:collapse;font-size:.92rem}
    .users-table th,.users-table td{border-bottom:1px solid #e5e7eb;padding:.5rem .6rem;text-align:left;white-space:nowrap}
    .table-wrap{max-height:420px;overflow:auto;border:1px solid #e5e7eb;border-radius:.5rem}
    @media (max-width: 1200px){ .grid{grid-template-columns:repeat(2,minmax(0,1fr))} }
    @media (max-width: 700px){ .grid{grid-template-columns:1fr} .users-table{font-size:.85rem} }
  </style>

  <!-- OVERRIDE verde para tabla y botones -->
  <style>
    :root{
      --accent-a:#0f5f73;
      --accent-b:#10b981;
      --thead-green-a:#0f4f63;
      --thead-green-b:#10b981;
      --row-odd:#f0fdf4;
      --row-hover:rgba(16,185,129,.15);
    }
    .badge{
      background:linear-gradient(135deg,var(--accent-a),var(--accent-b))!important;color:#fff!important;
      box-shadow:inset 0 0 0 2px rgba(255,255,255,.22)
    }
    .btn-primary{
      background:linear-gradient(135deg,var(--accent-a),var(--accent-b))!important;color:#fff!important
    }
    .btn-outline{
      background:#fff!important;border-color:var(--accent-a)!important;color:var(--accent-a)!important
    }
    .users-table thead th{
      background:linear-gradient(135deg,var(--thead-green-a),var(--thead-green-b))!important;color:#fff!important
    }
    .users-table tbody tr:nth-child(odd) td{background:var(--row-odd)!important}
    .users-table tbody tr:hover td{background:var(--row-hover)!important}
    .users-table tbody td{border-bottom:1px solid rgba(16,185,129,.25)!important}
    [data-bs-theme="dark"] .users-table thead th{background:linear-gradient(135deg,#0a4352,#0d7c62)!important}
    [data-bs-theme="dark"] .users-table tbody tr:nth-child(odd) td{background:rgba(16,185,129,.08)!important}
    [data-bs-theme="dark"] .users-table tbody tr:hover td{background:rgba(16,185,129,.22)!important}
  </style>
</asp:Content>

<asp:Content ID="MainEntrada" ContentPlaceHolderID="MainContent" runat="server">
  <div class="card">
    <div class="card-h">
      <div class="badge">IN</div>
      <h3 style="margin:0">Entrada de Material</h3>
    </div>

    <div class="card-b">
      <!-- Buscar artículo -->
      <div class="grid">
        <div class="field">
          <label for="codigoArticulo">Código de artículo</label>
          <input id="codigoArticulo" class="control" type="search" placeholder="Ej. T03" />
        </div>
        <div class="field" style="display:flex;align-items:flex-end">
          <button id="btnBuscarArticulo" class="btn btn-outline" type="button">Buscar artículo</button>
        </div>
      </div>

      <div class="grid" style="margin-top:.5rem">
        <div class="field"><label>Código</label><span id="lblCodigo" class="value muted">—</span></div>
        <div class="field"><label>Nombre / Nº Parte</label><span id="lblNombreParte" class="value muted">—</span></div>
        <div class="field" style="grid-column:1/-1"><label>Descripción</label><span id="lblDescripcion" class="value muted">—</span></div>
        <div class="field"><label>Stock actual</label><span id="lblStock" class="value muted">—</span></div>
        <div class="field"><label>Unidad</label><span id="lblUnidad" class="value muted">—</span></div>
      </div>

      <hr/>

      <!-- Buscar empleado -->
      <div class="grid">
        <div class="field">
          <label for="numReloj"># Reloj (empleado)</label>
          <input id="numReloj" class="control" type="search" placeholder="Ej. 1564" />
        </div>
        <div class="field" style="display:flex;align-items:flex-end">
          <button id="btnBuscarEmpleado" class="btn btn-outline" type="button">Buscar empleado</button>
        </div>
      </div>

      <div class="grid" style="margin-top:.5rem">
        <div class="field"><label>Nombre</label><span id="lblEmpleado" class="value muted">—</span></div>
        <div class="field"><label>Departamento</label><span id="lblDepto" class="value muted">—</span></div>
        <div class="field"><label>Puesto</label><span id="lblPuesto" class="value muted">—</span></div>
      </div>

      <hr/>

      <!-- Datos de entrada -->
      <div class="grid">
        <div class="field">
          <label>Cantidad de entrada</label>
          <input id="cantidad" class="control" type="number" min="1" />
        </div>
        <div class="field">
          <label>Fecha de entrada</label>
          <input id="fechaEntrada" class="control" type="date" />
        </div>
      </div>

      <div class="row" style="margin-top:.5rem">
        <button id="btnRegistrar" class="btn btn-primary" type="button" disabled>Registrar entrada</button>
        <span id="hint" style="margin-left:.5rem;color:#64748b"></span>
      </div>
    </div>
  </div>

  <div class="card" style="margin-top:1rem">
    <div class="card-h"><div class="badge">IN</div><h3 style="margin:0">Entradas registradas</h3></div>
    <div class="card-b">
      <div class="grid">
        <div class="field">
          <label>Código artículo</label>
          <input id="fCodigo" class="control" type="search" placeholder="Ej. T03" />
        </div>
        <div class="field">
          <label># Reloj</label>
          <input id="fReloj" class="control" type="search" placeholder="Ej. 1564" />
        </div>
        <div class="field">
          <label>Desde (fecha)</label>
          <input id="fDesde" class="control" type="date" />
        </div>
        <div class="field">
          <label>Hasta (fecha)</label>
          <input id="fHasta" class="control" type="date" />
        </div>
        <div class="field">
          <label>Mostrar últimos</label>
          <select id="fTop" class="control">
            <option value="10" selected>10</option>
            <option value="8">8</option>
            <option value="20">20</option>
            <option value="50">50</option>
          </select>
        </div>
      </div>

      <div class="row" style="gap:.5rem;flex-wrap:wrap;margin-top:.5rem">
        <button id="btnBuscarEntradas" class="btn btn-primary" type="button">Buscar</button>
        <button id="btnExportFiltro" class="btn btn-outline" type="button">Exportar filtro (.xlsx)</button>
        <button id="btnExportTodo" class="btn btn-outline" type="button">Exportar todo (.xlsx)</button>
      </div>

      <div class="table-wrap" style="margin-top:.5rem">
        <table id="tblEntradas" class="users-table">
          <thead>
            <tr>
              <th>Id</th>
              <th>Fecha</th>
              <th>Código</th>
              <th>Descripción</th>
              <th>Precio</th>
              <th>Stock</th>
              <th>Unidad</th>
              <th>Cuenta</th>
              <th># Reloj</th>
              <th>Nombre</th>
              <th>Cantidad</th>
            </tr>
          </thead>
          <tbody></tbody>
        </table>
      </div>
    </div>
  </div>

  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script>
      $(function () {
          const API = "https://localhost:7059/api/entrada";

          $("#fechaEntrada").val(new Date().toISOString().slice(0, 10));

          const canon = s => String(s).toLowerCase().replace(/[^a-z0-9]/g, '');
          function getVal(obj, names, def = "") {
              if (!obj) return def;
              const m = new Map();
              Object.keys(obj).forEach(k => m.set(canon(k), obj[k]));
              for (const n of names) {
                  const v = m.get(canon(n));
                  if (v !== undefined && v !== null) return v;
              }
              return def;
          }

          const normalizeArticulo = a => !a ? null : ({
              Codigo_Articulo: getVal(a, ["Codigo_Articulo"]),
              Numero_Parte_Articulo: getVal(a, ["Numero_Parte_Articulo"]),
              Descripcion_Articulo: getVal(a, ["Descripcion_Articulo"]),
              Stock_Actual_Articulo: getVal(a, ["Stock_Actual_Articulo"]),
              Unidad_Medida_Articulo: getVal(a, ["Unidad_Medida_Articulo"])
          });
          const normalizeEmpleado = e => !e ? null : ({
              Num_Reloj_Empleado: getVal(e, ["Num_Reloj_Empleado"]),
              Nombre_Empleado: getVal(e, ["Nombre_Empleado"]),
              Dpto_Empleado: getVal(e, ["Dpto_Empleado"]),
              Puesto_Empleado: getVal(e, ["Puesto_Empleado"])
          });

          function setArticulo(a) {
              if (!a) {
                  $("#lblCodigo,#lblNombreParte,#lblDescripcion,#lblStock,#lblUnidad").text("—").addClass("muted");
                  return;
              }
              $("#lblCodigo").text(a.Codigo_Articulo || "—");
              $("#lblNombreParte").text(a.Numero_Parte_Articulo || "—");
              $("#lblDescripcion").text(a.Descripcion_Articulo || "—");
              $("#lblStock").text(a.Stock_Actual_Articulo ?? "—");
              $("#lblUnidad").text(a.Unidad_Medida_Articulo || "—");
              $("#lblCodigo,#lblNombreParte,#lblDescripcion,#lblStock,#lblUnidad").removeClass("muted");
              updateBtn();
          }
          function setEmpleado(e) {
              if (!e) {
                  $("#lblEmpleado,#lblDepto,#lblPuesto").text("—").addClass("muted");
                  return;
              }
              $("#lblEmpleado").text(e.Nombre_Empleado || "—");
              $("#lblDepto").text(e.Dpto_Empleado || "—");
              $("#lblPuesto").text(e.Puesto_Empleado || "—");
              $("#lblEmpleado,#lblDepto,#lblPuesto").removeClass("muted");
              updateBtn();
          }
          function updateBtn() {
              const ok = $("#lblCodigo").text() !== "—"
                  && $("#lblEmpleado").text() !== "—"
                  && Number($("#cantidad").val()) > 0
                  && $("#numReloj").val().trim().length > 0;
              $("#btnRegistrar").prop("disabled", !ok);
          }
          $("#cantidad,#numReloj").on("input", updateBtn);

          // Buscar artículo
          $("#btnBuscarArticulo").on("click", function () {
              const c = $("#codigoArticulo").val().trim();
              if (!c) return alert("Ingresa un código");
              $("#hint").text("Buscando artículo…");
              $.get(API + "/lookup", { codigo: c })
                  .done(d => {
                      const art = normalizeArticulo(d.articulo || d.Articulo || d);
                      setArticulo(art);
                      $("#hint").text(art ? "" : "Artículo no encontrado");
                  })
                  .fail(() => { setArticulo(null); $("#hint").text("Artículo no encontrado"); });
          });

          // Buscar empleado
          $("#btnBuscarEmpleado").on("click", function () {
              const r = $("#numReloj").val().trim();
              if (!r) return alert("Ingresa un # de reloj");
              $("#hint").text("Buscando empleado…");
              $.get(API + "/lookup", { reloj: r })
                  .done(d => {
                      const emp = normalizeEmpleado(d.empleado || d.Empleado || d);
                      setEmpleado(emp);
                      $("#hint").text(emp ? "" : "Empleado no encontrado");
                  })
                  .fail(() => { setEmpleado(null); $("#hint").text("Empleado no encontrado"); });
          });

          // Registrar
          $("#btnRegistrar").on("click", function () {
              const datos = {
                  Codigo_Articulo: $("#lblCodigo").text(),
                  Cantidad: $("#cantidad").val(),
                  Num_Reloj_Empleado: $("#numReloj").val(),
                  Fecha_Entrada: $("#fechaEntrada").val()
              };
              $("#hint").text("Registrando…");
              $.post(API + "/registrar", datos)
                  .done(() => {
                      alert("Entrada registrada correctamente");
                      $("#hint").text("");
                      $("#cantidad").val("");
                      $("#fechaEntrada").val(new Date().toISOString().slice(0, 10));
                      updateBtn();
                      $("#btnBuscarEntradas").click();
                  })
                  .fail(e => {
                      $("#hint").text("");
                      alert("Error al registrar: " + (e.responseJSON?.message || e.statusText));
                  });
          });

          // Filtros
          function filtrosQuery(incluirTop = true) {
              const q = {
                  codigo: $("#fCodigo").val().trim() || undefined,
                  reloj: $("#fReloj").val().trim() || undefined,
                  desde: $("#fDesde").val() || undefined,
                  hasta: $("#fHasta").val() || undefined
              };
              if (incluirTop) q.top = $("#fTop").val();
              return Object.fromEntries(Object.entries(q).filter(([, v]) => v !== undefined && v !== ""));
          }

          // Tabla (JOIN Entradas + Artículos + Empleados)
          function cargarTabla(items) {
              const t = $("#tblEntradas tbody").empty();
              (items || []).forEach(x => {
                  const id = getVal(x, ["Id_Entrada", "id_entrada"]);
                  const fecha = getVal(x, ["Fecha_Entrada", "fecha_entrada"]);
                  const codigo = getVal(x, ["Codigo_Articulo"]);
                  const desc = getVal(x, ["Descripcion_Articulo"]);
                  const precio = getVal(x, ["Precio_Articulo"]);
                  const stock = getVal(x, ["Stock_Actual_Articulo"]);
                  const unidad = getVal(x, ["Unidad_Medida_Articulo"]);
                  const cuenta = getVal(x, ["Numero_Cuenta", "Numero_Cuenta_Articulo", "numero_cuenta"]);
                  const reloj = getVal(x, ["Num_Reloj_Empleado"]);
                  const nombre = getVal(x, ["Nombre_Empleado"]);
                  const cant = getVal(x, ["Cantidad"]);
                  t.append(`<tr>
            <td>${id}</td>
            <td>${fecha}</td>
            <td>${codigo}</td>
            <td>${desc}</td>
            <td>${precio}</td>
            <td>${stock}</td>
            <td>${unidad}</td>
            <td>${cuenta}</td>
            <td>${reloj}</td>
            <td>${nombre}</td>
            <td>${cant}</td>
          </tr>`);
              });
          }

          // Buscar (tabla)
          $("#btnBuscarEntradas").on("click", function () {
              $.get(API + "/movimientos", filtrosQuery(true))
                  .done(d => cargarTabla(d.items || []))
                  .fail(() => alert("Error al cargar movimientos"));
          });

          // Exportar filtro (respeta TOP)
          $("#btnExportFiltro").on("click", function () {
              const p = new URLSearchParams(filtrosQuery(true));
              window.location = API + "/movimientos/excel?" + p.toString();
          });

          // Exportar todo (sin filtros)
          $("#btnExportTodo").on("click", function () {
              window.location = API + "/movimientos/excel";
          });

          // Carga inicial
          $("#btnBuscarEntradas").click();
      });
  </script>
</asp:Content>
