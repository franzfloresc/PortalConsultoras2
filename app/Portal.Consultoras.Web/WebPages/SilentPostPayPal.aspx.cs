using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Portal.Consultoras.Web.ServiceContenido;
using System.ServiceModel;

namespace Portal.Consultoras.Web.WebPages
{
    public partial class SilentPostPayPal : System.Web.UI.Page
    {
        protected void Page_Load(object sender, System.EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                int rslt = 0;
                try
                {
                    using (ServiceContenido.ContenidoServiceClient sv = new ServiceContenido.ContenidoServiceClient())
                    {
                        rslt = sv.InsAbonoPago(12, /*int.Parse(this.Request["PAISID"].ToString()*/
                                               this.Request["USER1"].ToString(),
                                               this.Request["USER2"].ToString(),
                                               (string.IsNullOrEmpty(Request["AMOUNT"])) ? 0 : Decimal.Parse(this.Request["AMOUNT"]),
                                               this.Request["AUTHCODE"].ToString(),
                                               this.Request["PNREF"].ToString(),
                                               int.Parse(this.Request["RESULT"].ToString()));
                    }
                }
                catch (FaultException ex)
                {
                    LogManager.LogManager.LogErrorWebServicesPortal(ex, this.Request["USER2"].ToString(), "Error Silent Post");
                }
                catch (Exception ex)
                {
                    LogManager.LogManager.LogErrorWebServicesBus(ex, this.Request["USER2"].ToString(), "Error Silent Post");
                }

                //bePagosLinea.codigoPais = this.Request["USER1"];
                //bePagosLinea.codigoConsultora = this.Request["USER2"];
                //double montoAbono = (string.IsNullOrEmpty(Request["AMOUNT"])) ? 0 : Double.Parse(this.Request["AMOUNT"]);
                //string codigoAutorizacionBancaria = this.Request["AUTHCODE"];
                //string codigoTransaccion = this.Request["PNREF"];
                //string resultado = this.Request["RESULT"];
                //bool respuesta = false;

                //titProcesando.Text += ", bePagosLinea.codigoPais =" + bePagosLinea.codigoPais;
                //string connstring = Application[beUsuarioLogin.codigoPais].ToString();

                //DataSet paises = (DataSet)Application["Paises"];
                //string connstring = string.Empty;
                //for (int i = 0; i < paises.Tables[0].Rows.Count && string.IsNullOrEmpty(connstring); i++)
                //{
                //    if (paises.Tables[0].Rows[i]["chrCodigoPais"].ToString() == "0282")
                //        connstring = paises.Tables[0].Rows[i]["dataconn"].ToString();
                //}

                //BGPagosLinea bgPagoLinea = new BGPagosLinea();
                //respuesta = bgPagoLinea.RegistrarAbono(bePagosLinea, connstring, montoAbono, codigoAutorizacionBancaria, codigoTransaccion, resultado);
            }
        }
    }
}