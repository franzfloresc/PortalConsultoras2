﻿using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceODS;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServiceProductoCatalogoPersonalizado;
using System;
using System.Collections.Generic;
using System.Linq;

namespace Portal.Consultoras.Web.Controllers
{
    public class BaseEstrategiaController : BaseController
    {
        public List<BEEstrategia> ConsultarEstrategias(string cuv = "", int campaniaId = 0, string codAgrupacion = "")
        {
            //string varSession = Constantes.ConstSession.ListaEstrategia;
            //if (Session[varSession] != null && campaniaId == 0) return (List<BEEstrategia>)Session[varSession];

            codAgrupacion = Util.Trim(codAgrupacion);
            var listEstrategia = new List<BEEstrategia>();

            if (codAgrupacion != Constantes.TipoEstrategiaCodigo.Lanzamiento)
            {
                listEstrategia.AddRange(ConsultarEstrategiasPorTipo(Constantes.TipoEstrategiaCodigo.PackNuevas, campaniaId));
                listEstrategia.AddRange(ConsultarEstrategiasPorTipo(Constantes.TipoEstrategiaCodigo.OfertaWeb, campaniaId));
            }

            switch (codAgrupacion)
            {
                case Constantes.TipoEstrategiaCodigo.RevistaDigital:
                    listEstrategia.AddRange(ConsultarEstrategiasPorTipo(Constantes.TipoEstrategiaCodigo.Lanzamiento, campaniaId));
                    listEstrategia.AddRange(ConsultarEstrategiasPorTipo(Constantes.TipoEstrategiaCodigo.RevistaDigital, campaniaId));
                    break;
                case Constantes.TipoEstrategiaCodigo.Lanzamiento:
                    listEstrategia.AddRange(ConsultarEstrategiasPorTipo(Constantes.TipoEstrategiaCodigo.Lanzamiento, campaniaId));
                    break;
                default:
                    listEstrategia.AddRange(ConsultarEstrategiasPorTipo(Constantes.TipoEstrategiaCodigo.OfertaParaTi, campaniaId));
                    break;
            }

            listEstrategia = listEstrategia ?? new List<BEEstrategia>();

            //if (campaniaId > 0 || codAgrupacion == Constantes.TipoEstrategiaCodigo.RevistaDigital)
            //    return listEstrategia;

            //Session[varSession] = listEstrategia;
            return listEstrategia;
        }

        public List<BEEstrategia> ConsultarEstrategiasPorTipo(string tipo, int campaniaId = 0)
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
                    if (tipo == Constantes.TipoEstrategiaCodigo.PackNuevas && listEstrategia.Any())
                    {
                        listEstrategia = ConsultarEstrategiasFiltrarPackNuevasPedido(listEstrategia);
                    }

                    return listEstrategia;
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

                revistaDigital.SuscripcionModel.EMail = Util.Trim(revistaDigital.SuscripcionModel.EMail);
                revistaDigital.SuscripcionModel.EMail += "|" + tipo;

                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    listEstrategia = sv.GetEstrategiasPedido(entidad).ToList();
                }
                listEstrategia = listEstrategia ?? new List<BEEstrategia>();

                if (campaniaId == userData.CampaniaID)
                {
                    if (tipo == Constantes.TipoEstrategiaCodigo.PackNuevas
                        || tipo == Constantes.TipoEstrategiaCodigo.Lanzamiento
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
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
            return listEstrategia;
        }

        private List<BEEstrategia> ConsultarEstrategiasFiltrarPackNuevasPedido(List<BEEstrategia> listEstrategia)
        {
            var pedidoWebDetalle = ObtenerPedidoWebDetalle();
            listEstrategia = listEstrategia.Where(e => !pedidoWebDetalle.Any(d => d.CUV == e.CUV2)).ToList();

            return listEstrategia;
        }

        public List<BEEstrategia> ConsultarMasVendidos()
        {
            var entidad = new BEEstrategia
            {
                PaisID = userData.PaisID,
                CampaniaID = userData.CampaniaID,
                ConsultoraID = (userData.UsuarioPrueba == 1 ? userData.ConsultoraAsociadaID : userData.ConsultoraID).ToString(),
                Zona = userData.ZonaID.ToString(),
                ZonaHoraria = userData.ZonaHoraria,
                FechaInicioFacturacion = userData.FechaFinCampania,
                ValidarPeriodoFacturacion = true,
                Simbolo = userData.Simbolo,
            };

            var listEstrategia = new List<BEEstrategia>();
            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                listEstrategia = sv.GetMasVendidos(entidad).ToList();
            }
            listEstrategia = listEstrategia ?? new List<BEEstrategia>();

            return listEstrategia;
        }

