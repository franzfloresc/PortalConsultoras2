using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Portal.Consultoras.Web.ServiceZonificacion;
using Portal.Consultoras.Web.ServiceSAC;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using AutoMapper;
using System.ServiceModel;
using System.Web.Script.Serialization;
using System.Web.UI.WebControls;


namespace Portal.Consultoras.Web.Controllers
{
    public class AdministrarEstrategiaController : BaseController
    {
        //
        // GET: /AdministrarEstrategia/

        public ActionResult Index()
        {
            if (!UsuarioModel.HasAcces(ViewBag.Permiso, "AdministrarEstrategia/Index"))
                return RedirectToAction("Index", "Bienvenida");
            var EstrategiaModel = new EstrategiaModel()
            {
                listaCampania = new List<CampaniaModel>(),
                listaPaises = DropDowListPaises(),
                ListaTipoEstrategia = DropDowListTipoEstrategia(),
                ListaEtiquetas = DropDowListEtiqueta()
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
            string TipoEstrategiaID, string CUV, string Consulta)
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

                string mensaje = "", descripcion = "", precio = "";
                string imagen1 = "", imagen2 = "", imagen3 = "", imagen4 = "", imagen5 = "", imagen6 = "", imagen7 = "", imagen8 = "", imagen9 = "", imagen10 = "";
                string carpetaPais = Globals.UrlMatriz + "/" + UserData().CodigoISO;
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
                                success = true,
                                message = mensaje,
                                descripcion = descripcion,
                                precio = precio,
                                imagen1 = imagen1,
                                imagen2 = imagen2,
                                imagen3 = imagen3,
                                imagen4 = imagen4,
                                imagen5 = imagen5,
                                imagen6 = imagen6,
                                imagen7 = imagen7,
                                imagen8 = imagen8,
                                imagen9 = imagen9,
                                imagen10 = imagen10,
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
                    wsprecio = wspreciopack.ToString();
                    imagen1 = ConfigS3.GetUrlFileS3(carpetaPais, lst[0].FotoProducto01, Globals.RutaImagenesMatriz + "/" + userData.CodigoISO);
                    imagen2 = ConfigS3.GetUrlFileS3(carpetaPais, lst[0].FotoProducto02, Globals.RutaImagenesMatriz + "/" + userData.CodigoISO);
                    imagen3 = ConfigS3.GetUrlFileS3(carpetaPais, lst[0].FotoProducto03, Globals.RutaImagenesMatriz + "/" + userData.CodigoISO);
                    imagen4 = ConfigS3.GetUrlFileS3(carpetaPais, lst[0].FotoProducto04, Globals.RutaImagenesMatriz + "/" + userData.CodigoISO);
                    imagen5 = ConfigS3.GetUrlFileS3(carpetaPais, lst[0].FotoProducto05, Globals.RutaImagenesMatriz + "/" + userData.CodigoISO);
                    imagen6 = ConfigS3.GetUrlFileS3(carpetaPais, lst[0].FotoProducto06, Globals.RutaImagenesMatriz + "/" + userData.CodigoISO);
                    imagen7 = ConfigS3.GetUrlFileS3(carpetaPais, lst[0].FotoProducto07, Globals.RutaImagenesMatriz + "/" + userData.CodigoISO);
                    imagen8 = ConfigS3.GetUrlFileS3(carpetaPais, lst[0].FotoProducto08, Globals.RutaImagenesMatriz + "/" + userData.CodigoISO);
                    imagen9 = ConfigS3.GetUrlFileS3(carpetaPais, lst[0].FotoProducto09, Globals.RutaImagenesMatriz + "/" + userData.CodigoISO);
                    imagen10 = ConfigS3.GetUrlFileS3(carpetaPais, lst[0].FotoProducto10, Globals.RutaImagenesMatriz + "/" + userData.CodigoISO);
                }

