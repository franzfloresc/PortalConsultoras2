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
    }
}