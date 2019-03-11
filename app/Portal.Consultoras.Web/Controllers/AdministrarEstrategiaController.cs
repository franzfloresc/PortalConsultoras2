using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.CustomHelpers;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Models.Estrategia;
using Portal.Consultoras.Web.Providers;
using Portal.Consultoras.Web.ServiceGestionWebPROL;
using Portal.Consultoras.Web.ServiceODS;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServiceProductoCatalogoPersonalizado;
using Portal.Consultoras.Web.ServiceSAC;
using Portal.Consultoras.Web.ServiceUsuario;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.ServiceModel;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;
using System.Web.UI.WebControls;
using System.Xml.Linq;
using BEConfiguracionPaisDatos = Portal.Consultoras.Web.ServiceUsuario.BEConfiguracionPaisDatos;

namespace Portal.Consultoras.Web.Controllers
{
    public class AdministrarEstrategiaController : BaseAdmController
    {
        protected RenderImgProvider _renderImgProvider;
        protected OfertaBaseProvider _ofertaBaseProvider;
        protected string _dbdefault = "dbdefault";

        public AdministrarEstrategiaController()
        {
            _renderImgProvider = new RenderImgProvider();
            _ofertaBaseProvider = new OfertaBaseProvider();
        }

        public ActionResult Index(int TipoVistaEstrategia = 0)
        {
            EstrategiaModel estrategiaModel;
            try
            {

                if (!UsuarioModel.HasAcces(ViewBag.Permiso, "AdministrarEstrategia/Index"))
                    return RedirectToAction("Index", "Bienvenida");

                var paisIso = Util.GetPaisISO(userData.PaisID);
                var urlS3 = ConfigCdn.GetUrlCdnMatriz(paisIso);

                var habilitarNemotecnico = _tablaLogicaProvider.GetTablaLogicaDatoCodigo(userData.PaisID, Constantes.TablaLogica.Plan20,
                    Constantes.TablaLogicaDato.BusquedaNemotecnicoZonaEstrategia);

                estrategiaModel = new EstrategiaModel()
                {
                    listaCampania = new List<CampaniaModel>(),
                    listaPaises = DropDowListPaises(),
                    ListaTipoEstrategia = DropDowListTipoEstrategia(),
                    ListaEtiquetas = DropDowListEtiqueta(),
                    UrlS3 = urlS3,
                    habilitarNemotecnico = habilitarNemotecnico == "1",
                    ExpValidacionNemotecnico = _configuracionManagerProvider.GetConfiguracionManager(Constantes.ConfiguracionManager.ExpresionValidacionNemotecnico),
                    TipoVistaEstrategia = TipoVistaEstrategia,
                    PaisID = userData.PaisID
                };
                //Enviar listado de palancas c/microservicios y si el país está configurado para ser evaluados en grilla.
                ViewBag.MsEstrategias = SessionManager.GetConfigMicroserviciosPersonalizacion().EstrategiaHabilitado; //WebConfig.EstrategiaDisponibleMicroservicioPersonalizacion;
                ViewBag.MsPaises = SessionManager.GetConfigMicroserviciosPersonalizacion().PaisHabilitado; //WebConfig.PaisesMicroservicioPersonalizacion;
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                estrategiaModel = new EstrategiaModel();
            }
            return View(estrategiaModel);
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

        private IEnumerable<TipoEstrategiaModel> DropDowListTipoEstrategia()
        {
            var lst = _tipoEstrategiaProvider.GetTipoEstrategias(userData.PaisID);

            if (lst != null && lst.Count > 0)
            {
                lst.Update(x => x.ImagenEstrategia = ConfigS3.GetUrlFileS3Matriz(userData.CodigoISO, x.ImagenEstrategia));

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
            string TipoEstrategiaID, string CUV, string Consulta, int Imagen, int Activo, string TipoEstrategiaCodigo)
        {
            try
            {
                if (!ModelState.IsValid)
                {

                    return RedirectToAction("Index", "AdministrarEstrategia");
                }

                bool dbdefault = HttpUtility.ParseQueryString(((System.Web.HttpRequestWrapper)Request).UrlReferrer.Query)[_dbdefault].ToBool();

                var lst = ConsultarObtenerEstrategia(CampaniaID, TipoEstrategiaID, CUV, Consulta, Imagen, Activo, TipoEstrategiaCodigo, dbdefault);

                var grid = new BEGrid
                {
                    PageSize = rows,
                    CurrentPage = page,
                    SortColumn = sidx,
                    SortOrder = sord
                };

                IEnumerable<EstrategiaMDbAdapterModel> items = ConsultarOrdenar(lst, sidx, sord);
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
                               id = a.BEEstrategia.EstrategiaID,
                               cell = new string[]
                               {
                                        a.BEEstrategia.EstrategiaID.ToString(),
                                        a.BEEstrategia.Orden.ToString(),
                                        a.BEEstrategia.ID.ToString(),
                                        a.BEEstrategia.NumeroPedido.ToString(),
                                        a.BEEstrategia.Precio2.ToString(),
                                        a.BEEstrategia.CUV2,
                                        a.BEEstrategia.DescripcionCUV2,
                                        a.BEEstrategia.LimiteVenta.ToString(),
                                        a.BEEstrategia.CodigoProducto,
                                        a.BEEstrategia.ImagenURL,
                                        a.BEEstrategia.Activo.ToString(),
                                        a.BEEstrategia.EsOfertaIndependiente.ToString(),
                                        a.BEEstrategia.FlagValidarImagen.ToString(),
                                        a.BEEstrategia.PesoMaximoImagen.ToString(),
                                        a._id,
                                        a.BEEstrategia.CodigoTipoEstrategia
                               }
                           }
                };
                return Json(data, JsonRequestBehavior.AllowGet);

            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return RedirectToAction("Index", "AdministrarEstrategia");
            }
        }

