<%@ Page Title="Proveedores" Language="C#"
    MasterPageFile="~/Site.master"
    AutoEventWireup="true"
    Inherits="System.Web.UI.Page" %>

<asp:Content ID="HeadProveedores" ContentPlaceHolderID="HeadContent" runat="server">
      <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
<link href="<%= ResolveUrl("~/Content/pages/provedores.css") %>" rel="stylesheet" />

</asp:Content>

<asp:Content ID="MainProveedores" ContentPlaceHolderID="MainContent" runat="server">
  <div class="wrap">
    <div class="card">
      <div class="card-header">
        <div class="title">Proveedores</div>
      </div>

      <div class="card-body">
        
        <div class="toolbar">
          <input type="text" class="input" placeholder="Buscar por nombre, ciudad, estado, país o teléfono…" />
          <button type="button" class="btn">Buscar</button>
          <button type="button" class="btn">Limpiar</button>
        </div>


        <div class="table-wrap">
          <table class="tidy">
            <thead>
              <tr>
                <th>Id proveedor</th>
                <th>Nombre</th>
                <th>Dirección</th>
                <th>Ciudad</th>
                <th>Estado/Provincia</th>
                <th>Código Postal</th>
                <th>País</th>
                <th>Teléfono</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td class="mono">5</td>
                <td>ABRASIVOS Y SOLDADURAS INDUSTRIALES</td>
                <td>Av. Tecnológica 123</td>
                <td>Cd. Juárez</td>
                <td>Chihuahua</td>
                <td class="mono">32500</td>
                <td>México</td>
                <td class="mono">656-555-0101</td>
              </tr>
              <tr>
                <td class="mono">6</td>
                <td>PRODUCTOS Y SERVICIOS BHP SA DE CV</td>
                <td>Calle Industria 456</td>
                <td>Cd. Juárez</td>
                <td>Chihuahua</td>
                <td class="mono">32400</td>
                <td>México</td>
                <td class="mono">656-555-0202</td>
              </tr>
              <tr>
                <td class="mono">7</td>
                <td>IMPULSORA DE SUMINISTROS Y</td>
                <td>Blvd. Principal 789</td>
                <td>Chihuahua</td>
                <td>Chihuahua</td>
                <td class="mono">31000</td>
                <td>México</td>
                <td class="mono">614-555-0303</td>
              </tr>
              <tr>
                <td class="mono">8</td>
                <td>FERRETERÍA DEL NORTE</td>
                <td>Calle 5 #321</td>
                <td>Monterrey</td>
                <td>Nuevo León</td>
                <td class="mono">64000</td>
                <td>México</td>
                <td class="mono">81-555-0404</td>
              </tr>
              <tr>
                <td class="mono">9</td>
                <td>GLOBAL TOOLS INC</td>
                <td>742 Evergreen Terrace</td>
                <td>El Paso</td>
                <td>Texas</td>
                <td class="mono">79901</td>
                <td>USA</td>
                <td class="mono">915-555-0505</td>
              </tr>
             
            </tbody>
          </table>
        </div>
      </div>
    </div>
  </div>
</asp:Content>
