using System;
using System.ServiceModel;
using System.Web.UI;

namespace Portal.Consultoras.Web.WebPages
{
    public partial class SilentPostPayPal : System.Web.UI.Page
    {
        protected void Page_Load(object sender, System.EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                try
                {
                    using (ServiceContenido.ContenidoServiceClient sv = new ServiceContenido.ContenidoServiceClient())
                    {
                        sv.InsAbonoPago(12,
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

            }
        }
    }
}