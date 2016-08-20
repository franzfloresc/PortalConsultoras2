using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceODS;
using Portal.Consultoras.Web.ServiceSAC;
using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Web;
using System.Web.Mvc;
using System.Web.Script.Serialization;

namespace Portal.Consultoras.Web.Controllers
{
    public class PercepcionesController : BaseController
    {
        //
        // GET: /Percepciones/

        public ActionResult Index()
        {
            try
            {
                if (!UsuarioModel.HasAcces(ViewBag.Permiso, "Percepciones/Index"))
                    return RedirectToAction("Index", "Bienvenida");
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
            }

            var model = new PercepcionesModel();

            model.CodigoConsultora = UserData().CodigoConsultora;
            model.CodigoTerritorial = UserData().CodigoTerritorio;

            return View(model);
        }
        public ActionResult PercepcionDetalle()
        {
            if (Request.Form["data"] == null)
                return RedirectToAction("Index");

            JavaScriptSerializer serializer = new JavaScriptSerializer();

            Dictionary<string, object> data = serializer.Deserialize<Dictionary<string, object>>(Request.Form["data"]);

            List<BEDatosBelcorp> lsta;

            string IdComprobantePercepcion = data["IdComprobantePercepcion"].ToString();
            string RUCAgentePerceptor = data["RUCAgentePerceptor"].ToString();
            string NombreAgentePerceptor = data["NombreAgentePerceptor"].ToString();
            string NumeroComprobanteSerie = data["NumeroComprobanteSerie"].ToString();
            string FechaEmision = data["FechaEmision"].ToString();
            string ImportePercepcion = Convert.ToDecimal(data["ImportePercepcion"]).ToString("0.00");
            string ImportePercepcionTexto = "Son: " + Util.enletras(Convert.ToDecimal(data["ImportePercepcion"]).ToString("0.00")) + " Nuevos Soles";

            using (SACServiceClient sv = new SACServiceClient())
            {
                lsta = sv.GetDatosBelcorp(UserData().PaisID).ToList();
            }

            var model = new PercepcionesModel();

            model.IdComprobantePercepcion = IdComprobantePercepcion;
            model.RUCAgentePerceptor = RUCAgentePerceptor;
            model.NombreAgentePerceptor = NombreAgentePerceptor;
            model.NumeroComprobanteSerie = NumeroComprobanteSerie;
            model.FechaEmision = FechaEmision;
            model.ImportePercepcion = UserData().Simbolo + " " + ImportePercepcion;
            model.ImportePercepcionTexto = ImportePercepcionTexto;
            model.Direccion = lsta[0].Direccion;
            model.RUC = lsta[0].RUC;
            model.RazonSocial = lsta[0].RazonSocial;

            return View(model);
        }

