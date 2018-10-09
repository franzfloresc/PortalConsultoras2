using AutoMapper;
using Newtonsoft.Json;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceOferta;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.SessionManager;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.Web.Providers
{
    public class OfertaPersonalizadaProvider
    {
        private ISessionManager _sessionManager;
        public virtual ISessionManager SessionManager
        {
            get { return _sessionManager; }
            private set { _sessionManager = value; }
        }

        protected RevistaDigitalModel revistaDigital
        {
            get
            {
                return SessionManager.GetRevistaDigital();
            }
        }
        protected ConfiguracionManagerProvider _configuracionManager;
        protected readonly PedidoWebProvider _pedidoWeb;
        protected OfertaBaseProvider _ofertaBaseProvider;

        public OfertaPersonalizadaProvider() : this(Web.SessionManager.SessionManager.Instance, 
            new ConfiguracionManagerProvider(),
            new PedidoWebProvider(), 
            new OfertaBaseProvider())
        {
        }

        public OfertaPersonalizadaProvider(
            ISessionManager sessionManager,
            ConfiguracionManagerProvider configuracionManagerProvider,
            PedidoWebProvider pedidoWebProvider, 
            OfertaBaseProvider ofertaBaseProvider)
        {
            this.SessionManager = sessionManager;
            _configuracionManager = configuracionManagerProvider;
            _pedidoWeb = pedidoWebProvider;
            _ofertaBaseProvider = ofertaBaseProvider;
        }

        #region Metodos de Estrategia Controller

        public string ConsultarOfertasTipoPalanca(BusquedaProductoModel model, int tipo)
        {

            var palanca = string.Empty;

            if (tipo == Constantes.TipoConsultaOfertaPersonalizadas.RDObtenerProductos)
            {
                var userData = SessionManager.GetUserData();
                if (revistaDigital.ActivoMdo)
                {
                    palanca = Constantes.TipoEstrategiaCodigo.RevistaDigital;
                }
                else
                {
                    palanca = model.CampaniaID != userData.CampaniaID
                        || (revistaDigital.TieneRDC && revistaDigital.EsActiva)
                        ? Constantes.TipoEstrategiaCodigo.RevistaDigital
                        : Constantes.TipoEstrategiaCodigo.OfertaParaTi;
                }
            }
            else if (tipo == Constantes.TipoConsultaOfertaPersonalizadas.GNDObtenerProductos)
            {
                palanca = Constantes.TipoEstrategiaCodigo.GuiaDeNegocioDigitalizada;
            }
            else if (tipo == Constantes.TipoConsultaOfertaPersonalizadas.HVObtenerProductos)
            {
                palanca = Constantes.TipoEstrategiaCodigo.HerramientasVenta;
            }
            else if (tipo == Constantes.TipoConsultaOfertaPersonalizadas.LANObtenerProductos)
            {
                palanca = Constantes.TipoEstrategiaCodigo.Lanzamiento;
            }
            else if (tipo == Constantes.TipoConsultaOfertaPersonalizadas.OPTObtenerProductos)
            {
                palanca = Constantes.TipoEstrategiaCodigo.OfertaParaTi;
            }
            else if (tipo == Constantes.TipoConsultaOfertaPersonalizadas.MGObtenerProductos)
            {
                palanca = Constantes.TipoEstrategiaCodigo.MasGanadoras;
            }


            return palanca;
        }

        public int ConsultarOfertasCampania(BusquedaProductoModel model, int tipo)
        {
            var retorno = 0;

            if (tipo == Constantes.TipoConsultaOfertaPersonalizadas.RDObtenerProductos)
            {
                retorno = model.CampaniaID;
            }
            else if (tipo == Constantes.TipoConsultaOfertaPersonalizadas.GNDObtenerProductos)
            {
                retorno = 0;
            }
            else if (tipo == Constantes.TipoConsultaOfertaPersonalizadas.HVObtenerProductos)
            {
                retorno = model.CampaniaID;
            }
            else if (tipo == Constantes.TipoConsultaOfertaPersonalizadas.LANObtenerProductos)
            {
                retorno = model.CampaniaID;
            }
            else if (tipo == Constantes.TipoConsultaOfertaPersonalizadas.OPTObtenerProductos)
            {
                retorno = 0;
            }

            return retorno;
        }

        public List<EstrategiaPedidoModel> ConsultarOfertasFiltrar(BusquedaProductoModel model, List<EstrategiaPedidoModel> listaFinal1, int tipo)
        {
            var userData = SessionManager.GetUserData();

            var listModel1 = new List<EstrategiaPedidoModel>();
            if (listaFinal1 == null || !listaFinal1.Any())
                return listModel1;

            if (tipo == Constantes.TipoConsultaOfertaPersonalizadas.RDObtenerProductos)
            {
                var mdo0 = revistaDigital.ActivoMdo && !revistaDigital.EsActiva;

                if (mdo0 && model.CampaniaID == userData.CampaniaID)
                {
                    var listaRd = listaFinal1.Where(e => e.TipoEstrategia.Codigo == Constantes.TipoEstrategiaCodigo.OfertasParaMi || e.TipoEstrategia.Codigo == Constantes.TipoEstrategiaCodigo.PackAltoDesembolso).ToList();
                    listModel1 = listaFinal1.Where(e => e.TipoEstrategia.Codigo != Constantes.TipoEstrategiaCodigo.OfertasParaMi && e.TipoEstrategia.Codigo != Constantes.TipoEstrategiaCodigo.PackAltoDesembolso).ToList();
                    listModel1.AddRange(listaRd.Where(e => e.FlagRevista == Constantes.FlagRevista.Valor0));
                }
                else
                {
                    listModel1 = listaFinal1;
                }
            }
            else if (tipo == Constantes.TipoConsultaOfertaPersonalizadas.GNDObtenerProductos)
            {
                if (revistaDigital.TieneRDCR)
                {
                    // se puede cambiar a un BaseController.GetConfiguracionManagerContains
                    // cuando exista ConfiguracionManagerContainsProvider
                    var keyvalor = ConfigurationManager.AppSettings.Get(Constantes.ConfiguracionManager.RevistaPiloto_Zonas_RDR_2 + userData.CodigoISO);
                    keyvalor = Util.Trim(keyvalor);
                    if (keyvalor.Contains(userData.CodigoZona))
                    {
                        listaFinal1 = listaFinal1.Where(e => e.FlagRevista == Constantes.FlagRevista.Valor1 || e.FlagRevista == Constantes.FlagRevista.Valor3).ToList();
                    }
                    else
                    {
                        listaFinal1 = listaFinal1.Where(e => e.FlagRevista == Constantes.FlagRevista.Valor1).ToList();
                    }
                }

                listModel1 = listaFinal1;
            }
            else if (tipo == Constantes.TipoConsultaOfertaPersonalizadas.HVObtenerProductos)
            {
                listaFinal1 = listaFinal1
                    .ToList();

                listModel1 = listaFinal1;
            }
            else if (tipo == Constantes.TipoConsultaOfertaPersonalizadas.LANObtenerProductos)
            {
                listModel1 = listaFinal1;
            }
            else if (tipo == Constantes.TipoConsultaOfertaPersonalizadas.OPTObtenerProductos)
            {
                listModel1 = listaFinal1;
            }

            return listModel1;

        }

        public int ConsultarOfertasTipoPerdio(BusquedaProductoModel model, int tipo)
        {
            var retorno = 0;

            if (tipo == Constantes.TipoConsultaOfertaPersonalizadas.RDObtenerProductos)
            {
                retorno = 2;
            }
            else if (tipo == Constantes.TipoConsultaOfertaPersonalizadas.GNDObtenerProductos)
            {
                retorno = 2;
            }
            else if (tipo == Constantes.TipoConsultaOfertaPersonalizadas.HVObtenerProductos)
            {
                retorno = 2;
            }
            else if (tipo == Constantes.TipoConsultaOfertaPersonalizadas.LANObtenerProductos)
            {
                retorno = TieneProductosPerdio(model.CampaniaID) ? 1 : 0;
            }
            else if (tipo == Constantes.TipoConsultaOfertaPersonalizadas.OPTObtenerProductos)
            {
                retorno = 0;
            }

            return retorno;
        }

        public bool TieneProductosPerdio(int campaniaId)
        {
            var userData = SessionManager.GetUserData();

            if (revistaDigital.TieneRDC && !revistaDigital.EsActiva &&
                campaniaId == userData.CampaniaID)
                return true;

            return false;
        }

        public bool ConsultarOfertasValidarPermiso(BusquedaProductoModel model, int tipo)
        {
            var _guiaNegocioProvider = new GuiaNegocioProvider();

            if (tipo == Constantes.TipoConsultaOfertaPersonalizadas.RDObtenerProductos)
            {
                if (model == null || !(revistaDigital.TieneRevistaDigital()) || EsCampaniaFalsa(model.CampaniaID))
                {
                    return false;
                }
            }
            else if (tipo == Constantes.TipoConsultaOfertaPersonalizadas.GNDObtenerProductos)
            {
                var userData = SessionManager.GetUserData();
                var guiaNegocio = SessionManager.GetGuiaNegocio();

                if (!_guiaNegocioProvider.GNDValidarAcceso(userData.esConsultoraLider, guiaNegocio, revistaDigital))
                {
                    return false;
                }
            }
            else if (tipo == Constantes.TipoConsultaOfertaPersonalizadas.HVObtenerProductos)
            {
                return true;
            }
            else if (tipo == Constantes.TipoConsultaOfertaPersonalizadas.LANObtenerProductos)
            {
                if (!(revistaDigital.TieneRevistaDigital()) || EsCampaniaFalsa(model.CampaniaID))
                {
                    return false;
                }
            }
            else if (tipo == Constantes.TipoConsultaOfertaPersonalizadas.OPTObtenerProductos)
            {
                return true;
            }
            else if (tipo == Constantes.TipoConsultaOfertaPersonalizadas.MGObtenerProductos)
            {
                return _sessionManager.MasGanadoras.GetModel().TieneMG;
            }
            return true;
        }

        #region Mas Vendidos
        public EstrategiaOutModel BSActualizarPosicion(EstrategiaOutModel model)
        {
            if (model != null)
            {
                for (int i = 0; i <= model.Lista.Count - 1; i++)
                {
                    model.Lista[i].Posicion = i + 1;
                }
            }
            return model;
        }

        public EstrategiaOutModel BSActualizarPrecioFormateado(EstrategiaOutModel model)
        {
            if (model != null)
            {
                var userData = SessionManager.GetUserData();
                for (int i = 0; i <= model.Lista.Count - 1; i++)
                {
                    model.Lista[i].Posicion = i + 1;
                    model.Lista[i].PrecioTachado = Util.DecimalToStringFormat(model.Lista[i].Precio, userData.CodigoISO);
                    model.Lista[i].GananciaString = Util.DecimalToStringFormat(model.Lista[i].Ganancia, userData.CodigoISO);
                }
            }
            return model;
        }
        #endregion

        #endregion

        #region Cargar ofertas Por tipo

        public List<ServiceOferta.BEEstrategia> ConsultarEstrategias(bool esMobile, int campaniaId, string codAgrupacion, bool filtrarNuevasAgregadas = false)
        {
            codAgrupacion = Util.Trim(codAgrupacion);
            var listEstrategia = new List<ServiceOferta.BEEstrategia>();

            switch (codAgrupacion)
            {
                case Constantes.TipoEstrategiaCodigo.RevistaDigital:
                    listEstrategia.AddRange(ConsultarEstrategiasPorTipo(esMobile, Constantes.TipoEstrategiaCodigo.PackNuevas, campaniaId, filtrarNuevasAgregadas));
                    listEstrategia.AddRange(ConsultarEstrategiasPorTipo(esMobile, Constantes.TipoEstrategiaCodigo.OfertaWeb, campaniaId));
                    if (_sessionManager.MasGanadoras.GetModel().TieneMG)
                    {
                        listEstrategia.AddRange(ConsultarEstrategiasPorTipo(esMobile,
                            Constantes.TipoEstrategiaCodigo.RevistaDigital,
                            campaniaId,
                            false,
                            Constantes.MasGanadoras.ObtenerOpmSinForzadas));
                    }
                    else
                    {
                        listEstrategia.AddRange(ConsultarEstrategiasPorTipo(esMobile,
                            Constantes.TipoEstrategiaCodigo.RevistaDigital,
                            campaniaId,
                            false,
                            Constantes.MasGanadoras.ObtenerOpmTodo));
                    }
                    break;
                case Constantes.TipoEstrategiaCodigo.Lanzamiento:
                    listEstrategia.AddRange(ConsultarEstrategiasPorTipo(esMobile, Constantes.TipoEstrategiaCodigo.Lanzamiento, campaniaId));
                    break;
                case Constantes.TipoEstrategiaCodigo.GuiaDeNegocioDigitalizada:
                    listEstrategia.AddRange(ConsultarEstrategiasPorTipo(esMobile, Constantes.TipoEstrategiaCodigo.GuiaDeNegocioDigitalizada, campaniaId));
                    break;
                case Constantes.TipoEstrategiaCodigo.HerramientasVenta:
                    listEstrategia.AddRange(ConsultarEstrategiasPorTipo(esMobile, Constantes.TipoEstrategiaCodigo.HerramientasVenta, campaniaId));
                    break;
                case Constantes.TipoEstrategiaCodigo.LosMasVendidos:
                    listEstrategia.AddRange(ConsultarEstrategiasPorTipo(esMobile, Constantes.TipoEstrategiaCodigo.LosMasVendidos, campaniaId));
                    break;
                case Constantes.TipoEstrategiaCodigo.OfertaParaTi:
                    listEstrategia.AddRange(ConsultarEstrategiasPorTipo(esMobile, Constantes.TipoEstrategiaCodigo.PackNuevas, campaniaId, filtrarNuevasAgregadas));
                    listEstrategia.AddRange(ConsultarEstrategiasPorTipo(esMobile, Constantes.TipoEstrategiaCodigo.OfertaWeb, campaniaId));
                    listEstrategia.AddRange(ConsultarEstrategiasPorTipo(esMobile, Constantes.TipoEstrategiaCodigo.OfertaParaTi, campaniaId));
                    break;
                case Constantes.TipoEstrategiaCodigo.MasGanadoras:
                    listEstrategia.AddRange(ConsultarEstrategiasPorTipo(esMobile, 
                        Constantes.TipoEstrategiaCodigo.RevistaDigital, 
                        campaniaId,
                        false,
                        Constantes.MasGanadoras.ObtenerOpmSoloForzadas));
                    break;
            }

            return listEstrategia;
        }

        protected virtual List<ServiceOferta.BEEstrategia> ConsultarEstrategiasPorTipo(bool esMobile, 
            string tipo, 
            int campaniaId,
            bool filtrarNuevasAgregadas = false,
            int materialGanancia =0)
        {
            var userData = SessionManager.GetUserData();
            List<ServiceOferta.BEEstrategia> listEstrategia;
            try
            {
                campaniaId = campaniaId > 0 ? campaniaId : userData.CampaniaID;
                tipo = Util.Trim(tipo);
                string varSession = Constantes.ConstSession.ListaEstrategia + tipo;
                filtrarNuevasAgregadas = tipo == Constantes.TipoEstrategiaCodigo.PackNuevas && filtrarNuevasAgregadas;

                listEstrategia = SessionManager.GetBEEstrategia(varSession);
                if (listEstrategia != null && campaniaId == userData.CampaniaID && listEstrategia.Any())
                {                   
                    if (filtrarNuevasAgregadas) 
                        listEstrategia = ConsultarEstrategiasFiltrarPackNuevasPedido(listEstrategia);
                    return listEstrategia;
                }

                var entidad = new ServiceOferta.BEEstrategia
                {
                    PaisID = userData.PaisID,
                    CampaniaID = campaniaId,
                    ConsultoraID = userData.GetCodigoConsultora(),
                    Zona = userData.ZonaID.ToString(),
                    ZonaHoraria = userData.ZonaHoraria,
                    FechaInicioFacturacion = userData.FechaFinCampania,
                    ValidarPeriodoFacturacion = true,
                    Simbolo = userData.Simbolo,
                    CodigoTipoEstrategia = tipo,
                    MaterialGanancia = materialGanancia
                };

                if (tipo == Constantes.TipoEstrategiaCodigo.LosMasVendidos)
                {
                    entidad.ConsultoraID = userData.GetConsultoraId().ToString();
                }

                if (_ofertaBaseProvider.UsarMsPersonalizacion(userData.CodigoISO, tipo))
                {
                    string pathRevistaDigital = string.Format(Constantes.PersonalizacionOfertasService.UrlObtenerRevistaDigital,
                        userData.CodigoISO,
                        Constantes.ConfiguracionPais.RevistaDigital,
                        campaniaId,
                        userData.CodigoConsultora,
                        userData.CodigorRegion,
                        userData.ZonaID);
                    var taskApi = Task.Run(() => _ofertaBaseProvider.ObtenerOfertasDesdeApi(pathRevistaDigital, userData.CodigoISO));
                    Task.WhenAll(taskApi);
                    listEstrategia = taskApi.Result;
                }
                else
                {
                    using (OfertaServiceClient osc = new OfertaServiceClient())
                    {
                        listEstrategia = osc.GetEstrategiasPedido(entidad).ToList();
                    }
                }

                if (campaniaId == userData.CampaniaID)
                {
                    if (tipo == Constantes.TipoEstrategiaCodigo.PackNuevas
                        || tipo == Constantes.TipoEstrategiaCodigo.OfertaParaTi
                        || tipo == Constantes.TipoEstrategiaCodigo.OfertaWeb)
                    {
                        SessionManager.SetBEEstrategia(varSession, listEstrategia);
                    }
                    if (filtrarNuevasAgregadas && listEstrategia.Any()) 
                        listEstrategia = ConsultarEstrategiasFiltrarPackNuevasPedido(listEstrategia);
                }

                if (!listEstrategia.Any() && SessionManager.GetFlagLogCargaOfertas() &&
                    tipo != Constantes.TipoEstrategiaCodigo.OfertaWeb &&
                    tipo != Constantes.TipoEstrategiaCodigo.PackNuevas)
                    EnviarLogOferta(campaniaId, tipo, esMobile);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                listEstrategia = new List<ServiceOferta.BEEstrategia>();
            }
            return listEstrategia;
        }

        #endregion

        #region Metodos consumo Ofertas por tipo

        public List<EstrategiaPedidoModel> ConsultarEstrategiasHomePedido(bool esMobile, string codigoIso, int campaniaId, string codAgrupacion = "")
        {
            List<ServiceOferta.BEEstrategia> listModel;
            if (SessionManager.GetBEEstrategia(Constantes.ConstSession.ListaEstrategia) != null)
                listModel = SessionManager.GetBEEstrategia(Constantes.ConstSession.ListaEstrategia);
            else
            {
                listModel = ConsultarEstrategias(esMobile, 0, codAgrupacion, true);

                if (!listModel.Any())
                {
                    SessionManager.SetBEEstrategia(Constantes.ConstSession.ListaEstrategia, listModel);
                    return new List<EstrategiaPedidoModel>();
                }

                #region Validar Tipo RD 

                if (codAgrupacion == Constantes.TipoEstrategiaCodigo.RevistaDigital)
                {
                    var listModelLan = ConsultarEstrategias(esMobile, 0, Constantes.TipoEstrategiaCodigo.Lanzamiento);
                    var estrategiaLanzamiento = listModelLan.FirstOrDefault() ?? new ServiceOferta.BEEstrategia();

                    if (!listModel.Any() && estrategiaLanzamiento.EstrategiaID <= 0)
                    {
                        SessionManager.SetBEEstrategia(Constantes.ConstSession.ListaEstrategia, listModel);
                        return new List<EstrategiaPedidoModel>();
                    }

                    var listaPackNueva = listModel.Where(e => e.TipoEstrategia.Codigo == Constantes.TipoEstrategiaCodigo.PackNuevas).ToList();

                    var listaRevista = listModel.Where(e => e.TipoEstrategia.Codigo == Constantes.TipoEstrategiaCodigo.OfertasParaMi).ToList();

                    if (revistaDigital.ActivoMdo && !revistaDigital.EsActiva)
                    {
                        listaRevista = listaRevista.Where(e => e.FlagRevista == Constantes.FlagRevista.Valor0).ToList();
                    }

                    var cantMax = 8;
                    var cantPack = listaPackNueva.Any() ? 1 : 0;
                    var top = Math.Min(cantMax - cantPack, listaRevista.Count);

                    if (listaRevista.Count > top)
                        listaRevista.RemoveRange(top, listaRevista.Count - top);

                    if (listaPackNueva.Count > 0 && listaPackNueva.Count > cantMax - top)
                        listaPackNueva.RemoveRange(cantMax - top, listaPackNueva.Count - (cantMax - top));

                    listModel = new List<ServiceOferta.BEEstrategia>();
                    if (estrategiaLanzamiento.EstrategiaID > 0)
                        listModel.Add(estrategiaLanzamiento);

                    listModel.AddRange(listaPackNueva);
                    listModel.AddRange(listaRevista);
                }
                #endregion

                SessionManager.SetBEEstrategia(Constantes.ConstSession.ListaEstrategia, listModel);
            }

            var listaProductoModel = ConsultarEstrategiasFormatoEstrategiaToModel1(listModel, codigoIso, campaniaId);
            return listaProductoModel;
        }

        public List<EstrategiaPedidoModel> ConsultarEstrategiasModel(bool esMobile, string codigoIso, int campaniaIdConsultora, int campaniaId, string codAgrupacion)
        {
            var listaProducto = ConsultarEstrategias(esMobile, campaniaId, codAgrupacion, false);
            List<EstrategiaPedidoModel> listaProductoModel = ConsultarEstrategiasFormatoEstrategiaToModel1(listaProducto, codigoIso, campaniaIdConsultora);
            return listaProductoModel;
        }

        public List<EstrategiaPedidoModel> ConsultarMasVendidosModel(bool esMobile, string codigoIso, int campaniaId)
        {
            var listaProducto = ConsultarEstrategias(esMobile, 0, Constantes.TipoEstrategiaCodigo.LosMasVendidos);
            var listaProductoModel = Mapper.Map<List<ServiceOferta.BEEstrategia>, List<EstrategiaPedidoModel>>(listaProducto);
            var listaPedido = _pedidoWeb.ObtenerPedidoWebDetalle(0);
            listaProductoModel = ConsultarEstrategiasFormatoModelo1(listaProductoModel, listaPedido, codigoIso, campaniaId);
            return listaProductoModel;
        }

        #endregion

        #region Metodos de Base estrategia Controller

        public bool EsCampaniaFalsa(int campaniaId)
        {
            var userData = SessionManager.GetUserData();
            if (userData == null)
            {
                return true;
            }
            return (campaniaId < userData.CampaniaID || campaniaId > Util.AddCampaniaAndNumero(userData.CampaniaID, 1, userData.NroCampanias));
        }

        public string ObtenerConstanteConfPais(string codigoAgrupacion)
        {
            switch (codigoAgrupacion)
            {
                case Constantes.TipoEstrategiaCodigo.RevistaDigital:
                    return Constantes.ConfiguracionPais.RevistaDigital;
                case Constantes.TipoEstrategiaCodigo.Lanzamiento:
                    return Constantes.ConfiguracionPais.Lanzamiento;
                case Constantes.TipoEstrategiaCodigo.GuiaDeNegocioDigitalizada:
                    return Constantes.ConfiguracionPais.GuiaDeNegocioDigitalizada;
                default:
                    return Constantes.ConfiguracionPais.OfertasParaTi;
            }
        }

        public void EnviarLogOferta(int campaniaId, string tipo, bool esMObile)
        {
            object data = CrearDataLog(campaniaId, ObtenerConstanteConfPais(tipo), esMObile);
            var urlApi = _configuracionManager.GetConfiguracionManager(Constantes.ConfiguracionManager.UrlLogDynamo);

            if (string.IsNullOrEmpty(urlApi)) return;

            var httpClient = new HttpClient { BaseAddress = new Uri(urlApi) };
            httpClient.DefaultRequestHeaders.Accept.Clear();
            httpClient.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));

            var dataString = JsonConvert.SerializeObject(data);

            HttpContent contentPost = new StringContent(dataString, Encoding.UTF8, "application/json");

            var response = httpClient.PostAsync("Api/LogCargaOfertas", contentPost).GetAwaiter().GetResult();

            var noQuitar = response.IsSuccessStatusCode;

            httpClient.Dispose();
        }

        private object CrearDataLog(int campaniaOferta, string palanca, bool esMObile)
        {
            var userData = SessionManager.GetUserData();

            return new
            {
                Pais = userData.CodigoISO,
                CodigoConsultora = userData.CodigoConsultora,
                Fecha = userData.FechaActualPais.ToString("yyyyMMdd"),
                Campania = userData.CampaniaID,
                CampaniaOferta = campaniaOferta == 0 ? userData.CampaniaID.ToString() : campaniaOferta.ToString(),
                Palanca = palanca,
                Dispositivo = esMObile ? "Mobile" : "Desktop",
                Motivo = "Log carga oferta desde portal consultoras"
            };
        }

        public virtual EstrategiaPersonalizadaProductoModel ObtenerEstrategiaPersonalizada(UsuarioModel usuarioModel, string palanca, string cuv, int campaniaId)
        {
            try
            {
                var estrategiaPersonalizada = ObtenerEstrategiaPersonalizadaSession(usuarioModel, palanca, cuv, campaniaId, usuarioModel.CodigoConsultora, usuarioModel.EsDiasFacturacion);
                if (estrategiaPersonalizada == null || !estrategiaPersonalizada.CUV2.Equals(cuv))
                    return null;
                estrategiaPersonalizada.Hermanos = new List<EstrategiaComponenteModel>();
                estrategiaPersonalizada.TextoLibre = Util.Trim(estrategiaPersonalizada.TextoLibre);
                estrategiaPersonalizada.CodigoVariante = Util.Trim(estrategiaPersonalizada.CodigoVariante);
                return estrategiaPersonalizada;
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, usuarioModel.CodigoConsultora, usuarioModel.CodigoISO);
                return null;
            }
        }

        #endregion

        #region ShowRoom

        public List<ServiceOferta.BEEstrategia> GetShowRoomOfertasConsultora(UsuarioModel usuarioModel)
        {
            var entidad = new ServiceOferta.BEEstrategia
            {
                PaisID = usuarioModel.PaisID,
                CampaniaID = usuarioModel.CampaniaID,
                ConsultoraID = usuarioModel.GetCodigoConsultora(),
                ZonaHoraria = usuarioModel.ZonaHoraria,
                FechaInicioFacturacion = usuarioModel.FechaInicioCampania,
                ValidarPeriodoFacturacion = true,
                Simbolo = usuarioModel.Simbolo,
                CodigoTipoEstrategia = "030"
            };

            using (var osc = new OfertaServiceClient())
            {
                var listaProducto = osc.GetEstrategiasPedido(entidad).ToList();
                return listaProducto;
            }
        }

        public List<EstrategiaPedidoModel> GetProductosCompraPorCompra(UsuarioModel usuario, int eventoId)
        {
            using (var ofertaService = new OfertaServiceClient())
            {
                var listaShowRoomCpc = ofertaService.GetProductosCompraPorCompra(usuario.PaisID, eventoId, usuario.CampaniaID).ToList();
                return Mapper.Map<List<ServiceOferta.BEShowRoomOferta>, List<EstrategiaPedidoModel>>(listaShowRoomCpc);
            }
        }

        #endregion

        public int TipoAccionAgregar(int tieneVariedad, string codigoTipoEstrategia, bool esConsultoraLider = false, bool bloqueado = false, string codigoTipos = "")
        {
            var tipo = tieneVariedad == 0 ? codigoTipoEstrategia == Constantes.TipoEstrategiaCodigo.PackNuevas ? 1 : 2 : 3;
            if (codigoTipoEstrategia == Constantes.TipoEstrategiaCodigo.GuiaDeNegocioDigitalizada)
            {
                tipo = esConsultoraLider && revistaDigital.SociaEmpresariaExperienciaGanaMas && revistaDigital.EsSuscritaActiva() ? 0 : tipo;
            }
            else if (codigoTipoEstrategia == Constantes.TipoEstrategiaCodigo.ShowRoom)
            {
                tipo = codigoTipos == Constantes.TipoEstrategiaSet.CompuestaVariable ? 3 : 2;
                tipo = bloqueado && revistaDigital.EsNoSuscritaInactiva() ? 4 : tipo;
                tipo = bloqueado && revistaDigital.EsSuscritaInactiva() ? 5 : tipo;
            }
            else if (codigoTipoEstrategia == Constantes.TipoEstrategiaCodigo.OfertasParaMi
                || codigoTipoEstrategia == Constantes.TipoEstrategiaCodigo.PackAltoDesembolso
                || codigoTipoEstrategia == Constantes.TipoEstrategiaCodigo.Lanzamiento)
            {
                tipo = bloqueado && revistaDigital.EsNoSuscritaInactiva() ? 4 : tipo;
                tipo = bloqueado && revistaDigital.EsSuscritaInactiva() ? 5 : tipo;
            }
            return tipo;
        }

        #region Formato Estrategia a Modelo

        public List<EstrategiaPersonalizadaProductoModel> ConsultarEstrategiasModelFormato(List<ServiceOferta.BEEstrategia> listaProducto, string codigoISO, int campaniaID, int tipo, bool esConsultoraLider, string simbolo)
        {
            var listaPedido = _pedidoWeb.ObtenerPedidoWebDetalle(0);
            var listaEstrategiaPedidoModel = ConsultarEstrategiasFormatoEstrategiaToModel1(listaProducto, codigoISO, campaniaID);
            var listaPersonalizadaModel = FormatearModelo1ToPersonalizado(listaEstrategiaPedidoModel, listaPedido, codigoISO, campaniaID, tipo, esConsultoraLider, simbolo);
            return listaPersonalizadaModel;
        }

        public List<EstrategiaPedidoModel> ConsultarEstrategiasFormatoEstrategiaToModel1(List<ServiceOferta.BEEstrategia> listaProducto, string codigoISO, int campaniaID)
        {
            listaProducto = listaProducto ?? new List<ServiceOferta.BEEstrategia>();
            List<EstrategiaPedidoModel> listaProductoModel = Mapper.Map<List<ServiceOferta.BEEstrategia>, List<EstrategiaPedidoModel>>(listaProducto);

            listaProductoModel.Update(
                x => {
                    if (listaProducto.Where(c => c.CUV2 == x.CUV2 && c.CampaniaID == x.CampaniaID).FirstOrDefault().EstrategiaProducto != null)
                        x.Hermanos = ObtenerListaTonos(
                            listaProducto.Where(c => c.CUV2 == x.CUV2 && c.CampaniaID == x.CampaniaID)
                            .FirstOrDefault().EstrategiaProducto.ToList());
                });
            var listaPedido = _pedidoWeb.ObtenerPedidoWebSetDetalleAgrupado(0);
            var listaEstrategiaPedidoModel = ConsultarEstrategiasFormatoModelo1(listaProductoModel, listaPedido, codigoISO, campaniaID);
            return listaEstrategiaPedidoModel;
        }

        private List<EstrategiaComponenteModel> ObtenerListaTonos(List<ServiceOferta.BEEstrategiaProducto> listaEstrategiaProducto)
        {
            var listaTonos = new List<EstrategiaComponenteModel>();
            foreach (var item in listaEstrategiaProducto)
            {
                EstrategiaComponenteModel tono = new EstrategiaComponenteModel()
                {
                    Grupo = item.Grupo,
                    Cuv = item.CUV,
                    CodigoProducto = item.SAP,
                    Orden = item.Orden,
                    PrecioCatalogo = item.Precio,
                    PrecioCatalogoString = item.Precio.ToString(),
                    Digitable = item.Digitable,
                    Cantidad = item.Cantidad,
                    FactorCuadre = item.FactorCuadre,
                    IdMarca = item.IdMarca
                };
                listaTonos.Add(tono);
            }
            return listaTonos;
        }

        public List<EstrategiaPedidoModel> ConsultarEstrategiasFormatoModelo1(List<EstrategiaPedidoModel> listaProductoModel, List<BEPedidoWebDetalle> listaPedido, string codigoISO, int campaniaID)
        {
            if (!listaProductoModel.Any())
                return listaProductoModel;

            var carpetaPais = Globals.UrlMatriz + "/" + codigoISO;
            var claseBloqueada = "btn_desactivado_general";
            listaProductoModel.ForEach(estrategia =>
            {
                estrategia.ClaseBloqueada = estrategia.CampaniaID > 0 && estrategia.CampaniaID != campaniaID ? claseBloqueada : "";
                estrategia.IsAgregado = estrategia.ClaseBloqueada != claseBloqueada && listaPedido.Any(p => p.EstrategiaId == estrategia.EstrategiaID);
                estrategia.DescripcionResumen = "";
                estrategia.DescripcionDetalle = "";
                estrategia.EstrategiaDetalle = estrategia.EstrategiaDetalle ?? new EstrategiaDetalleModelo();

                if (estrategia.TipoEstrategia.Codigo == Constantes.TipoEstrategiaCodigo.Lanzamiento)
                {
                    #region Lanzamiento
                    estrategia.EstrategiaDetalle.ImgFondoDesktop = ConfigCdn.GetUrlFileCdn(carpetaPais, estrategia.EstrategiaDetalle.ImgFondoDesktop);
                    estrategia.EstrategiaDetalle.ImgFichaDesktop = ConfigCdn.GetUrlFileCdn(carpetaPais, estrategia.EstrategiaDetalle.ImgFichaDesktop);
                    estrategia.EstrategiaDetalle.ImgFichaFondoDesktop = ConfigCdn.GetUrlFileCdn(carpetaPais, estrategia.EstrategiaDetalle.ImgFichaFondoDesktop);
                    estrategia.EstrategiaDetalle.UrlVideoDesktop = Util.Trim(estrategia.EstrategiaDetalle.UrlVideoDesktop);
                    estrategia.EstrategiaDetalle.ImgFondoMobile = ConfigCdn.GetUrlFileCdn(carpetaPais, estrategia.EstrategiaDetalle.ImgFondoMobile);
                    estrategia.EstrategiaDetalle.ImgFichaMobile = ConfigCdn.GetUrlFileCdn(carpetaPais, estrategia.EstrategiaDetalle.ImgFichaMobile);
                    estrategia.EstrategiaDetalle.ImgFichaFondoMobile = ConfigCdn.GetUrlFileCdn(carpetaPais, estrategia.EstrategiaDetalle.ImgFichaFondoMobile);
                    estrategia.EstrategiaDetalle.UrlVideoMobile = Util.Trim(estrategia.EstrategiaDetalle.UrlVideoMobile);
                    estrategia.EstrategiaDetalle.ImgHomeDesktop = ConfigCdn.GetUrlFileCdn(carpetaPais, estrategia.EstrategiaDetalle.ImgHomeDesktop);
                    estrategia.EstrategiaDetalle.ImgHomeMobile = ConfigCdn.GetUrlFileCdn(carpetaPais, estrategia.EstrategiaDetalle.ImgHomeMobile);

                    var listadescr = estrategia.DescripcionCUV2.Split('|');
                    estrategia.DescripcionResumen = listadescr.Length > 0 ? listadescr[0] : "";
                    estrategia.DescripcionCortada = listadescr.Length > 1 ? listadescr[1] : "";
                    if (listadescr.Length > 2)
                    {
                        estrategia.ListaDescripcionDetalle = new List<string>(listadescr.Skip(2));
                        estrategia.DescripcionDetalle = string.Join("<br />", listadescr.Skip(2));
                    }
                    estrategia.DescripcionCortada = Util.SubStrCortarNombre(estrategia.DescripcionCortada, 40);

                    estrategia.ImagenURL = estrategia.EstrategiaDetalle.ImgFichaDesktop;

                    #endregion
                }
                else if (estrategia.FlagNueva == 1)
                {
                    estrategia.Precio = 0;
                    estrategia.DescripcionCortada = estrategia.DescripcionCUV2.Split('|')[0];
                    estrategia.DescripcionDetalle = estrategia.DescripcionCUV2.Contains("|") ? estrategia.DescripcionCUV2.Split('|')[1] : string.Empty;
                }
                else if (estrategia.TipoEstrategia.Codigo == Constantes.TipoEstrategiaCodigo.OfertaDelDia)
                {
                    var listadescr = estrategia.DescripcionCUV2.Split('|');
                    estrategia.DescripcionCortada = listadescr.Length > 0 ? listadescr[0] : "";
                    if (listadescr.Length > 1)
                    {
                        estrategia.ListaDescripcionDetalle = new List<string>(listadescr.Skip(1));
                    }
                    estrategia.DescripcionCortada = Util.SubStrCortarNombre(estrategia.DescripcionCortada, 40);
                }
                else
                {
                    estrategia.DescripcionCortada = Util.SubStrCortarNombre(estrategia.DescripcionCUV2, 40);
                }

                estrategia.ID = estrategia.EstrategiaID;
                if (estrategia.FlagMostrarImg == 1)
                {
                    if (estrategia.TipoEstrategiaImagenMostrar == Constantes.TipoEstrategia.OfertaParaTi)
                    {
                        if (estrategia.FlagEstrella == 1)
                        {
                            estrategia.ImagenURL = "/Content/Images/oferta-ultimo-minuto.png";
                        }
                    }
                    else if (!(estrategia.TipoEstrategiaImagenMostrar == Constantes.TipoEstrategia.PackNuevas
                        || estrategia.TipoEstrategiaImagenMostrar == Constantes.TipoEstrategia.Lanzamiento))
                    {
                        estrategia.ImagenURL = "";
                    }
                }
                else
                {
                    estrategia.ImagenURL = "";
                }

                estrategia.PuedeCambiarCantidad = 1;
                if (estrategia.TieneVariedad == 0 && estrategia.TipoEstrategiaImagenMostrar == Constantes.TipoEstrategia.PackNuevas)
                {
                    estrategia.PuedeCambiarCantidad = 0;
                }
                estrategia.PuedeAgregar = 1;
                estrategia.PuedeVerDetalle = estrategia.EstrategiaDetalle != null &&
                                                ((estrategia.ListaDescripcionDetalle != null && estrategia.ListaDescripcionDetalle.Any()) ||
                                                !estrategia.EstrategiaDetalle.UrlVideoDesktop.IsNullOrEmptyTrim());
                estrategia.PuedeVerDetalleMob = estrategia.EstrategiaDetalle != null &&
                                             ((estrategia.ListaDescripcionDetalle != null && estrategia.ListaDescripcionDetalle.Any()) ||
                                              !estrategia.EstrategiaDetalle.UrlVideoMobile.IsNullOrEmptyTrim());
            });

            return listaProductoModel;
        }

        public List<EstrategiaPersonalizadaProductoModel> FormatearModelo1ToPersonalizado(List<EstrategiaPedidoModel> listaProductoModel, List<BEPedidoWebDetalle> listaPedido, string codigoISO, int campaniaID, int tipo, bool esConsultoraLider, string simbolo)
        {
            var listaRetorno = new List<EstrategiaPersonalizadaProductoModel>();
            if (!listaProductoModel.Any())
                return listaRetorno;
            
            var carpetaPais = Globals.UrlMatriz + "/" + codigoISO;

            var claseBloqueada = "btn_desactivado_general";
            listaProductoModel.ForEach(estrategia =>
            {
                var prodModel = new EstrategiaPersonalizadaProductoModel();
                prodModel.CampaniaID = estrategia.CampaniaID;
                prodModel.EstrategiaID = estrategia.EstrategiaID;
                prodModel.CUV2 = estrategia.CUV2;
                prodModel.TipoEstrategiaImagenMostrar = estrategia.TipoEstrategiaImagenMostrar;
                prodModel.CodigoEstrategia = estrategia.TipoEstrategia.Codigo;
                prodModel.CodigoVariante = estrategia.CodigoEstrategia;
                prodModel.ClaseEstrategia =
                    (estrategia.TipoEstrategia.Codigo == Constantes.TipoEstrategiaCodigo.PackAltoDesembolso
                    || estrategia.TipoEstrategia.Codigo == Constantes.TipoEstrategiaCodigo.Lanzamiento
                    || estrategia.TipoEstrategia.Codigo == Constantes.TipoEstrategiaCodigo.OfertasParaMi)
                    || (
                        (estrategia.TipoEstrategia.Codigo == Constantes.TipoEstrategiaCodigo.OfertaParaTi
                        || estrategia.TipoEstrategia.Codigo == Constantes.TipoEstrategiaCodigo.PackNuevas)
                        && (revistaDigital.TieneRDC || revistaDigital.TieneRDI))
                    || tipo == 1
                    || tipo == 2
                    ? "revistadigital-landing" : "";
                prodModel.FotoProducto01 = estrategia.FotoProducto01;
                prodModel.ImagenURL = estrategia.ImagenURL;
                prodModel.DescripcionMarca = estrategia.DescripcionMarca;
                prodModel.DescripcionResumen = estrategia.DescripcionResumen;
                prodModel.DescripcionCortada = estrategia.DescripcionCortada;
                prodModel.DescripcionDetalle = estrategia.DescripcionDetalle;
                prodModel.DescripcionCompleta = estrategia.DescripcionCUV2.Split('|')[0];
                prodModel.Precio = estrategia.Precio;
                prodModel.Precio2 = estrategia.Precio2;
                prodModel.PrecioTachado = estrategia.PrecioTachado;
                prodModel.PrecioVenta = estrategia.PrecioString;
                prodModel.ClaseBloqueada = tipo == 1 || (estrategia.CampaniaID > 0 && estrategia.CampaniaID != campaniaID) ? claseBloqueada : "";
                prodModel.TipoEstrategiaID = estrategia.TipoEstrategiaID;
                prodModel.FlagNueva = estrategia.FlagNueva;
                prodModel.IsAgregado = prodModel.ClaseBloqueada != claseBloqueada && listaPedido.Any(p => p.EstrategiaId == estrategia.EstrategiaID);
                prodModel.ArrayContenidoSet = estrategia.FlagNueva == 1 ? estrategia.DescripcionCUV2.Split('|').Skip(1).ToList() : new List<string>();
                prodModel.ListaDescripcionDetalle = estrategia.ListaDescripcionDetalle ?? new List<string>();
                prodModel.TextoLibre = Util.Trim(estrategia.TextoLibre);

                prodModel.MarcaID = estrategia.MarcaID;

                prodModel.TienePaginaProducto = estrategia.PuedeVerDetalle;
                prodModel.TienePaginaProductoMob = estrategia.PuedeVerDetalleMob;
                prodModel.Ganancia = estrategia.Ganancia;
                prodModel.GananciaString = estrategia.GananciaString;

                prodModel.TipoAccionAgregar = TipoAccionAgregar(
                    estrategia.TieneVariedad,
                    estrategia.TipoEstrategia.Codigo,
                    esConsultoraLider,
                    tipo == 1 || (estrategia.CampaniaID > 0 && estrategia.CampaniaID != campaniaID),
                    estrategia.CodigoEstrategia
                );

                if (estrategia.TipoEstrategia.Codigo == Constantes.TipoEstrategiaCodigo.Lanzamiento)
                {
                    prodModel.TipoEstrategiaDetalle.ImgFondoDesktop = ConfigCdn.GetUrlFileCdn(carpetaPais, estrategia.EstrategiaDetalle.ImgFondoDesktop);
                    prodModel.TipoEstrategiaDetalle.ImgFichaDesktop = ConfigCdn.GetUrlFileCdn(carpetaPais, estrategia.EstrategiaDetalle.ImgFichaDesktop);
                    prodModel.TipoEstrategiaDetalle.ImgFichaFondoDesktop = ConfigCdn.GetUrlFileCdn(carpetaPais, estrategia.EstrategiaDetalle.ImgFichaFondoDesktop);
                    prodModel.TipoEstrategiaDetalle.UrlVideoDesktop = Util.Trim(estrategia.EstrategiaDetalle.UrlVideoDesktop);
                    prodModel.TipoEstrategiaDetalle.ImgFondoMobile = ConfigCdn.GetUrlFileCdn(carpetaPais, estrategia.EstrategiaDetalle.ImgFondoMobile);
                    prodModel.TipoEstrategiaDetalle.ImgFichaMobile = ConfigCdn.GetUrlFileCdn(carpetaPais, estrategia.EstrategiaDetalle.ImgFichaMobile);
                    prodModel.TipoEstrategiaDetalle.ImgFichaFondoMobile = ConfigCdn.GetUrlFileCdn(carpetaPais, estrategia.EstrategiaDetalle.ImgFichaFondoMobile);
                    prodModel.TipoEstrategiaDetalle.UrlVideoMobile = Util.Trim(estrategia.EstrategiaDetalle.UrlVideoMobile);
                    prodModel.TipoEstrategiaDetalle.ImgHomeDesktop = ConfigCdn.GetUrlFileCdn(carpetaPais, estrategia.EstrategiaDetalle.ImgHomeDesktop);
                    prodModel.TipoEstrategiaDetalle.ImgHomeMobile = ConfigCdn.GetUrlFileCdn(carpetaPais, estrategia.EstrategiaDetalle.ImgHomeMobile);
                    prodModel.TipoEstrategiaDetalle.Slogan = estrategia.EstrategiaDetalle.Slogan.IsNullOrEmptyTrim() ? "" : estrategia.EstrategiaDetalle.Slogan.First().ToString().ToUpper() + estrategia.EstrategiaDetalle.Slogan.Substring(1).ToLower();
                    prodModel.TipoEstrategiaDetalle.FlagIndividual = estrategia.EstrategiaDetalle.FlagIndividual;
                    prodModel.CodigoProducto = estrategia.CodigoProducto;

                    prodModel.ImagenURL = prodModel.TipoEstrategiaDetalle.ImgFichaDesktop;
                }
                else if (estrategia.TipoEstrategia.Codigo == Constantes.TipoEstrategiaCodigo.PackNuevas)
                {
                    prodModel.EsOfertaIndependiente = estrategia.EsOfertaIndependiente;
                    if (estrategia.EsOfertaIndependiente && estrategia.MostrarImgOfertaIndependiente)
                    {
                        prodModel.ImagenURL = ConfigCdn.GetUrlFileCdn(carpetaPais, estrategia.ImagenURL);
                    }
                }
                else if (estrategia.TipoEstrategia.Codigo == Constantes.TipoEstrategiaCodigo.HerramientasVenta)
                {
                    prodModel.Precio = 0;
                    prodModel.Ganancia = 0;
                    estrategia.Niveles = Util.Trim(estrategia.Niveles);
                    if (estrategia.Precio2 > 0 && estrategia.Niveles != "")
                    {
                        try
                        {
                            var niveles = estrategia.Niveles.Split('|');
                            if (niveles.Length > 0)
                            {
                                var nivelesConFormato = new List<string>();
                                niveles.Each(n =>
                                {
                                    var tmp = n.Split('-');
                                    if (tmp.Length == 2)
                                    {
                                        tmp[0] = Util.Trim(tmp[0]).ToLower();
                                        var precio = decimal.Parse(tmp[1]);
                                        tmp[1] = Util.DecimalToStringFormat(precio, codigoISO, simbolo);
                                    }
                                    nivelesConFormato.Add(string.Join(" ", tmp));
                                });

                                estrategia.Niveles = string.Join("|", nivelesConFormato);
                            }
                        }
                        catch
                        {
                            estrategia.Niveles = "";
                        }
                    }

                    prodModel.ListaPrecioNiveles = new List<string>();
                    if (estrategia.Niveles != "")
                    {
                        prodModel.ListaPrecioNiveles = estrategia.Niveles.Split('|').ToList();
                    }

                }

                if (estrategia.Hermanos != null)
                {
                    prodModel.Hermanos = new List<EstrategiaComponenteModel>();
                    if (estrategia.Hermanos.Any())
                    {
                        prodModel.Hermanos.AddRange(estrategia.Hermanos);
                    }
                }

                listaRetorno.Add(prodModel);
            });

            return listaRetorno;
        }

        public List<ServiceOferta.BEEstrategia> ConsultarEstrategiasFiltrarPackNuevasPedido(List<ServiceOferta.BEEstrategia> listEstrategia)
        {
            var pedidoWebDetalle = _pedidoWeb.ObtenerPedidoWebDetalle(0);
            listEstrategia = listEstrategia.Where(e => !pedidoWebDetalle.Any(d => d.CUV == e.CUV2)).ToList();

            return listEstrategia;
        }

        #endregion

        #region DetalleFicha
        public EstrategiaPersonalizadaProductoModel ObtenerEstrategiaPersonalizadaSession(UsuarioModel usuarioModel, string palanca, string cuv, int campaniaId, string codigoConsultora, bool esDiasFacturacion)
        {
            switch (palanca)
            {
                case Constantes.NombrePalanca.ShowRoom:
                    return ObtenerListaProductoShowRoom(usuarioModel, campaniaId, codigoConsultora, esDiasFacturacion, 1)
                        .FirstOrDefault(x => x.CUV2 == cuv);
                case Constantes.NombrePalanca.OfertaDelDia:
                    var listaProductoODD = RevisarCamposParaMostrar(ObtenerListaProductoODD(), true);
                    return listaProductoODD.FirstOrDefault(x => x.CUV2 == cuv);
                case Constantes.NombrePalanca.PackNuevas:
                    var varSession = Constantes.ConstSession.ListaEstrategia + Constantes.TipoEstrategiaCodigo.PackNuevas;
                    var listaEstrategia = SessionManager.GetBEEstrategia(varSession);
                    if (listaEstrategia.Any())
                    {
                        var userData = SessionManager.GetUserData();
                        var listaOfertasModel = ConsultarEstrategiasModelFormato(listaEstrategia, userData.CodigoISO, userData.CampaniaID, 2, userData.esConsultoraLider, userData.Simbolo);
                        return listaOfertasModel.FirstOrDefault(x => x.CUV2 == cuv);
                    }
                    return null;
                default:
                    return null;
            }
        }


        public List<EstrategiaPersonalizadaProductoModel> ObtenerListaProductoODD()
        {
            if (SessionManager.OfertaDelDia.Estrategia != null)
            {
                if (SessionManager.OfertaDelDia.Estrategia.ListaOferta != null)
                {
                    var ListaOfertaSession = SessionManager.OfertaDelDia.Estrategia.ListaOferta;
                    return ListaOfertaSession;
                }
                else
                    return new List<EstrategiaPersonalizadaProductoModel>();
            }
            else
                return new List<EstrategiaPersonalizadaProductoModel>();
        }

        public List<EstrategiaPersonalizadaProductoModel> ObtenerListaProductoShowRoom(UsuarioModel userData, int campaniaId, string codigoConsultora, bool esFacturacion = false, int tipoOferta = 1)
        {
            var listaProductoRetorno = new List<EstrategiaPersonalizadaProductoModel>();
            var cargo = SessionManager.ShowRoom.CargoOfertas ?? "0";

            if (cargo == "1")
            {
                switch (tipoOferta)
                {
                    case 1:
                        listaProductoRetorno = SessionManager.ShowRoom.Ofertas ?? new List<EstrategiaPersonalizadaProductoModel>();
                        break;
                    case 2:
                        listaProductoRetorno = SessionManager.ShowRoom.OfertasSubCampania ?? new List<EstrategiaPersonalizadaProductoModel>();
                        listaProductoRetorno.ForEach(producto => { producto.EsSubcampania = true; });
                        break;
                    case 3:
                        listaProductoRetorno = SessionManager.ShowRoom.OfertasPerdio ?? new List<EstrategiaPersonalizadaProductoModel>();
                        break;
                }

                if (tipoOferta != 3)
                {
                    var listaPedidoDetalle = _pedidoWeb.ObtenerPedidoWebSetDetalleAgrupado(0);
                    listaProductoRetorno.Update(x =>
                    {
                        x.IsAgregado = listaPedidoDetalle.Any(p => p.EstrategiaId == x.EstrategiaID);
                    });
                }

                return listaProductoRetorno;
            }

            var listaProducto = GetShowRoomOfertasConsultora(userData);
            var listaProductoModel = ConsultarEstrategiasFormatoEstrategiaToModel1(listaProducto, userData.CodigoISO, userData.CampaniaID);

            SetShowRoomOfertasInSession(listaProductoModel, userData);

            switch (tipoOferta)
            {
                case 1:
                    return SessionManager.ShowRoom.Ofertas;
                case 2:
                    return SessionManager.ShowRoom.OfertasSubCampania;
                case 3:
                    return SessionManager.ShowRoom.OfertasPerdio;
                default:
                    return SessionManager.ShowRoom.Ofertas;
            }
        }

        private void SetShowRoomOfertasInSession(List<EstrategiaPedidoModel> listaProductoModel, UsuarioModel userData)
        {
            List<EstrategiaPedidoModel> listaOfertas;
            List<EstrategiaPedidoModel> listaSubCampania;
            var listaOfertasPerdio = new List<EstrategiaPedidoModel>();
            
            if (revistaDigital.ActivoMdo && !revistaDigital.EsActiva)
            {
                listaOfertas = listaProductoModel.Where(x => !x.EsSubCampania && x.FlagRevista == Constantes.FlagRevista.Valor0).ToList();
                listaOfertasPerdio = listaProductoModel.Where(x => !x.EsSubCampania && x.FlagRevista != Constantes.FlagRevista.Valor0).ToList();
                listaSubCampania = listaProductoModel.Where(x => x.EsSubCampania && x.FlagRevista == Constantes.FlagRevista.Valor0).ToList();
            }
            else // if (revistaDigital.ActivoMdo && revistaDigital.EsActiva || !revistaDigital.ActivoMdo)
            {
                listaOfertas = listaProductoModel.Where(x => !x.EsSubCampania).ToList();
                listaSubCampania = listaProductoModel.Where(x => x.EsSubCampania).ToList();
            }
            
            listaSubCampania = obtenerListaHermanos(listaSubCampania);
            // para no mostrar boton ELIGE TU OPCION
            listaSubCampania.ForEach(item =>
            {
                if (item.CodigoEstrategia == Constantes.TipoEstrategiaSet.CompuestaVariable)
                    item.CodigoEstrategia = Constantes.TipoEstrategiaSet.CompuestaFija;
            });

            var listaPedido = _pedidoWeb.ObtenerPedidoWebDetalle(0);
            SessionManager.ShowRoom.CargoOfertas = "1";
            SessionManager.ShowRoom.Ofertas = FormatearModelo1ToPersonalizado(listaOfertas, listaPedido, userData.CodigoISO, userData.CampaniaID, 2, userData.esConsultoraLider, userData.Simbolo);
            SessionManager.ShowRoom.OfertasSubCampania = FormatearModelo1ToPersonalizado(listaSubCampania, listaPedido, userData.CodigoISO, userData.CampaniaID, 2, userData.esConsultoraLider, userData.Simbolo);
            SessionManager.ShowRoom.OfertasPerdio = FormatearModelo1ToPersonalizado(listaOfertasPerdio, listaPedido, userData.CodigoISO, userData.CampaniaID, 1, userData.esConsultoraLider, userData.Simbolo);
        }

        private List<EstrategiaPedidoModel> obtenerListaHermanos(List<EstrategiaPedidoModel> listaSubCampania)
        {
            var userData = SessionManager.GetUserData();

            if (listaSubCampania == null || !listaSubCampania.Any())
            {
                listaSubCampania = new List<EstrategiaPedidoModel>();
                return listaSubCampania;
            }
            
            var listaEstrategiaProductos = new List<ServicePedido.BEEstrategiaProducto>();
            var strJoinIds = string.Join(",", listaSubCampania.Select(x => x.EstrategiaID).ToList());
            using (var svc = new PedidoServiceClient())
            {
                listaEstrategiaProductos = svc.GetEstrategiaProductoList(userData.PaisID, strJoinIds).ToList();
            }

            listaEstrategiaProductos = listaEstrategiaProductos ?? new List<ServicePedido.BEEstrategiaProducto>();

            if (listaEstrategiaProductos.Any())
            {
                listaSubCampania.ForEach(item =>
                {
                    var lineasPorCaja = 3;

                    var componentesRelacinados = listaEstrategiaProductos.Where(x => x.EstrategiaID == item.EstrategiaID).ToList();

                    if (componentesRelacinados != null)
                    {
                        item.Hermanos = new List<EstrategiaComponenteModel>();
                        componentesRelacinados.ForEach(componente =>
                        {
                            if (lineasPorCaja > 0 && !string.IsNullOrEmpty(componente.NombreProducto))
                            {
                                var nombreFormateado = (componente.NombreProducto.Length <= 26) ? componente.NombreProducto : componente.NombreProducto.Substring(0,25) + "...";
                                item.Hermanos.Add(new EstrategiaComponenteModel()
                                {
                                    NombreComercial = string.Format("{0}", componente.NombreProducto),
                                    Descripcion = string.Format("{0}", nombreFormateado)
                                });
                            }
                            lineasPorCaja--;
                        });
                    }
                });
            }

            return listaSubCampania;
        }

        public bool EnviaronParametrosValidos(string palanca, int campaniaId, string cuv)
        {
            return !string.IsNullOrEmpty(palanca) &&
                   !string.IsNullOrEmpty(campaniaId.ToString()) &&
                   !EsCampaniaFalsa(campaniaId) &&
                   !string.IsNullOrEmpty(cuv);
        }

        //Por el momento solo SW y ODD se maneja de sesion
        public bool PalancasConSesion(string palanca)
        {
            return palanca.Equals(Constantes.NombrePalanca.ShowRoom) ||
                   palanca.Equals(Constantes.NombrePalanca.OfertaDelDia) ||
                   palanca.Equals(Constantes.NombrePalanca.PackNuevas);
        }

        //Falta revisar las casuiticas por palanca
        public bool TienePermisoPalanca(string palanca)
        {
            var listaConfigPais = SessionManager.GetConfiguracionesPaisModel();
            bool tienePalanca = false;
            if (listaConfigPais == null || listaConfigPais.Count == 0) return tienePalanca;
            switch (palanca)
            {
                case Constantes.NombrePalanca.RevistaDigital:
                case Constantes.NombrePalanca.PackNuevas:
                case Constantes.NombrePalanca.OfertasParaMi:
                    tienePalanca = listaConfigPais.Any(x => x.Codigo == Constantes.ConfiguracionPais.RevistaDigital); break;
                case Constantes.NombrePalanca.Lanzamiento:
                    tienePalanca = listaConfigPais.Any(x => x.Codigo == Constantes.ConfiguracionPais.Lanzamiento); break;
                case Constantes.NombrePalanca.GuiaDeNegocioDigitalizada: //TODO: Validar habilitacion para GND
                    tienePalanca = listaConfigPais.Any(x => x.Codigo == Constantes.ConfiguracionPais.GuiaDeNegocioDigitalizada); break;
                case Constantes.NombrePalanca.HerramientasVenta:
                    {
                        tienePalanca = listaConfigPais.Any(x => x.Codigo == Constantes.ConfiguracionPais.HerramientasVenta); break;
                    }
                case Constantes.NombrePalanca.ShowRoom:
                    tienePalanca = listaConfigPais.Any(x => x.Codigo == Constantes.ConfiguracionPais.ShowRoom); break;
                case Constantes.NombrePalanca.OfertaDelDia:
                    tienePalanca = listaConfigPais.Any(x => x.Codigo == Constantes.ConfiguracionPais.OfertaDelDia); break;
                case Constantes.NombrePalanca.OfertaParaTi:
                    tienePalanca = listaConfigPais.Any(x => x.Codigo == Constantes.ConfiguracionPais.OfertasParaTi); break;
                default:
                    tienePalanca = false; break;
            }
                

            return tienePalanca;
        }
        #endregion

        public List<EstrategiaPersonalizadaProductoModel> RevisarCamposParaMostrar(List<EstrategiaPersonalizadaProductoModel> revisarLista, bool ficha = false)
        {
            if (revisarLista != null)
            {
                if (!revisarLista.Any()) return new List<EstrategiaPersonalizadaProductoModel>();
                var listaPedido = _pedidoWeb.ObtenerPedidoWebSetDetalleAgrupado(0);
                revisarLista.Update(x =>
                {
                    x.IsAgregado = listaPedido.Any(p => p.EstrategiaId == x.EstrategiaID);
                    if (ficha)
                    {
                        x.ImagenURL = "";// no mostrar en el carrusel de la ficha
                    }
                });
            }
            else
                revisarLista = new List<EstrategiaPersonalizadaProductoModel>();

            return revisarLista;
        }
    }

}