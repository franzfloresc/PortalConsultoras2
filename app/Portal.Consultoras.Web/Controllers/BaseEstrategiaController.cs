﻿using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceODS;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServiceProductoCatalogoPersonalizado;
using Portal.Consultoras.Web.ServicePROLConsultas;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;

namespace Portal.Consultoras.Web.Controllers
{
    public class BaseEstrategiaController : BaseController
    {
        public List<BEEstrategia> ConsultarEstrategias(string cuv)
        {
            List<BEEstrategia> lst = new List<BEEstrategia>();

            if (Session["ListadoEstrategiaPedido"] != null)
            {
                lst = (List<BEEstrategia>)Session["ListadoEstrategiaPedido"];
                return lst;
            }

            var entidad = new BEEstrategia();
            entidad.PaisID = userData.PaisID;
            entidad.CampaniaID = userData.CampaniaID;
            entidad.ConsultoraID = userData.UsuarioPrueba == 1 ? userData.ConsultoraAsociadaID.ToString() : userData.ConsultoraID.ToString();
            entidad.CUV2 = cuv ?? "";
            entidad.Zona = userData.ZonaID.ToString();

            var listaTemporal = new List<BEEstrategia>();

            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                listaTemporal = sv.GetEstrategiasPedido(entidad).ToList();
            }
            listaTemporal = listaTemporal ?? new List<BEEstrategia>();

            if (listaTemporal.Count == 0)
            {
                Session["ListadoEstrategiaPedido"] = lst;
                return lst;
            }

            var codigoISO = userData.CodigoISO;
            var simbolo = userData.Simbolo;
            var fechaHoy = DateTime.Now.AddHours(userData.ZonaHoraria).Date;
            bool esFacturacion = fechaHoy >= userData.FechaInicioCampania.Date;

            string carpetapais = Globals.UrlMatriz + "/" + userData.CodigoISO;

            if (esFacturacion)
            {
                /*Obtener si tiene stock de PROL por CodigoSAP*/
                string codigoSap = "";
                foreach (var beEstrategia in listaTemporal)
                {
                    if (!string.IsNullOrEmpty(beEstrategia.CodigoProducto))
                        codigoSap += beEstrategia.CodigoProducto + "|";
                }

                codigoSap = codigoSap == "" ? "" : codigoSap.Substring(0, codigoSap.Length - 1);

                var listaTieneStock = new List<Lista>();

                try
                {
                    if (!string.IsNullOrEmpty(codigoSap))
                    {
                        using (var sv = new wsConsulta())
                        {
                            sv.Url = ConfigurationManager.AppSettings["RutaServicePROLConsultas"];
                            listaTieneStock = sv.ConsultaStock(codigoSap, userData.CodigoISO).ToList();
                        }
                    }
                }
                catch (Exception ex)
                {
                    LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                    listaTieneStock = new List<Lista>();
                }

                foreach (var beEstrategia in listaTemporal)
                {
                    var add = true;
                    if (beEstrategia.TipoEstrategiaImagenMostrar == Constantes.TipoEstrategia.OfertaParaTi)
                    {
                        add = false;
                        var itemStockProl = listaTieneStock.FirstOrDefault(p => p.Codsap.ToString() == beEstrategia.CodigoProducto);
                        if (itemStockProl != null)
                            add = itemStockProl.estado == 1;
                    }

                    if (add)
                    {
                        beEstrategia.FotoProducto01 = ConfigS3.GetUrlFileS3(carpetapais, beEstrategia.FotoProducto01, carpetapais);
                        beEstrategia.ImagenURL = ConfigS3.GetUrlFileS3(carpetapais, beEstrategia.ImagenURL, carpetapais);
                        beEstrategia.Simbolo = userData.Simbolo;
                        beEstrategia.TieneStockProl = true;
                        beEstrategia.PrecioString = Util.DecimalToStringFormat(beEstrategia.Precio2, userData.CodigoISO);
                        beEstrategia.PrecioTachado = Util.DecimalToStringFormat(beEstrategia.Precio, userData.CodigoISO);

                        lst.Add(beEstrategia);
                    }
                }
            }
            else
            {
                listaTemporal.Update(x =>
                {
                    x.FotoProducto01 = ConfigS3.GetUrlFileS3(carpetapais, x.FotoProducto01, carpetapais);
                    x.ImagenURL = ConfigS3.GetUrlFileS3(carpetapais, x.ImagenURL, carpetapais);
                    x.Simbolo = userData.Simbolo;
                    x.TieneStockProl = true;
                    x.PrecioString = Util.DecimalToStringFormat(x.Precio2, userData.CodigoISO);
                    x.PrecioTachado = Util.DecimalToStringFormat(x.Precio, userData.CodigoISO);
                });

                lst.AddRange(listaTemporal);
            }

