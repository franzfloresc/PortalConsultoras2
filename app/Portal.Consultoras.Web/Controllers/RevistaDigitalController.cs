using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServicePedido;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class RevistaDigitalController : BaseRevistaDigitalController
    {
        public ActionResult Index()
        {
            try
            {
                return RedirectToAction("Index", "Ofertas");
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            return RedirectToAction("Index", "Bienvenida");
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
                return ViewLanding(1);
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
                return ViewLanding(2);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            return RedirectToAction("Index", "Bienvenida");
        }

        [HttpPost]
        public JsonResult GuardarProductoTemporal(EstrategiaPersonalizadaProductoModel modelo)
        {
            if (modelo != null)
            {
                modelo.ClaseBloqueada = Util.Trim(modelo.ClaseBloqueada);
                modelo.ClaseEstrategia = Util.Trim(modelo.ClaseEstrategia);
                modelo.CodigoEstrategia = Util.Trim(modelo.CodigoEstrategia);
                modelo.DescripcionResumen = Util.Trim(modelo.DescripcionResumen);
                modelo.DescripcionDetalle = Util.Trim(modelo.DescripcionDetalle);
                modelo.DescripcionCompleta = Util.Trim(modelo.DescripcionCompleta);
                modelo.PrecioTachado = Util.Trim(modelo.PrecioTachado);
                modelo.CodigoVariante = Util.Trim(modelo.CodigoVariante);
                modelo.TextoLibre = Util.Trim(modelo.TextoLibre);
                modelo.UrlCompartir = Util.Trim(modelo.UrlCompartir);
            }

            Session[Constantes.ConstSession.ProductoTemporal] = modelo;

            return Json(new
            {
                success = true
            }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult Detalle(string cuv, int campaniaId)
        {
            try
            {
                return DetalleModel(cuv, campaniaId);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            return RedirectToAction("Index", "RevistaDigital");
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
                return PartialView("template-Landing", new RevistaDigitalLandingModel());
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
        public JsonResult RDObtenerProductos(BusquedaProductoModel model)
        {
            try
            {
                if (!(revistaDigital.TieneRDC || revistaDigital.TieneRDR) || EsCampaniaFalsa(model.CampaniaID))
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

                var palanca = model.CampaniaID != userData.CampaniaID || revistaDigital.TieneRDR
                    ? Constantes.TipoEstrategiaCodigo.RevistaDigital
                    : revistaDigital.TieneRDC && revistaDigital.SuscripcionAnterior2Model.EstadoRegistro == Constantes.EstadoRDSuscripcion.Activo
                        ? Constantes.TipoEstrategiaCodigo.RevistaDigital
                        : "";

                var listaFinal1 = ConsultarEstrategiasModel("", model.CampaniaID, palanca);
                var listModel = ConsultarEstrategiasFormatearModelo(listaFinal1, 2);
                
                listModel = listModel.Where(e => e.CodigoEstrategia != Constantes.TipoEstrategiaCodigo.Lanzamiento).ToList();

                int cantidadTotal = listModel.Count;

                var listPerdio = new List<EstrategiaPersonalizadaProductoModel>();
                if (TieneProductosPerdio(model.CampaniaID))
                {
                    var listPerdio1 = ConsultarEstrategiasModel("", model.CampaniaID, Constantes.TipoEstrategiaCodigo.RevistaDigital);
                    listPerdio1 = listPerdio1.Where(p => p.TipoEstrategia.Codigo != Constantes.TipoEstrategiaCodigo.PackNuevas).ToList();
                    listPerdio = ConsultarEstrategiasFormatearModelo(listPerdio1, 1);
                    
                    listPerdio = listPerdio.Where(e => e.CodigoEstrategia != Constantes.TipoEstrategiaCodigo.Lanzamiento).ToList();
                }

                return Json(new
                {
                    success = true,
                    lista = listModel,
                    listaPerdio = listPerdio,
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
        
        [HttpPost]
        public JsonResult RDObtenerProductosLan(BusquedaProductoModel model)
        {
            try
            {
                if (!(revistaDigital.TieneRDC || revistaDigital.TieneRDR) || EsCampaniaFalsa(model.CampaniaID))
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

                var listaFinal1 = ConsultarEstrategiasModel("", model.CampaniaID, Constantes.TipoEstrategiaCodigo.Lanzamiento);

                var perdio = model.CampaniaID != userData.CampaniaID || revistaDigital.TieneRDR
                    ? 0
                    : revistaDigital.TieneRDC && revistaDigital.SuscripcionAnterior2Model.EstadoRegistro == Constantes.EstadoRDSuscripcion.Activo
                        ? 0
                        : 1;

                var listModel = ConsultarEstrategiasFormatearModelo(listaFinal1, perdio);

                int cantidadTotal = listModel.Count;

                return Json(new
                {
                    success = true,
                    listaLan = listModel,
                    cantidadTotal = cantidadTotal,
                    cantidad = cantidadTotal,
                    campaniaId = model.CampaniaID,
                    codigo = Constantes.ConfiguracionPais.Lanzamiento
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

        [HttpPost]
        public JsonResult Suscripcion()
        {
            try
            {
                var mensaje = RegistroSuscripcion(Constantes.EstadoRDSuscripcion.Activo);
                if (mensaje != "")
                {
                    return Json(new
                    {
                        success = false,
                        message = mensaje
                    }, JsonRequestBehavior.AllowGet);
                }

                var entidad = new BERevistaDigitalSuscripcion();
                entidad.PaisID = userData.PaisID;
                entidad.CodigoConsultora = userData.CodigoConsultora;
                entidad.CampaniaID = userData.CampaniaID;
                entidad.CodigoZona = userData.CodigoZona;
                entidad.EstadoRegistro = Constantes.EstadoRDSuscripcion.Activo;
                entidad.EstadoEnvio = 0;
                entidad.IsoPais = userData.CodigoISO;
                entidad.EMail = userData.EMail;

                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    entidad.RevistaDigitalSuscripcionID = sv.RDSuscripcion(entidad);
                }

                if (entidad.RevistaDigitalSuscripcionID > 0)
                {
                    revistaDigital.SuscripcionModel = Mapper.Map<BERevistaDigitalSuscripcion, RevistaDigitalSuscripcionModel>(entidad);
                    revistaDigital.NoVolverMostrar = true;
                    revistaDigital.EstadoSuscripcion = revistaDigital.SuscripcionModel.EstadoRegistro;
                    userData.MenuMobile = null;
                    userData.Menu = null;
                    SetUserData(userData);
                }

                return Json(new
                {
                    success = revistaDigital.EstadoSuscripcion > 0,
                    message = revistaDigital.EstadoSuscripcion > 0 ? "" : "Ocurrió un error, vuelva a intentarlo.",
                    CodigoMenu = Constantes.BannerCodigo.RevistaDigital
                }, JsonRequestBehavior.AllowGet);

            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);

                return Json(new
                {
                    success = false,
                    message = "Ocurrió un error, vuelva a intentarlo."
                }, JsonRequestBehavior.AllowGet);
            }
        }

        [HttpPost]
        public JsonResult Desuscripcion()
        {
            try
            {
                var mensaje = RegistroSuscripcion(Constantes.EstadoRDSuscripcion.Activo);
                if (mensaje != "")
                {
                    return Json(new
                    {
                        success = false,
                        message = mensaje
                    }, JsonRequestBehavior.AllowGet);
                }

                var entidad = new BERevistaDigitalSuscripcion();
                entidad.PaisID = userData.PaisID;
                entidad.CodigoConsultora = userData.CodigoConsultora;
                entidad.CampaniaID = userData.CampaniaID;
                entidad.CodigoZona = userData.CodigoZona;
                entidad.EstadoRegistro = Constantes.EstadoRDSuscripcion.Desactivo;
                entidad.EstadoEnvio = 0;
                entidad.IsoPais = userData.CodigoISO;
                entidad.EMail = userData.EMail;

                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    entidad.RevistaDigitalSuscripcionID = sv.RDDesuscripcion(entidad);
                }

                if (entidad.RevistaDigitalSuscripcionID > 0)
                {
                    revistaDigital.SuscripcionModel = Mapper.Map<BERevistaDigitalSuscripcion, RevistaDigitalSuscripcionModel>(entidad);
                    revistaDigital.NoVolverMostrar = true;
                    revistaDigital.EstadoSuscripcion = revistaDigital.SuscripcionModel.EstadoRegistro;
                    userData.MenuMobile = null;
                    userData.Menu = null;

                    SetUserData(userData);
                }

                return Json(new
                {
                    success = revistaDigital.EstadoSuscripcion > 0,
                    message = revistaDigital.EstadoSuscripcion > 0 ? "" : "Ocurrió un error, vuelva a intentarlo."
                }, JsonRequestBehavior.AllowGet);

            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);

                return Json(new
                {
                    success = false,
                    message = "Ocurrió un error, vuelva a intentarlo."
                }, JsonRequestBehavior.AllowGet);
            }
        }

        [HttpPost]
        public JsonResult PopupNoVolverMostrar()
        {
            try
            {
                var entidad = new BERevistaDigitalSuscripcion();
                entidad.PaisID = userData.PaisID;
                entidad.CodigoConsultora = userData.CodigoConsultora;
                entidad.CampaniaID = userData.CampaniaID;
                entidad.CodigoZona = userData.CodigoZona;
                entidad.EstadoRegistro = Constantes.EstadoRDSuscripcion.NoPopUp;
                entidad.IsoPais = userData.CodigoISO;
                entidad.EMail = userData.EMail;

                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    if (sv.RDSuscripcion(entidad) > 0)
                    {
                        revistaDigital.NoVolverMostrar = true;
                        revistaDigital.EstadoSuscripcion = Constantes.EstadoRDSuscripcion.NoPopUp;
                        revistaDigital.SuscripcionModel.EstadoRegistro = Constantes.EstadoRDSuscripcion.NoPopUp;
                    }
                }

                return Json(new
                {
                    success = true
                }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ""
                }, JsonRequestBehavior.AllowGet);
            }
        }

        private string RegistroSuscripcion(int tipo)
        {
            if (userData.CodigoConsultora == "")
                throw new ArgumentException("El codigo de la consultora no puede ser nulo.");

            if (tipo == Constantes.EstadoRDSuscripcion.Activo)
            {
                if (!revistaDigital.TieneRDC)
                    return "Por el momento no está habilitada la suscripción a ÉSIKA PARA MÍ, gracias.";

                if (revistaDigital.EsSuscrita)
                    return "Usted ya está suscrito a ÉSIKA PARA MÍ, gracias.";


                var diasFaltanFactura = GetDiasFaltantesFacturacion(userData.FechaInicioCampania, userData.ZonaHoraria);
                if (diasFaltanFactura <= revistaDigital.BloquearDiasAntesFacturar)
                {
                    return "Lo sentimos no puede suscribirse, porque "
                        + (diasFaltanFactura == 0 ? "hoy" : diasFaltanFactura == 1 ? "mañana" : "en " + diasFaltanFactura + " días ")
                        + " es cierre de campaña.";
                }

            }
            else if (tipo == Constantes.EstadoRDSuscripcion.Desactivo)
            {
                if (!revistaDigital.TieneRDC)
                    return "Por el momento no está habilitada la desuscripción a ÉSIKA PARA MÍ, gracias.";
                
                if (!revistaDigital.EsSuscrita)
                    return "Lo sentimos no se puede ejecutar la acción, gracias.";

                var diasFaltanFactura = GetDiasFaltantesFacturacion(userData.FechaInicioCampania, userData.ZonaHoraria);
                if (diasFaltanFactura <= revistaDigital.BloquearDiasAntesFacturar)
                {
                    return "Lo sentimos no puede desuscribirse, porque "
                        + (diasFaltanFactura == 0 ? "hoy" : diasFaltanFactura == 1 ? "mañana" : "en " + diasFaltanFactura + " días ")
                        + " es cierre de campaña.";
                }

            }
            return "";
        }

        [HttpPost]
        public JsonResult PopupCerrar()
        {
            try
            {
                revistaDigital.NoVolverMostrar = true;
                revistaDigital.EstadoSuscripcion = Constantes.EstadoRDSuscripcion.NoPopUp;
                Session[Constantes.ConstSession.TipoPopUpMostrar] = Constantes.TipoPopUp.Ninguno;

                return Json(new
                {
                    success = true
                }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ""
                }, JsonRequestBehavior.AllowGet);
            }
        }
    }
}