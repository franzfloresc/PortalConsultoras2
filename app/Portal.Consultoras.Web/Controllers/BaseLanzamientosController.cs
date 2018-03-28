using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class BaseLanzamientosController : BaseEstrategiaController
    {
        public virtual ActionResult Detalle(string cuv, int campaniaId)
        {
            if (!(revistaDigital.TieneRevistaDigital() && revistaDigital.EsActiva))
            {
                return RedirectToAction("Index", "Bienvenida", new { area = IsMobile() ? "Mobile" : "" });
            }
            if (string.IsNullOrWhiteSpace(cuv) || campaniaId <= 0)
            {
                return RedirectToAction("Index", "Bienvenida", new { area = IsMobile() ? "Mobile" : "" });
            }

            var modelo = (EstrategiaPersonalizadaProductoModel)Session[Constantes.ConstSession.ProductoTemporal];
            if (modelo == null || modelo.EstrategiaID == 0 || modelo.CUV2 != cuv || modelo.CampaniaID != campaniaId)
            {
                return RedirectToAction("Index", "Ofertas", new { area = IsMobile() ? "Mobile" : "" });
            }
            if (EsCampaniaFalsa(modelo.CampaniaID))
            {
                return RedirectToAction("Index", "Ofertas", new { area = IsMobile() ? "Mobile" : "" });
            }
            if (modelo.EstrategiaID <= 0)
            {
                return RedirectToAction("Index", "Ofertas", new { area = IsMobile() ? "Mobile" : "" });
            }

            modelo.TipoEstrategiaDetalle = modelo.TipoEstrategiaDetalle ?? new EstrategiaDetalleModelo();
            modelo.ListaDescripcionDetalle = modelo.ListaDescripcionDetalle ?? new List<string>();

            var EstrategiaDetalle = EstrategiaGetDetalle(modelo.EstrategiaID);
            if (EstrategiaDetalle.Hermanos != null)
            {
                modelo.Hermanos = EstrategiaDetalle.Hermanos;
            }

            ViewBag.EstadoSuscripcion = revistaDigital.SuscripcionModel.EstadoRegistro;
            ViewBag.Campania = campaniaId;
            
            return View(modelo);
        }
    }
}