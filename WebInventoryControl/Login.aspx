<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="WebInventoryControl.Login" %>

<!DOCTYPE html>
<html lang="es">
<head runat="server">
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Login — ToolCrib</title>

  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet" />
  <link href="<%= ResolveUrl("~/Content/pages/login.css") %>" rel="stylesheet" />

  <style>
    :root { --accent:#2A7B9B; }
    .navbar-custom{background:#0f172a;color:#fff}
    .navbar-custom .navbar-brand{color:#fff}
    .login-min-height{min-height:calc(100vh - 56px)}
    .card.rounded-3{box-shadow:0 12px 28px rgba(2,6,23,.10)}
    .gradient-custom-2{background:linear-gradient(135deg,var(--accent),#57C785)}
    .brand-title{color:#0f172a}
    .login-logo{height:64px}
    .muted{color:#64748b}
    #msg{min-height:1.25rem}
    body.dark-mode{background:#0b1220;color:#e5e7eb}
    body.dark-mode .navbar-custom{background:#020617}
    body.dark-mode .card{background:#0b1220;color:#e5e7eb;border-color:#1f2937}
    body.dark-mode .brand-title{color:#e5e7eb}
  </style>
</head>

<body>
  <nav class="navbar navbar-expand-lg navbar-custom">
    <div class="container-fluid">
      <a class="navbar-brand" href="#">Toolcrib</a>
      <button id="themeToggle" type="button" class="btn btn-sm btn-outline-light" title="Cambiar tema">
        <i class="bi bi-moon-stars-fill"></i>
      </button>
    </div>
  </nav>

  <form id="form1" runat="server">
    <section class="login-min-height gradient-form">
      <div class="container py-5 h-100">
        <div class="row d-flex justify-content-center align-items-center h-100">
          <div class="col-xl-10">
            <div class="card rounded-3">
              <div class="row g-0">

                <!-- Columna: Formulario -->
                <div class="col-lg-6">
                  <div class="card-body p-md-5 mx-md-4">
                    <div class="text-center">
                      <img class="login-logo"
                           src="https://www.empleonuevo.com/space/public/companies/logos/57311a6cdecbd.jpg"
                           alt="logo">
                      <h4 class="mt-3 mb-4 pb-1 brand-title">Jones Painting &amp; Hydrographic</h4>
                    </div>

                    <!-- Mensajes -->
                    <div id="msg" class="small muted mb-2"></div>

                    <!-- # Reloj -->
                    <div class="form-outline mb-3">
                      <input id="reloj" class="form-control" type="text" placeholder="# Reloj (ej. 1564)" />
                    </div>

                    <!-- Contraseña -->
                    <div class="form-outline mb-4">
                      <input id="pwd" class="form-control" type="password" placeholder="Contraseña" />
                    </div>

                    <div class="text-center pt-1 mb-4 d-grid">
                      <button id="btnLogin" type="button"
                              class="btn btn-primary btn-block fa-lg gradient-custom-2">
                        Ingresar
                      </button>
                    </div>
                  </div>
                </div>

                <!-- Columna: Texto corporativo -->
                <div class="col-lg-6 d-flex align-items-center gradient-custom-2">
                  <div class="text-white px-3 py-4 p-md-5 mx-md-4">
                    <h4 class="mb-4">We are more than just a comp</h4>
                    <p class="small mb-0">
                      Jones Plastic es conocido no solo por nuestra experiencia en moldeo, como ser pioneros en el uso
                      de asistencia de gas, moldeo de alta velocidad a principios de los 90, sino también por nuestra
                      capacidad de ayudar a los clientes a comercializar sus productos rápidamente.
                      <br /><br />
                      Con instalaciones en Kentucky, Tennessee y tres ubicaciones en México, Monterrey, Juárez y Juarez
                      Painting and Hydrographics, estamos ubicados estratégicamente para ayudar a minimizar los costos
                      de flete, manipulación y mano de obra para nuestros clientes.
                      <br /><br />
                      Jones Plastic and Engineering emplea a 2400 empleados en todo el mundo y nuestras plantas
                      comprenden casi 1,000,000 de pies cuadrados.
                      <br /><br />
                      La compañía celebró con orgullo su 50 aniversario en 2011 con 3 generaciones de familiares activos
                      en la organización.
                    </p>
                  </div>
                </div>

              </div><!-- row -->
            </div><!-- card -->
          </div>
        </div>
      </div>
    </section>
  </form>

  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

  <!-- Tema oscuro (igual que tu snippet) -->
  <script>
      (function () {
          const themeToggle = document.getElementById('themeToggle');
          const body = document.body;

          document.addEventListener('DOMContentLoaded', () => {
              const saved = localStorage.getItem('theme');
              if (saved === 'dark') {
                  body.classList.add('dark-mode');
                  swapIcon(true);
              }
          });

          themeToggle.addEventListener('click', () => {
              const toDark = !body.classList.contains('dark-mode');
              body.classList.toggle('dark-mode', toDark);
              localStorage.setItem('theme', toDark ? 'dark' : 'light');
              swapIcon(toDark);
          });

          function swapIcon(isDark) {
              const i = themeToggle.querySelector('i');
              if (!i) return;
              i.classList.toggle('bi-sun-fill', isDark);
              i.classList.toggle('bi-moon-stars-fill', !isDark);
          }
      })();
  </script>

  <!-- Login contra API -->
  <script>
    (function () {
      const API = "https://localhost:7059/api/auth"; // <-- AJUSTA si tu API tiene otro host/puerto
      const $reloj = $("#reloj");
      const $pwd   = $("#pwd");
      const $btn   = $("#btnLogin");
      const $msg   = $("#msg");

      function canon(s){ return String(s||"").toLowerCase().replace(/[^a-z0-9]/g,""); }
      function pick(obj, names){
        if(!obj) return null;
        const m = new Map();
        Object.keys(obj).forEach(k => m.set(canon(k), obj[k]));
        for(const n of names){
          const v = m.get(canon(n));
          if(v !== undefined && v !== null) return v;
        }
        return null;
      }

      $btn.on("click", function () {
        const reloj = $reloj.val().trim();
        const pwd   = $pwd.val().trim();

        if(!reloj || !pwd){
          $msg.text("Ingresa tus credenciales.");
          return;
        }
        $msg.text("Validando…");

        $.ajax({
          url: API + "/login",
          method: "POST",
          contentType: "application/json",
          xhrFields: { withCredentials: true }, // útil si usas cookies/sesión
          data: JSON.stringify({
            Num_Reloj_Empleado: reloj,
            Contrasena: pwd // el backend también acepta "Contraseña"
          })
        })
        .done(function (data) {
          const user = {
            Num_Reloj_Empleado: pick(data, ["Num_Reloj_Empleado"]) || reloj,
            Nombre_Empleado:    pick(data, ["Nombre_Empleado"])    || "",
            Dpto_Empleado:      pick(data, ["Dpto_Empleado"])      || "",
            Puesto_Empleado:    pick(data, ["Puesto_Empleado"])    || ""
          };
          sessionStorage.setItem("toolcrib_user", JSON.stringify(user));
          $msg.text("");
          window.location.href = "<%= ResolveUrl("~/Inicio.aspx") %>";
        })
              .fail(function (xhr) {
                  const m = xhr?.responseJSON?.message || xhr?.statusText || "Usuario o contraseña incorrectos.";
                  $msg.text(m);
              });
      });

          // Enter para enviar
          $("#reloj,#pwd").on("keydown", function (e) {
              if (e.key === "Enter") { e.preventDefault(); $btn.click(); }
          });
      })();
  </script>
</body>
</html>
