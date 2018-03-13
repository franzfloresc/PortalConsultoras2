using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Models.LoginChatbot;
using Portal.Consultoras.Web.ServiceZonificacion;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class LoginChatbotController : Controller
    {
        public ActionResult Index(string t, bool webviewfallback, Enumeradores.TipoLogin tipo = Enumeradores.TipoLogin.Normal)
        {
            switch (tipo)
            {
                case Enumeradores.TipoLogin.Normal:
                    var normalModel = new LoginNormalChatbotModel
                    {
                        TokenBotmaker = t,
                        WebViewFallBack = webviewfallback,
                        PaisesEsika = ConfigurationManager.AppSettings["PaisesEsika"] ?? "",
                        UrlBotmakerChat = ConfigurationManager.AppSettings["UrlChatbot"] ?? "",
                        ListaPaises = DropDowListPaises()
                    };
                    return View("Normal", normalModel);
                case Enumeradores.TipoLogin.Facebook:
                    var facebookModel = new LoginFacebookChatbotModel
                    {
                        TokenBotmaker = t,
                        WebViewFallBack = webviewfallback,
                        PaisesEsika = ConfigurationManager.AppSettings["PaisesEsika"] ?? "",
                        UrlBotmakerChat = ConfigurationManager.AppSettings["UrlChatbot"] ?? "",
                        ListaPaises = DropDowListPaises(),
                        AppFacebookId = ConfigurationManager.AppSettings.Get("FB_AppId") ?? ""
                    };
                    return View("Facebook", facebookModel);
            }
            return Redirect("https://go.botmaker.com/rest/webviews/fbConnect");
        }

        private IList<PaisModel> DropDowListPaises()
        {
            string paisesInactivoskey = ConfigurationManager.AppSettings["PaisesInactivos"] ?? string.Empty;
            var paisesInactivos = paisesInactivoskey.ToUpper().Split(';');

            try
            {
                List<BEPais> lst;
                using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
                {
                    lst = sv.SelectPaises().ToList();
                }

                if (paisesInactivos.Any())
                    lst.RemoveAll(p => paisesInactivos.Contains(p.CodigoISO.ToUpper()));

                return Mapper.Map<List<BEPais>, List<PaisModel>>(lst);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, "", "", "DropDowListPaises");
                return new List<PaisModel>();
            }
        }
    }
}
