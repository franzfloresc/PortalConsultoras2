using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceSAC;
using Portal.Consultoras.Web.ServiceZonificacion;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class BEConfiguracionValidacionZonaRegionIDComparer : IEqualityComparer<BEConfiguracionValidacionZona>
    {
        #region IEqualityComparer<Contact> Members

        public bool Equals(BEConfiguracionValidacionZona x, BEConfiguracionValidacionZona y)
        {
            return x.RegionID.Equals(y.RegionID);
        }

        public int GetHashCode(BEConfiguracionValidacionZona obj)
        {
            return obj.RegionID.GetHashCode();
        }

        #endregion
    }

    public class ModificacionCronogramaController : BaseController
    {
        public ActionResult Index()
        {
            var modificacionCronogramaModel = new ModificacionCronogramaModel()
            {
                listaPaises = DropDowListPaises(),
                listaRegiones = new List<RegionModel>(),
                listaZonas = new List<ZonaModel>()
            };
            return View(modificacionCronogramaModel);
        }

        public JsonResult ObtenerRegionesPorPais(int PaisID)
        {
            IEnumerable<RegionModel> lstRegiones = _baseProvider.DropDownListRegiones(PaisID);
            IEnumerable<ZonaModel> lstZonas = _baseProvider.DropDownListZonas(PaisID);

            return Json(new
            {
                lstRegiones = lstRegiones.OrderBy(x => x.Codigo),
                listaZonas = lstZonas.OrderBy(x => x.Codigo)
            }, JsonRequestBehavior.AllowGet);
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

            return Mapper.Map<IList<BEPais>, IEnumerable<PaisModel>>(lst);
        }

        public JsonResult TraerRegiones(int pais)
        {
            var tree = new JsTreeModel[]
            {
                new JsTreeModel { data = "Confirm Application", attr = new JsTreeAttribute { id = 10, selected = true } },
                new JsTreeModel
                {
                    data = "Things",
                    attr = new JsTreeAttribute { id = 20 },
                    children = new JsTreeModel[]
                    {
                        new JsTreeModel { data = "Thing 1", attr = new JsTreeAttribute { id = 21, selected = true } },
                        new JsTreeModel { data = "Thing 2", attr = new JsTreeAttribute { id = 22 } },
                        new JsTreeModel { data = "Thing 3", attr = new JsTreeAttribute { id = 23 } },
                        new JsTreeModel
                        {
                            data = "Thing 4",
                            attr = new JsTreeAttribute { id = 24 },
                            children = new JsTreeModel[]
                            {
                                new JsTreeModel { data = "Thing 4.1", attr = new JsTreeAttribute { id = 241 } },
                                new JsTreeModel { data = "Thing 4.2", attr = new JsTreeAttribute { id = 242 } },
                                new JsTreeModel { data = "Thing 4.3", attr = new JsTreeAttribute { id = 243 } }
                            },
                        },
                    }
                }
            };

            return Json(tree, JsonRequestBehavior.AllowGet);
        }

        public JsonResult CargarArbolRegionesZonas(int? pais, int? region, int? zona)
        {
            if (pais.GetValueOrDefault() == 0)
                return Json(null, JsonRequestBehavior.AllowGet);

            IList<BEConfiguracionValidacionZona> lst;
            using (SACServiceClient sv = new SACServiceClient())
            {
                lst = sv.GetRegionZonaDiasDuracionCronograma(pais.GetValueOrDefault(), region.GetValueOrDefault(), zona.GetValueOrDefault());
            }

            JsTreeModel[] tree = lst
                .Distinct<BEConfiguracionValidacionZona>(new BEConfiguracionValidacionZonaRegionIDComparer()).Select(
                    r => new JsTreeModel
                    {
                        data = r.RegionNombre,
                        attr = new JsTreeAttribute
                        {
                            id = r.RegionID,
                            selected = false
                        },
                        children = lst.Where(i => i.RegionID == r.RegionID).Select(
                            z => new JsTreeModel
                            {
                                data = z.ZonaNombre + " (" + z.DiasDuracionCronograma + ")",
                                attr = new JsTreeAttribute
                                {
                                    id = z.ZonaID,
                                    selected = false,
                                    diasDuracionCronograma = z.DiasDuracionCronograma
                                }
                            }).ToArray()
                    }).ToArray();
            return Json(tree, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult GrabarZonas(List<BELogConfiguracionCronograma> EntradasLog, List<BEConfiguracionValidacionZona> EntradasConfiguracionValidacionZona, int DiasDuracionCronograma)
        {
            try
            {
                using (SACServiceClient sv = new SACServiceClient())
                {
                    sv.InsLogConfiguracionCronogramaMasivo(userData.PaisID, userData.CodigoUsuario, EntradasLog.ToArray());
                    sv.UpdConfiguracionValidacionZonaCronograma(userData.PaisID, EntradasConfiguracionValidacionZona.ToArray());
                }
                return Json(new
                {
                    success = true,
                    message = "Modificación de cronograma exitosa.",
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

        public ActionResult ExportarExcel(int PaisID)
        {
            IList<BEConfiguracionValidacionZona> lst;
            using (SACServiceClient sv = new SACServiceClient())
            {
                lst = sv.GetRegionZonaDiasDuracionCronograma(PaisID, 0, 0).ToList();
            }

            Dictionary<string, string> dic = new Dictionary<string, string>
            {
                {"Región", "RegionNombre"},
                {"Zona", "ZonaNombre"},
                {"No. Dias Cronograma", "DiasDuracionCronograma"}
            };
            Util.ExportToExcel<BEConfiguracionValidacionZona>("PedidosExcel", lst.ToList(), dic);
            return View();
        }

        public JsonResult ConsultarLog(string sidx, string sord, int page, int rows, string vBusqueda)
        {
            IList<BELogModificacionCronograma> lst;
            using (SACServiceClient sv = new SACServiceClient())
            {
                lst = sv.GetLogModificacionCronograma(userData.PaisID);
            }

            BEGrid grid = new BEGrid
            {
                PageSize = rows,
                CurrentPage = page,
                SortColumn = sidx,
                SortOrder = sord
            };
            IEnumerable<BELogModificacionCronograma> items = lst;

            #region Sort Section
            if (sord == "asc")
            {
                switch (sidx)
                {
                    case "CodigoUsuario":
                        items = lst.OrderBy(x => x.CodigoUsuario);
                        break;
                    case "Fecha":
                        items = lst.OrderBy(x => x.Fecha);
                        break;
                    case "CodigosRegionZona":
                        items = lst.OrderBy(x => x.CodigosRegionZona);
                        break;
                    case "DiasCronogramaAnterior":
                        items = lst.OrderBy(x => x.DiasDuracionCronogramaAnterior);
                        break;
                    case "DiasCronogramaActual":
                        items = lst.OrderBy(x => x.DiasDuracionCronogramaActual);
                        break;
                }
            }
            else
            {
                switch (sidx)
                {
                    case "CodigoUsuario":
                        items = lst.OrderByDescending(x => x.CodigoUsuario);
                        break;
                    case "Fecha":
                        items = lst.OrderByDescending(x => x.Fecha);
                        break;
                    case "CodigosRegionZona":
                        items = lst.OrderByDescending(x => x.CodigosRegionZona);
                        break;
                    case "DiasCronogramaAnterior":
                        items = lst.OrderByDescending(x => x.DiasDuracionCronogramaAnterior);
                        break;
                    case "DiasCronogramaActual":
                        items = lst.OrderByDescending(x => x.DiasDuracionCronogramaActual);
                        break;
                }
            }
            #endregion

            if (string.IsNullOrEmpty(vBusqueda))
                items = items.Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);
            else
                items = items.Where(p => p.Fecha.ToString().ToUpper().Contains(vBusqueda.ToUpper())).Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);

            BEPager pag = Paginador(grid, vBusqueda);

            var data = new
            {
                total = pag.PageCount,
                page = pag.CurrentPage,
                records = pag.RecordCount,
                rows = from a in items
                       select new
                       {
                           id = a.CodigoUsuario,
                           cell = new string[]
                           {
                                   a.CodigoUsuario,
                                   a.Fecha,
                                   a.CodigosRegionZona,
                                   Convert.ToString(a.DiasDuracionCronogramaAnterior),
                                   Convert.ToString(a.DiasDuracionCronogramaActual)
                            }
                       }
            };
            return Json(data, JsonRequestBehavior.AllowGet);
        }

        public BEPager Paginador(BEGrid item, string vBusqueda)
        {
            List<BELogModificacionCronograma> lst;
            using (SACServiceClient sv = new SACServiceClient())
            {
                lst = sv.GetLogModificacionCronograma(userData.PaisID).ToList();
            }

            BEPager pag = new BEPager();

            var recordCount = string.IsNullOrEmpty(vBusqueda)
                ? lst.Count
                : lst.Count(p => p.Fecha.ToUpper().Contains(vBusqueda.ToUpper()));

            pag.RecordCount = recordCount;

            int pageCount = (int)(((float)recordCount / (float)item.PageSize) + 1);
            pag.PageCount = pageCount;

            int currentPage = item.CurrentPage;
            pag.CurrentPage = currentPage;

            if (currentPage > pageCount)
                pag.CurrentPage = pageCount;

            return pag;
        }
    }
}
