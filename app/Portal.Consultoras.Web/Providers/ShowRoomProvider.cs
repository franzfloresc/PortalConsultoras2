using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.LogManager;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Models.Estrategia.ShowRoom;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.SessionManager;
using System;
using System.Collections.Generic;
using System.Linq;
using BEShowRoomEventoConsultora = Portal.Consultoras.Web.ServicePedido.BEShowRoomEventoConsultora;
using BEShowRoomNivel = Portal.Consultoras.Web.ServicePedido.BEShowRoomNivel;

namespace Portal.Consultoras.Web.Providers
{
    /// <summary>
    /// Propiedades y metodos de ShowRoom
    /// </summary>
    public class ShowRoomProvider
    {
        private const string ImageUrlCode = "bar_in_img";
        private const string RedirectCode = "bar_in_url";
        private const string EnabledCode = "bar_in_act";
        private const string NoUrlAllowed = "bar_in_no";
        private const short Pl50Key = 98;

        private readonly TablaLogicaProvider _tablaLogicaProvider;
        private readonly ILogManager _logManager;
        private readonly ISessionManager sessionManager;
        private readonly ConfiguracionManagerProvider _configuracionManager;

        public ShowRoomProvider(TablaLogicaProvider tablaLogicaProvider)
        {
            _tablaLogicaProvider = tablaLogicaProvider;
            _logManager = LogManager.LogManager.Instance;
            sessionManager = SessionManager.SessionManager.Instance;
            _configuracionManager = new ConfiguracionManagerProvider();
        }

        public ShowRoomProvider()
        {
            _logManager = LogManager.LogManager.Instance;
            sessionManager = SessionManager.SessionManager.Instance;
            _configuracionManager = new ConfiguracionManagerProvider();
        }

        /// <summary>
        /// Obtiene la configuracion de Base de datos
        /// </summary>
        /// <param name="paisId">Pais Id</param>
        /// <returns>Configuracion de Banner inferior</returns>
        public IBannerInferiorConfiguracion ObtenerBannerConfiguracion(int paisId)
        {
            var pl50configs = _tablaLogicaProvider.ObtenerConfiguracion(paisId, Pl50Key);
            var enabledObject = pl50configs.FirstOrDefault(c => c.Codigo == EnabledCode);
            var redirectUrlObject = pl50configs.FirstOrDefault(c => c.Codigo == RedirectCode);
            var imageUrlObject = pl50configs.FirstOrDefault(c => c.Codigo == ImageUrlCode);
            var NoUrlPermitidasObject = pl50configs.FirstOrDefault(c => c.Codigo == NoUrlAllowed);

            return new BannerInferiorConfiguracion
            {
                Activo = enabledObject != null && bool.Parse(enabledObject.Valor),
                UrlImagen = imageUrlObject != null ? imageUrlObject.Valor : string.Empty,
                UrlRedireccion = redirectUrlObject != null ? redirectUrlObject.Valor : string.Empty,
                RutasParcialesExcluidas = NoUrlPermitidasObject != null ? NoUrlPermitidasObject.Valor.Split(';') : new string[0]
            };
        }

        /// <summary>
        /// Obtiene y evalua la session (ShowRoom y Banner)
        /// </summary>
        /// <param name="paisId">Pais Id</param>
        /// <param name="session">Session Manager</param>
        /// <returns>Configuracion de Banner Inferior</returns>
        public IBannerInferiorConfiguracion EvaluarBannerConfiguracion(int paisId, ISessionManager session)
        {
            if (session.ShowRoom.BannerInferiorConfiguracion != null)
                return session.ShowRoom.BannerInferiorConfiguracion;

            var configuracion = ObtenerBannerConfiguracion(paisId);
            configuracion.Activo = configuracion.Activo && session.GetEsShowRoom();

            session.ShowRoom.BannerInferiorConfiguracion = configuracion;

            return configuracion;
        }

        public ShowRoomEventoModel GetShowRoomEventoByCampaniaId(UsuarioModel model)
        {
            using (var sv = new PedidoServiceClient())
            {
                var showRoomEvento = sv.GetShowRoomEventoByCampaniaID(model.PaisID, model.CampaniaID);
                return Mapper.Map<ServicePedido.BEShowRoomEvento, ShowRoomEventoModel>(showRoomEvento);
            }
        }

