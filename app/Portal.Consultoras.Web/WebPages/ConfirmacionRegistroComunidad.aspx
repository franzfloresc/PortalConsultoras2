<%@ Page Title="" Language="C#" MasterPageFile="~/WebPages/MasterComunidad.Master" AutoEventWireup="true" CodeBehind="ConfirmacionRegistroComunidad.aspx.cs" Inherits="Portal.Consultoras.Web.WebPages.ConfirmacionRegistroComunidad" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:HiddenField ID="hdfUsuario" runat="server" ClientIDMode="Static"/>
    <asp:HiddenField ID="hdfTipo" runat="server" ClientIDMode="Static"/>
    <asp:HiddenField ID="hdfPaisId" runat="server" ClientIDMode="Static"/>
    <asp:HiddenField ID="hdfUsuarioSB" runat="server" ClientIDMode="Static"/>
    <div>
        <div class="webFormMessage">
        </div>
        <div class="webFormMessage">
        </div>
        <div class="webFormMessage">
            <p>
                Tu cuenta ha sido creada con éxito. 
            </p>
            <p>
                ¡Ya eres parte de nuestra comunidad!
            </p>
        </div>
        <div class="webFormMessage">
            <div class="formbtn">
                <asp:Button ID="btnIngreso" Text="INGRESA AQUI" CssClass="btnCrear" runat="server" OnClick="btnIngreso_Click" />
            </div>
        </div>
    </div>
</asp:Content>