                return Json(new
                {
                    success = true,
                    message = mensaje,
                    descripcion = descripcion,
                    precio = precio,
                    wsprecio = wsprecio,
                    imagen1 = imagen1,
                    imagen2 = imagen2,
                    imagen3 = imagen3,
                    imagen4 = imagen4,
                    imagen5 = imagen5,
                    imagen6 = imagen6,
                    imagen7 = imagen7,
                    imagen8 = imagen8,
                    imagen9 = imagen9,
                    imagen10 = imagen10,
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
        public JsonResult RegistrarEstrategia(
             string EstrategiaID, string TipoEstrategiaID, string CampaniaID, string CampaniaIDFin,
             string NumeroPedido, string Activo, string ImagenURL, string LimiteVenta,
             string DescripcionCUV2, string FlagDescripcion, string CUV, string EtiquetaID,
             string Precio, string FlagCEP, string CUV2, string EtiquetaID2,
             string Precio2, string FlagCEP2, string TextoLibre, string FlagTextoLibre,
             string Cantidad, string FlagCantidad, string Zona, string Orden,
             string ColorFondo, string FlagEstrella
            )
        {
            int resultado = 0;

            try
            {
                if (string.IsNullOrEmpty(NumeroPedido))
                {
                    BEEstrategia entidad = new BEEstrategia();
                    entidad.PaisID = UserData().PaisID;
                    entidad.EstrategiaID = (EstrategiaID != "") ? Convert.ToInt32(EstrategiaID) : 0;
                    entidad.TipoEstrategiaID = (TipoEstrategiaID != "") ? Convert.ToInt32(TipoEstrategiaID) : 0;
                    entidad.CampaniaID = (CampaniaID != "") ? Convert.ToInt32(CampaniaID) : 0;
                    entidad.CampaniaIDFin = (CampaniaIDFin != "") ? Convert.ToInt32(CampaniaIDFin) : 0;
                    entidad.NumeroPedido = (NumeroPedido != "") ? Convert.ToInt32(NumeroPedido) : 0;
                    entidad.Activo = Convert.ToInt32(Activo);
                    entidad.ImagenURL = ImagenURL;
                    entidad.LimiteVenta = (LimiteVenta != "") ? Convert.ToInt32(LimiteVenta) : 0;
                    entidad.DescripcionCUV2 = DescripcionCUV2;
                    entidad.FlagDescripcion = Convert.ToInt32(FlagDescripcion);
                    entidad.CUV1 = CUV;
                    entidad.EtiquetaID = (EtiquetaID != "") ? Convert.ToInt32(EtiquetaID) : 0;
                    entidad.Precio = (Precio != "") ? Convert.ToDecimal(Precio) : 0;
                    entidad.FlagCEP = Convert.ToInt32(FlagCEP);
                    entidad.CUV2 = CUV2;
                    entidad.EtiquetaID2 = (EtiquetaID2 != "") ? Convert.ToInt32(EtiquetaID2) : 0;
                    entidad.Precio2 = (Precio2 != "") ? Convert.ToDecimal(Precio2) : 0;
                    entidad.FlagCEP2 = Convert.ToInt32(FlagCEP2);
                    entidad.TextoLibre = TextoLibre;
                    entidad.FlagTextoLibre = Convert.ToInt32(FlagTextoLibre);
                    entidad.Cantidad = (Cantidad != "") ? Convert.ToInt32(Cantidad) : 0;
                    entidad.FlagCantidad = Convert.ToInt32(FlagCantidad);
                    entidad.Zona = Zona;
                    //entidad.Orden = Convert.ToInt32(Orden);
                    entidad.Orden = (!string.IsNullOrEmpty(Orden) ? Convert.ToInt32(Orden) : 0);     /* SB20-312 */
                    entidad.UsuarioCreacion = UserData().CodigoUsuario;
                    entidad.UsuarioModificacion = UserData().CodigoUsuario;
                    entidad.ColorFondo = ColorFondo;
                    entidad.FlagEstrella = (FlagEstrella != "") ? Convert.ToInt32(FlagEstrella) : 0;

                    using (PedidoServiceClient sv = new PedidoServiceClient())
                    {
                        resultado = sv.InsertarEstrategia(entidad);
                    }
                }
                else
                {
                    List<int> NumeroPedidosAsociados = NumeroPedido.Split(',').Select(Int32.Parse).ToList();
                    //int OrdenEstrategia = Convert.ToInt32(Orden);
                    int OrdenEstrategia = (!string.IsNullOrEmpty(Orden) ? Convert.ToInt32(Orden) : 0);     /* SB20-312 */

                    foreach (int item in NumeroPedidosAsociados) /*R20160301*/
                    {
                        BEEstrategia entidad = new BEEstrategia();
                        entidad.PaisID = UserData().PaisID;
                        entidad.EstrategiaID = (EstrategiaID != "") ? Convert.ToInt32(EstrategiaID) : 0;
                        entidad.TipoEstrategiaID = (TipoEstrategiaID != "") ? Convert.ToInt32(TipoEstrategiaID) : 0;
                        entidad.CampaniaID = (CampaniaID != "") ? Convert.ToInt32(CampaniaID) : 0;
                        entidad.CampaniaIDFin = (CampaniaIDFin != "") ? Convert.ToInt32(CampaniaIDFin) : 0;
                        entidad.NumeroPedido = item; //(NumeroPedido != "") ? Convert.ToInt32(NumeroPedido) : 0;
                        entidad.Activo = Convert.ToInt32(Activo);
                        entidad.ImagenURL = ImagenURL;
                        entidad.LimiteVenta = (LimiteVenta != "") ? Convert.ToInt32(LimiteVenta) : 0;
                        entidad.DescripcionCUV2 = DescripcionCUV2;
                        entidad.FlagDescripcion = Convert.ToInt32(FlagDescripcion);
                        entidad.CUV1 = CUV;
                        entidad.EtiquetaID = (EtiquetaID != "") ? Convert.ToInt32(EtiquetaID) : 0;
                        entidad.Precio = (Precio != "") ? Convert.ToDecimal(Precio) : 0;
                        entidad.FlagCEP = Convert.ToInt32(FlagCEP);
                        entidad.CUV2 = CUV2;
                        entidad.EtiquetaID2 = (EtiquetaID2 != "") ? Convert.ToInt32(EtiquetaID2) : 0;
                        entidad.Precio2 = (Precio2 != "") ? Convert.ToDecimal(Precio2) : 0;
                        entidad.FlagCEP2 = Convert.ToInt32(FlagCEP2);
                        entidad.TextoLibre = TextoLibre;
                        entidad.FlagTextoLibre = Convert.ToInt32(FlagTextoLibre);
                        entidad.Cantidad = (Cantidad != "") ? Convert.ToInt32(Cantidad) : 0;
                        entidad.FlagCantidad = Convert.ToInt32(FlagCantidad);
                        entidad.Zona = Zona;
                        entidad.Orden = OrdenEstrategia;
                        entidad.UsuarioCreacion = UserData().CodigoUsuario;
                        entidad.UsuarioModificacion = UserData().CodigoUsuario;
                        entidad.ColorFondo = ColorFondo;
                        entidad.FlagEstrella = (FlagEstrella != "") ? Convert.ToInt32(FlagEstrella) : 0;

                        using (PedidoServiceClient sv = new PedidoServiceClient())
                        {
                            resultado = sv.InsertarEstrategia(entidad);
                        }
                        // OrdenEstrategia++;
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
        public JsonResult FiltrarEstrategia(string EstrategiaID)
        {
            try
            {
                List<BEEstrategia> lst = new List<BEEstrategia>();

                var entidad = new BEEstrategia();
                entidad.PaisID = UserData().PaisID;
                entidad.EstrategiaID = Convert.ToInt32(EstrategiaID);

                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    lst = sv.FiltrarEstrategia(entidad).ToList();
                }

                string carpetapais = Globals.UrlMatriz + "/" + UserData().CodigoISO;

                if (lst != null && lst.Count > 0)
                {
                    lst.Update(x => x.FotoProducto01 = ConfigS3.GetUrlFileS3(carpetapais, x.FotoProducto01 ?? "", carpetapais));
                    lst.Update(x => x.FotoProducto02 = ConfigS3.GetUrlFileS3(carpetapais, x.FotoProducto02 ?? "", carpetapais));
                    lst.Update(x => x.FotoProducto03 = ConfigS3.GetUrlFileS3(carpetapais, x.FotoProducto03 ?? "", carpetapais));
                    lst.Update(x => x.FotoProducto04 = ConfigS3.GetUrlFileS3(carpetapais, x.FotoProducto04 ?? "", carpetapais));
                    lst.Update(x => x.FotoProducto05 = ConfigS3.GetUrlFileS3(carpetapais, x.FotoProducto05 ?? "", carpetapais));
                    lst.Update(x => x.FotoProducto06 = ConfigS3.GetUrlFileS3(carpetapais, x.FotoProducto06 ?? "", carpetapais));
                    lst.Update(x => x.FotoProducto07 = ConfigS3.GetUrlFileS3(carpetapais, x.FotoProducto07 ?? "", carpetapais));
                    lst.Update(x => x.FotoProducto08 = ConfigS3.GetUrlFileS3(carpetapais, x.FotoProducto08 ?? "", carpetapais));
                    lst.Update(x => x.FotoProducto09 = ConfigS3.GetUrlFileS3(carpetapais, x.FotoProducto09 ?? "", carpetapais));
                    lst.Update(x => x.FotoProducto10 = ConfigS3.GetUrlFileS3(carpetapais, x.FotoProducto10 ?? "", carpetapais));
                    lst.Update(x => x.Simbolo = UserData().Simbolo);
                }

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
                lst.Update(x => x.FotoProducto01 = ConfigS3.GetUrlFileS3(carpetapais, x.FotoProducto01, carpetapais));
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
                case 1: result = "L'Bel";
                    break;
                case 2: result = "Ésika";
                    break;
                case 3: result = "Cyzone";
                    break;
                case 6: result = "Finart";
                    break;
            }

            return result;
        }

        [HttpPost]
        public List<BEEstrategia> ConsultarEstrategias()
        {
            List<BEEstrategia> lst;

            var entidad = new BEEstrategia();
            entidad.PaisID = UserData().PaisID;
            entidad.CampaniaID = UserData().CampaniaID;
            entidad.ConsultoraID = UserData().ConsultoraID.ToString();
            entidad.CUV2 = "";
            entidad.Zona = UserData().ZonaID.ToString();

            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                lst = sv.GetEstrategiasPedido(entidad).ToList();
            }

            string carpetapais = Globals.UrlMatriz + "/" + UserData().CodigoISO;

            if (lst != null && lst.Count > 0)
            {
                lst.Update(x => x.FotoProducto01 = ConfigS3.GetUrlFileS3(carpetapais, x.FotoProducto01, carpetapais));
                lst.Update(x => x.ImagenURL = ConfigS3.GetUrlFileS3(carpetapais, x.ImagenURL, carpetapais));
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
        
        public ActionResult ConsultarOfertasParaTi(string sidx, string sord, int page, int rows, string CampaniaID)
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
                        cantidadEstrategiasConfiguradas = ps.GetCantidadOfertasParaTi(userData.PaisID, int.Parse(CampaniaID), 1);
                        cantidadEstrategiasSinConfigurar= ps.GetCantidadOfertasParaTi(userData.PaisID, int.Parse(CampaniaID), 2);
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
                    Descripcion = "CUVS encontrados en Ofertas para Ti",
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

        public ActionResult ConsultarCuvTipoConfigurado(string sidx, string sord, int page, int rows, int campaniaId, int tipoConfigurado)
        {
            if (ModelState.IsValid)
            {
                List<BEEstrategia> lst = new List<BEEstrategia>();

                try
                {
                    using (PedidoServiceClient ps = new PedidoServiceClient())
                    {
                        lst = ps.GetOfertasParaTiByTipoConfigurado(userData.PaisID, campaniaId, tipoConfigurado).ToList();
                    }
                }
                catch (Exception ex)
                {
                    lst=new List<BEEstrategia>();
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

        public JsonResult InsertEstrategiaTemporal(int campaniaId, int tipoConfigurado)
        {
            try
            {
                List<BEEstrategia> lst = new List<BEEstrategia>();

                try
                {
                    using (PedidoServiceClient ps = new PedidoServiceClient())
                    {
                        lst = ps.GetOfertasParaTiByTipoConfigurado(userData.PaisID, campaniaId, tipoConfigurado).ToList();
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
                        }
                        catch (Exception ex)
                        {
                            precioOferta = 0;
                        }

                        if (precioOferta > 0)
                            opt.Precio2 = precioOferta;



                    }
                }
                catch (Exception ex)
                {
                    lst = new List<BEEstrategia>();
                }

                return Json(new
                {
                    success = true,
                    message = "Se deshabilitó la estrategia correctamente.",
                    extra = ""
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
    }
}
