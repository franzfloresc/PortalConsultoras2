﻿using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Models.Common;
using Portal.Consultoras.Web.Models.Estrategia.ShowRoom;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServiceUsuario;
using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class ShowRoomController : BaseShowRoomController
    {
        public ShowRoomController() : base()
        {

        }

        public ActionResult Intriga()
        {
            return RedirectToAction("Index", "Ofertas");

            /*
            if (!ValidarIngresoShowRoom(true))
            {
                return RedirectToAction("Index", "Bienvenida");
            }

            var model = ObtenerPrimeraOfertaShowRoom();
            if (model == null) return RedirectToAction("Index", "Bienvenida");

            //model.Simbolo = userData.Simbolo;
            //model.CodigoISO = userData.CodigoISO;
            //model.Suscripcion = (configEstrategiaSR.BeShowRoomConsultora ?? new ShowRoomEventoConsultoraModel()).Suscripcion;
            //model.EMail = userData.EMail;
            //model.EMailActivo = userData.EMailActivo;
            //model.Celular = userData.Celular;
            //model.UrlTerminosCondiciones = ObtenerValorPersonalizacionShowRoom(Constantes.ShowRoomPersonalizacion.Desktop.UrlTerminosCondiciones, Constantes.ShowRoomPersonalizacion.TipoAplicacion.Desktop);
            //model.Agregado = ObtenerPedidoWebDetalle().Any(d => d.CUV == model.CUV) ? "block" : "none";

            return View(model);
            */
        }

        public ActionResult Index(string query)
        {

            try
            {
                if (EsDispositivoMovil())
                {
                    var url = (Request.Url.Query).Split('?');
                    if (url.Length > 1)
                    {
                        string sap = "&" + url[1];
                        return RedirectToAction("Index", "ShowRoom", new { area = "Mobile", sap });
                    }
                    else
                    {
                        return RedirectToAction("Index", "ShowRoom", new { area = "Mobile" });
                    }

                }

                ViewBag.TerminoMostrar = 1;

                var mostrarShowRoomProductos = SessionManager.GetMostrarShowRoomProductos();
                var mostrarShowRoomProductosExpiro = SessionManager.GetMostrarShowRoomProductosExpiro();
                var mostrarPopupIntriga = !mostrarShowRoomProductos && !mostrarShowRoomProductosExpiro;

                if (mostrarPopupIntriga) return RedirectToAction("Intriga", "ShowRoom");
                if (!_showRoomProvider.ValidarIngresoShowRoom(false)) return RedirectToAction("Index", "Bienvenida");

                if (!string.IsNullOrEmpty(query))
                {
                    if (GetIsMobileDevice())
                    {
                        return RedirectToAction("Index", "ShowRoom", new { area = "Mobile", query });
                    }

                    var srQsv = new ShowRoomQueryStringValidator(query);

                    if (srQsv.CodigoConsultora != userData.CodigoConsultora && srQsv.CodigoIso != userData.CodigoISO
                        || srQsv.CodigoProceso != CodigoProceso)
                    {
                        return RedirectToAction("Index", "Bienvenida");
                    }

                    if (srQsv.CampanaId == userData.CampaniaID && !_showRoomProvider.GetEventoConsultoraRecibido(userData))
                    {
                        _showRoomProvider.UpdShowRoomEventoConsultoraEmailRecibido(srQsv.CodigoConsultora, srQsv.CampanaId, userData);
                    }
                }

                var showRoomEventoModel = CargarValoresModel();

                if (!showRoomEventoModel.TieneOfertasAMostrar) return RedirectToAction("Index", "Bienvenida");

                showRoomEventoModel.CloseBannerCompraPorCompra = userData.CloseBannerCompraPorCompra;
                ViewBag.IconoLLuvia = _showRoomProvider.ObtenerValorPersonalizacionShowRoom(Constantes.ShowRoomPersonalizacion.Desktop.IconoLluvia, Constantes.ShowRoomPersonalizacion.TipoAplicacion.Desktop);

                var dato = _ofertasViewProvider.ObtenerPerdioTitulo(userData.CampaniaID, IsMobile());
                showRoomEventoModel.ProductosPerdio = dato.Estado;
                showRoomEventoModel.PerdioTitulo = dato.Valor1;
                showRoomEventoModel.PerdioSubTitulo = dato.Valor2;
                showRoomEventoModel.MensajeProductoBloqueado = _ofertasViewProvider.MensajeProductoBloqueado(IsMobile());
                showRoomEventoModel.TieneCategoria = false;
                showRoomEventoModel.PerdioLogo = revistaDigital.DLogoComercialActiva;

                return View(showRoomEventoModel);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            return RedirectToAction("Index", "Bienvenida");
        }

        [HttpPost]
        public JsonResult CerrarBannerCompraPorCompra()
        {
            try
            {
                userData.CloseBannerCompraPorCompra = true;

                SessionManager.SetUserData(userData);

                return Json(new
                {
                    success = true,
                    message = "Ok"
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Error"
                });
            }
        }

        [HttpPost]
        public JsonResult PopupCerrar()
        {
            _showRoomProvider.CargarEventoConsultora(userData);
            if (configEstrategiaSR.BeShowRoomConsultora == null)
            {
                return Json(new
                {
                    success = false,
                    message = "BeShowRoomConsultora es null"
                });
            }

            configEstrategiaSR.BeShowRoomConsultora.MostrarPopup = false;
            configEstrategiaSR.BeShowRoomConsultora.MostrarPopupVenta = false;
            return Json(new
            {
                success = true,
                message = "Actualizado correctamente"
            });
        }

        [HttpPost]
        public JsonResult UpdatePopupShowRoom(bool noMostrarPopup)
        {
            try
            {
                using (var sv = new PedidoServiceClient())
                {
                    sv.UpdateShowRoomConsultoraMostrarPopup(userData.PaisID, userData.CampaniaID, userData.CodigoConsultora, !noMostrarPopup);
                }

                configEstrategiaSR.CargoEntidadesShowRoom = false;
                return Json(new
                {
                    success = true,
                    message = "Actualizado correctamente",
                    data = ""
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    data = ""
                });
            }
        }

        public JsonResult ValidarUnidadesPermitidasPedidoProducto(string cuv, string precioUnidad, string cantidad)
        {
            int unidadesPermitidas;
            int saldo;
            int cantidadPedida;

            var entidad = new BEOfertaProducto
            {
                PaisID = userData.PaisID,
                CampaniaID = userData.CampaniaID,
                CUV = cuv,
                ConsultoraID = Convert.ToInt32(userData.ConsultoraID)
            };

            using (var sv = new PedidoServiceClient())
            {
                unidadesPermitidas = sv.GetUnidadesPermitidasByCuvShowRoom(userData.PaisID, userData.CampaniaID, cuv);
                saldo = sv.ValidarUnidadesPermitidasEnPedidoShowRoom(userData.PaisID, userData.CampaniaID, cuv, userData.ConsultoraID);
                cantidadPedida = sv.CantidadPedidoByConsultoraShowRoom(entidad);
            }

            return Json(new
            {
                UnidadesPermitidas = unidadesPermitidas,
                Saldo = saldo,
                CantidadPedida = cantidadPedida,
                message = ""
            }, JsonRequestBehavior.AllowGet);
        }

        public JsonResult ObtenerStockActualProducto(string cuv)
        {
            int stock;

            using (var sv = new PedidoServiceClient())
            {
                stock = sv.GetStockOfertaShowRoom(userData.PaisID, userData.CampaniaID, cuv);
            }

            return Json(new
            {
                Stock = stock
            }, JsonRequestBehavior.AllowGet);
        }

        #region Comprar desde Pagina de Oferta

        #endregion

        [HttpPost]
        public JsonResult GetDataShowRoomIntriga()
        {
            try
            {
                const int SHOWROOM_ESTADO_INACTIVO = 0;
                const string TIPO_APLICACION_DESKTOP = "Desktop";
                _showRoomProvider.CargarEventoPersonalizacion(userData);
                configEstrategiaSR = SessionManager.GetEstrategiaSR();
                var showRoom = configEstrategiaSR.BeShowRoom ?? new ShowRoomEventoModel();

                if (showRoom.Estado == SHOWROOM_ESTADO_INACTIVO)
                {
                    return Json(new
                    {
                        success = false,
                        data = "",
                        message = "ShowRoomEvento no encontrado"
                    });
                }

                var personalizacionImagenIntriga = configEstrategiaSR
                    .ListaPersonalizacionConsultora
                    .FirstOrDefault(x => x.TipoAplicacion == TIPO_APLICACION_DESKTOP &&
                        x.Atributo == "PopupImagenIntriga");

                var imagenIntriga = "";
                if (personalizacionImagenIntriga != null)
                {
                    imagenIntriga = personalizacionImagenIntriga.Valor;
                }

                var diasFaltantes = (userData.FechaInicioCampania.AddDays(-showRoom.DiasAntes) - DateTime.Now.AddHours(userData.ZonaHoraria).Date).Days;
                var nombreConsultora = string.IsNullOrEmpty(userData.Sobrenombre)
                    ? userData.NombreConsultora
                    : userData.Sobrenombre;
                var mensajeSaludo = string.Format("{0} prepárate para la", nombreConsultora);
                var mensajeDiasFaltantes = diasFaltantes == 1 ? "FALTA 1 DÍA" : string.Format("FALTAN {0} DÍAS", diasFaltantes);

                return Json(new
                {
                    success = true,
                    EventoId = showRoom.EventoID,
                    EventoNombre = showRoom.Nombre,
                    EventoTema = showRoom.Tema,
                    DiasFaltantes = diasFaltantes,
                    MensajeSaludo = mensajeSaludo,
                    MensajeDiasFaltantes = mensajeDiasFaltantes,
                    UrlImagenIntriga = imagenIntriga ?? string.Empty,
                    codigo = Constantes.ConfiguracionPais.ShowRoom
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Hubo un problema con el servicio, intente nuevamente",
                    extra = ""
                }, JsonRequestBehavior.AllowGet);
            }
        }

        public JsonResult PopupIntriga()
        {
            try
            {
                const int SHOWROOM_ESTADO_INACTIVO = 0;
                const string TIPO_APLICACION_DESKTOP = "Desktop";

                _showRoomProvider.CargarEventoPersonalizacion(userData);
                configEstrategiaSR = SessionManager.GetEstrategiaSR();
                if (!_showRoomProvider.PaisTieneShowRoom(userData.CodigoISO))
                {
                    return Json(new
                    {
                        success = false,
                        data = "",
                        message = "ShowRoomConsultora encontrada"
                    });
                }

                var showRoom = configEstrategiaSR.BeShowRoom ?? new ShowRoomEventoModel();

                if (showRoom.Estado == SHOWROOM_ESTADO_INACTIVO)
                {
                    return Json(new
                    {
                        success = false,
                        data = "",
                        message = "ShowRoomEvento no encontrado"
                    });
                }

                var showRoomConsultora = configEstrategiaSR.BeShowRoomConsultora ?? new ShowRoomEventoConsultoraModel();
                var mostrarPopupIntriga = showRoomConsultora.MostrarPopup;
                var mostrarPopupVenta = showRoomConsultora.MostrarPopupVenta;

                if (!mostrarPopupIntriga && !mostrarPopupVenta)
                {
                    return Json(new
                    {
                        success = false
                    });
                }

                var personalizacionImagenIntriga = configEstrategiaSR
                    .ListaPersonalizacionConsultora
                    .FirstOrDefault(x => x.TipoAplicacion == TIPO_APLICACION_DESKTOP &&
                        x.Atributo == "PopupImagenIntriga");

                var imagenIntriga = "";
                if (personalizacionImagenIntriga != null)
                {
                    imagenIntriga = personalizacionImagenIntriga.Valor;
                }

                var diasFaltantes = (userData.FechaInicioCampania.AddDays(-showRoom.DiasAntes) - DateTime.Now.AddHours(userData.ZonaHoraria).Date).Days;
                var nombreConsultora = string.IsNullOrEmpty(userData.Sobrenombre)
                        ? userData.NombreConsultora
                        : userData.Sobrenombre;
                var mensajeSaludo = string.Format("{0} prepárate para la", nombreConsultora);
                var mensajeDiasFaltantes = diasFaltantes == 1 ? "FALTA 1 DÍA" : string.Format("FALTAN {0} DÍAS", diasFaltantes);
                return Json(new
                {
                    success = true,
                    EventoId = showRoom.EventoID,
                    EventoNombre = showRoom.Nombre,
                    EventoTema = showRoom.Tema,
                    DiasFaltantes = diasFaltantes,
                    MensajeSaludo = mensajeSaludo,
                    MensajeDiasFaltantes = mensajeDiasFaltantes,
                    UrlImagenIntriga = imagenIntriga ?? string.Empty,
                    codigo = Constantes.ConfiguracionPais.ShowRoom
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Hubo un problema con el servicio, intente nuevamente",
                    extra = ""
                }, JsonRequestBehavior.AllowGet);
            }
        }

        [HttpPost]
        public JsonResult ProgramarAviso(MisDatosModel model)
        {
            try
            {
                model.EMail = Util.Trim(model.EMail);
                model.Celular = Util.Trim(model.Celular);

                if (string.IsNullOrEmpty(model.EMail))
                {
                    return Json(new
                    {
                        success = false,
                        message = "- El correo no puede ser vacio."
                    });
                }

                if (CorreoPerteneceAOtraConsultora(model))
                {
                    return Json(new
                    {
                        success = false,
                        message = "La dirección de correo electrónico ingresada ya pertenece a otra Consultora.",
                        extra = ""
                    });
                }


                userData.EMail = Util.Trim(userData.EMail);
                userData.Celular = Util.Trim(userData.EMail);

                if (model.EMail != Util.Trim(userData.EMail) ||
                    model.Celular != Util.Trim(userData.Celular))
                {
                    var usuario = ActualizarCorreoUsuario(model, userData.EMail);
                    ActualizarUserData(usuario);
                }

                if (userData.EMail != model.EMail
                    || userData.EMail == model.EMail && !userData.EMailActivo)
                {
                    EnviarConfirmacionCorreoShowRoom(model);
                }

                ProgramarAvisoShowRoom(model);

                return Json(new
                {
                    success = true,
                    message = "- Sus datos se actualizaron correctamente.\n " +
                                "- Se ha enviado un correo electrónico de verificación a la dirección ingresada.",
                    emailValidado = userData.EMailActivo
                });
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
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
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    Cantidad = 0,
                    success = false,
                    message = "Ocurrió un error al acceder al servicio, intente nuevamente.",
                    extra = ""
                });
            }
        }

        [HttpGet]
        public JsonResult DesactivarBannerInferior()
        {
            SessionManager.ShowRoom.BannerInferiorConfiguracion.Activo = false;

            return Json(ResultModel<bool>.BuildOk(true), JsonRequestBehavior.AllowGet);
        }



        #region Metodos Privados

        private bool CorreoPerteneceAOtraConsultora(MisDatosModel model)
        {
            int cantidad;
            using (var svr = new UsuarioServiceClient())
            {
                cantidad = svr.ValidarEmailConsultora(userData.PaisID, model.EMail, userData.CodigoUsuario);
            }
            var correoRegistrado = cantidad > 0;
            return correoRegistrado;
        }

        private ServiceUsuario.BEUsuario ActualizarCorreoUsuario(MisDatosModel model, string correoAnterior)
        {
            var entidad = Mapper.Map<MisDatosModel, ServiceUsuario.BEUsuario>(model);

            entidad.CodigoUsuario = userData.CodigoUsuario;
            entidad.Telefono = userData.Telefono;
            entidad.TelefonoTrabajo = userData.TelefonoTrabajo;
            entidad.Sobrenombre = userData.Sobrenombre;
            entidad.ZonaID = userData.ZonaID;
            entidad.RegionID = userData.RegionID;
            entidad.ConsultoraID = userData.ConsultoraID;
            entidad.PaisID = userData.PaisID;

            using (var sv = new UsuarioServiceClient())
            {
                sv.UpdateDatos(entidad, correoAnterior);
            }

            return entidad;
        }

        private void ActualizarUserData(ServiceUsuario.BEUsuario usuario)
        {
            userData.EMailActivo = usuario.EMail == userData.EMail && userData.EMailActivo;
            userData.EMail = usuario.EMail;
            userData.Celular = usuario.Celular;
            SessionManager.SetUserData(userData);
        }

        private void EnviarConfirmacionCorreoShowRoom(MisDatosModel model)
        {
            const string UTM_NOMBRE_EVENTO = "{{NOMBRE_EVENTO}}";
            var parametros = new[] {
                        userData.CodigoUsuario,
                        userData.PaisID.ToString(),
                        userData.CodigoISO,
                        model.EMail,
                        "UrlReturn,sr"
                    };

            var paramQuerystring = Util.Encrypt(string.Join(";", parametros));

            var esPaisEsika = WebConfig.PaisesEsika.Contains(userData.CodigoISO);

            var cadena = MailUtilities.CuerpoMensajePersonalizado(
                Util.GetUrlHost(HttpContext.Request).ToString(),
                userData.Sobrenombre,
                paramQuerystring,
                esPaisEsika);

            if (model.EnviarParametrosUTMs)
            {
                _showRoomProvider.CargarEventoPersonalizacion(userData);
                configEstrategiaSR = SessionManager.GetEstrategiaSR();
                var nombreEvento = configEstrategiaSR.BeShowRoom != null && configEstrategiaSR.BeShowRoom.Nombre != null ?
                    configEstrategiaSR.BeShowRoom.Nombre.Replace(" ", "") :
                    string.Empty;
                var utms = model.CadenaParametrosUTMs.Replace(UTM_NOMBRE_EVENTO, nombreEvento);
                cadena = cadena.Replace(".aspx?", ".aspx?" + utms + "&");
            }

            Util.EnviarMailMasivoColas("no-responder@somosbelcorp.com", model.EMail, "Confirmación de Correo", cadena, true, userData.NombreConsultora);
        }

        private void ProgramarAvisoShowRoom(MisDatosModel model)
        {
            _showRoomProvider.CargarEventoConsultora(userData);
            configEstrategiaSR.BeShowRoomConsultora = configEstrategiaSR.BeShowRoomConsultora ?? new ShowRoomEventoConsultoraModel();
            configEstrategiaSR.BeShowRoomConsultora.Suscripcion = true;
            configEstrategiaSR.BeShowRoomConsultora.CorreoEnvioAviso = model.EMail;
            configEstrategiaSR.BeShowRoomConsultora.CampaniaID = userData.CampaniaID;
            configEstrategiaSR.BeShowRoomConsultora.CodigoConsultora = userData.CodigoConsultora;
            _showRoomProvider.ShowRoomProgramarAviso(userData.PaisID, configEstrategiaSR.BeShowRoomConsultora);
        }

        #endregion

    }
}