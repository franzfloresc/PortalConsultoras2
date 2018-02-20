using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceSAC;
using System;
using System.Collections.Generic;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class BaseHerramientasVentaController : BaseEstrategiaController
    {

        public ActionResult ViewLanding(int tipo)
        {
            var id = tipo == 1 ? userData.CampaniaID : AddCampaniaAndNumero(userData.CampaniaID, 1);

            var model = new HerramientasVentaLandingModel();

            model.CampaniaID = id;
            model.IsMobile = IsMobile();

            model.FiltersBySorting = new List<BETablaLogicaDatos>
            {
                new BETablaLogicaDatos
                {
                    Codigo = Constantes.ShowRoomTipoOrdenamiento.ValorPrecio.Predefinido,
                    Descripcion = model.IsMobile ? "ORDENAR POR" : "ORDENAR POR PRECIO"
                },
                new BETablaLogicaDatos
                {
                    Codigo = Constantes.ShowRoomTipoOrdenamiento.ValorPrecio.MenorAMayor,
                    Descripcion = model.IsMobile ? "MENOR PRECIO" : "MENOR A MAYOR PRECIO"
                },
                new BETablaLogicaDatos
                {
                    Codigo = Constantes.ShowRoomTipoOrdenamiento.ValorPrecio.MayorAMenor,
                    Descripcion = model.IsMobile ? "MAYOR PRECIO" : "MAYOR A MENOR PRECIO"
                }
            };

            model.FiltersByBrand = new List<BETablaLogicaDatos>
            {
                new BETablaLogicaDatos {Codigo = "-", Descripcion = model.IsMobile ? "MARCAS" : "FILTRAR POR MARCA"},
                new BETablaLogicaDatos {Codigo = "CYZONE", Descripcion = "CYZONE"},
                new BETablaLogicaDatos {Codigo = "ÉSIKA", Descripcion = "ÉSIKA"},
                new BETablaLogicaDatos {Codigo = "LBEL", Descripcion = "LBEL"}
            };

            model.Success = true;
            model.MensajeProductoBloqueado = MensajeProductoBloqueado();
            model.CantidadFilas = 10;

            return PartialView("template-landing", model);
        }

        public bool EsCampaniaFalsa(int campaniaId)
        {
            return (campaniaId < userData.CampaniaID || campaniaId > AddCampaniaAndNumero(userData.CampaniaID, 1));
        }

        public ActionResult ViewLandingHV(int tipo)
        {
            var id = tipo == 1 ? userData.CampaniaID : AddCampaniaAndNumero(userData.CampaniaID, 1);

            var model = new RevistaDigitalLandingModel();
            if (EsCampaniaFalsa(id)) return PartialView("template-landing", model);

            model.CampaniaID = id;
            model.IsMobile = IsMobile();

            model.FiltersBySorting = new List<BETablaLogicaDatos>
            {
                new BETablaLogicaDatos
                {
                    Codigo = Constantes.ShowRoomTipoOrdenamiento.ValorPrecio.Predefinido,
                    Descripcion = model.IsMobile ? "ORDENAR POR" : "ORDENAR POR PRECIO"
                },
                new BETablaLogicaDatos
                {
                    Codigo = Constantes.ShowRoomTipoOrdenamiento.ValorPrecio.MenorAMayor,
                    Descripcion = model.IsMobile ? "MENOR PRECIO" : "MENOR A MAYOR PRECIO"
                },
                new BETablaLogicaDatos
                {
                    Codigo = Constantes.ShowRoomTipoOrdenamiento.ValorPrecio.MayorAMenor,
                    Descripcion = model.IsMobile ? "MAYOR PRECIO" : "MAYOR A MENOR PRECIO"
                }
            };

            model.FiltersByBrand = new List<BETablaLogicaDatos>
            {
                new BETablaLogicaDatos {Codigo = "-", Descripcion = model.IsMobile ? "MARCAS" : "FILTRAR POR MARCA"},
                new BETablaLogicaDatos {Codigo = "CYZONE", Descripcion = "CYZONE"},
                new BETablaLogicaDatos {Codigo = "ÉSIKA", Descripcion = "ÉSIKA"},
                new BETablaLogicaDatos {Codigo = "LBEL", Descripcion = "LBEL"}
            };

            model.Success = true;

            model.MensajeProductoBloqueado = MensajeProductoBloqueado();
            model.CantidadFilas = 10;

            ViewBag.TieneHV = true;
            ViewBag.OrigenPedidoWeb = tipo == 1 ? Constantes.OrigenPedidoWeb.HerramientasVentaMobileLandingComprar : Constantes.OrigenPedidoWeb.HerramientasVentaMobileLandingRevisar;
            return PartialView("template-landing", model);
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

        public override MensajeProductoBloqueadoModel MensajeProductoBloqueado()
        {
            return HVMensajeProductoBloqueado();
        }
    }
}