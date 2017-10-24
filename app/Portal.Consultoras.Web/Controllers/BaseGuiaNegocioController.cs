using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceSAC;
using System.Collections.Generic;
using System.Configuration;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class BaseGuiaNegocioController : BaseEstrategiaController
    {
        public virtual ActionResult ViewLanding()
        {

            ViewBag.NombreConsultora = userData.Sobrenombre;

            var model = new RevistaDigitalLandingModel();

            model.CampaniaID = userData.CampaniaID;
            model.IsMobile = IsMobile();

            model.FiltersBySorting = GetFiltersBySorting();
            model.FiltersByBrand = GetFiltersByBrand();

            model.Success = true;
            model.CantidadFilas = 10;

            return PartialView("Index", model);
        }

        public List<BETablaLogicaDatos> GetFiltersBySorting()
        {
            var filtersBySorting = new List<BETablaLogicaDatos>();
            filtersBySorting.Add(new BETablaLogicaDatos { Codigo = Constantes.GuiaNegocioTipoOrdenamiento.ValorPrecio.Predefinido, Descripcion = IsMobile() ? "ORDENAR POR" : "ORDENAR POR PRECIO" });
            filtersBySorting.Add(new BETablaLogicaDatos { Codigo = Constantes.GuiaNegocioTipoOrdenamiento.ValorPrecio.MenorAMayor, Descripcion = IsMobile() ? "MENOR PRECIO" : "MENOR A MAYOR PRECIO" });
            filtersBySorting.Add(new BETablaLogicaDatos { Codigo = Constantes.GuiaNegocioTipoOrdenamiento.ValorPrecio.MayorAMenor, Descripcion = IsMobile() ? "MAYOR PRECIO" : "MAYOR A MENOR PRECIO" });
            return filtersBySorting;
        }


        public List<BETablaLogicaDatos> GetFiltersByBrand()
        {
            var filterByBrand = new List<BETablaLogicaDatos>();
            filterByBrand.Add(new BETablaLogicaDatos { Codigo = Constantes.GuiaNegocioMarca.ValorPrecio.Predefinido, Descripcion = IsMobile() ? "FILTRAR POR MARCA" : "FILTRAR POR MARCA" });
            filterByBrand.Add(new BETablaLogicaDatos { Codigo = Constantes.GuiaNegocioMarca.ValorPrecio.Cyzone, Descripcion = IsMobile() ? "CYZONE" : "CYZONE" });
            filterByBrand.Add(new BETablaLogicaDatos { Codigo = Constantes.GuiaNegocioMarca.ValorPrecio.Esika, Descripcion = IsMobile() ? "ÉSIKA" : "ÉSIKA" });
            filterByBrand.Add(new BETablaLogicaDatos { Codigo = Constantes.GuiaNegocioMarca.ValorPrecio.LBel, Descripcion = IsMobile() ? "LBEL" : "LBEL" });
            return filterByBrand;
        }


        public ActionResult DetalleModel(string cuv, int campaniaId)
        {
            //var modelo = (EstrategiaPersonalizadaProductoModel)Session[Constantes.ConstSession.ProductoTemporal];
            //if (modelo == null || modelo.EstrategiaID == 0 || modelo.CUV2 != cuv || modelo.CampaniaID != campaniaId)
            //{
            //    return RedirectToAction("Index", "RevistaDigital", new { area = IsMobile() ? "Mobile" : "" });
            //}

            //if (!revistaDigital.TieneRDC && !revistaDigital.TieneRDR)
            //{
            //    return RedirectToAction("Index", "RevistaDigital", new { area = IsMobile() ? "Mobile" : "" });
            //}
            //if (EsCampaniaFalsa(modelo.CampaniaID))
            //{
            //    return RedirectToAction("Index", "RevistaDigital", new { area = IsMobile() ? "Mobile" : "" });
            //}
            //if (modelo.EstrategiaID <= 0)
            //{
            //    return RedirectToAction("Index", "RevistaDigital", new { area = IsMobile() ? "Mobile" : "" });
            //}

            //modelo.TipoEstrategiaDetalle = modelo.TipoEstrategiaDetalle ?? new EstrategiaDetalleModelo();
            //modelo.ListaDescripcionDetalle = modelo.ListaDescripcionDetalle ?? new List<string>();
            //ViewBag.TieneRDC = revistaDigital.TieneRDC;
            //ViewBag.EstadoSuscripcion = revistaDigital.SuscripcionModel.EstadoRegistro;
            //ViewBag.TieneProductosPerdio = TieneProductosPerdio(modelo.CampaniaID);
            //ViewBag.NombreConsultora = userData.Sobrenombre;
            //var campaniaX2 = revistaDigital.SuscripcionAnterior1Model.CampaniaID > 0 && revistaDigital.SuscripcionAnterior1Model.EstadoRegistro == Constantes.EstadoRDSuscripcion.Activo
            //    ? revistaDigital.SuscripcionAnterior1Model.CampaniaID : userData.CampaniaID;
            //ViewBag.CampaniaMasDos = AddCampaniaAndNumero(campaniaX2, 2) % 100;
            //ViewBag.Campania = campaniaId;
            //return View(modelo);
            return null;
        }
    }
}