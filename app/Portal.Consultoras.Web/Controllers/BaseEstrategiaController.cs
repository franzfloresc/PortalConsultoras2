//using AutoMapper;
//using Portal.Consultoras.Common;
//using Portal.Consultoras.Web.LogManager;
//using Portal.Consultoras.Web.Models;
//using Portal.Consultoras.Web.ServiceOferta;
//using Portal.Consultoras.Web.SessionManager;
//using System;
//using System.Collections.Generic;
//using System.Linq;

//namespace Portal.Consultoras.Web.Controllers
//{
//    public class BaseEstrategiaController : BaseController
//    {
//        public BaseEstrategiaController()
//            : base()
//        {
//            //
//        }

//        public BaseEstrategiaController(ISessionManager sessionManager)
//            : base(sessionManager)
//        {
//        }

//        public BaseEstrategiaController(ISessionManager sessionManager, ILogManager logManager)
//            : base(sessionManager, logManager)
//        {

//        }

//        public RevistaDigitalModel RevistaDigital
//        {
//            get
//            {
//                return revistaDigital;
//            }
//            set
//            {
//                revistaDigital = value;
//            }
//        }

//        //public List<ServiceOferta.BEEstrategia> ConsultarEstrategias(int campaniaId = 0, string codAgrupacion = "")
//        //{
//        //    codAgrupacion = Util.Trim(codAgrupacion);
//        //    var listEstrategia = new List<ServiceOferta.BEEstrategia>();

//        //    switch (codAgrupacion)
//        //    {
//        //        case Constantes.TipoEstrategiaCodigo.RevistaDigital:
//        //            listEstrategia.AddRange(ConsultarEstrategiasPorTipo(Constantes.TipoEstrategiaCodigo.PackNuevas, campaniaId));
//        //            listEstrategia.AddRange(ConsultarEstrategiasPorTipo(Constantes.TipoEstrategiaCodigo.OfertaWeb, campaniaId));
//        //            listEstrategia.AddRange(ConsultarEstrategiasPorTipo(Constantes.TipoEstrategiaCodigo.RevistaDigital, campaniaId));
//        //            break;
//        //        case Constantes.TipoEstrategiaCodigo.Lanzamiento:
//        //            listEstrategia.AddRange(ConsultarEstrategiasPorTipo(Constantes.TipoEstrategiaCodigo.Lanzamiento, campaniaId));
//        //            break;
//        //        case Constantes.TipoEstrategiaCodigo.GuiaDeNegocioDigitalizada:
//        //            // cache de amazaon en la capa BL
//        //            listEstrategia.AddRange(ConsultarEstrategiasPorTipo(Constantes.TipoEstrategiaCodigo.GuiaDeNegocioDigitalizada, campaniaId));
//        //            break;
//        //        case Constantes.TipoEstrategiaCodigo.HerramientasVenta:
//        //            listEstrategia.AddRange(ConsultarEstrategiasPorTipo(Constantes.TipoEstrategiaCodigo.HerramientasVenta, campaniaId));
//        //            break;
//        //        case Constantes.TipoEstrategiaCodigo.LosMasVendidos:
//        //            listEstrategia.AddRange(ConsultarEstrategiasPorTipo(Constantes.TipoEstrategiaCodigo.LosMasVendidos, campaniaId));
//        //            break;
//        //        case Constantes.TipoEstrategiaCodigo.OfertaParaTi:
//        //            listEstrategia.AddRange(ConsultarEstrategiasPorTipo(Constantes.TipoEstrategiaCodigo.PackNuevas, campaniaId));
//        //            listEstrategia.AddRange(ConsultarEstrategiasPorTipo(Constantes.TipoEstrategiaCodigo.OfertaWeb, campaniaId));
//        //            listEstrategia.AddRange(ConsultarEstrategiasPorTipo(Constantes.TipoEstrategiaCodigo.OfertaParaTi, campaniaId));
//        //            break;
//        //    }

//        //    return listEstrategia;
//        //}

//        //protected virtual List<ServiceOferta.BEEstrategia> ConsultarEstrategiasPorTipo(string tipo, int campaniaId = 0)
//        //{
//        //    var listEstrategia = new List<ServiceOferta.BEEstrategia>();
//        //    try
//        //    {
//        //        campaniaId = campaniaId > 0 ? campaniaId : userData.CampaniaID;
//        //        tipo = Util.Trim(tipo);
//        //        string varSession = Constantes.ConstSession.ListaEstrategia + tipo;

