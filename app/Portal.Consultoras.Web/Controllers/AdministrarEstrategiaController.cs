using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.CustomHelpers;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Providers;
using Portal.Consultoras.Web.ServiceGestionWebPROL;
using Portal.Consultoras.Web.ServiceODS;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServiceProductoCatalogoPersonalizado;
using Portal.Consultoras.Web.ServiceSAC;
using Portal.Consultoras.Web.ServiceUsuario;
using Portal.Consultoras.Web.ServiceZonificacion;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.ServiceModel;
using System.Text;
using System.Threading.Tasks;
using System.Web.Mvc;
using System.Web.UI.WebControls;
using System.Xml.Linq;
using BEConfiguracionPaisDatos = Portal.Consultoras.Web.ServiceUsuario.BEConfiguracionPaisDatos;

namespace Portal.Consultoras.Web.Controllers
{
    public class AdministrarEstrategiaController : BaseController
    {
        protected RenderImgProvider _renderImgProvider;

        public AdministrarEstrategiaController()
        {
            _renderImgProvider = new RenderImgProvider();
        }

        public ActionResult Index(int TipoVistaEstrategia = 0)
        {
            EstrategiaModel estrategiaModel;
            try
            {

                if (!UsuarioModel.HasAcces(ViewBag.Permiso, "AdministrarEstrategia/Index"))
                    return RedirectToAction("Index", "Bienvenida");

                var paisIso = Util.GetPaisISO(userData.PaisID);
                var carpetaPais = Globals.UrlMatriz + "/" + paisIso;
                var urlS3 = ConfigCdn.GetUrlCdn(carpetaPais);

                var habilitarNemotecnico = _tablaLogicaProvider.ObtenerValorTablaLogica(userData.PaisID, Constantes.TablaLogica.Plan20,
                    Constantes.TablaLogicaDato.BusquedaNemotecnicoZonaEstrategia);

                estrategiaModel = new EstrategiaModel()
                {
                    listaCampania = new List<CampaniaModel>(),
                    listaPaises = DropDowListPaises(),
                    ListaTipoEstrategia = DropDowListTipoEstrategia(TipoVistaEstrategia),
                    ListaEtiquetas = DropDowListEtiqueta(),
                    UrlS3 = urlS3,
                    habilitarNemotecnico = habilitarNemotecnico == "1",
                    ExpValidacionNemotecnico = _configuracionManagerProvider.GetConfiguracionManager(Constantes.ConfiguracionManager.ExpresionValidacionNemotecnico),
                    TipoVistaEstrategia = TipoVistaEstrategia,
                    PaisID = userData.PaisID
                };

            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                estrategiaModel = new EstrategiaModel();
            }
            return View(estrategiaModel);
        }

        private IEnumerable<PaisModel> DropDowListPaises()
        {
            List<BEPais> lst;
            using (var sv = new ZonificacionServiceClient())
            {
                lst = userData.RolID == 2
                    ? sv.SelectPaises().ToList()
                    : new List<BEPais> { sv.SelectPais(userData.PaisID) };
            }

            return Mapper.Map<IList<BEPais>, IEnumerable<PaisModel>>(lst);
        }

        public JsonResult ObtenerPedidoAsociado(string CodigoPrograma)
        {
            IList<BEConfiguracionPackNuevas> lst;
            using (var sv = new PedidoServiceClient())
            {
                lst = sv.GetConfiguracionPackNuevas(userData.PaisID, CodigoPrograma);
            }
            return Json(new { pedidoAsociado = lst }, JsonRequestBehavior.AllowGet);
        }

        private IEnumerable<EtiquetaModel> DropDowListEtiqueta()
        {
            IList<BEEtiqueta> lst;
            var entidad = new BEEtiqueta
            {
                PaisID = userData.PaisID,
                Estado = -1
            };

            using (var sv = new PedidoServiceClient())
            {
                lst = sv.GetEtiquetas(entidad);
            }

            return Mapper.Map<IList<BEEtiqueta>, IEnumerable<EtiquetaModel>>(lst);
        }

        public JsonResult ObtenterCampanias(int PaisID)
        {
            PaisID = userData.PaisID;
            var lst = DropDowListCampanias(PaisID);

            return Json(new
            {
                lista = lst
            }, JsonRequestBehavior.AllowGet);
        }

        private IEnumerable<CampaniaModel> DropDowListCampanias(int PaisID)
        {
            IList<BECampania> lst;
            using (var sv = new ZonificacionServiceClient())
            {
                lst = sv.SelectCampanias(PaisID);
            }

            return Mapper.Map<IList<BECampania>, IEnumerable<CampaniaModel>>(lst);
        }

        private IEnumerable<TipoEstrategiaModel> DropDowListTipoEstrategia(int TipoVistaEstrategia)
        {
            var lst = _tipoEstrategiaProvider.GetTipoEstrategias(userData.PaisID);

            if (lst != null && lst.Count > 0)
            {
                var carpetaPais = Globals.UrlMatriz + "/" + userData.CodigoISO;
                lst.Update(x => x.ImagenEstrategia = ConfigCdn.GetUrlFileCdn(carpetaPais, x.ImagenEstrategia));

                var lista = (from a in lst
                             where a.FlagActivo == 1
                                   && a.Codigo != Constantes.TipoEstrategiaCodigo.IncentivosProgramaNuevas
                             select a);

                return Mapper.Map<IEnumerable<ServicePedido.BETipoEstrategia>, IEnumerable<TipoEstrategiaModel>>(lista);
            }

            return null;
        }

        public class BEConfiguracionValidacionZERegionIDComparer : IEqualityComparer<BEConfiguracionValidacionZE>
        {
            public bool Equals(BEConfiguracionValidacionZE x, BEConfiguracionValidacionZE y)
            {
                return y != null && (x != null && x.RegionID.Equals(y.RegionID));
            }

            public int GetHashCode(BEConfiguracionValidacionZE obj)
            {
                return obj.RegionID.GetHashCode();
            }
        }

        public JsonResult CargarArbolRegionesZonas(int? pais, int? region, int? zona)
        {
            if (pais.GetValueOrDefault() == 0)
                return Json(null, JsonRequestBehavior.AllowGet);

            IList<BEConfiguracionValidacionZE> lst;
            using (var sv = new PedidoServiceClient())
            {
                lst = sv.GetRegionZonaZE(pais.GetValueOrDefault(), region.GetValueOrDefault(),
                    zona.GetValueOrDefault());
            }
            var tree = lst.Distinct<BEConfiguracionValidacionZE>(new BEConfiguracionValidacionZERegionIDComparer())
                .Select(
                    r => new JsTreeModel
                    {
                        data = r.RegionNombre,
                        attr = new JsTreeAttribute
                        {
                            id = r.RegionID * 1000,
                            selected = false
                        },
                        children = lst.Where(i => i.RegionID == r.RegionID).Select(
                            z => new JsTreeModel
                            {
                                data = z.ZonaNombre,
                                attr = new JsTreeAttribute
                                {
                                    id = z.ZonaID,
                                    selected = false
                                }
                            }).ToArray()
                    }).ToArray();
            return Json(tree, JsonRequestBehavior.AllowGet);
        }

        public ActionResult Consultar(string sidx, string sord, int page, int rows, string CampaniaID,
            string TipoEstrategiaID, string CUV, string Consulta, int Imagen, int Activo)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    List<ServicePedido.BEEstrategia> lst;
                    if (Consulta == "1")
                    {
                        var entidad = new ServicePedido.BEEstrategia
                        {
                            PaisID = userData.PaisID,
                            TipoEstrategiaID = Convert.ToInt32(TipoEstrategiaID),
                            CUV2 = CUV != "" ? CUV : "0",
                            CampaniaID = Convert.ToInt32(CampaniaID),
                            Activo = Activo,
                            Imagen = Imagen
                        };

                        using (var sv = new PedidoServiceClient())
                        {
                            lst = sv.GetEstrategias(entidad).ToList();
                        }
                    }
                    else
                    {
                        lst = new List<ServicePedido.BEEstrategia>();
                    }

                    var carpetapais = Globals.UrlMatriz + "/" + userData.CodigoISO;

                    if (lst.Count > 0)
                        lst.Update(x => x.ImagenURL = ConfigCdn.GetUrlFileCdn(carpetapais, x.ImagenURL));

                    var grid = new BEGrid
                    {
                        PageSize = rows,
                        CurrentPage = page,
                        SortColumn = sidx,
                        SortOrder = sord
                    };
                    IEnumerable<ServicePedido.BEEstrategia> items = lst;
                    if (lst.Any())
                    {
                        if (sord == "asc")
                        {
                            switch (sidx)
                            {
                                case "CUV2":
                                    items = lst.OrderBy(x => x.CUV2);
                                    break;
                                case "CodigoProducto":
                                    items = lst.OrderBy(x => x.CodigoProducto);
                                    break;
                            }
                        }
                        else
                        {
                            switch (sidx)
                            {
                                case "CUV2":
                                    items = lst.OrderByDescending(x => x.CUV2);
                                    break;
                                case "CodigoProducto":
                                    items = lst.OrderByDescending(x => x.CodigoProducto);
                                    break;
                            }
                        }
                    }
                    items = items.Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);
                    var pag = Util.PaginadorGenerico(grid, lst);

