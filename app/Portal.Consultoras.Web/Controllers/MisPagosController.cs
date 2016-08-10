using ClosedXML.Excel;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceContenido;
using Portal.Consultoras.Web.ServiceODS;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServiceSAC;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.ServiceModel;
using System.Web;
using System.Web.Mvc;
using System.Web.Script.Serialization;

namespace Portal.Consultoras.Web.Controllers
{
    public class MisPagosController : BaseController
    {
        #region Acciones

        public ActionResult Index()
        {
            Session["ListadoEstadoCuenta"] = null;

            string fechaVencimiento;
            string montoPagar;

            ObtenerFechaVencimientoMontoPagar(out fechaVencimiento, out montoPagar);

            var parametroAEncriptar = userData.CodigoConsultora + "|" + DateTime.Now.ToShortDateString() + " 23:59:59" + "|" + userData.CodigoISO;

            var model = new MisPagosModel();
            model.CodigoISO = userData.CodigoISO;
            model.UrlChileEncriptada = Util.EncriptarQueryString(parametroAEncriptar);
            model.RutaChile = userData.CodigoISO == "CL" ? ConfigurationManager.AppSettings.Get("UrlPagoLineaChile") : string.Empty;
            model.MostrarFE = userData.CodigoISO == "EC" || userData.CodigoISO == "PE" ? " " : "display: none;";
            model.Simbolo = string.Format("{0} ", userData.Simbolo);
            model.TieneFlexipago = userData.IndicadorFlexiPago;
            model.MontoMinimoFlexipago = userData.IndicadorFlexiPago > 0 ? ObtenerMontoMinimo() : "0.00";
            model.TienePagoOnline = userData.IndicadorPagoOnline;
            model.UrlPagoOnline = userData.UrlPagoOnline;
            model.CorreoConsultora = userData.EMail;
            model.FechaVencimiento = fechaVencimiento;
            model.MontoPagar = montoPagar;

            return View(model);
        }

        #region Estado Cuenta

        [HttpPost]
        public JsonResult ListarEstadoCuenta(string sidx, string sord, int page, int rows, string vCampania)
        {
            List<EstadoCuentaModel> lst;

            lst = ObtenerEstadoCuenta();
            if (lst.Count != 0)
            {
                lst.RemoveAt(lst.Count - 1);
            }

            // Usamos el modelo para obtener los datos
            BEGrid grid = new BEGrid();
            grid.PageSize = rows;
            grid.CurrentPage = page;
            grid.SortColumn = sidx;
            grid.SortOrder = sord;

            BEPager pag = new BEPager();
            IEnumerable<EstadoCuentaModel> items = lst;

            lst.ForEach(l =>
            {
                if (l.Cargo > 0)
                {
                    l.TipoMovimiento = 1;
                }
                if (l.Abono > 0)
                {
                    l.TipoMovimiento = 2;
                }
            });

            items = items.ToList().Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);

            pag = Util.PaginadorGenerico(grid, lst);

            items.Where(x => x.Glosa == null).Update(r => r.Glosa = string.Empty);

            var data = new
            {
                total = pag.PageCount,
                page = pag.CurrentPage,
                records = pag.RecordCount,

                Rows = items.Select(a => new
                {
                    Fecha = a.Fecha.ToString("dd/MM/yyyy"),
                    a.Glosa,
                    Cargo = string.Format("{0} ", userData.Simbolo) + Util.DecimalToStringFormat(a.Cargo, userData.CodigoISO),
                    Abono = string.Format("{0} ", userData.Simbolo) + Util.DecimalToStringFormat(a.Abono, userData.CodigoISO)
                })
            };

