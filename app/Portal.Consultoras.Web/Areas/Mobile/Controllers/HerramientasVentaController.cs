using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Controllers;
using Portal.Consultoras.Web.CustomFilters;
using Portal.Consultoras.Web.Infraestructure;
using Portal.Consultoras.Web.Models;
using System;
using System.Collections.Generic;
using System.ServiceModel;
using System.Web.Mvc;
using System.Linq;

namespace Portal.Consultoras.Web.Areas.Mobile.Controllers
{
    [UniqueSession("UniqueRoute", UniqueRoute.IdentifierKey, "/g/")]
    [ClearSessionMobileApp(UniqueRoute.IdentifierKey, "MobileAppConfiguracion", "StartSession")]
    public class HerramientasVentaController : BaseRevistaDigitalController
    {
        public ActionResult Index()
        {
            try
            {
                return RedirectToAction("Comprar", "HerramientasVenta", new { area = "Mobile" });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            return RedirectToAction("Index", "Bienvenida", new { area = "Mobile" });
        }

        public ActionResult Detalle(int id, int origen)
        {
            try
            {
                return RenderDetalle(id, origen);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            return RedirectToAction("Index", "Bienvenida", new { area = "Mobile" });
        }

        public virtual ActionResult RenderDetalle(int id, int origen)
        {
            var modelo = EstrategiaGetDetalle(id);
            var origenPantalla = GetPantallaOrigenPedidoWeb(origen);

            if (modelo == null || modelo.EstrategiaID <= 0)
                return GetRedirectTo(origenPantalla);

            ViewBag.OrigenUrl = GetActionTo(origenPantalla, origen);
            ViewBag.EstadoSuscripcion = revistaDigital.SuscripcionModel.EstadoRegistro;

            ViewBag.origenPedidoWebEstrategia = GetOrigenPedidoWebDetalle(origen);
            return View(modelo);
        }

        public virtual ActionResult GetRedirectTo(Enumeradores.PantallaOrigenPedidoWeb origenPantalla)
        {
            switch (origenPantalla)
            {
                case Enumeradores.PantallaOrigenPedidoWeb.Default:
                    return RedirectToAction("Index", "Ofertas", new { area = "Mobile" });
                case Enumeradores.PantallaOrigenPedidoWeb.Home:
                    return RedirectToAction("Index", "Bienvenida", new { area = "Mobile" });
                case Enumeradores.PantallaOrigenPedidoWeb.Pedido:
                    return RedirectToAction("Index", "Pedido", new { area = "Mobile" });
                case Enumeradores.PantallaOrigenPedidoWeb.RevistaDigital:
                    return RedirectToAction("Comprar", "RevistaDigital", new { area = "Mobile" });
                case Enumeradores.PantallaOrigenPedidoWeb.GuiaNegocioDigital:
                    return RedirectToAction("Index", "GuiaNegocio", new { area = "Mobile" });
                case Enumeradores.PantallaOrigenPedidoWeb.Liquidacion:
                case Enumeradores.PantallaOrigenPedidoWeb.CatalogoPersonalizado:
                case Enumeradores.PantallaOrigenPedidoWeb.ShowRoom:
                case Enumeradores.PantallaOrigenPedidoWeb.OfertaParaTi:
                case Enumeradores.PantallaOrigenPedidoWeb.General:
                default:
                    return RedirectToAction("Index", "Bienvenida", new { area = "Mobile" });
            }
        }

        public virtual Enumeradores.PantallaOrigenPedidoWeb GetPantallaOrigenPedidoWeb(int origen)
        {
            var pantallaString = Util.SubStr(
                origen.ToString(),
                Constantes.OrigenPedidoWeb.Campos.PANTALLA_INICIO,
                Constantes.OrigenPedidoWeb.Campos.PANTALLA_TAMANO
                );

            var pantalla = Enumeradores.PantallaOrigenPedidoWeb.Default;

            Enum.TryParse<Enumeradores.PantallaOrigenPedidoWeb>(pantallaString, out pantalla);

            return pantalla;
        }

        public virtual string GetActionTo(Enumeradores.PantallaOrigenPedidoWeb origenPantalla, int origenPedidoWeb)
        {
            string result;

            switch (origenPantalla)
            {
                case Enumeradores.PantallaOrigenPedidoWeb.Default:
                    result = Url.Action("Index", "Ofertas", new { area = "Mobile" });
                    break;
                case Enumeradores.PantallaOrigenPedidoWeb.Home:
                    result = Url.Action("Index", "Bienvenida", new { area = "Mobile" });
                    break;
                case Enumeradores.PantallaOrigenPedidoWeb.Pedido:
                    result = Url.Action("Index", "Pedido", new { area = "Mobile" });
                    break;
                case Enumeradores.PantallaOrigenPedidoWeb.RevistaDigital:
                    result = Url.Action("Comprar", "RevistaDigital", new { area = "Mobile" });
                    break;
                case Enumeradores.PantallaOrigenPedidoWeb.GuiaNegocioDigital:
                    result = Url.Action("Index", "GuiaNegocio", new { area = "Mobile" });
                    if (origenPedidoWeb == Constantes.OrigenPedidoWeb.OfertasParaTiMobileContenedor)
                    {
                        result = Url.Action("Index", "Ofertas", new { area = "Mobile" });
                    }
                    break;
                case Enumeradores.PantallaOrigenPedidoWeb.Liquidacion:
                case Enumeradores.PantallaOrigenPedidoWeb.CatalogoPersonalizado:
                case Enumeradores.PantallaOrigenPedidoWeb.ShowRoom:
                case Enumeradores.PantallaOrigenPedidoWeb.OfertaParaTi:
                case Enumeradores.PantallaOrigenPedidoWeb.General:
                    result = Url.Action("Index", "Bienvenida", new { area = "Mobile" });
                    break;
                case Enumeradores.PantallaOrigenPedidoWeb.HerramientasVentaComprar:
                    result = Url.Action("Comprar", "HerramientasVenta", new { area = "Mobile" });
                    break;
                case Enumeradores.PantallaOrigenPedidoWeb.HerramientasVentaRevisar:
                    result = Url.Action("Revisar", "HerramientasVenta", new { area = "Mobile" });
                    break;
                default:
                    result = Url.Action("Index", "Bienvenida", new { area = "Mobile" });
                    break;
            }

            return result;
        }

        public virtual int GetOrigenPedidoWebDetalle(int origenPantalla)
        {
            var result = 0;

            switch (origenPantalla)
            {
                case Constantes.OrigenPedidoWeb.OfertasParaTiMobileHome:
                    result = Constantes.OrigenPedidoWeb.OfertasParaTiMobileHomePopUp;
                    break;
                case Constantes.OrigenPedidoWeb.OfertasParaTiMobilePedido:
                    result = Constantes.OrigenPedidoWeb.OfertasParaTiMobilePedidoPopUp;
                    break;
                case Constantes.OrigenPedidoWeb.OfertasParaTiMobileContenedor:
                    result = Constantes.OrigenPedidoWeb.OfertasParaTiMobileContenedorPopup;
                    break;

                case Constantes.OrigenPedidoWeb.CatalogoPersonalizadoMobile:
                    result = Constantes.OrigenPedidoWeb.CatalogoPersonalizadoMobilePopUp;
                    break;

                case Constantes.OrigenPedidoWeb.RevistaDigitalMobileHomeSeccion:
                    result = Constantes.OrigenPedidoWeb.RevistaDigitalMobileHomePopUp;
                    break;
                case Constantes.OrigenPedidoWeb.RevistaDigitalMobilePedidoSeccion:
                    result = Constantes.OrigenPedidoWeb.RevistaDigitalMobilePedidoPopUp;
                    break;
                case Constantes.OrigenPedidoWeb.RevistaDigitalMobileLanding:
                    result = Constantes.OrigenPedidoWeb.RevistaDigitalMobileLandingPopUp;
                    break;

                case Constantes.OrigenPedidoWeb.RevistaDigitalMobileHomeLanzamiento:
                    result = Constantes.OrigenPedidoWeb.LanzamientoMobileHomePopup;
                    break;
                case Constantes.OrigenPedidoWeb.LanzamientoMobileContenedor:
                    result = Constantes.OrigenPedidoWeb.LanzamientoMobileContenedorPopup;
                    break;

                case Constantes.OrigenPedidoWeb.GNDMobileLanding:
                    result = Constantes.OrigenPedidoWeb.GNDMobileLandingPopup;
                    break;
            }

            result = result == 0 ? Constantes.OrigenPedidoWeb.OfertasParaTiMobileDetalle : result;

            return result;
        }

        public ActionResult Informacion(string tipo)
        {
            try
            {
                ViewBag.TipoLayout = tipo;
                return IndexModel();
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            return RedirectToAction("Index", "Bienvenida");
        }

        public ActionResult Comprar()
        {
            try
            {
                return ViewLandingHV(1);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            return RedirectToAction("Index", "Bienvenida");
        }

        public ActionResult Revisar()
        {
            try
            {
                return ViewLandingHV(2);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            return RedirectToAction("Index", "Bienvenida");
        }

        public ActionResult _Landing(int id)
        {
            try
            {
                return ViewLanding(id);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return PartialView("template-Landing", new RevistaDigitalModel());
            }
        }

        public ActionResult MensajeBloqueado()
        {
            try
            {
                return PartialView("template-mensaje-bloqueado", MensajeProductoBloqueado());
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
            return PartialView("template-mensaje-bloqueado", new MensajeProductoBloqueadoModel());
        }

        [HttpPost]
        public JsonResult ActualizarDatos(MisDatosModel model)
        {
            try
            {
                var usuario = Mapper.Map<MisDatosModel, ServiceUsuario.BEUsuario>(model);

                string resultado = ActualizarMisDatos(usuario, model.CorreoAnterior);
                bool seActualizoMisDatos = resultado.Split('|')[0] != "0";
                string message = resultado.Split('|')[2];
                int cantidad = int.Parse(resultado.Split('|')[3]);

                if (!seActualizoMisDatos)
                {
                    return Json(new
                    {
                        success = false,
                        message,
                        Cantidad = cantidad,
                        extra = string.Empty
                    });
                }
                else
                {
                    return Json(new
                    {
                        success = true,
                        message,
                        Cantidad = 0,
                        extra = string.Empty
                    });
                }
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    Cantidad = 0,
                    success = false,
                    message = "Ocurrió un error al acceder al servicio, intente nuevamente.",
                    extra = ""
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    Cantidad = 0,
                    success = false,
                    message = "Ocurrió un error al acceder al servicio, intente nuevamente.",
                    extra = ""
                });
            }
        }

        public enum Priority
        {
            Esika = 2,
            Lbel = 1,
            Cyzone = 3
        }

        [HttpPost]
        public JsonResult HVObtenerProductos(BusquedaProductoModel model)
        {
            try
            {
                if (herramientasVenta==null || EsCampaniaFalsa(model.CampaniaID))
                {
                    return Json(new
                    {
                        success = false,
                        message = "",
                        lista = new List<ShowRoomOfertaModel>(),
                        cantidadTotal = 0,
                        cantidad = 0
                    });
                }

                ViewBag.EsMobile = model.IsMobile ? 2 : 1;

                var palanca = Constantes.TipoEstrategiaCodigo.HerramientasVenta;

                var listaFinal1 = ConsultarEstrategiasModel("", model.CampaniaID, palanca);
                var listModel = ConsultarEstrategiasFormatearModelo(listaFinal1, 2);

                listModel = listModel.Where(e => e.CodigoEstrategia == Constantes.TipoEstrategiaCodigo.HerramientasVenta).ToList();

                var defaultOrder = new List<int> { 2, 1, 3 };

                listModel = listModel.OrderBy(x =>
                                            {
                                                var index = defaultOrder.IndexOf(x.MarcaID);
                                                return index == -1 ? int.MaxValue : index;
                                            }).ToList();
                
                var cantidadTotal = listModel.Count;


                return Json(new
                {
                    success = true,
                    lista = listModel,
                    listaPerdio = new List<EstrategiaPersonalizadaModel>(),
                    cantidadTotal = cantidadTotal,
                    cantidad = cantidadTotal,
                    campaniaId = model.CampaniaID
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Error al cargar los productos",
                    data = ""
                });
            }
        }
    }
}