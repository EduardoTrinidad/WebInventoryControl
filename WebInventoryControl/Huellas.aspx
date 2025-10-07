<%@ Page Title="Huellas" Language="C#"
    MasterPageFile="~/Site.master"
    AutoEventWireup="true"
    CodeBehind="Huellas.aspx.cs"
    Inherits="WebInventoryControl.Huellas" %>

<asp:Content ID="HeadHuellas" ContentPlaceHolderID="HeadContent" runat="server">

</asp:Content>

<asp:Content ID="BodyHuellas" ContentPlaceHolderID="MainContent" runat="server">
    <div class="huella-card">
        <div class="huella-icon">
            <i class="bi bi-fingerprint"></i>
        </div>
        <h3>Registro de Entradas</h3>
        <p>Coloca tu huella digital.</p>
        <asp:TextBox ID="txtHuella" runat="server" CssClass="form-control mb-3" placeholder="ID de empleado"></asp:TextBox>
        <asp:Button ID="btnCapturar" runat="server" CssClass="btn btn-primary w-100" Text="Capturar Huella" />
    </div>
</asp:Content>
