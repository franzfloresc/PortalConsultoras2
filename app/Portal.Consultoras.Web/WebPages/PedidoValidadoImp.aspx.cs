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
    public partial class PedidoValidadoImp : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string parametros = Request.QueryString["parametros"];
            List<BEPedidoWebDetalle> olstPedidoWebDetalle = new List<BEPedidoWebDetalle>();
            string param = Util.DesencriptarQueryString(parametros);
            string[] lista = param.Split(new char[] { ';' });
            string PaisID = lista[0];
            string CampaniaID = lista[1];
            string ConsultoraID = lista[2];

            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                olstPedidoWebDetalle = sv.SelectByPedidoValidado(Convert.ToInt32(PaisID), Convert.ToInt32(CampaniaID), Convert.ToInt64(ConsultoraID), lista[4]).ToList();
            }

            
            lblSimbolo.Text = lista[3];
            lblTotal.Text = string.Format("{0:N2}", olstPedidoWebDetalle.Where(p => p.PedidoDetalleIDPadre == 0).Sum(p => p.ImporteTotal));
            lblUsuario.Text = "Hola, " + lista[4];
            imgBandera.ImageUrl = "../Content/Banderas/" + lista[5];
            imgLogoResponde.ImageUrl = "../Content/Images/logo_responde_" + lista[5];
            lblNombrePais.Text = lista[6];

            StringBuilder sb = new StringBuilder();
            sb.Append("<table>");
            sb.Append("<thead><tr><th>Codigo</th><th>Producto</th><th>Cantidad</th><th>Precio Unitario</th><th>Precio Total</th><th>Cliente</th></tr></thead>");
            sb.Append("<tbody>");
            foreach (var item in olstPedidoWebDetalle)
            {
                if (item.PedidoDetalleIDPadre == 0)
                {
                    sb.Append("<tr>");
                    sb.Append("<td>" + item.CUV + "</td>");
                    sb.Append("<td>" + item.DescripcionProd + "</td>");
                    sb.Append("<td><span>" + item.Cantidad + "</span></td>");
                    sb.Append("<td><span style='vertical-align: super; font-size:small;'>" + lista[3] + "</span>");
                    sb.Append("<span>" + string.Format("{0:N2}",item.PrecioUnidad) + "</span></td>");
                    sb.Append("<td><span style='vertical-align: super; font-size:small;'>" + lista[3] + "</span>");
                    sb.Append("<span>" + string.Format("{0:N2}",item.ImporteTotal) + "</span></td>");
                    sb.Append("<td class='center'>" + item.Nombre + "</td>");
                }
            }
            sb.Append("</tbody>");
            sb.Append("</table>");

            lTabla.Text = sb.ToString();
        }
    }
}