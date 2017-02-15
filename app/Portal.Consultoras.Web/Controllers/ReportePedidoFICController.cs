using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServiceZonificacion;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.ServiceModel;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class ReportePedidoFICController : BaseController
    {
        public ActionResult Index()
        {
            var reportePedidoCampaniaModel = new ReportePedidoFICModel();
            try
            {
                ViewBag.Pais = userData.PaisID;

                var listaCampanias = DropDowListCampanias(11);

                reportePedidoCampaniaModel = new ReportePedidoFICModel()
                {
                    listaCampanias = new List<CampaniaModel>(),
                    listaPaises = DropDowListPaises(),
                    listaRegiones = new List<RegionModel>(),
                    listaZonas = new List<ZonaModel>()
                };
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
            return View(reportePedidoCampaniaModel);
        }

        public ActionResult ConsultarPedidoFIC(string sidx, string sord, int page, int rows, string vPaisID, string vCampania, string vRegion, string vZona, string vConsultora)
        {
            if (ModelState.IsValid)
            {
                List<BEServicePROLFIC> lst = new List<BEServicePROLFIC>();
                BEPais bepais = new BEPais();
                DataTable dt = new DataTable();
                WsFuncionesSoap2.WsFuncionesSoapClient BusinessService = new WsFuncionesSoap2.WsFuncionesSoapClient();
                WsFuncionesSoap.WsFuncionesSoapClient BusinessService2 = new WsFuncionesSoap.WsFuncionesSoapClient();
                try
                {
                    if (vPaisID == "")
                    {
                        lst = new List<BEServicePROLFIC>();
                    }
                    else
                    {
                        using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
                        {
                            bepais = sv.SelectPais(Convert.ToInt32(vPaisID));
                        }
                        if (bepais.CodigoISO == "AR" || bepais.CodigoISO == "DO" || bepais.CodigoISO == "MX" || bepais.CodigoISO == "PR" || bepais.CodigoISO == "EC" || bepais.CodigoISO == "PA" || bepais.CodigoISO == "VE")
                        {
                            dt = BusinessService.ObtenerMatrizProl(bepais.CodigoISO, vCampania).data.Tables[0];
                        }
                        else if (bepais.CodigoISO == "CL" || bepais.CodigoISO == "GT" || bepais.CodigoISO == "PE" || bepais.CodigoISO == "SV")
                        {
                            dt = BusinessService2.ObtenerMatrizProl(bepais.CodigoISO, vCampania).data.Tables[0];
                        }
                        else
                        {
                            dt = BusinessService2.ObtenerMatrizProl(bepais.CodigoISO, vCampania).data.Tables[0];
                        }


                        if (vRegion == "" || vRegion == "-- Todas --") vRegion = "x";
                        if (vZona == "" || vZona == "-- Todas --") vZona = "x";
                        if (vConsultora == "") vConsultora = "";

                        using (PedidoServiceClient sv = new PedidoServiceClient())
                        {
                            sv.InsTempServiceProl(bepais.PaisID, dt);
                            lst = sv.GetReportePedidoFIC(bepais.PaisID, vCampania, vRegion, vZona, vConsultora).ToList();
                        }
                    }
                }
                catch (Exception ex)
                {
                    lst = new List<BEServicePROLFIC>();
                    LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                }

                BEGrid grid = new BEGrid();
                grid.PageSize = rows;
                grid.CurrentPage = page;
                grid.SortColumn = sidx;
                grid.SortOrder = sord;
                //int buscar = int.Parse(txtBuscar);
                BEPager pag = new BEPager();
                IEnumerable<BEServicePROLFIC> items = lst;

                #region Sort Section
                if (sord == "asc")
                {
                    switch (sidx)
                    {
                        case "ZONA":
                            items = lst.OrderBy(x => x.ZONA);
                            break;
                        case "CUENTA":
                            items = lst.OrderBy(x => x.CUENTA);
                            break;
                        case "COD_ESTR":
                            items = lst.OrderBy(x => x.COD_ESTR);
                            break;
                        case "VAL_I18N":
                            items = lst.OrderBy(x => x.VAL_I18N);
                            break;
                        case "NUM_OFER":
                            items = lst.OrderBy(x => x.NUM_OFER);
                            break;
                        case "CUV":
                            items = lst.OrderBy(x => x.CUV);
                            break;
                        case "PRODUCTO":
                            items = lst.OrderBy(x => x.PRODUCTO);
                            break;
                        case "TIPO_OFETA":
                            items = lst.OrderBy(x => x.TIPO_OFETA);
                            break;
                        case "UNIDADES":
                            items = lst.OrderBy(x => x.UNIDADES);
                            break;
                        case "VENTA_NETA":
                            items = lst.OrderBy(x => x.VENTA_NETA);
                            break;
                    }
                }
                else
                {
                    switch (sidx)
                    {
                        case "ZONA":
                            items = lst.OrderByDescending(x => x.ZONA);
                            break;
                        case "CUENTA":
                            items = lst.OrderByDescending(x => x.CUENTA);
                            break;
                        case "COD_ESTR":
                            items = lst.OrderByDescending(x => x.COD_ESTR);
                            break;
                        case "VAL_I18N":
                            items = lst.OrderByDescending(x => x.VAL_I18N);
                            break;
                        case "NUM_OFER":
                            items = lst.OrderByDescending(x => x.NUM_OFER);
                            break;
                        case "CUV":
                            items = lst.OrderByDescending(x => x.CUV);
                            break;
                        case "PRODUCTO":
                            items = lst.OrderByDescending(x => x.PRODUCTO);
                            break;
                        case "TIPO_OFETA":
                            items = lst.OrderByDescending(x => x.TIPO_OFETA);
                            break;
                        case "UNIDADES":
                            items = lst.OrderByDescending(x => x.UNIDADES);
                            break;
                        case "VENTA_NETA":
                            items = lst.OrderByDescending(x => x.VENTA_NETA);
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
                               cell = new string[] 
                               {
                                   bepais.Nombre,
                                   vCampania,
                                   a.FechaRegistro == null ? "" : Convert.ToDateTime(a.FechaRegistro.ToString()).ToShortDateString() + " "+ Convert.ToDateTime(a.FechaRegistro.ToString()).ToShortTimeString(),                                  
                                  a.FechaModificacion == null ? "" : Convert.ToDateTime(a.FechaModificacion.ToString()).ToShortDateString() + " "+ Convert.ToDateTime(a.FechaRegistro.ToString()).ToShortTimeString(),
                                   a.ZONA,
                                   a.CUENTA,
                                   a.COD_ESTR,
                                   a.VAL_I18N,
                                   a.NUM_OFER,
                                   a.CUV,
                                   a.PRODUCTO,
                                   a.TIPO_OFETA,
                                   a.UNIDADES,
                                   Convert.ToDecimal(a.VENTA_NETA).ToString("0.#0")
                                }
                           }
                };
                return Json(data, JsonRequestBehavior.AllowGet);
            }
            return RedirectToAction("Index");
        }

        public void LoadConsultorasCache(int PaisID)
        {
            using (ServiceODS.ODSServiceClient sv = new ServiceODS.ODSServiceClient())
            {
                sv.LoadConsultoraCodigo(PaisID);
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

        private IEnumerable<CampaniaModel> DropDowListCampanias(int PaisID)
        {
            //PaisID = 11;
            IList<BECampania> lst;
            using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
            {
                lst = sv.SelectCampanias(PaisID);
            }
            Mapper.CreateMap<BECampania, CampaniaModel>()
                    .ForMember(t => t.CampaniaID, f => f.MapFrom(c => c.CampaniaID))
                    .ForMember(t => t.Codigo, f => f.MapFrom(c => c.Codigo));

            return Mapper.Map<IList<BECampania>, IEnumerable<CampaniaModel>>(lst);
        }

        public JsonResult GetConsultorasIds(int RegionID, int ZonaID, int rowCount, string vBusqueda)
        {
            using (ServiceODS.ODSServiceClient sv = new ServiceODS.ODSServiceClient())
            {
                ServiceODS.BEConsultoraCodigo[] entidad = sv.SelectConsultoraCodigo(UserData().PaisID, RegionID, ZonaID, vBusqueda, rowCount);
                return Json(entidad, JsonRequestBehavior.AllowGet);
            }
        }

        public BEPager Paginador(BEGrid item, List<ReportePedidoCampaniaModel> lst)
        {
            BEPager pag = new BEPager();

            int RecordCount;

            RecordCount = lst.Count;

            pag.RecordCount = RecordCount;

            int PageCount = (int)(((float)RecordCount / (float)item.PageSize) + 1);
            pag.PageCount = PageCount;

            int CurrentPage = (int)item.CurrentPage;
            pag.CurrentPage = CurrentPage;

            if (CurrentPage > PageCount)
                pag.CurrentPage = PageCount;

            return pag;
        }

        public ActionResult ExportarExcel(string vPaisID, string vCampania, string vRegion, string vZona, string vConsultora)
        {
            List<BEServicePROLFIC> lst = new List<BEServicePROLFIC>();
            BEPais bepais = new BEPais();
            DataTable dt = new DataTable();
            WsFuncionesSoap2.WsFuncionesSoapClient BusinessService = new WsFuncionesSoap2.WsFuncionesSoapClient();
            WsFuncionesSoap.WsFuncionesSoapClient BusinessService2 = new WsFuncionesSoap.WsFuncionesSoapClient();
            try
            {


                using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
                {
                    bepais = sv.SelectPais(Convert.ToInt32(vPaisID));
                }
                if (bepais.CodigoISO == "AR" || bepais.CodigoISO == "DO" || bepais.CodigoISO == "MX" || bepais.CodigoISO == "PR" || bepais.CodigoISO == "EC" || bepais.CodigoISO == "PA" || bepais.CodigoISO == "VE")
                {
                    dt = BusinessService.ObtenerMatrizProl(bepais.CodigoISO, vCampania).data.Tables[0];
                }
                else if (bepais.CodigoISO == "CL" || bepais.CodigoISO == "GT" || bepais.CodigoISO == "PE" || bepais.CodigoISO == "SV")
                {
                    dt = BusinessService2.ObtenerMatrizProl(bepais.CodigoISO, vCampania).data.Tables[0];
                }
                else
                {
                    dt = BusinessService2.ObtenerMatrizProl(bepais.CodigoISO, vCampania).data.Tables[0];
                }

                

                if (vRegion == "" || vRegion == "-- Todas --") vRegion = "x";
                if (vZona == "" || vZona == "-- Todas --") vZona = "x";
                if (vConsultora == "") vConsultora = "";

                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    sv.InsTempServiceProl(bepais.PaisID, dt);
                    lst = sv.GetReportePedidoFIC(bepais.PaisID, vCampania, vRegion, vZona, vConsultora).ToList();
                }

            }
            catch (Exception ex)
            {
                lst = new List<BEServicePROLFIC>();
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
            }

            Dictionary<string, string> dic = new Dictionary<string, string>();
            if (bepais.PaisID==5 || bepais.PaisID==8 || bepais.PaisID==7 || bepais.PaisID==9)
            {
                dic.Add("País", "PAIS");
                dic.Add("Periodo", "PERIODO");
                dic.Add("Fecha Registro", "FechaRegistro");
                dic.Add("Fecha Modificación", "FechaModificacion");
                dic.Add("Zona", "ZONA");
                dic.Add("Cuenta", "CUENTA");
                dic.Add("Código de Estrategia", "COD_ESTR");
                dic.Add("Descripción", "VAL_I18N");
                dic.Add("Número de oferta", "NUM_OFER");
                dic.Add("CUV", "CUV");
                dic.Add("Producto", "PRODUCTO");
                dic.Add("Tipo de Oferta", "TIPO_OFETA");
                dic.Add("Unidades", "UNIDADES");
                dic.Add("Venta Neta", "VENTA_NETA");
            }
            else
            {
                dic.Add("País", "PAIS");
                dic.Add("Periodo", "PERIODO");
                dic.Add("Zona", "ZONA");
                dic.Add("Cuenta", "CUENTA");
                dic.Add("Código de Estrategia", "COD_ESTR");
                dic.Add("Descripción", "VAL_I18N");
                dic.Add("Número de oferta", "NUM_OFER");
                dic.Add("CUV", "CUV");
                dic.Add("Producto", "PRODUCTO");
                dic.Add("Tipo de Oferta", "TIPO_OFETA");
                dic.Add("Unidades", "UNIDADES");
                dic.Add("Venta Neta", "VENTA_NETA");
            }
            

            Util.ExportToExcel_FIC("PedidosFICExcel", lst, dic);
            return View();
        }

        public JsonResult ObtenterCampaniasyRegionesPorPais(int PaisID)
        {
            IEnumerable<CampaniaModel> lst;
            IEnumerable<RegionModel> lstRegiones;
            IEnumerable<ZonaModel> lstZonas;
            if (PaisID == 0)
            {
                lst = null;
                lstRegiones = null;
                lstZonas = null;

                return Json(new
                {
                    lista = lst,
                    lstRegiones = lstRegiones,
                    listaZonas = lstZonas
                }, JsonRequestBehavior.AllowGet);
            }
            else
            {
                lst = DropDowListCampanias(PaisID);
                lstRegiones = DropDownListRegiones(PaisID);
                lstZonas = DropDownListZonas(PaisID);

                return Json(new
                {
                    lista = lst,
                    lstRegiones = lstRegiones.OrderBy(x => x.Codigo),
                    listaZonas = lstZonas.OrderBy(x => x.Codigo)
                }, JsonRequestBehavior.AllowGet);
            }

        }
    }
}
