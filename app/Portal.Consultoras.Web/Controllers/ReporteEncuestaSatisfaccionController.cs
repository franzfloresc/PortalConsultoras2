using AutoMapper;
using ClosedXML.Excel;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceSAC;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Reflection;
using System.ServiceModel;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class ReporteEncuestaSatisfaccionController : BaseAdmController
    {
        // GET: EncuestaSatisfaccion
        public ActionResult Index()
        {
            int paisId = userData.PaisID;
            try
            {
                if (!UsuarioModel.HasAcces(ViewBag.Permiso, "ReporteEncuestaSatisfaccion/Index"))
                    return RedirectToAction("Index", "Bienvenida");


            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
            }


            var model = new ReporteEncuestaSatisfaccionModel()
            {
                listaCampanias = _zonificacionProvider.GetCampanias(paisId),
                listaPaises = DropDowListPaises(),
                listaRegiones = _zonificacionProvider.GetRegiones(paisId),
                listaZonas = _zonificacionProvider.GetZonas(paisId),
                PaisID = paisId


            };
            return View(model);
        }

        [HttpPost]
        public ActionResult Consultar(string sidx, string sord, int page, int rows, string obj)
        {

            ReporteEncuestaSatisfaccionModel objEncuesta = Newtonsoft.Json.JsonConvert.DeserializeObject<ReporteEncuestaSatisfaccionModel>(obj);
            if (!ModelState.IsValid)
            {
                return RedirectToAction("Index", "Bienvenida");
            }
            var entidad = Mapper.Map<ReporteEncuestaSatisfaccionModel, BEEncuestaReporte>(objEncuesta);
            List<BEEncuestaReporte> lst;
            using (SACServiceClient sv = new SACServiceClient())
            {
                lst = sv.GetReporteEncuestaSatisfaccion(entidad).ToList();
            }

            BEGrid grid = new BEGrid
            {
                PageSize = rows,
                CurrentPage = page,
                SortColumn = sidx,
                SortOrder = sord
            };
            IEnumerable<BEEncuestaReporte> items = lst;
            System.Web.HttpContext.Current.Session["ListaReporteEncuesta"] = items.ToList();

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
                           id = a.EncuestaResultadoId,
                           cell = new[]
                            {
                                a.CodigoCampania?? string.Empty,
                                a.Region?? string.Empty,
                                a.Zona?? string.Empty,
                                a.CodigoConsultora?? string.Empty,
                                a.Consultora?? string.Empty,
                                a.Calificacion?? string.Empty,
                                a.Motivo?? string.Empty
                            }
                       }
            };
            
            return Json(data, JsonRequestBehavior.AllowGet);
        }


        public ActionResult ExportarExcel(string obj)
        {
            ReporteEncuestaSatisfaccionModel objEncuesta = Newtonsoft.Json.JsonConvert.DeserializeObject<ReporteEncuestaSatisfaccionModel>(obj);
            var entidad = Mapper.Map<ReporteEncuestaSatisfaccionModel, BEEncuestaReporte>(objEncuesta);

            List<BEEncuestaReporte> lst;
            var result=System.Web.HttpContext.Current.Session["ListaReporteEncuesta"];
            if (result == null)
            {
                using (SACServiceClient ps = new SACServiceClient())
                {
                    lst = ps.GetReporteEncuestaSatisfaccion(entidad).ToList();
                }
            }
            else lst = (List<BEEncuestaReporte>)result;

            Dictionary<string, string> dic = new Dictionary<string, string>
            {
                {"Campaña", "CodigoCampania"},
                {"Region", "Region"},
                {"Zona", "Zona"},
                {"Codigo Consultora", "CodigoConsultora"},
                {"Consultora", "Consultora"},
                {"Calificación", "Calificacion"},
                {"Motivo", "Motivo"}

            };

            Util.ExportToExcel("ReporteEncuestaSatisExcel", lst.ToList(), dic, GetExcelSecureCallback());
            return View();
        }


    }
}