        public ActionResult Consultar(string sidx, string sord, int page, int rows)
        {
            if (ModelState.IsValid)
            {
                List<BEComprobantePercepcion> lst;
                using (ODSServiceClient sv = new ODSServiceClient())
                {
                    lst = sv.SelectComprobantePercepcion(UserData().PaisID, UserData().ConsultoraID).ToList();
                }

                // Usamos el modelo para obtener los datos
                BEGrid grid = new BEGrid();
                grid.PageSize = rows;
                grid.CurrentPage = page;
                grid.SortColumn = sidx;
                grid.SortOrder = sord;
                //int buscar = int.Parse(txtBuscar);
                BEPager pag = new BEPager();
                IEnumerable<BEComprobantePercepcion> items = lst;

                #region Sort Section
                if (sord == "asc")
                {
                    switch (sidx)
                    {
                        case "NumeroComprobanteSerie":
                            items = lst.OrderBy(x => x.NumeroComprobanteSerie);
                            break;
                        case "FechaEmision":
                            items = lst.OrderBy(x => x.FechaEmision);
                            break;
                        case "ImportePercepcion":
                            items = lst.OrderBy(x => x.ImportePercepcion);
                            break;
                    }
                }
                else
                {
                    switch (sidx)
                    {
                        case "NumeroComprobanteSerie":
                            items = lst.OrderByDescending(x => x.NumeroComprobanteSerie);
                            break;
                        case "FechaEmision":
                            items = lst.OrderByDescending(x => x.FechaEmision);
                            break;
                        case "ImportePercepcion":
                            items = lst.OrderByDescending(x => x.ImportePercepcion);
                            break;
                    }
                }
                #endregion

                items = items.ToList().Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);

                pag = Paginador(grid, lst);

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
                                   a.IdComprobantePercepcion.ToString(),
                                   a.RUCAgentePerceptor.ToString(),
                                   a.DireccionAgentePerceptor,
                                   a.NombreAgentePerceptor,
                                   a.NumeroComprobante.ToString(),
                                   a.FechaEmision.ToString("dd/MM/yyyy"),
                                   a.ImportePercepcion.ToString("0.00")
                                }
                           }
                };
                return Json(data, JsonRequestBehavior.AllowGet);
            }
            return RedirectToAction("Index", "Bienvenida");
        }

        public JsonResult ConsultarDetalle(string sidx, string sord, int page, int rows, string IdComprobantePercepcion, string IdComprobantePercepcion2)
        {

            List<BEComprobantePercepcionDetalle> lst;
            using (ODSServiceClient sv = new ODSServiceClient())
            {
                lst = sv.SelectComprobantePercepcionDetalle(UserData().PaisID, Convert.ToInt32(IdComprobantePercepcion)).ToList();
            }

            // Usamos el modelo para obtener los datos
            BEGrid grid = new BEGrid();
            grid.PageSize = rows;
            grid.CurrentPage = page;
            grid.SortColumn = sidx;
            grid.SortOrder = sord;
            //int buscar = int.Parse(txtBuscar);
            BEPager pag = new BEPager();
            IEnumerable<BEComprobantePercepcionDetalle> items = lst;

            #region Sort Section
            if (sord == "asc")
            {
                switch (sidx)
                {
                    case "TipoDocumento":
                        items = lst.OrderBy(x => x.TipoDocumento);
                        break;
                    case "NumeroDocumentoSerie":
                        items = lst.OrderBy(x => x.NumeroDocumentoSerie);
                        break;
                    case "NumeroDocumentoCorrelativo":
                        items = lst.OrderBy(x => x.NumeroDocumentoCorrelativo);
                        break;
                    case "FechaEmisionDocumento":
                        items = lst.OrderBy(x => x.FechaEmisionDocumento);
                        break;
                    case "Monto":
                        items = lst.OrderBy(x => x.Monto);
                        break;
                    case "PorcentajePercepcion":
                        items = lst.OrderBy(x => x.PorcentajePercepcion);
                        break;
                    case "ImportePercepcion":
                        items = lst.OrderBy(x => x.ImportePercepcion);
                        break;
                    case "MontoTotal":
                        items = lst.OrderBy(x => x.MontoTotal);
                        break;
                }
            }
            else
            {
                switch (sidx)
                {
                    case "TipoDocumento":
                        items = lst.OrderByDescending(x => x.TipoDocumento);
                        break;
                    case "NumeroDocumentoSerie":
                        items = lst.OrderByDescending(x => x.NumeroDocumentoSerie);
                        break;
                    case "NumeroDocumentoCorrelativo":
                        items = lst.OrderByDescending(x => x.NumeroDocumentoCorrelativo);
                        break;
                    case "FechaEmisionDocumento":
                        items = lst.OrderByDescending(x => x.FechaEmisionDocumento);
                        break;
                    case "Monto":
                        items = lst.OrderByDescending(x => x.Monto);
                        break;
                    case "PorcentajePercepcion":
                        items = lst.OrderByDescending(x => x.PorcentajePercepcion);
                        break;
                    case "ImportePercepcion":
                        items = lst.OrderByDescending(x => x.ImportePercepcion);
                        break;
                    case "MontoTotal":
                        items = lst.OrderByDescending(x => x.MontoTotal);
                        break;
                }
            }
            #endregion

            items = items.ToList().Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);

            pag = PaginadorDetalle(grid, lst);

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
                                   a.TipoDocumento,
                                   a.NumeroDocumentoSerie,
                                   a.NumeroDocumentoCorrelativo,
                                   a.FechaEmisionDocumento.ToString("dd/MM/yyyy"),
                                   a.Monto.ToString("0.00"),
                                   a.PorcentajePercepcion.ToString("0.00"),
                                   a.ImportePercepcion.ToString("0.00"),
                                   a.MontoTotal.ToString("0.00")
                                }
                       }
            };
            return Json(data, JsonRequestBehavior.AllowGet);


        }
        public JsonResult GetDatosBelcorp(PercepcionesModel item)
        {
            try
            {
                List<BEDatosBelcorp> lsta;
                using (SACServiceClient sv = new SACServiceClient())
                {
                    lsta = sv.GetDatosBelcorp(UserData().PaisID).ToList();
                }
                if (lsta == null)
                {
                    lsta = new List<BEDatosBelcorp>();
                }

                string ImportePercepcionTexto = "Son: " + Util.enletras(Convert.ToDecimal(item.ImportePercepcion).ToString("0.00")) + " Nuevos Soles"; ;

                return Json(new
                {
                    success = true,
                    Direccion = lsta[0].Direccion,
                    RUC = lsta[0].RUC,
                    RazonSocial = lsta[0].RazonSocial,
                    Simbolo = UserData().Simbolo,
                    Texto = ImportePercepcionTexto
                });

            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                });
            }
        }

        public BEPager Paginador(BEGrid item, List<BEComprobantePercepcion> lst)
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
        public BEPager PaginadorDetalle(BEGrid item, List<BEComprobantePercepcionDetalle> lst)
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

        public ActionResult ExportarPDF(string vIdComprobantePercepcion, string vRUCAgentePerceptor, string vNombreAgentePerceptor, string vNumeroComprobanteSerie,
            string vFechaEmision, string vImportePercepcion, string vImportePercepcionTexto, string vSimbolo)
        {
            string[] lista = new string[10];
            lista[0] = vIdComprobantePercepcion;
            lista[1] = vRUCAgentePerceptor;
            lista[2] = vNombreAgentePerceptor;
            lista[3] = vNumeroComprobanteSerie;
            lista[4] = vFechaEmision;
            lista[5] = vImportePercepcion;
            lista[6] = vImportePercepcionTexto;
            lista[7] = UserData().PaisID.ToString();
            lista[8] = vSimbolo;
            //Util.ExportToPdf(this, "PedidoReservado.pdf", "PedidoValidadoImp", Util.EncriptarQueryString(lista));
            Util.ExportToPdfWebPages(this, "Percepciones.pdf", "PercepcionDetalle", Util.EncriptarQueryString(lista));
            return View();
        }
    }
}
