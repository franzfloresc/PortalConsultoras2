﻿using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceAsesoraOnline;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServiceUsuario;
using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
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

            return RedirectToAction("Index", "Ofertas");
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
                    : revistaDigital.TieneRDC && revistaDigital.EsActiva
                        ? Constantes.TipoEstrategiaCodigo.RevistaDigital
                        : "";

                var listaFinal1 = ConsultarEstrategiasModel("", model.CampaniaID, palanca);
                var listModel = ConsultarEstrategiasFormatearModelo(listaFinal1, 2);

                listModel = listModel.Where(e => e.CodigoEstrategia != Constantes.TipoEstrategiaCodigo.Lanzamiento).ToList();

                var cantidadTotal = listModel.Count;

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

                var perdio = revistaDigital.TieneRDR ? 0 : TieneProductosPerdio(model.CampaniaID) ? 1 : 0;

                var listModel = ConsultarEstrategiasFormatearModelo(listaFinal1, perdio);

                var cantidadTotal = listModel.Count;

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
            return RegistroSuscripcionTry(Constantes.EstadoRDSuscripcion.Activo);
        }

        [HttpPost]
        public JsonResult Desuscripcion()
        {
            return RegistroSuscripcionTry(Constantes.EstadoRDSuscripcion.Desactivo);
        }

        [HttpPost]
        public JsonResult PopupNoVolverMostrar()
        {
            return RegistroSuscripcionTry(Constantes.EstadoRDSuscripcion.NoPopUp);
        }

        private JsonResult RegistroSuscripcionTry(int tipo)
        {
            try
            {
                var mensaje = RegistroSuscripcion(tipo);
                if (mensaje != "")
                {
                    return Json(new
                    {
                        success = false,
                        message = mensaje
                    }, JsonRequestBehavior.AllowGet);
                }

                return Json(new
                {
                    success = revistaDigital.EstadoSuscripcion > 0,
                    message = revistaDigital.EstadoSuscripcion > 0 ? "" : "Ocurrió un error, vuelva a intentarlo."
                }, JsonRequestBehavior.AllowGet);

            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO, "Constantes.EstadoRDSuscripcion = " + tipo);

                return Json(new
                {
                    success = false,
                    message = "Ocurrió un error, vuelva a intentarlo."
                }, JsonRequestBehavior.AllowGet);
            }

        }

        private string RegistroSuscripcion(int tipo)
        {
            string mensaje = RegistroSuscripcionValidar(tipo);
            if (mensaje != "")
                return mensaje;

            var entidad = new BERevistaDigitalSuscripcion
            {
                PaisID = userData.PaisID,
                CodigoConsultora = userData.CodigoConsultora,
                CampaniaID = userData.CampaniaID,
                CodigoZona = userData.CodigoZona,
                EstadoRegistro = tipo,
                Origen = revistaDigital.SuscripcionModel.Origen,
                EstadoEnvio = 0,
                IsoPais = userData.CodigoISO,
                EMail = userData.EMail,
                CampaniaEfectiva = AddCampaniaAndNumero(userData.CampaniaID, revistaDigital.CantidadCampaniaEfectiva)
            };

            entidad.Origen = Util.Trim(entidad.Origen) == ""
                ? Constantes.RevistaDigitalOrigen.RD
                : Util.Trim(entidad.Origen);

            switch (tipo)
            {
                case Constantes.EstadoRDSuscripcion.Desactivo:
                    using (var sv = new PedidoServiceClient())
                    {
                        entidad.RevistaDigitalSuscripcionID = sv.RDDesuscripcion(entidad);
                    }
                    break;
                case Constantes.EstadoRDSuscripcion.Activo:
                    RegistroSuscripcionVirtualCoach();
                    using (var sv = new PedidoServiceClient())
                    {
                        entidad.RevistaDigitalSuscripcionID = sv.RDSuscripcion(entidad);
                    }
                    break;
                case Constantes.EstadoRDSuscripcion.NoPopUp:
                    using (var sv = new PedidoServiceClient())
                    {
                        entidad.RevistaDigitalSuscripcionID = sv.RDSuscripcion(entidad);
                    }
                    break;
            }

            if (entidad.RevistaDigitalSuscripcionID <= 0) return "";
            revistaDigital.SuscripcionModel = Mapper.Map<BERevistaDigitalSuscripcion, RevistaDigitalSuscripcionModel>(entidad);
            revistaDigital.NoVolverMostrar = true;
            revistaDigital.EstadoSuscripcion = revistaDigital.SuscripcionModel.EstadoRegistro;
            revistaDigital.EsSuscrita = revistaDigital.SuscripcionModel.EstadoRegistro == Constantes.EstadoRDSuscripcion.Activo;
            sessionManager.SetRevistaDigital(revistaDigital);
            userData.MenuMobile = null;
            userData.Menu = null;
            Session[Constantes.ConstSession.MenuContenedor] = null;
            SetUserData(userData);

            return "";
        }

        private string RegistroSuscripcionValidar(int tipo)
        {
            var diasFaltanFactura = GetDiasFaltantesFacturacion(userData.FechaInicioCampania, userData.ZonaHoraria);
            switch (tipo)
            {
                case Constantes.EstadoRDSuscripcion.Activo:
                    if (!revistaDigital.TieneRDC)
                        return "Por el momento no está habilitada la suscripción a " + revistaDigital.NombreComercialActiva + ", gracias.";

                    if (revistaDigital.EsSuscrita)
                        return "Usted ya está suscrito a " + revistaDigital.NombreComercialActiva + ", gracias.";

                    if (diasFaltanFactura <= revistaDigital.BloquearDiasAntesFacturar && revistaDigital.BloquearDiasAntesFacturar > 0)
                    {
                        return "Lo sentimos no puede suscribirse a " + revistaDigital.NombreComercialActiva + ", porque "
                            + (diasFaltanFactura == 0 ? "hoy" : diasFaltanFactura == 1 ? "mañana" : "en " + diasFaltanFactura + " días ")
                            + " es cierre de campaña.";
                    }
                    break;
                case Constantes.EstadoRDSuscripcion.Desactivo:
                    if (!revistaDigital.TieneRDC)
                        return "Por el momento no está habilitada la desuscripción a " + revistaDigital.NombreComercialActiva + ", gracias.";

                    if (!revistaDigital.EsSuscrita)
                        return "Lo sentimos no se puede desuscribirse a " + revistaDigital.NombreComercialActiva + ", gracias.";
                    
                    if (diasFaltanFactura <= revistaDigital.BloquearDiasAntesFacturar && revistaDigital.BloquearDiasAntesFacturar > 0)
                    {
                        return "Lo sentimos no puede desuscribirse a " + revistaDigital.NombreComercialActiva + ", porque "
                            + (diasFaltanFactura == 0 ? "hoy" : diasFaltanFactura == 1 ? "mañana" : "en " + diasFaltanFactura + " días ")
                            + " es cierre de campaña.";
                    }
                    break;
                case Constantes.EstadoRDSuscripcion.NoPopUp:
                    if (!revistaDigital.TieneRDC)
                        return "Por el momento no está habilitada esta acción, gracias.";

                    if (revistaDigital.EsSuscrita)
                        return "Lo sentimos no se puede ejecutar esta acción, gracias.";
                    
                    if (diasFaltanFactura <= revistaDigital.BloquearDiasAntesFacturar && revistaDigital.BloquearDiasAntesFacturar > 0)
                    {
                        return "Lo sentimos no puede ejecutar esta acción, porque "
                            + (diasFaltanFactura == 0 ? "hoy" : diasFaltanFactura == 1 ? "mañana" : "en " + diasFaltanFactura + " días ")
                            + " es cierre de campaña.";
                    }
                    break;
                default:
                    return "Lo sentimos no se puede ejecutar esta acción, gracias.";
            }

            return "";
        }

        private void RegistroSuscripcionVirtualCoach()
        {
            if (revistaDigital.SubscripcionAutomaticaAVirtualCoach)
            {
                var asesoraOnLine = new BEAsesoraOnline
                {
                    CodigoConsultora = userData.CodigoConsultora,
                    ConfirmacionInscripcion = 1,
                    Origen = Constantes.RevistaDigitalOrigen.RD
                };
                using (var sv = new AsesoraOnlineServiceClient())
                {
                    sv.EnviarFormulario(userData.CodigoISO, asesoraOnLine);
                }
            }
        }

        [HttpPost]
        public JsonResult PopupCerrar()
        {
            try
            {
                revistaDigital.NoVolverMostrar = true;
                revistaDigital.EstadoSuscripcion = Constantes.EstadoRDSuscripcion.NoPopUp;
                revistaDigital.SuscripcionModel.EstadoRegistro = Constantes.EstadoRDSuscripcion.NoPopUp;
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

        [HttpPost]
        public JsonResult PopupDatos()
        {
            try
            {
                if (!revistaDigital.TieneRDC || revistaDigital.NoVolverMostrar || revistaDigital.EsSuscrita)
                {
                    return Json(new
                    {
                        success = false
                    }, JsonRequestBehavior.AllowGet);
                }

                var setSession = false;

                var listaDatosPopup = revistaDigital.ConfiguracionPaisDatos.Where(d => d.Componente == Constantes.ConfiguracionPaisComponente.RD.PopupClubGanaMas);
                
                var campaniaPopup = (listaDatosPopup.FirstOrDefault() ?? new ConfiguracionPaisDatosModel()).CampaniaID;
                if (listaDatosPopup.Any(d => d.CampaniaID != campaniaPopup))
                {
                    listaDatosPopup = GetConfiguracionPaisDatosPorComponente(userData.CampaniaID, Constantes.ConfiguracionPaisComponente.RD.PopupClubGanaMas);
                    setSession = true;
                }

                campaniaPopup = (listaDatosPopup.FirstOrDefault() ?? new ConfiguracionPaisDatosModel()).CampaniaID;
                if (campaniaPopup != userData.CampaniaID && campaniaPopup != 0)
                {
                    listaDatosPopup = GetConfiguracionPaisDatosPorComponente(0, Constantes.ConfiguracionPaisComponente.RD.PopupClubGanaMas);
                    setSession = true;
                }

                if (setSession)
                {
                    var listaDatos = revistaDigital.ConfiguracionPaisDatos.Where(d => d.Componente != Constantes.ConfiguracionPaisComponente.RD.PopupClubGanaMas).ToList();
                    listaDatos.AddRange(listaDatosPopup);
                    revistaDigital.ConfiguracionPaisDatos = listaDatos;
                    sessionManager.SetRevistaDigital(revistaDigital);
                }

                var modelo = new RevistaDigitalPopupModel
                {
                    Mensaje1 = GetValorDato(Constantes.ConfiguracionPaisDatos.RD.PopupMensaje1),
                    Mensaje2 = GetValorDato(Constantes.ConfiguracionPaisDatos.RD.PopupMensaje2),
                    MensajeColor = GetValorDato(Constantes.ConfiguracionPaisDatos.RD.PopupMensajeColor),
                    ImagenEtiqueta = GetValorDato(Constantes.ConfiguracionPaisDatos.RD.PopupImagenEtiqueta),
                    ImagenPublicidad = GetValorDato(Constantes.ConfiguracionPaisDatos.RD.PopupImagenPublicidad),
                    BotonColorFondo = GetValorDato(Constantes.ConfiguracionPaisDatos.RD.PopupBotonColorFondo),
                    BotonColorTexto = GetValorDato(Constantes.ConfiguracionPaisDatos.RD.PopupBotonColorTexto),
                    BotonTexto = GetValorDato(Constantes.ConfiguracionPaisDatos.RD.PopupBotonTexto),
                    FondoColor = GetValorDato(Constantes.ConfiguracionPaisDatos.RD.PopupFondoColor),
                    FondoColorMarco = GetValorDato(Constantes.ConfiguracionPaisDatos.RD.PopupFondoColorMarco)
                };

                var carpetaPais = Globals.UrlMatriz + "/" + userData.CodigoISO;
                modelo.ImagenEtiqueta = ConfigS3.GetUrlFileS3(carpetaPais, modelo.ImagenEtiqueta, String.Empty);
                modelo.ImagenPublicidad = ConfigS3.GetUrlFileS3(carpetaPais, modelo.ImagenPublicidad, String.Empty);

                var transparent = "transparent";
                modelo.MensajeColor = Util.ColorFormato(modelo.MensajeColor, transparent);
                modelo.BotonColorFondo = Util.ColorFormato(modelo.BotonColorFondo, transparent);
                modelo.BotonColorTexto = Util.ColorFormato(modelo.BotonColorTexto, transparent);
                modelo.FondoColor = Util.ColorFormato(modelo.FondoColor, transparent);
                modelo.FondoColorMarco = Util.ColorFormato(modelo.FondoColorMarco, transparent);

                modelo.FondoColor = "background:" + modelo.FondoColor + ";";
                modelo.FondoColorMarco = "box-shadow: inset 0 0 0 5px " + modelo.FondoColorMarco + ";";

                return Json(new
                {
                    success = true,
                    modelo
                }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false
                }, JsonRequestBehavior.AllowGet);
            }
        }

        protected virtual List<ConfiguracionPaisDatosModel> GetConfiguracionPaisDatosPorComponente(int campaniaid, string componente)
        {
            List<ConfiguracionPaisDatosModel> listaEntidad;
            try
            {
                var beEntidad = new BEConfiguracionPaisDatos
                {
                    PaisID = userData.PaisID,
                    CampaniaID = campaniaid,
                    Componente = componente,
                    ConfiguracionPais = new BEConfiguracionPais
                    {
                        Codigo = Constantes.ConfiguracionPais.RevistaDigital
                    }
                };
                
                using (var sv = new UsuarioServiceClient())
                {
                    var beEntidades = sv.GetConfiguracionPaisComponenteDatos(beEntidad).ToList();

                    listaEntidad = Mapper.Map<IList<BEConfiguracionPaisDatos>, List<ConfiguracionPaisDatosModel>>(beEntidades);
                }
            }
            catch (Exception ex)
            {
                listaEntidad = new List<ConfiguracionPaisDatosModel>();
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoUsuario, userData.PaisID.ToString());
            }
            return listaEntidad;
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
    }
}