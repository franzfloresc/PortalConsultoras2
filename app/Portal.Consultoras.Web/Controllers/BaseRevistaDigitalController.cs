using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceSAC;
using System.Collections.Generic;
using System.Configuration;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class BaseRevistaDigitalController : BaseEstrategiaController
    {
        public ActionResult IndexModel()
        {
            if (revistaDigital.TieneRDR)
                return RedirectToAction("Index", "Ofertas", new { area = IsMobile() ? "Mobile" : "" });
            
            if (!revistaDigital.TieneRDC && !revistaDigital.TieneRDS)
                return RedirectToAction("Index", "Ofertas", new { area = IsMobile() ? "Mobile" : "" });

            revistaDigital.NumeroContacto = Util.Trim(ConfigurationManager.AppSettings["BelcorpRespondeTEL_" + userData.CodigoISO]);
            revistaDigital.NombreConsultora = userData.UsuarioNombre;
            return View("template-informativa", revistaDigital);
        }

        public ActionResult ViewLanding(int tipo)
        {
            var id = tipo == 1 ? userData.CampaniaID : AddCampaniaAndNumero(userData.CampaniaID, 1);

            var model = new RevistaDigitalLandingModel();
            if (EsCampaniaFalsa(id)) return PartialView("template-landing", model);

            model.CampaniaID = id;
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
            model.ProductosPerdio = TieneProductosPerdio(model.CampaniaID);

            if (model.ProductosPerdio)
            {
                model.PerdioTitulo = revistaDigital.NombreConsultora + ", POR SI TE LO PERDISTE";
                model.PerdioSubTitulo = "GANA MÁS CON OFERTAS PARA SUSCRIPTORAS DESDE C-" + revistaDigital.CampaniaActiva;
            }

            model.MensajeProductoBloqueado = MensajeProductoBloqueado();
            model.CantidadFilas = 10;
            return PartialView("template-landing", model);
        }

        public ActionResult DetalleModel(string cuv, int campaniaId)
        {
            var modelo = (EstrategiaPersonalizadaProductoModel)Session[Constantes.ConstSession.ProductoTemporal];
            if (modelo == null || modelo.EstrategiaID == 0 || modelo.CUV2 != cuv || modelo.CampaniaID != campaniaId)
            {
                return RedirectToAction("Index", "RevistaDigital", new { area = IsMobile() ? "Mobile" : "" });
            }

            if (!revistaDigital.TieneRDC && !revistaDigital.TieneRDR)
            {
                return RedirectToAction("Index", "RevistaDigital", new { area = IsMobile() ? "Mobile" : "" });
            }
            if (EsCampaniaFalsa(modelo.CampaniaID))
            {
                return RedirectToAction("Index", "RevistaDigital", new { area = IsMobile() ? "Mobile" : "" });
            }
            if (modelo.EstrategiaID <= 0)
            {
                return RedirectToAction("Index", "RevistaDigital", new { area = IsMobile() ? "Mobile" : "" });
            }

            modelo.TipoEstrategiaDetalle = modelo.TipoEstrategiaDetalle ?? new EstrategiaDetalleModelo();
            modelo.ListaDescripcionDetalle = modelo.ListaDescripcionDetalle ?? new List<string>();

            ViewBag.EstadoSuscripcion = revistaDigital.SuscripcionModel.EstadoRegistro;
            ViewBag.TieneProductosPerdio = TieneProductosPerdio(modelo.CampaniaID);
            if (ViewBag.TieneProductosPerdio)
            {
                ViewBag.PerdioTitulo = revistaDigital.NombreConsultora + ", POR SI TE LO PERDISTE";
                ViewBag.PerdioSubTitulo = "GANA MÁS CON OFERTAS PARA SUSCRIPTORAS DESDE C-" + revistaDigital.CampaniaActiva;
            }

            ViewBag.Campania = campaniaId;
            return View(modelo);

        }

        public bool EsCampaniaFalsa(int campaniaId)
        {
            return (campaniaId < userData.CampaniaID || campaniaId > AddCampaniaAndNumero(userData.CampaniaID, 1));
        }

        public MensajeProductoBloqueadoModel MensajeProductoBloqueado()
        {
            var model = new MensajeProductoBloqueadoModel();

            if (!revistaDigital.TieneRDC) return model;

            model.IsMobile = IsMobile();

            if (!revistaDigital.EsActiva)
            {
                if (revistaDigital.EsSuscrita)
                {
                    model.MensajeIconoSuperior = true;
                    model.MensajeTitulo = model.IsMobile
                        ? "PODRÁS AGREGARLA EN LA CAMPAÑA " + revistaDigital.CampaniaActiva
                        : "PODRÁS AGREGAR OFERTAS COMO ESTA EN LA CAMPAÑA " + revistaDigital.CampaniaActiva;
                    model.BtnInscribirse = false;
                }
                else
                {
                    model.MensajeIconoSuperior = false;
                    model.MensajeTitulo = model.IsMobile
                        ? "INSCRÍBETE HOY EN ÉSIKA PARA MÍ Y NO TE PIERDAS EN C-" + revistaDigital.CampaniaActiva + "<br />OFERTAS COMO ESTA"
                        : "INSCRÍBETE HOY EN ÉSIKA PARA MÍ Y NO TE PIERDAS EN CAMPAÑA " + revistaDigital.CampaniaActiva + " OFERTAS COMO ESTA";
                    model.BtnInscribirse = true;
                }
            }

            return model;
        }

        public bool TieneProductosPerdio(int campaniaID)
        {
            if (!revistaDigital.EsActiva &&
                campaniaID == userData.CampaniaID)
                return true;

            return false;
        }

    }
}