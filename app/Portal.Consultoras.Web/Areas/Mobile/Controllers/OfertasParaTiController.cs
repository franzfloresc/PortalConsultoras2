﻿using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Controllers;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Areas.Mobile.Controllers
{
    public class OfertasParaTiController : BaseEstrategiaController
    {
        
        public ActionResult Index()
        {
            return View();
        }
        public ActionResult Detalle(int id, int origen)
        {
            var modelo = EstrategiaGetDetalle(id, "", origen);
            var origenPantalla = Util.Trim(origen.ToString()).Substring(1, 1);
           
            if (modelo.EstrategiaID <= 0)
            {
                switch (origenPantalla)
                {
                    case "1": return RedirectToAction("Index", "Bienvenida", new { area = "Mobile" });
                    case "2": return RedirectToAction("Index", "Pedido", new { area = "Mobile" });
                    case "7": return RedirectToAction("Index", "RevistaDigital", new { area = "Mobile" });
                }
            }

            //ViewBag.Origen = origen;
            ViewBag.OrigenUrl = Url.Action("Index", "Bienvenida", new { area = "Mobile" });

            switch (origenPantalla)
            {
                case "1":
                    ViewBag.OrigenUrl = Url.Action("Index", "Bienvenida", new { area = "Mobile" });
                    break;
                case "2":
                    ViewBag.OrigenUrl = Url.Action("Index", "Pedido", new { area = "Mobile" });
                    break;
                case "7":
                    ViewBag.Codigo = Constantes.MenuCodigo.RevistaDigital;
                    ViewBag.OrigenUrl = Url.Action("Index", "RevistaDigital", new { area = IsMobile() ? "Mobile" : "" }); 
                    break;
            }

            ViewBag.EstadoSuscripcion = userData.RevistaDigital.SuscripcionModel.EstadoRegistro;
            ViewBag.CampaniaMasDos = AddCampaniaAndNumero(userData.CampaniaID, 2) % 100;
            return View(modelo);
        }

    }
}