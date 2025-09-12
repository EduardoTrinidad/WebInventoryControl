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
        <h1>Artículos en Stock Máximo y Minimo</h1>
      </div>
    </section>

    <div class="toolbar">
      <div class="field">
        <label for="q">Buscar</label>
        <input id="q" class="control" type="search" placeholder="Código, descripción, marca..." />
      </div>
      <div class="field">
        <label for="cat">Categoría</label>
        <select id="cat" class="control">
          <option value="">Todas</option>
          <option>COCINA</option>
          <option>MANTENIMIENTO</option>
          <option>PRODUCCIÓN</option>
          <option>PINTURA</option>
          <option>VARIOS</option>
        </select>
      </div>
      <div class="field">
        <label for="est">Estado</label>
        <select id="est" class="control">
          <option value="">Todos</option>
          <option value="ok">Disponible</option>
          <option value="low">Bajo stock</option>
          <option value="out">Sin stock</option>
        </select>
      </div>
      <div class="spacer"></div>
      <button type="button" class="btn">Imprimir</button>
      <button type="button" class="btn btn-primary">Exportar CSV</button>
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

            <tr data-max="100" data-now="374">
              <td class="code">T779</td>
              <td>Filtros de 1 micra polipropileno 7”x32” aro plástico</td>
              <td class="brand hide-sm">BHP</td>
              <td class="num">$ 5.80</td>
              <td class="uom hide-sm">Piezas</td>
              <td class="cat hide-sm">COCINA</td>
              <td class="num">100</td>
              <td class="num">374</td>
              <td class="hide-sm">22E</td>
              <td><span class="pill ok">Disponible</span></td>
            </tr>
            <tr data-max="80" data-now="100">
              <td class="code">T1193</td>
              <td>Manguera roja para aire (Metros)</td>
              <td class="brand hide-sm">ADAPTAFLEX</td>
              <td class="num">$ 37.00</td>
              <td class="uom hide-sm">Metros</td>
              <td class="cat hide-sm">MANTENIMIENTO</td>
              <td class="num">80</td>
              <td class="num">100</td>
              <td class="hide-sm">31D,E</td>
              <td><span class="pill ok">Disponible</span></td>
            </tr>
            <tr data-max="50" data-now="50">
              <td class="code">T806</td>
              <td>Disco de lija super asilex de 125mm</td>
              <td class="brand hide-sm">tenazit</td>
              <td class="num">$ 1.10</td>
              <td class="uom hide-sm">Piezas</td>
              <td class="cat hide-sm">PRODUCCIÓN</td>
              <td class="num">50</td>
              <td class="num">50</td>
              <td class="hide-sm">6B</td>
              <td><span class="pill low">Bajo stock</span></td>
            </tr>
            <tr data-max="30" data-now="62">
              <td class="code">T1369</td>
              <td>Válvula sencilla de refacción</td>
              <td class="brand hide-sm">SMC</td>
              <td class="num">$ 8.54</td>
              <td class="uom hide-sm">Piezas</td>
              <td class="cat hide-sm">PINTURA</td>
              <td class="num">30</td>
              <td class="num">62</td>
              <td class="hide-sm">19D</td>
              <td><span class="pill ok">Disponible</span></td>
            </tr>
            <tr data-max="100" data-now="500">
              <td class="code">T1364</td>
              <td>Etiquetas de ID de químicos</td>
              <td class="brand hide-sm">RJ</td>
              <td class="num">$ 1.00</td>
              <td class="uom hide-sm">Piezas</td>
              <td class="cat hide-sm">VARIOS</td>
              <td class="num">100</td>
              <td class="num">500</td>
              <td class="hide-sm">4B</td>
              <td><span class="pill ok">Disponible</span></td>
            </tr>
          </tbody>
        </table>
      </div>
      <p id="stockmax-desc" class="sr-only">Los renglones que superan el stock máximo se resaltan automáticamente.</p>
    </section>
  </div>

  <script>
    (function(){
      // Resalta filas donde Stock actual > Stock máximo
      const rows = document.querySelectorAll('#stock-body tr');
      rows.forEach(tr => {
        const max = Number(tr.getAttribute('data-max') || '0');
        const now = Number(tr.getAttribute('data-now') || '0');
        if (now > max) tr.classList.add('over-max');
      });

      // (Opcional) Filtro visual simple en el front
      const q = document.getElementById('q');
      const cat = document.getElementById('cat');
      const est = document.getElementById('est');

      function applyFilter(){
        const term = (q.value || '').toLowerCase().trim();
        const fcat = (cat.value || '').toLowerCase();
        const fest = (est.value || '').toLowerCase();

        rows.forEach(tr=>{
          const txt = tr.innerText.toLowerCase();
          const catCell = tr.querySelector('.cat')?.innerText.toLowerCase() || '';
          const state = tr.querySelector('.pill')?.classList[1] || ''; // ok/low/out
          let show = true;

          if (term && !txt.includes(term)) show = false;
          if (fcat && !catCell.includes(fcat)) show = false;
          if (fest && !state.includes(fest)) show = false;

          tr.style.display = show ? '' : 'none';
        });
      }
      [q,cat,est].forEach(el => el && el.addEventListener('input', applyFilter));
    })();
  </script>
</asp:Content>
