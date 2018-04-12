using Portal.Consultoras.Common;
using System;
using System.Web.Mvc;
using Portal.Consultoras.Web.ServiceSAC;

namespace Portal.Consultoras.Web.Controllers
{
    public class CacheController : BaseController
    {
        public ActionResult Index()
        {
            ViewBag.PaisId = userData.PaisID;
            return View();
        }

        [HttpPost]
        public JsonResult Eliminar(int paisID, string cacheItemString, string customKey)
        {
            try
            {
                string respuesta;
                using (var sv = new SACServiceClient())
                {
                    respuesta = sv.RemoveDataCache(userData.PaisID, cacheItemString, customKey);
                }
                return SuccessJson(respuesta);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoUsuario, UserData().CodigoISO);
                return ErrorJson(Constantes.MensajesError.Cache_Eliminar);
            }
        }
    }
}
