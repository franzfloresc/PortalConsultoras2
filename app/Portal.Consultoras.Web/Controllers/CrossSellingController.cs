using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServiceZonificacion;
using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class CrossSellingController : BaseController
    {
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
                lst = UserData().RolID == 2
                    ? sv.SelectPaises().ToList()
                    : new List<BEPais> { sv.SelectPais(UserData().PaisID) };
            }

            return Mapper.Map<IList<BEPais>, IEnumerable<PaisModel>>(lst);
        }

        public JsonResult ObtenterCampaniasPorPais(int PaisID)
        {
            IEnumerable<CampaniaModel> lst = DropDowListCampanias(PaisID);
            return Json(new
            {
                lista = lst,
            }, JsonRequestBehavior.AllowGet);
        }

        private IEnumerable<CampaniaModel> DropDowListCampanias(int paisId)
        {
            IList<BECampania> lst;
            using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
            {
                lst = sv.SelectCampanias(paisId);
            }

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

                BEGrid grid = new BEGrid
                {
                    PageSize = rows,
                    CurrentPage = page,
                    SortColumn = sidx,
                    SortOrder = sord
                };
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

                items = items.Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);

                BEPager pag = Util.PaginadorGenerico(grid, lst);
                lst.Update(x => x.Pais = Util.GetPaisNombre(PaisID));
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
                
                if (lst != null && lst.Count > 0)
                {
                    var carpetaPais = Globals.UrlMatriz + "/" + userData.CodigoISO;
                    lst.Update(x => x.ImagenProducto = ConfigCdn.GetUrlFileCdn(carpetaPais, x.ImagenProducto));
                }                                            

                string iso = Util.GetPaisISO(PaisID);

                BEGrid grid = new BEGrid
                {
                    PageSize = rows,
                    CurrentPage = page,
                    SortColumn = sidx,
                    SortOrder = sord
                };
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

                items = items.Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);

                BEPager pag = Util.PaginadorGenerico(grid, lst);
                lst.Update(x => x.ISOPais = iso);
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
                                   a.CodigoCampania,
                                   a.CUV,
                                   a.Descripcion,
                                   a.PrecioOferta.ToString("#0.00"),
                                   a.ImagenProducto,
                                   a.FlagHabilitarProducto.ToString(),
                                   a.MensajeProducto,
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
            IEnumerable<CrossSellingProductoModel> lst = DropDowListProductosRecomendadosHabilitados(PaisID, CampaniaID, Tipo);
            return Json(new
            {
                lista = lst,
            }, JsonRequestBehavior.AllowGet);
        }

        public JsonResult ObtenerDescripcionProducto(int PaisID, int CampaniaID, string CUV)
        {
            IEnumerable<CrossSellingAsociacionModel> lst = GetDescripcionByCUV(PaisID, CampaniaID, CUV);
            return Json(new
            {
                lista = lst,
            }, JsonRequestBehavior.AllowGet);
        }

        public JsonResult ObtenerCUVAsociado(int PaisID, int CampaniaID, string CUV)
        {
            IEnumerable<CrossSellingAsociacionModel> lst = GetCUVAsociadoByFilter(PaisID, CampaniaID, CUV, "");
            return Json(new
            {
                lista = lst,
            }, JsonRequestBehavior.AllowGet);
        }

        private IEnumerable<CrossSellingProductoModel> DropDowListProductosRecomendadosHabilitados(int paisId, int campaniaId, int tipo)
        {
            List<BECrossSellingProducto> lst;
            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                lst = sv.GetProductosRecomendadosHabilitados(paisId, campaniaId, tipo).ToList();

            }

            return Mapper.Map<IList<BECrossSellingProducto>, IEnumerable<CrossSellingProductoModel>>(lst);
        }

        private IEnumerable<CrossSellingAsociacionModel> GetDescripcionByCUV(int paisId, int campaniaId, string cuv)
        {
            List<BECrossSellingAsociacion> lst;
            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                lst = sv.GetDescripcionProductoByCUV(paisId, campaniaId, cuv).ToList();

            }

            return Mapper.Map<IList<BECrossSellingAsociacion>, IEnumerable<CrossSellingAsociacionModel>>(lst);
        }

        private IEnumerable<CrossSellingAsociacionModel> GetCUVAsociadoByFilter(int paisId, int campaniaId, string cuv, string codigoSegmento)
        {
            List<BECrossSellingAsociacion> lst;
            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                lst = sv.GetCUVAsociadoByFilter(paisId, campaniaId, cuv, codigoSegmento).ToList();

            }

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

                    BEGrid grid = new BEGrid
                    {
                        PageSize = rows,
                        CurrentPage = page,
                        SortColumn = sidx,
                        SortOrder = sord
                    };
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

                    items = items.Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);

                    BEPager pag = Util.PaginadorGenerico(grid, lst);
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
                                a.CodigoCampania,
                                a.CUV,
                                a.Descripcion,
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

                        BEGrid grid = new BEGrid
                        {
                            PageSize = rows,
                            CurrentPage = page,
                            SortColumn = sidx,
                            SortOrder = sord
                        };
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

                        items = items.Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);

                        BEPager pag = Util.PaginadorGenerico(grid, lst);

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
                                    a.CodigoSegmento,
                                    a.CrossSellingAsociacionID.ToString(),
                                    a.DescripcionSegmento
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
                int paisId = UserData().PaisID;
                List<BECrossSellingAsociacion> lst;
                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    lst = sv.GetCUVAsociadoByFilter(paisId, CampaniaID, "", CodigoSegmento).ToList();

                }

                BEGrid grid = new BEGrid
                {
                    PageSize = rows,
                    CurrentPage = page,
                    SortColumn = sidx,
                    SortOrder = sord
                };
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

                items = items.Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);

                BEPager pag = Util.PaginadorGenerico(grid, lst);
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
                                   a.CUV,
                                   a.Descripcion,
                                   a.EtiquetaPrecio,
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