//        //        if (Session[varSession] != null && campaniaId == userData.CampaniaID)
//        //        {
//        //            listEstrategia = (List<ServiceOferta.BEEstrategia>)Session[varSession];
//        //            if (listEstrategia.Any())
//        //            {
//        //                if (tipo == Constantes.TipoEstrategiaCodigo.PackNuevas && listEstrategia.Any())
//        //                {
//        //                    listEstrategia = _ofertaPersonalizadaProvider.ConsultarEstrategiasFiltrarPackNuevasPedido(listEstrategia);
//        //                }

//        //                return listEstrategia;
//        //            }
//        //        }

//        //        var entidad = new ServiceOferta.BEEstrategia
//        //        {
//        //            PaisID = userData.PaisID,
//        //            CampaniaID = campaniaId,
//        //            ConsultoraID = userData.GetCodigoConsultora(),
//        //            Zona = userData.ZonaID.ToString(),
//        //            ZonaHoraria = userData.ZonaHoraria,
//        //            FechaInicioFacturacion = userData.FechaFinCampania,
//        //            ValidarPeriodoFacturacion = true,
//        //            Simbolo = userData.Simbolo,
//        //            CodigoTipoEstrategia = tipo
//        //        };

//        //        if (tipo == Constantes.TipoEstrategiaCodigo.LosMasVendidos)
//        //        {
//        //            entidad.ConsultoraID = userData.GetConsultoraId().ToString();
//        //        }

//        //        using (OfertaServiceClient osc = new OfertaServiceClient())
//        //        {
//        //            listEstrategia = osc.GetEstrategiasPedido(entidad).ToList();
//        //        }

//        //        if (campaniaId == userData.CampaniaID)
//        //        {
//        //            if (tipo == Constantes.TipoEstrategiaCodigo.PackNuevas
//        //                || tipo == Constantes.TipoEstrategiaCodigo.OfertaParaTi
//        //                || tipo == Constantes.TipoEstrategiaCodigo.OfertaWeb)
//        //            {
//        //                Session[varSession] = listEstrategia;
//        //            }
//        //            if (tipo == Constantes.TipoEstrategiaCodigo.PackNuevas && listEstrategia.Any())
//        //            {
//        //                listEstrategia = _ofertaPersonalizadaProvider.ConsultarEstrategiasFiltrarPackNuevasPedido(listEstrategia);
//        //            }
//        //        }

//        //        if (!listEstrategia.Any() && sessionManager.GetFlagLogCargaOfertas() &&
//        //            tipo != Constantes.TipoEstrategiaCodigo.OfertaWeb &&
//        //            tipo != Constantes.TipoEstrategiaCodigo.PackNuevas)
//        //            _ofertaPersonalizadaProvider.EnviarLogOferta(campaniaId, tipo, IsMobile());

//        //    }
//        //    catch (Exception ex)
//        //    {
//        //        LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
//        //    }
//        //    return listEstrategia;
//        //}

//        //[Obsolete("Metodo obsoleto no usar.")]
//        //public EstrategiaPersonalizadaProductoModel EstrategiaGetDetalle(int id, string cuv = "")
//        //{
//        //    EstrategiaPersonalizadaProductoModel estrategiaModelo;
//        //    try
//        //    {
//        //        estrategiaModelo = sessionManager.GetProductoTemporal();
//        //        if (estrategiaModelo == null || estrategiaModelo.EstrategiaID <= 0)
//        //            return estrategiaModelo;

//        //        estrategiaModelo.Hermanos = new List<EstrategiaComponenteModel>();
//        //        estrategiaModelo.TextoLibre = Util.Trim(estrategiaModelo.TextoLibre);
//        //        estrategiaModelo.CodigoVariante = Util.Trim(estrategiaModelo.CodigoVariante);

//        //        var listaPedido = ObtenerPedidoWebDetalle();
//        //        estrategiaModelo.IsAgregado = listaPedido.Any(p => p.CUV == estrategiaModelo.CUV2);

//        //        if (string.IsNullOrWhiteSpace(estrategiaModelo.CodigoVariante))
//        //            return estrategiaModelo;

