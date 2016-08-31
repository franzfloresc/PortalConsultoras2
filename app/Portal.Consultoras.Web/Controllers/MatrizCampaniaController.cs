using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Portal.Consultoras.Web.ServiceZonificacion;
using Portal.Consultoras.Web.ServiceODS;
using Portal.Consultoras.Web.ServiceSAC;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using AutoMapper;
using System.ServiceModel;


namespace Portal.Consultoras.Web.Controllers
{
    public class MatrizCampaniaController : BaseController
    {
        //
        // GET: /MatrizCampaniaModel/

        #region Action

        public ActionResult Actualizarmatrizcampania()
        {
            try
            {
                if (!UsuarioModel.HasAcces(ViewBag.Permiso, "MatrizCampania/Actualizarmatrizcampania"))
                    return RedirectToAction("Index", "Bienvenida");
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
            }
            var model = new MatrizCampaniaModel();
            model.listaPaises = DropDowListPaises();
            model.DropDownListCampania = DropDowListCampania();
            return View(model);
        }
        //public ActionResult ConsultarProductoCampania(string sidx, string sord, int page, int rows, string vCampania, string vNombre)
        //{
        //    if (ModelState.IsValid)
        //    {
        //        List<ServiceODS.BEProductoDescripcion> lst;
        //        using (ODSServiceClient sv = new ODSServiceClient())
        //        {
        //            lst = sv.GetProductoComercialByCampania(UserData().PaisID, Convert.ToInt32(vCampania)).ToList();
        //        }

        //        // Usamos el modelo para obtener los datos
        //        BEGrid grid = new BEGrid();
        //        grid.PageSize = rows;
        //        grid.CurrentPage = page;
        //        grid.SortColumn = sidx;
        //        grid.SortOrder = sord;
        //        //int buscar = int.Parse(txtBuscar);
        //        BEPager pag = new BEPager();
        //        IEnumerable<ServiceODS.BEProductoDescripcion> items = lst;

        //        #region Sort Section
        //        if (sord == "asc")
        //        {
        //            switch (sidx)
        //            {
        //                case "CUV":
        //                    items = lst.OrderBy(x => x.CUV);
        //                    break;
        //                case "Descripcion":
        //                    items = lst.OrderBy(x => x.Descripcion);
        //                    break;
        //            }
        //        }
        //        else
        //        {
        //            switch (sidx)
        //            {
        //                case "CUV":
        //                    items = lst.OrderByDescending(x => x.CUV);
        //                    break;
        //                case "Descripcion":
        //                    items = lst.OrderByDescending(x => x.Descripcion);
        //                    break;
        //            }
        //        }
        //        #endregion

        //        if (string.IsNullOrEmpty(vNombre))
        //            items = items.ToList().Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);
        //        else
        //            items = items.Where(p => p.Descripcion.ToUpper().Contains(vNombre.ToUpper())).ToList().Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);

        //        pag = Paginador(grid, Convert.ToInt32(vCampania), vNombre);

        //        // Creamos la estructura
        //        var data = new
        //        {
        //            total = pag.PageCount,
        //            page = pag.CurrentPage,
        //            records = pag.RecordCount,
        //            rows = from a in items
        //                   select new
        //                   {
        //                       id = a.CUV,
        //                       cell = new string[] 
        //                       {
        //                           a.CUV.ToString(),
        //                           a.Descripcion
        //                        }
        //                   }
        //        };
        //        return Json(data, JsonRequestBehavior.AllowGet);
        //    }
        //    return RedirectToAction("Consultar");
        //}
        [HttpPost]
        public JsonResult InsertarProductoDescripcion(MatrizCampaniaModel model)
        {
            try
            {
                Mapper.CreateMap<MatrizCampaniaModel, ServiceSAC.BEProductoDescripcion>()
                    .ForMember(t => t.CUV, f => f.MapFrom(c => c.CUV))
                    .ForMember(t => t.CampaniaID, f => f.MapFrom(c => c.CampaniaID))
                    .ForMember(t => t.Descripcion, f => f.MapFrom(c => c.Descripcion))
                    .ForMember(t => t.PrecioProducto, f => f.MapFrom(c => c.PrecioProducto))
                    .ForMember(t => t.FactorRepeticion, f => f.MapFrom(c => c.FactorRepeticion))
                    .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID));

                ServiceSAC.BEProductoDescripcion entidad = Mapper.Map<MatrizCampaniaModel, ServiceSAC.BEProductoDescripcion>(model);

