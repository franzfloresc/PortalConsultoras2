using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceSAC;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class BaseRevistaDigitalController : BaseEstrategiaController
    {
        public ActionResult IndexModel()
        {
            var model = new RevistaDigitalModel();
            model.EstadoAccion = -1;
            model.IsMobile = ViewBag.EsMobile == 2;

            if (!userData.RevistaDigital.TieneRDC && !userData.RevistaDigital.TieneRDR)
            {
                if (!userData.RevistaDigital.TieneRDS)
                {
                    return RedirectToAction("Index", "Bienvenida", new { area = model.IsMobile ? "Mobile" : "" });
                }

                if (userData.RevistaDigital.SuscripcionModel.EstadoRegistro != Constantes.EstadoRDSuscripcion.Activo)
                {
                    return RedirectToAction("Index", "Bienvenida", new { area = model.IsMobile ? "Mobile" : "" });
                }
            }
            
            model = ListarTabs(model);

            if (model.EstadoAccion < 0)
                return RedirectToAction("Index", "Bienvenida", new { area = model.IsMobile ? "Mobile" : "" });

            model.EstadoSuscripcion = userData.RevistaDigital.SuscripcionModel.EstadoRegistro;
            model.CampaniaMasUno = AddCampaniaAndNumero(userData.CampaniaID, 1) % 100;
            model.CampaniaMasDos = AddCampaniaAndNumero(userData.CampaniaID, 2) % 100;

            model.NumeroContacto = Util.Trim(ConfigurationManager.AppSettings["BelcorpRespondeTEL_" + userData.CodigoISO]);

            return View("Index", model);
        }

        public ActionResult ViewLanding(int id, string tipo)
        {
            var model = new RevistaDigitalModel();
            if (EsCampaniaFalsa(id)) return PartialView("template-Landing", model);

            model.CampaniaID = id;
            model.Success = true;
            model.IsMobile = ViewBag.EsMobile == 2;

            model.FiltersBySorting = new List<BETablaLogicaDatos>();
            model.FiltersBySorting.Add(new BETablaLogicaDatos { Codigo = Constantes.ShowRoomTipoOrdenamiento.ValorPrecio.Predefinido, Descripcion = model.IsMobile ? "LO MÁS VENDIDO" : "ORDENAR POR PRECIO" });
            model.FiltersBySorting.Add(new BETablaLogicaDatos { Codigo = Constantes.ShowRoomTipoOrdenamiento.ValorPrecio.MenorAMayor, Descripcion = model.IsMobile ? "MENOR PRECIO" : "MENOR A MAYOR PRECIO" });
            model.FiltersBySorting.Add(new BETablaLogicaDatos { Codigo = Constantes.ShowRoomTipoOrdenamiento.ValorPrecio.MayorAMenor, Descripcion = model.IsMobile ? "MAYOR PRECIO" : "MAYOR A MENOR PRECIO" });

            var codAgrupa = userData.RevistaDigital.TieneRDR || userData.RevistaDigital.TieneRDC ? Constantes.TipoEstrategiaCodigo.RevistaDigital : "";

            tipo = Util.Trim(tipo);
            if (codAgrupa != "" && tipo == Constantes.TipoEstrategiaCodigo.OfertaParaTi)
                codAgrupa = "";

            var listaProducto = ConsultarEstrategiasModel("", id, codAgrupa);
            model.ListaProducto = listaProducto.Where(e => e.TipoEstrategia.Codigo == Constantes.TipoEstrategiaCodigo.Lanzamiento).ToList() ?? new List<EstrategiaPedidoModel>();
            var listadoNoLanzamiento = listaProducto.Where(e => e.TipoEstrategia.Codigo != Constantes.TipoEstrategiaCodigo.Lanzamiento).ToList() ?? new List<EstrategiaPedidoModel>();

            var listaMarca = listadoNoLanzamiento.GroupBy(p => p.DescripcionMarca).ToList();
            model.FiltersByBrand = new List<BETablaLogicaDatos>();
            if (listaMarca.Any())
            {
                model.FiltersByBrand.Add(new BETablaLogicaDatos { Codigo = "-", Descripcion = model.IsMobile ? "MARCAS" : "FILTRAR POR MARCA" });
                foreach (var marca in listaMarca)
                {
                    model.FiltersByBrand.Add(new BETablaLogicaDatos { Codigo = marca.Key, Descripcion = marca.Key.ToUpper() });
                }
            }

            if (listadoNoLanzamiento.Any())
            {
                model.PrecioMin = listadoNoLanzamiento.Min(p => p.Precio2);
                model.PrecioMax = listadoNoLanzamiento.Max(p => p.Precio2);
            }

            return PartialView("template-Landing", model);
        }

        public ActionResult DetalleModel(int id, int campaniaId = 0)
        {
            if (!userData.RevistaDigital.TieneRDC && !userData.RevistaDigital.TieneRDR)
            {
                return RedirectToAction("Index", "RevistaDigital", new { area = ViewBag.EsMobile == 2 ? "Mobile" : "" });
            }
            if (EsCampaniaFalsa(campaniaId))
            {
                return RedirectToAction("Index", "RevistaDigital", new { area = ViewBag.EsMobile == 2 ? "Mobile" : "" });
            }

            var listaProducto = ConsultarEstrategiasModel("", campaniaId, Constantes.TipoEstrategiaCodigo.RevistaDigital);
            var model = listaProducto.FirstOrDefault(e => e.EstrategiaID == id) ?? new EstrategiaPedidoModel();
            model.EstrategiaDetalle = model.EstrategiaDetalle ?? new EstrategiaDetalleModelo();
            if (model.EstrategiaID > 0)
            {
                return View(model);
            }
            return RedirectToAction("Index", "RevistaDigital", new { area = ViewBag.EsMobile == 2 ? "Mobile" : "" });
        }

        public bool EsCampaniaFalsa(int campaniaId)
        {
            return (campaniaId < userData.CampaniaID || campaniaId > AddCampaniaAndNumero(userData.CampaniaID, 1));
        }

        public RevistaDigitalModel ListarTabs(RevistaDigitalModel model = null)
        {
            model = model ?? new RevistaDigitalModel();
            model.EstadoAccion = -1;
            model.ListaTabs = new List<ComunModel>();

            model.Titulo = userData.UsuarioNombre.ToUpper();
            model.TituloDescripcion = "";
            string cadenaActiva = "COMPRAR CAMPAÑA ";

            if (userData.RevistaDigital.TieneRDC)
            {
                model = ListarTabsRD(model);
                return model;
            }

            var addTagInfo = false;

            if (userData.RevistaDigital.TieneRDS)
            {
                if (!userData.RevistaDigital.TieneRDR)
                {
                    if (userData.RevistaDigital.SuscripcionModel.CampaniaID == userData.CampaniaID)
                    {
                        model.Titulo += ", YA ESTÁS INSCRITA A TU NUEVA REVISTA ONLINE PERSONALIZADA <br />";
                        model.TituloDescripcion = "INGRESA A ÉSIKA PARA MÍ A PARTIR DE LA PRÓXIMA CAMPAÑA Y DESCUBRE TODAS LAS OFERTAS QUE TENEMOS ÚNICAMENTE PARA TI";
                    }
                    else
                    {
                        model.Titulo += ", DESCUBRE TU NUEVA REVISTA ONLINE PERSONALIZADA <br />";
                        model.TituloDescripcion = "ENCUENTRA OFERTAS, BONIFICACIONES, Y LANZAMIENTOS DE LAS 3 MARCAS. TODOS LOS PRODUCTOS TAMBIÉN SUMAN PUNTOS.";
                    }

                    model.ListaTabs.Add(new ComunModel { Id = 0, Descripcion = model.NombreRevista });
                    model.EstadoAccion = 0;
                    return model;
                }

                addTagInfo = true;
            }
            else if (!userData.RevistaDigital.TieneRDR)
            {
                model.EstadoAccion = -1;
                return model;
            }

            model.EstadoAccion = 1;
            model.Titulo += ", DESCUBRE TU NUEVA REVISTA ONLINE PERSONALIZADA<br />";
            model.TituloDescripcion = "ENCUENTRA OFERTAS, BONIFICACIONES, Y LANZAMIENTOS DE LAS 3 MARCAS. TODOS LOS PRODUCTOS TAMBIÉN SUMAN PUNTOS.";
            model.ListaTabs.Add(new ComunModel { Id = userData.CampaniaID, Descripcion = cadenaActiva + userData.CampaniaID.Substring(4, 2) });
            if (addTagInfo) model.ListaTabs.Add(new ComunModel { Id = 0, Descripcion = model.NombreRevista });
            
            return model;
        }

        public RevistaDigitalModel ListarTabsRD(RevistaDigitalModel model = null)
        {
            model = model ?? new RevistaDigitalModel();
            model.EstadoAccion = -1;
            model.ListaTabs = new List<ComunModel>();

            if (!userData.RevistaDigital.TieneRDC) return model;

            if (userData.RevistaDigital.SuscripcionModel.CampaniaID > userData.CampaniaID)
                return model;

            model.Titulo = userData.UsuarioNombre.ToUpper();

            string cadenaActiva = model.IsMobile ? "COMPRAR C " : "COMPRAR CAMPAÑA ", cadenaBloqueado = model.IsMobile ? "VER C " : "VER CAMPAÑA ";

            if (userData.RevistaDigital.SuscripcionAnteriorModel.EstadoRegistro == Constantes.EstadoRDSuscripcion.Activo)
            {
                model.Titulo += ", LLEGÓ TU NUEVA REVISTA ONLINE PERSONALIZADA <br />";
                model.TituloDescripcion = "ENCUENTRA OFERTAS, BONIFICACIONES, Y LANZAMIENTOS DE LAS 3 MARCAS. TODOS LOS PRODUCTOS TAMBIÉN SUMAN PUNTOS.";
                model.EstadoAccion = AddCampaniaAndNumero(userData.CampaniaID, 1);
                model.ListaTabs.Add(new ComunModel { Id = userData.CampaniaID, Descripcion = cadenaActiva + userData.CampaniaID.Substring(4, 2) });
                model.ListaTabs.Add(new ComunModel { Id = model.EstadoAccion, Descripcion = cadenaBloqueado + model.EstadoAccion.Substring(4, 2) });
                model.ListaTabs.Add(new ComunModel { Id = 0, Descripcion = model.NombreRevista });
                return model;
            }

            if (userData.RevistaDigital.SuscripcionModel.EstadoRegistro == Constantes.EstadoRDSuscripcion.Activo)
            {
                if (userData.RevistaDigital.SuscripcionModel.CampaniaID == userData.CampaniaID)
                {
                    model.Titulo += ", YA ESTÁS INSCRITA A TU NUEVA REVISTA ONLINE PERSONALIZADA <br />";
                    model.TituloDescripcion = "INGRESA A ÉSIKA PARA MÍ A PARTIR DE LA PRÓXIMA CAMPAÑA Y DESCUBRE TODAS LAS OFERTAS QUE TENEMOS ÚNICAMENTE PARA TI";
                }
                else if (userData.RevistaDigital.SuscripcionModel.CampaniaID == AddCampaniaAndNumero(userData.CampaniaID, -1))
                {
                    model.Titulo += ", LLEGÓ TU NUEVA REVISTA ONLINE PERSONALIZADA <br />";
                    model.TituloDescripcion = "ENCUENTRA OFERTAS, BONIFICACIONES Y LANZAMIENTOS DE LAS 3 MARCAS. RECUERDA QUE PODRÁS AGREGARLOS A PARTIRÁ DE LA PRÓXIMA CAMPAÑA";
                }
                else
                {
                    return model;
                }
            }
            else
            {
                model.Titulo += ", INSCRÍBETE A TU NUEVA REVISTA ONLINE PERSONALIZADA <br />";
                model.TituloDescripcion = "INCREMENTA EN 20% TU GANANCIA REEMPLAZANDO TU REVISTA IMPRESA POR TU REVISTA ONLINE.";
            }

            string cadenaOpt = model.IsMobile ? "COMPRAR OPT C " : "COMPRAR OPT CAMPAÑA ";
            model.EstadoAccion = AddCampaniaAndNumero(userData.CampaniaID, 1);
            model.ListaTabs.Add(new ComunModel { Id = userData.CampaniaID, Descripcion = cadenaOpt + userData.CampaniaID.Substring(4, 2), ValorOpcional = Constantes.TipoEstrategiaCodigo.OfertaParaTi });
            model.ListaTabs.Add(new ComunModel { Id = model.EstadoAccion, Descripcion = cadenaBloqueado + model.EstadoAccion.Substring(4, 2) });
            model.ListaTabs.Add(new ComunModel { Id = 0, Descripcion = model.NombreRevista });

            return model;
        }

    }
}