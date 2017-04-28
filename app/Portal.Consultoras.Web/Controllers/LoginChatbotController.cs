using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
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
            var model = new LoginChatbotModel {
                TokenBotmaker = t,
                WebViewFallBack = webviewfallback,
                Tipo = tipo,
                ListaPaises = DropDowListPaises(),
                AppFacebookId = ConfigurationManager.AppSettings.Get("FB_AppId")
            };
            return View(model);
        }

        private IList<PaisModel> DropDowListPaises()
        {

            try
            {
                List<BEPais> lst;
                using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
                {
                    lst = sv.SelectPaises().ToList();
                }
                lst.RemoveAll(p => p.CodigoISO == Constantes.CodigosISOPais.Argentina);

                Mapper.CreateMap<BEPais, PaisModel>();
                return Mapper.Map<List<BEPais>, List<PaisModel>>(lst);
            }
            catch (Exception ex)
            {
                return new List<PaisModel>();
            }
        }
    }
}
