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
        public ActionResult ViewLanding()
        {
            var model = new RevistaDigitalLandingModel();

            model.CampaniaID = userData.CampaniaID;
            model.IsMobile = IsMobile();

            model.FiltersBySorting = new List<BETablaLogicaDatos>();
            model.FiltersBySorting.Add(new BETablaLogicaDatos { Codigo = Constantes.ShowRoomTipoOrdenamiento.ValorPrecio.Predefinido, Descripcion = model.IsMobile ? "ORDENAR POR" : "ORDENAR POR PRECIO" });
            model.FiltersBySorting.Add(new BETablaLogicaDatos { Codigo = Constantes.ShowRoomTipoOrdenamiento.ValorPrecio.MenorAMayor, Descripcion = model.IsMobile ? "MENOR PRECIO" : "MENOR A MAYOR PRECIO" });
            model.FiltersBySorting.Add(new BETablaLogicaDatos { Codigo = Constantes.ShowRoomTipoOrdenamiento.ValorPrecio.MayorAMenor, Descripcion = model.IsMobile ? "MAYOR PRECIO" : "MAYOR A MENOR PRECIO" });

            model.FiltersByBrand = new List<BETablaLogicaDatos>();
            model.FiltersByBrand.Add(new BETablaLogicaDatos { Codigo = "-", Descripcion = model.IsMobile ? "MARCAS" : "FILTRAR POR MARCA" });
            model.FiltersByBrand.Add(new BETablaLogicaDatos { Codigo = "CYZONE", Descripcion = "CYZONE" });
            model.FiltersByBrand.Add(new BETablaLogicaDatos { Codigo = "ÉSIKA", Descripcion = "ÉSIKA" });
            model.FiltersByBrand.Add(new BETablaLogicaDatos { Codigo = "LBEL", Descripcion = "LBEL" });

            model.Success = true;
            ViewBag.NombreConsultora = userData.Sobrenombre;
            model.CantidadFilas = 10;
            return PartialView("Index", model);
        }


        public ActionResult DetalleModel(string cuv, int campaniaId)
        {
            //modelo = modelo ?? new EstrategiaPersonalizadaProductoModel();
            var modelo = (EstrategiaPersonalizadaProductoModel)Session[Constantes.ConstSession.ProductoTemporal];
            if (modelo == null || modelo.EstrategiaID == 0 || modelo.CUV2 != cuv || modelo.CampaniaID != campaniaId)
            {
                return RedirectToAction("Index", "GuiaNegocio", new { area = IsMobile() ? "Mobile" : "" });
            }

            if (!revistaDigital.TieneRDC && !revistaDigital.TieneRDR)
            {
                return RedirectToAction("Index", "GuiaNegocio", new { area = IsMobile() ? "Mobile" : "" });
            }
            if (EsCampaniaFalsa(modelo.CampaniaID))
            {
                return RedirectToAction("Index", "GuiaNegocio", new { area = IsMobile() ? "Mobile" : "" });
            }
            if (modelo.EstrategiaID <= 0)
            {
                return RedirectToAction("Index", "GuiaNegocio", new { area = IsMobile() ? "Mobile" : "" });
            }

            modelo.TipoEstrategiaDetalle = modelo.TipoEstrategiaDetalle ?? new EstrategiaDetalleModelo();
            modelo.ListaDescripcionDetalle = modelo.ListaDescripcionDetalle ?? new List<string>();
            ViewBag.TieneRDC = revistaDigital.TieneRDC;
            ViewBag.EstadoSuscripcion = revistaDigital.SuscripcionModel.EstadoRegistro;
            ViewBag.TieneProductosPerdio = TieneProductosPerdio(modelo.CampaniaID);
            ViewBag.NombreConsultora = userData.Sobrenombre;
            var campaniaX2 = revistaDigital.SuscripcionAnterior1Model.CampaniaID > 0 && revistaDigital.SuscripcionAnterior1Model.EstadoRegistro == Constantes.EstadoRDSuscripcion.Activo
                ? revistaDigital.SuscripcionAnterior1Model.CampaniaID : userData.CampaniaID;
            ViewBag.CampaniaMasDos = AddCampaniaAndNumero(campaniaX2, 2) % 100;
            ViewBag.Campania = campaniaId;
            return View(modelo);

        }

        public bool EsCampaniaFalsa(int campaniaId)
        {
            return (campaniaId < userData.CampaniaID || campaniaId > AddCampaniaAndNumero(userData.CampaniaID, 1));
        }

        public bool TieneProductosPerdio(int campaniaID)
        {
            if (revistaDigital.TieneRDC &&
                revistaDigital.SuscripcionAnterior2Model.EstadoRegistro != Constantes.EstadoRDSuscripcion.Activo &&
                campaniaID == userData.CampaniaID)
                return true;
            return false;
        }
    }
}