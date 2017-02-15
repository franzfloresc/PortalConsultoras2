using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ServiceModel;
using System.Web.Mvc;
using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceSAC;
using Portal.Consultoras.Web.ServiceZonificacion;

namespace Portal.Consultoras.Web.Controllers
{

    public class BEConfiguracionParametroCargaRegionIDComparer : IEqualityComparer<BEConfiguracionParametroCarga>
    {
        #region IEqualityComparer<Contact> Members

        public bool Equals(BEConfiguracionParametroCarga x, BEConfiguracionParametroCarga y)
        {
            return x.RegionID.Equals(y.RegionID);
        }

        public int GetHashCode(BEConfiguracionParametroCarga obj)
        {
            return obj.RegionID.GetHashCode();
        }

        #endregion
    }

    public class ParametroDiasCargaPedidoController : BaseController
    {
        //
        // GET: /ParametroDiasCargaPedido/

        public ActionResult Index()
        {
            //try
            //{
            //    if (!UsuarioModel.HasAcces(ViewBag.Permiso, "ModificacionCronograma/Index"))
            //        return RedirectToAction("Index", "Bienvenida");
            //}
            //catch (FaultException ex)
            //{
            //    LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
            //}

            //await Task.Run(() => LoadConsultorasCache(11));
            //var listaCampanias = DropDowListCampanias(11);

            var parametroDiasCargaPedidoModel = new ParametroDiasCargaPedidoModel()
            {
                //listaCampanias = new List<CampaniaModel>(),
                listaPaises = DropDowListPaises(),
                listaRegiones = new List<RegionModel>(),
                listaZonas = new List<ZonaModel>()
            };
            return View(parametroDiasCargaPedidoModel);
        }

