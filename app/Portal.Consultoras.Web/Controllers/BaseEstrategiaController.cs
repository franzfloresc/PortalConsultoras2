﻿using AutoMapper;
using Newtonsoft.Json;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.LogManager;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.SessionManager;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Text;
using BEEstrategia = Portal.Consultoras.Web.ServicePedido.BEEstrategia;

namespace Portal.Consultoras.Web.Controllers
{
    public class BaseEstrategiaController : BaseController
    {
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
                case Constantes.TipoEstrategiaCodigo.OfertaParaTi:
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
        public EstrategiaPedidoModel GetOfertaConDetallePrueba(int idOferta)
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


            EstrategiaPersonalizadaProductoModel estrategiaModelo = new EstrategiaPersonalizadaProductoModel
            {
                EstrategiaID = idOferta,
                CampaniaID = userData.CampaniaID,
                CodigoVariante = ofertaShowRoomModelo.CodigoEstrategia
            };

            var listaHermanos = GetListaHermanos(estrategiaModelo);
            ofertaShowRoomModelo.ProductoTonos = listaHermanos;

            return ofertaShowRoomModelo;
        }

    }
}