//        //        bool esMultimarca = false;
//        //        estrategiaModelo.CampaniaID = estrategiaModelo.CampaniaID > 0 ? estrategiaModelo.CampaniaID : userData.CampaniaID;
//        //        estrategiaModelo.Hermanos = _estrategiaComponenteProvider.GetListaComponentes(estrategiaModelo, string.Empty, out esMultimarca);
//        //        estrategiaModelo.esMultimarca = esMultimarca;
//        //    }
//        //    catch (Exception ex)
//        //    {
//        //        estrategiaModelo = new EstrategiaPersonalizadaProductoModel();
//        //        LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
//        //    }
//        //    return estrategiaModelo;
//        //}

//        //public EstrategiaPersonalizadaProductoModel ObtenerEstrategiaPersonalizada(string palanca, string cuv, int campaniaId)
//        //{
//        //    try
//        //    {
//        //        var estrategiaPersonalizada = _ofertaPersonalizadaProvider.ObtenerEstrategiaPersonalizadaSession(userData ,palanca, cuv, campaniaId, userData.CodigoConsultora, userData.EsDiasFacturacion);
//        //        if (estrategiaPersonalizada == null || !estrategiaPersonalizada.CUV2.Equals(cuv))
//        //            return null;
//        //        estrategiaPersonalizada.Hermanos = new List<EstrategiaComponenteModel>();
//        //        estrategiaPersonalizada.TextoLibre = Util.Trim(estrategiaPersonalizada.TextoLibre);
//        //        estrategiaPersonalizada.CodigoVariante = Util.Trim(estrategiaPersonalizada.CodigoVariante);

//        //        //var listaPedido = ObtenerPedidoWebDetalle();
//        //        //estrategiaPersonalizada.IsAgregado = listaPedido.Any(p => p.CUV == estrategiaPersonalizada.CUV2);

//        //        //if (string.IsNullOrWhiteSpace(estrategiaPersonalizada.CodigoVariante))
//        //        //    return estrategiaPersonalizada;

//        //        //estrategiaPersonalizada.CampaniaID = estrategiaPersonalizada.CampaniaID > 0 ? estrategiaPersonalizada.CampaniaID : userData.CampaniaID;
//        //        //bool esMultimarca = false;
//        //        //estrategiaPersonalizada.Hermanos = _estrategiaComponenteProvider.GetListaComponentes(estrategiaPersonalizada, string.Empty, out esMultimarca);
//        //        return estrategiaPersonalizada;
//        //    }
//        //    catch (Exception ex)
//        //    {
//        //        LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
//        //        return null;
//        //    }
//        //}

//        //public List<EstrategiaPedidoModel> ConsultarEstrategiasHomePedido(string codAgrupacion = "")
//        //{
//        //    List<ServiceOferta.BEEstrategia> listModel;
//        //    if (Session[Constantes.ConstSession.ListaEstrategia] != null)
//        //        listModel = (List<ServiceOferta.BEEstrategia>)Session[Constantes.ConstSession.ListaEstrategia];
//        //    else
//        //    {
//        //        listModel = _ofertaPersonalizadaProvider.ConsultarEstrategias(IsMobile(), 0, codAgrupacion);

//        //        if (!listModel.Any())
//        //        {
//        //            Session[Constantes.ConstSession.ListaEstrategia] = listModel;
//        //            return new List<EstrategiaPedidoModel>();
//        //        }

//        //        #region Validar Tipo RD 

//        //        if (codAgrupacion == Constantes.TipoEstrategiaCodigo.RevistaDigital)
//        //        {
//        //            var listModelLan = _ofertaPersonalizadaProvider.ConsultarEstrategias(IsMobile(), 0, Constantes.TipoEstrategiaCodigo.Lanzamiento);
//        //            var estrategiaLanzamiento = listModelLan.FirstOrDefault() ?? new ServiceOferta.BEEstrategia();

//        //            if (!listModel.Any() && estrategiaLanzamiento.EstrategiaID <= 0)
//        //            {
//        //                Session[Constantes.ConstSession.ListaEstrategia] = listModel;
//        //                return new List<EstrategiaPedidoModel>();
//        //            }

//        //            var listaPackNueva = listModel.Where(e => e.TipoEstrategia.Codigo == Constantes.TipoEstrategiaCodigo.PackNuevas).ToList();

