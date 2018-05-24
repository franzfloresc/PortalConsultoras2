using Portal.Consultoras.Common;
using Portal.Consultoras.Web.ServicePedido;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web.UI.WebControls;

namespace Portal.Consultoras.Web.WebPages
{
    public partial class PedidoValidadoImp : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string parametros = Request.QueryString["parametros"];
            string param = Util.DesencriptarQueryString(parametros);
            string[] lista = param.Split(';');
            string paisId = lista[0];
            string campaniaId = lista[1];
            string consultoraId = lista[2];

            Converter<decimal, string> moneyToString;
            if (paisId == "4") moneyToString = new Converter<decimal, string>(p => p.ToString("n0", new System.Globalization.CultureInfo("es-CO")));
            else moneyToString = new Converter<decimal, string>(p => p.ToString("n2", new System.Globalization.CultureInfo("es-PE")));

            List<BEPedidoWebDetalle> olstPedidoWebDetalle;
            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                olstPedidoWebDetalle = sv.SelectByPedidoValidado(Convert.ToInt32(paisId), Convert.ToInt32(campaniaId), Convert.ToInt64(consultoraId), lista[4]).ToList();
            }
                        
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
                    sb.Append("<span>" + moneyToString(item.PrecioUnidad) + "</span></td>");
                    sb.Append("<td><span style='vertical-align: super; font-size:small;'>" + lista[3] + "</span>");
                    sb.Append("<span>" + moneyToString(item.ImporteTotal) + "</span></td>");
                    sb.Append("<td class='center'>" + item.Nombre + "</td>");
                }
            }
            sb.Append("</tbody>");
            sb.Append("</table>");
            lTabla.Text = sb.ToString();

            string simbolo = lista[3];
            bool estadoSimplificacionCuv = (lista[7] == "1");
            decimal total;

            if(estadoSimplificacionCuv &&
                olstPedidoWebDetalle.Any(item => string.IsNullOrEmpty(item.ObservacionPROL) && item.IndicadorOfertaCUV))
            {
                var subtotal = olstPedidoWebDetalle.Where(p => p.PedidoDetalleIDPadre == 0).Sum(p => p.ImporteTotal);
                var descuento = -olstPedidoWebDetalle[0].DescuentoProl;
                total = subtotal + descuento;
                                
                sb = new StringBuilder();
                sb.Append("<div class='subTotalPROL' style='width:700px;'> SubTotal: " + simbolo + moneyToString(subtotal) + " </div>");
                sb.Append("<div class='leyendaIndicadorPROL' style='width:700px;'>Descuento por ofertas con más de un precio" + simbolo + moneyToString(descuento) + " </div>");
                sb.Append("<div style='clear:both;'></div>");
                lDescuentoCuv.Text = sb.ToString();
            }
            else total = olstPedidoWebDetalle.Where(p => p.PedidoDetalleIDPadre == 0).Sum(p => p.ImporteTotal);
            
            lblSimbolo.Text = simbolo;
            lblTotal.Text = moneyToString(total);
        }
    }
}