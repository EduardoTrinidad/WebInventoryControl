<%@ Page Title="Stock Máximo" Language="C#"
    MasterPageFile="~/Site.master"
    AutoEventWireup="true"
    CodeBehind="Stockmaximo.aspx.cs"
    Inherits="WebInventoryControl.Articulos" %>

<asp:Content ID="HeadArticulos" ContentPlaceHolderID="HeadContent" runat="server">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
  <link href="<%= ResolveUrl("~/Content/pages/stock.css") %>" rel="stylesheet" />
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
  <div class="page-wrap">
    <section class="hero">
      <svg viewBox="0 0 24 24" aria-hidden="true">
        <path fill="url(#g1)" d="M12 2.5 21.5 12 12 21.5 2.5 12 12 2.5Z"/>
        <path fill="#fff" d="M12 6c.55 0 1 .45 1 1v7a1 1 0 0 1-2 0V7c0-.55.45-1 1-1Zm0 12a1.25 1.25 0 1 0 0-2.5 1.25 1.25 0 0 0 0 2.5Z"/>
        <defs>
          <linearGradient id="g1" x1="0" y1="0" x2="1" y2="1">
            <stop offset="0" stop-color="#ff7a59"/>
            <stop offset="1" stop-color="#ef4444"/>
          </linearGradient>
        </defs>
      </svg>
      <div>
        <h1>Artículos en Stock Máximo y Mínimo</h1>
      </div>
    </section>

    <div class="toolbar">
      <div class="field">
        <label for="q">Buscar</label>
        <input id="q" class="control" type="search" placeholder="Escribe el codigo" />
      </div>

      <div class="field">
        <label for="cat">Categoría</label>
        <select id="cat" class="control">
          <option value="">Todas</option>
      
        </select>
      </div>

      <div class="field">
        <label for="est">Estado</label>
        <select id="est" class="control">
          <option value="">Todos</option>
          <option value="ok">Disponible</option>
          <option value="low">Bajo stock</option>
          <option value="out">Sin stock</option>
          <option value="over">Sobre máximo</option>
        </select>
      </div>

      <div class="spacer"></div>
      <button id="btnPrint" type="button" class="btn">Imprimir</button>
      <button id="btnCSV" type="button" class="btn btn-primary">Exportar CSV</button>
    </div>

    <section class="table-card">
      <div class="table-scroll">
        <table class="inv" aria-describedby="stockmax-desc">
          <thead>
            <tr>
              <th>Código</th>
              <th>Descripción</th>
              <th class="hide-sm">Marca</th>
              <th>Precio</th>
              <th class="hide-sm">U/M</th>
              <th class="hide-sm">Categoría</th>
              <th>Stock máximo</th>
              <th>Stock actual</th>
              <th class="hide-sm">Ubicación</th>
              <th>Status</th>
            </tr>
          </thead>
          <tbody id="stock-body">
           
          </tbody>
        </table>
      </div>
      <p id="stockmax-desc" class="sr-only">Los renglones que superan el stock máximo se resaltan automáticamente.</p>
    </section>
  </div>

  <script>
      (function () {
          
          const API_URL = 'https://localhost:7059/api/Stock/stock_tabla'; 

          const $body = document.getElementById('stock-body');
          const $q = document.getElementById('q');
          const $cat = document.getElementById('cat');
          const $est = document.getElementById('est');
          const $btnPrint = document.getElementById('btnPrint');
          const $btnCSV = document.getElementById('btnCSV');

          let _rowsCache = [];


          const toNumber = (v) => {
              if (v === null || v === undefined) return 0;
              const n = Number(String(v).toString().replace(/[^\d.\-]/g, ''));
              return isNaN(n) ? 0 : n;
          };

          const fmtMoney = (v) =>
              new Intl.NumberFormat('es-MX', { style: 'currency', currency: 'MXN', minimumFractionDigits: 2 }).format(Number(v || 0));

          function pick(obj, keys) {
              for (const k of keys) {
                  if (obj[k] !== undefined && obj[k] !== null) return obj[k];
              }
              return '';
          }

          function statusFrom(max, now) {
              if (now <= 0) return { key: 'out', label: 'Sin stock' };
              if (now < max && now > 0) return { key: 'low', label: 'Bajo stock' };
              if (now === max) return { key: 'ok', label: 'Disponible' };
              if (now > max) return { key: 'over', label: 'Sobre máximo' };
              return { key: 'ok', label: 'Disponible' };
          }

          function renderRows(data) {
              $body.innerHTML = '';

              if (!Array.isArray(data) || data.length === 0) {
                  $body.innerHTML = '<tr><td colspan="10" class="text-center">Sin resultados.</td></tr>';
                  return;
              }

              const frag = document.createDocumentFragment();

              data.forEach(item => {

                  const codigo = pick(item, ['Codigo_Articulo', 'codigo_Articulo', 'Codigo', 'codigo']);
                  const descripcion = pick(item, ['Descripcion_Articulo', 'descripcion_Articulo', 'Descripcion', 'descripcion']);
                  const marca = pick(item, ['Marca_Articulo', 'marca_Articulo', 'Marca', 'marca']);
                  const precio = toNumber(pick(item, ['Precio_Articulo', 'precio_Articulo', 'Precio', 'precio']));
                  const um = pick(item, ['Unidad_Medida_Articulo', 'unidad_Medida_Articulo', 'UM', 'um']);
                  const categoria = pick(item, ['Categoria_Articulo', 'categoria_Articulo', 'Categoria', 'categoria']);
                  const stockMax = toNumber(pick(item, ['Stock_Maximo_Articulo', 'stock_Maximo_Articulo', 'Stock_Maximo', 'stock_Maximo', 'StockMaximo']));
                  const stockNow = toNumber(pick(item, ['Stock_Actual_Articulo', 'stock_Actual_Articulo', 'Stock_Actual', 'stock_Actual', 'StockActual']));
                  const ubicacion = pick(item, ['Ubicacion_Articulo', 'ubicacion_Articulo', 'Ubicacion', 'ubicacion']);

                  const st = statusFrom(stockMax, stockNow);

                  const tr = document.createElement('tr');
                  tr.dataset.max = String(stockMax);
                  tr.dataset.now = String(stockNow);
                  if (st.key === 'over') tr.classList.add('over-max');

                  tr.innerHTML = `
            <td class="code">${codigo}</td>
            <td>${descripcion}</td>
            <td class="brand hide-sm">${marca}</td>
            <td class="num">${fmtMoney(precio)}</td>
            <td class="uom hide-sm">${um}</td>
            <td class="cat hide-sm">${categoria}</td>
            <td class="num">${stockMax}</td>
            <td class="num">${stockNow}</td>
            <td class="hide-sm">${ubicacion}</td>
            <td><span class="pill ${st.key}">${st.label}</span></td>
          `;
                  frag.appendChild(tr);
              });

              $body.appendChild(frag);
          }

          function applyFilter() {
              const term = ($q.value || '').toLowerCase().trim();
              const fcat = ($cat.value || '').toLowerCase();
              const fest = ($est.value || '').toLowerCase();

              Array.from($body.querySelectorAll('tr')).forEach(tr => {
                  const txt = tr.innerText.toLowerCase();
                  const catCell = tr.querySelector('.cat')?.innerText.toLowerCase() || '';
                  const pill = tr.querySelector('.pill');
                  const stKey = pill ? [...pill.classList].find(c => ['ok', 'low', 'out', 'over'].includes(c)) || '' : '';

                  let show = true;
                  if (term && !txt.includes(term)) show = false;
                  if (fcat && !catCell.includes(fcat)) show = false;
                  if (fest && !stKey.includes(fest)) show = false;

                  tr.style.display = show ? '' : 'none';
              });
          }

          function buildCategoriesOptions(data) {
              const set = new Set();
              (data || []).forEach(item => {
                  const categoria = pick(item, ['Categoria_Articulo', 'categoria_Articulo', 'Categoria', 'categoria']);
                  if (categoria) set.add(String(categoria));
              });
              $cat.innerHTML = '<option value="">Todas</option>';
              [...set].sort((a, b) => a.localeCompare(b, 'es')).forEach(cat => {
                  const opt = document.createElement('option');
                  opt.value = cat;
                  opt.textContent = cat;
                  $cat.appendChild(opt);
              });
          }

          function toCSV() {
              const visibleRows = Array.from($body.querySelectorAll('tr')).filter(tr => tr.style.display !== 'none');
              const headers = ['Código', 'Descripción', 'Marca', 'Precio', 'U/M', 'Categoría', 'Stock máximo', 'Stock actual', 'Ubicación', 'Estado'];
              const lines = [headers.join(',')];

              visibleRows.forEach(tr => {
                  const tds = tr.querySelectorAll('td');
                  const row = [
                      tds[0]?.innerText || '',
                      tds[1]?.innerText || '',
                      tds[2]?.innerText || '',
                      tds[3]?.innerText || '',
                      tds[4]?.innerText || '',
                      tds[5]?.innerText || '',
                      tds[6]?.innerText || '',
                      tds[7]?.innerText || '',
                      tds[8]?.innerText || '',
                      tds[9]?.innerText || ''
                  ].map(v => `"${String(v).replace(/"/g, '""')}"`).join(',');

                  lines.push(row);
              });

              const blob = new Blob([lines.join('\n')], { type: 'text/csv;charset=utf-8;' });
              const url = URL.createObjectURL(blob);
              const a = document.createElement('a');
              a.href = url;
              a.download = 'stock_maximo.csv';
              a.click();
              URL.revokeObjectURL(url);
          }

          async function loadData() {
              try {
                  const res = await fetch(API_URL, { method: 'GET' });
                  if (!res.ok) throw new Error('Error HTTP ' + res.status);
                  const data = await res.json();

                  _rowsCache = Array.isArray(data) ? data : [];
                  renderRows(_rowsCache);
                  buildCategoriesOptions(_rowsCache);
                  applyFilter();
              } catch (err) {
                  console.error('Error cargando datos:', err);
                  $body.innerHTML = `
            <tr>
              <td colspan="10" class="text-center text-danger">
                No se pudo cargar la información del inventario.
              </td>
            </tr>`;
              }
          }
          [$q, $cat, $est].forEach(el => el && el.addEventListener('input', applyFilter));
          $btnPrint?.addEventListener('click', () => window.print());
          $btnCSV?.addEventListener('click', toCSV);

          loadData();
      })();
  </script>
</asp:Content>
