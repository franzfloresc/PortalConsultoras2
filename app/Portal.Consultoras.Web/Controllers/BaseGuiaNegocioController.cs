using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceSAC;
using System.Collections.Generic;
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
            filterByBrand.Add(new BETablaLogicaDatos { Codigo = Constantes.GuiaNegocioMarca.ValorPrecio.Predefinido, Descripcion = IsMobile() ? "MARCA" : "FILTRAR POR MARCA" });
            filterByBrand.Add(new BETablaLogicaDatos { Codigo = Constantes.GuiaNegocioMarca.ValorPrecio.Cyzone, Descripcion = "CYZONE" });
            filterByBrand.Add(new BETablaLogicaDatos { Codigo = Constantes.GuiaNegocioMarca.ValorPrecio.Esika, Descripcion = "ÉSIKA" });
            filterByBrand.Add(new BETablaLogicaDatos { Codigo = Constantes.GuiaNegocioMarca.ValorPrecio.LBel, Descripcion = "LBEL" });
            return filterByBrand;
        }

    }
}