        public EstrategiaPersonalizadaProductoModel EstrategiaGetDetalle(int id, string cuv = "")
        {
            var estrategiaModelo = new EstrategiaPersonalizadaProductoModel();

            try
            {
                estrategiaModelo = (EstrategiaPersonalizadaProductoModel)Session[Constantes.ConstSession.ProductoTemporal];
                if (estrategiaModelo == null || estrategiaModelo.EstrategiaID <= 0)
                    return estrategiaModelo;

                estrategiaModelo.Hermanos = new List<ProductoModel>();
                estrategiaModelo.TextoLibre = Util.Trim(estrategiaModelo.TextoLibre);
                estrategiaModelo.CodigoVariante = Util.Trim(estrategiaModelo.CodigoVariante);
                estrategiaModelo.UrlCompartir = GetUrlCompartirFB();

                var listaPedido = ObtenerPedidoWebDetalle();
                estrategiaModelo.IsAgregado = listaPedido.Any(p => p.CUV == estrategiaModelo.CUV2);

                if (estrategiaModelo.CodigoVariante == "")
                    return estrategiaModelo;

                string joinCuv = "|", separador = "|";

                estrategiaModelo.CampaniaID = estrategiaModelo.CampaniaID > 0 ? estrategiaModelo.CampaniaID : userData.CampaniaID;

                if (estrategiaModelo.CodigoVariante == Constantes.TipoEstrategiaSet.IndividualConTonos)
                {
                    var listaHermanosE = new List<BEProducto>();
                    using (ODSServiceClient svc = new ODSServiceClient())
                    {
                        listaHermanosE = svc.GetListBrothersByCUV(userData.PaisID, estrategiaModelo.CampaniaID, estrategiaModelo.CUV2).ToList();
                    }

                    foreach (var item in listaHermanosE)
                    {
                        item.CodigoSAP = Util.Trim(item.CodigoSAP);
                        if (item.CodigoSAP != "" && !joinCuv.Contains(separador + item.CodigoSAP + separador))
                            joinCuv += item.CodigoSAP + separador;
                    }
                }

                var listaProducto = new List<BEEstrategiaProducto>();
                if (estrategiaModelo.CodigoVariante == Constantes.TipoEstrategiaSet.CompuestaFija || estrategiaModelo.CodigoVariante == Constantes.TipoEstrategiaSet.CompuestaVariable)
                {
                    var estrategiaX = new EstrategiaPedidoModel() { PaisID = userData.PaisID, EstrategiaID = estrategiaModelo.EstrategiaID };
                    using (PedidoServiceClient svc = new PedidoServiceClient())
                    {
                        listaProducto = svc.GetEstrategiaProducto(Mapper.Map<EstrategiaPedidoModel, BEEstrategia>(estrategiaX)).ToList();
                    }

                    foreach (var item in listaProducto)
                    {
                        item.SAP = Util.Trim(item.SAP);
                        if (item.SAP != "" && !joinCuv.Contains(separador + item.SAP + separador))
                            joinCuv += item.SAP + separador;
                    }
                }

                if (joinCuv == separador) return estrategiaModelo;

                joinCuv = joinCuv.Substring(separador.Length, joinCuv.Length - separador.Length * 2);

                var listaAppCatalogo = new List<Producto>();
                using (ProductoServiceClient svc = new ProductoServiceClient())
                {
                    listaAppCatalogo = svc.ObtenerProductosByCodigoSap(userData.CodigoISO, estrategiaModelo.CampaniaID, joinCuv).ToList();
                }

                if (!listaAppCatalogo.Any()) return estrategiaModelo;

                var listaHermanos = Mapper.Map<List<Producto>, List<ProductoModel>>(listaAppCatalogo);

                if (estrategiaModelo.CodigoVariante == Constantes.TipoEstrategiaSet.IndividualConTonos)
                {
                    listaHermanos.ForEach(h =>
                    {
                        h.CUV = Util.Trim(h.CUV);
                        h.FactorCuadre = 1;
                    });
                    listaHermanos = listaHermanos.OrderBy(h => h.Orden).ToList();
                }
                if (estrategiaModelo.CodigoVariante == Constantes.TipoEstrategiaSet.CompuestaFija || estrategiaModelo.CodigoVariante == Constantes.TipoEstrategiaSet.CompuestaVariable)
                {
                    var listaHermanosX = new List<ProductoModel>();
                    listaProducto = listaProducto.OrderBy(p => p.Grupo).ToList();
                    listaHermanos = listaHermanos.OrderBy(p => p.CodigoProducto).ToList();

                    var idPk = 1;
                    listaHermanos.ForEach(h => h.ID = idPk++);

                    idPk = 0;
                    foreach (var item in listaProducto)
                    {
                        var prod = (ProductoModel)(listaHermanos.FirstOrDefault(p => item.SAP == p.CodigoProducto) ?? new ProductoModel()).Clone();
                        if (Util.Trim(prod.CodigoProducto) == "")
                            continue;

                        var listaIgual = listaHermanos.Where(p => item.SAP == p.CodigoProducto);
                        if (listaIgual.Count() > 1)
                        {
                            prod = (ProductoModel)(listaHermanos.FirstOrDefault(p => item.SAP == p.CodigoProducto && p.ID > idPk) ?? new ProductoModel()).Clone();
                        }

                        prod.Orden = item.Orden;
                        prod.Grupo = item.Grupo;
                        prod.PrecioCatalogo = item.Precio;
                        prod.PrecioCatalogoString = Util.DecimalToStringFormat(item.Precio, userData.CodigoISO);
                        prod.Digitable = item.Digitable;
                        prod.CUV = Util.Trim(item.CUV);
                        prod.Cantidad = item.Cantidad;
                        prod.FactorCuadre = item.FactorCuadre > 0 ? item.FactorCuadre : 1;
                        listaHermanosX.Add(prod);
                        idPk = prod.ID;
                    }

                    listaHermanos = listaHermanosX;

                    if (estrategiaModelo.CodigoVariante == Constantes.TipoEstrategiaSet.CompuestaFija)
                    {
                        listaHermanos.ForEach(h => { h.Digitable = 0; h.NombreComercial = Util.Trim(h.NombreComercial); });
                        listaHermanos = listaHermanos.Where(h => h.NombreComercial != "").ToList();
                    }
                    else if (estrategiaModelo.CodigoVariante == Constantes.TipoEstrategiaSet.CompuestaVariable)
                    {
                        var listaHermanosR = new List<ProductoModel>();
                        var hermano = new ProductoModel();
                        foreach (var item in listaHermanos)
                        {
                            hermano = (ProductoModel)item.Clone();
                            hermano.Hermanos = new List<ProductoModel>();
                            if (hermano.Digitable == 1)
                            {
                                var existe = false;
                                foreach (var itemR in listaHermanosR)
                                {
                                    existe = itemR.Hermanos.Any(h => h.CUV == hermano.CUV);
                                    if (existe) break;
                                }
                                if (existe) continue;

                                hermano.Hermanos = listaHermanos.Where(p => p.Grupo == hermano.Grupo).OrderBy(p => p.Orden).ToList();
                            }

                            listaHermanosR.Add(hermano);
                        }

                        listaHermanos = listaHermanosR.OrderBy(p => p.Orden).ToList();
                    }

                }

                #region Factor Cuadre

                var listaHermanosCuadre = new List<ProductoModel>();

                foreach (var hermano in listaHermanos)
                {
                    listaHermanosCuadre.Add((ProductoModel)hermano.Clone());

                    if (hermano.FactorCuadre > 1)
                    {
                        for (int i = 0; i < hermano.FactorCuadre - 1; i++)
                        {
                            listaHermanosCuadre.Add((ProductoModel)hermano.Clone());
                        }
                    }
                }

                #endregion

                //estrategiaModelo.Hermanos = listaHermanos ?? new List<ProductoModel>();
                estrategiaModelo.Hermanos = listaHermanosCuadre ?? new List<ProductoModel>();
            }
            catch (Exception ex)
            {
                estrategiaModelo = new EstrategiaPersonalizadaProductoModel();
                estrategiaModelo.Hermanos = new List<ProductoModel>();
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
            return estrategiaModelo;
        }

        public EstrategiaPersonalizadaProductoModel EstrategiaGetDetalleCuv(string cuv)
        {
            var estrategia = new EstrategiaPersonalizadaProductoModel();
            try
            {
                estrategia = EstrategiaGetDetalle(0, cuv);
            }
            catch (Exception ex)
            {
                estrategia = new EstrategiaPersonalizadaProductoModel();
                estrategia.Hermanos = new List<ProductoModel>();
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
            return estrategia;
        }

        public List<EstrategiaPedidoModel> ConsultarEstrategiasHomePedido(string cuv = "", string codAgrupacion = "")
        {
            var listModel = new List<BEEstrategia>();
            if (Session[Constantes.ConstSession.ListaEstrategia] != null)
                listModel = (List<BEEstrategia>)Session[Constantes.ConstSession.ListaEstrategia];
            else
            {
                listModel = ConsultarEstrategias(cuv, 0, codAgrupacion);

                if (!listModel.Any())
                {
                    Session[Constantes.ConstSession.ListaEstrategia] = listModel;
                    return new List<EstrategiaPedidoModel>();
                }

                #region Validar Tipo RD

                if (revistaDigital.TieneRDR || (revistaDigital.TieneRDC && revistaDigital.SuscripcionAnterior2Model.EstadoRegistro == 1))
                {
                    var estrategiaLanzamiento = listModel.FirstOrDefault(e => e.TipoEstrategia.Codigo == Constantes.TipoEstrategiaCodigo.Lanzamiento) ?? new BEEstrategia();

                    listModel = listModel.Where(e => e.TipoEstrategia.Codigo != Constantes.TipoEstrategiaCodigo.Lanzamiento).ToList();

                    if (!listModel.Any() && estrategiaLanzamiento.EstrategiaID <= 0)
                    {
                        Session[Constantes.ConstSession.ListaEstrategia] = listModel;
                        return new List<EstrategiaPedidoModel>();
                    }

                    var listaPackNueva = listModel.Where(e => e.TipoEstrategia.Codigo == Constantes.TipoEstrategiaCodigo.PackNuevas).ToList() ?? new List<BEEstrategia>();
                    var listaRevista = listModel.Where(e => e.TipoEstrategia.Codigo == Constantes.TipoEstrategiaCodigo.OfertasParaMi || e.TipoEstrategia.Codigo == Constantes.TipoEstrategiaCodigo.OfertaParaTi).ToList() ?? new List<BEEstrategia>();

                    var cantMax = 8;
                    var cantPack = listaPackNueva.Any() ? 1 : 0;
                    var top = Math.Min(cantMax - cantPack, listaRevista.Count());

                    if (listaRevista.Count() > top)
                        listaRevista.RemoveRange(top, listaRevista.Count() - top);

                    if (listaRevista.Count() > cantMax - top)
                        listaPackNueva.RemoveRange(cantMax - top, listaPackNueva.Count() - (cantMax - top));

                    listModel = new List<BEEstrategia>();
                    if (estrategiaLanzamiento.EstrategiaID > 0)
                        listModel.Add(estrategiaLanzamiento);

                    listModel.AddRange(listaPackNueva);
                    listModel.AddRange(listaRevista);
                    Session[Constantes.ConstSession.ListaEstrategia] = listModel;
                }
                #endregion

            }
            var listaProductoModel = ConsultarEstrategiasModelFormato(listModel);
            return listaProductoModel;
        }

        public List<EstrategiaPedidoModel> ConsultarEstrategiasModel(string cuv = "", int campaniaId = 0, string codAgrupacion = "")
        {
            var listaProducto = ConsultarEstrategias(cuv, campaniaId, codAgrupacion);

            List<EstrategiaPedidoModel> listaProductoModel = ConsultarEstrategiasModelFormato(listaProducto);

            return listaProductoModel;
        }

        public List<EstrategiaPedidoModel> ConsultarEstrategiasModelFormato(List<BEEstrategia> listaProducto)
        {
            listaProducto = listaProducto ?? new List<BEEstrategia>();
            List<EstrategiaPedidoModel> listaProductoModel = Mapper.Map<List<BEEstrategia>, List<EstrategiaPedidoModel>>(listaProducto);
            return ConsultarEstrategiasModelFormato(listaProductoModel);
        }

        public List<EstrategiaPedidoModel> ConsultarEstrategiasModelFormato(List<EstrategiaPedidoModel> listaProductoModel)
        {
            if (!listaProductoModel.Any())
                return listaProductoModel;

            var listaPedido = ObtenerPedidoWebDetalle();
            var carpetaPais = Globals.UrlMatriz + "/" + userData.CodigoISO;

            listaProductoModel.ForEach(estrategia =>
            {
                estrategia.ClaseBloqueada = estrategia.CampaniaID > 0 && estrategia.CampaniaID != userData.CampaniaID ? "btn_desactivado_general" : "";
                estrategia.IsAgregado = listaPedido.Any(p => p.CUV == estrategia.CUV2.Trim());
                estrategia.DescripcionResumen = "";
                estrategia.DescripcionDetalle = "";
                estrategia.EstrategiaDetalle = estrategia.EstrategiaDetalle ?? new EstrategiaDetalleModelo();

                if (estrategia.TipoEstrategia.Codigo == Constantes.TipoEstrategiaCodigo.Lanzamiento)
                {
                    #region Lanzamiento
                    estrategia.EstrategiaDetalle.ImgFondoDesktop = ConfigS3.GetUrlFileS3(carpetaPais, estrategia.EstrategiaDetalle.ImgFondoDesktop);
                    estrategia.EstrategiaDetalle.ImgPrevDesktop = ConfigS3.GetUrlFileS3(carpetaPais, estrategia.EstrategiaDetalle.ImgPrevDesktop);
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

                    var listadescr = estrategia.DescripcionCUV2.Split('|');
                    estrategia.DescripcionCortada = listadescr.Length > 0 ? listadescr[0] : "";
                    estrategia.DescripcionDetalle = listadescr.Length > 1 ? listadescr[1] : "";
                    estrategia.DescripcionResumen = "";
                }
                else
                {
                    estrategia.DescripcionCortada = Util.SubStrCortarNombre(estrategia.DescripcionCUV2, 40);
                };

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
                if (estrategia.TieneVariedad == 0)
                {
                    if (estrategia.TipoEstrategiaImagenMostrar == Constantes.TipoEstrategia.PackNuevas)
                    {
                        estrategia.PuedeCambiarCantidad = 0;
                    }
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

        public List<EstrategiaPersonalizadaProductoModel> ConsultarEstrategiasFormatearModelo(List<EstrategiaPedidoModel> listaProductoModel, int tipo = 0)
        {
            var listaRetorno = new List<EstrategiaPersonalizadaProductoModel>();
            if (!listaProductoModel.Any())
                return listaRetorno;

            var listaPedido = ObtenerPedidoWebDetalle();
            var carpetaPais = Globals.UrlMatriz + "/" + userData.CodigoISO;

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
                    || estrategia.TipoEstrategia.Codigo == Constantes.TipoEstrategiaCodigo.OfertasParaMi)
                    || (
                        (estrategia.TipoEstrategia.Codigo == Constantes.TipoEstrategiaCodigo.OfertaParaTi
                        || estrategia.TipoEstrategia.Codigo == Constantes.TipoEstrategiaCodigo.PackNuevas)
                        && (revistaDigital.TieneRDC || revistaDigital.TieneRDR))
                    || tipo == 1
                    ? "revistadigital-landing" : "";
                prodModel.FotoProducto01 = estrategia.FotoProducto01;
                prodModel.ImagenURL = estrategia.ImagenURL;
                prodModel.DescripcionMarca = estrategia.DescripcionMarca;
                prodModel.DescripcionResumen = estrategia.DescripcionResumen;
                prodModel.DescripcionCortada = estrategia.DescripcionCortada;
                prodModel.DescripcionDetalle = estrategia.DescripcionDetalle;
                prodModel.DescripcionCompleta = estrategia.DescripcionCUV2.Split('|')[0];
                prodModel.Simbolo = userData.Simbolo;
                prodModel.Precio = estrategia.Precio;
                prodModel.Precio2 = estrategia.Precio2;
                prodModel.PrecioTachado = estrategia.PrecioTachado;
                prodModel.PrecioVenta = estrategia.PrecioString;
                prodModel.ClaseBloqueada = tipo == 1 || (estrategia.CampaniaID > 0 && estrategia.CampaniaID != userData.CampaniaID) ? "btn_desactivado_general" : "";
                prodModel.ProductoPerdio = tipo == 1;
                prodModel.TipoEstrategiaID = estrategia.TipoEstrategiaID;
                prodModel.FlagNueva = estrategia.FlagNueva;
                prodModel.IsAgregado = listaPedido.Any(p => p.CUV == estrategia.CUV2.Trim());
                prodModel.ArrayContenidoSet = estrategia.FlagNueva == 1 ? estrategia.DescripcionCUV2.Split('|').Skip(1).ToList() : new List<string>();
                prodModel.ListaDescripcionDetalle = estrategia.ListaDescripcionDetalle ?? new List<string>();
                prodModel.TextoLibre = Util.Trim(estrategia.TextoLibre);

                prodModel.MarcaID = estrategia.MarcaID;
                prodModel.UrlCompartir = estrategia.UrlCompartir;

                prodModel.TienePaginaProducto = estrategia.PuedeVerDetalle;
                prodModel.TienePaginaProductoMob = estrategia.PuedeVerDetalleMob;
                prodModel.TieneVerDetalle = true;
                //estrategia.TipoEstrategia.Codigo == Constantes.TipoEstrategiaCodigo.PackNuevas
                //|| estrategia.TipoEstrategia.Codigo == Constantes.TipoEstrategiaCodigo.OfertaParaTi
                //|| estrategia.TipoEstrategia.Codigo == Constantes.TipoEstrategiaCodigo.Lanzamiento
                //|| estrategia.TipoEstrategia.Codigo == Constantes.TipoEstrategiaCodigo.OfertasParaMi
                //|| estrategia.TipoEstrategia.Codigo == Constantes.TipoEstrategiaCodigo.PackAltoDesembolso;

                prodModel.TipoAccionAgregar = estrategia.TieneVariedad == 0 ? estrategia.TipoEstrategia.Codigo == Constantes.TipoEstrategiaCodigo.PackNuevas ? 1 : 2 : 3;

                if (estrategia.TipoEstrategia.Codigo == Constantes.TipoEstrategiaCodigo.Lanzamiento)
                {
                    prodModel.TipoEstrategiaDetalle.ImgFondoDesktop = ConfigS3.GetUrlFileS3(carpetaPais, estrategia.EstrategiaDetalle.ImgFondoDesktop);
                    prodModel.TipoEstrategiaDetalle.ImgPrevDesktop = ConfigS3.GetUrlFileS3(carpetaPais, estrategia.EstrategiaDetalle.ImgPrevDesktop);
                    prodModel.TipoEstrategiaDetalle.ImgFichaDesktop = ConfigS3.GetUrlFileS3(carpetaPais, estrategia.EstrategiaDetalle.ImgFichaDesktop);
                    prodModel.TipoEstrategiaDetalle.ImgFichaFondoDesktop = ConfigS3.GetUrlFileS3(carpetaPais, estrategia.EstrategiaDetalle.ImgFichaFondoDesktop);
                    prodModel.TipoEstrategiaDetalle.UrlVideoDesktop = Util.Trim(estrategia.EstrategiaDetalle.UrlVideoDesktop);
                    prodModel.TipoEstrategiaDetalle.ImgFondoMobile = ConfigS3.GetUrlFileS3(carpetaPais, estrategia.EstrategiaDetalle.ImgFondoMobile);
                    prodModel.TipoEstrategiaDetalle.ImgFichaMobile = ConfigS3.GetUrlFileS3(carpetaPais, estrategia.EstrategiaDetalle.ImgFichaMobile);
                    prodModel.TipoEstrategiaDetalle.ImgFichaFondoMobile = ConfigS3.GetUrlFileS3(carpetaPais, estrategia.EstrategiaDetalle.ImgFichaFondoMobile);
                    prodModel.TipoEstrategiaDetalle.UrlVideoMobile = Util.Trim(estrategia.EstrategiaDetalle.UrlVideoMobile);
                    prodModel.TipoEstrategiaDetalle.ImgHomeDesktop = ConfigS3.GetUrlFileS3(carpetaPais, estrategia.EstrategiaDetalle.ImgHomeDesktop);
                    prodModel.TipoEstrategiaDetalle.ImgHomeMobile = ConfigS3.GetUrlFileS3(carpetaPais, estrategia.EstrategiaDetalle.ImgHomeMobile);
                }

                listaRetorno.Add(prodModel);
            });

            return listaRetorno;
        }

        public List<EstrategiaPedidoModel> ConsultarMasVendidosModel()
        {
            var listaProducto = ConsultarMasVendidos();
            var listaProductoModel = Mapper.Map<List<BEEstrategia>, List<EstrategiaPedidoModel>>(listaProducto);
            listaProductoModel = ConsultarEstrategiasModelFormato(listaProductoModel);
            return listaProductoModel;
        }
    }
}