using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.ServicePedido;

namespace Portal.Consultoras.Web.WebPages
{
    public partial class BloqueoPedidoImp : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string parametros = Request.QueryString["parametros"];
            string param = Util.DesencriptarQueryString(parametros);
            string[] lst = param.Split(new char[] { ';' });

            string CodigoConsultora = lst[0].ToString();
            string Nombres = lst[1].ToString();
            string Direccion = lst[2].ToString();
            string CodigoTerritorio = lst[3].ToString();
            string PedidoID = lst[4].ToString();
            int PaisID = Convert.ToInt32(lst[10]);
            string Usuario = lst[11];

            string TotalImporte = lst[15];

            imgBandera.ImageUrl = "../Content/Banderas/" + lst[12];
            imgLogoResponde.ImageUrl = "../Content/Images/logo_responde_" + lst[12];
            lblNombrePais.Text = lst[13];
            lblUsuario.Text = Usuario;
            lbCodigoConsultora.Text = CodigoConsultora;
            lbCodigoTerritorio.Text = CodigoTerritorio;
            lbDireccion.Text = Direccion;
            lbNombres.Text = Nombres;
            lbTotalImporte.Text = TotalImporte;

            StringBuilder sb = new StringBuilder();
            sb.Append("<table>");
            sb.Append("<thead><tr><th>Cod. Venta</th><th>Descripción</th><th>Cantidad</th><th>Precio Unitario</th><th>Precio Total</th></tr></thead>");
            sb.Append("<tbody>");
            List<BEPedidoWebDetalle> lista;
            using (PedidoServiceClient srv = new PedidoServiceClient())
            {
                lista = srv.SelectDetalleBloqueoPedidoByPedidoId(PaisID, Convert.ToInt32(PedidoID)).ToList();
            }
            foreach (var item in lista)
            {
                if (item.PedidoDetalleIDPadre == 0)
                {
                    sb.Append("<tr>");
                    sb.Append("<td>" + item.CUV + "</td>");
                    sb.Append("<td>" + item.DescripcionProd + "</td>");
                    sb.Append("<td><center>" + item.Cantidad + "</center></td>");
                    if (PaisID == 4)
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
            lbTotalImporte.Text = TotalImporte;
        }
    }
}