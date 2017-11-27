﻿using AutoMapper;
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
            List<BEClienteDB> response = new List<BEClienteDB>();

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

        //[HttpPost]
        //public JsonResult Update(ClienteModel model)
        //{
        //    int vValidation = 0;
        //    try
        //    {
        //        Mapper.CreateMap<ClienteModel, BECliente>()
        //            .ForMember(t => t.ClienteID, f => f.MapFrom(c => c.ClienteID))
        //            .ForMember(t => t.eMail, f => f.MapFrom(c => c.eMail))
        //            .ForMember(t => t.Nombre, f => f.MapFrom(c => c.Nombre))
        //            .ForMember(t => t.Celular, f => f.MapFrom(c => c.Celular))
        //            .ForMember(t => t.Telefono, f => f.MapFrom(c => c.Telefono));

        //        BECliente entidad = Mapper.Map<ClienteModel, BECliente>(model);
        //        //string x = "sdasda";
        //        //int dsds = int.Parse(x);
        //        entidad.ClienteID = model.ClienteID;

        //        using (ClienteServiceClient sv = new ClienteServiceClient())
        //        {
        //            if (model.FlagValidate == 1)
        //            {
        //                vValidation = sv.CheckClienteByConsultora(userData.PaisID, userData.ConsultoraID, model.Nombre);
        //                if (vValidation > 0)
        //                {
        //                    return Json(new
        //                    {
        //                        success = false,
        //                        message = "El nombre del cliente ya se encuentra registrado, verifique.",
        //                        extra = ""
        //                    });
        //                }
        //            }

        //            entidad.PaisID = userData.PaisID;
        //            entidad.ConsultoraID = userData.ConsultoraID;
        //            entidad.Activo = true;
        //            sv.Update(entidad);

        //            Session[Constantes.ConstSession.ClientesByConsultora] = sv.SelectByConsultora(userData.PaisID, userData.ConsultoraID).ToList();

        //        }
        //        return Json(new
        //        {
        //            success = true,
        //            message = "Se actualizó con éxito tu cliente.",
        //            extra = ""
        //        });
        //    }
        //    catch (FaultException ex)
        //    {
        //        LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
        //        return Json(new
        //        {
        //            success = false,
        //            message = ex.Message,
        //            extra = ""
        //        });
        //    }
        //    catch (Exception ex)
        //    {
        //        LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
        //        return Json(new
        //        {
        //            success = false,
        //            message = ex.Message,
        //            extra = ""
        //        });
        //    }
        //}

        //[HttpPost]
        //public JsonResult Insert(ClienteModel model)
        //{
        //    int vValidation = 0;
        //    try
        //    {
        //        Mapper.CreateMap<ClienteModel, BECliente>()
        //            .ForMember(t => t.eMail, f => f.MapFrom(c => c.eMail))
        //            .ForMember(t => t.Nombre, f => f.MapFrom(c => c.Nombre))
        //            .ForMember(t => t.Celular, f => f.MapFrom(c => c.Celular))
        //            .ForMember(t => t.Telefono, f => f.MapFrom(c => c.Telefono));

        //        BECliente entidad = Mapper.Map<ClienteModel, BECliente>(model);

        //        using (ClienteServiceClient sv = new ClienteServiceClient())
        //        {
        //            vValidation = sv.CheckClienteByConsultora(userData.PaisID, userData.ConsultoraID, model.Nombre);

        //            if (vValidation == 0)
        //            {
        //                entidad.PaisID = userData.PaisID;
        //                entidad.ConsultoraID = userData.ConsultoraID;
        //                entidad.Activo = true;
        //                sv.Insert(entidad);

        //                Session[Constantes.ConstSession.ClientesByConsultora] = sv.SelectByConsultora(userData.PaisID, userData.ConsultoraID).ToList();
        //            }
        //            else
        //            {
        //                return Json(new
        //                {
        //                    success = false,
        //                    message = "El nombre del cliente ya se encuentra registrado, verifique.",
        //                    extra = ""
        //                });
        //            }
        //        }
        //        return Json(new
        //        {
        //            success = true,
        //            message = "Se registró con éxito tu cliente.",
        //            extra = ""
        //        });
        //    }
        //    catch (FaultException ex)
        //    {
        //        LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
        //        return Json(new
        //        {
        //            success = false,
        //            message = ex.Message,
        //            extra = ""
        //        });
        //    }
        //    catch (Exception ex)
        //    {
        //        LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
        //        return Json(new
        //        {
        //            success = false,
        //            message = ex.Message,
        //            extra = ""
        //        });
        //    }
        //}

        public ActionResult Consultar(string sidx, string sord, int page, int rows, string vBusqueda)
        {
            if (ModelState.IsValid)
            {
                List<BECliente> lst;
                using (ClienteServiceClient sv = new ClienteServiceClient())
                {
                    lst = sv.SelectByConsultora(userData.PaisID, userData.ConsultoraID).ToList();
                }

                // Usamos el modelo para obtener los datos
                BEGrid grid = new BEGrid();
                grid.PageSize = rows;
                grid.CurrentPage = page;
                grid.SortColumn = sidx;
                grid.SortOrder = sord;
                //int buscar = int.Parse(txtBuscar);
                BEPager pag = new BEPager();
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
                    items = items.ToList().Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);
                else
                    items = items.Where(p => p.Nombre.ToUpper().Contains(vBusqueda.ToUpper())).ToList().Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);

                pag = Paginador(grid, vBusqueda);

                // Creamos la estructura
                var data = new
                {
                    //total = pag.PageCount,
                    //page = pag.CurrentPage,
                    //records = pag.RecordCount,

                    /* SB20-322 - INCIO */
                    Registros = grid.PageSize.ToString(),
                    RegistrosTotal = pag.RecordCount.ToString(),
                    Pagina = pag.CurrentPage.ToString(),
                    PaginaDe = pag.PageCount.ToString(),

                    rows = items
                    /* SB20-322 - FIN */

                    //rows = from a in items
                    //       select new
                    //       {
                    //           id = a.ClienteID,
                    //           cell = new string[] 
                    //           {
                    //               a.ClienteID.ToString(),
                    //               a.Nombre,
                    //               a.eMail,
                    //               Convert.ToString(Convert.ToInt32(a.Activo)),
                    //               a.ConsultoraID.ToString()
                    //            }
                    //       }
                };
                return Json(data, JsonRequestBehavior.AllowGet);
            }
            return RedirectToAction("Index", "Bienvenida");
        }

        public JsonResult Eliminar(int ClienteID)
        {
            try
            {
                bool rslt = false;
                using (ClienteServiceClient sv = new ClienteServiceClient())
                {
                    rslt = sv.Delete(userData.PaisID, userData.ConsultoraID, ClienteID);
                }
                string Mensaje = string.Empty;
                if (rslt)
                    Mensaje = "Se eliminó satisfactoriamente el registro.";
                else
                    Mensaje = "No es posible eliminar al cliente dado que se encuentra asociado a un pedido.";

                return Json(new
                {
                    success = true,
                    message = Mensaje,
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

            int RecordCount;

            if (string.IsNullOrEmpty(vBusqueda))
                RecordCount = lst.Count;
            else
                RecordCount = lst.Where(p => p.Nombre.ToUpper().Contains(vBusqueda.ToUpper())).ToList().Count();

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
                    lista = lst ?? new List<BECliente>()
                });
            }
            catch (Exception)
            {
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

            Dictionary<string, string> dic = new Dictionary<string, string>();

            dic.Add("Nombres y Apellidos", "msNombre");
            dic.Add("Teléfono Fijo", "msTelefono");
            dic.Add("Celular", "msCelular");
            dic.Add("Correo", "mseMail");

            string[] arrTotal = { "Total a Pagar:", userData.Simbolo + " #Cargo" };

            ExportToExcelMisClientes("MisClientes", lst, dicCabeceras, dic, arrTotal, 0, 100);
            return new EmptyResult();
        }

        private void ExportToExcelMisClientes(string filename, List<BECliente> SourceDetails, List<KeyValuePair<int, string>> columnHeaderDefinition,
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
                            BECliente source = SourceDetails[i];

                            string[] arr = new string[2];
                            if (column.Contains("#"))
                                arr = column.Split('#');
                            else
                                arr = new string[] { "", column };

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
                    index = keyvalue.Key;
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
    }
}
