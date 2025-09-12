<%@ Page Title="Artículos" Language="C#"
    MasterPageFile="~/Site.master"
    AutoEventWireup="true"
    CodeBehind="Articulos.aspx.cs"
    Inherits="WebInventoryControl.Articulos" %>

<asp:Content ID="HeadArticulos" ContentPlaceHolderID="HeadContent" runat="server">
  <link rel="stylesheet" href="<%= ResolveUrl("~/Content/pages/articulo.css") %>" />
  <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.3/dist/chart.umd.min.js" crossorigin="anonymous"></script>
</asp:Content>

<asp:Content ID="MainArticulos" ContentPlaceHolderID="MainContent" runat="server">

  <div class="radio-inputs" id="modeRadios">
    <label class="radio">
      <input type="radio" name="modo" value="buscar" checked />
      <span class="name">Buscar usuario</span>
    </label>
    <label class="radio">
      <input type="radio" name="modo" value="prestar" />
      <span class="name">Prestar herramienta</span>
    </label>
  </div>

  <div class="card-container">

    <div class="articulo-card" id="card-buscar">
      <div class="articulo-header">
        <div class="articulo-badge">JPH</div>
        <div>
          <h3 class="articulo-title">Buscar empleado</h3>
          <p class="articulo-sub">Consulta por <strong>número de reloj</strong></p>
        </div>
      </div>

      <div class="articulo-body">
        <div class="form-grid">
          <div class="field" style="grid-column:1/-1;">
            <label for="reloj">Número de reloj</label>
            <input id="reloj" class="control" type="search" inputmode="numeric" placeholder="Ej. 00123" />
          </div>

          <div class="field">
            <label>Nombre</label>
            <input id="outNombre" class="control" type="text" placeholder="—" disabled />
          </div>
          <div class="field">
            <label>Departamento</label>
            <input id="outDepto" class="control" type="text" placeholder="—" disabled />
          </div>
          <div class="field">
            <label>Puesto</label>
            <input id="outPuesto" class="control" type="text" placeholder="—" disabled />
          </div>
          <div class="field">
            <label>Turno</label>
            <input id="outTurno" class="control" type="text" placeholder="—" disabled />
          </div>
        </div>

        <div class="results" aria-label="Resultado (mock)">
          <div class="thumb" aria-hidden="true"></div>
          <div>
            <div style="font-weight:700;">Resultado</div>
            <div class="articulo-sub">Muestra simulada al buscar por reloj</div>
          </div>
          <button type="button" class="btn btn-secondary" id="go-prestar">Prestar</button>
        </div>
      </div>
    </div>

    <div class="articulo-card is-hidden" id="card-prestar" aria-hidden="true">
      <div class="articulo-header">
        <div class="articulo-badge">JPH</div>
        <div>
          <h3 class="articulo-title">Préstamo de herramienta</h3>
          <p class="articulo-sub">Registra un préstamo rápido</p>
        </div>
      </div>

      <div class="articulo-body">
        <div class="form-grid">
          <div class="field">
            <label for="relojPrestamo"># Reloj</label>
            <input id="relojPrestamo" class="control" type="text" placeholder="Ej. 00123" />
          </div>
          <div class="field">
            <label for="nombrePrestamo">Nombre</label>
            <input id="nombrePrestamo" class="control" type="text" placeholder="Nombre del empleado" />
          </div>
          <div class="field">
            <label for="deptoPrestamo">Departamento</label>
            <input id="deptoPrestamo" class="control" type="text" placeholder="Departamento" />
          </div>
          <div class="field">
            <label for="toolId">ID/Parte herramienta</label>
            <input id="toolId" class="control" type="text" placeholder="Ej. TL-00045 o ABC-123" />
          </div>
          <div class="field" style="grid-column:1/-1;">
            <label for="toolName">Nombre de la herramienta</label>
            <input id="toolName" class="control" type="text" placeholder="Desarmador Philips / Taladro, etc." />
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
            <input id="comentarios" class="control" type="text" placeholder="Observaciones (opcional)" />
          </div>
        </div>

        <div class="actions">
          <button type="button" class="btn btn-secondary" id="btn-cancel">Cancelar</button>
          <button type="button" class="btn btn-primary" id="btn-registrar">Registrar préstamo</button>
        </div>
      </div>
    </div>
  </div>

  <section class="analytics" aria-label="Analítica de Toolcrib">
    <h4>Indicadores</h4>

    <div class="kpis">
      <div class="kpi" aria-live="polite">
        <div class="label">Herramienta más usada</div>
        <div class="value" id="kpi-top-tool">—</div>
        <div class="trend up" id="kpi-top-tool-trend">+0% este mes</div>
      </div>
      <div class="kpi" aria-live="polite">
        <div class="label">Quién solicita más</div>
        <div class="value" id="kpi-top-user">—</div>
        <div class="trend up" id="kpi-top-user-trend">+0% solicitudes</div>
      </div>
      <div class="kpi" aria-live="polite">
        <div class="label">Departamento que más pide</div>
        <div class="value" id="kpi-top-dept">—</div>
        <div class="trend up" id="kpi-top-dept-trend">+0%</div>
      </div>
    </div>

    <div class="users-toolbar">
      <div class="search" role="search">
        <svg width="16" height="16" viewBox="0 0 24 24" aria-hidden="true"><path fill="currentColor" d="M21 21l-4.3-4.3m1.6-5.1A7.2 7.2 0 1 1 3 11.6a7.2 7.2 0 0 1 15.3 0Z"/></svg>
        <input type="search" placeholder="Buscar usuario (nombre, reloj, área)…" aria-label="Buscar usuario" />
      </div>
      <span class="pill"><strong>Total registros:</strong> <span id="users-total">—</span></span>
    </div>

    <div class="table-wrap">
      <div class="table-scroll">
        <table class="users-table" role="table" aria-label="Tabla de uso (mock)">
          <thead>
            <tr>
              <th># Reloj</th>
              <th>Nombre</th>
              <th>Área</th>
              <th>Solicitudes</th>
              <th>Tiempo usado (hrs)</th>
              <th>Estado</th>
            </tr>
          </thead>
          <tbody id="users-body">
            <tr><td>00123</td><td>Maria López</td><td>Producción</td><td>18</td><td>42.5</td><td><span class="badge">Activo</span></td></tr>
            <tr><td>00456</td><td>Carlos Pérez</td><td>Mantenimiento</td><td>22</td><td>51.0</td><td><span class="badge">Activo</span></td></tr>
            <tr><td>00789</td><td>Ana Torres</td><td>Calidad</td><td>11</td><td>25.0</td><td><span class="badge">Suspendido</span></td></tr>
          </tbody>
        </table>
      </div>
    </div>

    <div class="charts">
      <div class="chart-card">
        <div class="title">Top herramientas más solicitadas</div>
        <canvas id="chartTopTools" height="220" aria-label="Barras herramientas" role="img"></canvas>
      </div>
      <div class="chart-card">
        <div class="title">Usuarios con más solicitudes</div>
        <canvas id="chartTopUsers" height="220" aria-label="Barras usuarios" role="img"></canvas>
      </div>
      <div class="chart-card">
        <div class="title">Departamentos que más solicitan</div>
        <canvas id="chartTopDepts" height="220" aria-label="Barras departamentos" role="img"></canvas>
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

          const users = [
              { reloj: "00123", nombre: "Maria López", area: "Producción", puesto: "Operadora", turno: "A", solicitudes: 18, horas: 42.5 },
              { reloj: "00456", nombre: "Carlos Pérez", area: "Mantenimiento", puesto: "Técnico", turno: "B", solicitudes: 22, horas: 51.0 },
              { reloj: "00789", nombre: "Ana Torres", area: "Calidad", puesto: "Inspectora", turno: "A", solicitudes: 11, horas: 25.0 },
              { reloj: "00234", nombre: "Luis Díaz", area: "Producción", puesto: "Operador", turno: "C", solicitudes: 26, horas: 63.2 },
              { reloj: "00999", nombre: "Karla Ruiz", area: "Toolcrib", puesto: "Almacén", turno: "B", solicitudes: 17, horas: 38.7 }
          ];
          const tools = [
              { tool: "Desarmador Philips", times: 35, depto: "Mantenimiento" },
              { tool: "Llave 10mm", times: 42, depto: "Producción" },
              { tool: "Taladro", times: 27, depto: "Producción" },
              { tool: "Multímetro", times: 18, depto: "Mantenimiento" },
              { tool: "Pulidora", times: 14, depto: "Calidad" }
          ];

          const reloj = document.getElementById('reloj');
          reloj.addEventListener('input', () => {
              const u = users.find(x => x.reloj.startsWith(reloj.value.trim()));
              document.getElementById('outNombre').value = u ? u.nombre : "";
              document.getElementById('outDepto').value = u ? u.area : "";
              document.getElementById('outPuesto').value = u ? u.puesto : "";
              document.getElementById('outTurno').value = u ? u.turno : "";

              if (u) {
                  document.getElementById('relojPrestamo').value = u.reloj;
                  document.getElementById('nombrePrestamo').value = u.nombre;
                  document.getElementById('deptoPrestamo').value = u.area;
              }
          });

      
          document.getElementById('btn-registrar').addEventListener('click', () => {
              alert('Préstamo registrado (demo). Integra tu lógica con BD aquí.');
          });
          document.getElementById('btn-cancel').addEventListener('click', () => show('buscar'));

       
          const topUser = [...users].sort((a, b) => b.solicitudes - a.solicitudes)[0];
          const topTool = [...tools].sort((a, b) => b.times - a.times)[0];
          const deptCount = tools.reduce((acc, t) => { acc[t.depto] = (acc[t.depto] || 0) + t.times; return acc; }, {});
          const topDept = Object.entries(deptCount).sort((a, b) => b[1] - a[1])[0];

          document.getElementById('kpi-top-user').textContent = topUser ? topUser.nombre : '—';
          document.getElementById('kpi-top-tool').textContent = topTool ? topTool.tool : '—';
          document.getElementById('kpi-top-dept').textContent = topDept ? topDept[0] : '—';
          document.getElementById('users-total').textContent = users.length.toString();

          const cs = getComputedStyle(document.documentElement);
          const gridColor = cs.getPropertyValue('--card-border').trim() || 'rgba(148,163,184,.3)';
          const labelColor = cs.getPropertyValue('--card-fg').trim() || '#0f172a';
          const accentA = cs.getPropertyValue('--accent-a').trim() || '#2563eb';
          const accentB = cs.getPropertyValue('--accent-b').trim() || '#22c55e';
          const accentC = cs.getPropertyValue('--accent-c').trim() || '#eab308';

          new Chart(document.getElementById('chartTopTools').getContext('2d'), {
              type: 'bar',
              data: {
                  labels: tools.map(t => t.tool),
                  datasets: [{ label: 'Solicitudes', data: tools.map(t => t.times), borderWidth: 1, backgroundColor: accentA, borderColor: accentA }]
              },
              options: {
                  responsive: true,
                  plugins: { legend: { labels: { color: labelColor } }, tooltip: { enabled: true } },
                  scales: {
                      x: { ticks: { color: labelColor }, grid: { color: gridColor } },
                      y: { beginAtZero: true, ticks: { color: labelColor }, grid: { color: gridColor } }
                  }
              }
          });

        
          const topUsers = [...users].sort((a, b) => b.solicitudes - a.solicitudes).slice(0, 5);
          new Chart(document.getElementById('chartTopUsers').getContext('2d'), {
              type: 'bar',
              data: {
                  labels: topUsers.map(u => u.nombre.split(' ')[0]),
                  datasets: [{ label: 'Solicitudes', data: topUsers.map(u => u.solicitudes), borderWidth: 1, backgroundColor: accentB, borderColor: accentB }]
              },
              options: {
                  responsive: true,
                  plugins: { legend: { labels: { color: labelColor } }, tooltip: { enabled: true } },
                  scales: {
                      x: { ticks: { color: labelColor }, grid: { color: gridColor } },
                      y: { beginAtZero: true, ticks: { color: labelColor }, grid: { color: gridColor } }
                  }
              }
          });

          
          const deptLabels = Object.keys(deptCount);
          const deptValues = Object.values(deptCount);
          new Chart(document.getElementById('chartTopDepts').getContext('2d'), {
              type: 'bar',
              data: {
                  labels: deptLabels,
                  datasets: [{ label: 'Solicitudes', data: deptValues, borderWidth: 1, backgroundColor: accentC, borderColor: accentC }]
              },
              options: {
                  responsive: true,
                  plugins: { legend: { labels: { color: labelColor } }, tooltip: { enabled: true } },
                  scales: {
                      x: { ticks: { color: labelColor }, grid: { color: gridColor } },
                      y: { beginAtZero: true, ticks: { color: labelColor }, grid: { color: gridColor } }
                  }
              }
          });

         
          const now = new Date();
          document.getElementById('fecha').value = now.toISOString().slice(0, 10);
          document.getElementById('hora').value = now.toTimeString().slice(0, 5);
      })();
  </script>

</asp:Content>