                    var data = new
                    {
                        total = pag.PageCount,
                        page = pag.CurrentPage,
                        records = pag.RecordCount,
                        rows = from a in items
                               select new
                               {
                                   id = a.EstrategiaID,
                                   cell = new string[]
                                   {
                                a.EstrategiaID.ToString(),
                                a.Orden.ToString(),
                                a.ID.ToString(),
                                a.NumeroPedido.ToString(),
                                a.Precio2.ToString(),
                                a.CUV2,
                                a.DescripcionCUV2,
                                a.LimiteVenta.ToString(),
                                a.CodigoProducto,
                                a.ImagenURL,
                                a.Activo.ToString(),
                                a.EsOfertaIndependiente.ToString(),
                                a.FlagValidarImagen.ToString(),
                                a.PesoMaximoImagen.ToString()
                                   }
                               }
                    };
                    return Json(data, JsonRequestBehavior.AllowGet);
                }
                return RedirectToAction("Index", "AdministrarEstrategia");
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return RedirectToAction("Index", "AdministrarEstrategia");
            }
        }

        [HttpGet]
        public ActionResult ConsultarTallaColor(string sidx, string sord, int page, int rows, string CampaniaID,
            string CUV)
        {
            if (ModelState.IsValid)
            {
                List<BETallaColor> lst;

                var entidad = new BETallaColor
                {
                    PaisID = userData.PaisID,
                    CampaniaID = Convert.ToInt32(CampaniaID != "" ? CampaniaID : "0"),
                    CUV = CUV != "" ? CUV : "0"
                };

                using (var sv = new PedidoServiceClient())
                {
                    lst = sv.GetTallaColor(entidad).ToList();
                }

                var grid = new BEGrid
                {
                    PageSize = rows,
                    CurrentPage = page,
                    SortColumn = sidx,
                    SortOrder = sord
                };
                IEnumerable<BETallaColor> items = lst;
                items = items.Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);

                var pag = Util.PaginadorGenerico(grid, lst);

                var data = new
                {
                    total = pag.PageCount,
                    page = pag.CurrentPage,
                    records = pag.RecordCount,
                    rows = from a in items
                           select new
                           {
                               id = a.ID,
                               cell = new string[]
                               {
                            a.ID.ToString(),
                            a.CUV,
                            a.DescripcionCUV,
                            a.PrecioUnitario.ToString(),
                            a.Tipo,
                            a.DescripcionTipo,
                            a.DescripcionTallaColor,
                            a.IDAux.ToString()
                               }
                           }
                };
                return Json(data, JsonRequestBehavior.AllowGet);
            }
            return RedirectToAction("Index", "AdministrarEstrategia");
        }

        [HttpPost]
        public JsonResult RegistrarTallaColor(string xmlTallaColor)
        {
            try
            {
                var entidad = new BETallaColor
                {
                    ID = 0,
                    CUV = "0",
                    Tipo = "0",
                    CampaniaID = 0,
                    PaisID = userData.PaisID,
                    DescripcionTallaColor = xmlTallaColor,
                    UsuarioRegistro = userData.CodigoUsuario,
                    UsuarioModificacion = userData.CodigoUsuario
                };

                using (var sv = new PedidoServiceClient())
                {
                    sv.InsertarTallaColorCUV(entidad);
                }

                return Json(new
                {
                    success = true,
                    message = "Se grabó con éxito.",
                    extra = ""
                });
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    extra = ""
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    extra = ""
                });
            }
        }

        [HttpPost]
        public JsonResult EliminarTallaColor(string Id)
        {
            try
            {
                var entidad = new BETallaColor
                {
                    ID = Convert.ToInt32(Id),
                    PaisID = userData.PaisID
                };

                using (var sv = new PedidoServiceClient())
                {
                    sv.EliminarTallaColor(entidad);
                }

                return Json(new
                {
                    success = true,
                    message = "Se eliminó con éxito.",
                    extra = ""
                });
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    extra = ""
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    extra = ""
                });
            }
        }


        [HttpPost]
        public ActionResult ImagenEstrategiaUpload(string qqfile)
        {
            try
            {
                var inputStream = Request.InputStream;
                var fileBytes = ReadFully(inputStream);
                var ffFileName = qqfile;
                var path = Path.Combine(Globals.RutaTemporales, ffFileName);
                System.IO.File.WriteAllBytes(path, fileBytes);
                if (!System.IO.File.Exists(Globals.RutaTemporales))
                    Directory.CreateDirectory(Globals.RutaTemporales);

                var failImage = false;
                var image = System.Drawing.Image.FromFile(path);
                if (image.Width > 62)
                {
                    failImage = true;
                }
                if (image.Height > 62)
                {
                    failImage = true;
                }

                if (failImage)
                {
                    image.Dispose();
                    System.IO.File.Delete(path);
                    return Json(
                        new
                        {
                            success = false,
                            message = "El tamaño de imagen excede el máximo permitido. (Ancho: 62px - Alto: 62px)."
                        }, "text/html");
                }
                image.Dispose();
                return Json(new { success = true, name = Path.GetFileName(path) }, "text/html");
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new { success = false, message = "Hubo un error al cargar el archivo, intente nuevamente." },
                    "text/html");
            }
        }

        [HttpPost]
        public JsonResult GetOfertaByCUV(string CampaniaID, string CUV2,
            string TipoEstrategiaID, string CUV1, string flag,
            string FlagNueva, string FlagRecoProduc, string FlagRecoPerfil)
        {
            try
            {
                int resultado = -1, tipo = -1;
                if (FlagRecoProduc == "1") tipo = 0;
                if (FlagRecoPerfil == "1") tipo = 1;

                List<ServicePedido.BEEstrategia> lst;
                var entidad = new ServicePedido.BEEstrategia
                {
                    PaisID = userData.PaisID,
                    CampaniaID = Convert.ToInt32(CampaniaID),
                    CUV2 = CUV2,
                    TipoEstrategiaID = Convert.ToInt32(TipoEstrategiaID),
                    CUV1 = CUV1,
                    Activo = Convert.ToInt32(flag),
                    Cantidad = tipo
                };

                using (var sv = new PedidoServiceClient())
                {
                    lst = sv.GetOfertaByCUV(entidad).ToList();
                    if (tipo > -1)
                    {
                        resultado = sv.ValidarCUVsRecomendados(entidad);
                    }
                }

                string mensaje = "", descripcion = "", precio = "";

                if (lst.Count <= 0) throw new ArgumentException("No se econtro el CUV ingresado.");

                if (tipo != 1 && resultado == 0)
                {
                    if (FlagRecoProduc == "1") mensaje = "El CUV2 no está asociado a ningún otro.";
                    return Json(new
                    {
                        success = false,
                        message = mensaje,
                        descripcion,
                        precio,
                        extra = ""
                    }, JsonRequestBehavior.AllowGet);
                }
                mensaje = "OK";

                decimal wspreciopack, ganancia;
                string niveles;

                using (var svs = new WsGestionWeb())
                {
                    var preciosEstrategia = svs.ObtenerPrecioEstrategia(CUV2, userData.CodigoISO, CampaniaID);
                    wspreciopack = preciosEstrategia.montotal;
                    ganancia = preciosEstrategia.montoganacia;
                    niveles = ObtenerTextoNiveles(preciosEstrategia.listaniveles);
                }

                var beEstrategia = lst[0];

                descripcion = beEstrategia.DescripcionCUV2;
                precio = (wspreciopack + ganancia).ToString("F2");
                var codigoSap = beEstrategia.CodigoSAP;
                var enMatrizComercial = beEstrategia.EnMatrizComercial.ToInt();
                var idMatrizComercial = beEstrategia.IdMatrizComercial.ToInt();
                var wsprecio = wspreciopack.ToString("F2");

                return Json(new
                {
                    success = true,
                    message = mensaje,
                    descripcion,
                    precio,
                    wsprecio,
                    codigoSAP = codigoSap,
                    enMatrizComercial,
                    idMatrizComercial,
                    ganancia = ganancia.ToString("F2"),
                    extra = "",
                    niveles,
                    beEstrategia
                }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    extra = ""
                }, JsonRequestBehavior.AllowGet);
            }
        }

        private List<RptProductoEstrategia> EstrategiaProductoObtenerServicio(ServicePedido.BEEstrategia entidad)
        {
            var respuestaServiceCdr = new List<RptProductoEstrategia>();
            try
            {
                var codigo = _tablaLogicaProvider.ObtenerValorTablaLogica(userData.PaisID, Constantes.TablaLogica.Plan20,
                    Constantes.TablaLogicaDato.Tonos, true);

                if (Convert.ToInt32(codigo) <= entidad.CampaniaID)
                {
                    using (var sv = new WsGestionWeb())
                    {
                        respuestaServiceCdr = sv.GetEstrategiaProducto(entidad.CampaniaID.ToString(),
                            userData.CodigoConsultora, entidad.CUV2, userData.CodigoISO).ToList();
                    }
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                respuestaServiceCdr = new List<RptProductoEstrategia>();
            }
            return respuestaServiceCdr;
        }

        private int TieneVariedad(string codigo, string cuv)
        {
            var tieneVariedad = 0;
            switch (codigo)
            {
                case Constantes.TipoEstrategiaSet.IndividualConTonos:
                    List<ServiceODS.BEProducto> listaHermanosE;
                    using (var svc = new ODSServiceClient())
                    {
                        listaHermanosE = svc.GetListBrothersByCUV(userData.PaisID, userData.CampaniaID, cuv).ToList();
                    }
                    tieneVariedad = listaHermanosE.Any() ? 1 : 0;
                    break;
                case Constantes.TipoEstrategiaSet.CompuestaVariable:
                    tieneVariedad = 1;
                    break;
            }

            return tieneVariedad;
        }

        private void EstrategiaProductoInsertar(List<RptProductoEstrategia> respuestaServiceCdr, ServicePedido.BEEstrategia entidad)
        {
            foreach (var producto in respuestaServiceCdr)
            {
                var entidadPro = new ServicePedido.BEEstrategiaProducto
                {
                    PaisID = userData.PaisID,
                    EstrategiaID = entidad.EstrategiaID,
                    Campania = entidad.CampaniaID,
                    CUV = producto.cuv,
                    Grupo = producto.grupo,
                    Orden = producto.orden,
                    CUV2 = entidad.CUV2,
                    SAP = producto.codigo_sap,
                    Cantidad = producto.cantidad,
                    Precio = producto.precio_unitario,
                    PrecioValorizado = producto.precio_valorizado,
                    Digitable = Convert.ToInt16(producto.digitable),
                    CodigoEstrategia = producto.codigo_estrategia,
                    CodigoError = producto.codigo_error,
                    CodigoErrorObs = producto.obs_error,
                    FactorCuadre = producto.factor_cuadre,
                    NombreProducto = producto.descripcion,
                    IdMarca = producto.idmarca,
                    UsuarioModificacion = userData.CodigoConsultora
                };

                using (var sv = new PedidoServiceClient())
                {
                    entidadPro.EstrategiaProductoID = sv.InsertarEstrategiaProducto(entidadPro);
                }
            }
        }

        [HttpPost]
        public JsonResult RegistrarEstrategia(RegistrarEstrategiaModel model)
        {
            try
            {
                var mensajeErrorImagenResize = "";
                var nroPedido = Util.Trim(model.NumeroPedido);

                if (nroPedido.Contains(",")) model.NumeroPedido = "0";

                var entidad = Mapper.Map<RegistrarEstrategiaModel, ServicePedido.BEEstrategia>(model);

                model.NumeroPedido = nroPedido == "" ? "0" : nroPedido;
                nroPedido = model.NumeroPedido.Contains(",") ? nroPedido : "";

                entidad.PaisID = userData.PaisID;
                entidad.Orden = !string.IsNullOrEmpty(model.Orden) ? Convert.ToInt32(model.Orden) : 0;
                entidad.UsuarioCreacion = userData.CodigoUsuario;
                entidad.UsuarioModificacion = userData.CodigoUsuario;

                var respuestaServiceCdr = new List<RptProductoEstrategia>();

                #region codigo_estrategia y variedad

                if (entidad.Activo == 1 && entidad.CodigoTipoEstrategia != null &&
                    (model.CodigoTipoEstrategia == Constantes.TipoEstrategiaCodigo.OfertaParaTi ||
                     model.CodigoTipoEstrategia == Constantes.TipoEstrategiaCodigo.Lanzamiento ||
                     model.CodigoTipoEstrategia == Constantes.TipoEstrategiaCodigo.PackAltoDesembolso ||
                     model.CodigoTipoEstrategia == Constantes.TipoEstrategiaCodigo.OfertasParaMi ||
                     model.CodigoTipoEstrategia == Constantes.TipoEstrategiaCodigo.OfertaDelDia ||
                     model.CodigoTipoEstrategia == Constantes.TipoEstrategiaCodigo.LosMasVendidos ||
                     model.CodigoTipoEstrategia == Constantes.TipoEstrategiaCodigo.GuiaDeNegocioDigitalizada ||
                     model.CodigoTipoEstrategia == Constantes.TipoEstrategiaCodigo.ShowRoom))
                {
                    respuestaServiceCdr = EstrategiaProductoObtenerServicio(entidad);

                    if (respuestaServiceCdr.Any())
                    {
                        entidad.CodigoEstrategia = respuestaServiceCdr[0].codigo_estrategia;
                        entidad.TieneVariedad = TieneVariedad(entidad.CodigoEstrategia, entidad.CUV1);
                    }
                }

                #endregion

                var numeroPedidosAsociados = model.NumeroPedido.Split(',').Select(int.Parse).ToList();
                var estrategiaDetalle = new ServicePedido.BEEstrategiaDetalle();

                foreach (var item in numeroPedidosAsociados)
                {
                    entidad.NumeroPedido = item;
                    if (nroPedido != "") entidad.EstrategiaID = 0; //Fixed bug: _nropedido: 1,2,3 --> Solo Nuevos
                    using (var sv = new PedidoServiceClient())
                    {
                        if (entidad.CodigoTipoEstrategia != null)
                        {
                            if (entidad.CodigoTipoEstrategia.Equals(Constantes.TipoEstrategiaCodigo.Lanzamiento))
                            {
                                estrategiaDetalle = new ServicePedido.BEEstrategiaDetalle();
                                if (entidad.EstrategiaID != 0)
                                    estrategiaDetalle = sv.GetEstrategiaDetalle(entidad.PaisID, entidad.EstrategiaID);

                                entidad = VerficarArchivos(entidad, estrategiaDetalle);
                            }
                        }

                        #region Imagen Resize  

                        mensajeErrorImagenResize = _renderImgProvider.ImagenesResizeProceso(model.RutaImagenCompleta, userData.CodigoISO);

                        #endregion

                        if (entidad.ImagenMiniaturaURL == string.Empty || entidad.ImagenMiniaturaURL == "prod_grilla_vacio.png")
                        {
                            entidad.ImagenMiniaturaURL = entidad.ImagenURL;
                        }
                        else
                        {
                            entidad.ImagenMiniaturaURL = GuardarImagenMiniAmazon(model.ImagenMiniaturaURL, model.ImagenMiniaturaURLAnterior, userData.PaisID);
                        }


                        entidad.EstrategiaID = sv.InsertarEstrategia(entidad);
                    }
                }

                EstrategiaProductoInsertar(respuestaServiceCdr, entidad);

                if (model.CodigoTipoEstrategia == Constantes.TipoEstrategiaCodigo.OfertaParaTi &&
                    !string.IsNullOrEmpty(model.PrecioAnt) &&
                    model.Precio2 != model.PrecioAnt)
                    UpdateCacheListaOfertaFinal(model.CampaniaID);

                return Json(new
                {
                    success = true,
                    message = "Se grabó con éxito la estrategia. " + mensajeErrorImagenResize,
                    extra = ""
                });
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    extra = ""
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    extra = ""
                });
            }
        }

        private void UpdateCacheListaOfertaFinal(string campania)
        {
            try
            {
                string campNowNext;
                using (var svc = new SACServiceClient())
                {
                    campNowNext = svc.GetCampaniaActualAndSiguientePais(userData.PaisID, userData.CodigoISO);
                }

                if (!string.IsNullOrEmpty(campNowNext))
                {
                    var campNow = campNowNext;
                    var campNext = "";

                    if (campNowNext.IndexOf('|') >= 0)
                    {
                        var arr = campNowNext.Split('|');
                        campNow = arr[0];
                        campNext = arr[1];
                    }

                    if (campania == campNow || campania == campNext)
                    {
                        using (var svc = new ProductoServiceClient())
                        {
                            svc.UpdateCacheListaOfertaFinal(userData.CodigoISO, int.Parse(campania));
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
        }

        [HttpPost]
        public JsonResult FiltrarEstrategia(string EstrategiaID, string cuv2, string CampaniaID,
            string TipoEstrategiaID)
        {
            try
            {
                var entidad = new ServicePedido.BEEstrategia
                {
                    PaisID = userData.PaisID,
                    EstrategiaID = Convert.ToInt32(EstrategiaID),
                    CampaniaID = Convert.ToInt32(CampaniaID),
                    TipoEstrategiaID = Convert.ToInt32(TipoEstrategiaID),
                    CUV2 = cuv2,
                     AgregarEnMatriz=true,
                     UsuarioRegistro = userData.CodigoConsultora
                };

                List<ServicePedido.BEEstrategia> lst;
                using (var sv = new PedidoServiceClient())
                {
                    lst = sv.FiltrarEstrategia(entidad).ToList();
                }

                if (lst.Count <= 0)
                    return Json(new
                    {
                        success = false,
                        message = "El CUV2 ingresado no está configurado en la matriz comercial",
                        extra = ""
                    }, JsonRequestBehavior.AllowGet);

                entidad = lst[0];
                string carpetapais = Globals.UrlMatriz + "/" + userData.CodigoISO;
                entidad.ImagenMiniaturaURL = ConfigCdn.GetUrlFileCdn(carpetapais, entidad.ImagenMiniaturaURL);

                return Json(entidad, JsonRequestBehavior.AllowGet);
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Ocurrió un problema al intentar acceder al servicio, intente nuevamente.",
                    extra = ""
                }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Ocurrió un problema al intentar acceder al servicio, intente nuevamente.",
                    extra = ""
                }, JsonRequestBehavior.AllowGet);
            }
        }

        [HttpPost]
        public JsonResult GetImagesBySapCode(int paisID, string estragiaId, string cuv2, string CampaniaID,
            string TipoEstrategiaID, int pagina)
        {
            List<BEMatrizComercialImagen> lst;
            var estrategia = new ServicePedido.BEEstrategia
            {
                PaisID = paisID,
                EstrategiaID = Convert.ToInt32(estragiaId),
                CUV2 = cuv2,
                CampaniaID = Convert.ToInt32(CampaniaID),
                TipoEstrategiaID = Convert.ToInt32(TipoEstrategiaID)
            };

            using (var sv = new PedidoServiceClient())
            {
                lst = sv.GetImagenesByEstrategiaMatrizComercialImagen(estrategia, pagina, 10).ToList();
            }

            return GetImagesCommonResult(lst, paisID);
        }

        private JsonResult GetImagesCommonResult(List<BEMatrizComercialImagen> lst, int paisID)
        {
            var totalRegistros = lst.Any() ? lst[0].TotalRegistros : 0;
            var data = MapImages(lst, paisID);

            return Json(new { imagenes = data, totalRegistros = totalRegistros });
        }

        private List<MatrizComercialImagen> MapImages(List<BEMatrizComercialImagen> lst, int paisID)
        {
            var paisIso = Util.GetPaisISO(paisID);
            var carpetaPais = Globals.UrlMatriz + "/" + paisIso;
            var urlS3 = ConfigCdn.GetUrlCdn(carpetaPais);

            var data = lst.Select(p => new MatrizComercialImagen
            {
                IdMatrizComercialImagen = p.IdMatrizComercialImagen,
                FechaRegistro = p.FechaRegistro ?? default(DateTime),
                Foto = urlS3 + p.Foto,
                NemoTecnico = p.NemoTecnico,
                DescripcionComercial = p.DescripcionComercial
            }).ToList();

            return data;
        }

        [HttpPost]
        public JsonResult FiltrarEstrategiaPedido(string EstrategiaID, int FlagNueva = 0)
        {
            List<ServicePedido.BEEstrategia> lst;

            var entidad = new ServicePedido.BEEstrategia
            {
                PaisID = userData.PaisID,
                EstrategiaID = Convert.ToInt32(EstrategiaID),
                FlagNueva = FlagNueva
            };

            using (var sv = new PedidoServiceClient())
            {
                lst = sv.FiltrarEstrategiaPedido(entidad).ToList();
            }

            var carpetapais = Globals.UrlMatriz + "/" + userData.CodigoISO;

            if (lst.Count > 0)
            {                
                lst.Update(x => x.ImagenURL = ConfigCdn.GetUrlFileCdn(carpetapais, x.ImagenURL));
                lst.Update(x => x.Simbolo = userData.Simbolo);
            }
            ViewBag.ProductoDestacadoDetalle = lst[0];
            return Json(new
            {
                data = lst[0],
                precio = (userData.PaisID == 4)
                    ? lst[0].Precio.ToString("#,##0").Replace(',', '.')
                    : lst[0].Precio.ToString("#,##0.00"),
                precio2 = (userData.PaisID == 4)
                    ? lst[0].Precio2.ToString("#,##0").Replace(',', '.')
                    : lst[0].Precio2.ToString("#,##0.00")
            }, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult DeshabilitarEstrategia(string EstrategiaID)
        {
            try
            {
                var entidad = new ServicePedido.BEEstrategia
                {
                    PaisID = userData.PaisID,
                    EstrategiaID = Convert.ToInt32(EstrategiaID),
                    UsuarioModificacion = userData.CodigoUsuario
                };

                using (var sv = new PedidoServiceClient())
                {
                    sv.DeshabilitarEstrategia(entidad);
                }

                return Json(new
                {
                    success = true,
                    message = "Se deshabilitó la estrategia correctamente.",
                    extra = ""
                }, JsonRequestBehavior.AllowGet);
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Ocurrió un problema al intentar acceder al servicio, intente nuevamente.",
                    extra = ""
                }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Ocurrió un problema al intentar acceder al servicio, intente nuevamente.",
                    extra = ""
                }, JsonRequestBehavior.AllowGet);
            }
        }

        [HttpPost]
        public JsonResult EliminarEstrategia(string EstrategiaID)
        {
            try
            {
                var entidad = new ServicePedido.BEEstrategia
                {
                    PaisID = userData.PaisID,
                    EstrategiaID = Convert.ToInt32(EstrategiaID)
                };
                using (var sv = new PedidoServiceClient())
                {
                    sv.EliminarEstrategia(entidad);
                }
                return Json(new
                {
                    success = true,
                    message = "Se elimino la estrategia correctamente.",
                    extra = ""
                }, JsonRequestBehavior.AllowGet);
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Ocurrió un problema al intentar acceder al servicio, intente nuevamente.",
                    extra = ""
                }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Ocurrió un problema al intentar acceder al servicio, intente nuevamente.",
                    extra = ""
                }, JsonRequestBehavior.AllowGet);
            }
        }


        [HttpPost]
        public JsonResult ActivarDesactivarEstrategias(string EstrategiasActivas, string EstrategiasDesactivas,
            string campaniaID, string tipoEstrategiaCod)
        {
            try
            {
                int resultado;

                using (var sv = new PedidoServiceClient())
                {
                    resultado = sv.ActivarDesactivarEstrategias(userData.PaisID, userData.CodigoUsuario,
                        EstrategiasActivas, EstrategiasDesactivas);
                }

                if (tipoEstrategiaCod == Constantes.TipoEstrategiaCodigo.OfertaParaTi &&
                    !string.IsNullOrEmpty(EstrategiasDesactivas))
                    UpdateCacheListaOfertaFinal(campaniaID);

                return Json(new
                {
                    success = true,
                    message = resultado > 0
                        ? "No se activaron algunas estrategias por no contar con los requisitos de límite de venta o imagen"
                        : "Se actualizaron las estrategias correctamente.",
                    extra = ""
                }, JsonRequestBehavior.AllowGet);
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Ocurrió un problema al intentar acceder al servicio, intente nuevamente.",
                    extra = ""
                }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Ocurrió un problema al intentar acceder al servicio, intente nuevamente.",
                    extra = ""
                }, JsonRequestBehavior.AllowGet);
            }
        }

        [HttpPost]
        public JsonResult InsertEstrategiaPortal(PedidoDetalleModel model)
        {
            try
            {
                string mensaje;
                var beEstrategia = new ServicePedido.BEEstrategia
                {
                    PaisID = userData.PaisID,
                    Cantidad = Convert.ToInt32(model.Cantidad),
                    CUV2 = model.CUV,
                    CampaniaID = userData.CampaniaID,
                    ConsultoraID = userData.ConsultoraID.ToString()
                };

                using (var svc = new PedidoServiceClient())
                {
                    mensaje = svc.ValidarStockEstrategia(beEstrategia);
                    if (model.FlagNueva == 1)
                    {
                        var bePedidoWebDetalleParametros = new BEPedidoWebDetalleParametros
                        {
                            PaisId = userData.PaisID,
                            CampaniaId = userData.CampaniaID,
                            ConsultoraId = userData.ConsultoraID,
                            Consultora = userData.NombreConsultora,
                            EsBpt = EsOpt() == 1,
                            CodigoPrograma = userData.CodigoPrograma,
                            NumeroPedido = userData.ConsecutivoNueva
                        };

                        var detallePedidos = svc.SelectByCampania(bePedidoWebDetalleParametros).ToList();
                        var pedido = detallePedidos.FirstOrDefault(p => p.FlagNueva);
                        if (pedido != null)
                            svc.DelPedidoWebDetalle(pedido);
                    }
                }

                if (mensaje != "OK")
                {
                    return Json(new
                    {
                        result = false,
                        message = mensaje
                    }, JsonRequestBehavior.AllowGet);
                }

                var entidad = Mapper.Map<PedidoDetalleModel, BEPedidoWebDetalle>(model);
                using (var sv = new PedidoServiceClient())
                {
                    entidad.PaisID = userData.PaisID;
                    entidad.ConsultoraID = userData.ConsultoraID;
                    entidad.CampaniaID = userData.CampaniaID;
                    entidad.TipoOfertaSisID = 0;
                    entidad.IPUsuario = userData.IPUsuario;
                    entidad.CodigoUsuarioCreacion = userData.CodigoConsultora;
                    entidad.CodigoUsuarioModificacion = entidad.CodigoUsuarioCreacion;
                    entidad.OrigenPedidoWeb = ProcesarOrigenPedido(entidad.OrigenPedidoWeb);
                    sv.InsPedidoWebDetalleOferta(entidad);
                }

                UpdPedidoWebMontosPROL();

                if (!string.IsNullOrEmpty(entidad.CUV))
                {
                    var indPedidoAutentico = new BEIndicadorPedidoAutentico
                    {
                        PedidoID = entidad.PedidoID,
                        CampaniaID = entidad.CampaniaID,
                        PedidoDetalleID = entidad.PedidoDetalleID,
                        IndicadorIPUsuario = GetIPCliente(),
                        IndicadorFingerprint = "",
                        IndicadorToken = Session["TokenPedidoAutentico"] != null
                            ? Session["TokenPedidoAutentico"].ToString()
                            : ""
                    };
                    InsIndicadorPedidoAutentico(indPedidoAutentico, entidad.CUV);
                }

                object jsoNdata = new
                {
                    success = true,
                    message = "Se agrego la estrategia satisfactoriamente.",
                    extra = ""
                };

                return Json(jsoNdata);
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    extra = ""
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    extra = ""
                });
            }
        }
        
        public static byte[] ReadFully(Stream input)
        {
            var buffer = new byte[16 * 1024];
            using (var ms = new MemoryStream())
            {
                int read;
                while ((read = input.Read(buffer, 0, buffer.Length)) > 0)
                {
                    ms.Write(buffer, 0, read);
                }
                return ms.ToArray();
            }
        }

        public ServicePedido.BEEstrategia VerficarArchivos(ServicePedido.BEEstrategia estrategia, ServicePedido.BEEstrategiaDetalle estrategiaDetalle)
        {
            if (!string.IsNullOrEmpty(estrategia.ImgFondoDesktop) &&
                (string.IsNullOrEmpty(estrategiaDetalle.ImgFondoDesktop) ||
                 estrategia.ImgFondoDesktop != estrategiaDetalle.ImgFondoDesktop))
                estrategia.ImgFondoDesktop = SaveFileS3(estrategia.ImgFondoDesktop);

            if (!string.IsNullOrEmpty(estrategia.ImgFondoMobile) &&
                (string.IsNullOrEmpty(estrategiaDetalle.ImgFondoMobile) ||
                 estrategia.ImgFondoMobile != estrategiaDetalle.ImgFondoMobile))
                estrategia.ImgFondoMobile = SaveFileS3(estrategia.ImgFondoMobile);

            if (!string.IsNullOrEmpty(estrategia.ImgFichaDesktop) &&
                (string.IsNullOrEmpty(estrategiaDetalle.ImgFichaDesktop) ||
                 estrategia.ImgFichaDesktop != estrategiaDetalle.ImgFichaDesktop))
                estrategia.ImgFichaDesktop = SaveFileS3(estrategia.ImgFichaDesktop);

            if (!string.IsNullOrEmpty(estrategia.ImgFichaMobile) &&
                (string.IsNullOrEmpty(estrategiaDetalle.ImgFichaMobile) ||
                 estrategia.ImgFichaMobile != estrategiaDetalle.ImgFichaMobile))
                estrategia.ImgFichaMobile = SaveFileS3(estrategia.ImgFichaMobile);

            if (!string.IsNullOrEmpty(estrategia.ImgFichaFondoDesktop) &&
                (string.IsNullOrEmpty(estrategiaDetalle.ImgFichaFondoDesktop) ||
                 estrategia.ImgFichaFondoDesktop != estrategiaDetalle.ImgFichaFondoDesktop))
                estrategia.ImgFichaFondoDesktop = SaveFileS3(estrategia.ImgFichaFondoDesktop);

            if (!string.IsNullOrEmpty(estrategia.ImgFichaFondoMobile) &&
                (string.IsNullOrEmpty(estrategiaDetalle.ImgFichaFondoMobile) ||
                 estrategia.ImgFichaFondoMobile != estrategiaDetalle.ImgFichaFondoMobile))
                estrategia.ImgFichaFondoMobile = SaveFileS3(estrategia.ImgFichaFondoMobile);

            if (!string.IsNullOrEmpty(estrategia.ImgHomeDesktop) &&
                (string.IsNullOrEmpty(estrategiaDetalle.ImgHomeDesktop) ||
                 estrategia.ImgHomeDesktop != estrategiaDetalle.ImgHomeDesktop))
                estrategia.ImgHomeDesktop = SaveFileS3(estrategia.ImgHomeDesktop);

            if (!string.IsNullOrEmpty(estrategia.ImgHomeMobile) &&
                (string.IsNullOrEmpty(estrategiaDetalle.ImgHomeMobile) ||
                 estrategia.ImgHomeMobile != estrategiaDetalle.ImgHomeMobile))
                estrategia.ImgHomeMobile = SaveFileS3(estrategia.ImgHomeMobile);

            return estrategia;
        }

        public string SaveFileS3(string imagenEstrategia)
        {
            var path = Path.Combine(Globals.RutaTemporales, imagenEstrategia);
            var carpetaPais = Globals.UrlMatriz + "/" + userData.CodigoISO;
            var time = DateTime.Now.Year.ToString() + DateTime.Now.Month.ToString() + DateTime.Now.Minute.ToString() +
                       DateTime.Now.Millisecond.ToString();
            var newfilename = userData.CodigoISO + "_" + time + "_" + FileManager.RandomString() + ".png";
            ConfigS3.SetFileS3(path, carpetaPais, newfilename);
            return newfilename;
        }

        #region ProgramaNuevas

        [HttpGet]
        public ViewResult ProgramaNuevas()
        {
            try
            {
                ViewBag.hdnPaisISO = userData.CodigoISO;
                ViewBag.hdnPaisID = userData.PaisID;
                ViewBag.ddlCampania = DropDowListCampanias(userData.PaisID);

                var tipoEstrategias = _tipoEstrategiaProvider.GetTipoEstrategias(userData.PaisID);
                var oTipoEstrategia =
                    tipoEstrategias.FirstOrDefault(x =>
                        x.Codigo == Constantes.TipoEstrategiaCodigo.IncentivosProgramaNuevas) ?? new ServicePedido.BETipoEstrategia();
                ViewBag.hdnTipoEstrategiaID = oTipoEstrategia.TipoEstrategiaID;
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            return View();
        }

        [HttpGet]
        public ActionResult ProgramaNuevasConsultar(string sidx, string sord, int page, int rows, string CampaniaID,
            string CUV, int Imagen, int Activo, string CodigoPrograma, int TipoEstrategiaID)
        {
            try
            {
                if (string.IsNullOrEmpty(CampaniaID))
                    return RedirectToAction("ProgramaNuevas", "AdministrarEstrategia");

                var entidad = new ServicePedido.BEEstrategia()
                {
                    PaisID = userData.PaisID,
                    TipoEstrategiaID = TipoEstrategiaID,
                    CUV2 = (string.IsNullOrEmpty(CUV) ? "0" : CUV),
                    CampaniaID = Convert.ToInt32(CampaniaID),
                    Activo = Activo,
                    Imagen = Imagen,
                    CodigoPrograma = CodigoPrograma
                };

                List<ServicePedido.BEEstrategia> lst;
                using (var sv = new PedidoServiceClient())
                {
                    lst = sv.GetEstrategias(entidad).ToList();
                }

                var carpetapais = string.Format("{0}/{1}", Globals.UrlMatriz, userData.CodigoISO);
                lst.Update(x => x.ImagenURL = ConfigCdn.GetUrlFileCdn(carpetapais, x.ImagenURL));

                var grid = new BEGrid()
                {
                    PageSize = rows,
                    CurrentPage = page,
                    SortColumn = sidx,
                    SortOrder = sord
                };

                var items = lst.Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);
                var pag = Util.PaginadorGenerico(grid, lst);

                var data = new
                {
                    total = pag.PageCount,
                    page = pag.CurrentPage,
                    records = pag.RecordCount,
                    rows = items
                };

                return Json(data, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return RedirectToAction("ProgramaNuevas", "AdministrarEstrategia");
            }
        }

        [HttpGet]
        public PartialViewResult ProgramaNuevasDetalle(EstrategiaProgramaNuevasModel inModel)
        {
            ViewBag.ddlCampania = DropDowListCampanias(userData.PaisID);

            return PartialView(inModel);
        }

        [HttpGet]
        public PartialViewResult ProgramaNuevasMensaje()
        {
            return PartialView();
        }

        [HttpGet]
        public async Task<JsonResult> ProgramaNuevasMensajeConsultar(string CodigoPrograma)
        {
            var lst = new List<BEConfiguracionProgramaNuevasApp>();

            try
            {
                if (string.IsNullOrEmpty(CodigoPrograma))
                {
                    return Json(new
                    {
                        success = false,
                        message = "No se envió el codigo de programa",
                        data = lst
                    }, JsonRequestBehavior.AllowGet);
                }

                var entidad = new BEConfiguracionProgramaNuevasApp()
                {
                    PaisID = UserData().PaisID,
                    CodigoPrograma = CodigoPrograma,
                };

                using (var sv = new PedidoServiceClient())
                {
                    var resultado = await sv.GetConfiguracionProgramaNuevasAppAsync(entidad);
                    lst = resultado.ToList();
                }

                return Json(new
                {
                    success = true,
                    message = string.Empty,
                    data = lst.FirstOrDefault()
                }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);

                return Json(new
                {
                    success = false,
                    message = "Ocurrió un problema al intentar obtener los datos",
                    data = lst
                }, JsonRequestBehavior.AllowGet);
            }
        }

        [HttpPost]
        public async Task<JsonResult> ProgramaNuevasMensajeInsertar(ConfiguracionProgramaNuevasAppModel inModel)
        {
            try
            {
                var resultado = false;
                var entidad = Mapper.Map<ConfiguracionProgramaNuevasAppModel, BEConfiguracionProgramaNuevasApp>(inModel);
                entidad.PaisID = UserData().PaisID;

                using (var sv = new PedidoServiceClient())
                {
                    resultado = await sv.InsConfiguracionProgramaNuevasAppAsync(entidad);
                }

                return Json(new
                {
                    success = resultado,
                    message = resultado ? "Se grabó con éxito los datos." : "Ocurrió un problema al intentar registrar los datos"
                }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);

                return Json(new
                {
                    success = false,
                    message = "Ocurrió un problema al intentar registrar los datos"
                }, JsonRequestBehavior.AllowGet);
            }
        }

        [HttpGet]
        public PartialViewResult ProgramaNuevasBanner()
        {
            ViewBag.CodigoNivel = Dictionaries.IncentivoProgramaNuevasNiveles;
            return PartialView();
        }

        [HttpPost]
        public async Task<JsonResult> ProgramaNuevasBannerActualizar(int tipoBanner, string codigoPrograma, string codigoNivel)
        {
            try
            {
                var nombreArchivo = Request["qqfile"];
                new UploadHelper().UploadFile(Request, nombreArchivo);

                var carpetaPais = string.Format(Constantes.ProgramaNuevas.CarpetaBanner, UserData().CodigoISO,
                    Dictionaries.IncentivoProgramaNuevasNiveles[codigoNivel]);

                var newfilename = string.Empty;
                switch (tipoBanner)
                {
                    case Constantes.ProgramaNuevas.TipoBanner.BannerCupon:
                        newfilename = string.Format(Constantes.ProgramaNuevas.ArchivoBannerCupones, codigoPrograma, FileManager.RandomString());
                        break;
                    case Constantes.ProgramaNuevas.TipoBanner.BannerPremio:
                        newfilename = string.Format(Constantes.ProgramaNuevas.ArchivoBannerPremios, codigoPrograma, FileManager.RandomString());
                        break;
                }

                var result = ConfigS3.SetFileS3(Path.Combine(Globals.RutaTemporales, nombreArchivo), carpetaPais, newfilename);
                if (result)
                {
                    var entidad = new BEConfiguracionProgramaNuevasApp()
                    {
                        PaisID = UserData().PaisID,
                        CodigoPrograma = codigoPrograma,
                        CodigoNivel = codigoNivel,
                        ArchivoBannerCupon = (tipoBanner == Constantes.ProgramaNuevas.TipoBanner.BannerCupon ? newfilename : null),
                        ArchivoBannerPremio = (tipoBanner == Constantes.ProgramaNuevas.TipoBanner.BannerPremio ? newfilename : null),
                    };

                    using (var sv = new PedidoServiceClient())
                    {
                        result = await sv.InsConfiguracionProgramaNuevasAppAsync(entidad);
                    }
                }

                return Json(new
                {
                    success = result,
                    extra = result ? ConfigCdn.GetUrlFileCdn(carpetaPais, newfilename) : "Ocurrió un problema al intentar registrar los datos"
                }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    extra = ""
                });
            }
        }

        [HttpGet]
        public async Task<JsonResult> ProgramaNuevasBannerObtener(string codigoPrograma, string codigoNivel)
        {
            try
            {
                string filenameCupon = string.Empty;
                string filenamePremio = string.Empty;
                string carpetaPais = string.Format(Constantes.ProgramaNuevas.CarpetaBanner, UserData().CodigoISO, Dictionaries.IncentivoProgramaNuevasNiveles[codigoNivel]);

                var entidad = new BEConfiguracionProgramaNuevasApp()
                {
                    PaisID = UserData().PaisID,
                    CodigoPrograma = codigoPrograma,
                    CodigoNivel = codigoNivel
                };

                using (var sv = new PedidoServiceClient())
                {
                    var resultado = await sv.GetConfiguracionProgramaNuevasAppAsync(entidad);
                    entidad = resultado.FirstOrDefault();
                }

                if (entidad != null)
                {
                    filenameCupon = entidad.ArchivoBannerCupon;
                    filenamePremio = entidad.ArchivoBannerPremio;
                }

                var data = new
                {
                    ImgBannerCupon = ConfigCdn.GetUrlFileCdn(carpetaPais, filenameCupon),
                    ImgBannerPremio = ConfigCdn.GetUrlFileCdn(carpetaPais, filenamePremio)
                };

                return Json(new
                {
                    success = true,
                    extra = data
                }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    extra = ""
                });
            }
        }

        #endregion

        #region Incentivos

        [HttpGet]
        public ViewResult Incentivos()
        {
            try
            {
                ViewBag.hdnPaisISO = userData.CodigoISO;
                ViewBag.hdnPaisID = userData.PaisID;
                ViewBag.ddlCampania = DropDowListCampanias(userData.PaisID);

                var tipoEstrategias = _tipoEstrategiaProvider.GetTipoEstrategias(userData.PaisID);
                var oTipoEstrategia =
                    tipoEstrategias.FirstOrDefault(x => x.Codigo == Constantes.TipoEstrategiaCodigo.Incentivos) ??
                    new ServicePedido.BETipoEstrategia();
                ViewBag.hdnTipoEstrategiaID = oTipoEstrategia.TipoEstrategiaID;
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            return View();
        }

        [HttpGet]
        public ActionResult IncentivosConsultar(string sidx, string sord, int page, int rows, string CampaniaID,
            string CUV, int Imagen, int Activo, string CodigoConcurso, int TipoEstrategiaID)
        {
            try
            {
                if (string.IsNullOrEmpty(CampaniaID)) return RedirectToAction("Incentivos", "AdministrarEstrategia");

                var entidad = new ServicePedido.BEEstrategia()
                {
                    PaisID = userData.PaisID,
                    TipoEstrategiaID = TipoEstrategiaID,
                    CUV2 = (string.IsNullOrEmpty(CUV) ? "0" : CUV),
                    CampaniaID = Convert.ToInt32(CampaniaID),
                    Activo = Activo,
                    Imagen = Imagen,
                    CodigoConcurso = CodigoConcurso
                };

                List<ServicePedido.BEEstrategia> lst;
                using (var sv = new PedidoServiceClient())
                {
                    lst = sv.GetEstrategias(entidad).ToList();
                }

                var carpetapais = string.Format("{0}/{1}", Globals.UrlMatriz, userData.CodigoISO);
                lst.Update(x => x.ImagenURL = ConfigCdn.GetUrlFileCdn(carpetapais, x.ImagenURL));

                var grid = new BEGrid()
                {
                    PageSize = rows,
                    CurrentPage = page,
                    SortColumn = sidx,
                    SortOrder = sord
                };

                var items = lst.Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);
                var pag = Util.PaginadorGenerico(grid, lst);

                var data = new
                {
                    total = pag.PageCount,
                    page = pag.CurrentPage,
                    records = pag.RecordCount,
                    rows = items
                };

                return Json(data, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return RedirectToAction("Incentivos", "AdministrarEstrategia");
            }
        }

        [HttpGet]
        public PartialViewResult IncentivosDetalle(EstrategiaIncentivosModel inModel)
        {
            ViewBag.ddlCampania = DropDowListCampanias(userData.PaisID);
            ViewBag.ddlTipoConcurso = new List<Object>()
            {
                new {value = "X", text = "RxP"},
                new {value = "K", text = "Constancia"}
            };

            return PartialView(inModel);
        }

        #endregion

        [HttpPost]
        public ActionResult UploadCvs(DescripcionMasivoModel model)
        {
            try
            {

                if (model.Documento == null || model.Documento.ContentLength <= 0)
                    throw new ArgumentException("El archivo esta vacío.");
                if (model.Documento.ContentLength > 4 * 1024 * 1024)
                    throw new ArgumentException("El archivo es demasiado extenso para ser procesado.");
                if (!model.Documento.FileName.EndsWith(".csv"))
                    throw new ArgumentException("El archivo no tiene la extensión correcta.");

                var sd = new StreamReader(model.Documento.InputStream, Encoding.Default);

                var readLine = sd.ReadLine();
                if (readLine != null)
                {
                    var arraySplitHeader = readLine.Split(',');

                    if (arraySplitHeader.Length < 2)
                        throw new ArgumentException("Verificar los títulos de las columnas del archivo, deben ser 'cuv, descripcion'.");

                    if (!arraySplitHeader[0].Trim().ToLower().Equals("cuv") ||
                    !arraySplitHeader[1].Trim().ToLower().Equals("descripcion"))
                    {
                        throw new ArgumentException("Verificar los títulos de las columnas del archivo, deben ser 'cuv, descripcion'.");
                    }
                }

                var fileContent = new List<BEDescripcionEstrategia>();

                do
                {
                    readLine = sd.ReadLine();
                    if (readLine == null) continue;

                    var arraySplit = readLine.Split(',');

                    if (arraySplit.Length < 2) continue;
                    if (arraySplit[0].Trim() == "" || arraySplit[1].Trim() == "")
                        continue;

                    fileContent.Add(new BEDescripcionEstrategia
                    {
                        Cuv = arraySplit[0].Trim(),
                        Descripcion = arraySplit[1].Trim()
                    });

                } while (readLine != null);

                List<BEDescripcionEstrategia> beDescripcionEstrategias;
                using (var svc = new SACServiceClient())
                {
                    beDescripcionEstrategias = svc.ActualizarDescripcionEstrategia(model.Pais.ToInt(),
                        model.CampaniaId.ToInt(), model.TipoEstrategia.ToInt(), fileContent.ToArray()).ToList();
                }

                var descripcionEstrategiaModels =
                    Mapper.Map<List<BEDescripcionEstrategia>, List<DescripcionEstrategiaModel>>(beDescripcionEstrategias);

                return Json(new
                {
                    listActualizado = descripcionEstrategiaModels.Where(x => x.Estado == 1),
                    listNoActualizado = descripcionEstrategiaModels.Where(x => x.Estado != 1)
                });

            }
            catch (Exception ex)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest, ex.Message);
            }
        }

        public string GuardarImagenMiniAmazon(string nombreImagen, string nombreImagenAnterior, int paisId, bool keepFile = false)
        {
            string nombreImagenFinal;
            nombreImagen = nombreImagen ?? "";
            nombreImagenAnterior = nombreImagenAnterior ?? "";

            if (nombreImagen != nombreImagenAnterior)
            {
                string iso = Util.GetPaisISO(paisId);
                string carpetaPais = Globals.UrlMatriz + "/" + iso;

                string soloImagen = nombreImagen.Split('.')[0];
                string soloExtension = nombreImagen.Split('.')[1];
                string time = DateTime.Now.Year.ToString() + DateTime.Now.Month.ToString() + DateTime.Now.Minute.ToString() + DateTime.Now.Millisecond.ToString();
                nombreImagenFinal = iso + "_" + soloImagen + "_" + time + "_" + "01" + "_mini_" + FileManager.RandomString() + "." + soloExtension;

                if (nombreImagenAnterior != "") ConfigS3.DeleteFileS3(carpetaPais, nombreImagenAnterior);
                ConfigS3.SetFileS3(Path.Combine(Globals.RutaTemporales, nombreImagen), carpetaPais, nombreImagenFinal, true, !keepFile, false);
            }
            else nombreImagenFinal = nombreImagen;
            return nombreImagenFinal;
        }

        #region Metodos ShowRoom
        [HttpPost]
        public ActionResult UploadFileSetStrategyShowroom(DescripcionMasivoModel model)
        {
            int[] numberRecords = null;
            int line = 0;
            try
            {
                List<ServicePedido.BEEstrategia> strategyEntityList = new List<ServicePedido.BEEstrategia>();
                StreamReader streamReader = new StreamReader(model.Documento.InputStream, Encoding.Default);
                string readLine = streamReader.ReadLine();
                if (model.Documento == null || model.Documento.ContentLength <= 0) throw new ArgumentException("El archivo esta vacío.");
                if (!model.Documento.FileName.EndsWith(".csv")) throw new ArgumentException("El archivo no tiene la extensión correcta.");
                if (model.Documento.ContentLength > 4 * 1024 * 1024) throw new ArgumentException("El archivo es demasiado extenso para ser procesado.");
                if (readLine != null)
                {
                    string[] arrayHeader = readLine.Split('|');
                    string columnObservation = string.Empty;
                    bool errorColumn = false;
                    if (arrayHeader.Length != 7)
                    {
                        throw new ArgumentException("Los títulos de las columnas no son los correctos.");
                    }
                    if (!arrayHeader[(int)Constantes.ColumnsSetStrategyShowroom.Position.CUV].ToLower().Equals(Constantes.ColumnsSetStrategyShowroom.CUV))
                    {
                        columnObservation = Constantes.ColumnsSetStrategyShowroom.CUV;
                        errorColumn = true;
                    }
                    else if (!arrayHeader[(int)Constantes.ColumnsSetStrategyShowroom.Position.NormalPrice].ToLower().Equals(Constantes.ColumnsSetStrategyShowroom.NormalPrice))
                    {
                        columnObservation = Constantes.ColumnsSetStrategyShowroom.NormalPrice;
                        errorColumn = true;
                    }
                    else if (!arrayHeader[(int)Constantes.ColumnsSetStrategyShowroom.Position.AllowedUnits].ToLower().Equals(Constantes.ColumnsSetStrategyShowroom.AllowedUnits))
                    {
                        columnObservation = Constantes.ColumnsSetStrategyShowroom.AllowedUnits;
                        errorColumn = true;
                    }
                    else if (!arrayHeader[(int)Constantes.ColumnsSetStrategyShowroom.Position.NameSet].ToLower().Equals(Constantes.ColumnsSetStrategyShowroom.NameSet))
                    {
                        columnObservation = Constantes.ColumnsSetStrategyShowroom.NameSet;
                        errorColumn = true;
                    }
                    else if (!arrayHeader[(int)Constantes.ColumnsSetStrategyShowroom.Position.BusinessTip].ToLower().Equals(Constantes.ColumnsSetStrategyShowroom.BusinessTip))
                    {
                        columnObservation = Constantes.ColumnsSetStrategyShowroom.BusinessTip;
                        errorColumn = true;
                    }
                    else if (!arrayHeader[(int)Constantes.ColumnsSetStrategyShowroom.Position.IsSubcampaign].ToLower().Equals(Constantes.ColumnsSetStrategyShowroom.IsSubcampaign))
                    {
                        columnObservation = Constantes.ColumnsSetStrategyShowroom.IsSubcampaign;
                        errorColumn = true;
                    }
                    else if (!arrayHeader[(int)Constantes.ColumnsSetStrategyShowroom.Position.OfferStatus].ToLower().Equals(Constantes.ColumnsSetStrategyShowroom.OfferStatus))
                    {
                        columnObservation = Constantes.ColumnsSetStrategyShowroom.OfferStatus;
                        errorColumn = true;
                    }
                    if (errorColumn)
                    {
                        throw new ArgumentException(string.Format("Verificar los títulos de las columnas del archivo. <br /> Referencia: La observación se encontró en la columna '{0}'", columnObservation));
                    }
                    do
                    {
                        readLine = streamReader.ReadLine();
                        if (readLine == null) continue;
                        string[] arrayRows = readLine.Split('|');
                        if (arrayRows[0] != "CUV")
                        {
                            if (arrayRows.Length != 7)
                            {
                                throw new ArgumentException(string.Format("Verificar la información del archivo (datos incompletos). <br /> Referencia: La observación se encontró en el CUV '{0}'", arrayRows[(int)Constantes.ColumnsSetStrategyShowroom.Position.CUV].ToString().TrimEnd()));
                            }
                            line++;
                            strategyEntityList.Add(new ServicePedido.BEEstrategia
                            {
                                CUV2 = arrayRows[(int)Constantes.ColumnsSetStrategyShowroom.Position.CUV].ToString().TrimEnd(),
                                Precio = decimal.Parse(arrayRows[(int)Constantes.ColumnsSetStrategyShowroom.Position.NormalPrice]),
                                LimiteVenta = int.Parse(arrayRows[(int)Constantes.ColumnsSetStrategyShowroom.Position.AllowedUnits]),
                                DescripcionCUV2 = arrayRows[(int)Constantes.ColumnsSetStrategyShowroom.Position.NameSet].ToString().TrimEnd(),
                                TextoLibre = arrayRows[(int)Constantes.ColumnsSetStrategyShowroom.Position.BusinessTip].ToString().TrimEnd(),
                                EsSubCampania = int.Parse(arrayRows[(int)Constantes.ColumnsSetStrategyShowroom.Position.IsSubcampaign]),
                                Activo = int.Parse(arrayRows[(int)Constantes.ColumnsSetStrategyShowroom.Position.OfferStatus])
                            });
                        }
                    }
                    while (readLine != null);
                    using (var svc = new WsGestionWeb())
                    {
                        List<PrecioProducto> productPriceList = null;
                        productPriceList = svc.GetPrecioProductosOfertaWeb(userData.CodigoISO, model.CampaniaId, string.Join("|", strategyEntityList.Select(x => x.CUV2))).ToList();
                        if (productPriceList != null && productPriceList.Count > 0)
                        {
                            strategyEntityList.Update(strategy => strategy.Precio2 = productPriceList.FirstOrDefault(prol => prol.cuv == strategy.CUV2).precio_producto);
                        }
                    }
                    var productPriceZero = strategyEntityList.FirstOrDefault(p => p.Precio == 0);
                    if (productPriceZero != null)
                    {
                        string messageErrorPriceZero = string.Format("No se realizó ninguna operación (actualización/inserción) a ningunos de los registros que estaban dentro del archivo (CSV), porque el producto {0} tiene precio cero", productPriceZero.CUV2);
                        LogManager.LogManager.LogErrorWebServicesPortal(new FaultException(), "ERROR: CARGA PRODUCTO SHOWROOM", string.Format("CUV: {0} con precio CERO", productPriceZero.CUV2));
                        return new HttpStatusCodeResult(HttpStatusCode.BadRequest, messageErrorPriceZero);
                    }
                    var productPriceOfferZero = strategyEntityList.FirstOrDefault(p => p.Precio2 == 0);
                    if (productPriceOfferZero != null)
                    {
                        string messageErrorPriceZero = string.Format("No se actualizó el stock de ninguno de los productos que estaban dentro del archivo (CSV), porque el producto {0} tiene precio oferta Cero", productPriceOfferZero.CUV2);
                        LogManager.LogManager.LogErrorWebServicesPortal(new FaultException(), "ERROR: CARGA PRODUCTO SHOWROOM", string.Format("CUV: {0} con precio CERO", productPriceOfferZero.CUV2));
                        return new HttpStatusCodeResult(HttpStatusCode.BadRequest, messageErrorPriceZero);
                    }
                    XElement strategyXML = new XElement("strategy",
                    from strategy in strategyEntityList
                    select new XElement("row",
                                 new XElement("CUV2", strategy.CUV2),
                                 new XElement("DescripcionCUV2", strategy.DescripcionCUV2),
                                 new XElement("Precio", strategy.Precio),
                                 new XElement("Precio2", strategy.Precio2),
                                 new XElement("LimiteVenta", strategy.LimiteVenta),
                                 new XElement("TextoLibre", strategy.TextoLibre),
                                 new XElement("EsSubCampania", strategy.EsSubCampania),
                                 new XElement("Activo", strategy.Activo)
                               ));
                    using (var service = new PedidoServiceClient())
                    {
                        BEEstrategiaMasiva estrategia = new BEEstrategiaMasiva
                        {
                            EstrategiaXML = strategyXML,
                            TipoEstrategiaID = int.Parse(model.TipoEstrategia),
                            CampaniaID = int.Parse(model.CampaniaId),
                            UsuarioCreacion = userData.CodigoUsuarioHost,
                            UsuarioModificacion = userData.CodigoUsuarioHost,
                            PaisID = Util.GetPaisID(userData.CodigoISO)
                        };
                        numberRecords = service.InsertarEstrategiaMasiva(estrategia);
                    }
                    return Json(new
                    {
                        listActualizado = numberRecords[0],
                        listInsertado = numberRecords[1]
                    });

                }
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest, "readLine = null");
            }
            catch (FormatException ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest, string.Format("{0} <br /> Referencia: La observación se encontró en la registro '{1}'", ex.Message, line));
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest, ex.Message);
            }
        }

        [HttpPost]
        public ActionResult UploadFileProductStrategyShowroom(DescripcionMasivoModel model)
        {
            int[] numberRecords = null;
            int line = 0;
            try
            {
                var strategyEntityList = new List<ServicePedido.BEEstrategiaProducto>();
                StreamReader streamReader = new StreamReader(model.Documento.InputStream, Encoding.Default);
                string readLine = streamReader.ReadLine();
                if (model.Documento == null || model.Documento.ContentLength <= 0) throw new ArgumentException("El archivo esta vacío.");
                if (!model.Documento.FileName.EndsWith(".csv")) throw new ArgumentException("El archivo no tiene la extensión correcta.");
                if (model.Documento.ContentLength > 4 * 1024 * 1024) throw new ArgumentException("El archivo es demasiado extenso para ser procesado.");
                if (readLine != null)
                {
                    string[] arrayHeader = readLine.Split('|');
                    string columnObservation = string.Empty;
                    bool errorColumn = false;
                    if (arrayHeader.Length != 5)
                    {
                        throw new ArgumentException("Los títulos de las columnas no son los correctos.");
                    }
                    if (!arrayHeader[(int)Constantes.ColumnsProductStrategyShowroom.Position.CUV].ToLower().Equals(Constantes.ColumnsProductStrategyShowroom.CUV))
                    {
                        columnObservation = Constantes.ColumnsProductStrategyShowroom.CUV;
                        errorColumn = true;
                    }
                    if (!arrayHeader[(int)Constantes.ColumnsProductStrategyShowroom.Position.Order].ToLower().Equals(Constantes.ColumnsProductStrategyShowroom.Order))
                    {
                        columnObservation = Constantes.ColumnsProductStrategyShowroom.Order;
                        errorColumn = true;
                    }
                    if (!arrayHeader[(int)Constantes.ColumnsProductStrategyShowroom.Position.ProductName].ToLower().Equals(Constantes.ColumnsProductStrategyShowroom.ProductName))
                    {
                        columnObservation = Constantes.ColumnsProductStrategyShowroom.ProductName;
                        errorColumn = true;
                    }
                    if (!arrayHeader[(int)Constantes.ColumnsProductStrategyShowroom.Position.Description].ToLower().Equals(Constantes.ColumnsProductStrategyShowroom.Description))
                    {
                        columnObservation = Constantes.ColumnsProductStrategyShowroom.Description;
                        errorColumn = true;
                    }
                    if (!arrayHeader[(int)Constantes.ColumnsProductStrategyShowroom.Position.BrandProduct].ToLower().Equals(Constantes.ColumnsProductStrategyShowroom.BrandProduct))
                    {
                        columnObservation = Constantes.ColumnsProductStrategyShowroom.BrandProduct;
                        errorColumn = true;
                    }
                    if (errorColumn)
                    {
                        throw new ArgumentException(string.Format("Verificar los títulos de las columnas del archivo. <br /> Referencia: La observación se encontró en la columna '{0}'", columnObservation));
                    }
                    do
                    {
                        readLine = streamReader.ReadLine();
                        if (readLine == null) continue;
                        string[] arrayRows = readLine.Split('|');
                        int evalResult;
                        if (arrayRows[0] != "CUV")
                        {
                            if (arrayRows.Length != 5)
                            {
                                throw new ArgumentException(string.Format("Verificar la información del archivo (datos incompletos). <br /> Referencia: La observación se encontró en el CUV '{0}'", arrayRows[(int)Constantes.ColumnsSetStrategyShowroom.Position.CUV].ToString().TrimEnd()));
                            }
                            if (arrayRows[(int)Constantes.ColumnsProductStrategyShowroom.Position.ProductName].ToString().TrimEnd().Length == 0)
                            {
                                throw new ArgumentException(string.Format("El valor del campo 'Nombre de Producto' es obligatorio. <br /> Referencia: La observación se encontró en el CUV '{0}'", arrayRows[(int)Constantes.ColumnsSetStrategyShowroom.Position.CUV].ToString().TrimEnd()));
                            }
                            if (!int.TryParse(arrayRows[(int)Constantes.ColumnsProductStrategyShowroom.Position.Order], out evalResult))
                            {
                                throw new ArgumentException(string.Format("El valor del campo 'posición' no es númerico. <br /> Referencia: La observación se encontró en el CUV '{0}'", arrayRows[(int)Constantes.ColumnsSetStrategyShowroom.Position.CUV].ToString().TrimEnd()));
                            }
                            if (!int.TryParse(arrayRows[(int)Constantes.ColumnsProductStrategyShowroom.Position.BrandProduct], out evalResult))
                            {
                                throw new ArgumentException(string.Format("El valor del campo 'Marca de Producto' no es númerico. <br /> Referencia: La observación se encontró en el CUV '{0}'", arrayRows[(int)Constantes.ColumnsSetStrategyShowroom.Position.CUV].ToString().TrimEnd()));
                            }
                            line++;
                            strategyEntityList.Add(new ServicePedido.BEEstrategiaProducto
                            {
                                CUV = arrayRows[(int)Constantes.ColumnsProductStrategyShowroom.Position.CUV].ToString().TrimEnd(),
                                NombreProducto = arrayRows[(int)Constantes.ColumnsProductStrategyShowroom.Position.ProductName].ToString().TrimEnd(),
                                Descripcion1 = arrayRows[(int)Constantes.ColumnsProductStrategyShowroom.Position.Description].ToString().TrimEnd(),
                                Orden = int.Parse(arrayRows[(int)Constantes.ColumnsProductStrategyShowroom.Position.Order]),
                                IdMarca = int.Parse(arrayRows[(int)Constantes.ColumnsProductStrategyShowroom.Position.BrandProduct])
                            });
                        }
                    }
                    while (readLine != null);
                    if (strategyEntityList.Count == 0)
                    {
                        throw new ArgumentException("El archivo seleccionado no tiene registros.");
                    }
                    XElement strategyXML = new XElement("strategy",
                    from strategy in strategyEntityList
                    select new XElement("row",
                                 new XElement("CUV", strategy.CUV),
                                 new XElement("NombreProducto", strategy.NombreProducto),
                                 new XElement("Descripcion1", strategy.Descripcion1),
                                 new XElement("Orden", strategy.Orden),
                                 new XElement("IdMarca", strategy.IdMarca)
                               ));
                    using (var service = new PedidoServiceClient())
                    {
                        BEEstrategiaMasiva estrategia = new BEEstrategiaMasiva
                        {
                            EstrategiaXML = strategyXML,
                            TipoEstrategiaID = int.Parse(model.TipoEstrategia),
                            CampaniaID = int.Parse(model.CampaniaId),
                            UsuarioCreacion = userData.CodigoUsuarioHost,
                            UsuarioModificacion = userData.CodigoUsuarioHost,
                            PaisID = Util.GetPaisID(userData.CodigoISO)
                        };
                        numberRecords = service.InsertarProductoShowroomMasiva(estrategia);
                    }
                    return Json(new
                    {
                        listActualizado = numberRecords[0]
                    });

                }
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest, "readLine = null");
            }
            catch (FormatException ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest, string.Format("{0} <br /> Referencia: La observación se encontró en la registro '{1}'", ex.Message, line));
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest, ex.Message);
            }
        }

        #endregion

        private string ObtenerTextoNiveles(NivelEstrategia[] listaNivelEstrategias)
        {
            var stringNiveles = "";

            if (listaNivelEstrategias != null && listaNivelEstrategias.Length > 1)
            {
                stringNiveles = listaNivelEstrategias
                    .Where(nivelEstrategia => nivelEstrategia.nivel != 1)
                    .Aggregate(stringNiveles, (current, nivelEstrategia) => current + (nivelEstrategia.nivel + "X" + "-" + (nivelEstrategia.precio * nivelEstrategia.nivel) + "|"));

                stringNiveles = stringNiveles != "" ? stringNiveles.Remove(stringNiveles.Length - 1) : "";
            }

            return stringNiveles;
        }

        [HttpPost]
        public ActionResult UploadBloqueoCuvs(DescripcionMasivoModel model)
        {
            try
            {
                if (model.Documento == null || model.Documento.ContentLength <= 0)
                    throw new ArgumentException("El archivo esta vacío.");
                if (model.Documento.ContentLength > 4 * 1024 * 1024)
                    throw new ArgumentException("El archivo es demasiado extenso para ser procesado.");
                if (!model.Documento.FileName.EndsWith(".csv"))
                    throw new ArgumentException("El archivo no tiene la extensión correcta.");

                var sd = new StreamReader(model.Documento.InputStream, Encoding.Default);

                var readLine = sd.ReadLine();
                if (readLine != null)
                {
                    var arraySplitHeader = readLine.Split(',');
                    if (!arraySplitHeader[0].ToLower().Equals("cuv"))
                    {
                        throw new ArgumentException("Verificar los títulos de las columnas del archivo.");
                    }
                }

                var valor1 = new StringBuilder();
                var count = 0;
                do
                {
                    readLine = sd.ReadLine();
                    if (readLine == null) continue;
                    var arraySplit = readLine.Split(',');
                    if (arraySplit[0] == "") continue;

                    if (count > 0) valor1.Append(",");
                    valor1.Append(arraySplit[0]);
                    count++;
                } while (readLine != null);


                ServiceSAC.BEConfiguracionPais configuracionPais;

                using (var sac = new SACServiceClient())
                {
                    configuracionPais = sac.GetConfiguracionPaisByCode(userData.PaisID, Constantes.ConfiguracionPais.GuiaDeNegocioDigitalizada);
                }

                var configuracionPaisDatos = new BEConfiguracionPaisDatos
                {
                    ConfiguracionPaisID = configuracionPais.ConfiguracionPaisID,
                    CampaniaID = Convert.ToInt32(model.CampaniaId),
                    Componente = "",
                    Codigo = Constantes.ConfiguracionPaisDatos.RDR.BloquearProductoGnd,
                    Valor1 = valor1.ToString(),
                    Estado = true
                };

                using (var svc = new UsuarioServiceClient())
                {
                    svc.ConfiguracionPaisDatosGuardar(userData.PaisID, new[] { configuracionPaisDatos });
                }

                return Json(new
                {
                    listActualizado = count,
                    valor = valor1.ToString()
                });
            }
            catch (Exception ex)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest, ex.Message);
            }
        }

        public JsonResult GetCuvsBloqueados(int campaniaId)
        {
            try
            {
                var configuracionPaisDatos = new ServiceSAC.BEConfiguracionPaisDatos()
                {
                    PaisID = userData.PaisID,
                    Codigo = Constantes.ConfiguracionPaisDatos.RDR.BloquearProductoGnd,
                    CampaniaID = campaniaId,
                    ConfiguracionPais = new ServiceSAC.BEConfiguracionPais()
                    {
                        Codigo = Constantes.ConfiguracionPais.GuiaDeNegocioDigitalizada
                    }
                };
                using (var sac = new SACServiceClient())
                {
                    configuracionPaisDatos = sac.GetConfiguracionPaisDatos(configuracionPaisDatos);
                }
                return Json(new
                {
                    success = true,
                    message = "Ok",
                    valor = configuracionPaisDatos.Valor1
                }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    valor = ""
                }, JsonRequestBehavior.AllowGet);
            }


        }
    }
}