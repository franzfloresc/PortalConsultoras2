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
                    int PaisID = Convert.ToInt32(data[6].ToString());
                    string Simbolo = data[7].ToString();

                    using (SACServiceClient sv = new SACServiceClient())
                    {
                        lista = sv.GetDatosBelcorp(PaisID).ToList();
                    }

                    lblRUCAgentePerceptor.Text = RUCAgentePerceptor;
                    lblNombreAgentePerceptor.Text = NombreAgentePerceptor;
                    lblNumeroComprobanteSerie.Text = NumeroComprobanteSerie;
                    lblFechaEmision.Text = FechaEmision;
                    lblImportePercepcion.Text = ImportePercepcion;
                    lblDireccion.Text = lista[0].Direccion;
                    lblRUC.Text = lista[0].RUC;
                    lblRazonSocial.Text = lista[0].RazonSocial;
                    lblSimbolo.Text = Simbolo;

                    List<BEComprobantePercepcionDetalle> lst;
                    using (ODSServiceClient sv = new ODSServiceClient())
                    {
                        lst = sv.SelectComprobantePercepcionDetalle(PaisID, Convert.ToInt32(IdComprobantePercepcion)).ToList();
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
    }
}