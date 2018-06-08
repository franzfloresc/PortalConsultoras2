using AutoMapper;
using Newtonsoft.Json;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.LogManager;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceOferta;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServiceProductoCatalogoPersonalizado;
using Portal.Consultoras.Web.ServicePROLConsultas;
using Portal.Consultoras.Web.ServiceSAC;
using Portal.Consultoras.Web.SessionManager;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.ServiceModel;
using System.Text;
using BEEstrategia = Portal.Consultoras.Web.ServicePedido.BEEstrategia;

namespace Portal.Consultoras.Web.Controllers
{
    public class BaseEstrategiaController : BaseController
    {
        protected string CodigoProceso
        {
            get { return ConfigurationManager.AppSettings[Constantes.ConfiguracionManager.EmailCodigoProceso]; }
        }

        public BaseEstrategiaController()
            : base()
        {
            //
        }

        public BaseEstrategiaController(ISessionManager sessionManager)
            : base(sessionManager)
        {
        }

        public BaseEstrategiaController(ISessionManager sessionManager, ILogManager logManager)
            : base(sessionManager, logManager)
        {

        }

        public RevistaDigitalModel RevistaDigital
        {
            get
            {
                return revistaDigital;
            }
            set
            {
                revistaDigital = value;
            }
        }

        public List<BEEstrategia> ConsultarEstrategias(int campaniaId = 0, string codAgrupacion = "")
        {
            codAgrupacion = Util.Trim(codAgrupacion);
            var listEstrategia = new List<BEEstrategia>();

            switch (codAgrupacion)
            {
                case Constantes.TipoEstrategiaCodigo.RevistaDigital:
                    listEstrategia.AddRange(ConsultarEstrategiasPorTipo(Constantes.TipoEstrategiaCodigo.PackNuevas, campaniaId));
                    listEstrategia.AddRange(ConsultarEstrategiasPorTipo(Constantes.TipoEstrategiaCodigo.OfertaWeb, campaniaId));
                    listEstrategia.AddRange(ConsultarEstrategiasPorTipo(Constantes.TipoEstrategiaCodigo.RevistaDigital, campaniaId));
                    break;
                case Constantes.TipoEstrategiaCodigo.Lanzamiento:
                    listEstrategia.AddRange(ConsultarEstrategiasPorTipo(Constantes.TipoEstrategiaCodigo.Lanzamiento, campaniaId));
                    break;
                case Constantes.TipoEstrategiaCodigo.GuiaDeNegocioDigitalizada:
                    // cache de amazaon en la capa BL
                    listEstrategia.AddRange(ConsultarEstrategiasPorTipo(Constantes.TipoEstrategiaCodigo.GuiaDeNegocioDigitalizada, campaniaId));
                    break;
                case Constantes.TipoEstrategiaCodigo.HerramientasVenta:
                    listEstrategia.AddRange(ConsultarEstrategiasPorTipo(Constantes.TipoEstrategiaCodigo.HerramientasVenta, campaniaId));
                    break;
                case Constantes.TipoEstrategiaCodigo.LosMasVendidos:
                    listEstrategia.AddRange(ConsultarEstrategiasPorTipo(Constantes.TipoEstrategiaCodigo.LosMasVendidos, campaniaId));
                    break;
                default:
                    listEstrategia.AddRange(ConsultarEstrategiasPorTipo(Constantes.TipoEstrategiaCodigo.PackNuevas, campaniaId));
                    listEstrategia.AddRange(ConsultarEstrategiasPorTipo(Constantes.TipoEstrategiaCodigo.OfertaWeb, campaniaId));
                    listEstrategia.AddRange(ConsultarEstrategiasPorTipo(Constantes.TipoEstrategiaCodigo.OfertaParaTi, campaniaId));
                    break;
            }

            return listEstrategia;
        }

        protected virtual List<BEEstrategia> ConsultarEstrategiasPorTipo(string tipo, int campaniaId = 0)
        {
            var listEstrategia = new List<BEEstrategia>();
            try
            {
                campaniaId = campaniaId > 0 ? campaniaId : userData.CampaniaID;
                tipo = Util.Trim(tipo);
                string varSession = Constantes.ConstSession.ListaEstrategia + tipo;

                if (Session[varSession] != null && campaniaId == userData.CampaniaID)
                {
                    listEstrategia = (List<BEEstrategia>)Session[varSession];
                    if (listEstrategia.Any())
                    {
                        if (tipo == Constantes.TipoEstrategiaCodigo.PackNuevas && listEstrategia.Any())
                        {
                            listEstrategia = ConsultarEstrategiasFiltrarPackNuevasPedido(listEstrategia);
                        }

                        return listEstrategia;
                    }
                }

                var entidad = new BEEstrategia
                {
                    PaisID = userData.PaisID,
                    CampaniaID = campaniaId,
                    ConsultoraID = userData.UsuarioPrueba == 1 ? userData.ConsultoraAsociada : userData.CodigoConsultora,
                    Zona = userData.ZonaID.ToString(),
                    ZonaHoraria = userData.ZonaHoraria,
                    FechaInicioFacturacion = userData.FechaFinCampania,
                    ValidarPeriodoFacturacion = true,
                    Simbolo = userData.Simbolo,
                    CodigoTipoEstrategia = tipo
                };

                if (tipo == Constantes.TipoEstrategiaCodigo.LosMasVendidos)
                {
                    entidad.ConsultoraID = (userData.UsuarioPrueba == 1 ? userData.ConsultoraAsociadaID : userData.ConsultoraID).ToString();
                }

                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    listEstrategia = sv.GetEstrategiasPedido(entidad).ToList();
                }

                if (campaniaId == userData.CampaniaID)
                {
                    if (tipo == Constantes.TipoEstrategiaCodigo.PackNuevas
                        || tipo == Constantes.TipoEstrategiaCodigo.OfertaParaTi
                        || tipo == Constantes.TipoEstrategiaCodigo.OfertaWeb)
                    {
                        Session[varSession] = listEstrategia;
                    }
                    if (tipo == Constantes.TipoEstrategiaCodigo.PackNuevas && listEstrategia.Any())
                    {
                        listEstrategia = ConsultarEstrategiasFiltrarPackNuevasPedido(listEstrategia);
                    }
                }

                if (!listEstrategia.Any() && sessionManager.GetFlagLogCargaOfertas() &&
                    tipo != Constantes.TipoEstrategiaCodigo.OfertaWeb &&
                    tipo != Constantes.TipoEstrategiaCodigo.PackNuevas)
                    EnviarLogOferta(CrearDataLog(campaniaId, ObtenerConstanteConfPais(tipo)));

            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
            return listEstrategia;
        }