//        //            var listaRevista = listModel.Where(e => e.TipoEstrategia.Codigo == Constantes.TipoEstrategiaCodigo.OfertasParaMi).ToList();

//        //            if (revistaDigital.ActivoMdo && !revistaDigital.EsActiva)
//        //            {
//        //                listaRevista = listaRevista.Where(e => e.FlagRevista == Constantes.FlagRevista.Valor0).ToList();
//        //            }

//        //            var cantMax = 8;
//        //            var cantPack = listaPackNueva.Any() ? 1 : 0;
//        //            var top = Math.Min(cantMax - cantPack, listaRevista.Count);

//        //            if (listaRevista.Count > top)
//        //                listaRevista.RemoveRange(top, listaRevista.Count - top);

//        //            if (listaPackNueva.Count > 0 && listaPackNueva.Count > cantMax - top)
//        //                listaPackNueva.RemoveRange(cantMax - top, listaPackNueva.Count - (cantMax - top));

//        //            listModel = new List<ServiceOferta.BEEstrategia>();
//        //            if (estrategiaLanzamiento.EstrategiaID > 0)
//        //                listModel.Add(estrategiaLanzamiento);

//        //            listModel.AddRange(listaPackNueva);
//        //            listModel.AddRange(listaRevista);
//        //        }
//        //        #endregion

//        //        Session[Constantes.ConstSession.ListaEstrategia] = listModel;
//        //    }

//        //    var listaProductoModel = _ofertaPersonalizadaProvider.ConsultarEstrategiasFormatoEstrategiaToModel1(listModel, userData.CodigoISO, userData.CampaniaID);
//        //    return listaProductoModel;
//        //}

//        //public List<EstrategiaPedidoModel> ConsultarEstrategiasModel(int campaniaId = 0, string codAgrupacion = "")
//        //{
//        //    var listaProducto = _ofertaPersonalizadaProvider.ConsultarEstrategias(IsMobile(), campaniaId, codAgrupacion);

//        //    List<EstrategiaPedidoModel> listaProductoModel = _ofertaPersonalizadaProvider.ConsultarEstrategiasFormatoEstrategiaToModel1(listaProducto, userData.CodigoISO, userData.CampaniaID);

//        //    return listaProductoModel;
//        //}
        
//        //public List<EstrategiaPedidoModel> ConsultarMasVendidosModel()
//        //{
//        //    var listaProducto = _ofertaPersonalizadaProvider.ConsultarEstrategias(IsMobile(), 0, Constantes.TipoEstrategiaCodigo.LosMasVendidos);
//        //    var listaProductoModel = Mapper.Map<List<ServiceOferta.BEEstrategia>, List<EstrategiaPedidoModel>>(listaProducto);
//        //    var listaPedido = _pedidoWebProvider.ObtenerPedidoWebDetalle(0);
//        //    listaProductoModel = _ofertaPersonalizadaProvider.ConsultarEstrategiasFormatoModelo1(listaProductoModel, listaPedido, userData.CodigoISO, userData.CampaniaID);
//        //    return listaProductoModel;
//        //}

//        //public bool EsCampaniaFalsa(int campaniaId)
//        //{
//        //    return (campaniaId < userData.CampaniaID || campaniaId > Util.AddCampaniaAndNumero(userData.CampaniaID, 1, userData.NroCampanias));
//        //}

//        #region DetalleFicha
//        //private EstrategiaPersonalizadaProductoModel ObtenerEstrategiaPersonalizadaSession(string palanca, string cuv, int campaniaId)
//        //{
//        //    switch (palanca)
//        //    {
//        //        case Constantes.NombrePalanca.ShowRoom:
//        //            return ObtenerListaProductoShowRoom(campaniaId, userData.CodigoConsultora, userData.EsDiasFacturacion, 1)
//        //                .FirstOrDefault(x => x.CUV2 == cuv);
//        //        case Constantes.NombrePalanca.OfertaDelDia:
//        //            return sessionManager.OfertaDelDia.Estrategia.ListaOferta
//        //                .FirstOrDefault(x => x.CUV2 == cuv);
//        //        default:
//        //            return null;
//        //    }
//        //}