            return Json(data, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult EnviarCorreoEstadoCuenta(string correo)
        {
            try
            {
                List<EstadoCuentaModel> lst = new List<EstadoCuentaModel>();
                lst = ObtenerEstadoCuenta();

                #region cotnenido del correo
                /*CO-RE2584 - CS(CGI) */
                string cadena = "<span style='font-family:Calibri'><h2> Estado de Cuenta Belcorp </h2></span>" +
                                "<table width='650px' border = '1px' bordercolor='black' cellpadding='5px' cellspacing='0px' bgcolor='dddddd' >" +
                                "<tr>" +
                                    "<th bgcolor='666666' width='100px' align='center'><font color='#FFFFFF'>Fecha</th>" +
                                    "<th bgcolor='666666' width='350px' align='center'><font color='#FFFFFF'>Últimos Movimientos</th>" +
                                    "<th bgcolor='666666' width='100px' align='center'><font color='#FFFFFF'>Pedidos</th>" +
                                    "<th bgcolor='666666' width='100px' align='center'><font color='#FFFFFF'>Abonos</th>" +
                                "</tr>";

                if (userData.PaisID == 4) // validación para colombia req. 1478
                {

                    for (int i = 0; i < lst.Count - 1; i++)
                    {
                        cadena = cadena + "<tr>" +
                                            "<td align='center'>" + lst[i].Fecha.ToString("dd/MM/yyyy") + "</td>" +
                                            "<td align='left'>" + lst[i].Glosa + "</td>" +
                                            "<td align='right'>" + string.Format("{0:#,##0}", lst[i].Cargo).Replace(',', '.') + "</td>" +
                                            "<td align='right'>" + string.Format("{0:#,##0}", lst[i].Abono).Replace(',', '.') + "</td>" +
                                          "</tr>";
                    }
                }
                else
                {
                    for (int i = 0; i < lst.Count - 1; i++)
                    {
                        cadena = cadena + "<tr>" +
                                            "<td align='center'>" + lst[i].Fecha.ToString("dd/MM/yyyy") + "</td>" +
                                            "<td align='left'>" + lst[i].Glosa + "</td>" +
                                            "<td align='right'>" + lst[i].Cargo.ToString("0.00") + "</td>" +
                                            "<td align='right'>" + lst[i].Abono.ToString("0.00") + "</td>" +
                                          "</tr>";
                    }
                }
                //R2524 - JICM - Eliminando FEcha Vencimiento,Por ahora Si no existen movimientos no se mostrará 0 en la etiqueta
                //Total a pagar si no que mostrará el valor del Monto Total a Pagar.
                if (lst.Count > 0)
                {
                    string fechaVencimiento = string.Empty;
                    if (!lst[lst.Count - 1].Fecha.ToString("yyyyMMdd").Equals("19000101") && !lst[lst.Count - 1].Fecha.ToString("yyyyMMdd").Equals("00010101"))
                    {
                        fechaVencimiento = lst[lst.Count - 1].Fecha.ToString("dd/MM/yyyy");
                    }
                    //R2524 - JICM - Formateando decimal y Eliminando Fecha Vencimiento
                    //R2524 - JICM - CC - Validación Cargo y Abono para el envío de Mail
                    if (Math.Abs(lst[lst.Count - 1].Cargo) > 0)
                    {

                        cadena = cadena + "</table><br /><br />" +
                                     "TOTAL A PAGAR: " + string.Format("{0:0.##}", lst[lst.Count - 1].Cargo).Replace(',', '.') + "<br />";

                    }
                    else if (Math.Abs(lst[lst.Count - 1].Abono) > 0)
                    {

                        cadena = cadena + "</table><br /><br />" +
                                         "TOTAL A PAGAR: " + string.Format("{0:0.##}", lst[lst.Count - 1].Abono).Replace(',', '.') + "<br />";

                    }
                    else
                    {
                        cadena = cadena + "</table><br /><br />" +
                                          "TOTAL A PAGAR: " + "0" + "<br />";
                    }
                }
                // else
                // {
                //R2524 - JICM - Eliminando FEcha Vencimiento,Por ahora Si no existen movimientos no se mostrará 0 en la etiqueta
                //Total a pagar si no que mostrará el valor del Monto Total a Pagar.

                //cadena = cadena + "</table><br /><br />" +
                //                  "TOTAL A PAGAR: " + "0" + "<br />" ;

                //  }


                //Mejora - Correo
                //cadena += "<table border='0' style='width: 650px;'>";
                //cadena += "<tr>";
                //cadena += "<td style='font-family:Arial, Helvetica, sans-serif, serif; font-weight:bold; font-size:12px; text-align:right; padding-top:8px;'>";
                //cadena += "Belcorp - " + nomPais;
                //cadena += "</td>";
                //cadena += "</tr>";
                //cadena += "</table>";

                #endregion

                Util.EnviarMail("no-responder@somosbelcorp.com", correo, "(" + userData.CodigoISO + ") Estado de Cuenta", cadena, true, userData.NombreConsultora);
                return Json(new
                {
                    success = true,
                    message = "El correo se envió de forma correcta a la cuenta: " + correo,
                    extra = ""
                });
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message,
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

        public ActionResult ExportarExcelEstadoCuenta()
        {
            decimal cargo = 0;
            decimal abono = 0;
            List<EstadoCuentaModel> lst = new List<EstadoCuentaModel>();
            List<BEEstadoCuenta> EstadoCuenta = new List<BEEstadoCuenta>();
            try
            {
                using (SACServiceClient client = new SACServiceClient())
                {
                    EstadoCuenta = client.GetEstadoCuentaConsultora(userData.PaisID, userData.UsuarioPrueba == 1 ? userData.ConsultoraAsociada : userData.CodigoConsultora).ToList();
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            List<KeyValuePair<int, string>> dicCabeceras = new List<KeyValuePair<int, string>>();

            foreach (var ec in EstadoCuenta)
            {
                lst.Add(new EstadoCuentaModel
                {
                    Fecha = ec.FechaRegistro,
                    Glosa = ec.DescripcionOperacion,
                    Cargo = ec.Cargo,
                    Abono = ec.Abono
                });
            }

            if (lst.Count != 0)
            {
                EstadoCuentaModel cuenta = lst[lst.Count - 1];
                cargo = cuenta.Cargo;
                abono = cuenta.Abono;
                lst.RemoveAt(lst.Count - 1);

                dicCabeceras.Add(new KeyValuePair<int, string>(lst.Count, userData.NombreConsultora));
                lst.Add(new EstadoCuentaModel()
                {
                    Cargo = cuenta.Cargo
                });
            }

            Dictionary<string, string> dic = new Dictionary<string, string>();

            dic.Add("Fecha", "Fecha");
            dic.Add("Ultimos Movimientos", "Glosa");
            dic.Add("Pedidos", userData.Simbolo + " #Cargo");
            dic.Add("Abonos", userData.Simbolo + " #Abono");

            string[] arrTotal = { "Total a Pagar:", userData.Simbolo + " #Cargo" };

            ExportToExcelEstadoCuenta("EstadoCuentaExcel", lst, dicCabeceras, dic, arrTotal, cargo, abono);
            return new EmptyResult();
        }

        #endregion

        #region Lugares Pago

        [HttpPost]
        public JsonResult ListarLugaresPago()
        {
            try
            {
                var lugaresPagoModel = ObtenerLugaresPago();
                return Json(lugaresPagoModel);
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
            return Json(new LugaresPagoModel { listaLugaresPago = new List<BELugarPago>() });
        }

        #endregion

        #region Percepciones

        [HttpPost]
        public JsonResult ListarPercepciones(string sidx, string sord, int page, int rows)
        {
            List<BEComprobantePercepcion> lst;
            using (ODSServiceClient sv = new ODSServiceClient())
            {
                ((BasicHttpBinding)sv.Endpoint.Binding).MaxReceivedMessageSize = int.MaxValue;
                lst = sv.SelectComprobantePercepcion(userData.PaisID, userData.ConsultoraID).ToList();
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

            #endregion Sort Section

            items = items.ToList().Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);

            pag = PaginadorPercepcion(grid, lst);

            // Creamos la estructura
            var data = new
            {
                total = pag.PageCount,
                page = pag.CurrentPage.ToString(),
                records = pag.RecordCount,
                paginaDe = pag.PageCount.ToString(),
                pageSize = grid.PageSize,
                rows = items.Select(x => new
                {
                    x.IdComprobantePercepcion,
                    x.RUCAgentePerceptor,
                    x.DireccionAgentePerceptor,
                    x.NombreAgentePerceptor,
                    x.NumeroComprobante,
                    FechaEmision = x.FechaEmision.ToString("dd/MM/yyyy"),
                    x.ImportePercepcion
                })
            };

            return Json(data, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult ObtenerDetallePercepcion(PercepcionesModel item)
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

        [HttpPost]
        public JsonResult ListarDetallePercepcion(string sidx, string sord, int page, int rows, string IdComprobantePercepcion)
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

            #endregion Sort Section

            items = items.ToList().Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);

            pag = PaginadorDetallePercepcion(grid, lst);

            // Creamos la estructura
            var data = new
            {
                total = pag.PageCount,
                page = pag.CurrentPage,
                records = pag.RecordCount,
                rows = items.Select(x => new
                {
                    x.IdComprobantePercepcion,
                    x.NumeroDocumentoSerie,
                    x.NumeroDocumentoCorrelativo,
                    FechaEmisionDocumento = x.FechaEmisionDocumento.ToString("dd/MM/yyyy"),
                    Monto = x.Monto.ToString("0.00"),
                    PorcentajePercepcion = x.PorcentajePercepcion.ToString("0.00"),
                    ImportePercepcion = x.ImportePercepcion.ToString("0.00"),
                    MontoTotal = x.MontoTotal.ToString("0.00"),
                    x.TipoDocumento
                })
            };
            return Json(data, JsonRequestBehavior.AllowGet);
        }

        public ActionResult ExportarPDFPercepcion(string vIdComprobantePercepcion, string vRUCAgentePerceptor, string vNombreAgentePerceptor, string vNumeroComprobanteSerie, string vFechaEmision, string vImportePercepcion, string vSimbolo)
        {
            string[] lista = new string[10];
            lista[0] = vIdComprobantePercepcion;
            lista[1] = vRUCAgentePerceptor;
            lista[2] = vNombreAgentePerceptor;
            lista[3] = vNumeroComprobanteSerie;
            lista[4] = vFechaEmision;
            lista[5] = vImportePercepcion;
            lista[6] = UserData().PaisID.ToString();
            lista[7] = vSimbolo;
            Util.ExportToPdfWebPages(this, "Percepciones.pdf", "PercepcionDetalle", Util.EncriptarQueryString(lista));
            return View();
        }

        public ActionResult DetallePercepcion()
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

        #endregion

        #endregion

        #region Métodos privados

        private string ObtenerMontoMinimo()
        {
            int vPaisID = userData.PaisID;
            string consultora = userData.CodigoConsultora;
            string result = string.Empty;
            using (PedidoServiceClient svc = new PedidoServiceClient())
            {
                int CampaniaID = userData.CampaniaID;
                BEOfertaFlexipago oBe = svc.GetLineaCreditoFlexipago(vPaisID, consultora, CampaniaID);
                result = string.Format("{0:#,##0.00}", (oBe.MontoMinimoFlexipago < 0 ? 0M : oBe.MontoMinimoFlexipago));
            }
            return result;
        }

        private void ObtenerFechaVencimientoMontoPagar(out string fechaVencimiento, out string montoPagar)
        {
            fechaVencimiento = "--/--";
            montoPagar = Util.DecimalToStringFormat(0, userData.CodigoISO);

            try
            {
                List<EstadoCuentaModel> lst = ObtenerEstadoCuenta();

                if (lst.Count != 0)
                {
                    using (ContenidoServiceClient sv = new ContenidoServiceClient())
                    {
                        if (userData.PaisID == 4 || userData.PaisID == 11) //Colombia y Perú
                            montoPagar = sv.GetDeudaTotal(userData.PaisID, int.Parse(userData.ConsultoraID.ToString()))[0].SaldoPendiente.ToString();
                        else
                            montoPagar = sv.GetSaldoPendiente(userData.PaisID, userData.CampaniaID, int.Parse(userData.ConsultoraID.ToString()))[0].SaldoPendiente.ToString();

                        var fechaVencimientoTemp = sv.GetFechaVencimiento(userData.PaisID, userData.CodigoISO, userData.CampaniaID, userData.CodigoConsultora);

                        fechaVencimiento = fechaVencimientoTemp.ToString("dd/MM/yyyy") == "01/01/0001"
                            ? "--/--"
                            : fechaVencimientoTemp.ToString("dd/MM/yyyy");
                    }
                }
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
        }

        private LugaresPagoModel ObtenerLugaresPago()
        {
            List<BELugarPago> lst;
            int paisID = userData.PaisID;

            using (SACServiceClient sv = new SACServiceClient())
            {
                lst = (sv.SelectLugarPago(paisID) ?? new BELugarPago[0]).ToList();
            }

            foreach (var item in lst)
            {
                item.ArchivoLogo = Url.Content(item.ArchivoLogo);
            }

            string iso = userData.CodigoISO;
            var carpetaPais = Globals.UrlLugaresPago + "/" + iso;
            if (lst.Any())
                lst.Update(x => x.ArchivoLogo = ConfigS3.GetUrlFileS3(carpetaPais, x.ArchivoLogo, Globals.RutaImagenesLugaresPago + "/" + iso));

            var lugaresPagoModel = new LugaresPagoModel()
            {
                PaisID = paisID,
                CampaniaID = userData.CampaniaID,
                ISO = iso,
                listaLugaresPago = lst
            };

            return lugaresPagoModel;
        }

        private List<EstadoCuentaModel> ObtenerEstadoCuenta()
        {
            List<EstadoCuentaModel> lst = new List<EstadoCuentaModel>();

            if (Session["ListadoEstadoCuenta"] == null)
            {
                List<BEEstadoCuenta> EstadoCuenta = new List<BEEstadoCuenta>();
                try
                {
                    using (SACServiceClient client = new SACServiceClient())
                    {
                        EstadoCuenta = client.GetEstadoCuentaConsultora(userData.PaisID, userData.UsuarioPrueba == 1 ? userData.ConsultoraAsociada : userData.CodigoConsultora).ToList();
                    }
                }
                catch (Exception ex)
                {
                    LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                }

                foreach (var ec in EstadoCuenta)
                {
                    lst.Add(new EstadoCuentaModel
                    {
                        Fecha = ec.FechaRegistro,
                        Glosa = ec.DescripcionOperacion,
                        Cargo = ec.Cargo,
                        Abono = ec.Abono
                    });
                }

                Session["ListadoEstadoCuenta"] = lst;
            }
            else
            {
                lst = Session["ListadoEstadoCuenta"] as List<EstadoCuentaModel>;
            }

            return lst;
        }

        private void ExportToExcelEstadoCuenta(string filename, List<EstadoCuentaModel> SourceDetails, List<KeyValuePair<int, string>> columnHeaderDefinition,
           Dictionary<string, string> columnDetailDefinition, string[] arrTotal, decimal cargoTotal, decimal abonoTotal)
        {
            try
            {
                string extension = ".xlsx";
                string originalFileName = System.IO.Path.GetFileNameWithoutExtension(filename) + extension;

                var wb = new XLWorkbook();
                var ws = wb.Worksheets.Add("Hoja1");
                List<string> Columns = new List<string>();
                int index = 1;

                int row = 1;
                int col = 0;
                int i = 0;

                int col2 = 1;
                foreach (KeyValuePair<int, string> keyvalue in columnHeaderDefinition)
                {
                    ws.Cell(row, 1).Value = keyvalue.Value;
                    ws.Range(string.Format("A{0}:E{1}", row, row)).Row(1).Merge();
                    ws.Cell(row, 1).Style.Font.Bold = true;
                    col2 = 1;
                    foreach (KeyValuePair<string, string> keyvalue2 in columnDetailDefinition)
                    {
                        ws.Cell(row + 1, col2).Value = keyvalue2.Key;
                        col2++;
                        Columns.Add(keyvalue2.Value);
                    }

                    ws.Range(row + 1, 1, row + 1, col2 - 1).AddToNamed("HeadDetails");
                    var titlesStyleh = wb.Style;
                    titlesStyleh.Font.Bold = true;
                    titlesStyleh.Alignment.Horizontal = XLAlignmentHorizontalValues.Center;
                    titlesStyleh.Fill.BackgroundColor = XLColor.FromHtml("#00A2E8");
                    titlesStyleh.Font.FontColor = XLColor.FromHtml("#ffffff");
                    wb.NamedRanges.NamedRange("HeadDetails").Ranges.Style = titlesStyleh;

                    i = 0;

                    row += 2;
                    while (i < keyvalue.Key)
                    {
                        col = 1;
                        foreach (string column in Columns)
                        {
                            EstadoCuentaModel source = SourceDetails[i];

                            string[] arr = new string[2];
                            if (column.Contains("#"))
                                arr = column.Split('#');
                            else
                                arr = new string[] { "", column };

                            if (arr[1] == "Fecha")
                            {
                                ws.Cell(row, col).Style.NumberFormat.Format = "@";
                                ws.Cell(row, col).Value = arr[0] + source.Fecha.ToShortDateString();
                                ws.Cell(row, col).Style.Fill.BackgroundColor = XLColor.FromHtml("#F0F6F8");
                            }

                            else if (arr[1] == "Glosa")
                            {
                                ws.Cell(row, col).Style.NumberFormat.Format = "@";
                                ws.Cell(row, col).Value = arr[0] + source.Glosa;
                                ws.Cell(row, col).Style.Fill.BackgroundColor = XLColor.FromHtml("#F0F6F8");
                            }

                            else if (arr[1] == "Cargo")
                            {
                                string cargo = "";
                                if (userData.PaisID == 4) //Colombia
                                {
                                    cargo = source.Cargo.ToString("#,##0").Replace(',', '.');
                                }
                                else
                                {
                                    cargo = source.Cargo.ToString("0.00");
                                }
                                ws.Cell(row, col).Value = arr[0] + cargo;
                                ws.Cell(row, col).Style.Fill.BackgroundColor = XLColor.FromHtml("#F0F6F8");
                            }

                            else if (arr[1] == "Abono")
                            {
                                string abono = "";
                                if (userData.PaisID == 4) //Colombia
                                {
                                    abono = source.Abono.ToString("#,##0").Replace(',', '.');
                                }
                                else
                                {
                                    abono = source.Abono.ToString("0.00");
                                }
                                ws.Cell(row, col).Value = arr[0] + abono;
                                ws.Cell(row, col).Style.Fill.BackgroundColor = XLColor.FromHtml("#F0F6F8");
                            }
                            col++;
                        }
                        row++;
                        i++;
                    }
                    Columns = new List<string>();
                    if (arrTotal.Length > 0)
                    {
                        ws.Range(row, 1, row, col - 1).AddToNamed("Totals");
                        var titlesStyle = wb.Style;
                        titlesStyle.Font.Bold = true;
                        titlesStyle.Alignment.Horizontal = XLAlignmentHorizontalValues.Left;
                        titlesStyle.Fill.BackgroundColor = XLColor.NoColor;
                        titlesStyleh.Font.FontColor = XLColor.FromHtml("#000000");
                        wb.NamedRanges.NamedRange("Totals").Ranges.Style = titlesStyle;

                        string cargo = "";
                        if (userData.PaisID == 4) //Colombia
                        {
                            if (Math.Abs(cargoTotal) > 0)
                            {
                                cargo = cargoTotal.ToString("#,##0").Replace(',', '.');
                            }
                            else if (Math.Abs(abonoTotal) > 0)
                            {
                                cargo = abonoTotal.ToString("#,##0").Replace(',', '.');
                            }

                        }
                        else
                        {
                            if (Math.Abs(cargoTotal) > 0)
                            {
                                cargo = cargoTotal.ToString("0.00");
                            }
                            else if (Math.Abs(abonoTotal) > 0)
                            {
                                cargo = abonoTotal.ToString("0.00");
                            }
                        }

                        ws.Cell(row, col - 2).Value = arrTotal[0]; //Total:
                        ws.Cell(row, col - 1).Value = arrTotal[1].Split('#')[0] + cargo;
                    }
                    row++;
                    index = keyvalue.Key + 1;
                    SourceDetails.RemoveRange(0, index);
                }

                ws.Columns().AdjustToContents();

                var stream = new MemoryStream();
                wb.SaveAs(stream);

                HttpContext.Response.ClearHeaders();
                HttpContext.Response.Clear();
                //HttpContext.Current.Response.SetCookie("Cache-Control", "private");
                HttpContext.Response.Buffer = false;
                HttpContext.Response.AddHeader("Content-disposition", "attachment; filename=" + originalFileName);
                HttpContext.Response.Charset = "UTF-8";
                HttpContext.Response.Cache.SetCacheability(HttpCacheability.Private);
                //HttpContext.Current.Response.Cache.SetCacheability(HttpCacheability.NoCache);
                HttpContext.Response.ContentType = "application/octet-stream";
                HttpContext.Response.BinaryWrite(stream.ToArray());
                HttpContext.Response.Flush();
                HttpContext.Response.End();
                stream = null;
            }
            catch (Exception)
            {
            }
        }

        private BEPager PaginadorPercepcion(BEGrid item, List<BEComprobantePercepcion> lst)
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

        private BEPager PaginadorDetallePercepcion(BEGrid item, List<BEComprobantePercepcionDetalle> lst)
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

        #endregion
    }
}
