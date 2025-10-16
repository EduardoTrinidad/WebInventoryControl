<%@ Page Language="C#" AutoEventWireup="true" %>

<!DOCTYPE html>
<html lang="es">

<head runat="server">
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Login Bootstrap</title>

  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet" />
  <link href="~/Content/pages/login.css" rel="stylesheet" />
</head>

<body>

  <nav class="navbar navbar-expand-lg navbar-custom">
    <div class="container-fluid">
      <a class="navbar-brand" href="#">Toolcrib</a>
      <button id="themeToggle" type="button" title="Cambiar tema">
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

                <div class="col-lg-6">
                  <div class="card-body p-md-5 mx-md-4">

                    <div class="text-center">
                      <img class="login-logo"
                        src="https://www.empleonuevo.com/space/public/companies/logos/57311a6cdecbd.jpg"
                        alt="logo">
                      <h4 class="mt-3 mb-4 pb-1 brand-title">Jones Painting & Hydrographic</h4>
                    </div>

                    <asp:Label ID="lblMensaje" runat="server" ForeColor="Red" />

                    <div class="form-outline mb-3">
                      <asp:TextBox ID="txtEmail" runat="server"
                        CssClass="form-control"
                        Placeholder="correo@ejemplo.com"
                        TextMode="Email" />
                    </div>

                    <div class="form-outline mb-4">
                      <asp:TextBox ID="txtPassword" runat="server"
                        CssClass="form-control"
                        Placeholder="Contraseña"
                        TextMode="Password" />
                    </div>

                    <div class="text-center pt-1 mb-4">
                      <asp:Button ID="btnIngresar" runat="server"
                        Text="Ingresar"
                        CssClass="btn btn-primary btn-block fa-lg gradient-custom-2 mb-3"
                        OnClick="btnIngresar_Click" />
                    </div>

                  </div>
                </div>

                <div class="col-lg-6 d-flex align-items-center gradient-custom-2">
                  <div class="text-white px-3 py-4 p-md-5 mx-md-4">

                    <h4 class="mb-4">We are more than just a comp</h4>

                    <p class="small mb-0">
                      Jones Plastic es conocido no solo por nuestra experiencia en moldeo,
                      como ser pioneros en el uso de asistencia de gas,
                      moldeo de alta velocidad a principios de los 90,
                      sino también por nuestra capacidad de ayudar a los clientes a comercializar
                      sus productos rápidamente.
                      <br /><br />
                      Con instalaciones en Kentucky, Tennessee y tres ubicaciones en México,
                      Monterrey, Juárez y Juarez Painting and Hydrographics,
                      estamos ubicados estratégicamente para ayudar a minimizar los costos de flete,
                      manipulación y mano de obra para nuestros clientes.
                      <br /><br />
                      Jones Plastic and Engineering emplea a 2400 empleados en todo el mundo
                      y nuestras plantas comprenden casi 1,000,000 de pies cuadrados.
                      <br /><br />
                      La compañía celebró con orgullo su 50 aniversario en 2011
                      con 3 generaciones de familiares activos en la organización.
                    </p>

                  </div>
                </div>

              </div>
            </div>
          </div>
        </div>
      </div>

    </section>

  </form>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

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

  <script runat="server">
    protected void btnIngresar_Click(object sender, EventArgs e)
    {
        string email = txtEmail.Text.Trim();
        string password = txtPassword.Text.Trim();

        if (email == "admin@admin.com" && password == "1234")
        {
            Response.Redirect("Inicio.aspx");
        }
        else
        {
            lblMensaje.Text = "Correo o contraseña incorrectos.";
        }
    }
  </script>

</body>
</html>
