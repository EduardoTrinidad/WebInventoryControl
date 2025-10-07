<%@ Page Title="Entrada de Material" Language="C#" MasterPageFile="~/Site.master"
    AutoEventWireup="true" CodeBehind="Entrada.aspx.cs"
    Inherits="WebInventoryControl.Entrada" %>

<asp:Content ID="HeadEntrada" ContentPlaceHolderID="HeadContent" runat="server">
  <link rel="stylesheet" href="<%= ResolveUrl("~/Content/pages/entrada.css") %>" />
</asp:Content>

<asp:Content ID="MainEntrada" ContentPlaceHolderID="MainContent" runat="server">
  <div class="card">
    <div class="card-h">
      <div class="badge">IN</div>
      <h3>Entrada de Material</h3>
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

      <div class="grid">
        <div class="field"><label>Código</label><span id="lblCodigo" class="value muted">—</span></div>
        <div class="field"><label>Nombre / Nº Parte</label><span id="lblNombreParte" class="value muted">—</span></div>
        <div class="field" style="grid-column:1/-1"><label>Descripción</label><span id="lblDescripcion" class="value muted">—</span></div>
        <div class="field"><label>Stock actual</label><span id="lblStock" class="value muted">—</span></div>
        <div class="field"><label>Unidad</label><span id="lblUnidad" class="value muted">—</span></div>
      </div>

      <hr />

      <!-- Buscar empleado por # reloj -->
      <div class="grid">
        <div class="field">
          <label for="numReloj"># Reloj (empleado)</label>
          <input id="numReloj" class="control" type="search" placeholder="Ej. 1564" />
        </div>
        <div class="field" style="display:flex;align-items:flex-end">
          <button id="btnBuscarEmpleado" class="btn btn-outline" type="button">Buscar empleado</button>
        </div>
      </div>

      <div class="grid">
        <div class="field"><label>Nombre</label><span id="lblEmpleado" class="value muted">—</span></div>
        <div class="field"><label>Departamento</label><span id="lblDepto" class="value muted">—</span></div>
        <div class="field"><label>Puesto</label><span id="lblPuesto" class="value muted">—</span></div>
      </div>

      <hr />

      <!-- Datos de entrada -->
      <div class="grid">
        <div class="field"><label>Cantidad de entrada</label><input id="cantidad" class="control" type="number" min="1" /></div>
        <div class="field"><label>Fecha de entrada</label><input id="fechaEntrada" class="control" type="date" /></div>
      </div>

      <div class="row">
        <button id="btnRegistrar" class="btn btn-primary" type="button" disabled>Registrar entrada</button>
        <span id="hint" style="margin-left:.5rem;color:#64748b"></span>
      </div>
    </div>
  </div>

  <div class="card" style="margin-top:1rem">
    <div class="card-h"><div class="badge">IN</div><h3>Entradas registradas</h3></div>
    <div class="card-b">
      <div class="grid">
        <div class="field"><label>Código artículo</label><input id="fCodigo" class="control" type="search" /></div>
        <div class="field"><label># Reloj</label><input id="fReloj" class="control" type="search" /></div>
      </div>
      <div class="row">
        <button id="btnBuscarEntradas" class="btn btn-primary" type="button">Buscar</button>
      </div>

      <div class="table-wrap">
        <table id="tblEntradas" class="users-table">
          <thead><tr><th>Fecha</th><th>Código</th><th># Reloj</th><th>Cantidad</th></tr></thead>
          <tbody></tbody>
        </table>
      </div>
    </div>
  </div>

  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script>
      $(function () {
          const API = "https://localhost:7059/api/entrada";

          // ===== Fecha por defecto = hoy (editable) =====
          (function setHoy() {
              const d = new Date();
              const iso = new Date(d.getTime() - d.getTimezoneOffset() * 60000).toISOString().slice(0, 10);
              $("#fechaEntrada").val(iso);
          })();

          // --- helpers tolerantes (camel/Pascal/guion_bajo) ---
          const canon = s => String(s).toLowerCase().replace(/[^a-z0-9]/g, '');
          const pick = (obj, names) => {
              if (!obj) return null;
              const map = new Map();
              Object.keys(obj).forEach(k => map.set(canon(k), obj[k]));
              for (const n of names) {
                  const v = map.get(canon(n));
                  if (v !== undefined && v !== null) return v;
              }
              return null;
          };
          const normalizeArticulo = a => !a ? null : ({
              Codigo_Articulo: pick(a, ["Codigo_Articulo"]),
              Numero_Parte_Articulo: pick(a, ["Numero_Parte_Articulo"]),
              Descripcion_Articulo: pick(a, ["Descripcion_Articulo"]),
              Stock_Actual_Articulo: pick(a, ["Stock_Actual_Articulo"]),
              Unidad_Medida_Articulo: pick(a, ["Unidad_Medida_Articulo"])
          });
          const normalizeEmpleado = e => !e ? null : ({
              Num_Reloj_Empleado: pick(e, ["Num_Reloj_Empleado"]),
              Nombre_Empleado: pick(e, ["Nombre_Empleado"]),
              Dpto_Empleado: pick(e, ["Dpto_Empleado"]),
              Puesto_Empleado: pick(e, ["Puesto_Empleado"])
          });

          function setArticulo(a) {
              if (!a) { $("#lblCodigo,#lblNombreParte,#lblDescripcion,#lblStock,#lblUnidad").text("—").addClass("muted"); return; }
              $("#lblCodigo").text(a.Codigo_Articulo || "—");
              $("#lblNombreParte").text(a.Numero_Parte_Articulo || "—");
              $("#lblDescripcion").text(a.Descripcion_Articulo || "—");
              $("#lblStock").text(a.Stock_Actual_Articulo ?? "—");
              $("#lblUnidad").text(a.Unidad_Medida_Articulo || "—");
              $("#lblCodigo,#lblNombreParte,#lblDescripcion,#lblStock,#lblUnidad").removeClass("muted");
              updateBtn();
          }
          function setEmpleado(e) {
              if (!e) { $("#lblEmpleado,#lblDepto,#lblPuesto").text("—").addClass("muted"); return; }
              $("#lblEmpleado").text(e.Nombre_Empleado || "—");
              $("#lblDepto").text(e.Dpto_Empleado || "—");
              $("#lblPuesto").text(e.Puesto_Empleado || "—");
              $("#lblEmpleado,#lblDepto,#lblPuesto").removeClass("muted");
              updateBtn();
          }

          function updateBtn() {
              const ok = $("#lblCodigo").text() !== "—" &&
                  $("#lblEmpleado").text() !== "—" &&
                  Number($("#cantidad").val()) > 0 &&
                  $("#numReloj").val().trim().length > 0;
              $("#btnRegistrar").prop("disabled", !ok);
          }
          $("#cantidad,#numReloj").on("input", updateBtn);

          // === Buscar artículo ===
          $("#btnBuscarArticulo").click(function () {
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

          // === Buscar empleado ===
          $("#btnBuscarEmpleado").click(function () {
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

          // === Registrar ===
          $("#btnRegistrar").click(function () {
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
                      cargarMovimientos(true); // recarga últimos 10
                  })
                  .fail(e => {
                      $("#hint").text("");
                      alert("Error al registrar: " + (e.responseJSON?.message || e.statusText));
                  });
          });

          // === Movimientos (top 10 por defecto) ===
          function cargarMovimientos(top10PorDefecto) {
              const codigo = $("#fCodigo").val().trim();
              const reloj = $("#fReloj").val().trim();

              const params = {};
              if (codigo) params.codigo = codigo;
              if (reloj) params.reloj = reloj;
              if (!codigo && !reloj) params.top = top10PorDefecto ? 10 : 10;

              $.get(API + "/movimientos", params)
                  .done(d => {
                      const t = $("#tblEntradas tbody").empty();

                      // acepta {items:[...]} o directamente [...]
                      const items = Array.isArray(d) ? d : (d.items || d.result || []);

                      if (!items.length) {
                          t.append(`<tr><td colspan="4">Sin resultados</td></tr>`);
                          return;
                      }

                      for (const it of items) {
                          const fecha = pick(it, ["Fecha_Entrada", "FechaEntrada", "Fecha"]) || "—";
                          const codigo = pick(it, ["Codigo_Articulo", "Codigo"]) || "—";
                          const reloj = pick(it, ["Num_Reloj_Empleado", "Numero_Reloj", "Reloj"]) || "—";
                          const cant = pick(it, ["Cantidad"]) ?? "0";

                          t.append(`<tr>
          <td>${fecha}</td>
          <td>${codigo}</td>
          <td>${reloj}</td>
          <td>${cant}</td>
        </tr>`);
                      }
                  })
                  .fail(() => alert("Error al cargar movimientos"));
          }

          $("#btnBuscarEntradas").click(function () {
              cargarMovimientos(false);
          });

          // Al abrir la página: últimos 10
          cargarMovimientos(true);

      });
  </script>
</asp:Content>
