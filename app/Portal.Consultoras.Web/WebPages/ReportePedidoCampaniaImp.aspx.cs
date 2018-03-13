using Portal.Consultoras.Common;
using Portal.Consultoras.Web.ServiceOSBBelcorpPedido;
using Portal.Consultoras.Web.ServiceZonificacion;
using System;
using System.Text;
using System.Web.UI.WebControls;

namespace Portal.Consultoras.Web.WebPages
{
    public partial class ReportePedidoCampaniaImp : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                string parametros = Request.QueryString["parametros"];
            string param = Util.DesencriptarQueryString(parametros);
            string[] lista = param.Split(';');

            string paisddl = lista[0];
            string campaniaddl = lista[1];
            string regionddl = lista[2];
            string zonaddl = lista[3];
            string codConsultoratxt = lista[4];
            string paisddlVal = lista[5] == string.Empty ? "0" : lista[5];
            string campaniaddlVal = lista[6] == string.Empty ? "0" : lista[6];
            string regionddlVal = lista[7] == string.Empty ? "0" : lista[7];
            string zonaddlVal = lista[8] == string.Empty ? "0" : lista[8];
            string codConsultoratxtId = lista[9];
            string usuario = lista[10];
            string imagen = lista[11];
            string nombrePais = lista[12];

            lblNombrePais.Text = nombrePais;
            imgBandera.ImageUrl = "../Content/Banderas/" + imagen;
            imgLogoResponde.ImageUrl = "../Content/Images/logo_responde_" + imagen;
            lblUsuario.Text = usuario;
            txtCodigos.Text = codConsultoratxt;
            ddlCampania.Items.Add(new ListItem { Text = campaniaddl, Value = campaniaddlVal }); ddlCampania.SelectedIndex = 0;
            ddlPais.Items.Add(new ListItem { Text = paisddl, Value = paisddlVal }); ddlPais.SelectedIndex = 0;
            ddlRegion.Items.Add(new ListItem { Text = regionddl, Value = regionddlVal }); ddlRegion.SelectedIndex = 0;
            ddlZona.Items.Add(new ListItem { Text = zonaddl, Value = zonaddlVal }); ddlZona.SelectedIndex = 0;

            StringBuilder sb = new StringBuilder();
            sb.Append("<table>");
            sb.Append("<thead><tr><th>Cod. Consultora</th><th>Territorio</th><th>Cod. Venta</th><th>Cod. Producto</th><th>Unidades Demandadas</th><th>Monto Demandado</th><th>Cod. Tipo Oferta</th><th>Origen</th><th>Fecha Ult. Act.</th></tr></thead>");
            sb.Append("<tbody>");

            PedidoBS businessService = new PedidoBS();
            pedidoWebAnteriorDetalleBean[] listaE;

            BEPais bepais;
            using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
            {
                bepais = sv.SelectPais(Convert.ToInt32(paisddlVal));
            }

            if (regionddl == "" || regionddl == "-- Todas --") regionddl = "0";
            if (zonaddl == "" || zonaddl == "-- Todas --") zonaddl = "0";
            if (codConsultoratxtId == "") codConsultoratxtId = "0";
            string isows = string.Empty;

            if (bepais.CodigoISO.Equals("PE"))
                isows = "PE";
            else if (bepais.CodigoISO.Equals("CL"))
                isows = "CLE";
            else if (bepais.CodigoISO.Equals("EC"))
                isows = "ECL";
            else if (bepais.CodigoISO.Equals("BO"))
                isows = "BO";
            else if (bepais.CodigoISO.Equals("MX"))
                isows = "MXL";
            else if (bepais.CodigoISO.Equals("AR"))
                isows = "AR";
            else if (bepais.CodigoISO.Equals("CR"))
                isows = "CRL";
            else if (bepais.CodigoISO.Equals("SV"))
                isows = "SVE";
            else if (bepais.CodigoISO.Equals("PA"))
                isows = "PAL";
            else if (bepais.CodigoISO.Equals("GT"))
                isows = "GTE";
            else if (bepais.CodigoISO.Equals("PR"))
                isows = "PRL";
            else if (bepais.CodigoISO.Equals("DO"))
                isows = "DOL";
            else if (bepais.CodigoISO.Equals("VE"))
                isows = "VEL";
            else if (bepais.CodigoISO.Equals("CO"))
                isows = "COE";

            try
            {
                listaE = businessService.obtenerPedidoWebAnteriorDetalle(campaniaddlVal, isows, regionddl, zonaddl, codConsultoratxtId);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, "", "", "ReportePedidoCampaniaImp - Page_Load - obtenerPedidoWebAnteriorDetalle");

                listaE = null;
            }

            if (listaE != null)
            {
                foreach (var item in listaE)
                {
                    sb.Append("<tr>");
                    sb.Append("<td>" + item.codigoConsultora + "</td>");
                    sb.Append("<td>" + item.codigoTerritorio + "</td>");
                    sb.Append("<td>" + item.cuv + "</td>");
                    sb.Append("<td>" + item.codigoProducto + "</td>");
                    sb.Append("<td>" + item.cantidad + "</td>");
                    if (paisddl == "Colombia")
                    {
                        sb.Append("<td>" + Convert.ToDecimal(item.importeTotal).ToString("#,##0").Replace(',','.') + "</td>");
                    } else {
                        sb.Append("<td>" + Convert.ToDecimal(item.importeTotal).ToString("0.00") + "</td>");
                    }
                    sb.Append("<td>" + item.codigoTipoOferta + "</td>");
                    sb.Append("<td>" + item.origen + "</td>");
                    sb.Append("<td>" + (item.fechaUltimaActualizacion == null ? null : Convert.ToDateTime(item.fechaUltimaActualizacion).ToShortDateString()) + "</td>");
                    sb.Append("</tr>");
                }
            }
            else
            {
                sb.Append("<tr>");
                sb.Append("<td>" + string.Empty + "</td>");
                sb.Append("<td>" + string.Empty + "</td>");
                sb.Append("<td>" + string.Empty + "</td>");
                sb.Append("<td>" + string.Empty + "</td>");
                sb.Append("<td>" + string.Empty + "</td>");
                sb.Append("<td>" + string.Empty + "</td>");
                sb.Append("<td>" + string.Empty + "</td>");
                sb.Append("<td>" + string.Empty + "</td>");
                sb.Append("<td>" + string.Empty + "</td>");
                sb.Append("</tr>");
            }

            sb.Append("</tbody>");
            sb.Append("</table>");

            lTabla.Text = sb.ToString();
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, "", "", "ReportePedidoCampaniaImp - Page_Load");

                throw;
            }
        }
    }

}