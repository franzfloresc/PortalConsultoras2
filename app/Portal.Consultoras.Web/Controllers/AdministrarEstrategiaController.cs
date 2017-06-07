using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceGestionWebPROL;
using Portal.Consultoras.Web.ServiceODS;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServiceSAC;
using Portal.Consultoras.Web.ServiceZonificacion;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.ServiceModel;
using System.Web.Mvc;
using System.Web.UI.WebControls;
using Portal.Consultoras.Web.ServiceUsuario;
using Portal.Consultoras.Web.CustomHelpers;
using System.Configuration;

namespace Portal.Consultoras.Web.Controllers
{
    public class AdministrarEstrategiaController : BaseController
    {

        public ActionResult Index()
        {
            if (!UsuarioModel.HasAcces(ViewBag.Permiso, "AdministrarEstrategia/Index"))
                return RedirectToAction("Index", "Bienvenida");

            string paisISO = Util.GetPaisISO(userData.PaisID);
            var carpetaPais = Globals.UrlMatriz + "/" + paisISO;
            var urlS3 = ConfigS3.GetUrlS3(carpetaPais);

            string habilitarNemotecnico = ObtenerValorTablaLogica(userData.PaisID, Constantes.TablaLogica.Plan20, Constantes.TablaLogicaDato.BusquedaNemotecnicoZonaEstrategia);

            var EstrategiaModel = new EstrategiaModel()
            {
                listaCampania = new List<CampaniaModel>(),
                listaPaises = DropDowListPaises(),
                ListaTipoEstrategia = DropDowListTipoEstrategia(),
                ListaEtiquetas = DropDowListEtiqueta(),
                UrlS3 = urlS3,
                habilitarNemotecnico = habilitarNemotecnico == "1",
                ExpValidacionNemotecnico = ConfigurationManager.AppSettings["ExpresionValidacionNemotecnico"]
            };
            return View(EstrategiaModel);
        }

        private IEnumerable<PaisModel> DropDowListPaises()
        {
            List<BEPais> lst;
            using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
            {
                if (UserData().RolID == 2) lst = sv.SelectPaises().ToList();
                else
                {
                    lst = new List<BEPais>();
                    lst.Add(sv.SelectPais(UserData().PaisID));
                }

            }
            Mapper.CreateMap<BEPais, PaisModel>()
                    .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID))
                    .ForMember(t => t.Nombre, f => f.MapFrom(c => c.Nombre))
                    .ForMember(t => t.NombreCorto, f => f.MapFrom(c => c.NombreCorto));

