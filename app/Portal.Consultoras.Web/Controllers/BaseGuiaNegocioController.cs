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
            //
            ViewBag.CampaniaActual = userData.CampaniaID.ToString();
            ViewBag.CampaniaAnterior = AddCampaniaAndNumero(userData.CampaniaID, -1).ToString();
            ViewBag.CampaniaSiguiente = AddCampaniaAndNumero(userData.CampaniaID, 1).ToString();
            //
            ViewBag.CodigoRevistaActual = GetRevistaCodigoIssuu(ViewBag.CampaniaActual);
            ViewBag.CodigoRevistaAnterior = GetRevistaCodigoIssuu(ViewBag.CampaniaAnterior);
            ViewBag.CodigoRevistaSiguiente = GetRevistaCodigoIssuu(ViewBag.CampaniaSiguiente);

            var model = new RevistaDigitalLandingModel
            {
                CampaniaID = userData.CampaniaID,
                IsMobile = IsMobile(),
                FiltersBySorting = GetFiltersBySorting(),
                FiltersByBrand = GetFiltersByBrand(),
                Success = true,
                CantidadFilas = 10
            };

            return PartialView("Index", model);
        }

        public List<BETablaLogicaDatos> GetFiltersBySorting()
        {
            var filtersBySorting = new List<BETablaLogicaDatos>
            {
                new BETablaLogicaDatos
                {
                    Codigo = Constantes.GuiaNegocioTipoOrdenamiento.ValorPrecio.Predefinido,
                    Descripcion = IsMobile() ? "ORDENAR POR" : "ORDENAR POR PRECIO"
                },
                new BETablaLogicaDatos
                {
                    Codigo = Constantes.GuiaNegocioTipoOrdenamiento.ValorPrecio.MenorAMayor,
                    Descripcion = IsMobile() ? "MENOR PRECIO" : "MENOR A MAYOR PRECIO"
                },
                new BETablaLogicaDatos
                {
                    Codigo = Constantes.GuiaNegocioTipoOrdenamiento.ValorPrecio.MayorAMenor,
                    Descripcion = IsMobile() ? "MAYOR PRECIO" : "MAYOR A MENOR PRECIO"
                }
            };
            return filtersBySorting;
        }

        public List<BETablaLogicaDatos> GetFiltersByBrand()
        {
            var filterByBrand = new List<BETablaLogicaDatos>
            {
                new BETablaLogicaDatos
                {
                    Codigo = Constantes.GuiaNegocioMarca.ValorPrecio.Predefinido,
                    Descripcion = IsMobile() ? "MARCA" : "FILTRAR POR MARCA"
                },
                new BETablaLogicaDatos
                {
                    Codigo = Constantes.GuiaNegocioMarca.ValorPrecio.Cyzone,
                    Descripcion = "CYZONE"
                },
                new BETablaLogicaDatos {Codigo = Constantes.GuiaNegocioMarca.ValorPrecio.Esika, Descripcion = "ÉSIKA"},
                new BETablaLogicaDatos {Codigo = Constantes.GuiaNegocioMarca.ValorPrecio.LBel, Descripcion = "LBEL"}
            };
            return filterByBrand;
        }

    }
}