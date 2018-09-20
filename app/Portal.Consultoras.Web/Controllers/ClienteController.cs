using AutoMapper;
using ClosedXML.Excel;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceCliente;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.ServiceModel;
using System.Web;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class ClienteController : BaseController
    {
        #region Actions

        public ActionResult Index()
        {
            string sap = "";
            var url = (Request.Url.Query).Split('?');
            if (EsDispositivoMovil())
            {
                //return RedirectToAction("Index", "Cliente", new { area = "Mobile" });
                if (url.Length > 1)
                {
                    sap = "&" + url[1];
                    return RedirectToAction("Index", "Cliente", new { area = "Mobile", sap });
                }
                else
                {
                    return RedirectToAction("Index", "Cliente", new { area = "Mobile" });
                }

            }
            
            if (!UsuarioModel.HasAcces(ViewBag.Permiso, "Cliente/Index"))
                return RedirectToAction("Index", "Bienvenida");

            return View();
        }

        public ActionResult MisClientes()
        {
            return View();
        }

        [HttpGet]
        public PartialViewResult Detalle(ClienteModel cliente)
        {
            if (cliente.ClienteID != 0)
            {
                try
                {
                    ModelState.Clear();
                    using (var sv = new ClienteServiceClient())
                    {
                        var clienteService = sv.SelectByConsultoraByCodigo(userData.PaisID, userData.ConsultoraID, cliente.ClienteID, 0);
                        cliente = Mapper.Map<ClienteModel>(clienteService);
                    }
                }
                catch (FaultException ex) { LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO); }
                catch (Exception ex) { LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO); }
            }
            return PartialView(cliente);
        }

        [HttpPost]
        public JsonResult Mantener(ClienteModel model)
        {
            List<BEClienteDB> clientes = new List<BEClienteDB>();
            List<BEClienteContactoDB> contactos = new List<BEClienteContactoDB>();

            try
            {
                if (!string.IsNullOrEmpty(model.Celular))
                {
                    contactos.Add(new BEClienteContactoDB()
                    {
                        ClienteID = model.ClienteID,
                        Estado = Constantes.ClienteEstado.Activo,
                        TipoContactoID = Constantes.ClienteTipoContacto.Celular,
                        Valor = model.Celular
                    });
                }

                if (!string.IsNullOrEmpty(model.Telefono))
                {
                    contactos.Add(new BEClienteContactoDB()
                    {
                        ClienteID = model.ClienteID,
                        Estado = Constantes.ClienteEstado.Activo,
                        TipoContactoID = Constantes.ClienteTipoContacto.TelefonoFijo,
                        Valor = model.Telefono
                    });
                }

                if (!string.IsNullOrEmpty(model.eMail))
                {
                    contactos.Add(new BEClienteContactoDB()
                    {
                        ClienteID = model.ClienteID,
                        Estado = Constantes.ClienteEstado.Activo,
                        TipoContactoID = Constantes.ClienteTipoContacto.Correo,
                        Valor = model.eMail
                    });
                }

                clientes.Add(new BEClienteDB()
                {
                    CodigoCliente = model.CodigoCliente,
                    ClienteID = model.ClienteID,
                    Nombres = model.NombreCliente,
                    Apellidos = model.ApellidoCliente,
                    ConsultoraID = userData.ConsultoraID,
                    Origen = Constantes.ClienteOrigen.Desktop,
                    Estado = Constantes.ClienteEstado.Activo,
                    Contactos = contactos.ToArray()
                });

                List<BEClienteDB> response;
                using (var sv = new ClienteServiceClient())
                {
                    response = sv.SaveDB(userData.PaisID, clientes.ToArray()).ToList();
                }

                var itemResponse = response.First();

                if (itemResponse.CodigoRespuesta == Constantes.ClienteValidacion.Code.SUCCESS)
                {
                    return Json(new
                    {
                        success = true,
                        message = (itemResponse.Insertado ? "Se registró con éxito tu cliente." : "Se actualizó con éxito tu cliente."),
                        extra = string.Format("{0}|{1}", itemResponse.CodigoCliente, itemResponse.ClienteID)
                    });
                }
                else
                {
                    return Json(new
                    {
                        success = false,
                        message = itemResponse.MensajeRespuesta,
                        extra = ""
                    });
                }
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

        public ActionResult Consultar(string sidx, string sord, int page, int rows, string vBusqueda)
        {
            if (ModelState.IsValid)
            {
                List<BECliente> lst;
                using (ClienteServiceClient sv = new ClienteServiceClient())
                {
                    lst = sv.SelectByConsultora(userData.PaisID, userData.ConsultoraID).ToList();
                }

                BEGrid grid = new BEGrid
                {
                    PageSize = rows,
                    CurrentPage = page,
                    SortColumn = sidx,
                    SortOrder = sord
                };
                IEnumerable<BECliente> items = lst;

                #region Sort Section
                if (sord == "asc")
                {
                    switch (sidx)
                    {
                        case "Nombre":
                            items = lst.OrderBy(x => x.Nombre);
                            break;
                        case "Telefono":
                            items = lst.OrderBy(x => x.Telefono);
                            break;
                        case "Celular":
                            items = lst.OrderBy(x => x.Celular);
                            break;
                        case "eMail":
                            items = lst.OrderBy(x => x.eMail);
                            break;
                        case "ClienteID":
                            items = lst.OrderBy(x => x.ClienteID);
                            break;
                    }
                }
                else
                {
                    switch (sidx)
                    {
                        case "Nombre":
                            items = lst.OrderByDescending(x => x.Nombre);
                            break;
                        case "Telefono":
                            items = lst.OrderByDescending(x => x.Telefono);
                            break;
                        case "Celular":
                            items = lst.OrderByDescending(x => x.Celular);
                            break;
                        case "eMail":
                            items = lst.OrderByDescending(x => x.eMail);
                            break;
                        case "ClienteID":
                            items = lst.OrderByDescending(x => x.ClienteID);
                            break;
                    }
                }
                #endregion

                if (string.IsNullOrEmpty(vBusqueda))
                    items = items.Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);
                else
                    items = items.Where(p => p.Nombre.ToUpper().Contains(vBusqueda.ToUpper())).Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);

                BEPager pag = Paginador(grid, vBusqueda);

                var data = new
                {
                    Registros = grid.PageSize.ToString(),
                    RegistrosTotal = pag.RecordCount.ToString(),
                    Pagina = pag.CurrentPage.ToString(),
                    PaginaDe = pag.PageCount.ToString(),
                    rows = items
                };
                return Json(data, JsonRequestBehavior.AllowGet);
            }
            return RedirectToAction("Index", "Bienvenida");
        }

        public JsonResult Eliminar(int ClienteID)
        {
            try
            {
                bool rslt;
                using (ClienteServiceClient sv = new ClienteServiceClient())
                {
                    rslt = sv.Delete(userData.PaisID, userData.ConsultoraID, ClienteID);
                }

                var mensaje = rslt ? "Se eliminó satisfactoriamente el registro." : "No es posible eliminar al cliente dado que se encuentra asociado a un pedido.";

                return Json(new
                {
                    success = true,
                    message = mensaje,
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

        public JsonResult DeshacerCambios(int ClienteID)
        {
            try
            {
                using (ClienteServiceClient sv = new ClienteServiceClient())
                {
                    sv.UndoCliente(userData.PaisID, userData.ConsultoraID, ClienteID);
                }
                return Json(new
                {
                    success = true,
                    message = "Se deshicieron los cambios satisfactoriamente",
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

        #endregion

        #region Método Paginador

        public BEPager Paginador(BEGrid item, string vBusqueda)
        {
            List<BECliente> lst;
            using (ClienteServiceClient sv = new ClienteServiceClient())
            {
                lst = sv.SelectByConsultora(userData.PaisID, userData.ConsultoraID).ToList();
            }

            BEPager pag = new BEPager();

            var recordCount = string.IsNullOrEmpty(vBusqueda)
                ? lst.Count
                : lst.Count(p => p.Nombre.ToUpper().Contains(vBusqueda.ToUpper()));

            pag.RecordCount = recordCount;

            int pageCount = (int)(((float)recordCount / (float)item.PageSize) + 1);
            pag.PageCount = pageCount;

            int currentPage = item.CurrentPage;
            pag.CurrentPage = currentPage;

            if (currentPage > pageCount)
                pag.CurrentPage = pageCount;

            return pag;
        }

        #endregion

        public JsonResult ObtenerTodosClientes()
        {
            try
            {
                List<BECliente> lst;
                using (ClienteServiceClient sv = new ClienteServiceClient())
                {
                    lst = sv.SelectByConsultora(userData.PaisID, userData.ConsultoraID).ToList();
                }
                return Json(new
                {
                    success = true,
                    message = "",
                    lista = lst
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "",
                    lista = new List<BECliente>()
                });
            }
        }

        public ActionResult ExportarExcelMisClientes()
        {
            List<BECliente> lst;
            using (ClienteServiceClient sv = new ClienteServiceClient())
            {
                lst = sv.SelectByConsultora(userData.PaisID, userData.ConsultoraID).ToList();
            }

            List<KeyValuePair<int, string>> dicCabeceras = new List<KeyValuePair<int, string>>();

            if (lst.Count != 0)
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


            //string[] arrTotal = { "Total a Pagar:", userData.Simbolo + " #Cargo" };

            ExportToExcelMisClientes("MisClientes", lst, dicCabeceras, dic);
            return new EmptyResult();
        }

        private void ExportToExcelMisClientes(string filename, List<BECliente> sourceDetails, List<KeyValuePair<int, string>> columnHeaderDefinition,
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
                            BECliente source = sourceDetails[i];

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
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
        }
    }
}
