using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using System;
using System.Web.Mvc;
using Portal.Consultoras.Web.LogManager;
using Portal.Consultoras.Web.Providers;
using Portal.Consultoras.Web.SessionManager;

namespace Portal.Consultoras.Web.Controllers
{
    public class DetalleEstrategiaController : BaseViewController
    {
        //public DetalleEstrategiaController() : base()
        //{

        //}
        //public DetalleEstrategiaController(ISessionManager sesionManager) 
        //    : base(sesionManager)
        //{

        //}

        //public DetalleEstrategiaController(ISessionManager sesionManager, ILogManager logManager) 
        //    : base(sesionManager, logManager)
        //{

        //}

        public DetalleEstrategiaController(ISessionManager sesionManager, ILogManager logManager, OfertaPersonalizadaProvider ofertaPersonalizadaProvider)
            : base(sesionManager, logManager, ofertaPersonalizadaProvider)
        {
        }

        public override ActionResult Ficha(string palanca, int campaniaId, string cuv, string origen)
        {
            return base.Ficha(palanca, campaniaId, cuv, origen);
        }

        public JsonResult ObtenerComponentes(string estrategiaId, string cuv2,  string campania, string codigoVariante, string codigoEstrategia = "")
        {
            try
            {
                var estrategiaModelo = new EstrategiaPersonalizadaProductoModel
                {
                    EstrategiaID = estrategiaId.ToInt(),
                    CUV2 = cuv2,
                    CampaniaID = campania.ToInt(),
                    CodigoVariante = codigoVariante
                };

                bool esMultimarca = false;
                var componentes = _estrategiaComponenteProvider.GetListaComponentes(estrategiaModelo, codigoEstrategia, out esMultimarca);

                return Json(new
                {
                    esMultimarca,
                    componentes
                }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception e)
            {
                return ErrorJson("Error al obtener los Componentes: " + e.Message, true);
            }

        }
    }
}