using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models.Cache;
using Portal.Consultoras.Web.Models.Common;
using Portal.Consultoras.Web.ServiceSAC;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class CacheController : BaseController
    {
        public ActionResult Index()
        {
            if (userData.RolID != Constantes.Rol.AdministradorSAC) return RedirectToAction("Index", "Bienvenida");

            var model = new ListStringModel { List = new List<string>() };
            try
            {
                using (var sv = new SACServiceClient())
                {
                    model.List = sv.GetListEnumStringCache().ToList();
                }
            }
            catch(Exception ex) { LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoUsuario, userData.CodigoISO); }

            return View(model);
        }

        [HttpPost]
        public JsonResult Eliminar(CacheModel model)
        {
            try
            {
                string respuesta;
                using (var sv = new SACServiceClient())
                {
                    respuesta = sv.RemoveDataCache(userData.PaisID, model.CacheItemString, model.CustomKey);
                }
                return SuccessJson(respuesta);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoUsuario, userData.CodigoISO);
                return ErrorJson(Constantes.MensajesError.Cache_Eliminar);
            }
        }
    }
}
