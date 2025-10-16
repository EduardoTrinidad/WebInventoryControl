<%@ Page Title="Artículos" Language="C#"
    MasterPageFile="~/Site.master"
    AutoEventWireup="true"
    CodeBehind="Articulos.aspx.cs"
    Inherits="WebInventoryControl.Articulos" %>

<asp:Content ID="HeadArticulos" ContentPlaceHolderID="HeadContent" runat="server">
  <link rel="stylesheet" href="<%= ResolveUrl("~/Content/pages/articulo.css") %>" />
  <noscript>
    <style>
      .users-table { border-collapse: collapse; width:100%; }
      .users-table th, .users-table td { border:1px solid #ddd; padding:.6rem .8rem; }
      .users-table thead th { background:#2A7B9B; color:#fff; }
    </style>
  </noscript>
</asp:Content>

<asp:Content ID="MainArticulos" ContentPlaceHolderID="MainContent" runat="server">

  <!-- ===== CARD: Salida de artículo ===== -->
  <div class="card">
    <div class="card-h">
      <div class="badge">JPH</div>
      <h3 style="margin:0">Salida de artículo</h3>
    </div>

    <div class="card-b">
      <!-- Buscar Artículo -->
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

      <hr />

      <!-- Buscar Responsable SOLO por # RELOJ -->
      <div class="grid">
        <div class="field">
          <label for="responsableBuscar"># Reloj (Empleado)</label>
          <input id="responsableBuscar" class="control" type="search" list="dlResponsables" placeholder="Escribe # reloj y selecciona" />
          <datalist id="dlResponsables"></datalist>
          <input id="relojEmpleado" type="hidden" />
        </div>
        <div class="field" style="display:flex;align-items:flex-end">
          <button id="btnBuscarEmpleado" class="btn btn-outline" type="button">Buscar empleado</button>
        </div>
      </div>

      <div class="grid" style="margin-top:.25rem">
        <div class="field"><label>Nombre</label><span id="lblEmpleado" class="value muted">—</span></div>
        <div class="field"><label>Departamento</label><span id="lblDepto" class="value muted">—</span></div>
        <div class="field"><label>Puesto</label><span id="lblPuesto" class="value muted">—</span></div>
      </div>

      <hr />

      <!-- Datos de salida -->
      <div class="grid">
        <div class="field"><label for="cantSalida">Cantidad a salir</label><input id="cantSalida" class="control" type="number" min="1" placeholder="Ej. 10" /></div>
        <div class="field"><label for="fechaSalida">Fecha de salida</label><input id="fechaSalida" class="control" type="date" /></div>
        <div class="field"><label for="equipo">Equipo (opcional)</label><input id="equipo" class="control" type="text" placeholder="Ej. Taladro..." /></div>
        <div class="field"><label for="responsable">Responsable (opcional)</label><input id="responsable" class="control" type="text" placeholder="Nombre de quien entrega" /></div>
      </div>

      <div class="row" style="margin-top:.5rem">
        <button id="btnRegistrar" class="btn btn-primary" type="button" disabled>Registrar salida</button>
        <span id="hint" class="muted"></span>
      </div>
    </div>
  </div>

  <!-- ===== CARD: Movimientos DETALLE (JOIN) ===== -->
  <div class="card" style="margin-top:16px">
    <div class="card-h">
      <div class="badge">JPH</div>
      <h3 style="margin:0">Movimientos (detalle)</h3>
    </div>

    <div class="card-b">
      <div class="grid">
        <div class="field"><label for="fCodigo">Código de artículo (opcional)</label><input id="fCodigo" class="control" type="search" placeholder="Ej. T03" /></div>
        <div class="field"><label for="fResponsable">Responsable (opcional)</label><input id="fResponsable" class="control" type="search" placeholder="Nombre del responsable" /></div>
        <div class="field"><label for="fDel">Fecha inicial</label><input id="fDel" class="control" type="date" /></div>
        <div class="field"><label for="fAl">Fecha final</label><input id="fAl" class="control" type="date" /></div>
      </div>

      <div class="row" style="gap:8px;margin:12px 0">
        <button id="btnFiltrar" class="btn btn-primary" type="button">Buscar</button>
        <button id="btnLimpiar" class="btn btn-secondary" type="button">Limpiar</button>
        <button id="btnExcel" class="btn btn-secondary" type="button" title="Descargar Excel">Descargar Excel</button>
        <span id="movHint" class="pill">Mostrando últimos 10</span>
      </div>

      <div class="table-wrap">
        <div class="table-scroll">
          <table class="users-table" id="tblMovs">
            <thead>
              <tr>
                <th>Fecha</th>
                <th>Id</th>
                <th>Código</th>
                <th>Descripción</th>
                <th>Categoría</th>
                <th>Precio</th>
                <th>Cantidad</th>
                <th>Unidad</th>
                <th># Reloj</th>
                <th>Depto</th>
                <th>Turno</th>
                <th>Equipo</th>
                <th>Responsable</th>
              </tr>
            </thead>
            <tbody></tbody>
          </table>
        </div>
      </div>
    </div>
  </div>

  <!-- Scripts -->
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script>
      (() => {
          'use strict';
          const API = "https://localhost:7059";

          // Refs
          const $codigo = document.getElementById('codigoArticulo');
          const $cant = document.getElementById('cantSalida');
          const $fecha = document.getElementById('fechaSalida');
          const $equipo = document.getElementById('equipo');
          const $respTxt = document.getElementById('responsable');

          const $lblCodigo = document.getElementById('lblCodigo');
          const $lblNombreParte = document.getElementById('lblNombreParte');
          const $lblDescripcion = document.getElementById('lblDescripcion');
          const $lblStock = document.getElementById('lblStock');
          const $lblUnidad = document.getElementById('lblUnidad');

          const $lblEmpleado = document.getElementById('lblEmpleado');
          const $lblDepto = document.getElementById('lblDepto');
          const $lblPuesto = document.getElementById('lblPuesto');

          const $btnBA = document.getElementById('btnBuscarArticulo');
          const $btnBE = document.getElementById('btnBuscarEmpleado');
          const $btnReg = document.getElementById('btnRegistrar');
          const $hint = document.getElementById('hint');

          const $fCodigo = document.getElementById('fCodigo');
          const $fResp = document.getElementById('fResponsable');
          const $fDel = document.getElementById('fDel');
          const $fAl = document.getElementById('fAl');

          const $btnFiltrar = document.getElementById('btnFiltrar');
          const $btnLimpiar = document.getElementById('btnLimpiar');
          const $btnExcel = document.getElementById('btnExcel');

          const $tbl = document.getElementById('tblMovs');
          const $tbody = $tbl ? $tbl.querySelector('tbody') : null;
          const $movHint = document.getElementById('movHint');

          const $inputResp = document.getElementById('responsableBuscar');
          const $dlResp = document.getElementById('dlResponsables');
          const $relojHidden = document.getElementById('relojEmpleado');

          // Defaults
          if ($fecha) $fecha.value = new Date().toISOString().slice(0, 10);

          // Helpers
          const canon = s => String(s).toLowerCase().replace(/[^a-z0-9]/g, '');
          const pick = (obj, keys) => {
              if (!obj) return null;
              const map = new Map(Object.keys(obj).map(k => [canon(k), obj[k]]));
              for (const k of keys) {
                  const v = map.get(canon(k));
                  if (v !== undefined && v !== null && v !== "") return v;
              }
              return null;
          };
          const pad = n => String(n).padStart(2, '0');
          const fmtFecha = iso => {
              if (!iso) return "—";
              const d = new Date(iso);
              if (isNaN(d.getTime())) return iso;
              return `${d.getFullYear()}-${pad(d.getMonth() + 1)}-${pad(d.getDate())} ${pad(d.getHours())}:${pad(d.getMinutes())}`;
          };

          function normalizeArticulo(a) {
              if (!a) return null;
              return {
                  Codigo_Articulo: pick(a, ["Codigo_Articulo"]),
                  Numero_Parte_Articulo: pick(a, ["Numero_Parte_Articulo"]),
                  Descripcion_Articulo: pick(a, ["Descripcion_Articulo"]),
                  Stock_Actual_Articulo: pick(a, ["Stock_Actual_Articulo"]),
                  Unidad_Medida_Articulo: pick(a, ["Unidad_Medida_Articulo"])
              };
          }

          function setArticulo(a) {
              if (a) {
                  $lblCodigo.textContent = a.Codigo_Articulo ?? "—";
                  $lblNombreParte.textContent = a.Numero_Parte_Articulo ?? "—";
                  $lblDescripcion.textContent = a.Descripcion_Articulo ?? "—";
                  $lblStock.textContent = a.Stock_Actual_Articulo ?? "—";
                  $lblUnidad.textContent = a.Unidad_Medida_Articulo ?? "—";
                  [$lblCodigo, $lblNombreParte, $lblDescripcion, $lblStock, $lblUnidad].forEach(e => e.classList.remove('muted'));
              } else {
                  [$lblCodigo, $lblNombreParte, $lblDescripcion, $lblStock, $lblUnidad].forEach(e => { e.textContent = "—"; e.classList.add('muted') });
              }
              updateRegistrarEnabled();
          }

          function setEmpleadoFromSelection(nombre, depto, puesto, reloj) {
              $lblEmpleado.textContent = nombre || "—";
              $lblDepto.textContent = depto || "—";
              $lblPuesto.textContent = puesto || "—";
              [$lblEmpleado, $lblDepto, $lblPuesto].forEach(e => e.classList.remove('muted'));
              $relojHidden.value = reloj || "";
              updateRegistrarEnabled();
          }
          function clearEmpleado() {
              [$lblEmpleado, $lblDepto, $lblPuesto].forEach(e => { e.textContent = "—"; e.classList.add('muted') });
              $relojHidden.value = "";
              updateRegistrarEnabled();
          }
          function updateRegistrarEnabled() {
              const ok = ($lblCodigo.textContent && $lblCodigo.textContent !== "—")
                  && ($lblEmpleado.textContent && $lblEmpleado.textContent !== "—")
                  && (Number($cant.value) > 0)
                  && ($relojHidden.value && $relojHidden.value.trim() !== "");
              $btnReg.disabled = !ok;
          }

          if ($cant) $cant.addEventListener('input', updateRegistrarEnabled);

          // Buscar Artículo
          if ($btnBA) {
              $btnBA.addEventListener('click', async () => {
                  const codigo = $codigo.value.trim();
                  if (!codigo) { alert("Ingresa un código de artículo."); return; }
                  if ($hint) $hint.textContent = "Buscando artículo…";
                  try {
                      const res = await fetch(`${API}/api/salida/lookup?codigo=${encodeURIComponent(codigo)}`);
                      const json = await res.json().catch(() => ({}));
                      const raw = json.articulo ?? json.Articulo ?? json;
                      const art = normalizeArticulo(raw);
                      if (art && (art.Codigo_Articulo || art.Numero_Parte_Articulo)) {
                          setArticulo(art);
                          if ($hint) $hint.textContent = "";
                      } else {
                          setArticulo(null);
                          if ($hint) $hint.textContent = "Artículo no encontrado";
                      }
                  } catch (e) {
                      console.error(e);
                      if ($hint) $hint.textContent = "Error de red";
                  }
              });
          }
          if ($codigo) {
              $codigo.addEventListener('keydown', e => {
                  if (e.key === "Enter") { e.preventDefault(); $btnBA?.click(); }
              });
          }

          // Buscar empleado
          if ($btnBE) {
              $btnBE.addEventListener('click', async () => {
                  const term = document.getElementById('responsableBuscar').value.trim();
                  if (!/^\d{2,}$/.test(term)) { alert("Escribe un # de reloj válido."); return; }

                  const match = [...document.getElementById('dlResponsables').querySelectorAll('option')].find(o => o.value === term);
                  if (match) {
                      setEmpleadoFromSelection(match.getAttribute('data-nombre') || "", match.getAttribute('data-depto') || "", match.getAttribute('data-puesto') || "", term);
                      return;
                  }
                  try {
                      const res = await fetch(`${API}/api/salida/lookup?reloj=${encodeURIComponent(term)}`);
                      const j = await res.json().catch(() => ({}));
                      const emp = j.empleado ?? j.Empleado ?? j;
                      const nombre = pick(emp, ["Nombre_Empleado", "Nombre"]) || "";
                      const depto = pick(emp, ["Dpto_Empleado", "Departamento"]) || "";
                      const puesto = pick(emp, ["Puesto_Empleado", "Puesto"]) || "";
                      const reloj = pick(emp, ["Num_Reloj_Empleado", "Reloj"]) || "";
                      if (reloj) {
                          setEmpleadoFromSelection(nombre, depto, puesto, reloj);
                          document.getElementById('responsableBuscar').value = reloj;
                          return;
                      }
                  } catch (e) { console.error(e); }

                  // fallback sugerencias
                  try {
                      const res = await fetch(`${API}/api/salida/responsables?term=${encodeURIComponent(term)}`);
                      const data = await res.json().catch(() => ([]));
                      const items = Array.isArray(data) ? data : (data.items ?? []);
                      const $dl = document.getElementById('dlResponsables');
                      $dl.innerHTML = "";
                      for (const it of items) {
                          const nombre = pick(it, ["Nombre_Empleado", "Nombre"]) || "";
                          const depto = pick(it, ["Dpto_Empleado", "Departamento"]) || "";
                          const puesto = pick(it, ["Puesto_Empleado", "Puesto"]) || "";
                          const reloj = pick(it, ["Num_Reloj_Empleado", "Reloj"]) || "";
                          const opt = document.createElement('option');
                          opt.value = reloj;
                          opt.setAttribute('data-nombre', nombre);
                          opt.setAttribute('data-depto', depto);
                          opt.setAttribute('data-puesto', puesto);
                          $dl.appendChild(opt);
                      }
                      if (items.length === 1) {
                          const it = items[0];
                          setEmpleadoFromSelection(
                              pick(it, ["Nombre_Empleado", "Nombre"]) || "",
                              pick(it, ["Dpto_Empleado", "Departamento"]) || "",
                              pick(it, ["Puesto_Empleado", "Puesto"]) || "",
                              pick(it, ["Num_Reloj_Empleado", "Reloj"]) || ""
                          );
                          document.getElementById('responsableBuscar').value = pick(it, ["Num_Reloj_Empleado", "Reloj"]) || "";
                      } else if (!items.length) {
                          alert("Empleado no encontrado.");
                          clearEmpleado();
                      } else {
                          alert("Hay varias coincidencias, selecciona una de la lista.");
                      }
                  } catch (e) { console.error(e); }
              });
          }

          // Registrar salida
          if ($btnReg) {
              $btnReg.addEventListener('click', async () => {
                  const codigo = $lblCodigo.textContent.trim();
                  const reloj = $relojHidden.value.trim();
                  const cant = Number($cant.value);
                  const fecha = $fecha.value;
                  const equipo = $equipo.value.trim();
                  const responsable = $respTxt.value.trim();

                  if (!codigo || codigo === "—") { alert("Primero busca un artículo."); return; }
                  if (!reloj) { alert("Selecciona un responsable válido (# reloj)."); return; }
                  if (!(cant > 0)) { alert("Cantidad inválida."); return; }

                  try {
                      $btnReg.disabled = true;
                      if ($hint) $hint.textContent = "Registrando salida…";

                      const res = await fetch(`${API}/api/salida/registrar`, {
                          method: 'POST',
                          headers: { 'Content-Type': 'application/json' },
                          body: JSON.stringify({
                              Codigo_Articulo: codigo,
                              Cantidad: cant,
                              Num_Reloj_Empleado: reloj,
                              Equipo: equipo || null,
                              Responsable: responsable || null,
                              Fecha_Salida: fecha || null
                          })
                      });

                      const payload = await res.json().catch(() => ({}));
                      if (!res.ok) {
                          alert(payload?.message || "Error al registrar");
                          if ($hint) $hint.textContent = "";
                          updateRegistrarEnabled();
                          return;
                      }

                      if (payload?.stockNuevo !== undefined) $lblStock.textContent = payload.stockNuevo;
                      alert("Salida registrada correctamente.");
                      if ($hint) $hint.textContent = "";
                      $cant.value = "";
                      $equipo.value = "";
                      updateRegistrarEnabled();
                      cargarMovimientos();
                  } catch (e) {
                      console.error(e);
                      alert("Error de red");
                      if ($hint) $hint.textContent = "";
                      updateRegistrarEnabled();
                  }
              });
          }

          // ===== Movimientos detalle (JOIN) =====
          function buildQueryDetalle() {
              const qs = new URLSearchParams();
              const hasRange = Boolean($fDel?.value) || Boolean($fAl?.value);
              if ($fCodigo?.value.trim()) qs.set('codigo', $fCodigo.value.trim());
              if ($fResp?.value.trim()) qs.set('responsable', $fResp.value.trim());
              if ($fDel?.value) qs.set('fechaInicio', $fDel.value);
              if ($fAl?.value) qs.set('fechaFin', $fAl.value);
              if (!hasRange) qs.set('top', '10');
              return qs.toString();
          }

          function renderRowsDetalle(items) {
              if (!$tbody) return;
              $tbody.innerHTML = "";
              if (!items?.length) {
                  const tr = document.createElement('tr');
                  const td = document.createElement('td');
                  td.colSpan = 13; td.textContent = "Sin resultados.";
                  tr.appendChild(td); $tbody.appendChild(tr);
                  return;
              }
              for (const it of items) {
                  const tr = document.createElement('tr');
                  tr.innerHTML = `
          <td>${fmtFecha(it.Fecha_Salida)}</td>
          <td>${it.Id_Salida ?? "—"}</td>
          <td>${it.Codigo_Articulo ?? "—"}</td>
          <td>${it.Descripcion_Articulo ?? "—"}</td>
          <td>${it.Categoria_Articulo ?? "—"}</td>
          <td>${(it.Precio_Articulo ?? "") === "" ? "—" : Number(it.Precio_Articulo).toFixed(2)}</td>
          <td>${it.Cantidad ?? 0}</td>
          <td>${it.Unidad_Medida_Articulo ?? "—"}</td>
          <td>${it.Num_Reloj_Empleado ?? "—"}</td>
          <td>${it.Dpto_Empleado ?? "—"}</td>
          <td>${it.Turno_Empleado ?? "—"}</td>
          <td>${it.Equipo ?? "—"}</td>
          <td>${it.Responsable ?? "—"}</td>
        `;
                  $tbody.appendChild(tr);
              }
          }

          async function cargarMovimientos() {
              try {
                  if ($movHint) $movHint.textContent = "Cargando…";
                  const qs = buildQueryDetalle();
                  const res = await fetch(`${API}/api/salida/movimientos/detalle${qs ? ('?' + qs) : ''}`);
                  const data = await res.json().catch(() => []);
                  const items = Array.isArray(data) ? data : (data.items ?? data.result ?? []);
                  renderRowsDetalle(items);
                  const hasRange = Boolean($fDel?.value) || Boolean($fAl?.value);
                  if ($movHint) $movHint.textContent = hasRange ? "Rango aplicado" : "Mostrando últimos 10";
              } catch (e) {
                  console.error(e);
                  renderRowsDetalle([]);
                  if ($movHint) $movHint.textContent = "Error al cargar";
              }
          }

          async function descargarExcel() {
              try {
                  const qs = buildQueryDetalle();
                  const res = await fetch(`${API}/api/salida/movimientos/detalle/excel${qs ? ('?' + qs) : ''}`);
                  if (!res.ok) throw new Error();
                  const blob = await res.blob();
                  const a = document.createElement('a');
                  const href = URL.createObjectURL(blob);
                  a.href = href;
                  const tagDel = $fDel?.value || "";
                  const tagAl = $fAl?.value || "";
                  const tag = tagDel + (tagDel && tagAl ? '_' : '') + tagAl;
                  a.download = `movimientos_detalle_${tag || new Date().toISOString().slice(0, 10)}.csv`;
                  document.body.appendChild(a); a.click(); a.remove(); URL.revokeObjectURL(href);
              } catch {
                  alert("No se pudo descargar el Excel (CSV).");
              }
          }

          if ($btnFiltrar) $btnFiltrar.addEventListener('click', cargarMovimientos);
          if ($btnLimpiar) $btnLimpiar.addEventListener('click', () => {
              if ($fCodigo) $fCodigo.value = "";
              if ($fResp) $fResp.value = "";
              if ($fDel) $fDel.value = "";
              if ($fAl) $fAl.value = "";
              cargarMovimientos();
          });
          if ($btnExcel) $btnExcel.addEventListener('click', descargarExcel);
          [$fCodigo, $fResp, $fDel, $fAl].forEach(inp => {
              inp?.addEventListener('keydown', (e) => { if (e.key === "Enter") { e.preventDefault(); cargarMovimientos(); } });
          });

          // Inicial
          cargarMovimientos();
          window.cargarMovimientos = cargarMovimientos;
      })();
  </script>

</asp:Content>
