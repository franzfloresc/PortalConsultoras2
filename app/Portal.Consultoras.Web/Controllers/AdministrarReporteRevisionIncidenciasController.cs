using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Models.ReporteRevisionIncidencias;
using Portal.Consultoras.Web.Providers;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServiceZonificacion;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.UI.WebControls;

namespace Portal.Consultoras.Web.Controllers
{
    public class AdministrarReporteRevisionIncidenciasController : BaseAdmController
    {
        //protected string _dbdefault = "dbdefault";

        protected OfertaBaseProvider _ofertaBaseProvider;

        public AdministrarReporteRevisionIncidenciasController()
        {
            _ofertaBaseProvider = new OfertaBaseProvider();
        }

        public ActionResult Index()
        {
            if (!UsuarioModel.HasAcces(ViewBag.Permiso, "AdministrarReporteRevisionIncidencias/Index"))
                return RedirectToAction("Index", "Bienvenida");

            string paisIso = Util.GetPaisISO(userData.PaisID);
            var carpetaPais = Globals.UrlMatriz + "/" + paisIso;
            var urlS3 = ConfigCdn.GetUrlCdn(carpetaPais);

            var reporteValidacionModel = new ReporteRevisionIncidenciasModel()
            {
                listaCampania = new List<CampaniaModel>(),
                listaPaises = DropDowListPaises(),
                ListaTipoEstrategia = DropDowListTipoEstrategia(),
                UrlS3 = urlS3,
                listaTipoReporte = DropDowListTipoReporte()
            };
            return View(reporteValidacionModel);
        }

        private IEnumerable<PaisModel> DropDowListPaises()
        {
            List<BEPais> lst = new List<BEPais>
            {
                new BEPais {PaisID = 0, Nombre = "Todos", NombreCorto = "Todos"}
            };

            return Mapper.Map<IList<BEPais>, IEnumerable<PaisModel>>(lst);
        }

        private IEnumerable<BETipoReporte> DropDowListTipoReporte()
        {
            List<BETipoReporte> lst = new List<BETipoReporte>
            {
                new BETipoReporte { TipoReporteId = 1, Nombre = "Reporte Cuv" },
                new BETipoReporte { TipoReporteId = 2, Nombre = "Detalle Cuv" },
                new BETipoReporte { TipoReporteId = 3, Nombre = "Estrategias por Consultora" },
                new BETipoReporte { TipoReporteId = 4, Nombre = "Cuvs Eliminados" }
            };

            return lst;
        }

        //movido BaseAdm/ObtenerCampaniasPorUsuario
        //public JsonResult ObtenerCampanias()
        //{
        //    IEnumerable<CampaniaModel> lst = _zonificacionProvider.GetCampanias(userData.PaisID);
        //    return Json(new
        //    {
        //        lista = lst
        //    }, JsonRequestBehavior.AllowGet);
        //}

        private IEnumerable<TipoEstrategiaModel> DropDowListTipoEstrategia()
        {
            var lst = _tipoEstrategiaProvider.GetTipoEstrategias(userData.PaisID);
            List<TipoEstrategiaModel> lista = new List<TipoEstrategiaModel>();

            foreach (var item in lst)
            {
                if (item.CodigoGeneral == 4 || item.CodigoGeneral == 7 || item.CodigoGeneral == 9 || item.CodigoGeneral == 12 || item.CodigoGeneral == 30)
                {
                    lista.Add(new TipoEstrategiaModel
                    {
                        TipoEstrategiaID = item.TipoEstrategiaID,
                        Descripcion = item.DescripcionEstrategia,
                        PaisID = userData.PaisID,
                        FlagNueva = item.FlagNueva,
                        FlagRecoPerfil = item.FlagRecoPerfil,
                        FlagRecoProduc = item.FlagRecoProduc,
                        CodigoGeneral = item.CodigoGeneral,
                        CodigoPrograma = item.CodigoPrograma
                    });
                }
            }

            return lista;
        }

        public ActionResult ConsultarReporteCuvResumido(string sidx, string sord, int page, int rows, int CampaniaID, string CUV)
        {
            try
            {
                //bool dbdefault = HttpUtility.ParseQueryString(((System.Web.HttpRequestWrapper)Request).UrlReferrer.Query)[_dbdefault].ToBool();

                if (ModelState.IsValid)
                {
                    List<ReporteRevisionIncidenciasMDbAdapterModel> lst = new List<ReporteRevisionIncidenciasMDbAdapterModel>();

                    using (var sv = new PedidoServiceClient())
                    {
                        var tmpReporteLst = sv.GetReporteCuvResumido(userData.PaisID, CampaniaID, CUV).ToList();
                        foreach (var itemReporte in tmpReporteLst)
                        {
                            lst.Add(new ReporteRevisionIncidenciasMDbAdapterModel { BEReporteCuvResumido = itemReporte });
                        }
                    }

                    var grid = new BEGrid
                    {
                        PageSize = rows,
                        CurrentPage = page,
                        SortColumn = sidx,
                        SortOrder = sord
                    };
                    IEnumerable<ReporteRevisionIncidenciasMDbAdapterModel> items = lst;
                    items = items.Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);
                    var pag = Util.PaginadorGenerico(grid, lst);

                    var data = new
                    {
                        total = pag.PageCount,
                        page = pag.CurrentPage,
                        records = pag.RecordCount,
                        rows = from a in items
                               select new
                               {
                                   id = a.BEReporteCuvResumido.Cuv,
                                   cell = new string[]
                                   {
                                        a.BEReporteCuvResumido.Cuv,
                                        a.BEReporteCuvResumido.SAP,
                                        a.BEReporteCuvResumido.DescripcionProd,
                                        a.BEReporteCuvResumido.Palanca,
                                        a.BEReporteCuvResumido.imagenURL,
                                        a.BEReporteCuvResumido.Activo,
                                        a.BEReporteCuvResumido.PuedeDigitarse,
                                        a.BEReporteCuvResumido.PrecioSet.ToString("#.#0")
                                   }
                               }
                    };
                    return Json(data, JsonRequestBehavior.AllowGet);
                }
                throw new Exception(ModelState.ToString());
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return ErrorJson(ex.Message, true);
            }
        }

