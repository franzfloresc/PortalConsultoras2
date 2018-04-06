using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceSAC;
using System.Collections.Generic;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class BaseHerramientasVentaController : BaseEstrategiaController
    {
        public ActionResult ViewLanding(int tipo)
        {
            var id = tipo == 1 ? userData.CampaniaID : AddCampaniaAndNumero(userData.CampaniaID, 1);

            var model = new RevistaDigitalLandingModel
            {
                CampaniaID = id,
                IsMobile = IsMobile(),
                FiltersBySorting = GetFiltersBySorting(),
                FiltersByBrand = GetFiltersByBrand(),
                Success = true,
                MensajeProductoBloqueado = MensajeProductoBloqueado(),
                CantidadFilas = 10
            };

            return PartialView("template-landing", model);
        }

        public bool EsCampaniaFalsa(int campaniaId)
        {
            return (campaniaId < userData.CampaniaID || campaniaId > AddCampaniaAndNumero(userData.CampaniaID, 1));
        }
        
        public List<BETablaLogicaDatos> GetFiltersBySorting()
        {
            var filtersBySorting = new List<BETablaLogicaDatos>
            {
                new BETablaLogicaDatos
                {
                    Codigo = Constantes.GuiaNegocioTipoOrdenamiento.ValorPrecio.Predefinido,
                    Descripcion = "ORDENAR POR"
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
                    Descripcion = "FILTRAR POR"
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

        public override MensajeProductoBloqueadoModel MensajeProductoBloqueado()
        {
            return HVMensajeProductoBloqueado();
        }
    }
}