//        //public bool EnviaronParametrosValidos(string palanca, int campaniaId, string cuv)
//        //{
//        //    return !string.IsNullOrEmpty(palanca) &&
//        //           !string.IsNullOrEmpty(cuv) &&
//        //           !string.IsNullOrEmpty(campaniaId.ToString()) &&
//        //           !_ofertaPersonalizadaProvider.EsCampaniaFalsa(campaniaId);
//        //}

//        ////Por el momento solo SW y ODD se maneja de sesion
//        //public bool PalancasConSesion(string palanca)
//        //{
//        //    return palanca.Equals(Constantes.NombrePalanca.ShowRoom) ||
//        //           palanca.Equals(Constantes.NombrePalanca.OfertaDelDia);
//        //}

//        ////Falta revisar las casuiticas por palanca
//        //public bool TienePermisoPalanca(string palanca)
//        //{
//        //    var listaConfigPais = sessionManager.GetConfiguracionesPaisModel();
//        //    bool tienePalanca;
//        //    switch (palanca)
//        //    {
//        //        case Constantes.NombrePalanca.RevistaDigital:
//        //            tienePalanca = listaConfigPais.Any(x => x.Codigo == Constantes.ConfiguracionPais.RevistaDigital); break;
//        //        case Constantes.NombrePalanca.Lanzamiento:
//        //            tienePalanca = listaConfigPais.Any(x => x.Codigo == Constantes.ConfiguracionPais.Lanzamiento); break;
//        //        case Constantes.NombrePalanca.GuiaDeNegocioDigitalizada: //TODO: Validar habilitacion para GND
//        //            tienePalanca = listaConfigPais.Any(x => x.Codigo == Constantes.ConfiguracionPais.GuiaDeNegocioDigitalizada); break;
//        //        case Constantes.NombrePalanca.HerramientasVenta:
//        //        {
//        //            return revistaDigital.TieneRDC || revistaDigital.TieneRDCR;
//        //        }
//        //        case Constantes.NombrePalanca.ShowRoom:
//        //            tienePalanca = listaConfigPais.Any(x => x.Codigo == Constantes.ConfiguracionPais.ShowRoom); break;
//        //        case Constantes.NombrePalanca.OfertaDelDia:
//        //            tienePalanca = listaConfigPais.Any(x => x.Codigo == Constantes.ConfiguracionPais.OfertaDelDia); break;
//        //        case Constantes.NombrePalanca.OfertaParaTi:
//        //            tienePalanca = listaConfigPais.Any(x => x.Codigo == Constantes.ConfiguracionPais.OfertasParaTi); break;
//        //        case Constantes.NombrePalanca.OfertasParaMi:
//        //            tienePalanca = listaConfigPais.Any(x => x.Codigo == Constantes.ConfiguracionPais.RevistaDigital); break;
//        //        default:
//        //            tienePalanca = false; break;
//        //    }

//        //    return tienePalanca;
//        //}
//        #endregion

//        #region ShowRoom

//        //public List<EstrategiaPersonalizadaProductoModel> ObtenerListaProductoShowRoom(UsuarioModel userData, int campaniaId, string codigoConsultora, bool esFacturacion = false, int tipoOferta = 1)
//        //{
//        //    var listaProductoRetorno = new List<EstrategiaPersonalizadaProductoModel>();
//        //    var cargo = sessionManager.ShowRoom.CargoOfertas ?? "0";

//        //    if (cargo == "1")
//        //    {
//        //        switch (tipoOferta)
//        //        {
//        //            case 1:
//        //                listaProductoRetorno = sessionManager.ShowRoom.Ofertas ?? new List<EstrategiaPersonalizadaProductoModel>();
//        //                break;
//        //            case 2:
//        //                listaProductoRetorno = sessionManager.ShowRoom.OfertasSubCampania ?? new List<EstrategiaPersonalizadaProductoModel>();
//        //                break;
//        //            case 3:
//        //                listaProductoRetorno = sessionManager.ShowRoom.OfertasPerdio ?? new List<EstrategiaPersonalizadaProductoModel>();
//        //                break;
//        //        }

//        //        if (tipoOferta != 3)
//        //        {
//        //            var listaPedidoDetalle = _pedidoWeb.ObtenerPedidoWebDetalle(0);
//        //            listaProductoRetorno.Update(x =>
//        //            {
//        //                x.IsAgregado = listaPedidoDetalle.Any(p => p.CUV == x.CUV2);
//        //            });
//        //        }

//        //        return listaProductoRetorno;
//        //    }

