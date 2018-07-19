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

namespace Portal.Consultoras.Web.Providers
{
    public class OfertaPersonalizadaProvider
    {
        protected ISessionManager sessionManager;
        protected RevistaDigitalModel revistaDigital;
        protected ConfiguracionManagerProvider _configuracionManager;
        protected readonly PedidoWebProvider _pedidoWeb;
        protected readonly EstrategiaComponenteProvider _estrategiaComponenteProvider;

        public OfertaPersonalizadaProvider()
        {
            sessionManager = SessionManager.SessionManager.Instance;
            revistaDigital = sessionManager.GetRevistaDigital();
            _configuracionManager = new ConfiguracionManagerProvider();
            _pedidoWeb = new PedidoWebProvider();
        }

        #region Metodos de Estrategia Controller

        public string ConsultarOfertasTipoPalanca(BusquedaProductoModel model, int tipo)
        {

            var palanca = string.Empty;

            if (tipo == Constantes.TipoConsultaOfertaPersonalizadas.RDObtenerProductos)
            {
                var revistaDigital = sessionManager.GetRevistaDigital();
                var userData = sessionManager.GetUserData();
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
            else if (tipo == Constantes.TipoConsultaOfertaPersonalizadas.RDObtenerProductosLan)
            {
                palanca = Constantes.TipoEstrategiaCodigo.Lanzamiento;
            }
            else if (tipo == Constantes.TipoConsultaOfertaPersonalizadas.OPTObtenerProductos)
            {
                palanca = Constantes.TipoEstrategiaCodigo.OfertaParaTi;
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
            else if (tipo == Constantes.TipoConsultaOfertaPersonalizadas.RDObtenerProductosLan)
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
            var revistaDigital = sessionManager.GetRevistaDigital();
            var userData = sessionManager.GetUserData();

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
                    .OrderByDescending(x => x.MarcaID == Constantes.Marca.Esika)
                    .ThenByDescending(x => x.MarcaID == Constantes.Marca.LBel)
                    .ThenByDescending(x => x.MarcaID == Constantes.Marca.Cyzone)
                    .ToList();

                listModel1 = listaFinal1;
            }
            else if (tipo == Constantes.TipoConsultaOfertaPersonalizadas.RDObtenerProductosLan)
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
            else if (tipo == Constantes.TipoConsultaOfertaPersonalizadas.RDObtenerProductosLan)
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
            var revistaDigital = sessionManager.GetRevistaDigital();
            var userData = sessionManager.GetUserData();

            if (revistaDigital.TieneRDC && !revistaDigital.EsActiva &&
                campaniaId == userData.CampaniaID)
                return true;

            return false;
        }

        public bool ConsultarOfertasValidarPermiso(BusquedaProductoModel model, int tipo)
        {
            var revistaDigital = sessionManager.GetRevistaDigital();
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
                var userData = sessionManager.GetUserData();
                var guiaNegocio = sessionManager.GetGuiaNegocio();

                if (!_guiaNegocioProvider.GNDValidarAcceso(userData.esConsultoraLider, guiaNegocio, revistaDigital))
                {
                    return false;
                }
            }
            else if (tipo == Constantes.TipoConsultaOfertaPersonalizadas.HVObtenerProductos)
            {
                return true;
            }
            else if (tipo == Constantes.TipoConsultaOfertaPersonalizadas.RDObtenerProductosLan)
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
                var userData = sessionManager.GetUserData();
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

        public List<ServiceOferta.BEEstrategia> ConsultarEstrategias(bool esMobile, int campaniaId = 0, string codAgrupacion = "")
        {
            codAgrupacion = Util.Trim(codAgrupacion);
            var listEstrategia = new List<ServiceOferta.BEEstrategia>();

            switch (codAgrupacion)
            {
                case Constantes.TipoEstrategiaCodigo.RevistaDigital:
                    listEstrategia.AddRange(ConsultarEstrategiasPorTipo(esMobile, Constantes.TipoEstrategiaCodigo.PackNuevas, campaniaId));
                    listEstrategia.AddRange(ConsultarEstrategiasPorTipo(esMobile, Constantes.TipoEstrategiaCodigo.OfertaWeb, campaniaId));
                    listEstrategia.AddRange(ConsultarEstrategiasPorTipo(esMobile, Constantes.TipoEstrategiaCodigo.RevistaDigital, campaniaId));
                    break;
                case Constantes.TipoEstrategiaCodigo.Lanzamiento:
                    listEstrategia.AddRange(ConsultarEstrategiasPorTipo(esMobile, Constantes.TipoEstrategiaCodigo.Lanzamiento, campaniaId));
                    break;
                case Constantes.TipoEstrategiaCodigo.GuiaDeNegocioDigitalizada:
                    // cache de amazaon en la capa BL
                    listEstrategia.AddRange(ConsultarEstrategiasPorTipo(esMobile, Constantes.TipoEstrategiaCodigo.GuiaDeNegocioDigitalizada, campaniaId));
                    break;
                case Constantes.TipoEstrategiaCodigo.HerramientasVenta:
                    listEstrategia.AddRange(ConsultarEstrategiasPorTipo(esMobile, Constantes.TipoEstrategiaCodigo.HerramientasVenta, campaniaId));
                    break;
                case Constantes.TipoEstrategiaCodigo.LosMasVendidos:
                    listEstrategia.AddRange(ConsultarEstrategiasPorTipo(esMobile, Constantes.TipoEstrategiaCodigo.LosMasVendidos, campaniaId));
                    break;
                case Constantes.TipoEstrategiaCodigo.OfertaParaTi:
                    listEstrategia.AddRange(ConsultarEstrategiasPorTipo(esMobile, Constantes.TipoEstrategiaCodigo.PackNuevas, campaniaId));
                    listEstrategia.AddRange(ConsultarEstrategiasPorTipo(esMobile, Constantes.TipoEstrategiaCodigo.OfertaWeb, campaniaId));
                    listEstrategia.AddRange(ConsultarEstrategiasPorTipo(esMobile, Constantes.TipoEstrategiaCodigo.OfertaParaTi, campaniaId));
                    break;
            }

            return listEstrategia;
        }

        protected virtual List<ServiceOferta.BEEstrategia> ConsultarEstrategiasPorTipo(bool esMobile, string tipo, int campaniaId = 0)
        {
            var userData = sessionManager.GetUserData();
            var listEstrategia = new List<ServiceOferta.BEEstrategia>();
            try
            {
                campaniaId = campaniaId > 0 ? campaniaId : userData.CampaniaID;
                tipo = Util.Trim(tipo);
                string varSession = Constantes.ConstSession.ListaEstrategia + tipo;

                listEstrategia = sessionManager.GetBEEstrategia(varSession);

                if (listEstrategia != null && campaniaId == userData.CampaniaID && listEstrategia.Any())
                {
                    //listEstrategia = (List<ServiceOferta.BEEstrategia>)Session[varSession];
                   
                    if (tipo == Constantes.TipoEstrategiaCodigo.PackNuevas)
                    {
                        listEstrategia = ConsultarEstrategiasFiltrarPackNuevasPedido(listEstrategia);
                    }

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
                    CodigoTipoEstrategia = tipo
                };

                if (tipo == Constantes.TipoEstrategiaCodigo.LosMasVendidos)
                {
                    entidad.ConsultoraID = userData.GetConsultoraId().ToString();
                }

                using (OfertaServiceClient osc = new OfertaServiceClient())
                {
                    listEstrategia = osc.GetEstrategiasPedido(entidad).ToList();
                }
                //aqui va RD Implemenacion + tono
                if (campaniaId == userData.CampaniaID)
                {
                    if (tipo == Constantes.TipoEstrategiaCodigo.PackNuevas
                        || tipo == Constantes.TipoEstrategiaCodigo.OfertaParaTi
                        || tipo == Constantes.TipoEstrategiaCodigo.OfertaWeb)
                    {
                        sessionManager.SetBEEstrategia(varSession, listEstrategia);
                        //Session[varSession] = listEstrategia;
                    }
                    if (tipo == Constantes.TipoEstrategiaCodigo.PackNuevas && listEstrategia.Any())
                    {
                        listEstrategia = ConsultarEstrategiasFiltrarPackNuevasPedido(listEstrategia);
                    }
                }

                if (!listEstrategia.Any() && sessionManager.GetFlagLogCargaOfertas() &&
                    tipo != Constantes.TipoEstrategiaCodigo.OfertaWeb &&
                    tipo != Constantes.TipoEstrategiaCodigo.PackNuevas)
                    EnviarLogOferta(campaniaId, tipo, esMobile);

            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
            return listEstrategia;
        }

        #endregion

        #region Metodos consumo Ofertas por tipo

        public List<EstrategiaPedidoModel> ConsultarEstrategiasHomePedido(bool esMobile, string codigoIso, int campaniaId, string codAgrupacion = "")
        {
            List<ServiceOferta.BEEstrategia> listModel;
            if (sessionManager.GetBEEstrategia(Constantes.ConstSession.ListaEstrategia) != null)
                listModel = sessionManager.GetBEEstrategia(Constantes.ConstSession.ListaEstrategia);
            else
            {
                listModel = ConsultarEstrategias(esMobile, 0, codAgrupacion);

                if (!listModel.Any())
                {
                    sessionManager.SetBEEstrategia(Constantes.ConstSession.ListaEstrategia, listModel);
                    //Session[Constantes.ConstSession.ListaEstrategia] = listModel;
                    return new List<EstrategiaPedidoModel>();
                }

                #region Validar Tipo RD 

                if (codAgrupacion == Constantes.TipoEstrategiaCodigo.RevistaDigital)
                {
                    var listModelLan = ConsultarEstrategias(esMobile, 0, Constantes.TipoEstrategiaCodigo.Lanzamiento);
                    var estrategiaLanzamiento = listModelLan.FirstOrDefault() ?? new ServiceOferta.BEEstrategia();

                    if (!listModel.Any() && estrategiaLanzamiento.EstrategiaID <= 0)
                    {
                        sessionManager.SetBEEstrategia(Constantes.ConstSession.ListaEstrategia, listModel);
                        //Session[Constantes.ConstSession.ListaEstrategia] = listModel;
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

                sessionManager.SetBEEstrategia(Constantes.ConstSession.ListaEstrategia, listModel);
                //Session[Constantes.ConstSession.ListaEstrategia] = listModel;
            }

            var listaProductoModel = ConsultarEstrategiasFormatoEstrategiaToModel1(listModel, codigoIso, campaniaId);
            return listaProductoModel;
        }

        public List<EstrategiaPedidoModel> ConsultarEstrategiasModel(bool esMobile, string codigoIso, int campaniaIdConsultora, int campaniaId = 0, string codAgrupacion = "")
        {
            var listaProducto = ConsultarEstrategias(esMobile, campaniaId, codAgrupacion);

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
            var userData = sessionManager.GetUserData();
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
            var userData = sessionManager.GetUserData();

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

        public EstrategiaPersonalizadaProductoModel ObtenerEstrategiaPersonalizada(UsuarioModel usuarioModel, string palanca, string cuv, int campaniaId)
        {
            try
            {
                var estrategiaPersonalizada = ObtenerEstrategiaPersonalizadaSession(usuarioModel, palanca, cuv, campaniaId, usuarioModel.CodigoConsultora, usuarioModel.EsDiasFacturacion);
                if (estrategiaPersonalizada == null || !estrategiaPersonalizada.CUV2.Equals(cuv))
                    return null;
                estrategiaPersonalizada.Hermanos = new List<EstrategiaComponenteModel>();
                estrategiaPersonalizada.TextoLibre = Util.Trim(estrategiaPersonalizada.TextoLibre);
                estrategiaPersonalizada.CodigoVariante = Util.Trim(estrategiaPersonalizada.CodigoVariante);

                //var listaPedido = ObtenerPedidoWebDetalle();
                //estrategiaPersonalizada.IsAgregado = listaPedido.Any(p => p.CUV == estrategiaPersonalizada.CUV2);

                //if (string.IsNullOrWhiteSpace(estrategiaPersonalizada.CodigoVariante))
                //    return estrategiaPersonalizada;

                //estrategiaPersonalizada.CampaniaID = estrategiaPersonalizada.CampaniaID > 0 ? estrategiaPersonalizada.CampaniaID : userData.CampaniaID;
                //bool esMultimarca = false;
                //estrategiaPersonalizada.Hermanos = _estrategiaComponenteProvider.GetListaComponentes(estrategiaPersonalizada, string.Empty, out esMultimarca);
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
                //Zona = usuarioModel.ZonaID.ToString(),
                ZonaHoraria = usuarioModel.ZonaHoraria,
                FechaInicioFacturacion = usuarioModel.FechaInicioCampania,
                ValidarPeriodoFacturacion = true,
                Simbolo = usuarioModel.Simbolo,
                CodigoTipoEstrategia = "030"
            };

            using (var osc = new OfertaServiceClient())
            {
                //var listaShowRoomOferta = ofertaService.GetShowRoomOfertasConsultora(usuarioModel.PaisID, usuarioModel.CampaniaID, 
                //    usuarioModel.CodigoConsultora).ToList();
                //return Mapper.Map<List<ServiceOferta.BEShowRoomOferta>, List<EstrategiaPedidoModel>>(listaShowRoomOferta);

                var listaProducto = osc.GetEstrategiasPedido(entidad).ToList();
                //var listaProductoModel = Mapper.Map<List<ServiceOferta.BEEstrategia>, List<EstrategiaPedidoModel>>(listaProducto);
                //listaProductoModel = ConsultarEstrategiasModelFormato(listaProductoModel);
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
                tipo = codigoTipos == Constantes.TipoEstrategiaSet.IndividualConTonos || codigoTipos == Constantes.TipoEstrategiaSet.CompuestaFija ? 2 : 3;
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
            var listaPedido = _pedidoWeb.ObtenerPedidoWebDetalle(0);
            var listaEstrategiaPedidoModel = ConsultarEstrategiasFormatoModelo1(listaProductoModel, listaPedido, codigoISO, campaniaID);
            return listaEstrategiaPedidoModel;
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
                estrategia.IsAgregado = estrategia.ClaseBloqueada != claseBloqueada && listaPedido.Any(p => p.CUV == estrategia.CUV2.Trim());
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

            //var listaPedido = ObtenerPedidoWebDetalle();
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
                prodModel.IsAgregado = prodModel.ClaseBloqueada != claseBloqueada && listaPedido.Any(p => p.CUV == estrategia.CUV2.Trim());
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
                    if (estrategia.Niveles != "" )
                    {
                        prodModel.ListaPrecioNiveles = estrategia.Niveles.Split('|').ToList();
                    }
                    
                }

                if (estrategia.Hermanos!=null)
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
                    return sessionManager.OfertaDelDia.Estrategia.ListaOferta
                        .FirstOrDefault(x => x.CUV2 == cuv);
                case Constantes.NombrePalanca.PackNuevas:
                    var varSession = Constantes.ConstSession.ListaEstrategia + Constantes.TipoEstrategiaCodigo.PackNuevas;
                    var listaEstrategia = sessionManager.GetBEEstrategia(varSession);
                    if (listaEstrategia.Any())
                    {
                        var userData = sessionManager.GetUserData();
                        var listaOfertasModel = ConsultarEstrategiasModelFormato(listaEstrategia, userData.CodigoISO, userData.CampaniaID, 2, userData.esConsultoraLider, userData.Simbolo);
                        return listaOfertasModel.FirstOrDefault(x => x.CUV2 == cuv);
                    }
                    return null;
                default:
                    return null;
            }
        }

        public List<EstrategiaPersonalizadaProductoModel> ObtenerListaProductoShowRoom(UsuarioModel userData, int campaniaId, string codigoConsultora, bool esFacturacion = false, int tipoOferta = 1)
        {
            var listaProductoRetorno = new List<EstrategiaPersonalizadaProductoModel>();
            var cargo = sessionManager.ShowRoom.CargoOfertas ?? "0";

            if (cargo == "1")
            {
                switch (tipoOferta)
                {
                    case 1:
                        listaProductoRetorno = sessionManager.ShowRoom.Ofertas ?? new List<EstrategiaPersonalizadaProductoModel>();
                        break;
                    case 2:
                        listaProductoRetorno = sessionManager.ShowRoom.OfertasSubCampania ?? new List<EstrategiaPersonalizadaProductoModel>();
                        listaProductoRetorno.ForEach(producto => { producto.esSubcampania = true; });
                        break;
                    case 3:
                        listaProductoRetorno = sessionManager.ShowRoom.OfertasPerdio ?? new List<EstrategiaPersonalizadaProductoModel>();
                        break;
                }

                if (tipoOferta != 3)
                {
                    var listaPedidoDetalle = _pedidoWeb.ObtenerPedidoWebDetalle(0);
                    listaProductoRetorno.Update(x =>
                    {
                        x.IsAgregado = listaPedidoDetalle.Any(p => p.CUV == x.CUV2);
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
                    return sessionManager.ShowRoom.Ofertas;
                case 2:
                    return sessionManager.ShowRoom.OfertasSubCampania;
                case 3:
                    return sessionManager.ShowRoom.OfertasPerdio;
                default:
                    return sessionManager.ShowRoom.Ofertas;
            }
        }

        private void SetShowRoomOfertasInSession(List<EstrategiaPedidoModel> listaProductoModel, UsuarioModel userData)
        {
            var flagRevistaTodos = new List<int>() { Constantes.FlagRevista.Valor0, Constantes.FlagRevista.Valor1, Constantes.FlagRevista.Valor2 };
            List<EstrategiaPedidoModel> listaOfertas;
            List<EstrategiaPedidoModel> listaSubCampania;
            var listaOfertasPerdio = new List<EstrategiaPedidoModel>();

            if (revistaDigital.TieneRDC && revistaDigital.ActivoMdo && !revistaDigital.EsActiva)
            {
                listaOfertas = listaProductoModel.Where(x => !x.EsSubCampania && x.FlagRevista == Constantes.FlagRevista.Valor0).ToList();
                listaOfertasPerdio = listaProductoModel.Where(x => !x.EsSubCampania && x.FlagRevista != Constantes.FlagRevista.Valor0).ToList();
            }
            else if (revistaDigital.TieneRDC && revistaDigital.ActivoMdo && revistaDigital.EsActiva)
                listaOfertas = listaProductoModel.Where(x => !x.EsSubCampania && flagRevistaTodos.Contains(x.FlagRevista)).ToList();
            else if (!revistaDigital.ActivoMdo)
                listaOfertas = listaProductoModel.Where(x => !x.EsSubCampania).ToList();
            else
                listaOfertas = listaProductoModel.Where(x => !x.EsSubCampania && x.FlagRevista == Constantes.FlagRevista.Valor0).ToList();
            
            //subcampania
            if (revistaDigital.EsActiva && revistaDigital.ActivoMdo)
                listaSubCampania = listaProductoModel.Where(x => x.EsSubCampania && flagRevistaTodos.Contains(x.FlagRevista)).ToList();
            else if (!revistaDigital.ActivoMdo)
                listaSubCampania = listaProductoModel.Where(x => x.EsSubCampania).ToList();
            else
                listaSubCampania = listaProductoModel.Where(x => x.EsSubCampania && x.FlagRevista == Constantes.FlagRevista.Valor0).ToList();

            listaSubCampania = obtenerListaHermanos(listaSubCampania);

            var listaPedido = _pedidoWeb.ObtenerPedidoWebDetalle(0);
            //configEstrategiaSR.ListaCategoria = new List<ShowRoomCategoriaModel>();
            sessionManager.ShowRoom.CargoOfertas = "1";
            sessionManager.ShowRoom.Ofertas = FormatearModelo1ToPersonalizado(listaOfertas, listaPedido, userData.CodigoISO, userData.CampaniaID, 2, userData.esConsultoraLider, userData.Simbolo);
            sessionManager.ShowRoom.OfertasSubCampania = FormatearModelo1ToPersonalizado(listaSubCampania, listaPedido, userData.CodigoISO, userData.CampaniaID, 2, userData.esConsultoraLider, userData.Simbolo);
            sessionManager.ShowRoom.OfertasPerdio = FormatearModelo1ToPersonalizado(listaOfertasPerdio, listaPedido, userData.CodigoISO, userData.CampaniaID, 1, userData.esConsultoraLider, userData.Simbolo);
        }

        private List<EstrategiaPedidoModel> obtenerListaHermanos(List<EstrategiaPedidoModel> listaSubCampania)
        {
            var userData = sessionManager.GetUserData();
            if (listaSubCampania != null)
            {
                if (listaSubCampania.Any())
                {
                    var listaEstrategiaProductos = new List<ServicePedido.BEEstrategiaProducto>();
                    var strJoinIds = string.Join(",", listaSubCampania.Select(x => x.EstrategiaID).ToList());
                    using (var svc = new PedidoServiceClient())
                    {
                        listaEstrategiaProductos = svc.GetEstrategiaProductoList(userData.PaisID, strJoinIds).ToList().ToList();
                        listaEstrategiaProductos = (listaEstrategiaProductos == null ? new List<ServicePedido.BEEstrategiaProducto>() : listaEstrategiaProductos);
                    }

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
                                    if (componente.CUV != item.CUV2 && lineasPorCaja > 0 && !string.IsNullOrEmpty(componente.NombreProducto))
                                    {
                                        item.Hermanos.Add(new EstrategiaComponenteModel()
                                        {
                                            NombreComercial = string.Format("{0}{1}", componente.NombreProducto, item.Hermanos.Count == 1 ? "..." : string.Empty)
                                        });
                                    }
                                    lineasPorCaja--;
                                });
                            }
                        });
                    }
                }
            }
            else
                listaSubCampania = new List<EstrategiaPedidoModel>();

                return listaSubCampania;
        }
        public bool EnviaronParametrosValidos(string palanca, int campaniaId, string cuv)
        {
            return !string.IsNullOrEmpty(palanca) &&
                   !string.IsNullOrEmpty(cuv) &&
                   !string.IsNullOrEmpty(campaniaId.ToString()) &&
                   !EsCampaniaFalsa(campaniaId);
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
            var listaConfigPais = sessionManager.GetConfiguracionesPaisModel();
            bool tienePalanca;
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
                        return revistaDigital.TieneRDC || revistaDigital.TieneRDCR;
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
                if (revisarLista.Any())
                {
                    var listaPedido = _pedidoWeb.ObtenerPedidoWebDetalle(0);
                    revisarLista.Update(x =>
                    {
                        x.IsAgregado = listaPedido.Any(p => p.CUV == x.CUV2);
                        if (ficha)
                        {
                            x.ImagenURL = "";// no mostrar en el carrusel de la ficha
                        }
                       
                    });
                }
            }
            else
                revisarLista = new List<EstrategiaPersonalizadaProductoModel>();

            return revisarLista;
        }
    }

}