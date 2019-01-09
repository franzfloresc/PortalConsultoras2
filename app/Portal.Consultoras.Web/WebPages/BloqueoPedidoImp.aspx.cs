using Portal.Consultoras.Common;
using Portal.Consultoras.Web.ServicePedido;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web.UI.WebControls;

namespace Portal.Consultoras.Web.WebPages
{
    public partial class BloqueoPedidoImp : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string parametros = Request.QueryString["parametros"];
            string param = Util.DesencriptarQueryString(parametros);
            string[] lst = param.Split(';');

            string codigoConsultora = lst[0];
            string nombres = lst[1];
            string direccion = lst[2];
            string codigoTerritorio = lst[3];
            string pedidoId = lst[4];
            int paisId = Convert.ToInt32(lst[10]);
            string usuario = lst[11];

            string totalImporte = lst[15];

            imgBandera.ImageUrl = "../Content/Banderas/" + lst[12];
            imgLogoResponde.ImageUrl = "../Content/Images/logo_responde_" + lst[12];
            lblNombrePais.Text = lst[13];
            lblUsuario.Text = usuario;
            lbCodigoConsultora.Text = codigoConsultora;
            lbCodigoTerritorio.Text = codigoTerritorio;
            lbDireccion.Text = direccion;
            lbNombres.Text = nombres;
            lbTotalImporte.Text = totalImporte;

            StringBuilder sb = new StringBuilder();
            sb.Append("<table>");
            sb.Append("<thead><tr><th>Cod. Venta</th><th>Descripción</th><th>Cantidad</th><th>Precio Unitario</th><th>Precio Total</th></tr></thead>");
            sb.Append("<tbody>");
            List<BEPedidoWebDetalle> lista;
            using (PedidoServiceClient srv = new PedidoServiceClient())
            {
                lista = srv.SelectDetalleBloqueoPedidoByPedidoId(paisId, Convert.ToInt32(pedidoId)).ToList();
            }
            foreach (var item in lista)
            {
                if (item.PedidoDetalleIDPadre == 0)
                {
                    sb.Append("<tr>");
                    sb.Append("<td>" + item.CUV + "</td>");
                    sb.Append("<td>" + item.DescripcionProd + "</td>");
                    sb.Append("<td><center>" + item.Cantidad + "</center></td>");
                    if (paisId == Constantes.PaisID.Colombia)
                    {
                        sb.Append("<td>" + Convert.ToDecimal(item.PrecioUnidad).ToString("#,##0").Replace(',', '.') + "</td>");
                        sb.Append("<td>" + Convert.ToDecimal(item.ImporteTotal).ToString("#,##0").Replace(',', '.') + "</td>");
                    }
                    else
                    {
                        sb.Append("<td>" + Convert.ToDecimal(item.PrecioUnidad).ToString("0.00") + "</td>");
                        sb.Append("<td>" + Convert.ToDecimal(item.ImporteTotal).ToString("0.00") + "</td>");
                    }
                }
            }
            sb.Append("</tbody>");
            sb.Append("</table>");

            lTabla.Text = sb.ToString();
            lbTotalImporte.Text = totalImporte;
        }
    }
}