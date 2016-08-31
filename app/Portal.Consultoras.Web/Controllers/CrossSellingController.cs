using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;
using Portal.Consultoras.Web.Models;
using System.ServiceModel;
using Portal.Consultoras.Web.ServiceZonificacion;
using Portal.Consultoras.Web.ServicePedido;
using AutoMapper;
using Portal.Consultoras.Common;
using System.IO;

namespace Portal.Consultoras.Web.Controllers
{
    public class CrossSellingController : BaseController
    {
        //
        // GET: /CrossSelling/

        #region Configuracion Cross Selling

        public ActionResult ConfiguracionCrossSelling()
        {
            try
            {
                if (!UsuarioModel.HasAcces(ViewBag.Permiso, "CrossSelling/ConfiguracionCrossSelling"))
                    return RedirectToAction("Index", "Bienvenida");
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
            }

            var cronogramaModel = new ConfiguracionCrossSellingModel()
            {
                lstCampania = new List<CampaniaModel>(),
                lstPais = DropDowListPaises()
            };
            return View(cronogramaModel);
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

        public JsonResult ObtenterCampaniasPorPais(int PaisID)
        {
            //PaisID = 11;
            IEnumerable<CampaniaModel> lst = DropDowListCampanias(PaisID);
            return Json(new
            {
                lista = lst,
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

        public ActionResult ConsultarConfiguracionCrossSelling(string sidx, string sord, int page, int rows, int PaisID, int CampaniaID)
        {
            if (ModelState.IsValid)
            {
                List<BEConfiguracionCrossSelling> lst;
                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    lst = sv.GetConfiguracionCampaniasPorPais(PaisID, CampaniaID).ToList();
                }

                string ISO = Util.GetPaisISO(PaisID);

                // Usamos el modelo para obtener los datos
                BEGrid grid = new BEGrid();
                grid.PageSize = rows;
                grid.CurrentPage = page;
                grid.SortColumn = sidx;
                grid.SortOrder = sord;
                //int buscar = int.Parse(txtBuscar);
                BEPager pag = new BEPager();
                IEnumerable<BEConfiguracionCrossSelling> items = lst;

                #region Sort Section
                if (sord == "asc")
                {
                    switch (sidx)
                    {
                        case "Pais":
                            items = lst.OrderBy(x => x.Pais);
                            break;
                        case "CampaniaID":
                            items = lst.OrderBy(x => x.CampaniaID);
                            break;
                    }
                }
                else
                {
                    switch (sidx)
                    {
                        case "Pais":
                            items = lst.OrderByDescending(x => x.Pais);
                            break;
                        case "CampaniaID":
                            items = lst.OrderByDescending(x => x.CampaniaID);
                            break;
                    }
                }
                #endregion

                items = items.ToList().Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);

                pag = Util.PaginadorGenerico(grid, lst);
                lst.Update(x => x.Pais = Util.GetPaisNombre(PaisID));
                // Creamos la estructura
                var data = new
                {
                    total = pag.PageCount,
                    page = pag.CurrentPage,
                    records = pag.RecordCount,
                    rows = from a in items
                           select new
                           {
                               id = a.CampaniaID,
                               cell = new string[] 
                               {
                                   a.Pais,
                                   a.CampaniaID.ToString(),
                                   a.HabilitarDiasValidacion.ToString(),
                                   a.HabilitarDiasValidacion.ToString()
                                }
                           }
                };
                return Json(data, JsonRequestBehavior.AllowGet);
            }
            return RedirectToAction("Index", "Bienvenida");
        }

        [HttpPost]
        public JsonResult AdministrarConfiguracionCrossSelling(ConfiguracionCrossSellingModel model)
        {
            try
            {
                Mapper.CreateMap<ConfiguracionCrossSellingModel, BEConfiguracionCrossSelling>()
                    .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID))
                    .ForMember(t => t.CampaniaID, f => f.MapFrom(c => c.CampaniaID))
                    .ForMember(t => t.HabilitarDiasValidacion, f => f.MapFrom(c => c.HabilitarDiasValidacion));

                BEConfiguracionCrossSelling entidad = Mapper.Map<ConfiguracionCrossSellingModel, BEConfiguracionCrossSelling>(model);

                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    sv.InsConfiguracionCrossSelling(entidad);
                }
                return Json(new
                {
                    success = true,
                    message = "Se configuró satisfactoriamente el registro.",
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

        #endregion

        #region Administracion de CrossSelling

        public ActionResult AdministracionCrossSelling()
        {
            try
            {
                if (!UsuarioModel.HasAcces(ViewBag.Permiso, "CrossSelling/AdministracionCrossSelling"))
                    return RedirectToAction("Index", "Bienvenida");
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
            }

            var cronogramaModel = new CrossSellingProductoModel()
            {
                lstCampania = new List<CampaniaModel>(),
                lstPais = DropDowListPaises()
            };
            return View(cronogramaModel);
        }

        public ActionResult ConsultarCrossSellingAdministracion(string sidx, string sord, int page, int rows, int PaisID, int CampaniaID)
        {
            if (ModelState.IsValid)
            {
                List<BECrossSellingProducto> lst;
                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    lst = sv.GetCrossSellingProductosAdministracion(PaisID, CampaniaID).ToList();
                }
                // 1664
                var carpetaPais = Globals.UrlMatriz + "/" + UserData().CodigoISO;
                if(lst != null)
                    if (lst.Count > 0) // 1664
                        lst.Update(x => x.ImagenProducto = ConfigS3.GetUrlFileS3(carpetaPais, x.ImagenProducto, Globals.RutaImagenesMatriz + "/" + UserData().CodigoISO));

                string ISO = Util.GetPaisISO(PaisID);

                // Usamos el modelo para obtener los datos
                BEGrid grid = new BEGrid();
                grid.PageSize = rows;
                grid.CurrentPage = page;
                grid.SortColumn = sidx;
                grid.SortOrder = sord;
                //int buscar = int.Parse(txtBuscar);
                BEPager pag = new BEPager();
                IEnumerable<BECrossSellingProducto> items = lst;

                #region Sort Section
                if (sord == "asc")
                {
                    switch (sidx)
                    {
                        case "CodigoProducto":
                            items = lst.OrderBy(x => x.CodigoProducto);
                            break;
                        case "CodigoCampania":
                            items = lst.OrderBy(x => x.CodigoCampania);
                            break;
                        case "CUV":
                            items = lst.OrderBy(x => x.CUV);
                            break;
                        case "Descripcion":
                            items = lst.OrderBy(x => x.Descripcion);
                            break;
                    }
                }
                else
                {
                    switch (sidx)
                    {
                        case "CodigoProducto":
                            items = lst.OrderByDescending(x => x.CodigoProducto);
                            break;
                        case "CodigoCampania":
                            items = lst.OrderByDescending(x => x.CodigoCampania);
                            break;
                        case "CUV":
                            items = lst.OrderByDescending(x => x.CUV);
                            break;
                        case "Descripcion":
                            items = lst.OrderByDescending(x => x.Descripcion);
                            break;
                    }
                }
                #endregion

                items = items.ToList().Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);

                pag = Util.PaginadorGenerico(grid, lst);
                // lst.Update(x => x.ImagenProducto = (x.ImagenProducto.ToString().Equals(string.Empty) ? string.Empty : (ISO + "/" + x.ImagenProducto)));
                lst.Update(x => x.ISOPais = ISO);
                // Creamos la estructura
                var data = new
                {
                    total = pag.PageCount,
                    page = pag.CurrentPage,
                    records = pag.RecordCount,
                    rows = from a in items
                           select new
                           {
                               id = a.NroOrden,
                               cell = new string[] 
                               {
                                   a.CodigoProducto,
                                   a.CodigoCampania.ToString(),
                                   a.CUV.ToString(),
                                   a.Descripcion.ToString(),
                                   a.PrecioOferta.ToString("#0.00"),
                                   a.ImagenProducto.ToString(),
                                   a.FlagHabilitarProducto.ToString(),
                                   a.MensajeProducto.ToString(),
                                   a.ISOPais,
                                   a.CampaniaID.ToString(),
                                   a.CrossSellingProductoID.ToString()
                                }
                           }
                };
                return Json(data, JsonRequestBehavior.AllowGet);
            }
            return RedirectToAction("Index", "Bienvenida");
        }

        [HttpPost]
        public JsonResult InsertAdmCrossSelling(CrossSellingProductoModel model)
        {
            try
            {
                Mapper.CreateMap<CrossSellingProductoModel, BECrossSellingProducto>()
                    .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID))
                    .ForMember(t => t.CampaniaID, f => f.MapFrom(c => c.CampaniaID))
                    .ForMember(t => t.CUV, f => f.MapFrom(c => c.CUV))
                    .ForMember(t => t.Descripcion, f => f.MapFrom(c => c.Descripcion))
                    .ForMember(t => t.PrecioOferta, f => f.MapFrom(c => c.PrecioOferta))
                    .ForMember(t => t.ImagenProducto, f => f.MapFrom(c => c.ImagenProducto))
                    .ForMember(t => t.CodigoCampania, f => f.MapFrom(c => c.CodigoCampania))
                    .ForMember(t => t.FlagHabilitarProducto, f => f.MapFrom(c => c.FlagHabilitarProducto))
                    .ForMember(t => t.MensajeProducto, f => f.MapFrom(c => c.MensajeProducto));

                BECrossSellingProducto entidad = Mapper.Map<CrossSellingProductoModel, BECrossSellingProducto>(model);

                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    entidad.PaisID = model.PaisID;
                    entidad.TipoOfertaSisID = Constantes.ConfiguracionOferta.CrossSelling;
                    entidad.ConfiguracionOfertaID = Constantes.TipoOferta.CrossSelling;
                    sv.InsCrossSellingProducto(entidad);
                }
                return Json(new
                {
                    success = true,
                    message = "Se actualizó el Producto Recomendado satisfactoriamente.",
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
        public JsonResult UpdateAdmCrossSelling(CrossSellingProductoModel model)
        {
            try
            {
                Mapper.CreateMap<CrossSellingProductoModel, BECrossSellingProducto>()
                    .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID))
                    .ForMember(t => t.CampaniaID, f => f.MapFrom(c => c.CampaniaID))
                    .ForMember(t => t.CUV, f => f.MapFrom(c => c.CUV))
                    .ForMember(t => t.Descripcion, f => f.MapFrom(c => c.Descripcion))
                    .ForMember(t => t.PrecioOferta, f => f.MapFrom(c => c.PrecioOferta))
                    .ForMember(t => t.ImagenProducto, f => f.MapFrom(c => c.ImagenProducto))
                    //.ForMember(t => t.ImagenProductoAnterior, f => f.MapFrom(c => c.ImagenProductoAnterior))
                    .ForMember(t => t.CodigoCampania, f => f.MapFrom(c => c.CodigoCampania))
                    .ForMember(t => t.FlagHabilitarProducto, f => f.MapFrom(c => c.FlagHabilitarProducto))
                    .ForMember(t => t.MensajeProducto, f => f.MapFrom(c => c.MensajeProducto));

                BECrossSellingProducto entidad = Mapper.Map<CrossSellingProductoModel, BECrossSellingProducto>(model);

                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    entidad.PaisID = model.PaisID;
                    entidad.TipoOfertaSisID = Constantes.ConfiguracionOferta.CrossSelling;
                    entidad.ConfiguracionOfertaID = Constantes.TipoOferta.CrossSelling;
                    sv.UpdCrossSellingProducto(entidad);
                }
                return Json(new
                {
                    success = true,
                    message = "Se actualizó el Producto Recomendado satisfactoriamente.",
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
        public JsonResult DeshabilitarAdmCrossSelling(CrossSellingProductoModel model)
        {
            try
            {
                Mapper.CreateMap<CrossSellingProductoModel, BECrossSellingProducto>()
                    .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID))
                    .ForMember(t => t.CampaniaID, f => f.MapFrom(c => c.CampaniaID))
                    .ForMember(t => t.CUV, f => f.MapFrom(c => c.CUV));

                BECrossSellingProducto entidad = Mapper.Map<CrossSellingProductoModel, BECrossSellingProducto>(model);

                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    entidad.PaisID = model.PaisID;
                    sv.DelCrossSellingProducto(entidad);
                }
                return Json(new
                {
                    success = true,
                    message = "Se deshabilitó el Producto Recomendado satisfactoriamente.",
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

        #endregion

        #region Asociar CrossSelling

        public ActionResult AsociacionCrossSelling()
        {
            try
            {
                if (!UsuarioModel.HasAcces(ViewBag.Permiso, "CrossSelling/AsociacionCrossSelling"))
                    return RedirectToAction("Index", "Bienvenida");
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
            }

            var cronogramaModel = new CrossSellingAsociacionModel()
            {
                lstCampania = new List<CampaniaModel>(),
                lstCrossSellingProducto = new List<CrossSellingProductoModel>(),
                lstPais = DropDowListPaises()
            };
            return View(cronogramaModel);
        }

        public JsonResult ObtenerProductosRecomendadosHabilitados(int PaisID, int CampaniaID, int Tipo)
        {
            //PaisID = 11;
            IEnumerable<CrossSellingProductoModel> lst = DropDowListProductosRecomendadosHabilitados(PaisID, CampaniaID, Tipo);
            return Json(new
            {
                lista = lst,
            }, JsonRequestBehavior.AllowGet);
        }

        public JsonResult ObtenerDescripcionProducto(int PaisID, int CampaniaID, string CUV)
        {
            //PaisID = 11;
            IEnumerable<CrossSellingAsociacionModel> lst = GetDescripcionByCUV(PaisID, CampaniaID, CUV);
            return Json(new
            {
                lista = lst,
            }, JsonRequestBehavior.AllowGet);
        }

        public JsonResult ObtenerCUVAsociado(int PaisID, int CampaniaID, string CUV)
        {
            //PaisID = 11;
            IEnumerable<CrossSellingAsociacionModel> lst = GetCUVAsociadoByFilter(PaisID, CampaniaID, CUV, "");
            return Json(new
            {
                lista = lst,
            }, JsonRequestBehavior.AllowGet);
        }

        private IEnumerable<CrossSellingProductoModel> DropDowListProductosRecomendadosHabilitados(int PaisID, int CampaniaID, int tipo)
        {
            List<BECrossSellingProducto> lst;
            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                lst = sv.GetProductosRecomendadosHabilitados(PaisID, CampaniaID, tipo).ToList();

            }
            Mapper.CreateMap<BECrossSellingProducto, CrossSellingProductoModel>()
                    .ForMember(t => t.CUV, f => f.MapFrom(c => c.CUV))
                    .ForMember(t => t.Descripcion, f => f.MapFrom(c => c.Descripcion));

            return Mapper.Map<IList<BECrossSellingProducto>, IEnumerable<CrossSellingProductoModel>>(lst);
        }

        private IEnumerable<CrossSellingAsociacionModel> GetDescripcionByCUV(int PaisID, int CampaniaID, string CUV)
        {
            List<BECrossSellingAsociacion> lst;
            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                lst = sv.GetDescripcionProductoByCUV(PaisID, CampaniaID, CUV).ToList();

            }
            Mapper.CreateMap<BECrossSellingAsociacion, CrossSellingAsociacionModel>()
                    .ForMember(t => t.CUV, f => f.MapFrom(c => c.CUV))
                    .ForMember(t => t.Descripcion, f => f.MapFrom(c => c.Descripcion));

            return Mapper.Map<IList<BECrossSellingAsociacion>, IEnumerable<CrossSellingAsociacionModel>>(lst);
        }

        private IEnumerable<CrossSellingAsociacionModel> GetCUVAsociadoByFilter(int PaisID, int CampaniaID, string CUV, string CodigoSegmento)
        {
            List<BECrossSellingAsociacion> lst;
            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                lst = sv.GetCUVAsociadoByFilter(PaisID, CampaniaID, CUV, CodigoSegmento).ToList();

            }
            Mapper.CreateMap<BECrossSellingAsociacion, CrossSellingAsociacionModel>()
                    .ForMember(t => t.CUV, f => f.MapFrom(c => c.CUV))
                    .ForMember(t => t.Descripcion, f => f.MapFrom(c => c.Descripcion));

            return Mapper.Map<IList<BECrossSellingAsociacion>, IEnumerable<CrossSellingAsociacionModel>>(lst);
        }

        public ActionResult ConsultarProductosNoRecomendados(string sidx, string sord, int page, int rows, int PaisID,
            int CampaniaID, string CUV, string TipoCrossSelling = "")
        {
            if (ModelState.IsValid)
            {
                if (TipoCrossSelling == "2" || TipoCrossSelling == "")
                {
                    List<BECrossSellingAsociacion> lst;
                    using (PedidoServiceClient sv = new PedidoServiceClient())
                    {
                        lst = sv.GetCrossSellingAsociacionListado(PaisID, CampaniaID, CUV).ToList();
                    }

                    string ISO = Util.GetPaisISO(PaisID);

                    // Usamos el modelo para obtener los datos
                    BEGrid grid = new BEGrid();
                    grid.PageSize = rows;
                    grid.CurrentPage = page;
                    grid.SortColumn = sidx;
                    grid.SortOrder = sord;
                    //int buscar = int.Parse(txtBuscar);
                    BEPager pag = new BEPager();
                    IEnumerable<BECrossSellingAsociacion> items = lst;

                    #region Sort Section
                    if (sord == "asc")
                    {
                        switch (sidx)
                        {
                            case "CodigoCampania":
                                items = lst.OrderBy(x => x.CodigoCampania);
                                break;
                            case "CUV":
                                items = lst.OrderBy(x => x.CUV);
                                break;
                            case "Descripcion":
                                items = lst.OrderBy(x => x.Descripcion);
                                break;
                            case "PrecioOferta":
                                items = lst.OrderBy(x => x.PrecioOferta);
                                break;
                        }
                    }
                    else
                    {
                        switch (sidx)
                        {
                            case "CodigoCampania":
                                items = lst.OrderByDescending(x => x.CodigoCampania);
                                break;
                            case "CUV":
                                items = lst.OrderByDescending(x => x.CUV);
                                break;
                            case "Descripcion":
                                items = lst.OrderByDescending(x => x.Descripcion);
                                break;
                            case "PrecioOferta":
                                items = lst.OrderByDescending(x => x.PrecioOferta);
                                break;
                        }
                    }
                    #endregion

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
                                   id = a.NroOrden,
                                   cell = new string[] 
                               {
                                   a.CodigoCampania.ToString(),
                                   a.CUV.ToString(),
                                   a.Descripcion.ToString(),
                                   a.PrecioOferta.ToString("#0.00"),
                                   a.CrossSellingAsociacionID.ToString(),
                                   a.CampaniaID.ToString()
                                }
                               }
                    };
                    return Json(data, JsonRequestBehavior.AllowGet);
                }
                else
                {
                    #region "Segmentacion"

                    if (TipoCrossSelling == "1")
                    {
                        List<BESegmentoPlaneamiento> lst;

                        using (PedidoServiceClient sv = new PedidoServiceClient())
                        {
                            lst = sv.GetSegmentoPlaneamiento(PaisID, CampaniaID).ToList();
                        }

                        string ISO = Util.GetPaisISO(PaisID);

                        BEGrid grid = new BEGrid();
                        grid.PageSize = rows;
                        grid.CurrentPage = page;
                        grid.SortColumn = sidx;
                        grid.SortOrder = sord;
                        //int buscar = int.Parse(txtBuscar);
                        BEPager pag = new BEPager();
                        IEnumerable<BESegmentoPlaneamiento> items = lst;

                        #region Sort Section
                        if (sord == "asc")
                        {
                            switch (sidx)
                            {
                                case "CodigoCampania":
                                    items = lst.OrderBy(x => CampaniaID);
                                    break;
                                case "CodigoSegmento":
                                    items = lst.OrderBy(x => x.CodigoSegmento);
                                    break;
                                case "DescripcionSegmento":
                                    items = lst.OrderBy(x => x.DescripcionSegmento);
                                    break;
                            }
                        }
                        else
                        {
                            switch (sidx)
                            {
                                case "CodigoCampania":
                                    items = lst.OrderByDescending(x => CampaniaID);
                                    break;
                                case "CodigoSegmento":
                                    items = lst.OrderByDescending(x => x.CodigoSegmento);
                                    break;
                                case "DescripcionSegmento":
                                    items = lst.OrderByDescending(x => x.DescripcionSegmento);
                                    break;
                            }
                        }
                        #endregion

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
                                       id = a.NroOrden,
                                       cell = new string[] 
                               {
                                   CampaniaID.ToString(),
                                   a.CodigoSegmento.ToString(),
                                   a.CrossSellingAsociacionID.ToString(),
                                   a.DescripcionSegmento.ToString()
                                }
                                   }
                        };
                        return Json(data, JsonRequestBehavior.AllowGet);

                    #endregion
                    }
                }



            }
            return RedirectToAction("Index", "Bienvenida");
        }

        [HttpPost]
        public JsonResult InsertAsociacionCrossSelling(CrossSellingAsociacionModel model)
        {
            try
            {
                Mapper.CreateMap<CrossSellingAsociacionModel, BECrossSellingAsociacion>()
                    .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID))
                    .ForMember(t => t.CampaniaID, f => f.MapFrom(c => c.CampaniaID))
                    .ForMember(t => t.CUV, f => f.MapFrom(c => c.CUV))
                    .ForMember(t => t.CUVAsociado, f => f.MapFrom(c => c.CUVAsociado))
                    .ForMember(t => t.CUVAsociado2, f => f.MapFrom(c => c.CUVAsociado2))
                    .ForMember(t => t.CodigoSegmento, f => f.MapFrom(c => c.CodigoSegmento))
					.ForMember(t => t.Descripcion, f => f.MapFrom(c => c.Descripcion))
                    .ForMember(t => t.EtiquetaPrecio, f => f.MapFrom(c => c.EtiquetaPrecio));//1673CC

                BECrossSellingAsociacion entidad = Mapper.Map<CrossSellingAsociacionModel, BECrossSellingAsociacion>(model);

                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    entidad.PaisID = model.PaisID;
                    sv.InsCrossSellingAsociacion(entidad);
                }
                return Json(new
                {
                    success = true,
                    message = "Se registró la Asociación del Producto Recomendado satisfactoriamente.",
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
        public JsonResult UpdateAsociacionCrossSelling(CrossSellingAsociacionModel model)
        {
            try
            {
                Mapper.CreateMap<CrossSellingAsociacionModel, BECrossSellingAsociacion>()
                    .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID))
                    .ForMember(t => t.CampaniaID, f => f.MapFrom(c => c.CampaniaID))
                    .ForMember(t => t.CUV, f => f.MapFrom(c => c.CUV))
                    .ForMember(t => t.CUVAsociado, f => f.MapFrom(c => c.CUVAsociado))
                    .ForMember(t => t.CUVAsociado2, f => f.MapFrom(c => c.CUVAsociado2))
					.ForMember(t => t.Descripcion, f => f.MapFrom(c => c.Descripcion))
                    .ForMember(t => t.EtiquetaPrecio, f => f.MapFrom(c => c.EtiquetaPrecio));//1673CC

                BECrossSellingAsociacion entidad = Mapper.Map<CrossSellingAsociacionModel, BECrossSellingAsociacion>(model);

                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    entidad.PaisID = model.PaisID;
                    sv.UpdCrossSellingAsociacion(entidad);
                }
                return Json(new
                {
                    success = true,
                    message = "Se actualizó la Asociación del Producto Recomendado satisfactoriamente.",
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
        public JsonResult DeleteAsociacionCrossSelling(CrossSellingAsociacionModel model)
        {
            try
            {
                Mapper.CreateMap<CrossSellingAsociacionModel, BECrossSellingAsociacion>()
                    .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID))
                    .ForMember(t => t.CampaniaID, f => f.MapFrom(c => c.CampaniaID))
                    .ForMember(t => t.CUV, f => f.MapFrom(c => c.CUV))
                    .ForMember(t => t.CUVAsociado, f => f.MapFrom(c => c.CUVAsociado));

                BECrossSellingAsociacion entidad = Mapper.Map<CrossSellingAsociacionModel, BECrossSellingAsociacion>(model);

                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    entidad.PaisID = model.PaisID;
                    sv.DelCrossSellingAsociacion(entidad);
                }
                return Json(new
                {
                    success = true,
                    message = "Se eliminó la Asociación del Producto Recomendado satisfactoriamente.",
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


        public JsonResult ObtenerCUVAsociado_Segmentacion(int PaisID, int CampaniaID, string CodigoSegmento)
        {
            //PaisID = 11;
            IEnumerable<CrossSellingAsociacionModel> lst = GetCUVAsociadoByFilter(PaisID, CampaniaID, "", CodigoSegmento);
            return Json(new
            {
                lista = lst,
            }, JsonRequestBehavior.AllowGet);
        }

		public ActionResult ObtenerCUVAsociado_Perfil(string sidx, string sord, int page, int rows,
        int CampaniaID, string CodigoSegmento, string CrossSellingAsociacionID)
        {
            if (ModelState.IsValid)
            {
                int PaisID = UserData().PaisID;
                List<BECrossSellingAsociacion> lst;
                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    lst = sv.GetCUVAsociadoByFilter(PaisID, CampaniaID, "", CodigoSegmento).ToList();

                }

                string ISO = Util.GetPaisISO(PaisID);

                // Usamos el modelo para obtener los datos
                BEGrid grid = new BEGrid();
                grid.PageSize = rows;
                grid.CurrentPage = page;
                grid.SortColumn = sidx;
                grid.SortOrder = sord;
                //int buscar = int.Parse(txtBuscar);
                BEPager pag = new BEPager();
                IEnumerable<BECrossSellingAsociacion> items = lst;

                #region Sort Section
                if (sord == "asc")
                {
                    switch (sidx)
                    {
                        case "CodigoCampania":
                            items = lst.OrderBy(x => x.CodigoCampania);
                            break;
                        case "CUV":
                            items = lst.OrderBy(x => x.CUV);
                            break;
                        case "Descripcion":
                            items = lst.OrderBy(x => x.Descripcion);
                            break;
                        case "PrecioOferta":
                            items = lst.OrderBy(x => x.PrecioOferta);
                            break;
                    }
                }
                else
                {
                    switch (sidx)
                    {
                        case "CodigoCampania":
                            items = lst.OrderByDescending(x => x.CodigoCampania);
                            break;
                        case "CUV":
                            items = lst.OrderByDescending(x => x.CUV);
                            break;
                        case "Descripcion":
                            items = lst.OrderByDescending(x => x.Descripcion);
                            break;
                        case "PrecioOferta":
                            items = lst.OrderByDescending(x => x.PrecioOferta);
                            break;
                    }
                }
                #endregion

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
                               id = a.NroOrden,
                               cell = new string[] 
                               {
                                   CampaniaID.ToString(),
                                   a.CUV.ToString(),
                                   a.Descripcion.ToString(),
                                   a.EtiquetaPrecio.ToString(),//1673CC                                  
                                   a.CrossSellingAsociacionID.ToString()                       
                                }
                           }
                };
                return Json(data, JsonRequestBehavior.AllowGet);

            }
            return RedirectToAction("Index", "Bienvenida");
        }


        [HttpPost]
        public JsonResult DeleteAsociacionCrossSelling_Perfil(CrossSellingAsociacionModel model)
        {
            try
            {
                Mapper.CreateMap<CrossSellingAsociacionModel, BECrossSellingAsociacion>()
                    .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID))
                    .ForMember(t => t.CrossSellingAsociacionID, f => f.MapFrom(c => c.CrossSellingAsociacionID))
                    .ForMember(t => t.CampaniaID, f => f.MapFrom(c => c.CampaniaID));
                BECrossSellingAsociacion entidad = Mapper.Map<CrossSellingAsociacionModel, BECrossSellingAsociacion>(model);

                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    entidad.PaisID = model.PaisID;
                    sv.DelCrossSellingAsociacion_Perfil(entidad);
                }
                return Json(new
                {
                    success = true,
                    message = "Se eliminó la Asociación del Producto Recomendado satisfactoriamente.",
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
        #endregion

    }
}
