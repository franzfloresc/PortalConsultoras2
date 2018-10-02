using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.ServiceUsuario;
using Portal.Consultoras.Entities;
using System.ServiceModel;


namespace Portal.Consultoras.Web.Controllers
{
    public class ReporteContratoController : BaseController
    {
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult ConsultaReporte(string sidx, string sord, int page, int rows, string CodigoConsultora, string Cedula, string FechaInicio, string FechaFin)
        {
            BEGrid grid = new BEGrid
            {
                PageSize = rows,
                CurrentPage = page,
                SortColumn = sidx,
                SortOrder = sord
            };

            try
            {
                List<BeReporteContrato> lst;
                using (var usuarioServiceClient = new UsuarioServiceClient())
                {

                    DateTime? fechaIni = (FechaInicio == "" ? default(DateTime?) : Convert.ToDateTime(FechaInicio));
                    DateTime? FechaFi = (FechaInicio == "" ? default(DateTime?) : Convert.ToDateTime(FechaFin));

                    lst = usuarioServiceClient.ReporteContratoAceptacion(userData.PaisID, CodigoConsultora, Cedula, fechaIni, FechaFi).ToList();
                    IEnumerable<BeReporteContrato> items = lst;
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
                                    a.Registro.ToString(),
                                    a.CodigoConsultora ?? string.Empty,
                                    a.NombreConsultora ?? string.Empty,
                                    a.AceptoContrato ?? string.Empty,
                                    a.FechaAceptacion ?? string.Empty,
                                    a.Origen ?? string.Empty,
                                    a.DireccionIP ?? string.Empty,
                                    a.InformacionSOMobile ?? string.Empty,
                                    a.IMEI ?? string.Empty,
                                    a.DeviceID ?? string.Empty
                                   }
                               }
                    };
                    return Json(data, JsonRequestBehavior.AllowGet);
                }
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
                return null;
            }
           
        }

        public ActionResult ExportarExcel(string CodigoConsultora, string Cedula, string FechaInicio, string FechaFin)
        {
            List<BeReporteContrato> lst;

            using (var usuarioServiceClient = new UsuarioServiceClient())
            {

                DateTime? fechaIni = (FechaInicio == "" ? default(DateTime?) : Convert.ToDateTime(FechaInicio));
                DateTime? FechaFi = (FechaInicio == "" ? default(DateTime?) : Convert.ToDateTime(FechaFin));
                lst = usuarioServiceClient.ReporteContratoAceptacion(userData.PaisID, CodigoConsultora, Cedula, fechaIni, FechaFi).ToList();
            }



            //lst.Update(p => p.NombreCompleto = (p.PrimerNombre ?? "") + " " + (p.SegundoNombre ?? "") + " " + (p.PrimerApellido ?? "") + " " + (p.SegundoApellido ?? ""));

            //lst.Update(p => p.FechaTransaccionFormat = p.FechaTransaccion.ToString("dd/MM/yyyy") == "01/01/0001" ? "--/--" : p.FechaTransaccion.ToString("dd/MM/yyyy"));
            //lst.Update(p => p.FechaTransaccionHoraFormat = p.FechaTransaccion.ToString("dd/MM/yyyy") == "01/01/0001" ? "" : p.FechaTransaccion.ToString("HH:mm"));

            //lst.Update(p => p.FechaCreacionFormat = p.FechaCreacion.ToString("dd/MM/yyyy") == "01/01/0001" ? "--/--" : p.FechaCreacion.ToString("dd/MM/yyyy"));
            //lst.Update(p => p.FechaCreacionHoraFormat = p.FechaCreacion.ToString("dd/MM/yyyy") == "01/01/0001" ? "" : p.FechaCreacion.ToString("HH:mm"));

            Dictionary<string, string> dic = new Dictionary<string, string>
            {
                {"Registro", "Registro"},
                {"Código Consultora", "CodigoConsultora"},
                {"Nombre Consultora", "NombreConsultora"},
                {"Acepto Contrato", "AceptoContrato"},
                {"Fecha Aceptacion", "FechaAceptacion"},
                {"Origen", "Origen"},
                {"Dirección IP", "DireccionIP"},
                {"InformacionSOMobile", "InformacionSOMobile"},
                {"IMEI", "IMEI"},
                {"DeviceID", "DeviceID"}
            };
            Util.ExportToExcel<BeReporteContrato>("ReporteContratoExcel", lst, dic);
            return View();
        }



    }
}