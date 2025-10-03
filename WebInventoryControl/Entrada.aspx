<%@ Page Title="Materiales" Language="C#"
    MasterPageFile="~/Site.master"
    AutoEventWireup="true"
    CodeBehind="Articulos.aspx.cs"
    Inherits="WebInventoryControl.Articulos" %>

<asp:Content ID="HeadArticulos" ContentPlaceHolderID="HeadContent" runat="server">
  <link rel="stylesheet" href="<%= ResolveUrl("~/Content/pages/articulo.css") %>" />
  <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.3/dist/chart.umd.min.js" crossorigin="anonymous"></script>
</asp:Content>

<asp:Content ID="MainArticulos" ContentPlaceHolderID="MainContent" runat="server">

  <!-- Cambié SOLO los textos: ahora son Materiales / Entradas / Salidas -->
  <div class="radio-inputs" id="modeRadios">
    <label class="radio">
      <input type="radio" name="modo" value="buscar" checked />
      <span class="name">Buscar material</span>
    </label>
    <label class="radio">
      <input type="radio" name="modo" value="prestar" />
      <span class="name">Registrar movimiento</span>
    </label>
  </div>

  <div class="card-container">

    <!-- CARD 1: BÚSQUEDA por Código o Fecha / y también por #Reloj del asociado -->
    <div class="articulo-card" id="card-buscar">
      <div class="articulo-header">
        <div class="articulo-badge">JPH</div>
        <div>
          <h3 class="articulo-title">Buscar material</h3>
          <p class="articulo-sub">Consulta por <strong>código</strong>, <strong>fecha</strong> o <strong># reloj de asociado</strong></p>
        </div>
      </div>

      <div class="articulo-body">
        <div class="form-grid">
          <div class="field" style="grid-column:1/-1;">
            <label for="reloj">Código / Fecha (AAAA-MM-DD) / # Reloj</label>
            <input id="reloj" class="control" type="search" placeholder="Ej. MAT-001 | 2025-09-15 | 00123" />
          </div>

          <div class="field">
            <label>Descripción</label>
            <input id="outNombre" class="control" type="text" placeholder="—" disabled />
          </div>
          <div class="field">
            <label>Categoría</label>
            <input id="outDepto" class="control" type="text" placeholder="—" disabled />
          </div>
          <div class="field">
            <label>Unidad</label>
            <input id="outPuesto" class="control" type="text" placeholder="—" disabled />
          </div>
          <div class="field">
            <label>Stock actual</label>
            <input id="outTurno" class="control" type="text" placeholder="—" disabled />
          </div>
        </div>

        <div class="results" aria-label="Resultado (mock)">
          <div class="thumb" aria-hidden="true"></div>
          <div>
            <div style="font-weight:700;">Movimientos encontrados</div>
            <div class="articulo-sub" id="result-help">Escribe un código, fecha (AAAA-MM-DD) o # reloj.</div>
          </div>
          <button type="button" class="btn btn-secondary" id="go-prestar">Registrar</button>
        </div>
      </div>
    </div>

    <!-- CARD 2: REGISTRO de movimiento ENTRADA/SALIDA con asignación a asociado -->
    <div class="articulo-card is-hidden" id="card-prestar" aria-hidden="true">
      <div class="articulo-header">
        <div class="articulo-badge">JPH</div>
        <div>
          <h3 class="articulo-title">Movimiento de material</h3>
          <p class="articulo-sub">Entrada o salida con opción de asignar a un asociado</p>
        </div>
      </div>

      <div class="articulo-body">
        <div class="form-grid">
          <!-- Asociado -->
          <div class="field">
            <label for="relojPrestamo"># Reloj asociado</label>
            <input id="relojPrestamo" class="control" type="text" placeholder="Ej. 00123 (solo para SALIDA)" />
          </div>
          <div class="field">
            <label for="nombrePrestamo">Nombre asociado</label>
            <input id="nombrePrestamo" class="control" type="text" placeholder="Nombre (autollenado opcional)" />
          </div>
          <div class="field">
            <label for="deptoPrestamo">Área / Departamento</label>
            <input id="deptoPrestamo" class="control" type="text" placeholder="Área (autollenado opcional)" />
          </div>

          <!-- Material -->
          <div class="field">
            <label for="toolId">Código de material</label>
            <input id="toolId" class="control" type="text" placeholder="Ej. MAT-00045" />
          </div>
          <div class="field" style="grid-column:1/-1;">
            <label for="toolName">Nombre / Descripción del material</label>
            <input id="toolName" class="control" type="text" placeholder="Ej. Tornillo M6 x 20 mm" />
          </div>

          <!-- Movimiento -->
          <div class="field">
            <label for="tipoMov">Tipo de movimiento</label>
            <select id="tipoMov" class="control">
              <option value="ENTRADA">ENTRADA</option>
              <option value="SALIDA">SALIDA</option>
            </select>
          </div>
          <div class="field">
            <label for="cantidadMov">Cantidad</label>
            <input id="cantidadMov" class="control" type="number" min="1" placeholder="Ej. 10" />
          </div>

          <div class="field">
            <label for="fecha">Fecha</label>
            <input id="fecha" class="control" type="date" />
          </div>
          <div class="field">
            <label for="hora">Hora</label>
            <input id="hora" class="control" type="time" />
          </div>
          <div class="field" style="grid-column:1/-1;">
            <label for="comentarios">Comentarios</label>
            <input id="comentarios" class="control" type="text" placeholder="Lote, OC, motivo, etc. (opcional)" />
          </div>
        </div>

        <div class="actions">
          <button type="button" class="btn btn-secondary" id="btn-cancel">Cancelar</button>
          <button type="button" class="btn btn-primary" id="btn-registrar">Registrar movimiento</button>
        </div>
      </div>
    </div>
  </div>

  <!-- ANALYTICS: solo textos -->
  <section class="analytics" aria-label="Analítica de Materiales">
    <h4>Indicadores</h4>

    <div class="kpis">
      <div class="kpi" aria-live="polite">
        <div class="label">Material más movido</div>
        <div class="value" id="kpi-top-tool">—</div>
        <div class="trend up" id="kpi-top-tool-trend">+0% este mes</div>
      </div>
      <div class="kpi" aria-live="polite">
        <div class="label">Asociado con más salidas</div>
        <div class="value" id="kpi-top-user">—</div>
        <div class="trend up" id="kpi-top-user-trend">+0% salidas</div>
      </div>
      <div class="kpi" aria-live="polite">
        <div class="label">Área con más movimientos</div>
        <div class="value" id="kpi-top-dept">—</div>
        <div class="trend up" id="kpi-top-dept-trend">+0%</div>
      </div>
    </div>

    <div class="users-toolbar">
      <div class="search" role="search">
        <svg width="16" height="16" viewBox="0 0 24 24" aria-hidden="true"><path fill="currentColor" d="M21 21l-4.3-4.3m1.6-5.1A7.2 7.2 0 1 1 3 11.6a7.2 7.2 0 0 1 15.3 0Z"/></svg>
        <input id="qTabla" type="search" placeholder="Filtrar movimientos (código, asociado, fecha)…" aria-label="Buscar movimientos" />
      </div>
      <span class="pill"><strong>Total movimientos:</strong> <span id="users-total">—</span></span>
    </div>

    <div class="table-wrap">
      <div class="table-scroll">
        <table class="users-table" role="table" aria-label="Tabla de movimientos (mock)">
          <thead>
            <tr>
              <th>Código</th>
              <th>Material</th>
              <th>Tipo</th>
              <th>Cantidad</th>
              <th># Reloj</th>
              <th>Fecha/Hora</th>
              <th>Estado</th>
            </tr>
          </thead>
          <tbody id="users-body"><!-- Se llena por JS --></tbody>
        </table>
      </div>
    </div>

    <div class="charts">
      <div class="chart-card">
        <div class="title">Materiales más movidos</div>
        <canvas id="chartTopTools" height="220" aria-label="Barras materiales" role="img"></canvas>
      </div>
      <div class="chart-card">
        <div class="title">Asociados con más salidas</div>
        <canvas id="chartTopUsers" height="220" aria-label="Barras asociados" role="img"></canvas>
      </div>
      <div class="chart-card">
        <div class="title">Áreas con más movimientos</div>
        <canvas id="chartTopDepts" height="220" aria-label="Barras áreas" role="img"></canvas>
      </div>
    </div>
  </section>

  <script>
  (function () {
    const radios = document.querySelectorAll('input[name="modo"]');
    const cardBuscar = document.getElementById('card-buscar');
    const cardPrestar = document.getElementById('card-prestar');
    const goPrestar = document.getElementById('go-prestar');

    function show(which) {
      const showEl = which === 'buscar' ? cardBuscar : cardPrestar;
      const hideEl = which === 'buscar' ? cardPrestar : cardBuscar;
      hideEl.classList.add('is-hidden'); hideEl.setAttribute('aria-hidden', 'true');
      showEl.classList.remove('is-hidden'); showEl.removeAttribute('aria-hidden');
    }
    radios.forEach(r => r.addEventListener('change', e => show(e.target.value)));
    if (goPrestar) {
      goPrestar.addEventListener('click', () => {
        document.querySelector('input[name="modo"][value="prestar"]').checked = true;
        show('prestar');
      });
    }

    // ===== Mock de datos (puedes reemplazar con tu API) =====
    const asociados = [
      { reloj: "00123", nombre: "Maria López", area: "Producción" },
      { reloj: "00456", nombre: "Carlos Pérez", area: "Mantenimiento" },
      { reloj: "00789", nombre: "Ana Torres", area: "Calidad" },
    ];

    const materiales = [
      { codigo: "MAT-001", nombre: "Tornillo M6x20", categoria: "Fijación", unidad: "pz", stock: 540 },
      { codigo: "MAT-002", nombre: "Tuerca M6",    categoria: "Fijación", unidad: "pz", stock: 800 },
      { codigo: "MAT-003", nombre: "Cable AWG22",  categoria: "Eléctrico", unidad: "m",  stock: 120 },
    ];

    let movimientos = [
      { codigo:"MAT-001", material:"Tornillo M6x20", tipo:"SALIDA", cantidad:50, reloj:"00123", fecha:"2025-09-25", hora:"08:32", estado:"OK" },
      { codigo:"MAT-002", material:"Tuerca M6",     tipo:"ENTRADA", cantidad:200, reloj:"",     fecha:"2025-09-25", hora:"10:05", estado:"OK" },
      { codigo:"MAT-003", material:"Cable AWG22",   tipo:"SALIDA",  cantidad:20,  reloj:"00456", fecha:"2025-09-26", hora:"14:10", estado:"OK" },
    ];

    // ===== Búsqueda en CARD 1: por código, fecha o # reloj =====
    const $q = document.getElementById('reloj');
    const $outNom = document.getElementById('outNombre');
    const $outCat = document.getElementById('outDepto');
    const $outUni = document.getElementById('outPuesto');
    const $outStock = document.getElementById('outTurno');
    const $resultHelp = document.getElementById('result-help');

    function isIsoDate(v) { return /^\d{4}-\d{2}-\d{2}$/.test(v); }

    function fillMaterial(m) {
      $outNom.value = m ? m.nombre : "";
      $outCat.value = m ? m.categoria : "";
      $outUni.value = m ? m.unidad : "";
      $outStock.value = m ? String(m.stock) : "";
    }

    $q.addEventListener('input', () => {
      const v = $q.value.trim().toUpperCase();
      let filtered = [];
      if (!v) { fillMaterial(null); $resultHelp.textContent = "Escribe un código, fecha o # reloj."; return; }

      if (isIsoDate(v)) {
        filtered = movimientos.filter(x => x.fecha === v);
        $resultHelp.textContent = `${filtered.length} movimiento(s) en ${v}`;
        // si hay uno, tratar de mostrar su material
        const m = materiales.find(mm => mm.codigo === (filtered[0]?.codigo || ""));
        fillMaterial(m || null);
        return;
      }

      if (/^\d{3,}$/.test(v)) {
        // Búsqueda por # reloj de asociado
        filtered = movimientos.filter(x => x.reloj.startsWith(v));
        $resultHelp.textContent = `${filtered.length} movimiento(s) del asociado ${v}`;
        const asoc = asociados.find(a => a.reloj.startsWith(v));
        if (asoc) {
          document.getElementById('relojPrestamo').value = asoc.reloj;
          document.getElementById('nombrePrestamo').value = asoc.nombre;
          document.getElementById('deptoPrestamo').value = asoc.area;
        }
        const m = materiales.find(mm => mm.codigo === (filtered[0]?.codigo || ""));
        fillMaterial(m || null);
        return;
      }

      // Por código de material
      const mat = materiales.find(mm => mm.codigo.startsWith(v));
      fillMaterial(mat || null);
      filtered = movimientos.filter(x => x.codigo.startsWith(v));
      $resultHelp.textContent = `${filtered.length} movimiento(s) del código ${v}`;
    });

    // ===== Registrar movimiento (ENTRADA/SALIDA) =====
    document.getElementById('btn-registrar').addEventListener('click', () => {
      const tipo = document.getElementById('tipoMov').value;
      const codigo = document.getElementById('toolId').value.trim().toUpperCase();
      const material = document.getElementById('toolName').value.trim();
      const reloj = document.getElementById('relojPrestamo').value.trim();
      const nombre = document.getElementById('nombrePrestamo').value.trim();
      const depto = document.getElementById('deptoPrestamo').value.trim();
      const fecha = document.getElementById('fecha').value;
      const hora = document.getElementById('hora').value;
      const cantidad = parseFloat(document.getElementById('cantidadMov').value || "0");

      if (!codigo || !material || !fecha || !hora || !(cantidad > 0)) {
        alert("Completa Código, Material, Cantidad, Fecha y Hora.");
        return;
      }
      if (tipo === "SALIDA" && !reloj) {
        alert("Para SALIDA necesitas asignar el # reloj del asociado.");
        return;
      }

      // Actualiza stock del mock
      const m = materiales.find(x => x.codigo === codigo);
      if (m) { m.stock += (tipo === "ENTRADA" ? cantidad : -cantidad); if (m.stock < 0) m.stock = 0; }
      // Guarda movimiento (mock)
      movimientos.unshift({ codigo, material, tipo, cantidad, reloj: (tipo==="SALIDA"?reloj:""), fecha, hora, estado:"OK" });

      // Autollenado asociado si existe
      if (reloj && !nombre) {
        const a = asociados.find(x => x.reloj === reloj);
        if (a) {
          document.getElementById('nombrePrestamo').value = a.nombre;
          document.getElementById('deptoPrestamo').value = a.area;
        }
      }

      renderTabla();
      renderKPIsyCharts();
      alert('Movimiento registrado (demo). Integra tu API en este punto.');
    });

    document.getElementById('btn-cancel').addEventListener('click', () => show('buscar'));

    // ===== Tabla y filtros rápidos =====
    const $tbody = document.getElementById('users-body');
    const $qTabla = document.getElementById('qTabla');

    function renderTabla() {
      const rows = movimientos.map(m => 
        `<tr>
          <td>${m.codigo}</td>
          <td>${m.material}</td>
          <td>${m.tipo}</td>
          <td>${m.cantidad}</td>
          <td>${m.reloj || '—'}</td>
          <td>${m.fecha} ${m.hora}</td>
          <td><span class="badge">${m.estado}</span></td>
        </tr>`
      ).join('');
      $tbody.innerHTML = rows;
      document.getElementById('users-total').textContent = movimientos.length.toString();
    }

    $qTabla.addEventListener('input', () => {
      const v = $qTabla.value.trim().toUpperCase();
      const filtered = movimientos.filter(m =>
        m.codigo.toUpperCase().includes(v) ||
        m.material.toUpperCase().includes(v) ||
        (m.reloj||"").toUpperCase().includes(v) ||
        m.fecha.includes(v)
      );
      const rows = filtered.map(m => 
        `<tr>
          <td>${m.codigo}</td>
          <td>${m.material}</td>
          <td>${m.tipo}</td>
          <td>${m.cantidad}</td>
          <td>${m.reloj || '—'}</td>
          <td>${m.fecha} ${m.hora}</td>
          <td><span class="badge">${m.estado}</span></td>
        </tr>`
      ).join('');
      $tbody.innerHTML = rows;
      document.getElementById('users-total').textContent = filtered.length.toString();
    });

    // ===== KPIs + Charts (reutiliza tu paleta del CSS) =====
    function renderKPIsyCharts() {
      // KPI top asociado por SALIDAS
      const salidasPorAsociado = movimientos
        .filter(x => x.tipo === "SALIDA" && x.reloj)
        .reduce((acc, x) => (acc[x.reloj] = (acc[x.reloj]||0) + x.cantidad, acc), {});
      const topAsoc = Object.entries(salidasPorAsociado).sort((a,b)=>b[1]-a[1])[0];
      const asocNombre = topAsoc ? (asociados.find(a=>a.reloj===topAsoc[0])?.nombre || topAsoc[0]) : '—';
      document.getElementById('kpi-top-user').textContent = asocNombre;

      // KPI top material movido
      const movPorMaterial = movimientos.reduce((acc, x) => (acc[x.material] = (acc[x.material]||0) + x.cantidad, acc), {});
      const topMat = Object.entries(movPorMaterial).sort((a,b)=>b[1]-a[1])[0];
      document.getElementById('kpi-top-tool').textContent = topMat ? topMat[0] : '—';

      // KPI top área (usa área del asociado cuando haya reloj)
      const areaPorMov = movimientos.reduce((acc, x) => {
        const area = x.reloj ? (asociados.find(a=>a.reloj===x.reloj)?.area || "—") : "—";
        acc[area] = (acc[area]||0) + x.cantidad; return acc;
      }, {});
      const topArea = Object.entries(areaPorMov).sort((a,b)=>b[1]-a[1])[0];
      document.getElementById('kpi-top-dept').textContent = topArea ? topArea[0] : '—';

      // Charts
      const cs = getComputedStyle(document.documentElement);
      const gridColor = cs.getPropertyValue('--card-border').trim() || 'rgba(148,163,184,.3)';
      const labelColor = cs.getPropertyValue('--card-fg').trim() || '#0f172a';
      const accentA = cs.getPropertyValue('--accent-a').trim() || '#2563eb';
      const accentB = cs.getPropertyValue('--accent-b').trim() || '#22c55e';
      const accentC = cs.getPropertyValue('--accent-c').trim() || '#eab308';

      // Materiales más movidos
      const ctx1 = document.getElementById('chartTopTools').getContext('2d');
      if (window._c1) window._c1.destroy();
      window._c1 = new Chart(ctx1, {
        type: 'bar',
        data: {
          labels: Object.keys(movPorMaterial),
          datasets: [{ label: 'Cantidad', data: Object.values(movPorMaterial), borderWidth: 1, backgroundColor: accentA, borderColor: accentA }]
        },
        options: {
          responsive: true,
          plugins: { legend: { labels: { color: labelColor } } },
          scales: {
            x: { ticks: { color: labelColor }, grid: { color: gridColor } },
            y: { beginAtZero: true, ticks: { color: labelColor }, grid: { color: gridColor } }
          }
        }
      });

      // Asociados con más salidas
      const ctx2 = document.getElementById('chartTopUsers').getContext('2d');
      if (window._c2) window._c2.destroy();
      const labelsAsoc = Object.keys(salidasPorAsociado).map(r => asociados.find(a=>a.reloj===r)?.nombre?.split(' ')[0] || r);
      window._c2 = new Chart(ctx2, {
        type: 'bar',
        data: {
          labels: labelsAsoc,
          datasets: [{ label: 'Salidas', data: Object.values(salidasPorAsociado), borderWidth: 1, backgroundColor: accentB, borderColor: accentB }]
        },
        options: {
          responsive: true,
          plugins: { legend: { labels: { color: labelColor } } },
          scales: {
            x: { ticks: { color: labelColor }, grid: { color: gridColor } },
            y: { beginAtZero: true, ticks: { color: labelColor }, grid: { color: gridColor } }
          }
        }
      });

      // Áreas con más movimientos
      const ctx3 = document.getElementById('chartTopDepts').getContext('2d');
      if (window._c3) window._c3.destroy();
      window._c3 = new Chart(ctx3, {
        type: 'bar',
        data: {
          labels: Object.keys(areaPorMov),
          datasets: [{ label: 'Cantidad', data: Object.values(areaPorMov), borderWidth: 1, backgroundColor: accentC, borderColor: accentC }]
        },
        options: {
          responsive: true,
          plugins: { legend: { labels: { color: labelColor } } },
          scales: {
            x: { ticks: { color: labelColor }, grid: { color: gridColor } },
            y: { beginAtZero: true, ticks: { color: labelColor }, grid: { color: gridColor } }
          }
        }
      });
    }

    // ===== Autollenado de asociado al capturar # reloj en la card de registro =====
    const $relojPrestamo = document.getElementById('relojPrestamo');
    $relojPrestamo.addEventListener('input', () => {
      const v = $relojPrestamo.value.trim();
      const a = asociados.find(x => x.reloj.startsWith(v));
      document.getElementById('nombrePrestamo').value = a ? a.nombre : "";
      document.getElementById('deptoPrestamo').value = a ? a.area : "";
    });

    // ===== Init =====
    const now = new Date();
    document.getElementById('fecha').value = now.toISOString().slice(0, 10);
    document.getElementById('hora').value = now.toTimeString().slice(0, 5);

    renderTabla();
    renderKPIsyCharts();
  })();
  </script>
</asp:Content>
