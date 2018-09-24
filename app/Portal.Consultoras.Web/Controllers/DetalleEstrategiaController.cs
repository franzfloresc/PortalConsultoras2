using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using System;
using System.Collections.Generic;
using System.Web.Mvc;
using Portal.Consultoras.Web.LogManager;
using Portal.Consultoras.Web.Providers;
using Portal.Consultoras.Web.SessionManager;

namespace Portal.Consultoras.Web.Controllers
{
    public class DetalleEstrategiaController : BaseViewController
    {
        public DetalleEstrategiaController() : base()
        {

        }

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

        public DetalleEstrategiaController(ISessionManager sesionManager, ILogManager logManager, EstrategiaComponenteProvider estrategiaComponenteProvider)
            : base(sesionManager, logManager, estrategiaComponenteProvider)
        {
        }

        public override ActionResult Ficha(string palanca, int campaniaId, string cuv, string origen)
        {
            return base.Ficha(palanca, campaniaId, cuv, origen);
        }

        public JsonResult ObtenerComponentes(string estrategiaId, string cuv2,  string campania, string codigoVariante, string codigoEstrategia = "", List<EstrategiaComponenteModel> lstHermanos = null)
        {
            try
            {
                var estrategiaModelo = new EstrategiaPersonalizadaProductoModel
                {
                    EstrategiaID = estrategiaId.ToInt(),
                    CUV2 = cuv2,
                    CampaniaID = campania.ToInt(),
                    CodigoVariante = codigoVariante,
                    Hermanos = lstHermanos
                };

                bool esMultimarca = false;
                string mensaje = "";
                var componentes = _estrategiaComponenteProvider.GetListaComponentes(estrategiaModelo, codigoEstrategia, out esMultimarca, out mensaje);

                return Json(new
                {
                    success = true,
                    esMultimarca,
                    componentes,
                    mensaje
                }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);

                return Json(new
                {
                    success = false,
                    ex
                }, JsonRequestBehavior.AllowGet);
                //return ErrorJson("Error al obtener los Componentes: " + ex.Message, true);
            }

        }
    }
}