        public ShowRoomEventoConsultoraModel GetShowRoomConsultora(UsuarioModel model)
        {
            
            using (var sv = new PedidoServiceClient())
            {
                var  showRoomEventoConsultora = sv.GetShowRoomConsultora(
                    model.PaisID, 
                    model.CampaniaID, 
                    model.GetCodigoConsultora(), 
                    true);
                return Mapper.Map<BEShowRoomEventoConsultora, ShowRoomEventoConsultoraModel>(showRoomEventoConsultora);
            }
        }

        public List<ShowRoomNivelModel> GetShowRoomNivel(UsuarioModel model)
        {
            using (var sv = new PedidoServiceClient())
            {
                var showRoomNiveles = sv.GetShowRoomNivel(model.PaisID).ToList();
                return Mapper.Map<List<BEShowRoomNivel> , List<ShowRoomNivelModel>>(showRoomNiveles);
            }
        }

        public List<ShowRoomPersonalizacionModel> GetShowRoomPersonalizacion(UsuarioModel model)
        {
            using (var sv = new PedidoServiceClient())
            {
                var personalizacion = sv.GetShowRoomPersonalizacion(model.PaisID).ToList();
                return Mapper.Map<IList<ServicePedido.BEShowRoomPersonalizacion>, List<ShowRoomPersonalizacionModel>>(personalizacion).ToList();
            }
        }

        public List<ShowRoomPersonalizacionNivelModel> GetShowRoomPersonalizacionNivel(UsuarioModel model,int eventoId, int showRoomNivelId,int categoriaId)
        {
            using (var sv = new PedidoServiceClient())
            {
                var personalizacionesNivel = sv.GetShowRoomPersonalizacionNivel(model.PaisID, eventoId, showRoomNivelId, categoriaId).ToList();
                return Mapper.Map<List<ServicePedido.BEShowRoomPersonalizacionNivel>, List<ShowRoomPersonalizacionNivelModel>>(personalizacionesNivel).ToList();
            }
        }

        public void ShowRoomProgramarAviso(int paisId, ShowRoomEventoConsultoraModel showRoomConsultora)
        {
            var beShowRoomConsultora =
                Mapper.Map<ShowRoomEventoConsultoraModel, ServicePedido.BEShowRoomEventoConsultora>(showRoomConsultora);

            using (var sv = new PedidoServiceClient())
            {
                sv.ShowRoomProgramarAviso(paisId, beShowRoomConsultora);
            }
        }

        public bool GetEventoConsultoraRecibido(UsuarioModel usuario)
        {
            var result = false;

            try
            {
                using (var sv = new PedidoServiceClient())
                {
                    result = sv.GetEventoConsultoraRecibido(usuario.PaisID, usuario.CodigoConsultora, usuario.CampaniaID);
                }
            }
            catch (Exception ex)
            {
                _logManager.LogErrorWebServicesBusWrap(ex, usuario.CodigoConsultora, usuario.CodigoISO, "ShowRoomProvider.GetEventoConsultoraRecibido");
            }

            return result;
        }

        public void UpdShowRoomEventoConsultoraEmailRecibido(string codigoConsultoraFromQueryString, int campaniaIdFromQueryString, UsuarioModel usuario)
        {
            try
            {
                var entidad = new ServicePedido.BEShowRoomEventoConsultora
                {
                    CodigoConsultora = codigoConsultoraFromQueryString,
                    CampaniaID = campaniaIdFromQueryString
                };

                using (var sv = new PedidoServiceClient())
                {
                    sv.UpdShowRoomEventoConsultoraEmailRecibido(usuario.PaisID, entidad);
                }
            }
            catch (Exception ex)
            {
                _logManager.LogErrorWebServicesBusWrap(ex, usuario.CodigoConsultora, usuario.CodigoISO, "ShowRoomProvider.GetEventoConsultoraRecibido");
            }
        }
        
