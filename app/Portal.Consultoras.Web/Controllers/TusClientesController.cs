using Portal.Consultoras.Common;
using Portal.Consultoras.Web.LogManager;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Models.TusClientes;
using Portal.Consultoras.Web.Providers;
using Portal.Consultoras.Web.SessionManager;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
using ClosedXML.Excel;
using System.IO;
using System.Web;

namespace Portal.Consultoras.Web.Controllers
{
    public class TusClientesController : BaseController
    {
        private readonly ClienteProvider _clienteProvider;

        public TusClientesController() : this(new ClienteProvider())
        {

        }

        public TusClientesController(ClienteProvider clienteProvider) : base()
        {
            _clienteProvider = clienteProvider;
        }

        public TusClientesController(ClienteProvider clienteProvider, ISessionManager sessionManager, ILogManager logManager)
            : base(sessionManager, logManager)
        {
            _clienteProvider = clienteProvider;
        }


        // GET: TusClientes
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult Detalle()
        {
            return View();
        }

        [HttpGet]
        public ActionResult PanelLista()
        {
            return View();
        }

        [HttpGet]
        public ActionResult PanelMantener()
        {
            return View(new ClienteModel { });
        }

        [HttpPost]
        public JsonResult Consultar(string texto)
        {
            try
            {
                var clientesResult = GetClientes(texto);

                return Json(new ConsultarResult(clientesResult), JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                logManager.LogErrorWebServicesBusWrap(
                    ex,
                    userData.CodigoConsultora,
                    userData.CodigoISO,
                    "TusClientesController.Consultar"
                    );
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    extra = ""
                });
            }
        }

        private List<ClienteModel> GetClientes(string texto)
        {
            var clientesResult = (List<ClienteModel>)null;
            if (ModelState.IsValid)
            {
                clientesResult = _clienteProvider.SelectByConsultora(userData.PaisID, userData.ConsultoraID);
            }
            if (clientesResult != null && clientesResult.Any() && texto.Trim().Length > 0)
                clientesResult = clientesResult.FindAll(x => x.Nombre.Trim().ToUpper().Contains(texto.Trim().ToUpper()));
            return clientesResult;
        }

