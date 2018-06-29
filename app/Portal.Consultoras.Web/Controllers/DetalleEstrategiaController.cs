using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using System;
using System.Linq;
using System.Net;
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
                var estrategiaPresonalizada = ObtenerEstrategiaPersonalizada(palanca, cuv);
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

        public JsonResult ObtenerComponentes (int estrategiaId, int campania, string codigoVariante)
        {
            try
            {
                var estrategiaModelo = new EstrategiaPersonalizadaProductoModel
                {
                    EstrategiaID = estrategiaId,
                    CampaniaID = campania,
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

        private bool EnviaronParametrosValidos(string palanca, int campaniaId, string cuv)
        {
            return !string.IsNullOrEmpty(palanca) && 
                   !string.IsNullOrEmpty(cuv) && 
                   !string.IsNullOrEmpty(campaniaId.ToString()) && 
                   !_ofertaPersonalizadaProvider.EsCampaniaFalsa(campaniaId);
        }

        //Por el momento solo SW y ODD se maneja de sesion
        private bool PalancasConSesion(string palanca)
        {
            return palanca.Equals(Constantes.NombrePalanca.ShowRoom) ||
                   palanca.Equals(Constantes.NombrePalanca.OfertaDelDia);
        }

        //Falta revisar las casuiticas por palanca
        private bool TienePermisoPalanca(string palanca)
        {
            switch (palanca)
            {
                case Constantes.NombrePalanca.RevistaDigital:
                case Constantes.NombrePalanca.Lanzamiento:
                case Constantes.NombrePalanca.GuiaDeNegocioDigitalizada: //TODO: Validar habilitacion para GND
                case Constantes.NombrePalanca.HerramientasVenta:
                {
                    return revistaDigital.TieneRDC || revistaDigital.TieneRDCR;
                }
                case Constantes.NombrePalanca.ShowRoom:
                    return true; //TODO: Validar habilitacion para ShowRoom
                case Constantes.NombrePalanca.OfertaDelDia:
                    return true; //TODO: Validar habilitacion para OfertaDelDia
                default:
                    return true;
            }
        }
    }
}