            Session["ListadoEstrategiaPedido"] = lst;


            return lst;
        }

        public EstrategiaPedidoModel EstrategiaGetDetalle(int id)
        {
            var estrategia = new EstrategiaPedidoModel();
            estrategia.Hermanos = new List<ProductoModel>();

            try
            {
                var lista = ConsultarEstrategias("") ?? new List<BEEstrategia>();
                estrategia = Mapper.Map<BEEstrategia, EstrategiaPedidoModel>(lista.Find(e => e.EstrategiaID == id) ?? new BEEstrategia());
                estrategia.Hermanos = new List<ProductoModel>();
                estrategia.PaisID = userData.PaisID;
                estrategia.DescripcionCUV2 = Util.Trim(estrategia.DescripcionCUV2);
                estrategia.Descripcion = estrategia.DescripcionCUV2.Split('|')[0];
                estrategia.TextoLibre = Util.Trim(estrategia.TextoLibre);
                estrategia.CodigoEstrategia = Util.Trim(estrategia.CodigoEstrategia);
                estrategia.UrlCompartirFB = GetUrlCompartirFB();

                var listaPedido = ObtenerPedidoWebDetalle();
                estrategia.IsAgregado = listaPedido.Any(p => p.CUV == estrategia.CUV2);

                if (estrategia.CodigoEstrategia == "")
                    return estrategia;

                string joinCuv = "";

                if (estrategia.CodigoEstrategia == Constantes.TipoEstrategiaSet.IndividualConTonos)
                {
                    var listaHermanosE = new List<BEProducto>();
                    using (ODSServiceClient svc = new ODSServiceClient())
                    {
                        listaHermanosE = svc.GetListBrothersByCUV(userData.PaisID, userData.CampaniaID, estrategia.CUV2).ToList();
                    }

                    foreach (var item in listaHermanosE)
                    {
                        joinCuv += item.CodigoSAP + "|";
                    }
                }

                var listaProducto = new List<BEEstrategiaProducto>();
                if (estrategia.CodigoEstrategia == Constantes.TipoEstrategiaSet.CompuestaFija || estrategia.CodigoEstrategia == Constantes.TipoEstrategiaSet.CompuestaVariable)
                {
                    estrategia.PaisID = userData.PaisID;
                    using (PedidoServiceClient svc = new PedidoServiceClient())
                    {
                        listaProducto = svc.GetEstrategiaProducto(Mapper.Map<EstrategiaPedidoModel, BEEstrategia>(estrategia)).ToList();
                    }

                    foreach (var item in listaProducto)
                    {
                        joinCuv += item.SAP + "|";
                    }
                }

                if (joinCuv == "") return estrategia;

                joinCuv = joinCuv.Substring(0, joinCuv.Length - 1);

                var listaAppCatalogo = new List<Producto>();
                using (ProductoServiceClient svc = new ProductoServiceClient())
                {
                    listaAppCatalogo = svc.ObtenerProductosByCodigoSap(userData.CodigoISO, userData.CampaniaID, joinCuv).ToList();
                }

                if (!listaAppCatalogo.Any()) return estrategia;

                var listaHermanos = Mapper.Map<List<Producto>, List<ProductoModel>>(listaAppCatalogo);

                if (estrategia.CodigoEstrategia == Constantes.TipoEstrategiaSet.IndividualConTonos)
                {
                    listaHermanos.ForEach(h =>
                    {
                        h.CUV = Util.Trim(h.CUV);
                    });
                    listaHermanos = listaHermanos.OrderBy(h => h.Orden).ToList();
                }
                if (estrategia.CodigoEstrategia == Constantes.TipoEstrategiaSet.CompuestaFija || estrategia.CodigoEstrategia == Constantes.TipoEstrategiaSet.CompuestaVariable)
                {
                    //listaHermanos.ForEach(h =>
                    //{
                    //    var prod = listaProducto.Find(p => p.SAP == h.CodigoProducto) ?? new BEEstrategiaProducto();
                    //    h.Orden = prod.Orden;
                    //    h.Grupo = prod.Grupo;
                    //    h.PrecioCatalogo = prod.Precio;
                    //    h.PrecioCatalogoString = Util.DecimalToStringFormat(prod.Precio, userData.CodigoISO);
                    //    h.Digitable = prod.Digitable;
                    //    h.CUV = Util.Trim(prod.CUV);
                    //    h.Cantidad = prod.Cantidad;
                    //});

                    var listaHermanosX = new List<ProductoModel>();
                    listaProducto = listaProducto.OrderBy(p=>p.Grupo).ToList();
                    listaHermanos = listaHermanos.OrderBy(p=>p.CodigoProducto).ToList();

                    var idPk = 1;
                    listaHermanos.Update(h => h.ID = idPk++);

                    idPk = 0;
                    foreach (var item in listaProducto)
                    {
                        var prod = (ProductoModel)(listaHermanos.FirstOrDefault(p => item.SAP == p.CodigoProducto) ?? new ProductoModel()).Clone();
                        if (Util.Trim(prod.CodigoProducto) == "")
                            continue;

                        var listaIgual = listaHermanos.Where(p => item.SAP == p.CodigoProducto);
                        if (listaIgual.Count() > 1)
                        {
                            //var existe = listaHermanosX.FirstOrDefault(p => item.SAP == p.CodigoProducto && p.Grupo == item.Grupo) ?? new ProductoModel();
                            //if (Util.Trim(existe.CodigoProducto) != "")
                            //    prod = (ProductoModel)(listaHermanos.FirstOrDefault(p => item.SAP == p.CodigoProducto && p.Grupo == item.Grupo && p.ID > idPk) ?? new ProductoModel()).Clone();
                            //else
                                prod = (ProductoModel)(listaHermanos.FirstOrDefault(p => item.SAP == p.CodigoProducto && p.ID > idPk) ?? new ProductoModel()).Clone();
                        }

                        prod.Orden = item.Orden;
                        prod.Grupo = item.Grupo;
                        prod.PrecioCatalogo = item.Precio;
                        prod.PrecioCatalogoString = Util.DecimalToStringFormat(item.Precio, userData.CodigoISO);
                        prod.Digitable = item.Digitable;
                        prod.CUV = Util.Trim(item.CUV);
                        prod.Cantidad = item.Cantidad;
                        listaHermanosX.Add(prod);
                        idPk = prod.ID;
                    }

                    listaHermanos = listaHermanosX;

                    if (estrategia.CodigoEstrategia == Constantes.TipoEstrategiaSet.CompuestaFija)
                    {
                        listaHermanos.Update(h => h.Digitable = 0);
                    }
                    else if (estrategia.CodigoEstrategia == Constantes.TipoEstrategiaSet.CompuestaVariable)
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

                estrategia.Hermanos = listaHermanos ?? new List<ProductoModel>();
            }
            catch (Exception ex)
            {
                estrategia = new EstrategiaPedidoModel();
                estrategia.Hermanos = new List<ProductoModel>();
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
            return estrategia;
        }

        public EstrategiaPedidoModel EstrategiaGetDetalleCuv(string cuv)
        {
            var estrategia = new EstrategiaPedidoModel();
            try
            {
                var lista = ConsultarEstrategias("") ?? new List<BEEstrategia>();
                estrategia = Mapper.Map<BEEstrategia, EstrategiaPedidoModel>(lista.FirstOrDefault(e => e.CUV2 == cuv) ?? new BEEstrategia());
                estrategia = EstrategiaGetDetalle(estrategia.EstrategiaID);
            }
            catch (Exception ex)
            {
                estrategia = new EstrategiaPedidoModel();
                estrategia.Hermanos = new List<ProductoModel>();
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
            return estrategia;
        }
    }
}