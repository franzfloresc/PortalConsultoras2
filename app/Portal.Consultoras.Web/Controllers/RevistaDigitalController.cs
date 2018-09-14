using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.LogManager;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.SessionManager;
using System;
using System.Linq;
using System.ServiceModel;
using System.Web.Mvc;


namespace Portal.Consultoras.Web.Controllers
{
    public class RevistaDigitalController : BaseViewController
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
                return RDIndexModel();
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            return RedirectToAction("Index", "Bienvenida");
        }

        public ActionResult Comprar()
        {

            if (EsDispositivoMovil())
            {
                return RedirectToAction("Comprar", "RevistaDigital", new { area = "Mobile" });
            }
            
            try
            {
                ViewBag.variableEstrategia = GetVariableEstrategia();
                return RDViewLanding(1);
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
                return RDViewLanding(2);
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
                return RDDetalleModel(cuv, campaniaId);
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
                    CampaniaID = userData.CampaniaID,
                    Inmediata = _revistaDigitalProvider.EsSuscripcionInmediata()
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

            if (entidad.RevistaDigitalSuscripcionID <= 0)
                return "";

            RevistaDigitalActualizarSuscripcion();

            return "";
        }
        
        [HttpPost]
        public JsonResult PopupCerrar()
        {
            try
            {
                revistaDigital.ConfiguracionPaisDatos = revistaDigital.ConfiguracionPaisDatos.Where(d => d.Componente != Constantes.ConfiguracionPaisComponente.RD.PopupClubGanaMas).ToList();
                revistaDigital.NoVolverMostrar = true;
                revistaDigital.EstadoSuscripcion = Constantes.EstadoRDSuscripcion.NoPopUp;
                revistaDigital.SuscripcionModel.EstadoRegistro = Constantes.EstadoRDSuscripcion.NoPopUp;
                sessionManager.SetTipoPopUpMostrar(Constantes.TipoPopUp.Ninguno);

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
                modelo.ImagenEtiqueta = ConfigCdn.GetUrlFileCdn(carpetaPais, modelo.ImagenEtiqueta);
                modelo.ImagenPublicidad = ConfigCdn.GetUrlFileCdn(carpetaPais, modelo.ImagenPublicidad);

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
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            return Json(new
            {
                Cantidad = 0,
                success = false,
                message = "Ocurrió un error al acceder al servicio, intente nuevamente.",
                extra = ""
            });
        }

        private string ActualizarMisDatos(ServiceUsuario.BEUsuario usuario, string correoAnterior)
        {
            usuario.ZonaID = userData.ZonaID;
            usuario.RegionID = userData.RegionID;
            usuario.ConsultoraID = userData.ConsultoraID;
            usuario.PaisID = userData.PaisID;
            usuario.PrimerNombre = userData.PrimerNombre;
            usuario.CodigoISO = userData.CodigoISO;

            var resultado = string.Empty;
            using (ServiceUsuario.UsuarioServiceClient svr = new ServiceUsuario.UsuarioServiceClient())
            {
                resultado = svr.ActualizarMisDatos(usuario, correoAnterior);
            }

            resultado = Util.Trim(resultado);
            if (resultado.Split('|')[0] != "0")
            {
                var userDataX = userData;
                if (usuario.EMail != correoAnterior)
                {
                    userDataX.EMail = usuario.EMail;
                }
                userDataX.Celular = usuario.Celular;
                sessionManager.SetUserData(userDataX);
            }

            return resultado;
        }

        private void RevistaDigitalActualizarSuscripcion()
        {
            try
            {
                var rds = new ServicePedido.BERevistaDigitalSuscripcion
                {
                    PaisID = userData.PaisID,
                    CodigoConsultora = userData.CodigoConsultora
                };

                using (var pedidoServiceClient = new PedidoServiceClient())
                {
                    revistaDigital.SuscripcionModel = Mapper.Map<RevistaDigitalSuscripcionModel>(pedidoServiceClient.RDGetSuscripcion(rds));

                    rds.CampaniaID = userData.CampaniaID;
                    revistaDigital.SuscripcionEfectiva = Mapper.Map<RevistaDigitalSuscripcionModel>(pedidoServiceClient.RDGetSuscripcionActiva(rds));
                }

                revistaDigital.EstadoSuscripcion = revistaDigital.SuscripcionModel.EstadoRegistro;
                revistaDigital.EsSuscrita = revistaDigital.SuscripcionModel.EstadoRegistro == Constantes.EstadoRDSuscripcion.Activo;
                revistaDigital.EsActiva = revistaDigital.SuscripcionEfectiva.EstadoRegistro == Constantes.EstadoRDSuscripcion.Activo;
                revistaDigital.NoVolverMostrar = true; // se puede copiar la logica del login

                sessionManager.SetRevistaDigital(revistaDigital);
                userData.MenuMobile = null;
                userData.Menu = null;
                sessionManager.SetMenuContenedor(null);
                sessionManager.SetUserData(userData);

                if (_revistaDigitalProvider.EsSuscripcionInmediata())
                {
                    LimpiarEstrategia(userData.PaisID, userData.CampaniaID.ToString());
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
        }

        private void LimpiarEstrategia(int paisID, string campaniaID)
        {
            //Limpiar session del servidor
            sessionManager.SetBEEstrategia(string.Format("{0}{1}", Constantes.ConstSession.ListaEstrategia, Constantes.TipoEstrategiaCodigo.GuiaDeNegocioDigitalizada), null);
            sessionManager.SetBEEstrategia(string.Format("{0}{1}", Constantes.ConstSession.ListaEstrategia, Constantes.TipoEstrategiaCodigo.HerramientasVenta),null);
            sessionManager.SetBEEstrategia(string.Format("{0}{1}", Constantes.ConstSession.ListaEstrategia, Constantes.TipoEstrategiaCodigo.Lanzamiento),null);
            sessionManager.SetBEEstrategia(string.Format("{0}{1}", Constantes.ConstSession.ListaEstrategia, Constantes.TipoEstrategiaCodigo.LosMasVendidos), null);
            sessionManager.SetBEEstrategia(string.Format("{0}{1}", Constantes.ConstSession.ListaEstrategia, Constantes.TipoEstrategiaCodigo.OfertaParaTi), null);
            sessionManager.SetBEEstrategia(string.Format("{0}{1}", Constantes.ConstSession.ListaEstrategia, Constantes.TipoEstrategiaCodigo.OfertaWeb), null);
            sessionManager.SetBEEstrategia(string.Format("{0}{1}", Constantes.ConstSession.ListaEstrategia, Constantes.TipoEstrategiaCodigo.PackNuevas), null);
            sessionManager.SetBEEstrategia(string.Format("{0}{1}", Constantes.ConstSession.ListaEstrategia, Constantes.TipoEstrategiaCodigo.RevistaDigital), null);
            sessionManager.SetBEEstrategia(string.Format("{0}{1}", Constantes.ConstSession.ListaEstrategia, string.Empty), null);// OPT
            sessionManager.ShowRoom.Ofertas = null;
            sessionManager.ShowRoom.OfertasSubCampania = null;
            sessionManager.ShowRoom.OfertasPerdio = null;
            sessionManager.ShowRoom.CargoOfertas = "0";

            //Limpia cache de Redis
            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                sv.LimpiarCacheRedis(paisID, Constantes.TipoEstrategiaCodigo.GuiaDeNegocioDigitalizada, campaniaID);
                sv.LimpiarCacheRedis(paisID, Constantes.TipoEstrategiaCodigo.HerramientasVenta, campaniaID);
            }
        }

    }
}