//        //    var listaProducto = GetShowRoomOfertasConsultora(userData);
//        //    var listaProductoModel = ConsultarEstrategiasFormatoEstrategiaToModel1(listaProducto, userData.CodigoISO, userData.CampaniaID);

//        //    SetShowRoomOfertasInSession(listaProductoModel, userData);

//        //    switch (tipoOferta)
//        //    {
//        //        case 1:
//        //            return sessionManager.ShowRoom.Ofertas;
//        //        case 2:
//        //            return sessionManager.ShowRoom.OfertasSubCampania;
//        //        case 3:
//        //            return sessionManager.ShowRoom.OfertasPerdio;
//        //        default:
//        //            return sessionManager.ShowRoom.Ofertas;
//        //    }
//        //}
        
//        //private void SetShowRoomOfertasInSession(List<EstrategiaPedidoModel> listaProductoModel)
//        //{
//        //    var flagRevistaTodos = new List<int>() { Constantes.FlagRevista.Valor0, Constantes.FlagRevista.Valor1, Constantes.FlagRevista.Valor2 };
//        //    var listaOfertas = new List<EstrategiaPedidoModel>();
//        //    var listaSubCampania = new List<EstrategiaPedidoModel>();
//        //    var listaOfertasPerdio = new List<EstrategiaPedidoModel>();

//        //    if (revistaDigital.TieneRDC && revistaDigital.ActivoMdo && !revistaDigital.EsActiva)
//        //    {
//        //        listaOfertas = listaProductoModel.Where(x => !x.EsSubCampania && x.FlagRevista == Constantes.FlagRevista.Valor0).ToList();
//        //        listaOfertasPerdio = listaProductoModel.Where(x => !x.EsSubCampania && x.FlagRevista != Constantes.FlagRevista.Valor0).ToList();
//        //    }
//        //    else if (revistaDigital.TieneRDC && revistaDigital.ActivoMdo && revistaDigital.EsActiva)
//        //    {
//        //        listaOfertas = listaProductoModel.Where(x => !x.EsSubCampania && flagRevistaTodos.Contains(x.FlagRevista)).ToList();
//        //    }
//        //    else if (revistaDigital.EsActiva && revistaDigital.ActivoMdo)
//        //    {
//        //        listaSubCampania = listaProductoModel.Where(x => x.EsSubCampania && flagRevistaTodos.Contains(x.FlagRevista)).ToList();
//        //    }
//        //    else if (!revistaDigital.ActivoMdo)
//        //    {
//        //        listaOfertas = listaProductoModel.Where(x => !x.EsSubCampania).ToList();
//        //        listaSubCampania = listaProductoModel.Where(x => x.EsSubCampania).ToList();
//        //    }
//        //    else
//        //    {
//        //        listaOfertas = listaProductoModel.Where(x => !x.EsSubCampania && x.FlagRevista == Constantes.FlagRevista.Valor0).ToList();
//        //        listaSubCampania = listaProductoModel.Where(x => x.EsSubCampania && x.FlagRevista == Constantes.FlagRevista.Valor0).ToList();
//        //    }

//        //    var listaPedido = _pedidoWebProvider.ObtenerPedidoWebDetalle(0);
//        //    configEstrategiaSR.ListaCategoria = new List<ShowRoomCategoriaModel>();
//        //    sessionManager.ShowRoom.CargoOfertas = "1";
//        //    sessionManager.ShowRoom.Ofertas = _ofertaPersonalizadaProvider.FormatearModelo1ToPersonalizado(listaOfertas, listaPedido, userData.CodigoISO, userData.CampaniaID, 2, userData.esConsultoraLider, userData.Simbolo);
//        //    sessionManager.ShowRoom.OfertasSubCampania = _ofertaPersonalizadaProvider.FormatearModelo1ToPersonalizado(listaSubCampania, listaPedido, userData.CodigoISO, userData.CampaniaID, 2, userData.esConsultoraLider, userData.Simbolo);
//        //    sessionManager.ShowRoom.OfertasPerdio = _ofertaPersonalizadaProvider.FormatearModelo1ToPersonalizado(listaOfertasPerdio, listaPedido, userData.CodigoISO, userData.CampaniaID, 1, userData.esConsultoraLider, userData.Simbolo);
//        //}

//        #endregion
//    }
//}