        public void CargarEntidadesShowRoom(UsuarioModel model)
        {
            var configEstrategiaSR = sessionManager.GetEstrategiaSR() ?? new ConfigModel();
            try
            {
                const int SHOWROOM_ESTADO_ACTIVO = 1;

                sessionManager.SetEsShowRoom("0");
                sessionManager.SetMostrarShowRoomProductos("0");
                sessionManager.SetMostrarShowRoomProductosExpiro("0");

                configEstrategiaSR.BeShowRoomConsultora = null;
                configEstrategiaSR.BeShowRoom = null;
                configEstrategiaSR.CargoEntidadesShowRoom = false;

                if (!PaisTieneShowRoom(model.CodigoISO)) return;
                
                configEstrategiaSR.BeShowRoom = GetShowRoomEventoByCampaniaId(model);
                configEstrategiaSR.BeShowRoomConsultora = GetShowRoomConsultora(model);
                configEstrategiaSR.ListaNivel = GetShowRoomNivel(model);
                configEstrategiaSR.ShowRoomNivelId = ObtenerNivelId(configEstrategiaSR.ListaNivel);
                configEstrategiaSR.ListaPersonalizacionConsultora = GetShowRoomPersonalizacion(model);

                if (configEstrategiaSR.BeShowRoom != null &&
                    configEstrategiaSR.BeShowRoom.Estado == SHOWROOM_ESTADO_ACTIVO)
                {
                    ActualizarValorPersonalizacionesShowRoom(model, configEstrategiaSR);
                }

                if (configEstrategiaSR.BeShowRoom != null &&
                    configEstrategiaSR.BeShowRoom.Estado == SHOWROOM_ESTADO_ACTIVO &&
                    configEstrategiaSR.BeShowRoomConsultora != null)
                {
                    sessionManager.SetEsShowRoom("1");

                    var fechaHoy = model.FechaHoy;

                    if (fechaHoy >= model.FechaInicioCampania.AddDays(-configEstrategiaSR.BeShowRoom.DiasAntes).Date
                        && fechaHoy <= model.FechaInicioCampania.AddDays(configEstrategiaSR.BeShowRoom.DiasDespues).Date)
                    {
                        sessionManager.SetMostrarShowRoomProductos("1");
                    }

                    if (fechaHoy > model.FechaInicioCampania.AddDays(configEstrategiaSR.BeShowRoom.DiasDespues).Date)
                        sessionManager.SetMostrarShowRoomProductosExpiro("1");
                }

                configEstrategiaSR.CargoEntidadesShowRoom = true;
            }
            catch (Exception ex)
            {
                Common.LogManager.SaveLog(ex, model.CodigoConsultora, model.CodigoISO);
                configEstrategiaSR.CargoEntidadesShowRoom = false;
            }

            sessionManager.SetEstrategiaSR(configEstrategiaSR);
        }

        public bool PaisTieneShowRoom(string codigoIsoPais)
        {
            if (string.IsNullOrEmpty(codigoIsoPais))
                return false;

            var paisesShowRoom = _configuracionManager.GetConfiguracionManager(Constantes.ConfiguracionManager.PaisesShowRoom);
            var tieneShowRoom = paisesShowRoom.Contains(codigoIsoPais);
            return tieneShowRoom;
        }
        