        public ActionResult ConsultarReporteCuvDetallado(string sidx, string sord, int page, int rows, int CampaniaID, string CUV)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    List<ReporteRevisionIncidenciasMDbAdapterModel> lst = new List<ReporteRevisionIncidenciasMDbAdapterModel>();

                    using (var sv = new PedidoServiceClient())
                    {
                        var tmpReporteLst = sv.GetReporteCuvDetallado(userData.PaisID, CampaniaID, CUV).ToList();

                        foreach (var itemReporte in tmpReporteLst)
                        {
                            lst.Add(new ReporteRevisionIncidenciasMDbAdapterModel { BEReporteCuvDetallado = itemReporte });
                        }
                    }

                    var grid = new BEGrid
                    {
                        PageSize = rows,
                        CurrentPage = page,
                        SortColumn = sidx,
                        SortOrder = sord
                    };

                    IEnumerable<ReporteRevisionIncidenciasMDbAdapterModel> items = lst;
                    items = items.Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);

                    var pag = Util.PaginadorGenerico(grid, lst);
                    
                    var codigoISOPais = userData.CodigoISO;

                    var data = new
                    {
                        total = pag.PageCount,
                        page = pag.CurrentPage,
                        records = pag.RecordCount,
                        rows = from a in items
                               select new
                               {
                                   id = a.BEReporteCuvDetallado.CuvHijo,
                                   cell = new string[]
                                   {
                                        a.BEReporteCuvDetallado.DescripcionEstrategia,
                                        a.BEReporteCuvDetallado.CuvPadre,
                                        a.BEReporteCuvDetallado.CuvHijo,
                                        a.BEReporteCuvDetallado.CodigoEstrategia,
                                        a.BEReporteCuvDetallado.Grupo,
                                        a.BEReporteCuvDetallado.SAP,
                                        a.BEReporteCuvDetallado.MarcaEstrategia,
                                        a.BEReporteCuvDetallado.MarcaMatriz,
                                        a.BEReporteCuvDetallado.FactorCuadre.ToString(),
                                        a.BEReporteCuvDetallado.PrecioUnitario.ToString("#.#0"),
                                        a.BEReporteCuvDetallado.PrecioPublico.ToString("#.#0"),
                                        a.BEReporteCuvDetallado.Digitable.ToString(),
                                        a.BEReporteCuvDetallado.NombreProducto,
                                        a.BEReporteCuvDetallado.ImagenTipos,
                                        a.BEReporteCuvDetallado.ImagenTonos,
                                        a.BEReporteCuvDetallado.NombreBulk,
                                        a.BEReporteCuvDetallado.FactorRepeticion.ToString(),
                                        a.BEReporteCuvDetallado.RutaImagenTipos = string.Format(_configuracionManagerProvider.GetRutaImagenesAppCatalogo(), codigoISOPais, CampaniaID, DevolverInicialMarca(a.BEReporteCuvDetallado.CodigoMarca), a.BEReporteCuvDetallado.ImagenTipos),
                                        a.BEReporteCuvDetallado.RutaImagenTonos = string.Format(_configuracionManagerProvider.GetRutaImagenesAppCatalogoBulk(), codigoISOPais, CampaniaID, DevolverInicialMarca(a.BEReporteCuvDetallado.CodigoMarca), a.BEReporteCuvDetallado.ImagenTonos)
                                   }
                               }
                    };

                    return Json(data, JsonRequestBehavior.AllowGet);
                }

                return Json(new
                {
                    success = false,
                    message = "Algun campo requerido no ha sido ingresado",
                    data = "",
                    extra = string.Join("; ", ModelState.Values
                                        .SelectMany(x => x.Errors)
                                        .Select(x => x.ErrorMessage))
                }, JsonRequestBehavior.AllowGet);

            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);

                return Json(new
                {
                    success = false,
                    message = "Lo sentimos no podemos procesar su solicitud.",
                    data = "",
                    Trycatch = Common.LogManager.GetMensajeError(ex)
                }, JsonRequestBehavior.AllowGet);
            }
        }

        private string DevolverInicialMarca(string idMarca)
        {
            var idMarcaInt = 0;
            if (!string.IsNullOrEmpty(idMarca)) idMarcaInt = Convert.ToInt32(idMarca);
            var codigoMarca = string.Empty;
            if (idMarcaInt == Constantes.Marca.LBel) codigoMarca = "L";
            if (idMarcaInt == Constantes.Marca.Esika) codigoMarca = "E";
            if (idMarcaInt == Constantes.Marca.Cyzone) codigoMarca = "C";
            return codigoMarca;
        }

        public ActionResult ConsultarReporteEstrategiasConsultora(string sidx, string sord, int page, int rows, int CampaniaID,
           string CodigoConsultora, string FechaConsulta, int TipoEstrategiaID)
        {
            try
            {
                //bool dbdefault = HttpUtility.ParseQueryString(((System.Web.HttpRequestWrapper)Request).UrlReferrer.Query)[_dbdefault].ToBool();

                if (ModelState.IsValid)
                {
                    List<ReporteRevisionIncidenciasMDbAdapterModel> lst = new List<ReporteRevisionIncidenciasMDbAdapterModel>();

                    using (var sv = new PedidoServiceClient())
                    {
                        var tmpReporteLst = sv.GetReporteEstrategiasPorConsultora(userData.PaisID, CampaniaID, CodigoConsultora, TipoEstrategiaID, Convert.ToDateTime(FechaConsulta)).ToList();
                        foreach (var itemReporte in tmpReporteLst)
                        {
                            lst.Add(new ReporteRevisionIncidenciasMDbAdapterModel { BEReporteEstrategiasPorConsultora = itemReporte });
                        }
                    }

                    var grid = new BEGrid
                    {
                        PageSize = rows,
                        CurrentPage = page,
                        SortColumn = sidx,
                        SortOrder = sord
                    };
                    IEnumerable<ReporteRevisionIncidenciasMDbAdapterModel> items = lst;
                    items = items.Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);
                    var pag = Util.PaginadorGenerico(grid, lst);

                    var data = new
                    {
                        total = pag.PageCount,
                        page = pag.CurrentPage,
                        records = pag.RecordCount,
                        rows = from a in items
                               select new
                               {
                                   id = a.BEReporteEstrategiasPorConsultora.CUV,
                                   cell = new string[]
                                   {
                                a.BEReporteEstrategiasPorConsultora.CUV,
                                a.BEReporteEstrategiasPorConsultora.Descripcion,
                                   }
                               }
                    };
                    return Json(data, JsonRequestBehavior.AllowGet);
                }

                return RedirectToAction("Index", "AdministrarReporteRevisionIncidenciasController");
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return RedirectToAction("Index", "AdministrarReporteRevisionIncidenciasController");
            }
        }

        public ActionResult ConsultarEliminacionCuvsPedido(string sidx, string sord, int page, int rows, int CampaniaID,
           string CodigoConsultora)
        {
            try
            {
                //bool dbdefault = HttpUtility.ParseQueryString(((System.Web.HttpRequestWrapper)Request).UrlReferrer.Query)[_dbdefault].ToBool();

                if (ModelState.IsValid)
                {
                    List<ReporteRevisionIncidenciasMDbAdapterModel> lst = new List<ReporteRevisionIncidenciasMDbAdapterModel>();

                    using (var sv = new PedidoServiceClient())
                    {
                        var tmpReporteLst = sv.GetReporteMovimientosPedido(userData.PaisID, CampaniaID, CodigoConsultora).ToList();
                        foreach (var itemReporte in tmpReporteLst)
                        {
                            lst.Add(new ReporteRevisionIncidenciasMDbAdapterModel { BEReporteMovimientosPedido = itemReporte });
                        }
                    }

                    var grid = new BEGrid
                    {
                        PageSize = rows,
                        CurrentPage = page,
                        SortColumn = sidx,
                        SortOrder = sord
                    };
                    IEnumerable<ReporteRevisionIncidenciasMDbAdapterModel> items = lst;
                    items = items.Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);
                    var pag = Util.PaginadorGenerico(grid, lst);

                    var data = new
                    {
                        total = pag.PageCount,
                        page = pag.CurrentPage,
                        records = pag.RecordCount,
                        rows = from a in items
                               select new
                               {
                                   id = a.BEReporteMovimientosPedido.Cuv,
                                   cell = new string[]
                                   {
                                a.BEReporteMovimientosPedido.Cuv,
                                a.BEReporteMovimientosPedido.Descripcion,
                                a.BEReporteMovimientosPedido.FechaAccion,
                                a.BEReporteMovimientosPedido.Origen,
                                a.BEReporteMovimientosPedido.Mensaje
                                   }
                               }
                    };
                    return Json(data, JsonRequestBehavior.AllowGet);
                }
                return RedirectToAction("Index", "AdministrarReporteRevisionIncidenciasController");
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return RedirectToAction("Index", "AdministrarReporteRevisionIncidenciasController");
            }
        }

    }
}