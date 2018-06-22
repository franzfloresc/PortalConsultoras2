﻿using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using System;
using System.Linq;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class DetalleEstrategiaController : BaseEstrategiaController
    {

        public ActionResult Ficha(string cuv, int campaniaId)
        {

            var modelo = Mapper.Map<EstrategiaPersonalizadaProductoModel, EstrategiaFichaPersonalizadaProductoModel>(sessionManager.GetProductoTemporal());
            if (modelo == null || modelo.EstrategiaID == 0 || _ofertaPersonalizadaProvider.EsCampaniaFalsa(modelo.CampaniaID) ||
                    modelo.CUV2 != cuv || modelo.CampaniaID != campaniaId)
            {
                return RedirectToAction("Index", "Ofertas");
            }

            var EstrategiaDetalle = EstrategiaGetDetalle(modelo.EstrategiaID);
            if (EstrategiaDetalle.Hermanos != null)
            {
                modelo.Hermanos = EstrategiaDetalle.Hermanos;
            }

            return View("Ficha", modelo);
        }

    }
}