        private List<EstrategiaMDbAdapterModel> ConsultarObtenerEstrategia(string campaniaId, string tipoEstrategiaId,
            string cuv, string consulta, int imagen, int activo, string tipoEstrategiaCodigo, bool dbdefault)
        {
            List<EstrategiaMDbAdapterModel> lst = new List<EstrategiaMDbAdapterModel>();
            if (consulta != "1")
            {
                return lst;
            }

            var entidad = new ServicePedido.BEEstrategia
            {
                PaisID = userData.PaisID,
                TipoEstrategiaID = Convert.ToInt32(tipoEstrategiaId),
                CUV2 = cuv != "" ? cuv : "0",
                CampaniaID = Convert.ToInt32(campaniaId),
                Activo = activo,
                Imagen = imagen
            };

            if (_ofertaBaseProvider.UsarMsPersonalizacion(userData.CodigoISO, tipoEstrategiaCodigo, dbdefault))
            {
                entidad.CodigoTipoEstrategia = tipoEstrategiaCodigo;
                lst.AddRange(administrarEstrategiaProvider.Listar(entidad.CampaniaID.ToString(),
                    entidad.CodigoTipoEstrategia, userData.CodigoISO, entidad.Activo, entidad.CUV2, entidad.Imagen).ToList());
            }
            else
            {
                using (var sv = new PedidoServiceClient())
                {
                    var tmpEstrategiaList = sv.GetEstrategias(entidad).ToList();
                    foreach (var itemEstrategia in tmpEstrategiaList)
                    {
                        lst.Add(new EstrategiaMDbAdapterModel { BEEstrategia = itemEstrategia });
                    }
                }
            }

            if (lst.Count > 0)
                lst.Update(x => x.BEEstrategia.ImagenURL = ConfigS3.GetUrlFileS3Matriz(userData.CodigoISO, x.BEEstrategia.ImagenURL));

            return lst;
        }