        public EstrategiaPersonalizadaProductoModel EstrategiaGetDetalle(int id, string cuv = "")
        {
            EstrategiaPersonalizadaProductoModel estrategiaModelo;
            try
            {
                estrategiaModelo = sessionManager.GetProductoTemporal();
                if (estrategiaModelo == null || estrategiaModelo.EstrategiaID <= 0)
                    return estrategiaModelo;

                estrategiaModelo.Hermanos = new List<ProductoModel>();
                estrategiaModelo.TextoLibre = Util.Trim(estrategiaModelo.TextoLibre);
                estrategiaModelo.CodigoVariante = Util.Trim(estrategiaModelo.CodigoVariante);

                var listaPedido = ObtenerPedidoWebDetalle();
                estrategiaModelo.IsAgregado = listaPedido.Any(p => p.CUV == estrategiaModelo.CUV2);

                if (string.IsNullOrWhiteSpace(estrategiaModelo.CodigoVariante))
                    return estrategiaModelo;

                estrategiaModelo.CampaniaID = estrategiaModelo.CampaniaID > 0 ? estrategiaModelo.CampaniaID : userData.CampaniaID;

                estrategiaModelo.Hermanos = GetListaHermanos(estrategiaModelo);
            }
            catch (Exception ex)
            {
                estrategiaModelo = new EstrategiaPersonalizadaProductoModel();
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
            return estrategiaModelo;
        }

        public List<EstrategiaPedidoModel> ConsultarEstrategiasHomePedido(string codAgrupacion = "")
        {
            List<BEEstrategia> listModel;
            if (Session[Constantes.ConstSession.ListaEstrategia] != null)
                listModel = (List<BEEstrategia>)Session[Constantes.ConstSession.ListaEstrategia];
            else
            {
                listModel = ConsultarEstrategias(0, codAgrupacion);

                if (!listModel.Any())
                {
                    Session[Constantes.ConstSession.ListaEstrategia] = listModel;
                    return new List<EstrategiaPedidoModel>();
                }

                #region Validar Tipo RD 

                if (codAgrupacion == Constantes.TipoEstrategiaCodigo.RevistaDigital)
                {
                    var listModelLan = ConsultarEstrategias(0, Constantes.TipoEstrategiaCodigo.Lanzamiento);
                    var estrategiaLanzamiento = listModelLan.FirstOrDefault() ?? new BEEstrategia();

                    if (!listModel.Any() && estrategiaLanzamiento.EstrategiaID <= 0)
                    {
                        Session[Constantes.ConstSession.ListaEstrategia] = listModel;
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

                    listModel = new List<BEEstrategia>();
                    if (estrategiaLanzamiento.EstrategiaID > 0)
                        listModel.Add(estrategiaLanzamiento);

                    listModel.AddRange(listaPackNueva);
                    listModel.AddRange(listaRevista);
                }
                #endregion

                Session[Constantes.ConstSession.ListaEstrategia] = listModel;
            }

            var listaProductoModel = ConsultarEstrategiasModelFormato(listModel);
            return listaProductoModel;
        }

        public List<EstrategiaPedidoModel> ConsultarEstrategiasModel(int campaniaId = 0, string codAgrupacion = "")
        {
            var listaProducto = ConsultarEstrategias(campaniaId, codAgrupacion);

            List<EstrategiaPedidoModel> listaProductoModel = ConsultarEstrategiasModelFormato(listaProducto);

            return listaProductoModel;
        }

        public List<EstrategiaPersonalizadaProductoModel> ConsultarEstrategiasFormatearModelo(List<EstrategiaPedidoModel> listaProductoModel, int tipo = 0)
        {
            var listaRetorno = new List<EstrategiaPersonalizadaProductoModel>();
            if (!listaProductoModel.Any())
                return listaRetorno;

            var listaPedido = ObtenerPedidoWebDetalle();
            var carpetaPais = Globals.UrlMatriz + "/" + userData.CodigoISO;

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
                prodModel.ClaseBloqueada = tipo == 1 || (estrategia.CampaniaID > 0 && estrategia.CampaniaID != userData.CampaniaID) ? claseBloqueada : "";
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

                prodModel.TipoAccionAgregar = TipoAccionAgregar(estrategia.TieneVariedad, estrategia.TipoEstrategia.Codigo, tipo == 1 || (estrategia.CampaniaID > 0 && estrategia.CampaniaID != userData.CampaniaID));

                if (estrategia.TipoEstrategia.Codigo == Constantes.TipoEstrategiaCodigo.Lanzamiento)
                {
                    prodModel.TipoEstrategiaDetalle.ImgFondoDesktop = ConfigS3.GetUrlFileS3(carpetaPais, estrategia.EstrategiaDetalle.ImgFondoDesktop);
                    prodModel.TipoEstrategiaDetalle.ImgFichaDesktop = ConfigS3.GetUrlFileS3(carpetaPais, estrategia.EstrategiaDetalle.ImgFichaDesktop);
                    prodModel.TipoEstrategiaDetalle.ImgFichaFondoDesktop = ConfigS3.GetUrlFileS3(carpetaPais, estrategia.EstrategiaDetalle.ImgFichaFondoDesktop);
                    prodModel.TipoEstrategiaDetalle.UrlVideoDesktop = Util.Trim(estrategia.EstrategiaDetalle.UrlVideoDesktop);
                    prodModel.TipoEstrategiaDetalle.ImgFondoMobile = ConfigS3.GetUrlFileS3(carpetaPais, estrategia.EstrategiaDetalle.ImgFondoMobile);
                    prodModel.TipoEstrategiaDetalle.ImgFichaMobile = ConfigS3.GetUrlFileS3(carpetaPais, estrategia.EstrategiaDetalle.ImgFichaMobile);
                    prodModel.TipoEstrategiaDetalle.ImgFichaFondoMobile = ConfigS3.GetUrlFileS3(carpetaPais, estrategia.EstrategiaDetalle.ImgFichaFondoMobile);
                    prodModel.TipoEstrategiaDetalle.UrlVideoMobile = Util.Trim(estrategia.EstrategiaDetalle.UrlVideoMobile);
                    prodModel.TipoEstrategiaDetalle.ImgHomeDesktop = ConfigS3.GetUrlFileS3(carpetaPais, estrategia.EstrategiaDetalle.ImgHomeDesktop);
                    prodModel.TipoEstrategiaDetalle.ImgHomeMobile = ConfigS3.GetUrlFileS3(carpetaPais, estrategia.EstrategiaDetalle.ImgHomeMobile);
                    prodModel.TipoEstrategiaDetalle.Slogan = estrategia.EstrategiaDetalle.Slogan.IsNullOrEmptyTrim() ? "" : estrategia.EstrategiaDetalle.Slogan.First().ToString().ToUpper() + estrategia.EstrategiaDetalle.Slogan.Substring(1).ToLower();
                    prodModel.TipoEstrategiaDetalle.FlagIndividual = estrategia.EstrategiaDetalle.FlagIndividual;
                    prodModel.CodigoProducto = estrategia.CodigoProducto;
                }
                else if (estrategia.TipoEstrategia.Codigo == Constantes.TipoEstrategiaCodigo.PackNuevas)
                {
                    prodModel.EsOfertaIndependiente = estrategia.EsOfertaIndependiente;
                    if (estrategia.EsOfertaIndependiente && estrategia.MostrarImgOfertaIndependiente)
                    {
                        prodModel.ImagenURL = ConfigS3.GetUrlFileS3(carpetaPais, estrategia.ImagenOfertaIndependiente);
                    }
                }
                else if (estrategia.TipoEstrategia.Codigo == Constantes.TipoEstrategiaCodigo.HerramientasVenta)
                {
                    prodModel.Precio = 0;
                    prodModel.Ganancia = 0;
                    if (estrategia.Precio2 > 0 && !string.IsNullOrWhiteSpace(estrategia.Niveles))
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
                                        tmp[1] = Util.DecimalToStringFormat(precio, userData.CodigoISO, userData.Simbolo);
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

                    prodModel.PrecioNiveles = estrategia.Niveles ?? string.Empty;
                }


                listaRetorno.Add(prodModel);
            });

            return listaRetorno;
        }

        public List<EstrategiaPedidoModel> ConsultarMasVendidosModel()
        {
            var listaProducto = ConsultarEstrategias(0, Constantes.TipoEstrategiaCodigo.LosMasVendidos);
            var listaProductoModel = Mapper.Map<List<BEEstrategia>, List<EstrategiaPedidoModel>>(listaProducto);
            listaProductoModel = ConsultarEstrategiasModelFormato(listaProductoModel);
            return listaProductoModel;
        }

        public bool EsCampaniaFalsa(int campaniaId)
        {
            return (campaniaId < userData.CampaniaID || campaniaId > AddCampaniaAndNumero(userData.CampaniaID, 1));
        }

        #region Metodos Privados

        private List<BEEstrategia> ConsultarEstrategiasFiltrarPackNuevasPedido(List<BEEstrategia> listEstrategia)
        {
            var pedidoWebDetalle = ObtenerPedidoWebDetalle();
            listEstrategia = listEstrategia.Where(e => !pedidoWebDetalle.Any(d => d.CUV == e.CUV2)).ToList();

            return listEstrategia;
        }

        private List<EstrategiaPedidoModel> ConsultarEstrategiasModelFormato(List<BEEstrategia> listaProducto)
        {
            listaProducto = listaProducto ?? new List<BEEstrategia>();
            List<EstrategiaPedidoModel> listaProductoModel = Mapper.Map<List<BEEstrategia>, List<EstrategiaPedidoModel>>(listaProducto);
            return ConsultarEstrategiasModelFormato(listaProductoModel);
        }

