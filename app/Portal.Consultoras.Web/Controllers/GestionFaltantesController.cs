using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceODS;
using Portal.Consultoras.Web.ServiceSAC;
using Portal.Consultoras.Web.ServiceZonificacion;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.ServiceModel;
using System.Web;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class GestionFaltantesController : BaseController
    {
        #region Action
        public ActionResult GestionFaltantes()
        {
            try
            {
                if (!UsuarioModel.HasAcces(ViewBag.Permiso, "GestionFaltantes/GestionFaltantes"))
                    return RedirectToAction("Index", "Bienvenida");
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
            IEnumerable<CampaniaModel> lstCampania = new List<CampaniaModel>() {
                                new CampaniaModel() {
                                    CampaniaID = 0,
                                    Codigo = "-- Seleccionar --"
                                }
            };
            var gestionfaltantemodel = new GestionFaltantesModel()
            {
                listaCampanias = lstCampania,
                listaPaises = DropDowListPaises()
            };

            if (userData.CodigoISO == Constantes.CodigosISOPais.Colombia || userData.CodigoISO == Constantes.CodigosISOPais.Mexico)
                ViewBag.FaltanteUltimoMinuto = 1;
            else
                ViewBag.FaltanteUltimoMinuto = 0;

            ViewBag.PaisID = userData.PaisID;
            return View(gestionfaltantemodel);
        }

        public ActionResult Consultar(string sidx, string sord, int page, int rows, int paisID, string vBusqueda1,
                                     string vBusqueda2, string vBusqueda3, int campaniaID, String fecha, int flagPaginacion = 1)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    List<BEProductoFaltante> lst;
                    using (SACServiceClient srv = new SACServiceClient())
                    {
                        ((BasicHttpBinding)srv.Endpoint.Binding).MaxReceivedMessageSize = int.MaxValue;

                        BEProductoFaltante producto = new BEProductoFaltante()
                        {
                            CampaniaID = campaniaID,
                            Zona = vBusqueda1,
                            CUV = vBusqueda2,
                            Descripcion = vBusqueda3,
                            Fecha = fecha ?? ""
                        };

                        lst = srv.GetProductoFaltanteByEntity(paisID, producto, sidx, sord, page, flagPaginacion, rows).ToList();
                    }

                    int records = 0, totalPages = 0;
                    if (lst.Count > 0)
                    {
                        totalPages = lst[0].TotalPages;
                        records = lst[0].RowsCount;
                    }
                    var data = new
                    {
                        total = totalPages,
                        page = page,
                        records = records,
                        rows = from a in lst
                               select new
                               {
                                   id = a.rowID,
                                   cell = new string[]
                                   {
                                       a.ZonaID.ToString(),
                                       a.CampaniaID.ToString(),
                                       a.Codigo,
                                       a.CUV,
                                       a.Descripcion,
                                       a.FaltanteUltimoMinuto?"SI":"NO",
                                       a.Fecha,
                                       a.Estado.ToString()
                                   }
                               }
                    };

                    var jsonResult = Json(data, JsonRequestBehavior.AllowGet);
                    jsonResult.MaxJsonLength = int.MaxValue;
                    return jsonResult;

                }
                return RedirectToAction("Index", "Bienvenida");
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Ocurrió un error al cargar los datos de la grilla",
                    extra = ""
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Ocurrió un error al cargar los datos de la grilla",
                    extra = ""
                });
            }
        }

        public JsonResult SelectZonaByCodigo(int paisID, string codigo, int rowCount)
        {
            List<BEZona> lista;
            using (ZonificacionServiceClient srv = new ZonificacionServiceClient())
            {
                lista = srv.SelectZonaByCodigo(paisID, codigo, rowCount).ToList();
            }

            var lstModel = Mapper.Map<IList<BEZona>, IEnumerable<ZonaModel>>(lista);

            return Json(lstModel, JsonRequestBehavior.AllowGet);
        }

        public JsonResult SelectCodigoProducto(int campaniaID, int paisID, string codigo, int rowCount)
        {
            List<ServiceODS.BEProductoDescripcion> lista;
            using (ODSServiceClient srv = new ODSServiceClient())
            {
                lista = srv.GetProductoComercialByPaisAndCampania(campaniaID, codigo, paisID, rowCount).ToList();
            }

            var lstModel = Mapper.Map<IList<ServiceODS.BEProductoDescripcion>, IEnumerable<GestionFaltantesModel>>(lista);

            return Json(lstModel, JsonRequestBehavior.AllowGet);
        }

        public JsonResult Insertar(int paisID, int campaniaID, int faltanteUltimoMin, List<string> codigos)
        {
            try
            {
                object jsonData;
                string paisIso = userData.CodigoISO;
                string codigoUsuario = userData.CodigoUsuario;
                string messageCodigosNoValidos = string.Empty;
                List<BEProductoFaltante> productosFaltantes = new List<BEProductoFaltante>();

                string[] zonasAValidar = codigos[0].Split(new string[] { "," }, StringSplitOptions.RemoveEmptyEntries);
                zonasAValidar = zonasAValidar.Select(z => z.Trim()).ToArray<string>();

                string[] productosAValidar = codigos[1].Split(new string[] { "," }, StringSplitOptions.RemoveEmptyEntries);
                productosAValidar = productosAValidar.Select(p => p.Trim()).ToArray<string>();

                List<BEZona> zonasValidas = new List<BEZona>();
                List<ServiceODS.BEProductoDescripcion> productosValidos = new List<ServiceODS.BEProductoDescripcion>();

                if (zonasAValidar.Length != 0)
                {
                    BEZona[] zonas;
                    using (ZonificacionServiceClient srv = new ZonificacionServiceClient())
                    {
                        zonas = srv.SelectAllZonas(paisID);
                    }

                    var zonasNoValidas = (from item in zonasAValidar
                                          where !(zonas.Any(z => z.Codigo == item))
                                          select item).ToList();

                    if (zonasNoValidas.Count != 0)
                    {
                        messageCodigosNoValidos = "Las siguientes zonas no son válidas: " +
                                                  string.Join(",", zonasNoValidas.Select(zona => zona));
                    }
                    else
                    {
                        zonasValidas = (from item in zonas
                                        where zonasAValidar.Any(z => z == item.Codigo)
                                        select item).ToList();
                    }
                }

                if (productosAValidar.Length != 0)
                {
                    List<string> productosNoValidos = new List<string>();

                    using (ODSServiceClient srv = new ODSServiceClient())
                    {
                        foreach (string cuv in productosAValidar)
                        {
                            var productoFaltante = srv.GetProductoComercialByPaisAndCampania(campaniaID, cuv, paisID, 1).ToList();

                            if (productoFaltante.Count == 0 || productoFaltante[0].CUV != cuv)
                            {
                                productosNoValidos.Add(cuv);
                            }
                            else
                            {
                                productosValidos.Add(productoFaltante[0]);
                            }
                        }
                    }

                    if (productosNoValidos.Count != 0)
                    {
                        messageCodigosNoValidos = (messageCodigosNoValidos != string.Empty ? messageCodigosNoValidos + "\r\n" : "") +
                                                  "Los siguientes códigos de venta no son válidos: " +
                                                  string.Join(",", productosNoValidos.Select(z => z));
                    }
                }

                if (messageCodigosNoValidos != string.Empty)
                {
                    jsonData = new
                    {
                        success = false,
                        message = messageCodigosNoValidos,
                        extra = ""
                    };
                }
                else
                {
                    if (zonasValidas.Any())
                    {
                        foreach (BEZona zona in zonasValidas)
                        {
                            foreach (ServiceODS.BEProductoDescripcion producto in productosValidos)
                            {
                                productosFaltantes.Add(new BEProductoFaltante() { CampaniaID = campaniaID, CUV = producto.CUV, ZonaID = zona.ZonaID, Codigo = zona.Codigo, Zona = zona.Codigo });
                            }
                        }
                    }
                    else
                    {
                        foreach (ServiceODS.BEProductoDescripcion producto in productosValidos)
                        {
                            productosFaltantes.Add(new BEProductoFaltante() { CUV = producto.CUV, Zona = "TODAS" });
                        }
                    }

                    using (SACServiceClient sv = new SACServiceClient())
                    {
                        if (zonasValidas.Any())
                            sv.InsProductoFaltante(paisID, paisIso, codigoUsuario, productosFaltantes.ToArray(), faltanteUltimoMin == 1);
                        else
                            sv.InsProductoFaltanteMasivo(paisID, paisIso, codigoUsuario, campaniaID, productosFaltantes.ToArray(), faltanteUltimoMin == 1);
                    }

                    jsonData = new
                    {
                        success = true,
                        message = "Los registros han sido ingresados satisfactoriamente.",
                        extra = ""
                    };
                }

                return Json(jsonData);
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Hubo un problema con el servicio, intente nuevamente",
                    extra = ""
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Hubo un problema con el servicio, intente nuevamente",
                    extra = ""
                });
            }
        }

        public JsonResult Eliminar2(FaltanteTotal data)
        {

            try
            {

                int rslt;
                using (SACServiceClient saCsrv = new SACServiceClient())
                {
                    List<BEProductoFaltante> lproducto = new List<BEProductoFaltante>();
                    if (data.Lista != null)
                    {

                        for (int i = 0; i < data.Lista.Items.Count; i++)
                        {
                            BEProductoFaltante producto = new BEProductoFaltante()
                            {
                                CampaniaID = data.Lista.Items[i].CampaniaID,
                                CUV = data.Lista.Items[i].CUV,
                                ZonaID = data.Lista.Items[i].ZonaID,
                                FaltanteUltimoMinuto = false,
                            };
                            lproducto.Add(producto);
                        }
                    }

                    rslt = saCsrv.DelProductoFaltante2(userData.PaisID, userData.CodigoISO, userData.CodigoUsuario, lproducto.ToArray(), data.Flag, data.Pais, data.Campania, data.Zona, data.CUV, data.EProducto, data.Fecha);
                }
                if (rslt > 0)
                {
                    return Json(new
                    {
                        success = true,
                        message = rslt != 1 ? "Se elimino satisfactoriamente " + rslt + " registros" : "Se elimino satisfactoriamente " + rslt + " registro",
                        extra = rslt
                    });
                }
                else
                {
                    if (rslt == 0)
                    {
                        return Json(new
                        {
                            success = false,
                            message = "No se encontraron Registros para eliminar asegurese de que ZonaID,CUV,CampaniaID esten conforme",
                            extra = ""
                        });
                    }
                    else
                    {
                        return Json(new
                        {
                            success = false,
                            message = "No existe ningun Faltantes Anunciados en ProductoFaltante asegurese de que todos los campos de las tablas estan bien ingresados  ",
                            extra = ""
                        });
                    }

                }


            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Hubo un problema con el servicio, intente nuevamente",
                    extra = ""
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Hubo un problema con el servicio, intente nuevamente",
                    extra = ""
                });
            }
        }

        public JsonResult Eliminar(int CampaniaID, string CUV, int ZonaID, string Zona, string FaltanteUM)
        {
            try
            {
                BEProductoFaltante producto = new BEProductoFaltante()
                {
                    CampaniaID = CampaniaID,
                    CUV = CUV,
                    ZonaID = ZonaID,
                    Zona = Zona,
                    FaltanteUltimoMinuto = FaltanteUM == "SI"
                };

                using (SACServiceClient saCsrv = new SACServiceClient())
                {
                    saCsrv.DelProductoFaltante(userData.PaisID, userData.CodigoISO, userData.CodigoUsuario, producto);
                }
                return Json(new
                {
                    success = true,
                    message = "Se elimino satisfactoriamente el registro",
                    extra = ""
                });

            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Hubo un problema con el servicio, intente nuevamente",
                    extra = ""
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Hubo un problema con el servicio, intente nuevamente",
                    extra = ""
                });
            }
        }

        [HttpPost]
        public string ProcesarMasivo(HttpPostedFileBase uplArchivo, GestionFaltantesModel model)
        {
            int paisId = model.PaisID;
            int campaniaId = model.CampaniaID;
            try
            {
                if (uplArchivo == null)
                {
                    return "El archivo especificado no existe.";
                }

                if (!Util.IsFileExtension(uplArchivo.FileName, Enumeradores.TypeDocExtension.Excel))
                {
                    return "El archivo especificado no es un documento de tipo MS-Excel.";
                }

                string fileextension = Path.GetExtension(uplArchivo.FileName);

                if (fileextension != null && !fileextension.ToLower().Equals(".xlsx"))
                {
                    return "Sólo se permiten archivos MS-Excel versiones 2007-2012.";
                }

                string fileName = Guid.NewGuid().ToString();
                string pathfaltante = Server.MapPath("~/Content/ArchivoFaltante");

                if (!Directory.Exists(pathfaltante))
                    Directory.CreateDirectory(pathfaltante);
                var finalPath = Path.Combine(pathfaltante, fileName + fileextension);
                uplArchivo.SaveAs(finalPath);

                bool isCorrect = false;
                GestionFaltantesModel prod = new GestionFaltantesModel();
                IList<GestionFaltantesModel> lista = Util.ReadXmlFile(finalPath, prod, false, ref isCorrect);

                System.IO.File.Delete(finalPath);

                if (isCorrect && lista != null)
                {
                    var lst = Mapper.Map<IList<GestionFaltantesModel>, IEnumerable<BEProductoFaltante>>(lista);
                    using (SACServiceClient srv = new SACServiceClient())
                    {
                        srv.InsProductoFaltanteMasivo(paisId, userData.CodigoISO, userData.CodigoUsuario, campaniaId, lst.ToArray(), model.FaltanteUltimoMinuto);
                    }
                    return "Se realizo satisfactoriamente la carga de datos.";
                }

                return "Ocurrió un problema al cargar el documento o tal vez se encuentra vacío.";
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
                return "Verifique el formato del Documento, posiblemente no sea igual al de la Plantilla.";
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return "Verifique el formato del Documento, posiblemente no sea igual al de la Plantilla.";
            }
        }

        public JsonResult ObtenterCampaniasPorPais(int PaisID)
        {
            IEnumerable<CampaniaModel> lista = DropDownCampanias(PaisID);

            return Json(new
            {
                lista = lista
            }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult DescargaModelo()
        {
            string fileName = "PlantillaModelFaltante.xlsx";
            string pathfaltante = Server.MapPath("~/Content/ArchivoFaltante");

            if (!Directory.Exists(pathfaltante))
                Directory.CreateDirectory(pathfaltante);
            var finalPath = Path.Combine(pathfaltante, fileName);

            HttpContext.Response.Clear();
            HttpContext.Response.Buffer = false;
            HttpContext.Response.AddHeader("Content-disposition", "attachment; filename=" + fileName);
            HttpContext.Response.Charset = "UTF-8";
            HttpContext.Response.Cache.SetCacheability(HttpCacheability.NoCache);
            HttpContext.Response.ContentType = "application/octet-stream";
            HttpContext.Response.TransmitFile(finalPath);
            HttpContext.Response.Flush();
            HttpContext.Response.End();

            return View();
        }
        #endregion

        #region Metodos
        public IEnumerable<CampaniaModel> DropDownCampanias(int paisId)
        {
            List<BECampania> lista;
            using (ZonificacionServiceClient servicezona = new ZonificacionServiceClient())
            {
                lista = paisId == 0
                    ? servicezona.SelectCampanias(userData.PaisID).ToList()
                    : servicezona.SelectCampanias(paisId).ToList();
            }
            lista.Insert(0, new BECampania() { CampaniaID = 0, Codigo = "-- Seleccionar --" });

            return Mapper.Map<IList<BECampania>, IEnumerable<CampaniaModel>>(lista);
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
        #endregion

        public JsonResult EliminarTodos(string CampaniaID, string Zona, string CUV, string Fecha, string Descripcion)
        {

            try
            {

                int rslt;
                using (SACServiceClient saCsrv = new SACServiceClient())
                {
                    rslt = saCsrv.DelProductoFaltanteMasivo(userData.PaisID, Convert.ToInt32(CampaniaID), Zona, CUV, Fecha, Descripcion);
                }
                if (rslt > 0)
                {
                    return Json(new
                    {
                        success = true,
                        message = rslt != 1 ? "Se elimino satisfactoriamente " + rslt + " registros" : "Se elimino satisfactoriamente " + rslt + " registro",
                        extra = rslt
                    });
                }
                else
                {
                    if (rslt == 0)
                    {
                        return Json(new
                        {
                            success = false,
                            message = "No se encontraron Registros para eliminar asegurese de que ZonaID,CUV,CampaniaID esten conforme",
                            extra = ""
                        });
                    }
                    else
                    {
                        return Json(new
                        {
                            success = false,
                            message = "No existe ningun Faltantes Anunciados en ProductoFaltante asegurese de que todos los campos de las tablas estan bien ingresados  ",
                            extra = ""
                        });
                    }

                }


            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Hubo un problema con el servicio, intente nuevamente",
                    extra = ""
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Hubo un problema con el servicio, intente nuevamente",
                    extra = ""
                });
            }
        }
    }

    public class FaltanteTotal
    {
        public FaltanteAnunciadoDel Lista { get; set; }
        public int Flag { get; set; }
        public int Pais { get; set; }
        public int Campania { get; set; }
        public int Zona { get; set; }
        public string CUV { get; set; }
        public string EProducto { get; set; }
        public DateTime Fecha { get; set; }

    }

    public class FaltanteAnunciadoDel
    {
        public List<FaltanteDetalles> Items { get; set; }
    }

    public class FaltanteDetalles
    {
        public int CampaniaID { get; set; }
        public string CUV { get; set; }
        public int ZonaID { get; set; }
    }
}