            return Mapper.Map<IList<BEPais>, IEnumerable<PaisModel>>(lst);
        }

        public JsonResult ObtenerPedidoAsociado(string CodigoPrograma)
        {
            IList<BEConfiguracionPackNuevas> lst;
            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                lst = sv.GetConfiguracionPackNuevas(UserData().PaisID, CodigoPrograma);
            }
            return Json(new { pedidoAsociado = lst }, JsonRequestBehavior.AllowGet);
        }

        private IEnumerable<EtiquetaModel> DropDowListEtiqueta()
        {
            IList<BEEtiqueta> lst;
            var entidad = new BEEtiqueta();
            entidad.PaisID = UserData().PaisID;
            entidad.Estado = -1;

            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                lst = sv.GetEtiquetas(entidad);
            }
            Mapper.CreateMap<BEEtiqueta, EtiquetaModel>()
                    .ForMember(t => t.EtiquetaID, f => f.MapFrom(c => c.EtiquetaID))
                    .ForMember(t => t.Descripcion, f => f.MapFrom(c => c.Descripcion));

            return Mapper.Map<IList<BEEtiqueta>, IEnumerable<EtiquetaModel>>(lst);
        }

        public JsonResult ObtenterCampanias(int PaisID)
        {
            PaisID = UserData().PaisID;
            IEnumerable<CampaniaModel> lst = DropDowListCampanias(PaisID);

            return Json(new
            {
                lista = lst
            }, JsonRequestBehavior.AllowGet);
        }

        private IEnumerable<CampaniaModel> DropDowListCampanias(int PaisID)
        {
            IList<BECampania> lst;
            using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
            {
                lst = sv.SelectCampanias(PaisID);
            }
            Mapper.CreateMap<BECampania, CampaniaModel>()
                    .ForMember(t => t.CampaniaID, f => f.MapFrom(c => c.CampaniaID))
                    .ForMember(t => t.Codigo, f => f.MapFrom(c => c.Codigo))
                    .ForMember(t => t.Anio, f => f.MapFrom(c => c.Anio))
                    .ForMember(t => t.NombreCorto, f => f.MapFrom(c => c.NombreCorto))
                    .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID))
                    .ForMember(t => t.Activo, f => f.MapFrom(c => c.Activo));

            return Mapper.Map<IList<BECampania>, IEnumerable<CampaniaModel>>(lst);
        }

        private IEnumerable<TipoEstrategiaModel> DropDowListTipoEstrategia()
        {
            List<BETipoEstrategia> lst;
            var entidad = new BETipoEstrategia();
            entidad.PaisID = UserData().PaisID;
            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                lst = sv.GetTipoEstrategias(entidad).ToList();
            }

            if (lst != null && lst.Count > 0)
            {
                var carpetaPais = Globals.UrlMatriz + "/" + UserData().CodigoISO;
                lst.Update(x => x.ImagenEstrategia = ConfigS3.GetUrlFileS3(carpetaPais, x.ImagenEstrategia, Globals.RutaImagenesMatriz + "/" + UserData().CodigoISO));
            }

            var lista = from a in lst
                        where a.FlagActivo == 1
                        select a;

            Mapper.CreateMap<BETipoEstrategia, TipoEstrategiaModel>()
                    .ForMember(t => t.TipoEstrategiaID, f => f.MapFrom(c => c.TipoEstrategiaID))
                    .ForMember(t => t.Descripcion, f => f.MapFrom(c => c.DescripcionEstrategia))
                    .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID))
                    .ForMember(t => t.FlagNueva, f => f.MapFrom(c => c.FlagNueva))
                    .ForMember(t => t.FlagRecoPerfil, f => f.MapFrom(c => c.FlagRecoPerfil))
                    .ForMember(t => t.FlagRecoProduc, f => f.MapFrom(c => c.FlagRecoProduc))
                    .ForMember(t => t.Imagen, f => f.MapFrom(c => c.ImagenEstrategia))
                    .ForMember(t => t.CodigoPrograma, f => f.MapFrom(c => c.CodigoPrograma));

            return Mapper.Map<IList<BETipoEstrategia>, IEnumerable<TipoEstrategiaModel>>(lista.ToList());
        }

        public class BEConfiguracionValidacionZERegionIDComparer : IEqualityComparer<BEConfiguracionValidacionZE>
        {
            public bool Equals(BEConfiguracionValidacionZE x, BEConfiguracionValidacionZE y)
            {
                return x.RegionID.Equals(y.RegionID);
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

            // consultar las regiones y zonas
            IList<BEConfiguracionValidacionZE> lst;
            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                lst = sv.GetRegionZonaZE(pais.GetValueOrDefault(), region.GetValueOrDefault(), zona.GetValueOrDefault());
            }
            // se crea el arbol de nodos para el control de la vista
            JsTreeModel[] tree = lst.Distinct<BEConfiguracionValidacionZE>(new BEConfiguracionValidacionZERegionIDComparer()).Select(
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
                    List<BEEstrategia> lst;
                    if (Consulta == "1")
                    {
                        var entidad = new BEEstrategia();
                        entidad.PaisID = UserData().PaisID;
                        entidad.TipoEstrategiaID = Convert.ToInt32(TipoEstrategiaID);
                        entidad.CUV2 = (CUV != "") ? CUV : "0";
                        entidad.CampaniaID = Convert.ToInt32(CampaniaID);
                        entidad.Activo = Activo;
                        entidad.Imagen = Imagen;

                        using (PedidoServiceClient sv = new PedidoServiceClient())
                        {
                            lst = sv.GetEstrategias(entidad).ToList();
                        }
                    }
                    else
                    {
                        lst = new List<BEEstrategia>();
                    }

                    string carpetapais = Globals.UrlMatriz + "/" + UserData().CodigoISO;

                    if (lst != null && lst.Count > 0)
                        lst.Update(x => x.ImagenURL = ConfigS3.GetUrlFileS3(carpetapais, x.ImagenURL, carpetapais));

                    // Usamos el modelo para obtener los datos
                    BEGrid grid = new BEGrid();
                    grid.PageSize = rows;
                    grid.CurrentPage = page;
                    grid.SortColumn = sidx;
                    grid.SortOrder = sord;
                    //int buscar = int.Parse(txtBuscar);
                    BEPager pag = new BEPager();
                    IEnumerable<BEEstrategia> items = lst;
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
                    items = items.ToList().Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);
                    pag = Util.PaginadorGenerico(grid, lst);

                    // Creamos la estructura
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
                                   a.CUV2.ToString(),
                                   a.DescripcionCUV2.ToString(),
                                   a.LimiteVenta.ToString(),
                                   a.CodigoProducto.ToString(),
                                   a.ImagenURL.ToString(),
                                   a.Activo.ToString()
                                    }
                               }
                    };
                    return Json(data, JsonRequestBehavior.AllowGet);
                }
                return RedirectToAction("Index", "AdministrarEstrategia");
            }
            catch (Exception ex)
            {
                return RedirectToAction("Index", "AdministrarEstrategia");
            }
        }

        [HttpGet]
        public ActionResult ConsultarTallaColor(string sidx, string sord, int page, int rows, string CampaniaID, string CUV)
        {
            if (ModelState.IsValid)
            {
                List<BETallaColor> lst = new List<BETallaColor>();

                var entidad = new BETallaColor();
                entidad.PaisID = UserData().PaisID;
                entidad.CampaniaID = Convert.ToInt32((CampaniaID != "") ? CampaniaID : "0");
                entidad.CUV = (CUV != "") ? CUV : "0";

                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    lst = sv.GetTallaColor(entidad).ToList();
                }

                // Usamos el modelo para obtener los datos
                BEGrid grid = new BEGrid();
                grid.PageSize = rows;
                grid.CurrentPage = page;
                grid.SortColumn = sidx;
                grid.SortOrder = sord;
                //int buscar = int.Parse(txtBuscar);
                BEPager pag = new BEPager();
                IEnumerable<BETallaColor> items = lst;

                items = items.ToList().Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);

                pag = Util.PaginadorGenerico(grid, lst);

                // Creamos la estructura
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
                                   a.CUV.ToString(),
                                   a.DescripcionCUV.ToString(),
                                   a.PrecioUnitario.ToString(),
                                   a.Tipo.ToString(),
                                   a.DescripcionTipo.ToString(),
                                   a.DescripcionTallaColor.ToString(),
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
            int resultado = 0;
            try
            {
                var entidad = new BETallaColor();
                entidad.ID = 0;
                entidad.CUV = "0";
                entidad.Tipo = "0";
                entidad.CampaniaID = 0;
                entidad.PaisID = UserData().PaisID;
                entidad.DescripcionTallaColor = xmlTallaColor;
                entidad.UsuarioRegistro = UserData().CodigoUsuario;
                entidad.UsuarioModificacion = UserData().CodigoUsuario;

                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    resultado = sv.InsertarTallaColorCUV(entidad);
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
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    extra = ""
                });
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

        [HttpPost]
        public JsonResult EliminarTallaColor(string Id)
        {
            int resultado = 0;
            try
            {
                var entidad = new BETallaColor();
                entidad.ID = Convert.ToInt32(Id);
                entidad.PaisID = UserData().PaisID;

                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    resultado = sv.EliminarTallaColor(entidad);
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
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    extra = ""
                });
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


        [HttpPost]
        public ActionResult ImagenEstrategiaUpload(string qqfile)
        {
            string FileName = string.Empty;
            try
            {
                // req. 1664 - Unificando todo en una unica carpeta temporal
                Stream inputStream = Request.InputStream;
                byte[] fileBytes = ReadFully(inputStream);
                string ffFileName = qqfile; // qqfile;
                var path = Path.Combine(Globals.RutaTemporales, ffFileName);
                System.IO.File.WriteAllBytes(path, fileBytes);
                if (!System.IO.File.Exists(Globals.RutaTemporales))
                    System.IO.Directory.CreateDirectory(Globals.RutaTemporales);
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
                    return Json(new { success = false, message = "El tamaño de imagen excede el máximo permitido. (Ancho: 62px - Alto: 62px)." }, "text/html");
                }
                image.Dispose();
                return Json(new { success = true, name = Path.GetFileName(path) }, "text/html");
            }
            catch (Exception)
            {
                return Json(new { success = false, message = "Hubo un error al cargar el archivo, intente nuevamente." }, "text/html");
            }
        }

        [HttpPost]
        public JsonResult GetOfertaByCUV(string CampaniaID, string CUV2,
            string TipoEstrategiaID, string CUV1, string flag,
            string FlagNueva, string FlagRecoProduc, string FlagRecoPerfil)
        {
            try
            {
                // agregar parametros para validar el tipo de recomendación (CUV o PERFIL)
                List<BEEstrategia> lst = new List<BEEstrategia>();

                var entidad = new BEEstrategia();
                entidad.PaisID = UserData().PaisID;
                entidad.CampaniaID = Convert.ToInt32(CampaniaID);
                entidad.CUV2 = CUV2;
                entidad.TipoEstrategiaID = Convert.ToInt32(TipoEstrategiaID);
                entidad.CUV1 = CUV1;
                entidad.Activo = Convert.ToInt32(flag);
                int resultado = -1, tipo = -1;
                if (FlagRecoProduc == "1") tipo = 0;
                if (FlagRecoPerfil == "1") tipo = 1;
                entidad.Cantidad = tipo;
                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    lst = sv.GetOfertaByCUV(entidad).ToList();
                    if (tipo > -1)
                    {
                        resultado = sv.ValidarCUVsRecomendados(entidad);
                    }
                }

                string mensaje = "", descripcion = "", precio = "", codigoSAP = ""; int enMatrizComercial = 1;
                string carpetaPais = Globals.UrlMatriz + "/" + UserData().CodigoISO; int idMatrizComercial = 0;
               
                string wsprecio = ""; ///GR-1060

                if (lst.Count > 0)
                {
                    if (tipo != 1)
                    {
                        if (resultado == 0)
                        {
                            if (FlagRecoProduc == "1") mensaje = "El CUV2 no está asociado a ningún otro.";
                            //if (FlagRecoPerfil == "1") mensaje = "El CUV2 no está asociado a ningún perfil.";
                            return Json(new
                            {
                                success = false,
                                message = mensaje,
                                descripcion = descripcion,
                                precio = precio,
                                extra = ""
                            }, JsonRequestBehavior.AllowGet);
                        }
                    }
                    mensaje = "OK";

                    decimal wspreciopack = 0;

                    using (ServicePROL.ServiceStockSsic svs = new ServicePROL.ServiceStockSsic())
                    {
                        svs.Url = ConfigurarUrlServiceProl();
                        wspreciopack = svs.wsObtenerPrecioPack(CUV2, UserData().CodigoISO, CampaniaID);
                    }

                    ///end GR-1060

                    descripcion = lst[0].DescripcionCUV2;
                    precio = lst[0].PrecioUnitario.ToString();
                    codigoSAP = lst[0].CodigoSAP.ToString();
                    enMatrizComercial = lst[0].EnMatrizComercial.ToInt();
                    idMatrizComercial = lst[0].IdMatrizComercial.ToInt();
                    wsprecio = wspreciopack.ToString();
                    //imagen1 = lst[0].FotoProducto01; // ConfigS3.GetUrlFileS3(carpetaPais, lst[0].FotoProducto01, Globals.RutaImagenesMatriz + "/" + userData.CodigoISO);
                    //imagen2 = ConfigS3.GetUrlFileS3(carpetaPais, lst[0].FotoProducto02, Globals.RutaImagenesMatriz + "/" + userData.CodigoISO);
                    //imagen3 = ConfigS3.GetUrlFileS3(carpetaPais, lst[0].FotoProducto03, Globals.RutaImagenesMatriz + "/" + userData.CodigoISO);
                    //imagen4 = ConfigS3.GetUrlFileS3(carpetaPais, lst[0].FotoProducto04, Globals.RutaImagenesMatriz + "/" + userData.CodigoISO);
                    //imagen5 = ConfigS3.GetUrlFileS3(carpetaPais, lst[0].FotoProducto05, Globals.RutaImagenesMatriz + "/" + userData.CodigoISO);
                    //imagen6 = ConfigS3.GetUrlFileS3(carpetaPais, lst[0].FotoProducto06, Globals.RutaImagenesMatriz + "/" + userData.CodigoISO);
                    //imagen7 = ConfigS3.GetUrlFileS3(carpetaPais, lst[0].FotoProducto07, Globals.RutaImagenesMatriz + "/" + userData.CodigoISO);
                    //imagen8 = ConfigS3.GetUrlFileS3(carpetaPais, lst[0].FotoProducto08, Globals.RutaImagenesMatriz + "/" + userData.CodigoISO);
                    //imagen9 = ConfigS3.GetUrlFileS3(carpetaPais, lst[0].FotoProducto09, Globals.RutaImagenesMatriz + "/" + userData.CodigoISO);
                    //imagen10 = ConfigS3.GetUrlFileS3(carpetaPais, lst[0].FotoProducto10, Globals.RutaImagenesMatriz + "/" + userData.CodigoISO);
                }

                return Json(new
                {
                    success = true,
                    message = mensaje,
                    descripcion = descripcion,
                    precio = precio,
                    wsprecio = wsprecio,
                    codigoSAP = codigoSAP,
                    enMatrizComercial = enMatrizComercial,
                    idMatrizComercial = idMatrizComercial,
                    extra = ""
                }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message.ToString(),
                    extra = ""
                }, JsonRequestBehavior.AllowGet);
            }
        }

        [HttpPost]
        public JsonResult RegistrarEstrategia(RegistrarEstrategiaModel model)
        {
            int resultado = 0;
            int OrdenEstrategia = (!string.IsNullOrEmpty(model.Orden) ? Convert.ToInt32(model.Orden) : 0);     /* SB20-312 */

            try
            {
                BEEstrategia entidad = Mapper.Map<RegistrarEstrategiaModel, BEEstrategia>(model);
                entidad.PaisID = UserData().PaisID;
                entidad.Orden = OrdenEstrategia;
                entidad.UsuarioCreacion = UserData().CodigoUsuario;
                entidad.UsuarioModificacion = UserData().CodigoUsuario;

                var respuestaServiceCdr = new List<RptProductoEstrategia>();

                if (entidad.Activo == 1 && entidad.CodigoTipoEstrategia != null && 
                    (model.CodigoTipoEstrategia == Constantes.TipoEstrategiaCodigo.OfertaParaTi ||
                    model.CodigoTipoEstrategia == Constantes.TipoEstrategiaCodigo.Lanzamiento ||
                    model.CodigoTipoEstrategia == Constantes.TipoEstrategiaCodigo.PackAltoDesembolso ||
                    model.CodigoTipoEstrategia == Constantes.TipoEstrategiaCodigo.OfertasParaMi))
                {
                    try
                    {
                        short id = 98;
                        var getProductosConfigura = (List<BETablaLogicaDatos>)Session[Constantes.ConstSession.TablaLogicaDatos + id.ToString()];
                        if (getProductosConfigura == null)
                        {
                            getProductosConfigura = new List<BETablaLogicaDatos>();
                            using (SACServiceClient sv = new SACServiceClient())
                            {
                                getProductosConfigura = sv.GetTablaLogicaDatos(userData.PaisID, id).ToList();
                            }
                            getProductosConfigura = getProductosConfigura ?? new List<BETablaLogicaDatos>();
                            Session[Constantes.ConstSession.TablaLogicaDatos + id.ToString()] = getProductosConfigura;
                        }

                        if (getProductosConfigura.Any())
                        {
                            var valida = getProductosConfigura.Find(d => d.TablaLogicaDatosID == 9802) ?? new BETablaLogicaDatos();
                            if (Convert.ToInt32(valida.Codigo) <= entidad.CampaniaID)
                            {
                                using (WsGestionWeb sv = new WsGestionWeb())
                                {
                                    respuestaServiceCdr = sv.GetEstrategiaProducto(entidad.CampaniaID.ToString(), userData.CodigoConsultora, entidad.CUV2, userData.CodigoISO).ToList();
                                }

                                respuestaServiceCdr = respuestaServiceCdr ?? new List<RptProductoEstrategia>();
                            }
                        }
                    }
                    catch (Exception)
                    {
                        respuestaServiceCdr = new List<RptProductoEstrategia>();
                    }
                }

                if (respuestaServiceCdr.Any())
                {
                    entidad.CodigoEstrategia = respuestaServiceCdr[0].codigo_estrategia;
                    if (entidad.CodigoEstrategia == "2001")
                    {
                        var listaHermanosE = new List<BEProducto>();
                        using (ODSServiceClient svc = new ODSServiceClient())
                        {
                            listaHermanosE = svc.GetListBrothersByCUV(userData.PaisID, userData.CampaniaID, entidad.CUV1).ToList();
                        }
                        listaHermanosE = listaHermanosE ?? new List<BEProducto>();
                        entidad.TieneVariedad = listaHermanosE.Any() ? 1 : 0;
                    }
                    else if (entidad.CodigoEstrategia == "2003")
                    {
                        entidad.TieneVariedad = 1;
                    }
                }

                if (string.IsNullOrEmpty(model.NumeroPedido))
                    model.NumeroPedido = "0";

                List<int> NumeroPedidosAsociados = model.NumeroPedido.Split(',').Select(Int32.Parse).ToList();
                BEEstrategiaDetalle estrategiaDetalle =  new BEEstrategiaDetalle();
                foreach (int item in NumeroPedidosAsociados) /*R20160301*/
                {
                    entidad.NumeroPedido = item;
                    using (PedidoServiceClient sv = new PedidoServiceClient())
                    {
                        if (entidad.CodigoTipoEstrategia != null)
                        {
                            if (entidad.EstrategiaID != 0 && entidad.CodigoTipoEstrategia.Equals(Constantes.TipoEstrategiaCodigo.Lanzamiento))
                            {
                                estrategiaDetalle = sv.GetEstrategiaDetalle(entidad.PaisID, entidad.EstrategiaID);
                            }
                            if (entidad.CodigoTipoEstrategia.Equals(Constantes.TipoEstrategiaCodigo.Lanzamiento))
                            {
                                entidad = verficarArchivos(entidad, estrategiaDetalle);
                            }
                        }
                        entidad.EstrategiaID = sv.InsertarEstrategia(entidad);
                        
                    }
                }

                foreach (var producto in respuestaServiceCdr)
                {
                    var entidadPro = new BEEstrategiaProducto();
                    entidadPro.PaisID = entidad.PaisID;
                    entidadPro.EstrategiaID = entidad.EstrategiaID;
                    entidadPro.Campania = entidad.CampaniaID;
                    entidadPro.CUV = producto.cuv;
                    entidadPro.Grupo = producto.grupo;
                    entidadPro.Orden = producto.orden;
                    entidadPro.CUV2 = entidad.CUV2;
                    entidadPro.SAP = producto.codigo_sap;
                    entidadPro.Cantidad = producto.cantidad;
                    entidadPro.Precio = producto.precio_unitario;
                    entidadPro.PrecioValorizado = producto.precio_valorizado;
                    entidadPro.Digitable = producto.digitable;
                    entidadPro.CodigoEstrategia = producto.codigo_estrategia;
                    entidadPro.CodigoError = producto.codigo_error;
                    entidadPro.CodigoErrorObs = producto.obs_error;

                    using (PedidoServiceClient sv = new PedidoServiceClient())
                    {
                        entidadPro.EstrategiaProductoID = sv.InsertarEstrategiaProducto(entidadPro);
                    }
                }

                return Json(new
                {
                    success = true,
                    message = "Se grabó con éxito la estrategia.",
                    extra = ""
                });
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    extra = ""
                });
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

        [HttpPost]
        public JsonResult FiltrarEstrategia(string EstrategiaID, string cuv2, string CampaniaID, string TipoEstrategiaID)
        {
            try
            {
                List<BEEstrategia> lst = new List<BEEstrategia>();

                var entidad = new BEEstrategia();
                entidad.PaisID = UserData().PaisID;
                entidad.EstrategiaID = Convert.ToInt32(EstrategiaID);
                entidad.CampaniaID = Convert.ToInt32(CampaniaID);
                entidad.TipoEstrategiaID = Convert.ToInt32(TipoEstrategiaID);
                entidad.CUV2 = cuv2;

                using (PedidoServiceClient sv = new PedidoServiceClient())
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

                return Json(lst[0], JsonRequestBehavior.AllowGet);
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Ocurrió un problema al intentar acceder al servicio, intente nuevamente.",
                    extra = ""
                }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Ocurrió un problema al intentar acceder al servicio, intente nuevamente.",
                    extra = ""
                }, JsonRequestBehavior.AllowGet);
            }
        }

        [HttpPost]
        public JsonResult GetImagesBySapCode(int paisID, string estragiaId, string cuv2, string CampaniaID, string TipoEstrategiaID, int pagina)
        {
            List<BEMatrizComercialImagen> lst;
            BEEstrategia estrategia = new BEEstrategia();
            estrategia.PaisID = paisID;
            estrategia.EstrategiaID = Convert.ToInt32(estragiaId);
            estrategia.CUV2 = cuv2;
            estrategia.CampaniaID = Convert.ToInt32(CampaniaID);
            estrategia.TipoEstrategiaID = Convert.ToInt32(TipoEstrategiaID);

            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                lst = sv.GetImagenesByEstrategiaMatrizComercialImagen(estrategia, pagina, 10).ToList();
            }

            return GetImagesCommonResult(lst, paisID);
        }

        private JsonResult GetImagesCommonResult(List<BEMatrizComercialImagen> lst, int paisID)
        {
            int totalRegistros = lst.Any() ? lst[0].TotalRegistros : 0;
            var data = MapImages(lst, paisID);

            return Json(new { imagenes = data, totalRegistros = totalRegistros });
        }

        private List<MatrizComercialImagen> MapImages(List<BEMatrizComercialImagen> lst, int paisID)
        {
            string paisISO = Util.GetPaisISO(paisID);
            var carpetaPais = Globals.UrlMatriz + "/" + paisISO;
            var urlS3 = ConfigS3.GetUrlS3(carpetaPais);

            var data = lst.Select(p => new MatrizComercialImagen
            {
                IdMatrizComercialImagen = p.IdMatrizComercialImagen,
                FechaRegistro = p.FechaRegistro.HasValue ? p.FechaRegistro.Value : default(DateTime),
                Foto = urlS3 + p.Foto,
                NemoTecnico = p.NemoTecnico
            }).ToList();

            return data;
        }

        [HttpPost]
        public JsonResult FiltrarEstrategiaPedido(string EstrategiaID, int FlagNueva = 0)
        {
            List<BEEstrategia> lst;

            var entidad = new BEEstrategia();
            entidad.PaisID = UserData().PaisID;
            entidad.EstrategiaID = Convert.ToInt32(EstrategiaID);
            entidad.FlagNueva = FlagNueva;

            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                lst = sv.FiltrarEstrategiaPedido(entidad).ToList();
            }

            string carpetapais = Globals.UrlMatriz + "/" + UserData().CodigoISO;

            if (lst != null && lst.Count > 0)
            {
                lst.Update(x => x.FotoProducto01 = x.FotoProducto01); //ConfigS3.GetUrlFileS3(carpetapais, x.FotoProducto01, carpetapais));
                lst.Update(x => x.ImagenURL = ConfigS3.GetUrlFileS3(carpetapais, x.ImagenURL, carpetapais));
                lst.Update(x => x.Simbolo = UserData().Simbolo);
            }
            //R2469 - JICM - ViewBag Marcacion Detalle Producto
            ViewBag.ProductoDestacadoDetalle = lst[0];
            return Json(new
            {
                data = lst[0],
                precio = (UserData().PaisID == 4) ? lst[0].Precio.ToString("#,##0").Replace(',', '.') : lst[0].Precio.ToString("#,##0.00"),
                precio2 = (UserData().PaisID == 4) ? lst[0].Precio2.ToString("#,##0").Replace(',', '.') : lst[0].Precio2.ToString("#,##0.00")
            }, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult DeshabilitarEstrategia(string EstrategiaID)
        {
            try
            {
                int resultado = 0;

                var entidad = new BEEstrategia();
                entidad.PaisID = UserData().PaisID;
                entidad.EstrategiaID = Convert.ToInt32(EstrategiaID);
                entidad.UsuarioModificacion = UserData().CodigoUsuario;

                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    resultado = sv.DeshabilitarEstrategia(entidad);
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
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Ocurrió un problema al intentar acceder al servicio, intente nuevamente.",
                    extra = ""
                }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Ocurrió un problema al intentar acceder al servicio, intente nuevamente.",
                    extra = ""
                }, JsonRequestBehavior.AllowGet);
            }
        }


        [HttpPost]
        public JsonResult ActivarDesactivarEstrategias(string EstrategiasActivas, string EstrategiasDesactivas)
        {
            try
            {
                int resultado = 0;

                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    resultado = sv.ActivarDesactivarEstrategias(UserData().PaisID, UserData().CodigoUsuario, EstrategiasActivas, EstrategiasDesactivas);
                }

                return Json(new
                {
                    success = true,
                    message = resultado > 0 ? "No se activaron algunas estrategias por no contar con los requisitos de límite de venta o imagen" : "Se actualizaron las estrategias correctamente.",
                    extra = ""
                }, JsonRequestBehavior.AllowGet);
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Ocurrió un problema al intentar acceder al servicio, intente nuevamente.",
                    extra = ""
                }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Ocurrió un problema al intentar acceder al servicio, intente nuevamente.",
                    extra = ""
                }, JsonRequestBehavior.AllowGet);
            }
        }

        private void ValidarStatusCampania(BEConfiguracionCampania oBEConfiguracionCampania)
        {
            UsuarioModel usuario = UserData();
            usuario.ZonaValida = oBEConfiguracionCampania.ZonaValida;
            usuario.FechaInicioCampania = oBEConfiguracionCampania.FechaInicioFacturacion;
            usuario.FechaFinCampania = oBEConfiguracionCampania.FechaInicioFacturacion.AddDays(oBEConfiguracionCampania.DiasDuracionCronograma - 1);
            usuario.HoraInicioReserva = oBEConfiguracionCampania.HoraInicio;
            usuario.HoraFinReserva = oBEConfiguracionCampania.HoraFin;
            usuario.HoraInicioPreReserva = oBEConfiguracionCampania.HoraInicioNoFacturable;
            usuario.HoraFinPreReserva = oBEConfiguracionCampania.HoraCierreNoFacturable;
            usuario.DiasCampania = oBEConfiguracionCampania.DiasAntes;
            //usuario.DiaPROL = ValidarPROL(usuario);
            usuario.NombreCorto = oBEConfiguracionCampania.CampaniaDescripcion;
            usuario.CampaniaID = oBEConfiguracionCampania.CampaniaID;
            usuario.ZonaHoraria = oBEConfiguracionCampania.ZonaHoraria;
            usuario.HoraCierreZonaDemAnti = oBEConfiguracionCampania.HoraCierreZonaDemAnti;
            usuario.HoraCierreZonaNormal = oBEConfiguracionCampania.HoraCierreZonaNormal;

            if (DateTime.Now.AddHours(oBEConfiguracionCampania.ZonaHoraria) < oBEConfiguracionCampania.FechaInicioFacturacion.AddDays(-oBEConfiguracionCampania.DiasAntes))
            {
                usuario.FechaFacturacion = oBEConfiguracionCampania.FechaInicioFacturacion.AddDays(-oBEConfiguracionCampania.DiasAntes);
                usuario.HoraFacturacion = oBEConfiguracionCampania.HoraInicioNoFacturable;
            }
            else
            {
                usuario.FechaFacturacion = oBEConfiguracionCampania.FechaFinFacturacion;
                usuario.HoraFacturacion = oBEConfiguracionCampania.HoraFin;
            }
            SetUserData(usuario);
        }

        public string GetDescripcionMarca(int MarcaID)
        {
            string result = string.Empty;

            switch (MarcaID)
            {
                case 1:
                    result = "L'Bel";
                    break;
                case 2:
                    result = "Ésika";
                    break;
                case 3:
                    result = "Cyzone";
                    break;
                case 6:
                    result = "Finart";
                    break;
            }

            return result;
        }

        [HttpPost]
        public List<BEEstrategia> ConsultarEstrategias()
        {
            List<BEEstrategia> lst;

            var entidad = new BEEstrategia();
            entidad.PaisID = userData.PaisID;
            entidad.CampaniaID = userData.CampaniaID;
            entidad.ConsultoraID = userData.ConsultoraID.ToString();
            entidad.CUV2 = "";
            entidad.Zona = userData.ZonaID.ToString();
            entidad.ZonaHoraria = userData.ZonaHoraria;
            entidad.FechaInicioFacturacion = userData.FechaFinCampania;

            using (var sv = new PedidoServiceClient())
            {
                lst = sv.GetEstrategiasPedido(entidad).ToList();
            }

            string carpetapais = Globals.UrlMatriz + "/" + userData.CodigoISO;

            if (lst != null && lst.Count > 0)
            {
                lst.ForEach(x => x.ImagenURL = ConfigS3.GetUrlFileS3(carpetapais, x.ImagenURL, carpetapais));
            }

            return lst;
        }

        [HttpPost]
        public JsonResult InsertEstrategiaPortal(PedidoDetalleModel model)
        {
            object JSONdata = null;

            try
            {
                string mensaje = "";
                var BEEstrategia = new BEEstrategia();
                BEEstrategia.PaisID = UserData().PaisID;
                BEEstrategia.Cantidad = Convert.ToInt32(model.Cantidad);
                BEEstrategia.CUV2 = model.CUV;
                BEEstrategia.CampaniaID = UserData().CampaniaID;
                BEEstrategia.ConsultoraID = UserData().ConsultoraID.ToString();

                using (PedidoServiceClient svc = new PedidoServiceClient())
                {
                    mensaje = svc.ValidarStockEstrategia(BEEstrategia);
                    if (model.FlagNueva == 1)
                    {
                        List<BEPedidoWebDetalle> DetallePedidos = svc.SelectByCampania(UserData().PaisID, UserData().CampaniaID, UserData().ConsultoraID, UserData().NombreConsultora).ToList();
                        BEPedidoWebDetalle Pedido = DetallePedidos.FirstOrDefault(p => p.TipoEstrategiaID == 1);
                        if (Pedido != null)
                            svc.DelPedidoWebDetalle(Pedido);
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

                Mapper.CreateMap<PedidoDetalleModel, BEPedidoWebDetalle>()
                    .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID))
                    .ForMember(t => t.CampaniaID, f => f.MapFrom(c => c.CampaniaID))
                    .ForMember(t => t.ConsultoraID, f => f.MapFrom(c => c.ConsultoraID))
                    .ForMember(t => t.MarcaID, f => f.MapFrom(c => c.MarcaID))
                    .ForMember(t => t.Cantidad, f => f.MapFrom(c => c.Cantidad))
                    .ForMember(t => t.PrecioUnidad, f => f.MapFrom(c => c.PrecioUnidad))
                    .ForMember(t => t.CUV, f => f.MapFrom(c => c.CUV))
                    .ForMember(t => t.ConfiguracionOfertaID, f => f.MapFrom(c => c.ConfiguracionOfertaID))
                    .ForMember(t => t.TipoOfertaSisID, f => f.MapFrom(c => c.TipoOfertaSisID));

                BEPedidoWebDetalle entidad = Mapper.Map<PedidoDetalleModel, BEPedidoWebDetalle>(model);
                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    entidad.PaisID = UserData().PaisID;
                    entidad.ConsultoraID = UserData().ConsultoraID;
                    entidad.CampaniaID = UserData().CampaniaID;
                    entidad.TipoOfertaSisID = 0; // Constantes.ConfiguracionOferta.Web;
                    entidad.IPUsuario = UserData().IPUsuario;

                    entidad.CodigoUsuarioCreacion = UserData().CodigoConsultora;
                    entidad.CodigoUsuarioModificacion = entidad.CodigoUsuarioCreacion;

                    sv.InsPedidoWebDetalleOferta(entidad);

                }

                UpdPedidoWebMontosPROL();

                //EPD-2248
                if (entidad != null)
                {
                    BEIndicadorPedidoAutentico indPedidoAutentico = new BEIndicadorPedidoAutentico();
                    indPedidoAutentico.PedidoID = entidad.PedidoID;
                    indPedidoAutentico.CampaniaID = entidad.CampaniaID;
                    indPedidoAutentico.PedidoDetalleID = entidad.PedidoDetalleID;
                    indPedidoAutentico.IndicadorIPUsuario = GetIPCliente();
                    indPedidoAutentico.IndicadorFingerprint = (Session["Fingerprint"] != null) ? Session["Fingerprint"].ToString() : "";
                    indPedidoAutentico.IndicadorToken = (Session["TokenPedidoAutentico"] != null) ? Session["TokenPedidoAutentico"].ToString() : ""; ;

                    InsIndicadorPedidoAutentico(indPedidoAutentico, entidad.CUV);
                }
                //EPD-2248

                JSONdata = new
                {
                    success = true,
                    message = "Se agregó la estrategia satisfactoriamente.",
                    extra = ""
                };

                return Json(JSONdata);
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    extra = ""
                });
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

        public ActionResult EstrategiasAll()
        {
            try
            {
                //if (!UsuarioModel.HasAcces(ViewBag.Permiso, "AdministrarEstrategia/EstrategiasAll"))
                //    return RedirectToAction("Index", "Bienvenida");

                ViewBag.CampaniaID = UserData().CampaniaID.ToString();
                ViewBag.ISO = UserData().CodigoISO.ToString();
                ViewBag.Simbolo = UserData().Simbolo.ToString().Trim();
                ViewBag.PaisID = UserData().PaisID.ToString().Trim();
                BEConfiguracionCampania oBEConfiguracionCampania = null;
                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    oBEConfiguracionCampania = sv.GetEstadoPedido(UserData().PaisID, UserData().CampaniaID, UserData().ConsultoraID, UserData().ZonaID, UserData().RegionID);

                }
                if (oBEConfiguracionCampania != null)
                    ValidarStatusCampania(oBEConfiguracionCampania);

                List<BEEstrategia> lista = ConsultarEstrategias();

                foreach (var item in lista)
                {
                    var entidad = new BEEstrategia();
                    entidad.PaisID = UserData().PaisID;
                    entidad.EstrategiaID = item.EstrategiaID;
                    using (PedidoServiceClient sv = new PedidoServiceClient())
                    {
                        item.TallaColor = sv.FiltrarEstrategiaPedido(entidad).ToList()[0].TallaColor;
                    }
                }

                ViewBag.ListaEstrategias = lista;
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
            }
            return View();
        }

        public ActionResult ConsultarOfertasParaTi(string sidx, string sord, int page, int rows, string CampaniaID, int EstrategiaID)
        {
            if (ModelState.IsValid)
            {
                List<ComunModel> lst = new List<ComunModel>();
                int cantidadEstrategiasConfiguradas = 0;
                int cantidadEstrategiasSinConfigurar = 0;
                int tipoEstrategia = Convert.ToInt32(EstrategiaID);

                try
                {
                    using (PedidoServiceClient ps = new PedidoServiceClient())
                    {
                        cantidadEstrategiasConfiguradas = ps.GetCantidadOfertasParaTi(userData.PaisID, int.Parse(CampaniaID), 1, EstrategiaID);
                        cantidadEstrategiasSinConfigurar = ps.GetCantidadOfertasParaTi(userData.PaisID, int.Parse(CampaniaID), 2, EstrategiaID);
                    }
                }
                catch (Exception ex)
                {
                    cantidadEstrategiasConfiguradas = 0;
                    cantidadEstrategiasSinConfigurar = 0;
                }

                lst.Add(new ComunModel
                {
                    Id = 1,
                    Descripcion = "CUVS encontrados en ofertas personalizadas.",
                    Valor = (cantidadEstrategiasConfiguradas + cantidadEstrategiasSinConfigurar).ToString(),
                    ValorOpcional = "0"
                });
                lst.Add(new ComunModel
                {
                    Id = 2,
                    Descripcion = "CUVS configurados en Zonas de Estrategias",
                    Valor = cantidadEstrategiasConfiguradas.ToString(),
                    ValorOpcional = "1"
                });
                lst.Add(new ComunModel
                {
                    Id = 3,
                    Descripcion = "CUVS por configurar en Zonas de Estrategias",
                    Valor = cantidadEstrategiasSinConfigurar.ToString(),
                    ValorOpcional = "2"
                });

                // Usamos el modelo para obtener los datos
                BEGrid grid = new BEGrid();
                grid.PageSize = rows;
                grid.CurrentPage = page;
                grid.SortColumn = sidx;
                grid.SortOrder = sord;
                //int buscar = int.Parse(txtBuscar);
                BEPager pag = new BEPager();
                IEnumerable<ComunModel> items = lst;

                items = items.ToList().Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);

                pag = Util.PaginadorGenerico(grid, lst);

                // Creamos la estructura
                var data = new
                {
                    total = pag.PageCount,
                    page = pag.CurrentPage,
                    records = pag.RecordCount,
                    rows = from a in items
                           select new
                           {
                               id = a.Id,
                               cell = new string[]
                               {
                                   a.Id.ToString(),
                                   a.Descripcion,
                                   a.Valor,
                                   a.ValorOpcional
                                }
                           }
                };
                return Json(data, JsonRequestBehavior.AllowGet);
            }
            return RedirectToAction("Index", "AdministrarEstrategia");
        }

        public ActionResult ConsultarCuvTipoConfigurado(string sidx, string sord, int page, int rows, int campaniaId, int tipoConfigurado, int estrategiaID)
        {
            if (ModelState.IsValid)
            {
                List<BEEstrategia> lst = new List<BEEstrategia>();

                try
                {
                    using (PedidoServiceClient ps = new PedidoServiceClient())
                    {
                        lst = ps.GetOfertasParaTiByTipoConfigurado(userData.PaisID, campaniaId, tipoConfigurado, estrategiaID).ToList();
                    }
                }
                catch (Exception ex)
                {
                    lst = new List<BEEstrategia>();
                }

                // Usamos el modelo para obtener los datos
                BEGrid grid = new BEGrid();
                grid.PageSize = rows;
                grid.CurrentPage = page;
                grid.SortColumn = sidx;
                grid.SortOrder = sord;
                //int buscar = int.Parse(txtBuscar);
                BEPager pag = new BEPager();
                IEnumerable<BEEstrategia> items = lst;

                items = items.ToList().Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);

                pag = Util.PaginadorGenerico(grid, lst);

                // Creamos la estructura
                var data = new
                {
                    total = pag.PageCount,
                    page = pag.CurrentPage,
                    records = pag.RecordCount,
                    rows = from a in items
                           select new
                           {
                               id = a.CUV2,
                               cell = new string[]
                               {
                                   a.CUV2,
                                   a.DescripcionCUV2
                               }
                           }
                };
                return Json(data, JsonRequestBehavior.AllowGet);
            }
            return RedirectToAction("Index", "AdministrarEstrategia");
        }

        public JsonResult InsertEstrategiaTemporal(int campaniaId, int tipoConfigurado, int estrategiaID, bool habilitarNemotecnico)
        {
            try
            {
                List<BEEstrategia> lst = new List<BEEstrategia>();

                try
                {
                    using (PedidoServiceClient ps = new PedidoServiceClient())
                    {
                        lst = ps.GetOfertasParaTiByTipoConfigurado(userData.PaisID, campaniaId, tipoConfigurado, estrategiaID).ToList();
                    }

                    foreach (var opt in lst)
                    {
                        decimal precioOferta = 0;
                       
                        try
                        {
                            using (ServicePROL.ServiceStockSsic svs = new ServicePROL.ServiceStockSsic())
                            {
                                svs.Url = ConfigurarUrlServiceProl();
                                precioOferta = svs.wsObtenerPrecioPack(opt.CUV2, userData.CodigoISO, campaniaId.ToString());
                            }

                            if (habilitarNemotecnico)
                            {
                                List<RptProductoEstrategia> productoEstrategias = new List<RptProductoEstrategia>();
                                string nemoTecnicoBusqueda = String.Empty;
                                //TODO: Agregar el servicio de buscar por CUV2 el CODIGO SAP y CANTIDAD
                                using (ServiceGestionWebPROL.WsGestionWeb svs = new ServiceGestionWebPROL.WsGestionWeb())
                                {
                                    productoEstrategias = svs.GetEstrategiaProducto(campaniaId.ToString(), String.Empty, opt.CUV2, userData.CodigoISO.ToString()).ToList();
                                }

                                List<string> nemotecnicosLista = new List<string>();
                                int contadorNemotecnico = 0;
                                string grupoPrevio = String.Empty;

                                foreach (RptProductoEstrategia productoEstrategia in productoEstrategias)
                                {
                                    if ((productoEstrategia.codigo_estrategia == "2001" || productoEstrategia.codigo_estrategia == "2002") ||
                                        (productoEstrategia.codigo_estrategia == "2003" && (grupoPrevio!= productoEstrategia.grupo)))
                                    {
                                        grupoPrevio = productoEstrategia.grupo;
                                        string codigoSap = productoEstrategia.codigo_sap;
                                        string cantidad = (productoEstrategia.cantidad.ToString().Length < 2) ? "0" + productoEstrategia.cantidad.ToString() : productoEstrategia.cantidad.ToString();
                                        nemotecnicosLista.Add(String.Format("{0}#{1}", codigoSap, cantidad));
                                    }
                                
                                }
                                foreach (String nemoTecnico in nemotecnicosLista)
                                {
                                    if(contadorNemotecnico==0)
                                        nemoTecnicoBusqueda += nemoTecnico;
                                    else
                                        nemoTecnicoBusqueda += "&" + nemoTecnico;
                                    contadorNemotecnico++;
                                }

                                List<BEMatrizComercialImagen> lstImagenes = new List<BEMatrizComercialImagen>();
                                using (PedidoServiceClient ps = new PedidoServiceClient())
                                {
                                    lstImagenes = ps.GetImagenByNemotecnico(userData.PaisID, 0, null, null, 0, 0, 0, nemoTecnicoBusqueda, Common.Constantes.TipoBusqueda.Exacta, 1, 1).ToList();
                                    opt.FotoProducto01 = lstImagenes.Any() ? lstImagenes[0].Foto : String.Empty;
                                }
                            }

                        }
                        catch (Exception ex)
                        {
                            precioOferta = 0;
                        }

                        if (precioOferta > 0)
                            opt.Precio2 = precioOferta;

                        //sera el precio tachado ya que la propiedad PrecioTachado es de tipo String
                        opt.Precio = 0; //cuvServiceProl.importevalorizado;
                    }
                }
                catch (Exception ex)
                {
                    lst = new List<BEEstrategia>();
                }

                if (lst.Count > 0)
                {
                    try
                    {
                        using (PedidoServiceClient ps = new PedidoServiceClient())
                        {
                            ps.InsertEstrategiaTemporal(userData.PaisID, lst.ToArray(), campaniaId, userData.CodigoUsuario);
                        }
                    }
                    catch (Exception ex)
                    {
                        return Json(new
                        {
                            success = false,
                            message = "Error al insertar las estrategias"
                        }, JsonRequestBehavior.AllowGet);
                    }

                    return Json(new
                    {
                        success = true,
                        message = "Se insertaron en la tabla temporal de Estrategia.",
                        extra = ""
                    }, JsonRequestBehavior.AllowGet);
                }

                return Json(new
                {
                    success = false,
                    message = "No existen Estrategias para Insertar"
                }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return Json(new
                {
                    success = false,
                    message = ex.Message
                }, JsonRequestBehavior.AllowGet);
            }
        }

        public ActionResult ConsultarOfertasParaTiTemporal(string sidx, string sord, int page, int rows, string CampaniaID)
        {
            if (ModelState.IsValid)
            {
                List<ComunModel> lst = new List<ComunModel>();
                int cantidadEstrategiasConfiguradas = 0;
                int cantidadEstrategiasSinConfigurar = 0;

                try
                {
                    using (PedidoServiceClient ps = new PedidoServiceClient())
                    {
                        cantidadEstrategiasConfiguradas = ps.GetCantidadOfertasParaTiTemporal(userData.PaisID, int.Parse(CampaniaID), 1);
                        cantidadEstrategiasSinConfigurar = ps.GetCantidadOfertasParaTiTemporal(userData.PaisID, int.Parse(CampaniaID), 2);
                    }
                }
                catch (Exception ex)
                {
                    cantidadEstrategiasConfiguradas = 0;
                    cantidadEstrategiasSinConfigurar = 0;
                }

                lst.Add(new ComunModel
                {
                    Id = 1,
                    Descripcion = "CUVS pre cargados correctamente",
                    Valor = cantidadEstrategiasConfiguradas.ToString(),
                    ValorOpcional = "1"
                });
                lst.Add(new ComunModel
                {
                    Id = 2,
                    Descripcion = "CUVS no pre cargados",
                    Valor = cantidadEstrategiasSinConfigurar.ToString(),
                    ValorOpcional = "2"
                });

                // Usamos el modelo para obtener los datos
                BEGrid grid = new BEGrid();
                grid.PageSize = rows;
                grid.CurrentPage = page;
                grid.SortColumn = sidx;
                grid.SortOrder = sord;
                //int buscar = int.Parse(txtBuscar);
                BEPager pag = new BEPager();
                IEnumerable<ComunModel> items = lst;

                items = items.ToList().Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);

                pag = Util.PaginadorGenerico(grid, lst);

                // Creamos la estructura
                var data = new
                {
                    total = pag.PageCount,
                    page = pag.CurrentPage,
                    records = pag.RecordCount,
                    rows = from a in items
                           select new
                           {
                               id = a.Id,
                               cell = new string[]
                               {
                                   a.Id.ToString(),
                                   a.Descripcion,
                                   a.Valor,
                                   a.ValorOpcional
                                }
                           }
                };
                return Json(data, JsonRequestBehavior.AllowGet);
            }
            return RedirectToAction("Index", "AdministrarEstrategia");
        }

        public ActionResult ConsultarCuvTipoConfiguradoTemporal(string sidx, string sord, int page, int rows, int campaniaId, int tipoConfigurado)
        {
            if (ModelState.IsValid)
            {
                List<BEEstrategia> lst = new List<BEEstrategia>();

                try
                {
                    using (PedidoServiceClient ps = new PedidoServiceClient())
                    {
                        lst = ps.GetOfertasParaTiByTipoConfiguradoTemporal(userData.PaisID, campaniaId, tipoConfigurado).ToList();
                    }
                }
                catch (Exception ex)
                {
                    lst = new List<BEEstrategia>();
                }

                // Usamos el modelo para obtener los datos
                BEGrid grid = new BEGrid();
                grid.PageSize = rows;
                grid.CurrentPage = page;
                grid.SortColumn = sidx;
                grid.SortOrder = sord;
                //int buscar = int.Parse(txtBuscar);
                BEPager pag = new BEPager();
                IEnumerable<BEEstrategia> items = lst;

                items = items.ToList().Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);

                pag = Util.PaginadorGenerico(grid, lst);

                // Creamos la estructura
                var data = new
                {
                    total = pag.PageCount,
                    page = pag.CurrentPage,
                    records = pag.RecordCount,
                    rows = from a in items
                           select new
                           {
                               id = a.CUV2,
                               cell = new string[]
                               {
                                   a.CUV2,
                                   a.DescripcionCUV2
                               }
                           }
                };
                return Json(data, JsonRequestBehavior.AllowGet);
            }
            return RedirectToAction("Index", "AdministrarEstrategia");
        }

        public JsonResult CancelarInsertEstrategiaTemporal(int campaniaId)
        {
            try
            {
                using (PedidoServiceClient ps = new PedidoServiceClient())
                {
                    ps.DeleteEstrategiaTemporal(userData.PaisID, campaniaId);
                }
            }
            catch (Exception ex)
            {
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    extra = ""
                }, JsonRequestBehavior.AllowGet);
            }

            return Json(new
            {
                success = true,
                message = "Se eliminaron las estrategias de la tabla temporal",
                extra = ""
            }, JsonRequestBehavior.AllowGet);
        }

        public JsonResult InsertEstrategiaOfertaParaTi(int campaniaId, int tipoConfigurado, int estrategiaId)
        {
            try
            {
                List<BEEstrategia> lst = new List<BEEstrategia>();

                try
                {
                    using (PedidoServiceClient ps = new PedidoServiceClient())
                    {
                        lst = ps.GetOfertasParaTiByTipoConfiguradoTemporal(userData.PaisID, campaniaId, tipoConfigurado).ToList();
                    }
                }
                catch (Exception ex)
                {
                    lst = new List<BEEstrategia>();
                }

                if (lst.Count > 0)
                {
                    try
                    {
                        using (PedidoServiceClient ps = new PedidoServiceClient())
                        {
                            ps.InsertEstrategiaOfertaParaTi(userData.PaisID, lst.ToArray(), campaniaId, userData.CodigoUsuario, estrategiaId);
                        }
                    }
                    catch (Exception ex)
                    {
                        return Json(new
                        {
                            success = false,
                            message = "Error al insertar las estrategias"
                        }, JsonRequestBehavior.AllowGet);
                    }

                    return Json(new
                    {
                        success = true,
                        message = "Se insertaron las Estrategias.",
                        extra = ""
                    }, JsonRequestBehavior.AllowGet);
                }

                return Json(new
                {
                    success = false,
                    message = "No existen Estrategias para Insertar"
                }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return Json(new
                {
                    success = false,
                    message = ex.Message
                }, JsonRequestBehavior.AllowGet);
            }
        }

        public static byte[] ReadFully(Stream input)
        {
            byte[] buffer = new byte[16 * 1024];
            using (MemoryStream ms = new MemoryStream())
            {
                int read;
                while ((read = input.Read(buffer, 0, buffer.Length)) > 0)
                {
                    ms.Write(buffer, 0, read);
                }
                return ms.ToArray();
            }
        }

        public BEEstrategia verficarArchivos(BEEstrategia estrategia, BEEstrategiaDetalle estrategiaDetalle)
        {
            if (!String.IsNullOrEmpty(estrategia.ImgFondoDesktop) && 
                (String.IsNullOrEmpty(estrategiaDetalle.ImgFondoDesktop) || estrategia.ImgFondoDesktop != estrategiaDetalle.ImgFondoDesktop))
                estrategia.ImgFondoDesktop = SaveFileS3(estrategia.ImgFondoDesktop);

            if (!String.IsNullOrEmpty(estrategia.ImgPrevDesktop) && 
                (String.IsNullOrEmpty(estrategiaDetalle.ImgPrevDesktop) || estrategia.ImgPrevDesktop != estrategiaDetalle.ImgPrevDesktop))
                estrategia.ImgPrevDesktop = SaveFileS3(estrategia.ImgPrevDesktop);

            if (!String.IsNullOrEmpty(estrategia.ImgFichaDesktop) && 
                (String.IsNullOrEmpty(estrategiaDetalle.ImgFichaDesktop) || estrategia.ImgFichaDesktop != estrategiaDetalle.ImgFichaDesktop))
                estrategia.ImgFichaDesktop = SaveFileS3(estrategia.ImgFichaDesktop);

            //if (String.IsNullOrEmpty(estrategiaDetalle.ImgFondoMobile) || estrategia.ImgFondoMobile != estrategiaDetalle.ImgFondoMobile)
            //    estrategia.ImgFondoMobile = SaveFileS3(estrategia.ImgFondoMobile);

            if (!String.IsNullOrEmpty(estrategia.ImgFichaMobile) && 
                (String.IsNullOrEmpty(estrategiaDetalle.ImgFichaMobile) || estrategia.ImgFichaMobile != estrategiaDetalle.ImgFichaMobile))
                estrategia.ImgFichaMobile = SaveFileS3(estrategia.ImgFichaMobile);

            if (!String.IsNullOrEmpty(estrategia.ImgFichaFondoDesktop) && 
                (String.IsNullOrEmpty(estrategiaDetalle.ImgFichaFondoDesktop) || estrategia.ImgFichaFondoDesktop != estrategiaDetalle.ImgFichaFondoDesktop))
                estrategia.ImgFichaFondoDesktop = SaveFileS3(estrategia.ImgFichaFondoDesktop);

            if (!String.IsNullOrEmpty(estrategia.ImgFichaFondoMobile) && 
                (String.IsNullOrEmpty(estrategiaDetalle.ImgFichaFondoMobile) || estrategia.ImgFichaFondoMobile != estrategiaDetalle.ImgFichaFondoMobile))
                estrategia.ImgFichaFondoMobile = SaveFileS3(estrategia.ImgFichaFondoMobile);

            return estrategia;
        }
        public string SaveFileS3(string imagenEstrategia)
        {
            var path = Path.Combine(Globals.RutaTemporales, imagenEstrategia);
            var carpetaPais = Globals.UrlMatriz + "/" + UserData().CodigoISO;
            var time = DateTime.Now.Year.ToString() + DateTime.Now.Month.ToString() + DateTime.Now.Minute.ToString() + DateTime.Now.Millisecond.ToString();
            var newfilename = UserData().CodigoISO + "_" + time + "_" + FileManager.RandomString() + ".png";
            ConfigS3.SetFileS3(path, carpetaPais, newfilename);
            return newfilename;
        }
    }
}
