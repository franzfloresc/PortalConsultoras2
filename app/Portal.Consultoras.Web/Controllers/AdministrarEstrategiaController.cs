using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceGestionWebPROL;
using Portal.Consultoras.Web.ServiceODS;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServiceProductoCatalogoPersonalizado;
using Portal.Consultoras.Web.ServiceSAC;
using Portal.Consultoras.Web.ServiceZonificacion;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.ServiceModel;
using System.Web.Mvc;
using System.Web.UI.WebControls;
using ImageMagick;

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
            List<BETipoEstrategia> lst = GetTipoEstrategias();

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
                        var entidad = new BEEstrategia
                        {
                            PaisID = UserData().PaisID,
                            TipoEstrategiaID = Convert.ToInt32(TipoEstrategiaID),
                            CUV2 = (CUV != "") ? CUV : "0",
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
                        lst = new List<BEEstrategia>();
                    }

                    string carpetapais = Globals.UrlMatriz + "/" + UserData().CodigoISO;

                    if (lst != null && lst.Count > 0)
                        lst.Update(x => x.ImagenURL = ConfigS3.GetUrlFileS3(carpetapais, x.ImagenURL, carpetapais));

                    // Usamos el modelo para obtener los datos
                    var grid = new BEGrid
                    {
                        PageSize = rows,
                        CurrentPage = page,
                        SortColumn = sidx,
                        SortOrder = sord
                    };
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
                                       a.Activo.ToString(),
                                       a.EsOfertaIndependiente.ToString()
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
                    message = "Se grab� con �xito.",
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
                    message = "Se elimin� con �xito.",
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
                    return Json(new { success = false, message = "El tama�o de imagen excede el m�ximo permitido. (Ancho: 62px - Alto: 62px)." }, "text/html");
                }
                image.Dispose();
                return Json(new { success = true, name = Path.GetFileName(path) }, "text/html");
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
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
                // agregar parametros para validar el tipo de recomendaci�n (CUV o PERFIL)
                int resultado = -1, tipo = -1;
                if (FlagRecoProduc == "1") tipo = 0;
                if (FlagRecoPerfil == "1") tipo = 1;
                
                List<BEEstrategia> lst;
                var entidad = new BEEstrategia
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

                string mensaje = "", descripcion = "", precio = "", codigoSAP = "", wsprecio = "";
                int enMatrizComercial = 1, idMatrizComercial = 0;

                if (lst.Count <= 0) throw new Exception("No se econtro el CUV ingresado.");
                
                if (tipo != 1)
                {
                    if (resultado == 0)
                    {
                        if (FlagRecoProduc == "1") mensaje = "El CUV2 no est� asociado a ning�n otro.";
                        //if (FlagRecoPerfil == "1") mensaje = "El CUV2 no est� asociado a ning�n perfil.";
                        return Json(new
                        {
                            success = false,
                            message = mensaje,
                            descripcion,
                            precio,
                            extra = ""
                        }, JsonRequestBehavior.AllowGet);
                    }
                }
                mensaje = "OK";

                decimal wspreciopack = 0, ganancia = 0;

                using (var svs = new WsGestionWeb())
                {
                    //svs.Url = ConfigurarUrlServiceProl();
                    var preciosEstrategia =  svs.ObtenerPrecioEstrategia(CUV2, userData.CodigoISO, CampaniaID);
                    wspreciopack = preciosEstrategia.montotal;
                    ganancia = preciosEstrategia.montoganacia;
                }

                descripcion = lst[0].DescripcionCUV2;
                precio = (wspreciopack + ganancia).ToString("F2");
                codigoSAP = lst[0].CodigoSAP;
                enMatrizComercial = lst[0].EnMatrizComercial.ToInt();
                idMatrizComercial = lst[0].IdMatrizComercial.ToInt();
                wsprecio = wspreciopack.ToString("F2");

                return Json(new
                {
                    success = true,
                    message = mensaje,
                    descripcion,
                    precio,
                    wsprecio,
                    codigoSAP,
                    enMatrizComercial,
                    idMatrizComercial,
                    ganancia = ganancia.ToString("F2"),
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

        private List<RptProductoEstrategia> EstrategiaProductoObtenerServicio(BEEstrategia entidad)
        {
            var respuestaServiceCdr = new List<RptProductoEstrategia>();
            try
            {
                var codigo = ObtenerValorTablaLogica(userData.PaisID, Constantes.TablaLogica.Plan20, Constantes.TablaLogicaDato.Tonos, true);

                if (Convert.ToInt32(codigo) <= entidad.CampaniaID)
                {
                    using (var sv = new WsGestionWeb())
                    {
                        respuestaServiceCdr = sv.GetEstrategiaProducto(entidad.CampaniaID.ToString(), userData.CodigoConsultora, entidad.CUV2, userData.CodigoISO).ToList();
                    }

                    respuestaServiceCdr = respuestaServiceCdr ?? new List<RptProductoEstrategia>();
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
            if (codigo == Constantes.TipoEstrategiaSet.IndividualConTonos)
            {
                var listaHermanosE = new List<BEProducto>();
                using (ODSServiceClient svc = new ODSServiceClient())
                {
                    listaHermanosE = svc.GetListBrothersByCUV(userData.PaisID, userData.CampaniaID, cuv).ToList();
                }
                listaHermanosE = listaHermanosE ?? new List<BEProducto>();
                tieneVariedad = listaHermanosE.Any() ? 1 : 0;
            }
            else if (codigo == Constantes.TipoEstrategiaSet.CompuestaVariable)
            {
                tieneVariedad = 1;
            }

            return tieneVariedad;
        }

        private void EstrategiaProductoInsertar(List<RptProductoEstrategia> respuestaServiceCdr, BEEstrategia entidad)
        {
            foreach (var producto in respuestaServiceCdr)
            {
                var entidadPro = new BEEstrategiaProducto
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
                    Digitable = producto.digitable,
                    CodigoEstrategia = producto.codigo_estrategia,
                    CodigoError = producto.codigo_error,
                    CodigoErrorObs = producto.obs_error,
                    FactorCuadre = producto.factor_cuadre
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
                string mensajeImagenesResize = "";
                string _nroPedido = Util.Trim(model.NumeroPedido);

                if (_nroPedido.Contains(",")) model.NumeroPedido = "0";

                BEEstrategia entidad = Mapper.Map<RegistrarEstrategiaModel, BEEstrategia>(model);

                model.NumeroPedido = _nroPedido == "" ? "0" : _nroPedido;
                _nroPedido = model.NumeroPedido.Contains(",") ? _nroPedido : "";

                entidad.PaisID = userData.PaisID;
                entidad.Orden = (!string.IsNullOrEmpty(model.Orden) ? Convert.ToInt32(model.Orden) : 0);
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
                    model.CodigoTipoEstrategia == Constantes.TipoEstrategiaCodigo.LosMasVendidos))
                {
                    respuestaServiceCdr = EstrategiaProductoObtenerServicio(entidad);

                    if (respuestaServiceCdr.Any())
                    {
                        entidad.CodigoEstrategia = respuestaServiceCdr[0].codigo_estrategia;
                        entidad.TieneVariedad = TieneVariedad(entidad.CodigoEstrategia, entidad.CUV1);
                    }
                }
                #endregion

                List<int> NumeroPedidosAsociados = model.NumeroPedido.Split(',').Select(Int32.Parse).ToList();
                BEEstrategiaDetalle estrategiaDetalle = new BEEstrategiaDetalle();
                foreach (int item in NumeroPedidosAsociados)
                {
                    entidad.NumeroPedido = item;
                    if (_nroPedido != "") entidad.EstrategiaID = 0; //Fixed bug: _nropedido: 1,2,3 --> Solo Nuevos
                    using (PedidoServiceClient sv = new PedidoServiceClient())
                    {
                        if (entidad.CodigoTipoEstrategia != null)
                        {
                            if (entidad.CodigoTipoEstrategia.Equals(Constantes.TipoEstrategiaCodigo.Lanzamiento))
                            {
                                if (entidad.EstrategiaID != 0)
                                    estrategiaDetalle = sv.GetEstrategiaDetalle(entidad.PaisID, entidad.EstrategiaID);

                                entidad = VerficarArchivos(entidad, estrategiaDetalle);
                            }
                        }

                        #region Imagen Resize                                                

                        var resultadoImagenesResize = GuardarImagenesResize(userData.CodigoISO, model.RutaImagenCompleta, model.ImagenURL);

                        mensajeImagenesResize = resultadoImagenesResize ? "" : "No se generaron las imagenes Small y Medium, favor volver a guardar.";

                        #endregion

                        entidad.EstrategiaID = sv.InsertarEstrategia(entidad);
                    }
                }

                EstrategiaProductoInsertar(respuestaServiceCdr, entidad);

                if (model.CodigoTipoEstrategia == Constantes.TipoEstrategiaCodigo.OfertaParaTi)
                {
                    if (!string.IsNullOrEmpty(model.PrecioAnt))
                    {
                        if (model.Precio2 != model.PrecioAnt)
                        {
                            UpdateCacheListaOfertaFinal(model.CampaniaID);
                        }
                    }
                }

                return Json(new
                {
                    success = true,
                    message = "Se grab� con �xito la estrategia. " + mensajeImagenesResize,
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

        #region Resize Imagen

        private bool GuardarImagenesResize(string codigoIso, string rutaImagenOriginal, string nombreImagenOriginal)
        {
            var resultado = false;

            try
            {
                var listaValoresImagenesResize = ObtenerParametrosTablaLogica(11, Constantes.TablaLogica.ValoresImagenesResize, true);

                if (Util.ExisteUrlRemota(rutaImagenOriginal))
                {
                    string soloImagen = nombreImagenOriginal.Split('.')[0];
                    string soloExtension = nombreImagenOriginal.Split('.')[1];
                                        
                    var extensionNombreImagenSmall = Constantes.ConfiguracionImagenResize.ExtensionNombreImagenSmall;
                    var rutaImagenSmall = rutaImagenOriginal.Clone().ToString();
                    rutaImagenSmall = rutaImagenSmall.Replace(soloImagen, soloImagen + extensionNombreImagenSmall);                   
                    if (!Util.ExisteUrlRemota(rutaImagenSmall))
                    {
                        var imagenSmall = soloImagen + extensionNombreImagenSmall + "." + soloExtension;

                        var widthSmallString = ObtenerValorTablaLogica(listaValoresImagenesResize, Constantes.TablaLogicaDato.ValoresImagenesResizeWitdhSmall);
                        var widthSmall = 0;
                        var esIntWidthSmall = int.TryParse(widthSmallString, out widthSmall);
                        widthSmall = esIntWidthSmall ? widthSmall : Constantes.ConfiguracionImagenResize.WidthImagenSmall;

                        //var heightSmall = Constantes.ConfiguracionImagenResize.HeightImagenSmall;
                        var heightSmallString = ObtenerValorTablaLogica(listaValoresImagenesResize, Constantes.TablaLogicaDato.ValoresImagenesResizeHeightSmall);
                        var heightSmall = 0;
                        var esIntHeightSmall = int.TryParse(heightSmallString, out heightSmall);
                        widthSmall = esIntHeightSmall ? heightSmall : Constantes.ConfiguracionImagenResize.HeightImagenSmall;

                        MagickNetLibrary.GuardarImagenResize(userData.CodigoISO, rutaImagenOriginal, widthSmall, heightSmall, imagenSmall);
                    }

                    var extensionNombreImagenMedium = Constantes.ConfiguracionImagenResize.ExtensionNombreImagenMedium;
                    var rutaImagenMedium = rutaImagenOriginal.Clone().ToString();
                    rutaImagenMedium = rutaImagenMedium.Replace(soloImagen, soloImagen + extensionNombreImagenMedium);                    
                    if (!Util.ExisteUrlRemota(rutaImagenMedium))
                    {
                        var imagenMedium = soloImagen + extensionNombreImagenMedium + "." + soloExtension;
                                                
                        var widthMediumString = ObtenerValorTablaLogica(listaValoresImagenesResize, Constantes.TablaLogicaDato.ValoresImagenesResizeWitdhMedium);
                        var widthMedium = 0;
                        var esIntWidthMedium = int.TryParse(widthMediumString, out widthMedium);
                        widthMedium = esIntWidthMedium ? widthMedium : Constantes.ConfiguracionImagenResize.WidthImagenMedium;
                        
                        var heightMediumString = ObtenerValorTablaLogica(listaValoresImagenesResize, Constantes.TablaLogicaDato.ValoresImagenesResizeWitdhMedium);
                        var heightMedium = 0;
                        var esIntHeightMedium = int.TryParse(heightMediumString, out heightMedium);
                        widthMedium = esIntHeightMedium ? heightMedium : Constantes.ConfiguracionImagenResize.HeightImagenMedium;

                        MagickNetLibrary.GuardarImagenResize(userData.CodigoISO, rutaImagenOriginal, widthMedium, heightMedium, imagenMedium);
                    }

                    resultado = true;
                }
            }
            catch (Exception ex)
            {
                resultado = false;
            }            

            return resultado;
        }        

        #endregion

        private void UpdateCacheListaOfertaFinal(string campania)
        {
            try
            {
                string campNowNext = string.Empty;
                using (SACServiceClient svc = new SACServiceClient())
                {
                    campNowNext = svc.GetCampaniaActualAndSiguientePais(UserData().PaisID, UserData().CodigoISO);
                }

                if (!string.IsNullOrEmpty(campNowNext))
                {
                    string campNow = campNowNext;
                    string campNext = "";

                    if (campNowNext.IndexOf('|') >= 0)
                    {
                        var arr = campNowNext.Split('|');
                        campNow = arr[0];
                        campNext = arr[1];
                    }

                    if (campania == campNow || campania == campNext)
                    {
                        using (ProductoServiceClient svc = new ProductoServiceClient())
                        {
                            svc.UpdateCacheListaOfertaFinal(UserData().CodigoISO, int.Parse(campania));
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
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
                        message = "El CUV2 ingresado no est� configurado en la matriz comercial",
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
                    message = "Ocurri� un problema al intentar acceder al servicio, intente nuevamente.",
                    extra = ""
                }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Ocurri� un problema al intentar acceder al servicio, intente nuevamente.",
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
                NemoTecnico = p.NemoTecnico,
                DescripcionComercial = p.DescripcionComercial
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
                    message = "Se deshabilit� la estrategia correctamente.",
                    extra = ""
                }, JsonRequestBehavior.AllowGet);
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Ocurri� un problema al intentar acceder al servicio, intente nuevamente.",
                    extra = ""
                }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Ocurri� un problema al intentar acceder al servicio, intente nuevamente.",
                    extra = ""
                }, JsonRequestBehavior.AllowGet);
            }
        }


        [HttpPost]
        public JsonResult ActivarDesactivarEstrategias(string EstrategiasActivas, string EstrategiasDesactivas, string campaniaID, string tipoEstrategiaCod)
        {
            try
            {
                int resultado = 0;

                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    resultado = sv.ActivarDesactivarEstrategias(UserData().PaisID, UserData().CodigoUsuario, EstrategiasActivas, EstrategiasDesactivas);
                }

                if (tipoEstrategiaCod == Constantes.TipoEstrategiaCodigo.OfertaParaTi)
                {
                    if (!string.IsNullOrEmpty(EstrategiasDesactivas))
                    {
                        UpdateCacheListaOfertaFinal(campaniaID);
                    }
                }

                return Json(new
                {
                    success = true,
                    message = resultado > 0 ? "No se activaron algunas estrategias por no contar con los requisitos de l�mite de venta o imagen" : "Se actualizaron las estrategias correctamente.",
                    extra = ""
                }, JsonRequestBehavior.AllowGet);
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Ocurri� un problema al intentar acceder al servicio, intente nuevamente.",
                    extra = ""
                }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Ocurri� un problema al intentar acceder al servicio, intente nuevamente.",
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
                        List<BEPedidoWebDetalle> DetallePedidos = svc.SelectByCampania(UserData().PaisID, UserData().CampaniaID, UserData().ConsultoraID, UserData().NombreConsultora, EsOpt()).ToList();
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
                    entidad.OrigenPedidoWeb = ProcesarOrigenPedido(entidad.OrigenPedidoWeb);

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
                    indPedidoAutentico.IndicadorFingerprint = "";
                    indPedidoAutentico.IndicadorToken = (Session["TokenPedidoAutentico"] != null) ? Session["TokenPedidoAutentico"].ToString() : ""; ;

                    InsIndicadorPedidoAutentico(indPedidoAutentico, entidad.CUV);
                }
                //EPD-2248

                JSONdata = new
                {
                    success = true,
                    message = "Se agreg� la estrategia satisfactoriamente.",
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
                    LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
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

        public ActionResult ConsultarCuvTipoConfigurado(string sidx, string sord, int page, int rows, int campaniaId, int tipoConfigurado, string estrategiaCodigo)
        {
            if (ModelState.IsValid)
            {
                List<BEEstrategia> lst = new List<BEEstrategia>();

                try
                {
                    using (PedidoServiceClient ps = new PedidoServiceClient())
                    {
                        lst = ps.GetOfertasParaTiByTipoConfigurado(userData.PaisID, campaniaId, tipoConfigurado, estrategiaCodigo).ToList();
                    }
                }
                catch (Exception ex)
                {
                    LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
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

        public JsonResult InsertEstrategiaTemporal(int campaniaId, int tipoConfigurado, string estrategiaCodigo, bool habilitarNemotecnico)
        {
            try
            {
                List<BEEstrategia> listBeEstrategias;
                try
                {
                    using (var ps = new PedidoServiceClient())
                    {
                        listBeEstrategias = ps.GetOfertasParaTiByTipoConfigurado(userData.PaisID, campaniaId, tipoConfigurado, estrategiaCodigo).ToList();
                    }

                    if (!listBeEstrategias.Any())
                    {
                        return Json(new
                        {
                            success = false,
                            message = "No existen Estrategias para Insertar"
                        }, JsonRequestBehavior.AllowGet);
                    }

                    var tono = //opt.Activo == 1 &&
                    (estrategiaCodigo == Constantes.TipoEstrategiaCodigo.OfertaParaTi ||
                     estrategiaCodigo == Constantes.TipoEstrategiaCodigo.Lanzamiento ||
                     estrategiaCodigo == Constantes.TipoEstrategiaCodigo.PackAltoDesembolso ||
                     estrategiaCodigo == Constantes.TipoEstrategiaCodigo.OfertasParaMi ||
                     estrategiaCodigo == Constantes.TipoEstrategiaCodigo.OfertaDelDia ||
                     estrategiaCodigo == Constantes.TipoEstrategiaCodigo.LosMasVendidos);
                    
                    
                    foreach (var opt in listBeEstrategias)
                    {
                        #region precioOferta
                        decimal precioOferta = 0;
                        decimal ganancia = 0;
                        try
                        {
                            using (var svs = new WsGestionWeb())
                            {
                                var preciosEstrategia = svs.ObtenerPrecioEstrategia(opt.CUV2, userData.CodigoISO, campaniaId.ToString());
                                precioOferta = preciosEstrategia.montotal;
                                ganancia = preciosEstrategia.montoganacia;
                            }
                        }
                        catch (Exception ex)
                        {
                            LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                            precioOferta = 0;
                        }

                        if (precioOferta > 0) opt.Precio2 = precioOferta;
                        if (ganancia > 0)
                        {
                            opt.Precio = precioOferta + ganancia;
                            opt.Ganancia = ganancia;
                        }
                        #endregion
                        try
                        {
                            var productoEstrategias = new List<RptProductoEstrategia>();
                           
                            if (tono)
                            {
                                opt.CampaniaID = campaniaId;
                                productoEstrategias = EstrategiaProductoObtenerServicio(opt);

                                if (productoEstrategias.Any())
                                {
                                    opt.CodigoEstrategia = productoEstrategias[0].codigo_estrategia;
                                    opt.TieneVariedad = TieneVariedad(opt.CodigoEstrategia, opt.CUV2);
                                }
                            }

                            EstrategiaProductoInsertar(productoEstrategias, opt);

                            if (habilitarNemotecnico)
                            {
                                #region habilitarNemotecnico
                                var nemotecnicosLista = new List<string>();
                                var grupoPrevio = string.Empty;
                                foreach (var productoEstrategia in productoEstrategias)
                                {
                                    #region habilitarNemotecnico
                                    tono = (productoEstrategia.codigo_estrategia == Constantes.TipoEstrategiaSet.IndividualConTonos ||
                                         productoEstrategia.codigo_estrategia == Constantes.TipoEstrategiaSet.CompuestaFija) ||
                                        (productoEstrategia.codigo_estrategia == Constantes.TipoEstrategiaSet.CompuestaVariable &&
                                         grupoPrevio != productoEstrategia.grupo);

                                    if (!tono) continue;
                                    grupoPrevio = productoEstrategia.grupo;
                                    var cantidad = (productoEstrategia.cantidad.ToString().Length < 2)
                                        ? "0" + productoEstrategia.cantidad
                                        : productoEstrategia.cantidad.ToString();
                                    nemotecnicosLista.Add(String.Format("{0}#{1}", productoEstrategia.codigo_sap, cantidad));
                                    #endregion
                                }

                                var nemoTecnicoBusqueda = nemotecnicosLista.Aggregate(string.Empty, (current, nemoTecnico) => current + (current == string.Empty ? nemoTecnico : ("&" + nemoTecnico)));

                                List<BEMatrizComercialImagen> lstImagenes;
                                using (var ps = new PedidoServiceClient())
                                {
                                    lstImagenes = ps.GetImagenByNemotecnico(userData.PaisID, 0, null, null, 0, 0, 0,
                                            nemoTecnicoBusqueda, Constantes.TipoBusqueda.Exacta, 1, 1).ToList();
                                    opt.FotoProducto01 = lstImagenes.Any() ? lstImagenes[0].Foto : String.Empty;
                                }

                                #endregion
                            }
                        }
                        catch (Exception ex)
                        {
                            LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                        }
                    }
                }
                catch (TimeoutException ex)
                {
                    LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                    return Json(new
                    {
                        success = false,
                        message = "Tiempo agotado de espera durante la extracion de los productos."
                    }, JsonRequestBehavior.AllowGet);
                }
                catch (Exception ex)
                {
                    LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                    return Json(new
                    {
                        success = false,
                        message = "No se encontraron productos en ods.productocomercial."
                    }, JsonRequestBehavior.AllowGet);
                }

                try
                {
                    using (var ps = new PedidoServiceClient())
                    {
                        ps.InsertEstrategiaTemporal(userData.PaisID, listBeEstrategias.ToArray(), campaniaId, userData.CodigoUsuario);
                    }
                }
                catch (Exception ex)
                {
                    LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
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
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
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
                    LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
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
                    LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
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
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
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
                    LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
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
                        LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
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
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
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

        public BEEstrategia VerficarArchivos(BEEstrategia estrategia, BEEstrategiaDetalle estrategiaDetalle)
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

            if (!String.IsNullOrEmpty(estrategia.ImgHomeDesktop) &&
                (String.IsNullOrEmpty(estrategiaDetalle.ImgHomeDesktop) || estrategia.ImgHomeDesktop != estrategiaDetalle.ImgHomeDesktop))
                estrategia.ImgHomeDesktop = SaveFileS3(estrategia.ImgHomeDesktop);

            if (!String.IsNullOrEmpty(estrategia.ImgHomeMobile) &&
                (String.IsNullOrEmpty(estrategiaDetalle.ImgHomeMobile) || estrategia.ImgHomeMobile != estrategiaDetalle.ImgHomeMobile))
                estrategia.ImgHomeMobile = SaveFileS3(estrategia.ImgHomeMobile);

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
