using Portal.Consultoras.Common;
using Portal.Consultoras.Web.ServiceODS;
using Portal.Consultoras.Web.ServiceSAC;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Portal.Consultoras.Web.WebPages
{
    public partial class PercepcionDetalle : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Page.IsPostBack) return;
            if (Request.QueryString["parametros"] == null) return;

            string[] data = Util.DesencriptarQueryString(Request.QueryString["parametros"].ToString()).Split(';');
            string idComprobantePercepcion = data[0];
            string rucAgentePerceptor = data[1];
            string nombreAgentePerceptor = data[2];
            string numeroComprobanteSerie = data[3];
            string fechaEmision = data[4];
            string importePercepcion = Convert.ToDecimal(data[5]).ToString("0.00");
            int paisId = Convert.ToInt32(data[6]);
            string simbolo = data[7];

            List<BEDatosBelcorp> lista;
            using (SACServiceClient sv = new SACServiceClient())
            {
                lista = sv.GetDatosBelcorp(paisId).ToList();
            }

            lblRUCAgentePerceptor.Text = rucAgentePerceptor;
            lblNombreAgentePerceptor.Text = nombreAgentePerceptor;
            lblNumeroComprobanteSerie.Text = numeroComprobanteSerie;
            lblFechaEmision.Text = fechaEmision;
            lblImportePercepcion.Text = importePercepcion;
            lblDireccion.Text = lista[0].Direccion;
            lblRUC.Text = lista[0].RUC;
            lblRazonSocial.Text = lista[0].RazonSocial;
            lblSimbolo.Text = simbolo;

            List<BEComprobantePercepcionDetalle> lst;
            using (ODSServiceClient sv = new ODSServiceClient())
            {
                lst = sv.SelectComprobantePercepcionDetalle(paisId, Convert.ToInt32(idComprobantePercepcion)).ToList();
            }

            var sb = new StringBuilder();

            foreach (var item in lst)
            {
                sb.Append("<div class='content_datos_percepciones'>");
                sb.Append("<div class='tipo padding_tabla_percepcion'>" + item.TipoDocumento + "</div>");
                sb.Append("<div class='serie padding_tabla_percepcion'>" + item.NumeroDocumentoSerie + "</div>");
                sb.Append("<div class='correlativo padding_tabla_percepcion'>" + item.NumeroDocumentoCorrelativo + "</div>");
                sb.Append("<div class='fechaEmision padding_tabla_percepcion'>" + item.FechaEmisionDocumento.ToString("dd/MM/yyyy") + "</div>");
                sb.Append("<div class='precioVenta padding_tabla_percepcion'>" + item.Monto.ToString("0.00") + "</div>");
                sb.Append("<div class='porcentajePercepcion padding_tabla_percepcion'>" + item.PorcentajePercepcion.ToString("0.00") + "</div>");
                sb.Append("<div class='importePercepcion padding_tabla_percepcion'>" + item.ImportePercepcion.ToString("0.00") + "</div>");
                sb.Append("<div class='montoTotalPercepcion padding_tabla_percepcion'>" + item.MontoTotal.ToString("0.00") + "</div>");
                sb.Append("</div>");
            }

            lTabla.Text = sb.ToString();
        }
    }
}