using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using System;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class DetalleEstrategiaController : BaseViewController // : BaseEstrategiaController
    {
        public ActionResult Ficha(string palanca, int campaniaId, string cuv, string origen)
        {
            return DEFicha(palanca, campaniaId, cuv, origen);
        }

        public JsonResult ObtenerComponentes(string estrategiaId, string campania, string codigoVariante, string codigoEstrategia = "")
        {
            try
            {
                var estrategiaModelo = new EstrategiaPersonalizadaProductoModel
                {
                    EstrategiaID = estrategiaId.ToInt(),
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