        private List<EstrategiaPedidoModel> ConsultarEstrategiasModelFormato(List<EstrategiaPedidoModel> listaProductoModel)
        {
            if (!listaProductoModel.Any())
                return listaProductoModel;

            var listaPedido = ObtenerPedidoWebDetalle();
            var carpetaPais = Globals.UrlMatriz + "/" + userData.CodigoISO;
            var claseBloqueada = "btn_desactivado_general";
            listaProductoModel.ForEach(estrategia =>
            {
                estrategia.ClaseBloqueada = estrategia.CampaniaID > 0 && estrategia.CampaniaID != userData.CampaniaID ? claseBloqueada : "";
                estrategia.IsAgregado = estrategia.ClaseBloqueada != claseBloqueada && listaPedido.Any(p => p.CUV == estrategia.CUV2.Trim());
                estrategia.DescripcionResumen = "";
                estrategia.DescripcionDetalle = "";
                estrategia.EstrategiaDetalle = estrategia.EstrategiaDetalle ?? new EstrategiaDetalleModelo();

                if (estrategia.TipoEstrategia.Codigo == Constantes.TipoEstrategiaCodigo.Lanzamiento)
                {
                    #region Lanzamiento
                    estrategia.EstrategiaDetalle.ImgFondoDesktop = ConfigS3.GetUrlFileS3(carpetaPais, estrategia.EstrategiaDetalle.ImgFondoDesktop);
                    estrategia.EstrategiaDetalle.ImgFichaDesktop = ConfigS3.GetUrlFileS3(carpetaPais, estrategia.EstrategiaDetalle.ImgFichaDesktop);
                    estrategia.EstrategiaDetalle.ImgFichaFondoDesktop = ConfigS3.GetUrlFileS3(carpetaPais, estrategia.EstrategiaDetalle.ImgFichaFondoDesktop);
                    estrategia.EstrategiaDetalle.UrlVideoDesktop = Util.Trim(estrategia.EstrategiaDetalle.UrlVideoDesktop);
                    estrategia.EstrategiaDetalle.ImgFondoMobile = ConfigS3.GetUrlFileS3(carpetaPais, estrategia.EstrategiaDetalle.ImgFondoMobile);
                    estrategia.EstrategiaDetalle.ImgFichaMobile = ConfigS3.GetUrlFileS3(carpetaPais, estrategia.EstrategiaDetalle.ImgFichaMobile);
                    estrategia.EstrategiaDetalle.ImgFichaFondoMobile = ConfigS3.GetUrlFileS3(carpetaPais, estrategia.EstrategiaDetalle.ImgFichaFondoMobile);
                    estrategia.EstrategiaDetalle.UrlVideoMobile = Util.Trim(estrategia.EstrategiaDetalle.UrlVideoMobile);
                    estrategia.EstrategiaDetalle.ImgHomeDesktop = ConfigS3.GetUrlFileS3(carpetaPais, estrategia.EstrategiaDetalle.ImgHomeDesktop);
                    estrategia.EstrategiaDetalle.ImgHomeMobile = ConfigS3.GetUrlFileS3(carpetaPais, estrategia.EstrategiaDetalle.ImgHomeMobile);

                    var listadescr = estrategia.DescripcionCUV2.Split('|');
                    estrategia.DescripcionResumen = listadescr.Length > 0 ? listadescr[0] : "";
                    estrategia.DescripcionCortada = listadescr.Length > 1 ? listadescr[1] : "";
                    if (listadescr.Length > 2)
                    {
                        estrategia.ListaDescripcionDetalle = new List<string>(listadescr.Skip(2));
                        estrategia.DescripcionDetalle = string.Join("<br />", listadescr.Skip(2));
                    }
                    estrategia.DescripcionCortada = Util.SubStrCortarNombre(estrategia.DescripcionCortada, 40);

                    #endregion
                }
                else if (estrategia.FlagNueva == 1)
                {
                    estrategia.Precio = 0;
                    estrategia.DescripcionCortada = estrategia.DescripcionCUV2.Split('|')[0];
                    estrategia.DescripcionDetalle = estrategia.DescripcionCUV2.Contains("|") ? estrategia.DescripcionCUV2.Split('|')[1] : string.Empty;
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

        private void EnviarLogOferta(object data)
        {
            var urlApi = GetConfiguracionManager(Constantes.ConfiguracionManager.UrlLogDynamo);

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

        private object CrearDataLog(int campaniaOferta, string palanca)
        {
            return new
            {
                Pais = userData.CodigoISO,
                CodigoConsultora = userData.CodigoConsultora,
                Fecha = userData.FechaActualPais.ToString("yyyyMMdd"),
                Campania = userData.CampaniaID,
                CampaniaOferta = campaniaOferta == 0 ? userData.CampaniaID.ToString() : campaniaOferta.ToString(),
                Palanca = palanca,
                Dispositivo = IsMobile() ? "Mobile" : "Desktop",
                Motivo = "Log carga oferta desde portal consultoras"
            };
        }

        private string ObtenerConstanteConfPais(string codigoAgrupacion)
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

        #endregion

        #region ShowRoom

        protected void ActionExecutingMobile()
        {
            if (sessionManager.GetUserData() == null) return;

            var userData = UserData();
            ViewBag.CodigoCampania = userData.CampaniaID.ToString();

            try
            {
                ViewBag.EsMobile = 2;
                BuildMenuMobile(userData, revistaDigital);
                CargarValoresGenerales(userData);

                bool mostrarBanner, permitirCerrarBanner = false;
                if (SiempreMostrarBannerPL20()) mostrarBanner = true;
                else if (NuncaMostrarBannerPL20()) mostrarBanner = false;
                else
                {
                    mostrarBanner = true;
                    permitirCerrarBanner = true;

                    if (userData.CloseBannerPL20) mostrarBanner = false;
                    else
                    {
                        using (var sv = new PedidoServiceClient())
                        {
                            var result = sv.ValidacionModificarPedidoSelectiva(userData.PaisID, userData.ConsultoraID, userData.CampaniaID, userData.UsuarioPrueba == 1, userData.AceptacionConsultoraDA, false, true, false);
                            if (result.MotivoPedidoLock == Enumeradores.MotivoPedidoLock.Reservado) mostrarBanner = false;
                        }
                    }
                }

                bool mostrarBannerTop = !NuncaMostrarBannerTopPL20();
                ViewBag.MostrarBannerTopPL20 = mostrarBannerTop;

                if (mostrarBanner || mostrarBannerTop)
                {
                    ViewBag.PermitirCerrarBannerPL20 = permitirCerrarBanner;
                    ShowRoomBannerLateralModel showRoomBannerLateral = GetShowRoomBannerLateral();
                    ViewBag.ShowRoomBannerLateral = showRoomBannerLateral;
                    ViewBag.MostrarShowRoomBannerLateral = sessionManager.GetEsShowRoom() &&
                        !showRoomBannerLateral.ConsultoraNoEncontrada && !showRoomBannerLateral.ConsultoraNoEncontrada &&
                        showRoomBannerLateral.BEShowRoomConsultora.EventoConsultoraID != 0 && showRoomBannerLateral.EstaActivoLateral;

                    if (showRoomBannerLateral.DiasFalta < 1)
                    {
                        ViewBag.MostrarShowRoomBannerLateral = false;
                    }

                    if (showRoomBannerLateral.DiasFalta > 0)
                    {
                        if (showRoomBannerLateral.DiasFalta > 1)
                        {
                            showRoomBannerLateral.LetrasDias = "FALTAN " + Convert.ToInt32(showRoomBannerLateral.DiasFalta).ToString() + " DÍAS";
                        }
                        else { showRoomBannerLateral.LetrasDias = "FALTA " + Convert.ToInt32(showRoomBannerLateral.DiasFalta).ToString() + " DÍA"; }
                    }

                    ViewBag.ImagenPopupShowroomIntriga = showRoomBannerLateral.ImagenPopupShowroomIntriga;
                    ViewBag.ImagenBannerShowroomIntriga = showRoomBannerLateral.ImagenBannerShowroomIntriga;
                    ViewBag.ImagenPopupShowroomVenta = showRoomBannerLateral.ImagenPopupShowroomVenta;
                    ViewBag.ImagenBannerShowroomVenta = showRoomBannerLateral.ImagenBannerShowroomVenta;
                    ViewBag.DiasFaltantesLetras = showRoomBannerLateral.LetrasDias;

                    OfertaDelDiaModel ofertaDelDia = GetOfertaDelDiaModel();
                    ViewBag.OfertaDelDia = ofertaDelDia;

                    ViewBag.MostrarOfertaDelDia =
                        !userData.CloseOfertaDelDia
                        && userData.TieneOfertaDelDia
                        && ofertaDelDia != null
                        && ofertaDelDia.TeQuedan.TotalSeconds > 0;

                    showRoomBannerLateral.EstadoActivo = mostrarBannerTop ? "0" : "1";
                }
                ViewBag.MostrarBannerPL20 = mostrarBanner;
                ViewBag.MostrarBannerOtros = mostrarBannerTop;

                ViewBag.EstadoActivo = mostrarBannerTop ? "0" : "1";

                if (mostrarBanner
                    && !(
                            (!userData.ValidacionAbierta && userData.EstadoPedido == 202 && userData.IndicadorGPRSB == 2)
                            || userData.IndicadorGPRSB == 0
                        )
                )
                {
                    ViewBag.MostrarBannerPL20 = false;
                    ViewBag.MostrarOfertaDelDia = false;
                }

            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
        }

        private void CargarValoresGenerales(UsuarioModel userData)
        {
            if (sessionManager.GetUserData() != null)
            {
                ViewBag.NombreConsultora = (string.IsNullOrEmpty(userData.Sobrenombre) ? userData.NombreConsultora : userData.Sobrenombre).ToUpper();
                int j = ViewBag.NombreConsultora.Trim().IndexOf(' ');
                if (j >= 0) ViewBag.NombreConsultora = ViewBag.NombreConsultora.Substring(0, j).Trim();

                ViewBag.NumeroCampania = userData.NombreCorto.Substring(4);
                ViewBag.EsUsuarioComunidad = userData.EsUsuarioComunidad ? 1 : 0;
                ViewBag.AnalyticsCampania = userData.CampaniaID;
                ViewBag.AnalyticsSegmento = string.IsNullOrEmpty(userData.Segmento) ? "(not available)" : userData.Segmento.Trim();
                ViewBag.AnalyticsEdad = Util.Edad(userData.FechaNacimiento);
                ViewBag.AnalyticsZona = userData.CodigoZona;
                ViewBag.AnalyticsPais = userData.CodigoISO;
                ViewBag.AnalyticsRol = "Consultora";
                ViewBag.AnalyticsRegion = userData.CodigorRegion;
                ViewBag.AnalyticsSeccion = string.IsNullOrEmpty(userData.SeccionAnalytics) ? "(not available)" : userData.SeccionAnalytics;
                ViewBag.AnalyticsCodigoConsultora = string.IsNullOrEmpty(userData.CodigoConsultora) ? "(not available)" : userData.CodigoConsultora;

                var fechaHoy = DateTime.Now.AddHours(userData.ZonaHoraria).Date;

                if (fechaHoy >= userData.FechaInicioCampania.Date && fechaHoy <= userData.FechaFinCampania.Date)
                    ViewBag.AnalyticsPeriodo = "Facturacion";
                else
                    ViewBag.AnalyticsPeriodo = "Venta";

                ViewBag.AnalyticsSegmentoConstancia = string.IsNullOrEmpty(userData.SegmentoConstancia) ? "(not available)" : userData.SegmentoConstancia.Trim();
                ViewBag.AnalyticsSociaNivel = string.IsNullOrEmpty(userData.DescripcionNivel) ? "(not available)" : userData.DescripcionNivel;
            }
        }

        private bool SiempreMostrarBannerPL20()
        {
            string controllerName = this.ControllerContext.RouteData.Values["controller"].ToString();
            string actionName = this.ControllerContext.RouteData.Values["action"].ToString();

            if (controllerName == "Bienvenida" && actionName == "Index") return true;
            return false;
        }

        private bool NuncaMostrarBannerPL20()
        {
            string controllerName = this.ControllerContext.RouteData.Values["controller"].ToString();

            return controllerName == "Pedido"
                || controllerName == "CatalogoPersonalizado"
                || controllerName == "ShowRoom"
                || controllerName == "SeguimientoPedido"
                || controllerName == "PedidosFacturados"
                || controllerName == "EstadoCuenta"
                || controllerName == "Cliente"
                || controllerName == "OfertaLiquidacion"
                || controllerName == "ConsultoraOnline"
                || controllerName == "ProductosAgotados"
                || controllerName == "Catalogo"
                || controllerName == "MiAsesorBelleza"
                || controllerName == "Notificaciones";
        }

        private bool NuncaMostrarBannerTopPL20()
        {
            string controllerName = this.ControllerContext.RouteData.Values["controller"].ToString();
            string actionName = this.ControllerContext.RouteData.Values["action"].ToString();

            return (controllerName == "Bienvenida" && actionName == "Index")
                   || controllerName == "Pedido"
                   || controllerName == "CatalogoPersonalizado"
                   || controllerName == "ShowRoom"
                   || controllerName == "SeguimientoPedido"
                   || controllerName == "PedidosFacturados"
                   || controllerName == "OfertaLiquidacion";

        }

        protected bool GetEventoConsultoraRecibido(UsuarioModel usuario)
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
                logManager.LogErrorWebServicesBusWrap(ex, usuario.CodigoConsultora, usuario.CodigoISO, "BaseShowRoomController.GetEventoConsultoraRecibido");
            }


            return result;
        }

        public bool ValidarIngresoShowRoom(bool esIntriga)
        {
            if (!configEstrategiaSR.CargoEntidadesShowRoom)
                return false;

            var resultado = false;

            var esShowRoom = sessionManager.GetEsShowRoom();
            var mostrarShowRoomProductos = sessionManager.GetMostrarShowRoomProductos();
            var mostrarShowRoomProductosExpiro = sessionManager.GetMostrarShowRoomProductosExpiro();

            if (esIntriga)
            {
                resultado = esShowRoom && !mostrarShowRoomProductos && !mostrarShowRoomProductosExpiro;
            }

            if (!esIntriga)
            {
                resultado = esShowRoom && mostrarShowRoomProductos && !mostrarShowRoomProductosExpiro;
            }

            return resultado;
        }

        public ShowRoomEventoModel CargarValoresModel()
        {
            ShowRoomEventoModel showRoomEventoModel;

            try
            {
                var showRoomEvento = configEstrategiaSR.BeShowRoom;
                var codigoConsultora = userData.CodigoConsultora;

                showRoomEventoModel = Mapper.Map<BEShowRoomEvento, ShowRoomEventoModel>(showRoomEvento);
                showRoomEventoModel.Simbolo = userData.Simbolo;
                showRoomEventoModel.CodigoIso = userData.CodigoISO;

                var fechaHoy = DateTime.Now.AddHours(userData.ZonaHoraria).Date;
                bool esFacturacion = fechaHoy >= userData.FechaInicioCampania.Date;

                var listaShowRoomOferta = ObtenerListaProductoShowRoom(userData.CampaniaID, codigoConsultora, esFacturacion);
                showRoomEventoModel.ListaShowRoomOferta = listaShowRoomOferta;

                var listaCompraPorCompra = GetProductosCompraPorCompra(esFacturacion, showRoomEventoModel.EventoID, showRoomEventoModel.CampaniaID);
                showRoomEventoModel.ListaShowRoomCompraPorCompra = listaCompraPorCompra;

                var listaCategoria = new List<ShowRoomCategoriaModel>();
                var categorias = listaShowRoomOferta.GroupBy(p => p.CodigoCategoria).Select(p => p.First());
                foreach (var item in categorias)
                {
                    if (!string.IsNullOrEmpty(item.DescripcionCategoria))
                    {
                        var beCategoria = new ShowRoomCategoriaModel
                        {
                            Codigo = item.CodigoCategoria,
                            Descripcion = item.DescripcionCategoria,
                            EventoID = showRoomEventoModel.EventoID
                        };
                        listaCategoria.Add(beCategoria);
                    }
                }

                listaCategoria = listaCategoria.OrderBy(p => p.Descripcion).ToList();

                showRoomEventoModel.ListaCategoria = listaCategoria;

                var tipoAplicacion = GetIsMobileDevice() ? Constantes.ShowRoomPersonalizacion.TipoAplicacion.Mobile
                    : Constantes.ShowRoomPersonalizacion.TipoAplicacion.Desktop;

                showRoomEventoModel.UrlTerminosCondiciones = ObtenerValorPersonalizacionShowRoom(Constantes.ShowRoomPersonalizacion.Mobile.UrlTerminosCondiciones, tipoAplicacion);
                showRoomEventoModel.TextoCondicionCompraCpc = ObtenerValorPersonalizacionShowRoom(Constantes.ShowRoomPersonalizacion.Mobile.TextoCondicionCompraCpc, tipoAplicacion);
                showRoomEventoModel.TextoDescripcionLegalCpc = ObtenerValorPersonalizacionShowRoom(Constantes.ShowRoomPersonalizacion.Mobile.TextoDescripcionLegalCpc, tipoAplicacion);

                if (GetIsMobileDevice())
                {
                    showRoomEventoModel.TextoInicialOfertaSubCampania = ObtenerValorPersonalizacionShowRoom(Constantes.ShowRoomPersonalizacion.Mobile.TextoInicialOfertaSubCampania, tipoAplicacion);
                    showRoomEventoModel.ColorTextoInicialOfertaSubCampania = ObtenerValorPersonalizacionShowRoom(Constantes.ShowRoomPersonalizacion.Mobile.ColorTextoInicialOfertaSubCampania, tipoAplicacion);
                    showRoomEventoModel.TextoTituloOfertaSubCampania = ObtenerValorPersonalizacionShowRoom(Constantes.ShowRoomPersonalizacion.Mobile.TextoTituloOfertaSubCampania, tipoAplicacion);
                    showRoomEventoModel.ColorTextoTituloOfertaSubCampania = ObtenerValorPersonalizacionShowRoom(Constantes.ShowRoomPersonalizacion.Mobile.ColorTextoTituloOfertaSubCampania, tipoAplicacion);
                    showRoomEventoModel.ColorFondoTituloOfertaSubCampania = ObtenerValorPersonalizacionShowRoom(Constantes.ShowRoomPersonalizacion.Mobile.ColorFondoTituloOfertaSubCampania, tipoAplicacion);
                }
                else
                {
                    showRoomEventoModel.TextoInicialOfertaSubCampania = ObtenerValorPersonalizacionShowRoom(Constantes.ShowRoomPersonalizacion.Desktop.TextoInicialOfertaSubCampania, tipoAplicacion);
                    showRoomEventoModel.ColorTextoInicialOfertaSubCampania = ObtenerValorPersonalizacionShowRoom(Constantes.ShowRoomPersonalizacion.Desktop.ColorTextoInicialOfertaSubCampania, tipoAplicacion);
                    showRoomEventoModel.TextoTituloOfertaSubCampania = ObtenerValorPersonalizacionShowRoom(Constantes.ShowRoomPersonalizacion.Desktop.TextoTituloOfertaSubCampania, tipoAplicacion);
                    showRoomEventoModel.ColorTextoTituloOfertaSubCampania = ObtenerValorPersonalizacionShowRoom(Constantes.ShowRoomPersonalizacion.Desktop.ColorTextoTituloOfertaSubCampania, tipoAplicacion);
                    showRoomEventoModel.ColorFondoTituloOfertaSubCampania = ObtenerValorPersonalizacionShowRoom(Constantes.ShowRoomPersonalizacion.Desktop.ColorFondoTituloOfertaSubCampania, tipoAplicacion);
                    showRoomEventoModel.ImagenFondoTituloOfertaSubCampania = ObtenerValorPersonalizacionShowRoom(Constantes.ShowRoomPersonalizacion.Desktop.ImagenFondoTituloOfertaSubCampania, tipoAplicacion);
                    showRoomEventoModel.ColorFondoContenidoOfertaSubCampania = ObtenerValorPersonalizacionShowRoom(Constantes.ShowRoomPersonalizacion.Desktop.ColorFondoContenidoOfertaSubCampania, tipoAplicacion);
                    showRoomEventoModel.TextoBotonVerMasOfertaSubCampania = ObtenerValorPersonalizacionShowRoom(Constantes.ShowRoomPersonalizacion.Desktop.TextoBotonVerMasOfertaSubCampania, tipoAplicacion);

                }
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
                showRoomEventoModel = new ShowRoomEventoModel();
            }

            return showRoomEventoModel;
        }

        protected virtual bool GetIsMobileDevice()
        {
            return Request.Browser.IsMobileDevice;
        }

        protected void UpdShowRoomEventoConsultoraEmailRecibido(string codigoConsultoraFromQueryString, int campaniaIdFromQueryString, UsuarioModel usuario)
        {
            try
            {
                var entidad = new BEShowRoomEventoConsultora
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
                logManager.LogErrorWebServicesBusWrap(ex, usuario.CodigoConsultora, usuario.CodigoISO, "BaseShowRoomController.GetEventoConsultoraRecibido");
            }
        }

        protected class ShowRoomQueryStringValidator
        {
            private readonly int CODIGO_PROCESO_INDEX = 0;
            private readonly int CODIGO_ISO_INDEX = 1;
            private readonly int CODIGO_CONSULTORA_INDEX = 2;
            private readonly int CAMPANIA_ID_INDEX = 3;
            private readonly int OFERTA_ID_INDEX = 5;
            private readonly char SEPARATOR = ';';
            private string QueryString { get; set; }

            public ShowRoomQueryStringValidator(string queryString)
            {
                if (!string.IsNullOrEmpty(queryString))
                {
                    LoadParameterValuesFromQueryString(queryString);
                }
            }

            private void LoadParameterValuesFromQueryString(string queryString)
            {
                QueryString = Util.Decrypt(queryString);
                var paramValues = QueryString.Split(SEPARATOR);
                if (CODIGO_PROCESO_INDEX < paramValues.Length) CodigoProceso = paramValues[CODIGO_PROCESO_INDEX];
                if (CODIGO_ISO_INDEX < paramValues.Length) CodigoIso = paramValues[CODIGO_ISO_INDEX];
                if (CODIGO_CONSULTORA_INDEX < paramValues.Length) CodigoConsultora = paramValues[CODIGO_CONSULTORA_INDEX];
                if (CAMPANIA_ID_INDEX < paramValues.Length && !string.IsNullOrEmpty(paramValues[CAMPANIA_ID_INDEX]))
                    CampanaId = Convert.ToInt32(paramValues[CAMPANIA_ID_INDEX]);

                if (OFERTA_ID_INDEX < paramValues.Length &&
                    !string.IsNullOrEmpty(paramValues[OFERTA_ID_INDEX]))
                    OfertaId = Convert.ToInt32(paramValues[OFERTA_ID_INDEX]);
            }

            public string CodigoProceso { get; private set; }
            public string CodigoIso { get; private set; }
            public string CodigoConsultora { get; private set; }
            public int CampanaId { get; private set; }
            public int OfertaId { get; private set; }
        }

        protected virtual List<TablaLogicaDatosModel> GetTablaLogicaDatos(short tablaLogicaId)
        {
            List<BETablaLogicaDatos> tablaLogicaDatos;

            using (var svc = new SACServiceClient())
            {
                tablaLogicaDatos = svc.GetTablaLogicaDatos(userData.PaisID, tablaLogicaId).ToList();
            }

            var tablaLogicaDatosModel = Mapper.Map<List<BETablaLogicaDatos>, List<TablaLogicaDatosModel>>(tablaLogicaDatos);

            return tablaLogicaDatosModel;
        }

        private void ActualizarUrlImagenes(List<ServiceOferta.BEShowRoomOferta> ofertasShowRoom)
        {
            ofertasShowRoom.Update(x =>
            {
                x.ImagenProducto = string.Empty;
                x.ImagenMini = string.Empty;
                if (string.IsNullOrEmpty(x.ImagenProducto))
                {
                    x.ImagenProducto = ConfigS3.GetUrlFileS3(ObtenerCarpetaPais(), x.ImagenProducto, ObtenerCarpetaPais());
                }
                if (string.IsNullOrEmpty(x.ImagenMini))
                {
                    x.ImagenProducto = ConfigS3.GetUrlFileS3(ObtenerCarpetaPais(), x.ImagenMini, ObtenerCarpetaPais());
                }
            });
        }

        protected virtual string ObtenerCarpetaPais()
        {
            return Globals.UrlMatriz + "/" + userData.CodigoISO;
        }

        public EstrategiaPedidoModel ViewDetalleOferta(int id)
        {
            var modelo = GetOfertaConDetalle(id);
            modelo.CodigoISO = userData.CodigoISO;
            modelo.ListaOfertaShowRoom = GetOfertaListadoExcepto(id);
            var listaDetalle = ObtenerPedidoWebDetalle();
            modelo.ListaOfertaShowRoom.Update(o => o.Agregado = (listaDetalle.Find(p => p.CUV == o.CUV) ?? new BEPedidoWebDetalle()).PedidoDetalleID > 0 ? "block" : "none");

            modelo.FBMensaje = "";

            var tipoAplicacion = GetIsMobileDevice() ? Constantes.ShowRoomPersonalizacion.TipoAplicacion.Mobile
                    : Constantes.ShowRoomPersonalizacion.TipoAplicacion.Desktop;

            modelo.TextoCondicionCompraCpc = ObtenerValorPersonalizacionShowRoom(Constantes.ShowRoomPersonalizacion.Mobile.TextoCondicionCompraCpc, tipoAplicacion);
            modelo.TextoDescripcionLegalCpc = ObtenerValorPersonalizacionShowRoom(Constantes.ShowRoomPersonalizacion.Mobile.TextoDescripcionLegalCpc, tipoAplicacion);

            return modelo;
        }

        public EstrategiaPedidoModel GetOfertaConDetalle(int idOferta)
        {
            EstrategiaPedidoModel ofertaShowRoomModelo = new EstrategiaPedidoModel();
            if (idOferta <= 0) return ofertaShowRoomModelo;

            List<EstrategiaPedidoModel> listadoOfertasTodasModel = ObtenerListaProductoShowRoom(userData.CampaniaID, userData.CodigoConsultora);
            ofertaShowRoomModelo = listadoOfertasTodasModel.Find(o => o.OfertaShowRoomID == idOferta) ?? new EstrategiaPedidoModel();
            if (ofertaShowRoomModelo.OfertaShowRoomID <= 0) return ofertaShowRoomModelo;

            ofertaShowRoomModelo.ImagenProducto = Util.Trim(ofertaShowRoomModelo.ImagenProducto);
            ofertaShowRoomModelo.ImagenProducto = ofertaShowRoomModelo.ImagenProducto == "" ?
                "/Content/Images/showroom/no_disponible.png" :
                ofertaShowRoomModelo.ImagenProducto;

            /*TONOS-INI*/
            #region Obtener productos por estrategia
            List<BEEstrategiaProducto> listaEstrategiaProducto = new List<BEEstrategiaProducto>();
            using (PedidoServiceClient svc = new PedidoServiceClient())
            {
                BEEstrategia estrategia = new BEEstrategia() { PaisID = userData.PaisID, EstrategiaID = idOferta };
                listaEstrategiaProducto = svc.GetEstrategiaProducto(estrategia).ToList();
            }

            // filtrar solo activos
            listaEstrategiaProducto = listaEstrategiaProducto.Where(x => x.Activo == 1).ToList();
            string codigoVariante = listaEstrategiaProducto.Select(o => o.CodigoEstrategia).FirstOrDefault();
            #endregion

            #region Obtener tonos de AppCatalogo por codigosap
            StringBuilder listaCodigosSAP = new StringBuilder();
            const string separador = "|";
            listaCodigosSAP.Append(separador);

            if (codigoVariante == Constantes.TipoEstrategiaSet.IndividualConTonos || codigoVariante == Constantes.TipoEstrategiaSet.CompuestaFija)
            {
                foreach (BEEstrategiaProducto producto in listaEstrategiaProducto.Where(producto => producto != null && string.IsNullOrEmpty(producto.ImagenProducto) == true))
                {
                    producto.SAP = Util.Trim(producto.SAP);
                    if (producto.SAP != string.Empty && !listaCodigosSAP.ToString().Contains(separador + producto.SAP + separador))
                    {
                        listaCodigosSAP.Append(producto.SAP + separador);
                    }
                }
            }
            else if (codigoVariante == Constantes.TipoEstrategiaSet.CompuestaVariable)
            {
                foreach (BEEstrategiaProducto producto in listaEstrategiaProducto.Where(producto => producto != null))
                {
                    producto.SAP = Util.Trim(producto.SAP);
                    if (producto.SAP != string.Empty && !listaCodigosSAP.ToString().Contains(separador + producto.SAP + separador))
                    {
                        listaCodigosSAP.Append(producto.SAP + separador);
                    }
                }
            }

            List<Producto> listaAppCatalogo = new List<Producto>();
            if (listaCodigosSAP.ToString() != separador)
            {
                string listaDeCUV = listaCodigosSAP.ToString().Substring(1, listaCodigosSAP.ToString().Length - 2);
                int numeroCampanias = Convert.ToInt32(GetConfiguracionManager(Constantes.ConfiguracionManager.NumeroCampanias));
                using (ProductoServiceClient svc = new ProductoServiceClient())
                {
                    listaAppCatalogo = svc.ObtenerProductosPorCampaniasBySap(userData.CodigoISO, userData.CampaniaID, listaDeCUV, numeroCampanias).ToList();
                }
            }
            #endregion

            #region Algoritmo para relacionar productos con tonos
            List<ProductoModel> listaInfoAppCatalogo = Mapper.Map<List<Producto>, List<ProductoModel>>(listaAppCatalogo);
            foreach (ProductoModel producto in listaInfoAppCatalogo)
            {
                BEEstrategiaProducto estrategiaProducto = listaEstrategiaProducto.FirstOrDefault(p => p.CUV == producto.CUV);
                if (estrategiaProducto == null) continue;
                producto.Digitable = estrategiaProducto.Digitable;
            }

            List<ProductoModel> listaProductoTemporal = new List<ProductoModel>();

            if (codigoVariante == Constantes.TipoEstrategiaSet.IndividualConTonos || codigoVariante == Constantes.TipoEstrategiaSet.CompuestaFija)
            {
                foreach (BEEstrategiaProducto item in listaEstrategiaProducto)
                {
                    string imagenProducto = string.Empty;
                    if (!string.IsNullOrEmpty(item.ImagenProducto))
                    {
                        imagenProducto = ConfigS3.GetUrlFileS3(Globals.UrlMatriz + "/" + userData.CodigoISO, item.ImagenProducto, Globals.UrlMatriz + "/" + userData.CodigoISO);
                    }
                    else
                    {
                        foreach (ProductoModel app in listaInfoAppCatalogo)
                        {
                            if (app.CodigoProducto == item.SAP)
                            {
                                imagenProducto = app.Imagen;
                            }
                        }
                    }

                    ProductoModel prod = new ProductoModel()
                    {
                        NombreComercial = item.NombreProducto,
                        Descripcion = item.Descripcion1,
                        Imagen = imagenProducto,
                        DescripcionMarca = item.NombreMarca,
                        Orden = item.Orden,
                        Grupo = item.Grupo,
                        PrecioCatalogo = item.Precio,
                        PrecioCatalogoString = Util.DecimalToStringFormat(item.Precio, userData.CodigoISO),
                        Digitable = item.Digitable,
                        CUV = Util.Trim(item.CUV),
                        Cantidad = item.Cantidad,
                        FactorCuadre = item.FactorCuadre > 0 ? item.FactorCuadre : 1
                    };
                    listaProductoTemporal.Add(prod);
                }

                listaProductoTemporal.ForEach(h => { h.Digitable = 0; h.NombreComercial = Util.Trim(h.NombreComercial); });
                listaProductoTemporal = listaProductoTemporal.Where(h => h.NombreComercial != "").ToList();
            }
            else if (codigoVariante == Constantes.TipoEstrategiaSet.CompuestaVariable)
            {
                listaEstrategiaProducto = listaEstrategiaProducto.OrderBy(p => p.Grupo).ToList();
                listaInfoAppCatalogo = listaInfoAppCatalogo.OrderBy(p => p.CodigoProducto).ToList();
                int idPk = 1;
                listaInfoAppCatalogo.ForEach(h => h.ID = idPk++);
                idPk = 0;

                foreach (BEEstrategiaProducto item in listaEstrategiaProducto)
                {
                    ProductoModel prod = (ProductoModel)(listaInfoAppCatalogo.FirstOrDefault(p => item.SAP == p.CodigoProducto) ?? new ProductoModel()).Clone();
                    if (Util.Trim(prod.CodigoProducto) == "") continue;
                    if (listaInfoAppCatalogo.Count(p => item.SAP == p.CodigoProducto) > 1)
                    {
                        prod = (ProductoModel)(listaInfoAppCatalogo.FirstOrDefault(p => item.SAP == p.CodigoProducto && p.ID > idPk) ?? new ProductoModel()).Clone();
                    }
                    prod.NombreComercial = item.NombreProducto;
                    prod.Descripcion = item.Descripcion1;
                    if (!string.IsNullOrEmpty(item.ImagenProducto))
                    {
                        prod.Imagen = ConfigS3.GetUrlFileS3(Globals.UrlMatriz + "/" + userData.CodigoISO, item.ImagenProducto, Globals.UrlMatriz + "/" + userData.CodigoISO);
                    }
                    if (!string.IsNullOrEmpty(item.NombreMarca))
                    {
                        prod.DescripcionMarca = item.NombreMarca;
                    }
                    prod.Orden = item.Orden;
                    prod.Grupo = item.Grupo;
                    prod.PrecioCatalogo = item.Precio;
                    prod.PrecioCatalogoString = Util.DecimalToStringFormat(item.Precio, userData.CodigoISO);
                    prod.Digitable = item.Digitable;
                    prod.CUV = Util.Trim(item.CUV);
                    prod.Cantidad = item.Cantidad;
                    prod.FactorCuadre = item.FactorCuadre > 0 ? item.FactorCuadre : 1;
                    listaProductoTemporal.Add(prod);
                    idPk = prod.ID;
                }

                List<ProductoModel> listaHermanosR = new List<ProductoModel>();
                foreach (ProductoModel hermano in listaProductoTemporal.Select(item => (ProductoModel)item.Clone()))
                {
                    hermano.Hermanos = new List<ProductoModel>();
                    if (hermano.Digitable == 1)
                    {
                        bool existe = false;
                        foreach (ProductoModel itemR in listaHermanosR)
                        {
                            existe = itemR.Hermanos.Any(h => h.CUV == hermano.CUV);
                            if (existe) break;
                        }
                        if (existe) continue;

                        hermano.Hermanos = listaProductoTemporal.Where(p => p.Grupo == hermano.Grupo).OrderBy(p => p.Orden).ToList();
                    }
                    listaHermanosR.Add(hermano);
                }
                listaProductoTemporal = listaHermanosR.OrderBy(p => p.Orden).ToList();
            }

            listaInfoAppCatalogo = listaProductoTemporal;

            #endregion
            #region Algoritmo para considerar FactorCuadre
            List<ProductoModel> listaProductoConFactorCuadre = new List<ProductoModel>();
            foreach (ProductoModel infoAppCatalogo in listaInfoAppCatalogo)
            {
                listaProductoConFactorCuadre.Add((ProductoModel)infoAppCatalogo.Clone());
                if (infoAppCatalogo.FactorCuadre <= 1) continue;
                for (int i = 0; i < infoAppCatalogo.FactorCuadre - 1; i++)
                {
                    listaProductoConFactorCuadre.Add((ProductoModel)infoAppCatalogo.Clone());
                }
            }
            #endregion

            ofertaShowRoomModelo.ProductoTonos = listaProductoConFactorCuadre;
            ofertaShowRoomModelo.CodigoEstrategia = codigoVariante;
            /*TONOS-FIN*/

            return ofertaShowRoomModelo;
        }

        public List<EstrategiaPedidoModel> GetOfertaListadoExcepto(int idOferta)
        {
            var listaOferta = new List<EstrategiaPedidoModel>();
            if (idOferta <= 0) return listaOferta;

            var listadoOfertasTodasModel = ObtenerListaProductoShowRoom(userData.CampaniaID, userData.CodigoConsultora);
            listaOferta = listadoOfertasTodasModel.Where(o => o.OfertaShowRoomID != idOferta).ToList();
            return listaOferta;
        }

        public List<EstrategiaPedidoModel> ObtenerListaProductoShowRoom(int campaniaId, string codigoConsultora, bool esFacturacion = false, bool conFiltroMdo = true)
        {
            var listaDetalle = ObtenerPedidoWebDetalle();

            if (Session[Constantes.ConstSession.ListaProductoShowRoom] != null)
            {
                List<EstrategiaPedidoModel> listadoOfertasTodasModel = ObtenerListaProductoShowRoomSession(listaDetalle);
                return listadoOfertasTodasModel;
            }

            var listaShowRoomOferta = ObtenerListaProductoShowRoomService(campaniaId, codigoConsultora);
            if (conFiltroMdo)
                listaShowRoomOferta = ObtenerListaProductoShowRoomMdo(listaShowRoomOferta, Constantes.FlagRevista.Valor0);

            var listadoOfertasTodasModel1 = ObtenerListaProductoShowRoomFormato(listaShowRoomOferta, listaDetalle, esFacturacion);

            return listadoOfertasTodasModel1;
        }

        private List<ServiceOferta.BEShowRoomOferta> ObtenerListaProductoShowRoomService(int campaniaId, string codigoConsultora)
        {
            List<ServiceOferta.BEShowRoomOferta> listaShowRoomOferta;

            using (OfertaServiceClient ofertaService = new OfertaServiceClient())
            {
                listaShowRoomOferta = ofertaService.GetShowRoomOfertasConsultora(userData.PaisID, campaniaId, codigoConsultora).ToList();
            }

            return listaShowRoomOferta;
        }

        private List<EstrategiaPedidoModel> ObtenerListaProductoShowRoomSession(List<BEPedidoWebDetalle> listaPedidoDetalle)
        {
            var listadoOfertasTodas = (List<ServiceOferta.BEShowRoomOferta>)Session[Constantes.ConstSession.ListaProductoShowRoom];
            List<EstrategiaPedidoModel> listadoOfertasTodasModel = Mapper.Map<List<ServiceOferta.BEShowRoomOferta>, List<EstrategiaPedidoModel>>(listadoOfertasTodas);
            listadoOfertasTodasModel.Update(x =>
            {
                x.DescripcionMarca = GetDescripcionMarca(x.MarcaID);
                x.CodigoISO = userData.CodigoISO;
                x.Simbolo = userData.Simbolo;
                x.Agregado = (listaPedidoDetalle.Find(p => p.CUV == x.CUV) ?? new BEPedidoWebDetalle()).PedidoDetalleID > 0 ? "block" : "none";
                string CodigoEstrategia = listadoOfertasTodas.Where(f => f.CUV == x.CUV).Select(o => o.CodigoEstrategia).FirstOrDefault();

                x.TipoAccionAgregar = TipoAccionAgregar(0, Constantes.TipoEstrategiaCodigo.ShowRoom, false, CodigoEstrategia);

            });
            return listadoOfertasTodasModel;

        }

        private List<ServiceOferta.BEShowRoomOferta> ObtenerListaProductoShowRoomMdo(List<ServiceOferta.BEShowRoomOferta> listaShowRoomOferta, int flagRevistaValor = 0)
        {
            if (revistaDigital.TieneRDC && revistaDigital.ActivoMdo && !revistaDigital.EsActiva)
            {
                listaShowRoomOferta = listaShowRoomOferta.Where(p => p.FlagRevista == (flagRevistaValor == 0 ? Constantes.FlagRevista.Valor0 : flagRevistaValor)).ToList();
            }
            return listaShowRoomOferta;

        }

        private List<EstrategiaPedidoModel> ObtenerListaProductoShowRoomFormato(List<ServiceOferta.BEShowRoomOferta> listaShowRoomOferta, List<BEPedidoWebDetalle> listaPedidoDetalle, bool esFacturacion)
        {
            var carpetaPais = Globals.UrlMatriz + "/" + userData.CodigoISO;
            if (listaShowRoomOferta.Any())
            {
                listaShowRoomOferta.Update(x => x.ImagenProducto = string.IsNullOrEmpty(x.ImagenProducto)
                                ? "" : ConfigS3.GetUrlFileS3(carpetaPais, x.ImagenProducto, Globals.UrlMatriz + "/" + userData.CodigoISO));
                listaShowRoomOferta.Update(x => x.ImagenMini = string.IsNullOrEmpty(x.ImagenMini)
                                ? "" : ConfigS3.GetUrlFileS3(carpetaPais, x.ImagenMini, Globals.UrlMatriz + "/" + userData.CodigoISO));
            }

            var listaTieneStock = new List<Lista>();
            if (esFacturacion)
            {
                /*Obtener si tiene stock de PROL por CodigoSAP*/
                var txtBuil = new StringBuilder();
                foreach (var beProducto in listaShowRoomOferta)
                {
                    if (!string.IsNullOrEmpty(beProducto.CodigoProducto))
                    {
                        txtBuil.Append(beProducto.CodigoProducto + "|");
                    }
                }
                var codigoSap = txtBuil.ToString();
                codigoSap = codigoSap == "" ? "" : codigoSap.Substring(0, codigoSap.Length - 1);

                try
                {
                    if (!string.IsNullOrEmpty(codigoSap))
                    {
                        using (var sv = new wsConsulta())
                        {
                            sv.Url = GetConfiguracionManager(Constantes.ConfiguracionManager.RutaServicePROLConsultas);
                            listaTieneStock = sv.ConsultaStock(codigoSap, userData.CodigoISO).ToList();
                        }
                    }
                }
                catch (Exception ex)
                {
                    LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);

                    listaTieneStock = new List<Lista>();
                }
            }

            var listaShowRoomOfertaFinal = new List<ServiceOferta.BEShowRoomOferta>();
            foreach (var beShowRoomOferta in listaShowRoomOferta)
            {
                bool tieneStockProl = true;
                if (esFacturacion)
                {
                    var itemStockProl = listaTieneStock.FirstOrDefault(p => p.Codsap.ToString() == beShowRoomOferta.CodigoProducto);
                    if (itemStockProl != null)
                        tieneStockProl = itemStockProl.estado == 1;
                }
                if (tieneStockProl)
                {
                    listaShowRoomOfertaFinal.Add(beShowRoomOferta);
                }
            }

            Session[Constantes.ConstSession.ListaProductoShowRoom] = listaShowRoomOfertaFinal;
            List<EstrategiaPedidoModel> listadoOfertasTodasModel1 = Mapper.Map<List<ServiceOferta.BEShowRoomOferta>, List<EstrategiaPedidoModel>>(listaShowRoomOfertaFinal);

            listadoOfertasTodasModel1.Update(x =>
            {
                x.DescripcionMarca = GetDescripcionMarca(x.MarcaID);
                x.CodigoISO = userData.CodigoISO;
                x.Simbolo = userData.Simbolo;
                x.Agregado = (listaPedidoDetalle.Find(p => p.CUV == x.CUV) ?? new BEPedidoWebDetalle()).PedidoDetalleID > 0 ? "block" : "none";

                string CodigoEstrategia = listaShowRoomOfertaFinal.Where(f => f.CUV == x.CUV).Select(o => o.CodigoEstrategia).FirstOrDefault();

                x.TipoAccionAgregar = TipoAccionAgregar(0, Constantes.TipoEstrategiaCodigo.ShowRoom, false, CodigoEstrategia);
            });
            return listadoOfertasTodasModel1;
        }

        public List<EstrategiaPedidoModel> GetProductosCompraPorCompra(bool esFacturacion, int eventoId, int campaniaId)
        {
            try
            {
                if (Session[Constantes.ConstSession.ListaProductoShowRoomCpc] != null)
                {
                    var listadoOfertasTodas = (List<ServiceOferta.BEShowRoomOferta>)Session[Constantes.ConstSession.ListaProductoShowRoomCpc];
                    var listadoOfertasTodasModel = Mapper.Map<List<ServiceOferta.BEShowRoomOferta>, List<EstrategiaPedidoModel>>(listadoOfertasTodas);
                    listadoOfertasTodasModel.Update(x =>
                    {
                        x.DescripcionMarca = GetDescripcionMarca(x.MarcaID);
                        x.CodigoISO = userData.CodigoISO;
                        x.Simbolo = userData.Simbolo;
                    });
                    return listadoOfertasTodasModel;
                }

                List<ServiceOferta.BEShowRoomOferta> listaShowRoomCpc = GetProductosCompraPorCompraService(eventoId, campaniaId);
                listaShowRoomCpc = ObtenerListaProductoShowRoomMdo(listaShowRoomCpc);

                var listaTieneStock = new List<Lista>();
                var txtBuil = new StringBuilder();
                string codigoSap;
                if (esFacturacion)
                {
                    foreach (var beProducto in listaShowRoomCpc)
                    {
                        if (!string.IsNullOrEmpty(beProducto.CodigoProducto))
                        {
                            txtBuil.Append(beProducto.CodigoProducto + "|");
                        }
                    }

                    codigoSap = txtBuil.ToString();
                    codigoSap = codigoSap == "" ? "" : codigoSap.Substring(0, codigoSap.Length - 1);

                    try
                    {
                        if (!string.IsNullOrEmpty(codigoSap))
                        {
                            using (var sv = new wsConsulta())
                            {
                                sv.Url = GetConfiguracionManager(Constantes.ConfiguracionManager.RutaServicePROLConsultas);
                                listaTieneStock = sv.ConsultaStock(codigoSap, userData.CodigoISO).ToList();
                            }
                        }
                    }
                    catch (Exception ex)
                    {
                        LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);

                        listaTieneStock = new List<Lista>();
                    }
                }

                var listaShowRoomCpcFinal = new List<ServiceOferta.BEShowRoomOferta>();
                txtBuil.Clear();
                foreach (var beShowRoomOferta in listaShowRoomCpc)
                {
                    bool tieneStockProl = true;
                    if (esFacturacion)
                    {
                        var itemStockProl = listaTieneStock.FirstOrDefault(p => p.Codsap.ToString() == beShowRoomOferta.CodigoProducto);
                        if (itemStockProl != null)
                            tieneStockProl = itemStockProl.estado == 1;
                    }

                    if (tieneStockProl)
                    {
                        txtBuil.Append(beShowRoomOferta.CodigoProducto + "|");
                        listaShowRoomCpcFinal.Add(beShowRoomOferta);
                    }
                }
                List<Producto> listaShowRoomProductoCatalogo;
                var numeroCampanias = Convert.ToInt32(GetConfiguracionManager(Constantes.ConfiguracionManager.NumeroCampanias));

                codigoSap = txtBuil.ToString();
                codigoSap = codigoSap == "" ? "" : codigoSap.Substring(0, codigoSap.Length - 1);
                using (ProductoServiceClient sv = new ProductoServiceClient())
                {
                    listaShowRoomProductoCatalogo = sv.ObtenerProductosPorCampaniasBySap(userData.CodigoISO, campaniaId, codigoSap, numeroCampanias).ToList();
                }

                foreach (var item in listaShowRoomCpcFinal)
                {
                    var beCatalogoPro = listaShowRoomProductoCatalogo.FirstOrDefault(p => p.CodigoSap == item.CodigoProducto);
                    if (beCatalogoPro != null)
                    {
                        item.ImagenProducto = beCatalogoPro.Imagen;
                        item.Descripcion = beCatalogoPro.NombreComercial;
                        item.DescripcionLegal = beCatalogoPro.Descripcion;
                    }
                }

                Session[Constantes.ConstSession.ListaProductoShowRoomCpc] = listaShowRoomCpcFinal;
                var listadoProductosCpcModel1 = Mapper.Map<List<ServiceOferta.BEShowRoomOferta>, List<EstrategiaPedidoModel>>(listaShowRoomCpcFinal);
                listadoProductosCpcModel1.Update(x =>
                {
                    x.DescripcionMarca = GetDescripcionMarca(x.MarcaID);
                    x.CodigoISO = userData.CodigoISO;
                    x.Simbolo = userData.Simbolo;
                });

                return listadoProductosCpcModel1;
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return null;
            }
        }

        private List<ServiceOferta.BEShowRoomOferta> GetProductosCompraPorCompraService(int campaniaId, int eventoId)
        {
            List<ServiceOferta.BEShowRoomOferta> listaShowRoomCpc;

            using (OfertaServiceClient ofertaServiceClient = new OfertaServiceClient())
            {
                listaShowRoomCpc = ofertaServiceClient.GetProductosCompraPorCompra(userData.PaisID, eventoId, campaniaId).ToList();
            }

            return listaShowRoomCpc;
        }

        protected EstrategiaPedidoModel ObtenerPrimeraOfertaShowRoom()
        {
            var ofertasShowRoom = ObtenerListaProductoShowRoomService(userData.CampaniaID, userData.CodigoConsultora);
            ofertasShowRoom = ObtenerListaProductoShowRoomMdo(ofertasShowRoom);
            ActualizarUrlImagenes(ofertasShowRoom);


            var ofertasShowRoomModel = Mapper.Map<List<ServiceOferta.BEShowRoomOferta>, List<EstrategiaPedidoModel>>(ofertasShowRoom);
            ofertasShowRoomModel.Update(x => x.DescripcionMarca = GetDescripcionMarca(x.MarcaID));

            var ofertaShowRoomModel = ofertasShowRoomModel.FirstOrDefault();

            return ofertaShowRoomModel;
        }

        #endregion

    }
}