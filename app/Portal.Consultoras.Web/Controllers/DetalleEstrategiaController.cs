using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using System;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class DetalleEstrategiaController : BaseEstrategiaController
    {
        public ActionResult Ficha(string palanca, int campaniaId, string cuv, string origen)
        {
            if (!EnviaronParametrosValidos(palanca, campaniaId, cuv)) return RedirectToAction("Index", "Ofertas");

            if (!TienePermisoPalanca(palanca)) return RedirectToAction("Index", "Ofertas");

            DetalleEstrategiaFichaModel modelo;
            if (PalancasConSesion(palanca))
            {
                var estrategiaPresonalizada = ObtenerEstrategiaPersonalizada(palanca, cuv, campaniaId);
                if (estrategiaPresonalizada == null) return RedirectToAction("Index", "Ofertas");
                modelo = Mapper.Map<EstrategiaPersonalizadaProductoModel, DetalleEstrategiaFichaModel>(estrategiaPresonalizada);
            }
            else
            {
                modelo = new DetalleEstrategiaFichaModel();
            }
            
            modelo.Origen = origen;
            modelo.Palanca = palanca;
            modelo.TieneSession = PalancasConSesion(palanca);
            modelo.Campania = campaniaId;
            modelo.Cuv = cuv;

            return View("Ficha", modelo);
        }

        public JsonResult ObtenerComponentes (string estrategiaId, string campania, string codigoVariante)
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
                var componentes = _estrategiaComponenteProvider.GetListaComponentes(estrategiaModelo, "", out esMultimarca);

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