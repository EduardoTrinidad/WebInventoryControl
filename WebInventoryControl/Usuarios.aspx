<%@ Page Title="Usuarios" Language="C#"
    MasterPageFile="~/Site.master"
    AutoEventWireup="true"
    CodeBehind="Usuarios.aspx.cs"
    Inherits="WebInventoryControl.Usuarios" %>

<asp:Content ID="HeadUsuarios" ContentPlaceHolderID="HeadContent" runat="server">
      <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
<link href="<%= ResolveUrl("~/Content/pages/usuario.css") %>" rel="stylesheet" />

  <script>

      document.addEventListener('DOMContentLoaded', function () {
          var lbl = document.getElementById('clientTime');
          if (lbl) { lbl.textContent = "Cliente: " + new Date().toLocaleString(); }
      });
  </script>
</asp:Content>

<asp:Content ID="MainUsuarios" ContentPlaceHolderID="MainContent" runat="server">
  <div class="wrap">
    <div class="card">
      <div class="card-header">
        <div>
          <div class="title">Usuarios · Prestamo de herramienta</div>
         
        </div>
        <div class="subtle">
          <span id="clientTime">Cliente: --/--/---- --:--</span>
        </div>
      </div>

      <div class="card-body grid grid-2">
    
        <div>
          <div class="field">
            <label class="label">Número de reloj</label>
            <asp:TextBox ID="txtClockNumber" runat="server" CssClass="input mono" placeholder="Ej. 1564" MaxLength="16"></asp:TextBox>
          </div>
          <div class="btns" style="margin-top:10px;">
          
            <asp:Button ID="btnSearch" runat="server" Text="Buscar usuario" CssClass="btn primary" UseSubmitBehavior="false" />
            <asp:Button ID="btnClear" runat="server" Text="Limpiar" CssClass="btn ghost" UseSubmitBehavior="false" />
          </div>

          <div class="hr"></div>

          <div class="user-card" style="margin-top:10px;">
            <img class="avatar" src="~/assets/avatar-placeholder.png" alt="Avatar" /> 
            <div class="user-lines">
              <span class="user-name">Eduardo Trinidad</span>
              <span class="user-meta">
                Reloj: <span class="mono">1564</span> ·
                Depto: Producción ·
                Puesto: Operador
              </span>
              <span class="muted">WWID: <span class="mono">1564</span></span>
            </div>
          </div>

         
        </div>
        <div>
          <div class="field">
            <label class="label">ID de pieza a retirar</label>
            <asp:TextBox ID="txtPartId" runat="server" CssClass="input mono" placeholder="Ej. PZA-001234" MaxLength="32"></asp:TextBox>
          </div>

          <div class="field" style="margin-top:10px;">
            <label class="label">Cantidad</label>
            <asp:TextBox ID="txtQty" runat="server" CssClass="input mono" TextMode="Number" Text="1" />
          </div>

          <div class="field" style="margin-top:10px;">
            <label class="label">Comentario (opcional)</label>
            <asp:TextBox ID="txtNote" runat="server" CssClass="input" TextMode="MultiLine" Rows="2" placeholder="Ej. Entrega para línea 3"></asp:TextBox>
          </div>

         
          <asp:HiddenField ID="hdnUserId" runat="server" />
          <asp:HiddenField ID="hdnClientTime" runat="server" />

          <div class="btns" style="margin-top:12px;">

            <asp:Button ID="btnRegister" runat="server" Text="Registrar retiro" CssClass="btn warn" UseSubmitBehavior="false" />
          </div>

        </div>
      </div>

   
      <div class="card-body">
        <div style="display:flex; align-items:center; justify-content:space-between; margin-bottom:6px;">
          <div class="title" style="font-size:16px;">Últimos movimientos</div>
        </div>

        <table class="tidy">
          <thead>
            <tr>
              <th>Fecha/Hora (Local)</th>
              <th>Reloj</th>
              <th>Usuario</th>
              <th>ID Pieza</th>
              <th>Cant.</th>
              <th>Nota</th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td>2025-09-10 08:15</td>
              <td class="mono">123456</td>
              <td>Jaime Galaviz</td>
              <td class="mono">PZA-001234</td>
              <td>1</td>
              <td>Entrega para línea 3</td>
            </tr>
            <tr>
              <td>2025-09-10 08:03</td>
              <td class="mono">654321</td>
              <td>Daniel Peña</td>
              <td class="mono">PZA-009876</td>
              <td>2</td>
              <td>Préstamo temporal</td>
            </tr>
            <tr>
              <td>2025-09-09 17:40</td>
              <td class="mono">112233</td>
              <td>Ana Ruiz</td>
              <td class="mono">PZA-000111</td>
              <td>1</td>
              <td>Urgente mantenimiento</td>
            </tr>
          </tbody>
        </table>

      </div>
    </div>
  </div>
</asp:Content>
