using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Text;
using System.Web.UI;
using System.Web.UI.WebControls;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.ServiceSAC;
using Portal.Consultoras.Web.ServiceODS;

namespace Portal.Consultoras.Web.WebPages
{
    public partial class PercepcionDetalle : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                string result = string.Empty;
                List<BEDatosBelcorp> lista;

                if (Request.QueryString["parametros"] != null)
                {
                    string[] data = Util.DesencriptarQueryString(Request.QueryString["parametros"].ToString()).Split(';');
                    string IdComprobantePercepcion = data[0].ToString();
                    string RUCAgentePerceptor = data[1].ToString();
                    string NombreAgentePerceptor = data[2].ToString();
                    string NumeroComprobanteSerie = data[3].ToString();
                    string FechaEmision = data[4].ToString();
                    string ImportePercepcion = Convert.ToDecimal(data[5]).ToString("0.00");
                    string ImportePercepcionTexto = "Son: " + Util.enletras(Convert.ToDecimal(ImportePercepcion).ToString("0.00")) + " Nuevos Soles";
                    int PaisID = Convert.ToInt32(data[7].ToString());
                    string Simbolo = data[8].ToString();

                    using (SACServiceClient sv = new SACServiceClient())
                    {
                        lista = sv.GetDatosBelcorp(PaisID).ToList();
                    }

                    lblRUCAgentePerceptor.Text = RUCAgentePerceptor;
                    lblNombreAgentePerceptor.Text = NombreAgentePerceptor;
                    lblNumeroComprobanteSerie.Text = NumeroComprobanteSerie;
                    lblFechaEmision.Text = FechaEmision;
                    lblImportePercepcion.Text = ImportePercepcion;
                    lblImportePercepcionTexto.Text = ImportePercepcionTexto;
                    lblDireccion.Text = lista[0].Direccion;
                    lblRUC.Text = lista[0].RUC;
                    lblRazonSocial.Text = lista[0].RazonSocial;
                    lblSimbolo.Text = Simbolo;

                    List<BEComprobantePercepcionDetalle> lst;
                    using (ODSServiceClient sv = new ODSServiceClient())
                    {
                        lst = sv.SelectComprobantePercepcionDetalle(PaisID, Convert.ToInt32(IdComprobantePercepcion)).ToList();
                    }

                    StringBuilder sb = new StringBuilder();
                    sb.Append("<table>");
                    sb.Append("<thead><tr><th>Tipo</th><th>Nro. Serie</th><th>Nro. Correlativo</th><th>Fecha Emisión documento</th><th>Precio de Venta(S/.)</th><th>Porcentaje de Percepción</th><th>Importe Percepciones(S/.)</th><th>Monto Total Cobrado(S/.)</th></tr></thead>");
                    sb.Append("<tbody>");

                    foreach (var item in lst)
                    {
                        sb.Append("<tr>");
                        sb.Append("<td>" + item.TipoDocumento + "</td>");
                        sb.Append("<td>" + item.NumeroDocumentoSerie + "</td>");
                        sb.Append("<td>" + item.NumeroDocumentoCorrelativo + "</td>");
                        sb.Append("<td>" + item.FechaEmisionDocumento.ToString("dd/MM/yyyy") + "</td>");
                        sb.Append("<td>" + item.Monto.ToString("0.00") + "</td>");
                        sb.Append("<td>" + item.PorcentajePercepcion.ToString("0.00") + "</td>");
                        sb.Append("<td>" + item.ImportePercepcion.ToString("0.00") + "</td>");
                        sb.Append("<td>" + item.MontoTotal.ToString("0.00") + "</td>");
                        sb.Append("</tr>");
                    }

                    sb.Append("</tbody>");
                    sb.Append("</table>");

                    lTabla.Text = sb.ToString();
                }
            }
        }
    }
}