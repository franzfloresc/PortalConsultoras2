using Portal.Consultoras.Common;
using Portal.Consultoras.Web.ServicePedido;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web.UI.WebControls;

namespace Portal.Consultoras.Web.WebPages
{
    public partial class ReportePedidoDDWebDetalleImp : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string parametros = Request.QueryString["parametros"];
            string param = Util.DesencriptarQueryString(parametros);
            string[] lst = param.Split(new char[] { ';' });
            string paisIso = lst[0];
            string campaniaCod = lst[1];
            string consultoraCod = lst[2];
            string consultoraNombre = lst[3];
            string origen = lst[5];
            string validado = lst[6];
            string saldo = lst[7];
            string importe = lst[8];
            string importeConDescuento = lst[9];
            string usuario = lst[14];
            string simbolo = lst[15];
            string tipoProceso = lst[18];
            string motivoRechazo = lst[20];
            int paisId = Convert.ToInt32(lst[19]);

            Usuario.Text = usuario;
            lblCampaniaCod.Text = campaniaCod;
            lblConsultoraCod.Text = consultoraCod;
            lblConsultoraNombre.Text = consultoraNombre;
            lblOrigen.Text = origen;
            lblValidado.Text = validado;
            lblSaldo.Text = saldo;
            lblMotivoRechazo.Text = motivoRechazo;
            lblImporte.Text = importe;
            lblImporteConDescuento.Text = importeConDescuento;

            List<BEPedidoDDWebDetalle> lstPedidosDdWebNoFacturados;
            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                lstPedidosDdWebNoFacturados = sv.GetPedidosWebDDNoFacturadosDetalle(paisId, paisIso, Convert.ToInt32(campaniaCod), consultoraCod, tipoProceso).ToList();
            }

            var lstDetalle = (from c in lstPedidosDdWebNoFacturados
                where !string.IsNullOrEmpty(c.CUV.Trim())
                select new BEPedidoDDWebDetalle
                {
                    CUV = c.CUV,
                    Descripcion = c.Descripcion,
                    Cantidad = c.Cantidad,
                    PrecioUnitario = c.PrecioUnitario,
                    PrecioTotal = c.PrecioTotal
                }).ToList();
            

            imgBandera.ImageUrl = "../Content/Banderas/" + lst[15];
            imgLogoResponde.ImageUrl = "../Content/Images/logo_responde_" + lst[15];
            lblNombrePais.Text = lst[16];

            StringBuilder sb = new StringBuilder();
            sb.Append("<table>");
            sb.Append("<thead><tr><th>Cod. Venta</th><th>Descripción</th><th>Cantidad</th><th>Precio Unitario</th><th>Precio Total</th></tr></thead>");
            sb.Append("<tbody>");
            foreach (var item in lstDetalle)
            {
                sb.Append("<tr>");
                sb.Append("<td>" + item.CUV + "</td>");
                sb.Append("<td>" + item.Descripcion + "</td>");
                sb.Append("<td><span>" + item.Cantidad + "</span></td>");
                if (paisId == Constantes.PaisID.Colombia)
                {
                    sb.Append("<td>" + simbolo + " " + item.PrecioUnitario.ToString("#,##0").Replace(',','.') + "</td>");
                    sb.Append("<td>" + simbolo + " " + item.PrecioTotal.ToString("#,##0").Replace(',', '.') + "</td>");
                }
                else
                {
                    sb.Append("<td>" + simbolo + " " + item.PrecioUnitario.ToString("0.00") + "</td>");
                    sb.Append("<td>" + simbolo + " " + item.PrecioTotal.ToString("0.00") + "</td>");
                }
                sb.Append("</tr>");
            }
            sb.Append("</tbody>");
            sb.Append("</table>");

            lTabla.Text = sb.ToString();
        }
    }
}