        public JsonResult ObtenerRegionesPorPais(int PaisID)
        {
            //PaisID = 11;
            IEnumerable<RegionModel> lstRegiones = DropDownListRegiones(PaisID);
            IEnumerable<ZonaModel> lstZonas = DropDownListZonas(PaisID);

            return Json(new
            {
                lstRegiones = lstRegiones.OrderBy(x => x.Codigo)
                //listaZonas = lstZonas.OrderBy(x => x.Codigo)
            }, JsonRequestBehavior.AllowGet);
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

        public JsonResult TraerRegiones(int pais)
        {
            JsTreeModel[] tree = null;
            tree = new JsTreeModel[] 
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

            // consultar las regiones y zonas
            IList<BEConfiguracionParametroCarga> lst;
            using (SACServiceClient sv = new SACServiceClient())
            {
                lst = sv.GetRegionZonaDiasParametroCarga(pais.GetValueOrDefault(), region.GetValueOrDefault(), zona.GetValueOrDefault());
            }
            // se crea el arbol de nodos para el control de la vista
            JsTreeModel[] tree = lst.Distinct<BEConfiguracionParametroCarga>(new BEConfiguracionParametroCargaRegionIDComparer()).Select(
                                    r => new JsTreeModel
                                    {
                                        data = r.RegionNombre,
                                        attr = new JsTreeAttribute
                                        {
                                            id = r.RegionID,
                                            selected = false
                                        },
                                        children = lst.Where(i => i.RegionID == r.RegionID && i.DiasParametroCarga > 1).Select(
                                                        z => new JsTreeModel
                                                        {
                                                            data = z.ZonaNombre + " (" + z.DiasParametroCarga + ")",
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
        public JsonResult GrabarZonas(List<BELogParametroDiasCargaPedido> EntradasLog, List<BEConfiguracionParametroCarga> EntradasConfiguracionParametroCarga, int DiasParametroCarga)
        {
            try
            {
                // se hace la actualizacion de modificación de cronograma
                using (SACServiceClient sv = new SACServiceClient())
                {
                    // grabar en el log cada cambio
                    sv.InsLogParametroDiasCargaPedido(UserData().PaisID, UserData().CodigoUsuario, EntradasLog.ToArray());
                    // update de la zona para el nuevo valor de dias de duracion de cronograma
                    sv.UpdConfiguracionParametroCargaPedido(UserData().PaisID, EntradasConfiguracionParametroCarga.ToArray());
                }
                return Json(new
                {
                    success = true,
                    message = "Modificación de Parametro Carga Pedido exitosa.",
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

        //public ActionResult ExportarExcel(string PaisID, string RegionID, string ZonaID, string vConsultora)
        public ActionResult ExportarExcel(int PaisID)
        {
            // consulta toda la data de ConfiguracionValidacionZona
            IList<BEConfiguracionParametroCarga> lst;
            using (SACServiceClient sv = new SACServiceClient())
            {
                lst = sv.GetRegionZonaDiasParametroCarga(PaisID, 0, 0).ToList();
            }

            Dictionary<string, string> dic = new Dictionary<string, string>();
            dic.Add("Región", "RegionNombre");
            dic.Add("Zona", "ZonaNombre");
            dic.Add("No. Dias", "DiasParametroCarga");
            Util.ExportToExcel<BEConfiguracionParametroCarga>("PedidosExcel", lst.ToList(), dic);
            return View();
        }


        public JsonResult ConsultarLog(string sidx, string sord, int page, int rows, string vBusqueda)
        {
            //if (ModelState.IsValid)
            //{
            IList<BELogParametroDiasCargaPedido> lst;
            using (SACServiceClient sv = new SACServiceClient())
            {
                lst = sv.GetLogParametroDiasCargaPedido(UserData().PaisID);
            }

            // Usamos el modelo para obtener los datos
            BEGrid grid = new BEGrid();
            grid.PageSize = rows;
            grid.CurrentPage = page;
            grid.SortColumn = sidx;
            grid.SortOrder = sord;
            //int buscar = int.Parse(txtBuscar);
            BEPager pag = new BEPager();
            IEnumerable<BELogParametroDiasCargaPedido> items = lst;

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
                    case "DiasParametroCargaActual":
                        items = lst.OrderBy(x => x.DiasParametroCargaActual);
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
                    case "DiasParametroCargaActual":
                        items = lst.OrderByDescending(x => x.DiasParametroCargaActual);
                        break;
                }
            }
            #endregion

            if (string.IsNullOrEmpty(vBusqueda))
                items = items.ToList().Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);
            else
                items = items.Where(p => p.Fecha.ToString().ToUpper().Contains(vBusqueda.ToUpper())).ToList().Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);

            pag = Paginador(grid, vBusqueda);

            // Creamos la estructura
            var data = new
            {
                total = pag.PageCount,
                page = pag.CurrentPage,
                records = pag.RecordCount,
                rows = from a in items
                       select new
                       {
                           id = a.CodigoUsuario.ToString(),
                           cell = new string[] 
                               {
                                   a.CodigoUsuario,
                                   a.Fecha.ToString(),
                                   a.CodigosRegionZona,
                                   Convert.ToString(a.DiasParametroCargaActual)
                                }
                       }
            };
            return Json(data, JsonRequestBehavior.AllowGet);
            //}
            //return RedirectToAction("Index", "ModificacionCronograma");
        }

        public BEPager Paginador(BEGrid item, string vBusqueda)
        {
            List<BELogParametroDiasCargaPedido> lst;
            using (SACServiceClient sv = new SACServiceClient())
            {
                lst = sv.GetLogParametroDiasCargaPedido(UserData().PaisID).ToList();
            }

            BEPager pag = new BEPager();

            int RecordCount;

            // TODO: probar si es necesario el valor de 'vBusqueda'
            if (string.IsNullOrEmpty(vBusqueda))
                RecordCount = lst.Count;
            else
                RecordCount = lst.Where(p => p.Fecha.ToUpper().Contains(vBusqueda.ToUpper())).ToList().Count();

            pag.RecordCount = RecordCount;

            int PageCount = (int)(((float)RecordCount / (float)item.PageSize) + 1);
            pag.PageCount = PageCount;

            int CurrentPage = (int)item.CurrentPage;
            pag.CurrentPage = CurrentPage;

            if (CurrentPage > PageCount)
                pag.CurrentPage = PageCount;

            return pag;
        }

    }
}