        public ShowRoomBannerLateralModel GetShowRoomBannerLateral(string codigoIso, double zonaHoraria, DateTime fechaInicioCampania)
        {
            var model = new ShowRoomBannerLateralModel();


            if (!PaisTieneShowRoom(codigoIso))
                return new ShowRoomBannerLateralModel { ConsultoraNoEncontrada = true };

            var configEstrategiaSR = sessionManager.GetEstrategiaSR();
            if (!configEstrategiaSR.CargoEntidadesShowRoom)
                return new ShowRoomBannerLateralModel { ConsultoraNoEncontrada = true };

            model.BEShowRoomConsultora = configEstrategiaSR.BeShowRoomConsultora ?? new ShowRoomEventoConsultoraModel();
            model.BEShowRoom = configEstrategiaSR.BeShowRoom ?? new ShowRoomEventoModel();

            if (model.BEShowRoom.Estado != 1)
                return new ShowRoomBannerLateralModel { EventoNoEncontrado = true };

            model.EstaActivoLateral = true;
            var fechaHoy = DateTime.Now.AddHours(zonaHoraria).Date;
            if ((fechaHoy >= fechaInicioCampania.AddDays(-model.BEShowRoom.DiasAntes).Date &&
                fechaHoy <= fechaInicioCampania.AddDays(model.BEShowRoom.DiasDespues).Date))
            {
                model.MostrarShowRoomProductos = true;
                sessionManager.SetMostrarShowRoomProductos("1");
            }
            if (fechaHoy > fechaInicioCampania.AddDays(model.BEShowRoom.DiasDespues).Date)
                model.EstaActivoLateral = false;

            var diasFalta = fechaInicioCampania.AddDays(-model.BEShowRoom.DiasAntes) - fechaHoy;
            model.DiasFalta = diasFalta.Days;
            model.DiasFaltantes = diasFalta.Days;

            model.MesFaltante = fechaInicioCampania.Month;
            model.AnioFaltante = fechaInicioCampania.Year;

            if (configEstrategiaSR.ListaPersonalizacionConsultora == null)
            {
                model.ImagenPopupShowroomIntriga = "";
                model.ImagenBannerShowroomIntriga = "";
                model.ImagenPopupShowroomVenta = "";
                model.ImagenBannerShowroomVenta = "";
                return model;
            }

            foreach (var item in configEstrategiaSR.ListaPersonalizacionConsultora)
            {
                switch (item.Atributo)
                {
                    case Constantes.ShowRoomPersonalizacion.Mobile.PopupImagenIntriga:
                        model.ImagenPopupShowroomIntriga =
                            item.TipoAplicacion == Constantes.ShowRoomPersonalizacion.TipoAplicacion.Mobile
                                ? item.Valor
                                : "";
                        break;
                    case Constantes.ShowRoomPersonalizacion.Mobile.BannerImagenIntriga:
                        model.ImagenBannerShowroomIntriga =
                            item.TipoAplicacion == Constantes.ShowRoomPersonalizacion.TipoAplicacion.Mobile
                                ? item.Valor
                                : "";
                        break;
                    case Constantes.ShowRoomPersonalizacion.Mobile.PopupImagenVenta:
                        model.ImagenPopupShowroomVenta =
                            item.TipoAplicacion == Constantes.ShowRoomPersonalizacion.TipoAplicacion.Mobile
                                ? item.Valor
                                : "";
                        break;
                    case Constantes.ShowRoomPersonalizacion.Mobile.BannerImagenVenta:
                        model.ImagenBannerShowroomVenta =
                            item.TipoAplicacion == Constantes.ShowRoomPersonalizacion.TipoAplicacion.Mobile
                                ? item.Valor
                                : "";
                        break;
                }
            }

            return model;
        }
        
        private void ActualizarValorPersonalizacionesShowRoom(UsuarioModel model, ConfigModel configEstrategiaSR)
        {
            var personalizacionesNivel = GetShowRoomPersonalizacionNivel(model,
                                    configEstrategiaSR.BeShowRoom.EventoID,
                                    configEstrategiaSR.ShowRoomNivelId,
                                    0);

            var personalizaciones = configEstrategiaSR.ListaPersonalizacionConsultora;

            if (personalizacionesNivel == null || !personalizacionesNivel.Any()) return;

            foreach (var item in personalizaciones)
            {
                item.PersonalizacionNivelId = 0;
                item.Valor = string.Empty;

                var personalizacionNivel = personalizacionesNivel.Find(
                    p => p.NivelId == configEstrategiaSR.ShowRoomNivelId &&
                         p.EventoID == configEstrategiaSR.BeShowRoom.EventoID &&
                         p.PersonalizacionId == item.PersonalizacionId);

                if (personalizacionNivel == null) continue;
                item.PersonalizacionNivelId = personalizacionNivel.PersonalizacionNivelId;
                item.Valor = personalizacionNivel.Valor;

                if (item.TipoAtributo != "IMAGEN") continue;
                if (string.IsNullOrEmpty(item.Valor))
                {
                    item.Valor = string.Empty;
                    continue;
                }

                var carpetaPais = Globals.UrlMatriz + "/" + model.CodigoISO;
                item.Valor = ConfigCdn.GetUrlFileCdn(carpetaPais, item.Valor);
            }
        }
        
        private int ObtenerNivelId(List<ShowRoomNivelModel> niveles)
        {
            var showRoomNivelPais = niveles.FirstOrDefault(p => p.Codigo == "PAIS") ?? new ShowRoomNivelModel();
            return showRoomNivelPais.NivelId;
        }
        
        public string ObtenerValorPersonalizacionShowRoom(string codigoAtributo, string tipoAplicacion)
        {
            var configEstrategiaSR = sessionManager.GetEstrategiaSR(); 
            if (configEstrategiaSR.ListaPersonalizacionConsultora == null)
                return string.Empty;

            var model = configEstrategiaSR.ListaPersonalizacionConsultora.FirstOrDefault(p => p.Atributo == codigoAtributo && p.TipoAplicacion == tipoAplicacion);

            return model == null
                ? string.Empty
                : model.Valor;
        }
    }
}
