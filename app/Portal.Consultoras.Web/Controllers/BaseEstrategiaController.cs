using AutoMapper;
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
using Org.BouncyCastle.Utilities;

namespace Portal.Consultoras.Web.Controllers
{
    public class BaseEstrategiaController : BaseController
    {
        public List<BEEstrategia> ConsultarEstrategias(string cuv, int campaniaID = 0)
        {
            if (Session["ListadoEstrategiaPedido"] != null) return (List<BEEstrategia>)Session["ListadoEstrategiaPedido"];

            var usuario = ObtenerUsuarioConfiguracion();            
            var entidad = new BEEstrategia
            {
                PaisID = userData.PaisID,
                CampaniaID = campaniaID > 0 ? campaniaID : userData.CampaniaID,
                ConsultoraID = (userData.UsuarioPrueba == 1 ? userData.ConsultoraAsociadaID : userData.ConsultoraID).ToString(),
                CUV2 = cuv ?? "",
                Zona = userData.ZonaID.ToString(),
                ZonaHoraria = usuario.ZonaHoraria,
                FechaInicioFacturacion = usuario.FechaInicioFacturacion,
                ValidarPeriodoFacturacion = true,
                Simbolo = userData.Simbolo,
                CodigoAgrupacion = ""
            };            
            if (ValidarPermiso(Constantes.MenuCodigo.RevistaDigital)) entidad.CodigoAgrupacion = Constantes.TipoEstrategiaCodigo.RevistaDigital;

            var listEstrategia = new List<BEEstrategia>();
            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                listEstrategia = sv.GetEstrategiasPedido(entidad).ToList();
            }
            listEstrategia = listEstrategia ?? new List<BEEstrategia>();
            
            listEstrategia = listEstrategia.Where(e => e.Precio2 > 0).ToList();
            listEstrategia.Where(e => e.Precio <= e.Precio2).ToList().ForEach(e => {
                e.Precio = 0;
                e.PrecioTachado = Util.DecimalToStringFormat(e.Precio, userData.CodigoISO);
            });
            
            Session["ListadoEstrategiaPedido"] = listEstrategia;
            return listEstrategia;
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

        public List<EstrategiaPedidoModel> ConsultarEstrategiasModel(string cuv = "")
        {
            var listaProducto = ConsultarEstrategias(cuv);
            var ListaProductoModel = Mapper.Map<List<BEEstrategia>, List<EstrategiaPedidoModel>>(listaProducto);

            var listaPedido = ObtenerPedidoWebDetalle();
            var carpetaPais = Globals.UrlMatriz + "/" + userData.CodigoISO;

            var isMobile = IsMobile();
            ListaProductoModel.ForEach(estrategia =>
            {
                estrategia.IsAgregado = listaPedido.Any(p => p.CUV == estrategia.CUV2.Trim());
                estrategia.EstrategiaDetalle = estrategia.EstrategiaDetalle ?? new EstrategiaDetalleModelo();
                estrategia.EstrategiaDetalle.ImgFondoDesktop =  ConfigS3.GetUrlFileS3(carpetaPais, estrategia.EstrategiaDetalle.ImgFondoDesktop);
                estrategia.EstrategiaDetalle.ImgPrevDesktop =   ConfigS3.GetUrlFileS3(carpetaPais, estrategia.EstrategiaDetalle.ImgPrevDesktop);
                estrategia.EstrategiaDetalle.ImgFichaDesktop =  ConfigS3.GetUrlFileS3(carpetaPais, estrategia.EstrategiaDetalle.ImgFichaDesktop);
                estrategia.EstrategiaDetalle.ImgFichaFondoDesktop =  ConfigS3.GetUrlFileS3(carpetaPais, estrategia.EstrategiaDetalle.ImgFichaFondoDesktop);
                estrategia.EstrategiaDetalle.UrlVideoDesktop = Util.Trim(estrategia.EstrategiaDetalle.UrlVideoDesktop);
                estrategia.EstrategiaDetalle.ImgFondoMobile = ConfigS3.GetUrlFileS3(carpetaPais, estrategia.EstrategiaDetalle.ImgFondoMobile);
                estrategia.EstrategiaDetalle.ImgFichaMobile = ConfigS3.GetUrlFileS3(carpetaPais, estrategia.EstrategiaDetalle.ImgFichaMobile);
                estrategia.EstrategiaDetalle.ImgFichaFondoMobile = ConfigS3.GetUrlFileS3(carpetaPais, estrategia.EstrategiaDetalle.ImgFichaFondoMobile);
                estrategia.EstrategiaDetalle.UrlVideoMobile = Util.Trim(estrategia.EstrategiaDetalle.UrlVideoMobile);

                estrategia.EstrategiaDetalle.ImgFondoDesktop = isMobile ? "" : estrategia.EstrategiaDetalle.ImgFondoDesktop;
                estrategia.EstrategiaDetalle.ImgPrevDesktop = isMobile ? "" : estrategia.EstrategiaDetalle.ImgPrevDesktop;
                estrategia.EstrategiaDetalle.ImgFichaDesktop = isMobile ? estrategia.EstrategiaDetalle.ImgFichaMobile : estrategia.EstrategiaDetalle.ImgFichaDesktop;
                estrategia.EstrategiaDetalle.ImgFichaFondoDesktop = isMobile ? estrategia.EstrategiaDetalle.ImgFichaFondoMobile : estrategia.EstrategiaDetalle.ImgFichaFondoDesktop;
                estrategia.EstrategiaDetalle.UrlVideoDesktop = isMobile ? estrategia.EstrategiaDetalle.UrlVideoMobile : estrategia.EstrategiaDetalle.UrlVideoDesktop;

                estrategia.DescripcionResumen = "";
                estrategia.DescripcionDetalle = "";
                if (estrategia.TipoEstrategia.Codigo == Constantes.TipoEstrategiaCodigo.Lanzamiento)
                {
                    var listadescr = estrategia.DescripcionCUV2.Split('|');
                    estrategia.DescripcionResumen = listadescr.Length > 0 ? listadescr[0] : "";
                    estrategia.DescripcionCortada = listadescr.Length > 1 ? listadescr[1] : "";
                    if (listadescr.Length > 2)
                    {
                        estrategia.ListaDescripcionDetalle = new List<string>(listadescr.Skip(2));
                        estrategia.DescripcionDetalle = string.Join("<br />", listadescr.Skip(2));
                    }
                    estrategia.DescripcionCortada = Util.SubStrCortarNombre(estrategia.DescripcionCortada, 40);
                }
                else if (estrategia.FlagNueva == 1)
                {
                    estrategia.DescripcionResumen = estrategia.DescripcionCUV2.Split('|')[0];
                    estrategia.DescripcionDetalle = estrategia.DescripcionCUV2.Split('|')[1];
                    estrategia.DescripcionCortada = estrategia.DescripcionResumen;
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
            });

            return ListaProductoModel;
        }
    }
}