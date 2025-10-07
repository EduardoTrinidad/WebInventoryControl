<%@ Page Title="Artículos" Language="C#"
    MasterPageFile="~/Site.master"
    AutoEventWireup="true"
    CodeBehind="Articulos.aspx.cs"
    Inherits="WebInventoryControl.Articulos" %>

<asp:Content ID="HeadArticulos" ContentPlaceHolderID="HeadContent" runat="server">
  <link rel="stylesheet" href="<%= ResolveUrl("~/Content/pages/articulo.css") %>" />
  <style>
    .card{margin-top:1rem;background:#fff;border:1px solid rgba(0,0,0,.08);border-radius:16px;box-shadow:0 10px 24px rgba(0,0,0,.06)}
    .card-h{display:flex;gap:.8rem;align-items:center;padding:1rem 1.25rem;border-bottom:1px solid rgba(0,0,0,.06)}
    .badge{background:#0ea5e9;color:#fff;font-weight:700;padding:.25rem .6rem;border-radius:999px;letter-spacing:.5px}
    .card-b{padding:1rem 1.25rem}
    .grid{display:grid;grid-template-columns:repeat(2,minmax(0,1fr));gap:12px}
    @media (max-width:900px){.grid{grid-template-columns:1fr}}
    .field label{display:block;font-size:.9rem;margin-bottom:.25rem;color:#0f172a}
    .control{width:100%;padding:.6rem .7rem;border-radius:10px;border:1px solid rgba(0,0,0,.12);background:#f8fafc}
    .value{display:block;width:100%;padding:.6rem .7rem;border-radius:10px;border:1px dashed rgba(0,0,0,.12);background:#fafafa;font-weight:600;color:#0f172a;min-height:42px}
    .muted{color:#94a3b8;font-weight:500}
    .row{display:flex;gap:10px;align-items:center;flex-wrap:wrap}
    .btn{border:0;border-radius:12px;padding:.65rem 1rem;cursor:pointer}
    .btn-primary{background:#0f3f66;color:#fff}
    .btn-secondary{color:#0f172a;background:#fff;border:1px solid rgba(0,0,0,.18)}
    .btn-outline{background:#fff;border:1px solid #0f3f66;color:#0f3f66}
    .btn:disabled{opacity:.5;cursor:not-allowed}
    #hint,#movHint{color:#64748b}
    .table-wrap{background:#fff;border-top:1px solid var(--card-border, rgba(15,23,42,.10))}
    .table-scroll{overflow:auto;max-height:360px}
    .users-table{width:100%;border-collapse:separate;border-spacing:0}
    .users-table thead th{position:sticky;top:0;z-index:2;background:var(--accent-a,#2A7B9B);color:#fff;text-align:left;padding:.65rem .8rem}
    .users-table tbody td{padding:.6rem .8rem;border-bottom:1px solid var(--card-border, rgba(15,23,42,.10))}
  </style>
</asp:Content>

<asp:Content ID="MainArticulos" ContentPlaceHolderID="MainContent" runat="server">

  <!-- ===== CARD: Salida de artículo ===== -->
  <div class="card">
    <div class="card-h">
      <div class="badge">JPH</div>
      <div>
        <h3 style="margin:0">Salida de artículo</h3>
      </div>
    </div>

    <div class="card-b">
      <!-- Buscar Artículo -->
      <div class="grid" style="grid-column:1/-1;margin-bottom:.25rem">
        <div class="field">
          <label for="codigoArticulo">Código de artículo</label>
          <input id="codigoArticulo" class="control" type="search" placeholder="Ej. T03" />
        </div>
        <div class="field" style="display:flex;align-items:flex-end">
          <button id="btnBuscarArticulo" class="btn btn-outline" type="button">Buscar artículo</button>
        </div>
      </div>

      <div class="grid" style="grid-column:1/-1;margin-bottom:.5rem">
        <div class="field">
          <label>Código</label>
          <span id="lblCodigo" class="value muted">—</span>
        </div>
        <div class="field">
          <label>Nombre / Nº Parte</label>
          <span id="lblNombreParte" class="value muted">—</span>
        </div>
        <div class="field" style="grid-column:1/-1;">
          <label>Descripción</label>
          <span id="lblDescripcion" class="value muted">—</span>
        </div>
        <div class="field">
          <label>Stock actual</label>
          <span id="lblStock" class="value muted">—</span>
        </div>
        <div class="field">
          <label>Unidad</label>
          <span id="lblUnidad" class="value muted">—</span>
        </div>
      </div>

      <hr />

      <!-- Buscar Responsable SOLO por # RELOJ -->
      <div class="grid" style="grid-column:1/-1;margin-bottom:.25rem">
        <div class="field">
          <label for="responsableBuscar"># Reloj (Empleado)</label>
          <input id="responsableBuscar"
                 class="control"
                 type="search"
                 list="dlResponsables"
                 placeholder="Escribe # reloj y selecciona" />
          <datalist id="dlResponsables"></datalist>
          <input id="relojEmpleado" type="hidden" />
        </div>
        <div class="field" style="display:flex;align-items:flex-end">
          <button id="btnBuscarEmpleado" class="btn btn-outline" type="button">Buscar empleado</button>
        </div>
      </div>

      <div class="grid" style="grid-column:1/-1;">
        <div class="field">
          <label>Nombre</label>
          <span id="lblEmpleado" class="value muted">—</span>
        </div>
        <div class="field">
          <label>Departamento</label>
          <span id="lblDepto" class="value muted">—</span>
        </div>
        <div class="field">
          <label>Puesto</label>
          <span id="lblPuesto" class="value muted">—</span>
        </div>
      </div>

      <hr />

      <!-- Datos de salida -->
      <div class="grid" style="grid-column:1/-1;">
        <div class="field">
          <label for="cantSalida">Cantidad a salir</label>
          <input id="cantSalida" class="control" type="number" min="1" placeholder="Ej. 10" />
        </div>
        <div class="field">
          <label for="fechaSalida">Fecha de salida</label>
          <input id="fechaSalida" class="control" type="date" />
        </div>
        <div class="field">
          <label for="equipo">Equipo (opcional)</label>
          <input id="equipo" class="control" type="text" placeholder="Ej. Taladro, Juego llaves..." />
        </div>
        <div class="field">
          <label for="responsable">Responsable (opcional)</label>
          <input id="responsable" class="control" type="text" placeholder="Nombre de quien entrega" />
        </div>
      </div>

      <div class="row" style="margin-top:.5rem">
        <button id="btnRegistrar" class="btn btn-primary" type="button" disabled>Registrar salida</button>
        <span id="hint"></span>
      </div>
    </div>
  </div>

  <div class="card" style="margin-top:16px">
    <div class="card-h">
      <div class="badge">JPH</div>
      <div>
        <h3 style="margin:0">Movimientos</h3>
      </div>
    </div>

    <div class="card-b">
      <div class="grid" style="grid-column:1/-1;margin-bottom:.5rem">
        <div class="field">
          <label for="fCodigo">Código de artículo (opcional)</label>
          <input id="fCodigo" class="control" type="search" placeholder="Ej. T03" />
        </div>
        <div class="field">
          <label for="fResponsable">Responsable (opcional)</label>
          <input id="fResponsable" class="control" type="search" placeholder="Nombre del responsable" />
        </div>
        <div class="field">
          <label for="fDel">Fecha inicial</label>
          <input id="fDel" class="control" type="date" />
        </div>
        <div class="field">
          <label for="fAl">Fecha final</label>
          <input id="fAl" class="control" type="date" />
        </div>
      </div>

      <div class="actions" style="justify-content:flex-start; gap:8px; margin-bottom:12px">
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
                <th>Código</th>
                <th>Responsable</th>
                <th>Cantidad</th>
                <th>Equipo</th>
                <th>Entregó</th>
              </tr>
            </thead>
            <tbody></tbody>
          </table>
        </div>
      </div>
    </div>
  </div>

  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

  <script>
      (() => {
          'use strict';

          const API = "https://localhost:7059";

          const $codigo = document.getElementById('codigoArticulo');
          const $cant = document.getElementById('cantSalida');
          const $fecha = document.getElementById('fechaSalida');
          const $equipo = document.getElementById('equipo');
          const $resp = document.getElementById('responsable');

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

          // Fecha default = hoy
          (function () {
              if ($fecha) {
                  const d = new Date();
                  $fecha.value = d.toISOString().slice(0, 10);
              }
          })();

          const canon = (s) => String(s).toLowerCase().replace(/[^a-z0-9]/g, '');
          const pick = (obj, keys) => {
              if (!obj) return null;
              const map = new Map();
              Object.keys(obj).forEach(k => map.set(canon(k), obj[k]));
              for (const wanted of keys) {
                  const v = map.get(canon(wanted));
                  if (v !== undefined && v !== null && v !== "") return v;
              }
              return null;
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
                  [$lblCodigo, $lblNombreParte, $lblDescripcion, $lblStock, $lblUnidad].forEach(el => el.classList.remove('muted'));
              } else {
                  [$lblCodigo, $lblNombreParte, $lblDescripcion, $lblStock, $lblUnidad].forEach(el => { el.textContent = "—"; el.classList.add('muted'); });
              }
              updateRegistrarEnabled();
          }

          function setEmpleadoFromSelection(nombre, depto, puesto, reloj) {
              $lblEmpleado.textContent = nombre || "—";
              $lblDepto.textContent = depto || "—";
              $lblPuesto.textContent = puesto || "—";
              [$lblEmpleado, $lblDepto, $lblPuesto].forEach(el => el.classList.remove('muted'));
              $relojHidden.value = reloj || "";
              updateRegistrarEnabled();
          }

          function clearEmpleado() {
              [$lblEmpleado, $lblDepto, $lblPuesto].forEach(el => { el.textContent = "—"; el.classList.add('muted'); });
              $relojHidden.value = "";
              updateRegistrarEnabled();
          }

          function updateRegistrarEnabled() {
              const ok =
                  ($lblCodigo.textContent && $lblCodigo.textContent !== "—") &&
                  ($lblEmpleado.textContent && $lblEmpleado.textContent !== "—") &&
                  (Number($cant.value) > 0) &&
                  ($relojHidden.value && $relojHidden.value.trim() !== "");
              $btnReg.disabled = !ok;
          }

          function fmtFecha(isoLike) {
              if (!isoLike) return "—";
              try {
                  const d = new Date(isoLike);
                  if (isNaN(d.getTime())) return isoLike;
                  const pad = n => String(n).padStart(2, '0');
                  return `${d.getFullYear()}-${pad(d.getMonth() + 1)}-${pad(d.getDate())} ${pad(d.getHours())}:${pad(d.getMinutes())}`;
              } catch { return isoLike; }
          }

          function normalizeMovimiento(m) {
              return {
                  Fecha_Salida: pick(m, ["Fecha_Salida", "Fecha"]),
                  Codigo_Articulo: pick(m, ["Codigo_Articulo", "Codigo"]),
                  Num_Reloj_Empleado: pick(m, ["Num_Reloj_Empleado", "Reloj", "Numero_Reloj"]),
                  Cantidad: Number(pick(m, ["Cantidad", "Qty", "Cantidad_Salida"]) ?? 0),
                  Equipo: pick(m, ["Equipo"]),
                  Responsable: pick(m, ["Responsable"])
              };
          }

          function renderRows(items) {
              if (!$tbody) return;
              $tbody.innerHTML = "";
              if (!items?.length) {
                  const tr = document.createElement('tr');
                  const td = document.createElement('td');
                  td.colSpan = 6;
                  td.textContent = "Sin resultados.";
                  tr.appendChild(td);
                  $tbody.appendChild(tr);
                  return;
              }
              for (const it of items) {
                  const n = normalizeMovimiento(it);
                  const tr = document.createElement('tr');
                  tr.innerHTML = `
          <td>${fmtFecha(n.Fecha_Salida)}</td>
          <td>${n.Codigo_Articulo ?? "—"}</td>
          <td>${n.Num_Reloj_Empleado ?? "—"}</td>
          <td>${n.Cantidad ?? 0}</td>
          <td>${n.Equipo ?? "—"}</td>
          <td>${n.Responsable ?? "—"}</td>
        `;
                  $tbody.appendChild(tr);
              }
          }

          function buildQuery() {
              const qs = new URLSearchParams();
              const hasRange = Boolean($fDel?.value) || Boolean($fAl?.value);
              if ($fCodigo?.value.trim()) qs.set('codigo', $fCodigo.value.trim());
              if ($fResp?.value.trim()) qs.set('responsable', $fResp.value.trim());
              if ($fDel?.value) qs.set('fechaInicio', $fDel.value);
              if ($fAl?.value) qs.set('fechaFin', $fAl.value);
              if (!hasRange) qs.set('top', '10');
              return qs.toString();
          }

          async function cargarMovimientos() {
              try {
                  if ($movHint) $movHint.textContent = "Cargando…";
                  const qs = buildQuery();
                  const url = `${API}/api/salida/movimientos${qs ? ('?' + qs) : ''}`;
                  const res = await fetch(url);
                  const data = await res.json().catch(() => []);
                  const items = Array.isArray(data) ? data : (data.items ?? data.result ?? []);
                  renderRows(items);
                  const hasRange = Boolean($fDel?.value) || Boolean($fAl?.value);
                  if ($movHint) $movHint.textContent = hasRange ? "Rango aplicado" : "Mostrando últimos 10";
              } catch (e) {
                  console.error(e);
                  renderRows([]);
                  if ($movHint) $movHint.textContent = "Error al cargar";
              }
          }

          async function descargarExcel() {
              try {
                  const qs = buildQuery();
                  const url = `${API}/api/salida/movimientos/excel${qs ? ('?' + qs) : ''}`;
                  const res = await fetch(url);
                  if (!res.ok) throw new Error();
                  const blob = await res.blob();
                  const ct = (res.headers.get('Content-Type') || '').toLowerCase();
                  const isCsv = ct.includes('text/csv') || ct.includes('application/vnd.ms-excel');
                  const ext = isCsv ? 'csv' : 'xlsx';
                  const a = document.createElement('a');
                  const href = URL.createObjectURL(blob);
                  a.href = href;
                  const tagDel = $fDel?.value || "";
                  const tagAl = $fAl?.value || "";
                  const tag = tagDel + (tagDel && tagAl ? '_' : '') + tagAl;
                  a.download = `movimientos_${tag || new Date().toISOString().slice(0, 10)}.${ext}`;
                  document.body.appendChild(a);
                  a.click();
                  a.remove();
                  URL.revokeObjectURL(href);
              } catch {
                  const rows = [];
                  const headers = ["Fecha", "Código", "# Reloj", "Cantidad", "Equipo", "Responsable"];
                  rows.push(headers.join(','));
                  if ($tbody) {
                      [...$tbody.querySelectorAll('tr')].forEach(tr => {
                          const cols = [...tr.querySelectorAll('td')].map(td => {
                              const v = (td.textContent || "").replaceAll('"', '""');
                              return `"${v}"`;
                          });
                          if (cols.length) rows.push(cols.join(','));
                      });
                  }
                  const blob = new Blob([rows.join('\r\n')], { type: 'text/csv;charset=utf-8;' });
                  const a = document.createElement('a');
                  const href = URL.createObjectURL(blob);
                  const tagDel = $fDel?.value || "";
                  const tagAl = $fAl?.value || "";
                  const tag = tagDel + (tagDel && tagAl ? '_' : '') + tagAl;
                  a.href = href;
                  a.download = `movimientos_${tag || new Date().toISOString().slice(0, 10)}.csv`;
                  document.body.appendChild(a);
                  a.click();
                  a.remove();
                  URL.revokeObjectURL(href);
              }
          }

          async function buscarResponsables(term) {
              
              if (!/^\d{2,}$/.test(term)) { $dlResp.innerHTML = ""; return []; }
              try {
                  const url = `${API}/api/salida/responsables?term=${encodeURIComponent(term)}`;
                  const res = await fetch(url);
                  const data = await res.json().catch(() => ([]));
                  const items = Array.isArray(data) ? data : (data.items ?? []);
                  $dlResp.innerHTML = "";
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
                      $dlResp.appendChild(opt);
                  }
                  return items;
              } catch (e) {
                  console.error(e);
                  $dlResp.innerHTML = "";
                  return [];
              }
          }

          function onResponsableChanged() {
              const reloj = $inputResp.value.trim();
              const match = [...$dlResp.querySelectorAll('option')].find(o => o.value === reloj);
              if (match) {
                  const nombre = match.getAttribute('data-nombre') || "";
                  const depto = match.getAttribute('data-depto') || "";
                  const puesto = match.getAttribute('data-puesto') || "";
                  setEmpleadoFromSelection(nombre, depto, puesto, reloj);
              } else {
                  clearEmpleado();
              }
          }

          if ($cant) $cant.addEventListener('input', updateRegistrarEnabled);

          if ($btnBA) {
              $btnBA.addEventListener('click', async () => {
                  const codigo = $codigo.value.trim();
                  if (!codigo) { alert("Ingresa un código de artículo."); return; }
                  if ($hint) $hint.textContent = "Buscando artículo…";
                  try {
                      const qs = new URLSearchParams({ codigo });
                      const res = await fetch(`${API}/api/salida/lookup?${qs.toString()}`);
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

          if ($btnBE) {
              $btnBE.addEventListener('click', async () => {
                  const term = $inputResp.value.trim();
                  if (!/^\d{2,}$/.test(term)) { alert("Escribe un # de reloj válido."); return; }

                  
                  const match = [...$dlResp.querySelectorAll('option')].find(o => o.value === term);
                  if (match) {
                      const nombre = match.getAttribute('data-nombre') || "";
                      const depto = match.getAttribute('data-depto') || "";
                      const puesto = match.getAttribute('data-puesto') || "";
                      setEmpleadoFromSelection(nombre, depto, puesto, term);
                      return;
                  }
                  try {
                      const qs = new URLSearchParams({ reloj: term });
                      const res = await fetch(`${API}/api/salida/lookup?${qs.toString()}`);
                      const j = await res.json().catch(() => ({}));
                      const emp = j.empleado ?? j.Empleado ?? j;
                      const nombre = pick(emp, ["Nombre_Empleado", "Nombre"]) || "";
                      const depto = pick(emp, ["Dpto_Empleado", "Departamento"]) || "";
                      const puesto = pick(emp, ["Puesto_Empleado", "Puesto"]) || "";
                      const reloj = pick(emp, ["Num_Reloj_Empleado", "Reloj"]) || "";
                      if (reloj) {
                          setEmpleadoFromSelection(nombre, depto, puesto, reloj);
                          $inputResp.value = reloj;
                          return;
                      }
                  } catch (e) { console.error(e); }

                  
                  const items = await buscarResponsables(term);
                  if (items && items.length === 1) {
                      const it = items[0];
                      const nombre = pick(it, ["Nombre_Empleado", "Nombre"]) || "";
                      const depto = pick(it, ["Dpto_Empleado", "Departamento"]) || "";
                      const puesto = pick(it, ["Puesto_Empleado", "Puesto"]) || "";
                      const reloj = pick(it, ["Num_Reloj_Empleado", "Reloj"]) || "";
                      setEmpleadoFromSelection(nombre, depto, puesto, reloj);
                      $inputResp.value = reloj;
                  } else if (items && items.length > 1) {
                      alert("Hay varias coincidencias de # reloj, selecciona una de la lista.");
                  } else {
                      alert("Empleado no encontrado.");
                      clearEmpleado();
                  }
              });
          }

          if ($inputResp) {
              let t;
              $inputResp.addEventListener('input', () => {
                  clearTimeout(t);
                  const term = $inputResp.value.trim();
                  if (!/^\d{2,}$/.test(term)) { $dlResp.innerHTML = ""; clearEmpleado(); return; }
                  t = setTimeout(() => buscarResponsables(term), 200);
              });
              $inputResp.addEventListener('change', onResponsableChanged);
              $inputResp.addEventListener('blur', onResponsableChanged);
              $inputResp.addEventListener('keydown', (e) => {
                  if (e.key === "Enter") { e.preventDefault(); $btnBE?.click(); }
              });
          }

          if ($codigo) {
              $codigo.addEventListener('keydown', (e) => {
                  if (e.key === "Enter") { e.preventDefault(); $btnBA?.click(); }
              });
          }

          if ($btnReg) {
              $btnReg.addEventListener('click', async () => {
                  const codigo = $lblCodigo.textContent.trim();
                  const reloj = $relojHidden.value.trim();
                  const cant = Number($cant.value);
                  const fecha = $fecha.value;
                  const equipo = $equipo.value.trim();
                  const responsable = $resp.value.trim();

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
              inp?.addEventListener('keydown', (e) => {
                  if (e.key === "Enter") { e.preventDefault(); cargarMovimientos(); }
              });
          });

          cargarMovimientos();
          window.cargarMovimientos = cargarMovimientos;
      })();
  </script>

</asp:Content>
