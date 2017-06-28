using AutoMapper;
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
            string varSession = Constantes.SessionNames.ListaEstrategia;// + (campaniaId > 0 ? campaniaId.ToString() : "");
            if (Session[varSession] != null && campaniaId == 0) return (List<BEEstrategia>)Session[varSession];

            //var usuario = ObtenerUsuarioConfiguracion();            
            var entidad = new BEEstrategia
            {
                PaisID = userData.PaisID,
                CampaniaID = campaniaId > 0 ? campaniaId : userData.CampaniaID,
                ConsultoraID = (userData.UsuarioPrueba == 1 ? userData.ConsultoraAsociadaID : userData.ConsultoraID).ToString(),
                CUV2 = Util.Trim(cuv),
                Zona = userData.ZonaID.ToString(),
                ZonaHoraria = userData.ZonaHoraria,
                FechaInicioFacturacion = userData.FechaFinCampania,
                ValidarPeriodoFacturacion = true,
                Simbolo = userData.Simbolo,
                CodigoAgrupacion = Util.Trim(codAgrupacion)
            };

            var listEstrategia = new List<BEEstrategia>();
            
            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                listEstrategia = sv.GetEstrategiasPedido(entidad).ToList();
            }
            listEstrategia = listEstrategia ?? new List<BEEstrategia>();
            

            // Filtrar precio cero o precio de oferta mayor al precio normal.
            listEstrategia = listEstrategia.Where(e => e.Precio2 > 0).ToList();
            listEstrategia.Where(e => e.Precio <= e.Precio2).ToList().ForEach(e => {
                e.Precio = 0;
                e.PrecioTachado = Util.DecimalToStringFormat(e.Precio, userData.CodigoISO);
            });

            if (campaniaId > 0 || codAgrupacion == Constantes.TipoEstrategiaCodigo.RevistaDigital)
            {
                return listEstrategia;
            }

            Session[varSession] = listEstrategia;
            return listEstrategia;
        }
        
        public EstrategiaPedidoModel EstrategiaGetDetalle(int id, string cuv = "")
        {
            var estrategia = new EstrategiaPedidoModel();
            estrategia.Hermanos = new List<ProductoModel>();

            try
            {
                if (Session[Constantes.SessionNames.ProductoTemporal] != null)
                {
                    estrategia = (EstrategiaPedidoModel)Session[Constantes.SessionNames.ProductoTemporal];

                    var lista = new List<EstrategiaPedidoModel>() { estrategia };
                    estrategia = ConsultarEstrategiasModelFormato(lista)[0];
                }
                
                if (estrategia.EstrategiaID <= 0)
                {
                    var lista = ConsultarEstrategias();
                    cuv = Util.Trim(cuv);
                    estrategia = Mapper.Map<BEEstrategia, EstrategiaPedidoModel>(lista.Find(e => e.EstrategiaID == id || (e.CUV2 == cuv && cuv != "")) ?? new BEEstrategia());
                }

                estrategia.Hermanos = new List<ProductoModel>();
                estrategia.PaisID = userData.PaisID;
                estrategia.DescripcionCUV2 = Util.Trim(estrategia.DescripcionCUV2);
                estrategia.Descripcion = estrategia.DescripcionCUV2.Split('|')[0];
                estrategia.TextoLibre = Util.Trim(estrategia.TextoLibre);
                estrategia.CodigoEstrategia = Util.Trim(estrategia.CodigoEstrategia);
                estrategia.UrlCompartir = GetUrlCompartirFB();

                var listaPedido = ObtenerPedidoWebDetalle();
                estrategia.IsAgregado = listaPedido.Any(p => p.CUV == estrategia.CUV2);

                if (estrategia.CodigoEstrategia == "")
                    return estrategia;

                string joinCuv = "|", separador = "|";

                estrategia.CampaniaID = estrategia.CampaniaID > 0 ? estrategia.CampaniaID : userData.CampaniaID;

                if (estrategia.CodigoEstrategia == Constantes.TipoEstrategiaSet.IndividualConTonos)
                {
                    var listaHermanosE = new List<BEProducto>();
                    using (ODSServiceClient svc = new ODSServiceClient())
                    {
                        listaHermanosE = svc.GetListBrothersByCUV(userData.PaisID, estrategia.CampaniaID, estrategia.CUV2).ToList();
                    }

                    foreach (var item in listaHermanosE)
                    {
                        item.CodigoSAP = Util.Trim(item.CodigoSAP);
                        if (item.CodigoSAP != "" && !joinCuv.Contains(separador + item.CodigoSAP + separador))
                            joinCuv += item.CodigoSAP + separador;
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
                        item.SAP = Util.Trim(item.SAP);
                        if (item.SAP != "" && !joinCuv.Contains(separador + item.SAP + separador))
                            joinCuv += item.SAP + separador;
                    }
                }

                if (joinCuv == separador) return estrategia;

                joinCuv = joinCuv.Substring(separador.Length, joinCuv.Length - separador.Length * 2);

                var listaAppCatalogo = new List<Producto>();
                using (ProductoServiceClient svc = new ProductoServiceClient())
                {
                    listaAppCatalogo = svc.ObtenerProductosByCodigoSap(userData.CodigoISO, estrategia.CampaniaID, joinCuv).ToList();
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
                        listaHermanos.ForEach(h => h.Digitable = 0);
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
                estrategia = EstrategiaGetDetalle(0, cuv);
            }
            catch (Exception ex)
            {
                estrategia = new EstrategiaPedidoModel();
                estrategia.Hermanos = new List<ProductoModel>();
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
            return estrategia;
        }

        public List<EstrategiaPedidoModel> ConsultarEstrategiasFiltrarSegunTipo(string cuv = "", string codAgrupacion = "")
        {
            var listModel = new List<BEEstrategia>();
            if (Session[Constantes.SessionNames.ListaEstrategia] != null)
                listModel = (List<BEEstrategia>)Session[Constantes.SessionNames.ListaEstrategia];
            else
            {
                listModel = ConsultarEstrategias(cuv, 0, codAgrupacion);

                if (!listModel.Any())
                {
                    Session[Constantes.SessionNames.ListaEstrategia] = listModel;
                    return new List<EstrategiaPedidoModel>();
                }

                #region Validar Tipo
                if (userData.RevistaDigital.TieneRDR)
                {
                    listModel = listModel.Where(e => e.TipoEstrategia.Codigo != Constantes.TipoEstrategiaCodigo.Lanzamiento).ToList() ?? new List<BEEstrategia>();
                    var top = listModel.Count();

                    top = Math.Min(top, 4);

                    if (top <= 0)
                    {
                        Session[Constantes.SessionNames.ListaEstrategia] = listModel;
                        return new List<EstrategiaPedidoModel>();
                    }

                    var estrategiaPackNuevas = listModel.FirstOrDefault(e => e.TipoEstrategia.Codigo == Constantes.TipoEstrategiaCodigo.PackNuevas) ?? new BEEstrategia();
                    var listaDemas = listModel.Where(e => e.TipoEstrategia.Codigo == Constantes.TipoEstrategiaCodigo.OfertasParaMi).ToList() ?? new List<BEEstrategia>();

                    listModel = new List<BEEstrategia>();
                    if (estrategiaPackNuevas.EstrategiaID > 0)
                    {
                        top--;
                        listModel.Add(estrategiaPackNuevas);
                    }

                    if (listaDemas.Count() > top)
                        listaDemas.RemoveRange(top, listaDemas.Count() - top);
                    
                    listModel.AddRange(listaDemas);
                    Session[Constantes.SessionNames.ListaEstrategia] = listModel;
                }
                else if (userData.RevistaDigital.TieneRDC && userData.RevistaDigital.SuscripcionAnterior2Model.EstadoRegistro == 1)
                {
                    var estrategiaLanzamiento = listModel.FirstOrDefault(e => e.TipoEstrategia.Codigo == Constantes.TipoEstrategiaCodigo.Lanzamiento) ?? new BEEstrategia();

                    listModel = listModel.Where(e => e.TipoEstrategia.Codigo != Constantes.TipoEstrategiaCodigo.Lanzamiento).ToList();
                    var top = listModel.Count();

                    top = Math.Min(top, 4);

                    if (top <= 0)
                    {
                        Session[Constantes.SessionNames.ListaEstrategia] = listModel;
                        return new List<EstrategiaPedidoModel>();
                    }

                    var estrategiaPackNuevas = listModel.FirstOrDefault(e => e.TipoEstrategia.Codigo == Constantes.TipoEstrategiaCodigo.PackNuevas) ?? new BEEstrategia();
                    var listaDemas = listModel.Where(e => e.TipoEstrategia.Codigo == Constantes.TipoEstrategiaCodigo.OfertasParaMi).ToList() ?? new List<BEEstrategia>();

                    listModel = new List<BEEstrategia>();
                    //if (estrategiaLanzamiento.EstrategiaID > 0)
                    //{
                    //    top--;
                    //    listModel.Add(estrategiaLanzamiento);
                    //}
                    if (estrategiaPackNuevas.EstrategiaID > 0)
                    {
                        top--;
                        listModel.Add(estrategiaPackNuevas);
                    }

                    if (listaDemas.Count() > top)
                        listaDemas.RemoveRange(top, listaDemas.Count() - top);
                    
                    listModel.AddRange(listaDemas);
                    Session[Constantes.SessionNames.ListaEstrategia] = listModel;
                }
                #endregion

            }
            var listaProductoModel = ConsultarEstrategiasModelFormato(listModel);
            if (userData.RevistaDigital.TieneRDR ||(userData.RevistaDigital.TieneRDC && userData.RevistaDigital.SuscripcionAnterior2Model.EstadoRegistro == 1))
            {
                if (IsMobile() && listaProductoModel.Any())
                {
                    listaProductoModel = listaProductoModel.Take(1).ToList();
                }
            }
            return listaProductoModel;
        }

        public List<EstrategiaPedidoModel> ConsultarEstrategiasModel(string cuv = "", int campaniaId = 0, string codAgrupacion = "")
        {
            var listaProducto = ConsultarEstrategias(cuv, campaniaId, codAgrupacion);

            List<EstrategiaPedidoModel> listaProductoModel = ConsultarEstrategiasModelFormato(listaProducto);
            
            return listaProductoModel;
        }

        private List<EstrategiaPedidoModel> ConsultarEstrategiasModelFormato(List<BEEstrategia> listaProducto)
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

            bool isMobile = ViewBag.EsMobile == 2;// IsMobile();
            listaProductoModel.ForEach(estrategia =>
            {
                estrategia.ClaseBloqueada = estrategia.CampaniaID > 0 && estrategia.CampaniaID != userData.CampaniaID ? "btn_desactivado_general" : "";
                estrategia.IsAgregado = listaPedido.Any(p => p.CUV == estrategia.CUV2.Trim());
                estrategia.DescripcionResumen = "";
                estrategia.DescripcionDetalle = "";
                estrategia.EstrategiaDetalle = estrategia.EstrategiaDetalle ?? new EstrategiaDetalleModelo();

                if (estrategia.TipoEstrategia.Codigo == Constantes.TipoEstrategiaCodigo.Lanzamiento)
                {
                    estrategia.EstrategiaDetalle.ImgFondoDesktop = ConfigS3.GetUrlFileS3(carpetaPais, estrategia.EstrategiaDetalle.ImgFondoDesktop);
                    estrategia.EstrategiaDetalle.ImgPrevDesktop = ConfigS3.GetUrlFileS3(carpetaPais, estrategia.EstrategiaDetalle.ImgPrevDesktop);
                    estrategia.EstrategiaDetalle.ImgFichaDesktop = ConfigS3.GetUrlFileS3(carpetaPais, estrategia.EstrategiaDetalle.ImgFichaDesktop);
                    estrategia.EstrategiaDetalle.ImgFichaFondoDesktop = ConfigS3.GetUrlFileS3(carpetaPais, estrategia.EstrategiaDetalle.ImgFichaFondoDesktop);
                    estrategia.EstrategiaDetalle.UrlVideoDesktop = Util.Trim(estrategia.EstrategiaDetalle.UrlVideoDesktop);
                    estrategia.EstrategiaDetalle.ImgFondoMobile = ConfigS3.GetUrlFileS3(carpetaPais, estrategia.EstrategiaDetalle.ImgFondoMobile);
                    estrategia.EstrategiaDetalle.ImgFichaMobile = ConfigS3.GetUrlFileS3(carpetaPais, estrategia.EstrategiaDetalle.ImgFichaMobile);
                    estrategia.EstrategiaDetalle.ImgFichaFondoMobile = ConfigS3.GetUrlFileS3(carpetaPais, estrategia.EstrategiaDetalle.ImgFichaFondoMobile);
                    estrategia.EstrategiaDetalle.UrlVideoMobile = Util.Trim(estrategia.EstrategiaDetalle.UrlVideoMobile);

                    //estrategia.EstrategiaDetalle.ImgFondoDesktop = isMobile ? "" : estrategia.EstrategiaDetalle.ImgFondoDesktop;
                    //estrategia.EstrategiaDetalle.ImgPrevDesktop = isMobile ? "" : estrategia.EstrategiaDetalle.ImgPrevDesktop;
                    //estrategia.EstrategiaDetalle.ImgFichaDesktop = isMobile ? estrategia.EstrategiaDetalle.ImgFichaMobile : estrategia.EstrategiaDetalle.ImgFichaDesktop;
                    //estrategia.EstrategiaDetalle.ImgFichaFondoDesktop = isMobile ? estrategia.EstrategiaDetalle.ImgFichaFondoMobile : estrategia.EstrategiaDetalle.ImgFichaFondoDesktop;
                    //estrategia.EstrategiaDetalle.UrlVideoDesktop = isMobile ? estrategia.EstrategiaDetalle.UrlVideoMobile : estrategia.EstrategiaDetalle.UrlVideoDesktop;

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
                estrategia.PuedeVerDetalle = estrategia.EstrategiaDetalle != null &&
                                                ((estrategia.ListaDescripcionDetalle != null && estrategia.ListaDescripcionDetalle.Any()) ||
                                                !estrategia.EstrategiaDetalle.UrlVideoDesktop.IsNullOrEmptyTrim());
                estrategia.PuedeVerDetalleMob = estrategia.EstrategiaDetalle != null &&
                                             ((estrategia.ListaDescripcionDetalle != null && estrategia.ListaDescripcionDetalle.Any()) ||
                                              !estrategia.EstrategiaDetalle.UrlVideoMobile.IsNullOrEmptyTrim());
            });
            
            return listaProductoModel;
        }
    }
}