﻿using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.LogManager;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceAsesoraOnline;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServiceUsuario;
using Portal.Consultoras.Web.SessionManager;
using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Web.Mvc;
using Portal.Consultoras.Web.SessionManager;


namespace Portal.Consultoras.Web.Controllers
{
    public class RevistaDigitalController : BaseRevistaDigitalController
    {
        public RevistaDigitalController()
            : base()
        {
        }

        public RevistaDigitalController(ISessionManager sessionManager)
            : base(sessionManager)
        {
        }

        public RevistaDigitalController(ISessionManager sessionManager, ILogManager logManager)
            : base(sessionManager, logManager)
        {
        }

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

        public ActionResult MensajeBloqueado()
        {
            try
            {
                return PartialView("template-mensaje-bloqueado", _ofertasViewProvider.MensajeProductoBloqueado(IsMobile()));
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
            return PartialView("template-mensaje-bloqueado", new MensajeProductoBloqueadoModel());
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
                    message = revistaDigital.EstadoSuscripcion > 0 ? "" : "Ocurrió un error, vuelva a intentarlo.",
                    revistaDigital = getRevistaDigitalShortModel(),
                    CampaniaID = userData.CampaniaID
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
            string mensaje = _revistaDigitalProvider.RegistroSuscripcionValidar(tipo);
            if (mensaje != "")
                return mensaje;

            var entidad = new ServicePedido.BERevistaDigitalSuscripcion
            {
                PaisID = userData.PaisID,
                CodigoConsultora = userData.CodigoConsultora,
                CampaniaID = userData.CampaniaID,
                CodigoZona = userData.CodigoZona,
                EstadoRegistro = tipo,
                Origen = Constantes.RevistaDigitalOrigen.RD,
                EstadoEnvio = 0,
                IsoPais = userData.CodigoISO,
                EMail = userData.EMail,
                CampaniaEfectiva = Util.AddCampaniaAndNumero(userData.CampaniaID, revistaDigital.CantidadCampaniaEfectiva, userData.NroCampanias)
            };

            switch (tipo)
            {
                case Constantes.EstadoRDSuscripcion.Desactivo:
                    using (var sv = new PedidoServiceClient())
                    {
                        entidad.RevistaDigitalSuscripcionID = sv.RDDesuscripcion(entidad);
                    }
                    break;
                case Constantes.EstadoRDSuscripcion.Activo:
                    _revistaDigitalProvider.RegistroSuscripcionVirtualCoach();
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
            revistaDigital.SuscripcionModel = Mapper.Map<ServicePedido.BERevistaDigitalSuscripcion, RevistaDigitalSuscripcionModel>(entidad);
            revistaDigital.NoVolverMostrar = true;
            revistaDigital.EstadoSuscripcion = revistaDigital.SuscripcionModel.EstadoRegistro;
            revistaDigital.EsSuscrita = revistaDigital.SuscripcionModel.EstadoRegistro == Constantes.EstadoRDSuscripcion.Activo;
            var campaniaEfectiva = userData.CampaniaID + revistaDigital.CantidadCampaniaEfectiva;
            revistaDigital.CampaniaActiva = campaniaEfectiva.ToString().Substring(campaniaEfectiva.ToString().Length - 2);
            sessionManager.SetRevistaDigital(revistaDigital);
            userData.MenuMobile = null;
            userData.Menu = null;
            Session[Constantes.ConstSession.MenuContenedor] = null;
            SetUserData(userData);
            if (_revistaDigitalProvider.EsSuscripcionInmediata())
            {
                if (tipo == Constantes.EstadoRDSuscripcion.Activo)
                    revistaDigital.EsActiva = true;
                else if (tipo == Constantes.EstadoRDSuscripcion.Desactivo)
                    revistaDigital.EsActiva = false;

                LimpiarEstrategia(entidad.PaisID, entidad.CampaniaID.ToString());
                RecargarPalancas();
            }
            return "";
        }

        private void RecargarPalancas()
        {
            ConsultarEstrategias(userData.CampaniaID, Constantes.TipoEstrategiaCodigo.RevistaDigital);
            ConsultarEstrategias(userData.CampaniaID, Constantes.TipoEstrategiaCodigo.Lanzamiento);
            ConsultarEstrategias(userData.CampaniaID, Constantes.TipoEstrategiaCodigo.GuiaDeNegocioDigitalizada);
            ConsultarEstrategias(userData.CampaniaID, Constantes.TipoEstrategiaCodigo.LosMasVendidos);
            ConsultarEstrategias(userData.CampaniaID, Constantes.TipoEstrategiaCodigo.OfertaParaTi);
        }

        //private string RegistroSuscripcionValidar(int tipo)
        //{
        //    var diasFaltanFactura = _baseProvider.GetDiasFaltantesFacturacion(userData.FechaInicioCampania, userData.ZonaHoraria);
        //    switch (tipo)
        //    {
        //        case Constantes.EstadoRDSuscripcion.Activo:
        //            if (!revistaDigital.TieneRDC)
        //                return "Por el momento no está habilitada la suscripción a " + revistaDigital.NombreComercialActiva + ", gracias.";

        //            if (revistaDigital.EsSuscrita)
        //                return "Usted ya está suscrito a " + revistaDigital.NombreComercialActiva + ", gracias.";

        //            if (diasFaltanFactura <= revistaDigital.BloquearDiasAntesFacturar && revistaDigital.BloquearDiasAntesFacturar > 0)
        //            {
        //                return "Lo sentimos no puede suscribirse a " + revistaDigital.NombreComercialActiva + ", porque "
        //                    + (diasFaltanFactura == 0 ? "hoy" : diasFaltanFactura == 1 ? "mañana" : "en " + diasFaltanFactura + " días ")
        //                    + " es cierre de campaña.";
        //            }
        //            break;
        //        case Constantes.EstadoRDSuscripcion.Desactivo:
        //            if (!revistaDigital.TieneRDC)
        //                return "Por el momento no está habilitada la desuscripción a " + revistaDigital.NombreComercialActiva + ", gracias.";

        //            if (!revistaDigital.EsSuscrita)
        //                return "Lo sentimos no se puede desuscribirse a " + revistaDigital.NombreComercialActiva + ", gracias.";

        //            if (diasFaltanFactura <= revistaDigital.BloquearDiasAntesFacturar && revistaDigital.BloquearDiasAntesFacturar > 0)
        //            {
        //                return "Lo sentimos no puede desuscribirse a " + revistaDigital.NombreComercialActiva + ", porque "
        //                    + (diasFaltanFactura == 0 ? "hoy" : diasFaltanFactura == 1 ? "mañana" : "en " + diasFaltanFactura + " días ")
        //                    + " es cierre de campaña.";
        //            }
        //            break;
        //        case Constantes.EstadoRDSuscripcion.NoPopUp:
        //            if (!revistaDigital.TieneRDC)
        //                return "Por el momento no está habilitada esta acción, gracias.";

        //            if (revistaDigital.EsSuscrita)
        //                return "Lo sentimos no se puede ejecutar esta acción, gracias.";

        //            if (diasFaltanFactura <= revistaDigital.BloquearDiasAntesFacturar && revistaDigital.BloquearDiasAntesFacturar > 0)
        //            {
        //                return "Lo sentimos no puede ejecutar esta acción, porque "
        //                    + (diasFaltanFactura == 0 ? "hoy" : diasFaltanFactura == 1 ? "mañana" : "en " + diasFaltanFactura + " días ")
        //                    + " es cierre de campaña.";
        //            }
        //            break;
        //        default:
        //            return "Lo sentimos no se puede ejecutar esta acción, gracias.";
        //    }

        //    return "";
        //}

        //private void RegistroSuscripcionVirtualCoach()
        //{
        //    if (revistaDigital.SubscripcionAutomaticaAVirtualCoach)
        //    {
        //        var asesoraOnLine = new BEAsesoraOnline
        //        {
        //            CodigoConsultora = userData.CodigoConsultora,
        //            ConfirmacionInscripcion = 1,
        //            Origen = Constantes.RevistaDigitalOrigen.RD
        //        };
        //        using (var sv = new AsesoraOnlineServiceClient())
        //        {
        //            sv.EnviarFormulario(userData.CodigoISO, asesoraOnLine);
        //        }
        //    }
        //}

        [HttpPost]
        public JsonResult PopupCerrar()
        {
            try
            {
                revistaDigital.ConfiguracionPaisDatos = revistaDigital.ConfiguracionPaisDatos.Where(d => d.Componente != Constantes.ConfiguracionPaisComponente.RD.PopupClubGanaMas).ToList();
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
                    listaDatosPopup = _revistaDigitalProvider.GetConfiguracionPaisDatosPorComponente(userData.CampaniaID, Constantes.ConfiguracionPaisComponente.RD.PopupClubGanaMas);
                    setSession = true;
                }

                campaniaPopup = (listaDatosPopup.FirstOrDefault() ?? new ConfiguracionPaisDatosModel()).CampaniaID;
                if (campaniaPopup != userData.CampaniaID && campaniaPopup != 0)
                {
                    listaDatosPopup = _revistaDigitalProvider.GetConfiguracionPaisDatosPorComponente(0, Constantes.ConfiguracionPaisComponente.RD.PopupClubGanaMas);
                    setSession = true;
                }

                if (setSession)
                {
                    var listaDatos = revistaDigital.ConfiguracionPaisDatos.Where(d => d.Componente != Constantes.ConfiguracionPaisComponente.RD.PopupClubGanaMas).ToList();
                    listaDatos.AddRange(listaDatosPopup);
                    revistaDigital.ConfiguracionPaisDatos = listaDatos;
                    sessionManager.SetRevistaDigital(revistaDigital);
                }

                if (!listaDatosPopup.Any())
                {
                    return Json(new
                    {
                        success = false
                    }, JsonRequestBehavior.AllowGet);
                }

                var esMobile = IsMobile();
                var modelo = new RevistaDigitalPopupModel
                {
                    Mensaje1 = _revistaDigitalProvider.GetValorDato(Constantes.ConfiguracionPaisDatos.RD.PopupMensaje1, esMobile),
                    Mensaje2 = _revistaDigitalProvider.GetValorDato(Constantes.ConfiguracionPaisDatos.RD.PopupMensaje2, esMobile),
                    MensajeColor = _revistaDigitalProvider.GetValorDato(Constantes.ConfiguracionPaisDatos.RD.PopupMensajeColor, esMobile),
                    ImagenEtiqueta = _revistaDigitalProvider.GetValorDato(Constantes.ConfiguracionPaisDatos.RD.PopupImagenEtiqueta, esMobile),
                    ImagenPublicidad = _revistaDigitalProvider.GetValorDato(Constantes.ConfiguracionPaisDatos.RD.PopupImagenPublicidad, esMobile),
                    BotonColorFondo = _revistaDigitalProvider.GetValorDato(Constantes.ConfiguracionPaisDatos.RD.PopupBotonColorFondo, esMobile),
                    BotonColorTexto = _revistaDigitalProvider.GetValorDato(Constantes.ConfiguracionPaisDatos.RD.PopupBotonColorTexto, esMobile),
                    BotonTexto = _revistaDigitalProvider.GetValorDato(Constantes.ConfiguracionPaisDatos.RD.PopupBotonTexto, esMobile),
                    FondoColor = _revistaDigitalProvider.GetValorDato(Constantes.ConfiguracionPaisDatos.RD.PopupFondoColor, esMobile),
                    FondoColorMarco = _revistaDigitalProvider.GetValorDato(Constantes.ConfiguracionPaisDatos.RD.PopupFondoColorMarco, esMobile)
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
                modelo.FondoColorMarco = "border: 5px solid " + modelo.FondoColorMarco + ";";

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

        [HttpPost]
        public JsonResult ActualizarDatos(MisDatosModel model)
        {
            try
            {
                var usuario = Mapper.Map<MisDatosModel, ServiceUsuario.BEUsuario>(model);

                string resultado = ActualizarMisDatos(usuario, model.CorreoAnterior);
                var lstRes = resultado.Split('|');

                bool seActualizoMisDatos = lstRes[0] != "0";
                string message = lstRes.Length >= 3 ? lstRes[2] : "";

                if (seActualizoMisDatos)
                {
                    return Json(new
                    {
                        success = true,
                        message,
                        Cantidad = 0,
                        extra = string.Empty
                    });
                }

                int cantidad = lstRes.Length >= 4 ? int.Parse(lstRes[3]) : 0;
                return Json(new
                {
                    success = false,
                    message,
                    Cantidad = cantidad,
                    extra = string.Empty
                });

            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
            }

            return Json(new
            {
                Cantidad = 0,
                success = false,
                message = "Ocurrió un error al acceder al servicio, intente nuevamente.",
                extra = ""
            });
        }

        private void LimpiarEstrategia(int paisID, string campaniaID)
        {
            //Limpiar session del servidor
            Session[string.Format("{0}{1}", Constantes.ConstSession.ListaEstrategia, Constantes.TipoEstrategiaCodigo.GuiaDeNegocioDigitalizada)] = null;
            Session[string.Format("{0}{1}", Constantes.ConstSession.ListaEstrategia, Constantes.TipoEstrategiaCodigo.HerramientasVenta)] = null;
            Session[string.Format("{0}{1}", Constantes.ConstSession.ListaEstrategia, Constantes.TipoEstrategiaCodigo.Lanzamiento)] = null;
            Session[string.Format("{0}{1}", Constantes.ConstSession.ListaEstrategia, Constantes.TipoEstrategiaCodigo.LosMasVendidos)] = null;
            Session[string.Format("{0}{1}", Constantes.ConstSession.ListaEstrategia, Constantes.TipoEstrategiaCodigo.OfertaParaTi)] = null;
            Session[string.Format("{0}{1}", Constantes.ConstSession.ListaEstrategia, Constantes.TipoEstrategiaCodigo.OfertaWeb)] = null;
            Session[string.Format("{0}{1}", Constantes.ConstSession.ListaEstrategia, Constantes.TipoEstrategiaCodigo.PackNuevas)] = null;
            Session[string.Format("{0}{1}", Constantes.ConstSession.ListaEstrategia, Constantes.TipoEstrategiaCodigo.RevistaDigital)] = null;
            sessionManager.ShowRoom.Ofertas = null;
            sessionManager.OfertaDelDia.Estrategia=null;

            //Limpia cache de Redis
            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                sv.LimpiarCacheRedis(paisID, Constantes.TipoEstrategiaCodigo.GuiaDeNegocioDigitalizada, campaniaID);
                sv.LimpiarCacheRedis(paisID, Constantes.TipoEstrategiaCodigo.HerramientasVenta, campaniaID);
            }
        }
    }
}