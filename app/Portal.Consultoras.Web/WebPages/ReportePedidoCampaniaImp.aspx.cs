using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServiceOSBBelcorpPedido;
using Portal.Consultoras.Web.ServiceZonificacion;
using Portal.Consultoras.Web.Models;

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
            string[] lista = param.Split(new char[] { ';' });

            string Paisddl = lista[0];
            string Campaniaddl = lista[1];
            string Regionddl = lista[2];
            string Zonaddl = lista[3];
            string CodConsultoratxt = lista[4];
            string Paisddl_val = (lista[5] == string.Empty ? "0" : lista[5]);
            string Campaniaddl_val = (lista[6] == string.Empty ? "0" : lista[6]);
            string Regionddl_val = (lista[7] == string.Empty ? "0" : lista[7]);
            string Zonaddl_val = (lista[8] == string.Empty ? "0" : lista[8]);
            string CodConsultoratxt_ID = lista[9];
            string Usuario = lista[10];
            string Imagen = lista[11];
            string NombrePais = lista[12];

            lblNombrePais.Text = NombrePais;
            imgBandera.ImageUrl = "../Content/Banderas/" + Imagen;
            imgLogoResponde.ImageUrl = "../Content/Images/logo_responde_" + Imagen;
            lblUsuario.Text = Usuario;
            txtCodigos.Text = CodConsultoratxt;
            ddlCampania.Items.Add(new ListItem { Text = Campaniaddl, Value = Campaniaddl_val }); ddlCampania.SelectedIndex = 0;
            ddlPais.Items.Add(new ListItem { Text = Paisddl, Value = Paisddl_val }); ddlPais.SelectedIndex = 0;
            ddlRegion.Items.Add(new ListItem { Text = Regionddl, Value = Regionddl_val }); ddlRegion.SelectedIndex = 0;
            ddlZona.Items.Add(new ListItem { Text = Zonaddl, Value = Zonaddl_val }); ddlZona.SelectedIndex = 0;

            StringBuilder sb = new StringBuilder();
            sb.Append("<table>");
            sb.Append("<thead><tr><th>Cod. Consultora</th><th>Territorio</th><th>Cod. Venta</th><th>Cod. Producto</th><th>Unidades Demandadas</th><th>Monto Demandado</th><th>Cod. Tipo Oferta</th><th>Origen</th><th>Fecha Ult. Act.</th></tr></thead>");
            sb.Append("<tbody>");

            BEPais bepais = new BEPais();

            PedidoBS BusinessService = new PedidoBS();
            ServiceOSBBelcorpPedido.pedidoWebAnteriorDetalleBean[] listaE;


            using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
            {
                bepais = sv.SelectPais(Convert.ToInt32(Paisddl_val));
            }

            if (Regionddl == "" || Regionddl == "-- Todas --") Regionddl = "0";
            if (Zonaddl == "" || Zonaddl == "-- Todas --") Zonaddl = "0";
            if (CodConsultoratxt_ID == "") CodConsultoratxt_ID = "0";
            string ISOWS = string.Empty;

            if (bepais.CodigoISO.Equals("PE"))
                ISOWS = "PE";
            else if (bepais.CodigoISO.Equals("CL"))
                ISOWS = "CLE";
            else if (bepais.CodigoISO.Equals("EC"))
                ISOWS = "ECL";
            else if (bepais.CodigoISO.Equals("BO"))
                ISOWS = "BO";
            else if (bepais.CodigoISO.Equals("MX"))
                ISOWS = "MXL";
            else if (bepais.CodigoISO.Equals("AR"))
                ISOWS = "AR";
            else if (bepais.CodigoISO.Equals("CR"))
                ISOWS = "CRL";
            else if (bepais.CodigoISO.Equals("SV"))
                ISOWS = "SVE";
            else if (bepais.CodigoISO.Equals("PA"))
                ISOWS = "PAL";
            else if (bepais.CodigoISO.Equals("GT"))
                ISOWS = "GTE";
            else if (bepais.CodigoISO.Equals("PR"))
                ISOWS = "PRL";
            else if (bepais.CodigoISO.Equals("DO"))
                ISOWS = "DOL";
            else if (bepais.CodigoISO.Equals("VE"))
                ISOWS = "VEL";
            else if (bepais.CodigoISO.Equals("CO"))
                ISOWS = "COE";

            try
            {
                listaE = BusinessService.obtenerPedidoWebAnteriorDetalle(Campaniaddl_val, ISOWS, Regionddl, Zonaddl, CodConsultoratxt_ID);
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
                    // validación pais colombia req. 1478
                    if (Paisddl == "Colombia")
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