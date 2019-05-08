using Portal.Consultoras.Common;
using Portal.Consultoras.Web.ServiceSAC;
using System;
using System.Configuration;
using System.Linq;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    [RoutePrefix("")]
    public class AppController : Controller
    {
        [HttpGet()]
        [Route("GanaMas")]
        [AllowAnonymous]
        public async Task<ActionResult> GanaMas()
        {
            var iso = string.Empty;


            try
            {
                if (EsAndroid())
                {
                    bool valBool = EstaActivoBuscarIsoPorIp();
                    if (valBool)
                    {
                        var ip = GetIpCliente();
                        if (!string.IsNullOrWhiteSpace(ip)) iso = Util.GetISObyIPAddress(ip);
                    }
                }

                if (!string.IsNullOrEmpty(iso))
                {
                    using (var sv = new SACServiceClient())
                    {
                        var lst = await sv.ListarAppsAsync(Constantes.PaisID.Peru);
                        var itemPais = lst.FirstOrDefault(x => x.PaisISO == iso);
                        if (itemPais != null) return Redirect(itemPais.Url);
                    }
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, string.Empty, string.Empty, "AppController.Verificar");
            }

            return RedirectToAction("Index", "Login");
        }

        #region private
        private bool EsAndroid()
        {
            string uAg = Request.ServerVariables["HTTP_USER_AGENT"];
            Regex regEx = new Regex(@"android", RegexOptions.IgnoreCase);
            return regEx.IsMatch(uAg);
        }

        private bool EstaActivoBuscarIsoPorIp()
        {
            var buscarIsoPorIp = ConfigurationManager.AppSettings.Get("BuscarISOPorIP") ?? string.Empty;
            return buscarIsoPorIp == "1";
        }

        private string GetIpCliente()
        {
            var ip = string.Empty;

            try
            {
                var request = new HttpRequestWrapper(System.Web.HttpContext.Current.Request);
                ip = request.ClientIPFromRequest(skipPrivate: true);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, string.Empty, string.Empty, "AppController.GetIpCliente");
            }

            return ip;
        }
        #endregion
    }
}