                using (SACServiceClient sv = new SACServiceClient())
                {
                    sv.UpdProductoDescripcion(entidad, UserData().CodigoUsuario);
                }
                return Json(new
                {
                    success = true,
                    message = "El producto se actualizó satisfactoriamente.",
                    extra = ""
                });
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Ocurrió un problema al intentar acceder al servicio, intente nuevamente.",
                    extra = ""
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Ocurrió un problema al intentar acceder al servicio, intente nuevamente.",
                    extra = ""
                });
            }
        }
        [HttpPost]
        public JsonResult ConsultarDescripcion(string CUV, string IDCampania, string paisID)
        {
            try
            {
                List<ServiceSAC.BEProductoDescripcion> lst = new List<ServiceSAC.BEProductoDescripcion>();
                //decimal precio = 0; GR-1060

                using (SACServiceClient sv = new SACServiceClient())
                {
                    lst = sv.GetProductoDescripcionByCUVandCampania(Convert.ToInt32(paisID), Convert.ToInt32(IDCampania), CUV).ToList();
                    
                }

                if (lst.Count == 0)
                {
                    return Json(new
                    {
                        success = false,
                        message = "El CUV ingresado no se encuentra registrado para la campaña seleccionada, verifique.",
                        extra = ""
                    });
                }
                else
                {
                    ///GR-1060

                    //using (ServicePROL.ServiceStockSsic svs = new ServicePROL.ServiceStockSsic())
                    //{
                    //    svs.Url = ConfigurarUrlServiceProl();
                    //    precio = svs.wsObtenerPrecioPack(CUV,UserData().CodigoISO, IDCampania);
                    //}

                    ///end GR-1060

                    return Json(new
                    {
                        success = true,
                        lstProducto = lst,
                        //precio = precio, //////////GR-1060
                        message = "",
                        extra = ""
                    });
                }

            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Ocurrió un problema al intentar acceder al servicio, intente nuevamente.",
                    extra = ""
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Ocurrió un problema al intentar acceder al servicio, intente nuevamente.",
                    extra = ""
                });
            }
        }

        #endregion

        #region Metodos

        public JsonResult CargarCampania(string vPaisID)
        {
            var model = new MatrizCampaniaModel();
            List<BECampania> lst = new List<BECampania>();
            try
            {
                using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
                {
                    if (vPaisID != "")
                    {
                        lst = sv.SelectCampanias(UserData().PaisID).ToList();
                        lst.Insert(0, new BECampania { CampaniaID = 0, Codigo = "-- Seleccionar --" });
                        return Json(new
                        {
                            DropDownListCampania = lst
                        }, JsonRequestBehavior.AllowGet);
                    }
                    else
                    {
                        lst.Insert(0, new BECampania { CampaniaID = 0, Codigo = "-- Seleccionar --" });
                        return Json(new
                        {
                            DropDownListCampania = lst
                        }, JsonRequestBehavior.AllowGet);
                    }
                }
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                lst.Insert(0, new BECampania { CampaniaID = 0, NombreCorto = "-- Seleccionar --" });
                return Json(new
                {
                    DropDownListCampania = lst
                }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                lst.Insert(0, new BECampania { CampaniaID = 0, NombreCorto = "-- Seleccionar --" });
                return Json(new
                {
                    DropDownListCampania = lst
                }, JsonRequestBehavior.AllowGet);
            }
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
        private List<BECampania> DropDowListCampania()
        {
            var model = new MatrizCampaniaModel();
            List<BECampania> lst = new List<BECampania>();
            lst.Insert(0, new BECampania { CampaniaID = 0, Codigo = "-- Seleccionar --" });
            return lst;

        }

        //public BEPager Paginador(BEGrid item, int campaniaID, string vBusqueda)
        //{
        //    List<ServiceODS.BEProductoDescripcion> lst;
        //    using (ODSServiceClient sv = new ODSServiceClient())
        //    {
        //        lst = sv.GetProductoComercialByCampania(UserData().PaisID, campaniaID).ToList();
        //    }

        //    BEPager pag = new BEPager();

        //    int RecordCount;

        //    if (string.IsNullOrEmpty(vBusqueda))
        //        RecordCount = lst.Count;
        //    else
        //        RecordCount = lst.Where(p => p.Descripcion.ToUpper().Contains(vBusqueda.ToUpper())).ToList().Count();

        //    pag.RecordCount = RecordCount;

        //    int PageCount = (int)(((float)RecordCount / (float)item.PageSize) + 1);
        //    pag.PageCount = PageCount;

        //    int CurrentPage = (int)item.CurrentPage;
        //    pag.CurrentPage = CurrentPage;

        //    if (CurrentPage > PageCount)
        //        pag.CurrentPage = PageCount;

        //    return pag;
        //}

        #endregion

    }
}
