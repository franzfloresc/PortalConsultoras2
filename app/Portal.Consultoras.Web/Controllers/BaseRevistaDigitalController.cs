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
            if (!revistaDigital.TieneRDC && !revistaDigital.TieneRDR)
            {
                if (!revistaDigital.TieneRDS)
                    return RedirectToAction("Index", "Bienvenida", new { area = IsMobile() ? "Mobile" : "" });

                if (revistaDigital.SuscripcionModel.EstadoRegistro != Constantes.EstadoRDSuscripcion.Activo)
                    return RedirectToAction("Index", "Bienvenida", new { area = IsMobile() ? "Mobile" : "" });
            }
            revistaDigital.EstadoSuscripcion = revistaDigital.SuscripcionModel.EstadoRegistro;
            revistaDigital.NumeroContacto = Util.Trim(ConfigurationManager.AppSettings["BelcorpRespondeTEL_" + userData.CodigoISO]);
            revistaDigital.Nombre = userData.UsuarioNombre;
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
            ViewBag.TieneProductosPerdio = TieneProductosPerdio(model.CampaniaID);
            ViewBag.NombreConsultora = userData.Sobrenombre;
            var campaniaX2 = revistaDigital.SuscripcionAnterior1Model.CampaniaID > 0 && revistaDigital.SuscripcionAnterior1Model.EstadoRegistro == Constantes.EstadoRDSuscripcion.Activo
                ? revistaDigital.SuscripcionAnterior1Model.CampaniaID : userData.CampaniaID;
            ViewBag.CampaniaMasDos = AddCampaniaAndNumero(campaniaX2, 2) % 100;
            ViewBag.EstadoSuscripcion = revistaDigital.SuscripcionModel.EstadoRegistro;
            model.MensajeProductoBloqueado = MensajeProductoBloqueado();
            model.UrlTerminosCondicionesRD = Util.Trim(ConfigurationManager.AppSettings["UrlTerminosCondicionesRD"]);
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

        public MensajeProductoBloqueadoModel MensajeProductoBloqueado()
        {
            var model = new MensajeProductoBloqueadoModel();
            model.IsMobile = IsMobile();
            if (revistaDigital.SuscripcionAnterior1Model.EstadoRegistro == Constantes.EstadoRDSuscripcion.Activo)
            {
                if (revistaDigital.SuscripcionModel.EstadoRegistro == Constantes.EstadoRDSuscripcion.Activo)
                {
                    model.MensajeIconoSuperior = true;
                    model.MensajeTitulo = model.IsMobile
                        ? "PODRÁS AGREGARLA EN LA PRÓXIMA CAMPAÑA"
                        : "PODRÁS AGREGAR ESTA OFERTA A PARTIR DE LA PRÓXIMA CAMPAÑA";
                    model.BtnInscribirse = false;
                }
                else
                {
                    model.MensajeIconoSuperior = false;
                    model.MensajeTitulo = model.IsMobile
                        ? "INSCRÍBETE HOY EN ÉSIKA PARA MÍ Y NO TE PIERDAS EN C-" + AddCampaniaAndNumero(userData.CampaniaID, 2).Substring(4, 2) + "<br />OFERTAS COMO ESTA"
                        : "INSCRÍBETE HOY EN ÉSIKA PARA MÍ Y NO TE PIERDAS EN CAMPAÑA " + AddCampaniaAndNumero(userData.CampaniaID, 2).Substring(4, 2) + " OFERTAS COMO ESTA";
                    model.BtnInscribirse = true;
                }
            }
            else
            {
                if (revistaDigital.SuscripcionModel.EstadoRegistro == Constantes.EstadoRDSuscripcion.Activo)
                {
                    model.MensajeIconoSuperior = true;
                    model.MensajeTitulo = model.IsMobile
                        ? "PODRÁS AGREGARLA EN LA CAMPAÑA " + AddCampaniaAndNumero(userData.CampaniaID, 2).Substring(4, 2)
                        : "PODRÁS AGREGAR OFERTAS COMO ESTA EN LA CAMPAÑA " + AddCampaniaAndNumero(userData.CampaniaID, 2).Substring(4, 2);
                    model.BtnInscribirse = false;
                }
                else
                {
                    model.MensajeIconoSuperior = false;
                    model.MensajeTitulo = model.IsMobile
                        ? "INSCRÍBETE HOY EN ÉSIKA PARA MÍ Y NO TE PIERDAS EN C-" + AddCampaniaAndNumero(userData.CampaniaID, 2).Substring(4, 2) + "<br />OFERTAS COMO ESTA"
                        : "INSCRÍBETE HOY EN ÉSIKA PARA MÍ Y NO TE PIERDAS EN CAMPAÑA " + AddCampaniaAndNumero(userData.CampaniaID, 2).Substring(4, 2) + " OFERTAS COMO ESTA";
                    model.BtnInscribirse = true;
                }
            }

            return model;
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