        private IEnumerable<EstrategiaMDbAdapterModel> ConsultarOrdenar(List<EstrategiaMDbAdapterModel> lst, string sidx, string sord)
        {
            IEnumerable<EstrategiaMDbAdapterModel> items = lst;
            if (lst.Any())
            {
                if (sord == "asc")
                {
                    switch (sidx)
                    {
                        case "CUV2":
                            items = lst.OrderBy(x => x.BEEstrategia.CUV2);
                            break;
                        case "CodigoProducto":
                            items = lst.OrderBy(x => x.BEEstrategia.CodigoProducto);
                            break;
                    }
                }
                else
                {
                    switch (sidx)
                    {
                        case "CUV2":
                            items = lst.OrderByDescending(x => x.BEEstrategia.CUV2);
                            break;
                        case "CodigoProducto":
                            items = lst.OrderByDescending(x => x.BEEstrategia.CodigoProducto);
                            break;
                    }
                }
            }

            return items;
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
            string FlagNueva, string FlagRecoProduc, string FlagRecoPerfil,
            string tipoEstrategiaCodigo)
        {
            try
            {
                string mensaje = "", descripcion = "", precio = "";
                decimal wspreciopack, ganancia = 0;
                string niveles = "";
                string codigoSap = "";
                int enMatrizComercial = 0;
                string wsprecio = "";
                int idMatrizComercial = 0;
                ServicePedido.BEEstrategia beEstrategia = null;
                bool dbdefault = HttpUtility.ParseQueryString(((System.Web.HttpRequestWrapper)Request).UrlReferrer.Query)[_dbdefault].ToBool();

                if (_ofertaBaseProvider.UsarMsPersonalizacion(userData.CodigoISO, tipoEstrategiaCodigo, dbdefault))
                {
                    var objEstrategia = administrarEstrategiaProvider.ObtenerEstrategiaCuv(CUV2,
                                                                CampaniaID, tipoEstrategiaCodigo,
                                                                userData.CodigoISO, FlagRecoProduc, FlagRecoPerfil);

                    if (objEstrategia != null)
                    {
                        mensaje = "OK";
                        beEstrategia = objEstrategia;
                        descripcion = beEstrategia.DescripcionCUV2;
                        precio = (beEstrategia.PrecioPublico + beEstrategia.Ganancia).ToString("F2");
                        wsprecio = beEstrategia.PrecioPublico.ToString();
                        ganancia = beEstrategia.Ganancia;
                        codigoSap = beEstrategia.CodigoSAP;
                        enMatrizComercial = beEstrategia.EnMatrizComercial.ToInt();
                    }
                }
                else
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

                    using (var svs = new WsGestionWeb())
                    {
                        var preciosEstrategia = svs.ObtenerPrecioEstrategia(CUV2, userData.CodigoISO, CampaniaID);
                        wspreciopack = preciosEstrategia.montotal;
                        ganancia = preciosEstrategia.montoganacia;
                        niveles = ObtenerTextoNiveles(preciosEstrategia.listaniveles);
                    }

                    beEstrategia = lst[0];

                    descripcion = beEstrategia.DescripcionCUV2;
                    precio = (wspreciopack + ganancia).ToString("F2");
                    codigoSap = beEstrategia.CodigoSAP;
                    enMatrizComercial = beEstrategia.EnMatrizComercial.ToInt();
                    idMatrizComercial = beEstrategia.IdMatrizComercial.ToInt();
                    wsprecio = wspreciopack.ToString("F2");
                }
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
                var codigo = _tablaLogicaProvider.GetTablaLogicaDatoCodigo(userData.PaisID, Constantes.TablaLogica.Plan20,
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
                    tieneVariedad = listaHermanosE.Any().ToInt();
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
        public JsonResult RegistrarEstrategia(RegistrarEstrategiaModel model,
            string _id, string _flagRecoProduc, string _flagRecoPerfil)
        {
            var error = new StringBuilder();
            try
            {
                bool dbdefault = HttpUtility.ParseQueryString(((System.Web.HttpRequestWrapper)Request).UrlReferrer.Query)[_dbdefault].ToBool();
                var mensajeErrorImagenResize = " Antes de Crear la Imagenes Renderizadas";
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
                    error.Append("| region codigo_estrategia y variedad");
                    respuestaServiceCdr = EstrategiaProductoObtenerServicio(entidad);
                    error.Append("| region codigo_estrategia y variedad fin - respuestaServiceCdr = " + respuestaServiceCdr.Count);

                    if (respuestaServiceCdr.Any())
                    {
                        error.Append("| respuestaServiceCdr.Any - TieneVariedad");
                        entidad.CodigoEstrategia = respuestaServiceCdr[0].codigo_estrategia;
                        entidad.TieneVariedad = TieneVariedad(entidad.CodigoEstrategia, entidad.CUV1);
                        error.Append("| respuestaServiceCdr.Any - TieneVariedad fin = " + entidad.TieneVariedad);
                    }
                }

                #endregion

                var numeroPedidosAsociados = model.NumeroPedido.Split(',').Select(int.Parse).ToList();
                error.Append("| NumeroPedido.Split = " + numeroPedidosAsociados.Count);

                ServicePedido.BEEstrategiaDetalle estrategiaDetalle;

                foreach (var item in numeroPedidosAsociados)
                {
                    entidad.NumeroPedido = item;
                    if (nroPedido != "") entidad.EstrategiaID = 0; //Fixed bug: _nropedido: 1,2,3 --> Solo Nuevos
                    using (var sv = new PedidoServiceClient())
                    {
                        if (entidad.CodigoTipoEstrategia != null)
                        {
                            error.Append("| if CodigoTipoEstrategia != null");
                            if (entidad.CodigoTipoEstrategia.Equals(Constantes.TipoEstrategiaCodigo.Lanzamiento))
                            {
                                error.Append("| if CodigoTipoEstrategia Equals Lan");
                                estrategiaDetalle = new ServicePedido.BEEstrategiaDetalle();

                                if (entidad.EstrategiaID != 0)
                                {
                                    if (_ofertaBaseProvider.UsarMsPersonalizacion(userData.CodigoISO, entidad.CodigoTipoEstrategia, dbdefault))
                                    {
                                        List<EstrategiaMDbAdapterModel> lst = new List<EstrategiaMDbAdapterModel>();
                                        lst.AddRange(administrarEstrategiaProvider.FiltrarEstrategia(_id, userData.CodigoISO).ToList());
                                        if (lst.Count > 0)
                                        {
                                            var entidadMongo = lst[0].BEEstrategia;
                                            estrategiaDetalle = administrarEstrategiaProvider.ObtenerEstrategiaDetalle(entidadMongo);
                                        }
                                    }
                                    else
                                    {
                                        error.Append("| if entidad.EstrategiaID != 0");
                                        estrategiaDetalle = sv.GetEstrategiaDetalle(entidad.PaisID, entidad.EstrategiaID);
                                        error.Append("| if entidad.EstrategiaID != 0 fin");
                                    }
                                }

                                error.Append("| VerficarArchivos");
                                entidad = VerficarArchivos(entidad, estrategiaDetalle);
                                error.Append("| VerficarArchivos fin");
                            }
                        }

                        #region Imagen Resize  
                        error.Append("| mensajeErrorImagenResize");
                        mensajeErrorImagenResize = _renderImgProvider.ImagenesResizeProceso(model.RutaImagenCompleta, userData.CodigoISO);
                        error.Append("| mensajeErrorImagenResize fin = " + mensajeErrorImagenResize);

                        #endregion

                        if (entidad.ImagenMiniaturaURL == string.Empty || entidad.ImagenMiniaturaURL == "prod_grilla_vacio.png")
                        {
                            error.Append("| ImagenMiniaturaURL vacia");
                            entidad.ImagenMiniaturaURL = entidad.ImagenURL;
                            error.Append("| ImagenMiniaturaURL vacia - fin = " + entidad.ImagenMiniaturaURL);
                        }
                        else
                        {
                            error.Append("| ImagenMiniaturaURL");
                            entidad.ImagenMiniaturaURL = GuardarImagenMiniAmazon(model.ImagenMiniaturaURL, model.ImagenMiniaturaURLAnterior, userData.PaisID);
                            error.Append("| ImagenMiniaturaURL fin = " + entidad.ImagenMiniaturaURL);
                        }

                        if (_ofertaBaseProvider.UsarMsPersonalizacion(userData.CodigoISO, entidad.CodigoTipoEstrategia, dbdefault))
                        {
                            if (entidad.EstrategiaID != 0)
                            {
                                error.Append("| EditarEstrategia");
                                administrarEstrategiaProvider.EditarEstrategia(entidad, _id, userData.CodigoISO, _flagRecoProduc, _flagRecoPerfil);
                                error.Append("| EditarEstrategia fin");
                            }
                            else
                            {
                                error.Append("| RegistrarEstrategia");
                                administrarEstrategiaProvider.RegistrarEstrategia(entidad, userData.CodigoISO);
                                error.Append("| RegistrarEstrategia fin");
                            }
                        }
                        else
                        {
                            error.Append("| InsertarEstrategia");
                            entidad.EstrategiaID = sv.InsertarEstrategia(entidad);
                            error.Append("| InsertarEstrategia Fin = EstrategiaID = " + entidad.EstrategiaID);
                        }
                    }
                }
                if (!_ofertaBaseProvider.UsarMsPersonalizacion(userData.CodigoISO, entidad.CodigoTipoEstrategia, dbdefault))
                {
                    error.Append("| EstrategiaProductoInsertar");
                    EstrategiaProductoInsertar(respuestaServiceCdr, entidad);
                    error.Append("| EstrategiaProductoInsertar fin");
                }

                if (model.CodigoTipoEstrategia == Constantes.TipoEstrategiaCodigo.OfertaParaTi &&
                    !string.IsNullOrEmpty(model.PrecioAnt) &&
                    model.Precio2 != model.PrecioAnt)
                {
                    error.Append("| UpdateCacheListaOfertaFinal");
                    UpdateCacheListaOfertaFinal(model.CampaniaID);
                    error.Append("| UpdateCacheListaOfertaFinal fin");
                }

                return Json(new
                {
                    success = true,
                    message = "Se grabó con éxito la estrategia. " + mensajeErrorImagenResize,
                    extra = "",
                    msjError = error
                });
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
                error.Append("| FaultException = " + ex.Message);
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    extra = "",
                    msjError = error
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                error.Append("| Exception = " + ex.Message);
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    extra = "",
                    msjError = error
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
            string TipoEstrategiaID, string _id, string mongoIdVal, string tipoEstrategiaCodigo)
        {
            try
            {
                bool dbdefault = HttpUtility.ParseQueryString(((System.Web.HttpRequestWrapper)Request).UrlReferrer.Query)[_dbdefault].ToBool();
                List<EstrategiaMDbAdapterModel> lst = new List<EstrategiaMDbAdapterModel>();
                
                if (_ofertaBaseProvider.UsarMsPersonalizacion(userData.CodigoISO, tipoEstrategiaCodigo, dbdefault))
                {
                    lst.AddRange(administrarEstrategiaProvider.FiltrarEstrategia(mongoIdVal, userData.CodigoISO).ToList());
                }
                else
                {
                    var entidad = new ServicePedido.BEEstrategia
                    {
                        PaisID = userData.PaisID,
                        EstrategiaID = Convert.ToInt32(EstrategiaID),
                        CampaniaID = Convert.ToInt32(CampaniaID),
                        TipoEstrategiaID = Convert.ToInt32(TipoEstrategiaID),
                        CUV2 = cuv2,
                        AgregarEnMatriz = true,
                        UsuarioRegistro = userData.CodigoConsultora
                    };

                    using (var sv = new PedidoServiceClient())
                    {
                        var tmpList = sv.FiltrarEstrategia(entidad).ToList();
                        foreach (var itemEstrategia in tmpList)
                        {
                            lst.Add(new EstrategiaMDbAdapterModel { BEEstrategia = itemEstrategia });
                        }
                    }
                }

                if (lst.Count <= 0)
                    return Json(new
                    {
                        success = false,
                        message = "El CUV2 ingresado no está configurado en la matriz comercial",
                        extra = ""
                    }, JsonRequestBehavior.AllowGet);

                entidad = lst[0].BEEstrategia;
                entidad.ImagenMiniaturaURL = ConfigS3.GetUrlFileS3Matriz(userData.CodigoISO, entidad.ImagenMiniaturaURL);

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
            string TipoEstrategiaID, int pagina, string nombreImagen)
        {
            string error = "";
            try
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

                if (pagina == 1)
                {
                    error += "| primera pagina";
                    GetImagenesByEstrategiaMatrizComercialImagenIsOk(estrategia, pagina, nombreImagen);
                    error += "| primera pagina fin";
                }

                // validar si existe en MatrizComercialImagen
                using (var sv = new PedidoServiceClient())
                {
                    lst = sv.GetImagenesByEstrategiaMatrizComercialImagen(estrategia, pagina, 10).ToList();
                    error += "| GetImagenesByEstrategiaMatrizComercialImagen = " + lst.Count;
                }

                return GetImagesCommonResult(lst, paisID, error);
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
                error += "| FaultException = " + ex.Message;
                return Json(new
                {
                    success = false,
                    message = "Ocurrió un problema al intentar acceder al servicio, intente nuevamente.",
                    extra = "",
                    msjError = error
                }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                error += "| Exception = " + ex.Message;
                return Json(new
                {
                    success = false,
                    message = "Ocurrió un problema al intentar acceder al servicio, intente nuevamente.",
                    extra = "",
                    msjError = error
                }, JsonRequestBehavior.AllowGet);
            }
        }

        private void GetImagenesByEstrategiaMatrizComercialImagenIsOk(ServicePedido.BEEstrategia estrategia, int pagina, string nombreImagen)
        {
            nombreImagen = Util.Trim(nombreImagen);
            if (nombreImagen == "")
            {
                return;
            }

            List<BEMatrizComercialImagen> lst;

            using (var sv = new PedidoServiceClient())
            {
                lst = sv.GetImagenesByEstrategiaMatrizComercialImagen(estrategia, pagina, -1).ToList();
            }

            bool foto = false;

            foreach (var item in lst)
            {
                if (lst.Any(x => item.Foto.ToLower() == nombreImagen.ToLower()))
                {
                    foto = true;
                    break;
                }
            }

            if (foto)
            {
                return;
            }

            var entidadImagen = lst[0];

            var entity = new BEMatrizComercialImagen
            {
                IdMatrizComercial = entidadImagen.IdMatrizComercial,
                PaisID = userData.PaisID,
                UsuarioRegistro = userData.CodigoConsultora,
                UsuarioModificacion = userData.CodigoConsultora,
                NemoTecnico = null, // NemoTecnico apagado
                DescripcionComercial = null,  // NemoTecnico apagado,
                Foto = nombreImagen
            };

            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                entity.IdMatrizComercialImagen = sv.InsMatrizComercialImagen(entity);
            }
        }

        private JsonResult GetImagesCommonResult(List<BEMatrizComercialImagen> lst, int paisID, string error)
        {
            var totalRegistros = lst.Any() ? lst[0].TotalRegistros : 0;
            error += "| GetImagesCommonResult - totalRegistros = " + totalRegistros;
            var data = MapImages(lst, paisID);
            error += "| GetImagesCommonResult - MapImages = " + data.Count;

            return Json(new { imagenes = data, totalRegistros = totalRegistros, msjError = error });
        }

        private List<MatrizComercialImagen> MapImages(List<BEMatrizComercialImagen> lst, int paisID)
        {
            var paisIso = Util.GetPaisISO(paisID);
            var carpetaPais = Globals.UrlMatriz + "/" + paisIso;
            var urlS3 = ConfigS3.GetUrlS3(carpetaPais);

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

        //[HttpPost]
        //public JsonResult FiltrarEstrategiaPedido(string EstrategiaID, int FlagNueva = 0)
        //{
        //    List<ServicePedido.BEEstrategia> lst;

        //    var entidad = new ServicePedido.BEEstrategia
        //    {
        //        PaisID = userData.PaisID,
        //        EstrategiaID = Convert.ToInt32(EstrategiaID),
        //        FlagNueva = FlagNueva
        //    };

        //    using (var sv = new PedidoServiceClient())
        //    {
        //        lst = sv.FiltrarEstrategiaPedido(entidad).ToList();
        //    }

        //    if (lst.Count > 0)
        //    {
        //        lst.Update(x => x.ImagenURL = ConfigS3.GetUrlFileS3Matriz(userData.CodigoISO, x.ImagenURL));
        //        lst.Update(x => x.Simbolo = userData.Simbolo);
        //    }
        //    ViewBag.ProductoDestacadoDetalle = lst[0];
        //    return Json(new
        //    {
        //        data = lst[0],
        //        precio = (userData.PaisID == Constantes.PaisID.Colombia)
        //            ? lst[0].Precio.ToString("#,##0").Replace(',', '.')
        //            : lst[0].Precio.ToString("#,##0.00"),
        //        precio2 = (userData.PaisID == Constantes.PaisID.Colombia)
        //            ? lst[0].Precio2.ToString("#,##0").Replace(',', '.')
        //            : lst[0].Precio2.ToString("#,##0.00")
        //    }, JsonRequestBehavior.AllowGet);
        //}

        [HttpPost]
        public JsonResult DeshabilitarEstrategia(string EstrategiaID, string idMongoVal, string tipoEstrategiaCodigo)
        {
            try
            {
                bool dbdefault = HttpUtility.ParseQueryString(((System.Web.HttpRequestWrapper)Request).UrlReferrer.Query)[_dbdefault].ToBool();
                var entidad = new ServicePedido.BEEstrategia
                {
                    PaisID = userData.PaisID,
                    EstrategiaID = Convert.ToInt32(EstrategiaID),
                    UsuarioModificacion = userData.CodigoUsuario
                };

                if (_ofertaBaseProvider.UsarMsPersonalizacion(userData.CodigoISO, tipoEstrategiaCodigo, dbdefault))
                {
                    administrarEstrategiaProvider.DesactivarEstrategia(idMongoVal, userData.UsuarioNombre, userData.CodigoISO);
                }
                else
                {
                    using (var sv = new PedidoServiceClient())
                    {
                        sv.DeshabilitarEstrategia(entidad);
                    }

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
        public JsonResult EliminarEstrategia(string EstrategiaID, string _id, string tipoEstrategiaCodigo)
        {
            try
            {
                bool dbdefault = HttpUtility.ParseQueryString(((System.Web.HttpRequestWrapper)Request).UrlReferrer.Query)[_dbdefault].ToBool();
                var entidad = new ServicePedido.BEEstrategia
                {
                    PaisID = userData.PaisID,
                    EstrategiaID = Convert.ToInt32(EstrategiaID)
                };

                if (_ofertaBaseProvider.UsarMsPersonalizacion(userData.CodigoISO, tipoEstrategiaCodigo, dbdefault))
                {
                    administrarEstrategiaProvider.EliminarEstrategia(entidad.EstrategiaID, _id);
                }
                else
                {
                    using (var sv = new PedidoServiceClient())
                    {
                        sv.EliminarEstrategia(entidad);
                    }
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
                int resultado = 0;
                EstrategiasActivas = EstrategiasActivas ?? "";
                EstrategiasDesactivas = EstrategiasDesactivas ?? "";
                bool dbdefault = HttpUtility.ParseQueryString(((System.Web.HttpRequestWrapper)Request).UrlReferrer.Query)[_dbdefault].ToBool();

                if (_ofertaBaseProvider.UsarMsPersonalizacion(userData.CodigoISO, tipoEstrategiaCod, dbdefault))
                {
                    List<string> estrategiasActivasList = new List<string>();
                    List<string> estrategiasInactivasList = new List<string>();
                    if (EstrategiasActivas != "")
                    {
                        estrategiasActivasList.AddRange(EstrategiasActivas.Split(',').ToList());
                    }
                    if (EstrategiasDesactivas != "")
                    {
                        estrategiasInactivasList.AddRange(EstrategiasDesactivas.Split(',').ToList());
                    }


                    bool bResultado = administrarEstrategiaProvider.ActivarDesactivarEstrategias(estrategiasActivasList, estrategiasInactivasList, userData.UsuarioNombre, userData.CodigoISO, tipoEstrategiaCod);
                    resultado = (!bResultado).ToInt();
                }
                else
                {
                    using (var sv = new PedidoServiceClient())
                    {
                        resultado = sv.ActivarDesactivarEstrategias(userData.PaisID, userData.CodigoUsuario,
                            EstrategiasActivas, EstrategiasDesactivas);
                    }
                }

                if (tipoEstrategiaCod == Constantes.TipoEstrategiaCodigo.OfertaParaTi && EstrategiasDesactivas != "")
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

        //[HttpPost]
        //public JsonResult InsertEstrategiaPortal(PedidoDetalleModel model)
        //{
        //    try
        //    {
        //        string mensaje;
        //        var beEstrategia = new ServicePedido.BEEstrategia
        //        {
        //            PaisID = userData.PaisID,
        //            Cantidad = Convert.ToInt32(model.Cantidad),
        //            CUV2 = model.CUV,
        //            CampaniaID = userData.CampaniaID,
        //            ConsultoraID = userData.ConsultoraID.ToString()
        //        };

        //        using (var svc = new PedidoServiceClient())
        //        {
        //            mensaje = svc.ValidarStockEstrategia(beEstrategia);
        //            if (model.FlagNueva == 1)
        //            {
        //                var bePedidoWebDetalleParametros = new BEPedidoWebDetalleParametros
        //                {
        //                    PaisId = userData.PaisID,
        //                    CampaniaId = userData.CampaniaID,
        //                    ConsultoraId = userData.ConsultoraID,
        //                    Consultora = userData.NombreConsultora,
        //                    EsBpt = EsOpt() == 1,
        //                    CodigoPrograma = userData.CodigoPrograma,
        //                    NumeroPedido = userData.ConsecutivoNueva
        //                };

        //                var detallePedidos = svc.SelectByCampania(bePedidoWebDetalleParametros).ToList();
        //                var pedido = detallePedidos.FirstOrDefault(p => p.FlagNueva);
        //                if (pedido != null)
        //                    svc.DelPedidoWebDetalle(pedido);
        //            }
        //        }

        //        if (mensaje != "OK")
        //        {
        //            return Json(new
        //            {
        //                result = false,
        //                message = mensaje
        //            }, JsonRequestBehavior.AllowGet);
        //        }

        //        var entidad = Mapper.Map<PedidoDetalleModel, BEPedidoWebDetalle>(model);
        //        using (var sv = new PedidoServiceClient())
        //        {
        //            entidad.PaisID = userData.PaisID;
        //            entidad.ConsultoraID = userData.ConsultoraID;
        //            entidad.CampaniaID = userData.CampaniaID;
        //            entidad.TipoOfertaSisID = 0;
        //            entidad.IPUsuario = userData.IPUsuario;
        //            entidad.CodigoUsuarioCreacion = userData.CodigoConsultora;
        //            entidad.CodigoUsuarioModificacion = entidad.CodigoUsuarioCreacion;
        //            entidad.OrigenPedidoWeb = ProcesarOrigenPedido(entidad.OrigenPedidoWeb);
        //            sv.InsPedidoWebDetalleOferta(entidad);
        //        }

        //        UpdPedidoWebMontosPROL();

        //        if (!string.IsNullOrEmpty(entidad.CUV))
        //        {
        //            var indPedidoAutentico = new BEIndicadorPedidoAutentico
        //            {
        //                PedidoID = entidad.PedidoID,
        //                CampaniaID = entidad.CampaniaID,
        //                PedidoDetalleID = entidad.PedidoDetalleID,
        //                IndicadorIPUsuario = GetIPCliente(),
        //                IndicadorFingerprint = "",
        //                IndicadorToken = SessionManager.GetTokenPedidoAutentico() != null
        //                    ? SessionManager.GetTokenPedidoAutentico().ToString()
        //                    : ""
        //            };
        //            InsIndicadorPedidoAutentico(indPedidoAutentico, entidad.CUV);
        //        }

        //        object jsoNdata = new
        //        {
        //            success = true,
        //            message = "Se agrego la estrategia satisfactoriamente.",
        //            extra = ""
        //        };

        //        return Json(jsoNdata);
        //    }
        //    catch (FaultException ex)
        //    {
        //        LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);

        //        return Json(new
        //        {
        //            success = false,
        //            message = ex.Message,
        //            extra = ""
        //        });
        //    }
        //    catch (Exception ex)
        //    {
        //        LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
        //        return Json(new
        //        {
        //            success = false,
        //            message = ex.Message,
        //            extra = ""
        //        });
        //    }
        //}

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
                ViewBag.ddlCampania = _zonificacionProvider.GetCampanias(userData.PaisID);

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

                lst.Update(x => x.ImagenURL = ConfigS3.GetUrlFileS3Matriz(userData.CodigoISO, x.ImagenURL));

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
            ViewBag.ddlCampania = _zonificacionProvider.GetCampanias(userData.PaisID);

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
                    PaisID = userData.PaisID,
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
                entidad.PaisID = userData.PaisID;

                using (var sv = new PedidoServiceClient())
                {
                    resultado = await sv.InsConfiguracionProgramaNuevasAppAsync(entidad);
                }

                return Json(new
                {
                    success = resultado,
                    message = resultado ? "Se grabó con �xito los datos." : "Ocurrió un problema al intentar registrar los datos"
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

                var carpetaPais = string.Format(Constantes.ProgNuevas.CarpetaBanner, userData.CodigoISO,
                    Dictionaries.IncentivoProgramaNuevasNiveles[codigoNivel]);

                var newfilename = string.Empty;
                switch (tipoBanner)
                {
                    case Constantes.ProgNuevas.TipoBanner.BannerCupon:
                        newfilename = string.Format(Constantes.ProgNuevas.ArchivoBannerCupones, codigoPrograma, FileManager.RandomString());
                        break;
                    case Constantes.ProgNuevas.TipoBanner.BannerPremio:
                        newfilename = string.Format(Constantes.ProgNuevas.ArchivoBannerPremios, codigoPrograma, FileManager.RandomString());
                        break;
                }

                var result = ConfigS3.SetFileS3(Path.Combine(Globals.RutaTemporales, nombreArchivo), carpetaPais, newfilename);
                if (result)
                {
                    var entidad = new BEConfiguracionProgramaNuevasApp()
                    {
                        PaisID = userData.PaisID,
                        CodigoPrograma = codigoPrograma,
                        CodigoNivel = codigoNivel,
                        ArchivoBannerCupon = (tipoBanner == Constantes.ProgNuevas.TipoBanner.BannerCupon ? newfilename : null),
                        ArchivoBannerPremio = (tipoBanner == Constantes.ProgNuevas.TipoBanner.BannerPremio ? newfilename : null),
                    };

                    using (var sv = new PedidoServiceClient())
                    {
                        result = await sv.InsConfiguracionProgramaNuevasAppAsync(entidad);
                    }
                }

                return Json(new
                {
                    success = result,
                    extra = result ? ConfigS3.GetUrlFileS3(carpetaPais, newfilename) : "Ocurrió un problema al intentar registrar los datos"
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
                string carpetaPais = string.Format(Constantes.ProgNuevas.CarpetaBanner, userData.CodigoISO, Dictionaries.IncentivoProgramaNuevasNiveles[codigoNivel]);

                var entidad = new BEConfiguracionProgramaNuevasApp()
                {
                    PaisID = userData.PaisID,
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
                    ImgBannerCupon = ConfigS3.GetUrlFileS3(carpetaPais, filenameCupon),
                    ImgBannerPremio = ConfigS3.GetUrlFileS3(carpetaPais, filenamePremio)
                };

                return Json(new
                {
                    success = true,
                    extra = data
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
                ViewBag.ddlCampania = _zonificacionProvider.GetCampanias(userData.PaisID);

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

                lst.Update(x => x.ImagenURL = ConfigS3.GetUrlFileS3Matriz(userData.CodigoISO, x.ImagenURL));

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
            ViewBag.ddlCampania = _zonificacionProvider.GetCampanias(userData.PaisID);
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
                bool dbdefault = HttpUtility.ParseQueryString(((System.Web.HttpRequestWrapper)Request).UrlReferrer.Query)[_dbdefault].ToBool();

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
                List<DescripcionEstrategiaModel> descripcionEstrategiaModels;

                if (_ofertaBaseProvider.UsarMsPersonalizacion(userData.CodigoISO, model.TipoEstrategiaCodigo, dbdefault))
                {
                    descripcionEstrategiaModels = administrarEstrategiaProvider.UploadCsv(fileContent, userData.CodigoISO, model.TipoEstrategiaCodigo, model.CampaniaId);
                }
                else
                {
                    using (var svc = new SACServiceClient())
                    {
                        beDescripcionEstrategias = svc.ActualizarDescripcionEstrategia(model.Pais.ToInt(),
                            model.CampaniaId.ToInt(), model.TipoEstrategia.ToInt(), fileContent.ToArray()).ToList();
                    }
                    descripcionEstrategiaModels =
                        Mapper.Map<List<BEDescripcionEstrategia>, List<DescripcionEstrategiaModel>>(
                            beDescripcionEstrategias);
                }

                return Json(new
                {
                    listActualizado = descripcionEstrategiaModels.Where(x => x.Estado == 1),
                    listNoActualizado = descripcionEstrategiaModels.Where(x => x.Estado != 1)
                });

            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
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

        private void UploadFileShowroomValidarModel(DescripcionMasivoModel model)
        {
            if (model.Documento == null || model.Documento.ContentLength <= 0) throw new ArgumentException("El archivo esta vacío.");
            if (!model.Documento.FileName.EndsWith(".csv")) throw new ArgumentException("El archivo no tiene la extensión correcta.");
            if (model.Documento.ContentLength > 4 * 1024 * 1024) throw new ArgumentException("El archivo es demasiado extenso para ser procesado.");
        }

        private string UploadFileSetStrategyShowroomMensajeReadLineColumnas(string readLine, int cantidadColumnas)
        {
            string[] arrayHeader = readLine.Split('|');
            string columnObservation = string.Empty;
            if (arrayHeader.Length != cantidadColumnas)
            {
                throw new ArgumentException("Los títulos de las columnas no son los correctos.");
            }
            if (!arrayHeader[(int)Constantes.ColumnsSetStrategyShowroom.Position.CUV].ToLower().Equals(Constantes.ColumnsSetStrategyShowroom.CUV))
            {
                columnObservation = Constantes.ColumnsSetStrategyShowroom.CUV;
            }
            else if (!arrayHeader[(int)Constantes.ColumnsSetStrategyShowroom.Position.AllowedUnits].ToLower().Equals(Constantes.ColumnsSetStrategyShowroom.AllowedUnits))
            {
                columnObservation = Constantes.ColumnsSetStrategyShowroom.AllowedUnits;
            }
            else if (!arrayHeader[(int)Constantes.ColumnsSetStrategyShowroom.Position.NameSet].ToLower().Equals(Constantes.ColumnsSetStrategyShowroom.NameSet))
            {
                columnObservation = Constantes.ColumnsSetStrategyShowroom.NameSet;
            }
            else if (!arrayHeader[(int)Constantes.ColumnsSetStrategyShowroom.Position.BusinessTip].ToLower().Equals(Constantes.ColumnsSetStrategyShowroom.BusinessTip))
            {
                columnObservation = Constantes.ColumnsSetStrategyShowroom.BusinessTip;
            }
            else if (!arrayHeader[(int)Constantes.ColumnsSetStrategyShowroom.Position.IsSubcampaign].ToLower().Equals(Constantes.ColumnsSetStrategyShowroom.IsSubcampaign))
            {
                columnObservation = Constantes.ColumnsSetStrategyShowroom.IsSubcampaign;
            }
            else if (!arrayHeader[(int)Constantes.ColumnsSetStrategyShowroom.Position.OfferStatus].ToLower().Equals(Constantes.ColumnsSetStrategyShowroom.OfferStatus))
            {
                columnObservation = Constantes.ColumnsSetStrategyShowroom.OfferStatus;
            }

            return columnObservation;
        }

        private string UploadFileProductStrategyShowroomMensajeReadLineColumnas(string readLine, int cantidadColumnas)
        {
            string[] arrayHeader = readLine.Split('|');
            string columnObservation = string.Empty;

            if (arrayHeader.Length != cantidadColumnas)
            {
                throw new ArgumentException("Los títulos de las columnas no son los correctos.");
            }
            if (!arrayHeader[(int)Constantes.ColumnsProductStrategyShowroom.Position.CUV].ToLower().Equals(Constantes.ColumnsProductStrategyShowroom.CUV))
            {
                columnObservation = Constantes.ColumnsProductStrategyShowroom.CUV;
            }
            if (!arrayHeader[(int)Constantes.ColumnsProductStrategyShowroom.Position.Order].ToLower().Equals(Constantes.ColumnsProductStrategyShowroom.Order))
            {
                columnObservation = Constantes.ColumnsProductStrategyShowroom.Order;
            }
            if (!arrayHeader[(int)Constantes.ColumnsProductStrategyShowroom.Position.ProductName].ToLower().Equals(Constantes.ColumnsProductStrategyShowroom.ProductName))
            {
                columnObservation = Constantes.ColumnsProductStrategyShowroom.ProductName;
            }
            if (!arrayHeader[(int)Constantes.ColumnsProductStrategyShowroom.Position.Description].ToLower().Equals(Constantes.ColumnsProductStrategyShowroom.Description))
            {
                columnObservation = Constantes.ColumnsProductStrategyShowroom.Description;
            }

            return columnObservation;
        }

        [HttpPost]
        public ActionResult UploadFileSetStrategyShowroom(DescripcionMasivoModel model)
        {
            int[] numberRecords = null;
            int line = 0;
            int cantidadColumnas = 6;

            try
            {
                var strategyEntityList = new List<ServicePedido.BEEstrategia>();
                StreamReader streamReader = new StreamReader(model.Documento.InputStream, Encoding.Default);
                bool dbdefault = HttpUtility.ParseQueryString(((System.Web.HttpRequestWrapper)Request).UrlReferrer.Query)[_dbdefault].ToBool();

                UploadFileShowroomValidarModel(model);

                string readLine = streamReader.ReadLine();
                if (readLine != null)
                {
                    var columnObservation = UploadFileSetStrategyShowroomMensajeReadLineColumnas(readLine, cantidadColumnas);
                    if (columnObservation != string.Empty)
                    {
                        throw new ArgumentException(string.Format("Verificar los títulos de las columnas del archivo. <br /> Referencia: La observación se encontró en la columna '{0}'", columnObservation));
                    }

                    do
                    {
                        readLine = streamReader.ReadLine();
                        if (readLine == null) continue;
                        string[] arrayRows = readLine.Split('|');
                        if (arrayRows[0] == "CUV") continue;

                        if (arrayRows.Length != cantidadColumnas)
                        {
                            throw new ArgumentException(string.Format("Verificar la información del archivo (datos incompletos). <br /> Referencia: La observación se encontró en el CUV '{0}'", arrayRows[(int)Constantes.ColumnsSetStrategyShowroom.Position.CUV].ToString().TrimEnd()));
                        }
                        line++;
                        strategyEntityList.Add(new ServicePedido.BEEstrategia
                        {
                            CUV2 = arrayRows[(int)Constantes.ColumnsSetStrategyShowroom.Position.CUV].ToString().TrimEnd(),
                            LimiteVenta = int.Parse(arrayRows[(int)Constantes.ColumnsSetStrategyShowroom.Position.AllowedUnits]),
                            DescripcionCUV2 = arrayRows[(int)Constantes.ColumnsSetStrategyShowroom.Position.NameSet].ToString().TrimEnd(),
                            TextoLibre = arrayRows[(int)Constantes.ColumnsSetStrategyShowroom.Position.BusinessTip].ToString().TrimEnd(),
                            EsSubCampania = int.Parse(arrayRows[(int)Constantes.ColumnsSetStrategyShowroom.Position.IsSubcampaign]),
                            Activo = int.Parse(arrayRows[(int)Constantes.ColumnsSetStrategyShowroom.Position.OfferStatus])
                        });
                    }
                    while (readLine != null);

                    XElement strategyXML = new XElement("strategy",
                    from strategy in strategyEntityList
                    select new XElement("row",
                                 new XElement("CUV2", strategy.CUV2),
                                 new XElement("DescripcionCUV2", strategy.DescripcionCUV2),
                                 new XElement("LimiteVenta", strategy.LimiteVenta),
                                 new XElement("TextoLibre", strategy.TextoLibre),
                                 new XElement("EsSubCampania", strategy.EsSubCampania),
                                 new XElement("Activo", strategy.Activo)
                               ));


                    BEEstrategiaMasiva estrategia = new BEEstrategiaMasiva
                    {
                        EstrategiaXML = strategyXML,
                        TipoEstrategiaID = int.Parse(model.TipoEstrategia),
                        CampaniaID = int.Parse(model.CampaniaId),
                        UsuarioCreacion = userData.CodigoUsuarioHost,
                        UsuarioModificacion = userData.CodigoUsuarioHost,
                        PaisID = Util.GetPaisID(userData.CodigoISO)
                    };

                    if (_ofertaBaseProvider.UsarMsPersonalizacion(userData.CodigoISO, model.TipoEstrategiaCodigo, dbdefault))
                    {
                        numberRecords = new int[2];
                        var result = administrarEstrategiaProvider.UploadFileSetStrategyShowroom(estrategia, strategyEntityList, model.TipoEstrategiaCodigo);

                        numberRecords[0] = result;
                    }
                    else
                    {
                        using (var service = new PedidoServiceClient())
                        {
                            numberRecords = service.InsertarEstrategiaMasiva(estrategia);
                        }
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

        [HttpPost]
        public ActionResult UploadFileProductStrategyShowroom(DescripcionMasivoModel model)
        {
            int[] numberRecords = null;
            int line = 0;
            int cantidadColumnas = 4;

            try
            {
                var strategyEntityList = new List<ServicePedido.BEEstrategiaProducto>();
                StreamReader streamReader = new StreamReader(model.Documento.InputStream, Encoding.Default);
                bool dbdefault = HttpUtility.ParseQueryString(((System.Web.HttpRequestWrapper)Request).UrlReferrer.Query)[_dbdefault].ToBool();

                UploadFileShowroomValidarModel(model);

                string readLine = streamReader.ReadLine();
                if (readLine != null)
                {
                    var columnObservation = UploadFileProductStrategyShowroomMensajeReadLineColumnas(readLine, cantidadColumnas);
                    if (columnObservation != string.Empty)
                    {
                        throw new ArgumentException(string.Format("Verificar los títulos de las columnas del archivo. <br /> Referencia: La observación se encontró en la columna '{0}'", columnObservation));
                    }
                    do
                    {
                        readLine = streamReader.ReadLine();
                        if (readLine == null) continue;
                        string[] arrayRows = readLine.Split('|');
                        if (arrayRows[0] == "CUV") continue;

                        int evalResult;
                        if (arrayRows.Length != cantidadColumnas)
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
                        line++;
                        strategyEntityList.Add(new ServicePedido.BEEstrategiaProducto
                        {
                            CUV = arrayRows[(int)Constantes.ColumnsProductStrategyShowroom.Position.CUV].ToString().TrimEnd(),
                            NombreProducto = arrayRows[(int)Constantes.ColumnsProductStrategyShowroom.Position.ProductName].ToString().TrimEnd(),
                            Descripcion1 = arrayRows[(int)Constantes.ColumnsProductStrategyShowroom.Position.Description].ToString().TrimEnd(),
                            Orden = int.Parse(arrayRows[(int)Constantes.ColumnsProductStrategyShowroom.Position.Order])
                        });

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
                                 new XElement("Orden", strategy.Orden)
                               ));


                    BEEstrategiaMasiva estrategia = new BEEstrategiaMasiva
                    {
                        EstrategiaXML = strategyXML,
                        TipoEstrategiaID = int.Parse(model.TipoEstrategia),
                        CampaniaID = int.Parse(model.CampaniaId),
                        UsuarioCreacion = userData.CodigoUsuarioHost,
                        UsuarioModificacion = userData.CodigoUsuarioHost,
                        PaisID = Util.GetPaisID(userData.CodigoISO)
                    };

                    if (_ofertaBaseProvider.UsarMsPersonalizacion(userData.CodigoISO, model.TipoEstrategiaCodigo, dbdefault))
                    {
                        numberRecords = new int[2];
                        var result = administrarEstrategiaProvider.UploadFileProductStrategyShowroom(estrategia, strategyEntityList, model.TipoEstrategiaCodigo);

                        numberRecords[0] = result;
                        numberRecords[1] = 0;
                    }
                    else
                    {
                        using (var service = new PedidoServiceClient())
                        {
                            numberRecords = service.InsertarProductoShowroomMasiva(estrategia);
                        }
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