        [HttpPost]
        public JsonResult Mantener(ClienteModel client)
        {
            try
            {
                if (client == null) throw new ArgumentNullException("client", "client parameter is null");

                var clienteNuevo = client.ClienteID == 0;

                client.Origen = EsDispositivoMovil() ? Constantes.ClienteOrigen.Mobile : Constantes.ClienteOrigen.Desktop;

                var response = _clienteProvider.SaveDB(userData.PaisID, userData.ConsultoraID, client);

                if (response.CodigoRespuesta == Constantes.ClienteValidacion.Code.SUCCESS)
                {
                    return Json(new
                    {
                        success = true,
                        message = clienteNuevo ? "Se registró con éxito tu cliente." : "Se actualizó con éxito tu cliente.",
                        ClienteID = response.ClienteID,
                        CodigoCliente = response.CodigoCliente,
                        NombreCompleto = response.NombreCompleto
                    });
                }
                else
                {
                    return Json(new
                    {
                        success = false,
                        message = clienteNuevo ? "Error al registrar cliente." : "Error al actualizar cliente.",
                        response
                    });
                }
            }
            catch (Exception ex)
            {
                logManager.LogErrorWebServicesBusWrap(ex, userData.CodigoConsultora, userData.CodigoISO, "TusClientesController.Mantener");
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    Trycatch = Common.LogManager.GetMensajeError(ex)
                });
            }
        }

        [HttpPost]
        public JsonResult Eliminar(int clienteId)
        {
            try
            {
                var mensaje = _clienteProvider.Eliminar(userData.PaisID,userData.ConsultoraID,clienteId) ? 
                    "" : 
                    "No es posible eliminar al cliente dado que se encuentra asociado a un pedido.";

                return Json(new
                {
                    success = true,
                    message = mensaje,
                    extra = ""
                });

            }
            catch (Exception ex)
            {
                logManager.LogErrorWebServicesBusWrap(ex, userData.CodigoConsultora, userData.CodigoISO, "TusClientesController.Eliminar");
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    extra = ""
                });
            }
        }

        public ActionResult ExportarExcelMisClientes()
        {
            var lst = GetClientes(string.Empty);

            List<KeyValuePair<int, string>> dicCabeceras = new List<KeyValuePair<int, string>>();

            if (lst.Any())
            {
                dicCabeceras.Add(new KeyValuePair<int, string>(lst.Count, userData.NombreConsultora));
            }

            Dictionary<string, string> dic = new Dictionary<string, string>
            {
                {"Nombres y Apellidos", "msNombre"},
                {"Teléfono Fijo", "msTelefono"},
                {"Celular", "msCelular"},
                {"Correo", "mseMail"}
            };

            ExportToExcelMisClientes("MisClientes", lst, dicCabeceras, dic);

            return new EmptyResult();
        }

        private void ExportToExcelMisClientes(string filename, List<ClienteModel> sourceDetails, List<KeyValuePair<int, string>> columnHeaderDefinition,
           Dictionary<string, string> columnDetailDefinition)
        {
            try
            {
                string extension = ".xlsx";
                string originalFileName = Path.GetFileNameWithoutExtension(filename) + extension;

                var wb = new XLWorkbook();
                var ws = wb.Worksheets.Add("Hoja1");
                List<string> columns = new List<string>();

                int row = 1;

                foreach (KeyValuePair<int, string> keyvalue in columnHeaderDefinition)
                {
                    ws.Cell(row, 1).Value = keyvalue.Value;
                    ws.Range(string.Format("A{0}:E{1}", row, row)).Row(1).Merge();
                    ws.Cell(row, 1).Style.Font.Bold = true;
                    var col2 = 1;
                    foreach (KeyValuePair<string, string> keyvalue2 in columnDetailDefinition)
                    {
                        ws.Cell(row + 1, col2).Value = keyvalue2.Key;
                        col2++;
                        columns.Add(keyvalue2.Value);
                    }

                    ws.Range(row + 1, 1, row + 1, col2 - 1).AddToNamed("HeadDetails");
                    var titlesStyleh = wb.Style;
                    titlesStyleh.Font.Bold = true;
                    titlesStyleh.Alignment.Horizontal = XLAlignmentHorizontalValues.Center;
                    titlesStyleh.Fill.BackgroundColor = XLColor.FromHtml("#00A2E8");
                    titlesStyleh.Font.FontColor = XLColor.FromHtml("#ffffff");
                    wb.NamedRanges.NamedRange("HeadDetails").Ranges.Style = titlesStyleh;

                    var i = 0;

                    row += 2;
                    while (i < keyvalue.Key)
                    {
                        var col = 1;
                        foreach (string column in columns)
                        {
                            var source = sourceDetails[i];

                            var arr = column.Contains("#")
                                ? column.Split('#')
                                : new string[] { "", column };

                            if (arr[1] == "msNombre")
                            {
                                ws.Cell(row, col).Style.NumberFormat.Format = "@";
                                ws.Cell(row, col).Value = arr[0] + source.Nombre;
                                ws.Cell(row, col).Style.Fill.BackgroundColor = XLColor.FromHtml("#F0F6F8");
                            }
                            else if (arr[1] == "msTelefono")
                            {
                                ws.Cell(row, col).Style.NumberFormat.Format = "@";
                                ws.Cell(row, col).Value = arr[0] + source.Telefono;
                                ws.Cell(row, col).Style.Fill.BackgroundColor = XLColor.FromHtml("#F0F6F8");
                            }
                            else if (arr[1] == "msCelular")
                            {
                                ws.Cell(row, col).Style.NumberFormat.Format = "@";
                                ws.Cell(row, col).Value = arr[0] + source.Celular;
                                ws.Cell(row, col).Style.Fill.BackgroundColor = XLColor.FromHtml("#F0F6F8");
                            }
                            else if (arr[1] == "mseMail")
                            {
                                ws.Cell(row, col).Style.NumberFormat.Format = "@";
                                ws.Cell(row, col).Value = arr[0] + source.eMail;
                                ws.Cell(row, col).Style.Fill.BackgroundColor = XLColor.FromHtml("#F0F6F8");
                            }
                            col++;
                        }
                        row++;
                        i++;
                    }
                    row++;
                    var index = keyvalue.Key;
                    sourceDetails.RemoveRange(0, index);
                }

                ws.Columns().AdjustToContents();

                var stream = new MemoryStream();
                wb.SaveAs(stream);

                HttpContext.Response.ClearHeaders();
                HttpContext.Response.Clear();
                HttpContext.Response.Buffer = false;
                HttpContext.Response.AddHeader("Content-disposition", "attachment; filename=" + originalFileName);
                HttpContext.Response.Charset = "UTF-8";
                HttpContext.Response.Cache.SetCacheability(HttpCacheability.Private);
                HttpContext.Response.ContentType = "application/octet-stream";
                HttpContext.Response.BinaryWrite(stream.ToArray());
                HttpContext.Response.Flush();
                HttpContext.Response.End();
                stream = null;
            }
            catch (Exception ex)
            {
                logManager.LogErrorWebServicesBusWrap(ex, userData.CodigoConsultora, userData.CodigoISO, "TusClientesController.ExportToExcelMisClientes");
            }
        }
    }
}