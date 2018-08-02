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
                List<BEServicePROLFIC> lst;
                BEPais bepais = new BEPais();

                try
                {
                    if (vPaisID == "")
                    {
                        lst = new List<BEServicePROLFIC>();
                    }
                    else
                    {
                        if (vRegion == "" || vRegion == "-- Todas --") vRegion = "x";
                        if (vZona == "" || vZona == "-- Todas --") vZona = "x";

                        using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
                        {
                            bepais = sv.SelectPais(Convert.ToInt32(vPaisID));
                        }

                        using (PedidoServiceClient sv = new PedidoServiceClient())
                        {
                            lst = sv.GetReportePedidoFIC(bepais.PaisID, vCampania, vRegion, vZona, vConsultora).ToList();
                        }
                    }
                }
                catch (Exception ex)
                {
                    lst = new List<BEServicePROLFIC>();
                    LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                }

                BEGrid grid = new BEGrid(sidx, sord, page, rows);
                IEnumerable<BEServicePROLFIC> items = lst;

                #region Sort Section
                bool orderAsc = (sord == "asc");
                switch (sidx)
                {
                    case "ZONA": items = lst.OrderBy(x => x.ZONA, orderAsc); break;
                    case "CUENTA": items = lst.OrderBy(x => x.CUENTA, orderAsc); break;
                    case "CUV": items = lst.OrderBy(x => x.CUV, orderAsc); break;
                    case "PRODUCTO": items = lst.OrderBy(x => x.PRODUCTO, orderAsc); break;
                    case "TIPO_OFETA": items = lst.OrderBy(x => x.TIPO_OFETA, orderAsc); break;
                    case "UNIDADES": items = lst.OrderBy(x => x.UNIDADES, orderAsc); break;
                    case "VENTA_NETA": items = lst.OrderBy(x => x.VENTA_NETA, orderAsc); break;
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
                               cell = new string[]
                               {
                                    bepais.Nombre,
                                    vCampania,
                                    a.FechaRegistro == null ? "" : Convert.ToDateTime(a.FechaRegistro.ToString()).ToShortDateString() + " "+ Convert.ToDateTime(a.FechaRegistro.ToString()).ToShortTimeString(),
                                    a.FechaModificacion == null ? "" : Convert.ToDateTime(a.FechaModificacion.ToString()).ToShortDateString() + " "+ Convert.ToDateTime(a.FechaRegistro.ToString()).ToShortTimeString(),
                                    a.ZONA,
                                    a.CUENTA,
                                    a.CUV,
                                    a.PRODUCTO,
                                    a.TIPO_OFETA,
                                    a.UNIDADES,
                                    Util.DecimalToStringFormat(a.VENTA_NETA, bepais.CodigoISO)
                                }
                           }
                };
                return Json(data, JsonRequestBehavior.AllowGet);
            }
            return RedirectToAction("Index");
        }

        private IEnumerable<PaisModel> DropDowListPaises()
        {
            List<BEPais> lst;
            using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
            {
                lst = userData.RolID == 2
                    ? sv.SelectPaises().ToList()
                    : new List<BEPais> { sv.SelectPais(userData.PaisID) };
            }
            return Mapper.Map<IEnumerable<PaisModel>>(lst);
        }

        private IEnumerable<CampaniaModel> DropDowListCampanias(int paisId)
        {
            IList<BECampania> lst;
            using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
            {
                lst = sv.SelectCampanias(paisId);
            }
            return Mapper.Map<IEnumerable<CampaniaModel>>(lst);
        }

        public JsonResult GetConsultorasIds(int regionID, int zonaID, int rowCount, string busqueda)
        {
            using (ServiceODS.ODSServiceClient sv = new ServiceODS.ODSServiceClient())
            {
                ServiceODS.BEConsultoraCodigo[] entidad = sv.SelectConsultoraCodigo(userData.PaisID, regionID, zonaID, busqueda, rowCount);
                return Json(entidad, JsonRequestBehavior.AllowGet);
            }
        }

        public ActionResult ExportarExcel(string vPaisID, string vCampania, string vRegion, string vZona, string vConsultora)
        {
            if (vRegion == "" || vRegion == "-- Todas --") vRegion = "x";
            if (vZona == "" || vZona == "-- Todas --") vZona = "x";

            List<BEServicePROLFIC> lst;
            try
            {
                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    lst = sv.GetReportePedidoFIC(Convert.ToInt32(vPaisID), vCampania, vRegion, vZona, vConsultora).ToList();
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                lst = new List<BEServicePROLFIC>();
            }

            var dic = new Dictionary<string, string>
            {
                {"País", "PAIS"},
                {"Periodo", "PERIODO"},
                {"Fecha Registro", "FechaRegistro"},
                {"Fecha Modificación", "FechaModificacion"},
                {"Zona", "ZONA"},
                {"Cuenta", "CUENTA"},
                {"CUV", "CUV"},
                {"Producto", "PRODUCTO"},
                {"Descripción", "Descripcion"},
                {"Marca", "Marca"},
                {"Categoría", "Categoria"},
                {"Tipo de Oferta", "TIPO_OFETA"},
                {"Unidades", "UNIDADES"},
                {"Venta Neta", "VENTA_NETA"}
            };

            Util.ExportToExcel_FIC("PedidosFICExcel", lst, dic);
            return View();
        }

        public JsonResult ObtenterCampaniasyRegionesPorPais(int PaisID)
        {
            IEnumerable<CampaniaModel> lst = null;
            IEnumerable<RegionModel> lstRegiones = null;
            IEnumerable<ZonaModel> lstZonas = null;

            if (PaisID != 0)
            {
                lst = DropDowListCampanias(PaisID);
                lstRegiones = _baseProvider.DropDownListRegiones(PaisID).OrderBy(x => x.Codigo);
                lstZonas = _baseProvider.DropDownListZonas(PaisID).OrderBy(x => x.Codigo);
            }

            return Json(new
            {
                lista = lst,
                lstRegiones = lstRegiones,
                listaZonas = lstZonas
            }, JsonRequestBehavior.AllowGet);
        }
    }
}
