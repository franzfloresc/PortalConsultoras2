using System.Globalization;//R1957
using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceODS;
using Portal.Consultoras.Web.ServiceSAC;
using Portal.Consultoras.Web.ServiceZonificacion;
using System;
using System.Collections.Generic;
using System.ComponentModel;//R1957
using System.Data;//R1957
using System.IO;
using System.Linq;
using System.Reflection;//R1957
using System.ServiceModel;
using System.Web;
using System.Web.Mvc;
using System.Web.Script.Serialization;//R1957

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
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
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

            if (UserData().CodigoISO == Constantes.CodigosISOPais.Colombia || UserData().CodigoISO == Constantes.CodigosISOPais.Mexico)
                ViewBag.FaltanteUltimoMinuto = 1;
            else
                ViewBag.FaltanteUltimoMinuto = 0;

            ViewBag.PaisID = UserData().PaisID;//R1957
            return View(gestionfaltantemodel);
        }

        //R1957
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
                        //En caso tenga error en maximum message, habilitar el MaxReceivedMessageSize 2147483647.
                        ((BasicHttpBinding)srv.Endpoint.Binding).MaxReceivedMessageSize = int.MaxValue;

                        BEProductoFaltante producto = new BEProductoFaltante()
                        {
                            CampaniaID = campaniaID,
                            Zona = vBusqueda1,
                            CUV = vBusqueda2,
                            Descripcion = vBusqueda3,
                            Fecha = (fecha != null) ? fecha : ""//R1957 – ECM - Se modifico el parámetro en caso no se ingrese fecha
                        };

                        lst = srv.GetProductoFaltanteByEntity(paisID, producto, sidx, sord, page, flagPaginacion, rows).ToList();
                    }

                    int Records = 0, TotalPages = 0;
                    if (lst.Count > 0)
                    {
                        TotalPages = lst[0].TotalPages;
                        Records = lst[0].RowsCount;
                    }
                    var data = new
                    {
                        total = TotalPages,
                        page = page,
                        records = Records,
                        rows = from a in lst
                               select new
                               {
                                   id = a.rowID,
                                   cell = new string[] 
                                   {
                                       a.ZonaID.ToString(),
                                       a.CampaniaID.ToString(),
                                       a.Codigo, // Se regresa a mostrar el código - 1957
                                       a.CUV,
                                       a.Descripcion,
                                       a.FaltanteUltimoMinuto?"SI":"NO",
                                       a.Fecha.ToString(),
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
            catch (System.ServiceModel.FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Ocurrió un error al cargar los datos de la grilla",
                    extra = ""
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
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
            Mapper.CreateMap<BEZona, ZonaModel>()
                .ForMember(t => t.ZonaID, f => f.MapFrom(c => c.ZonaID))
                .ForMember(t => t.Codigo, f => f.MapFrom(c => c.Codigo))
                .ForMember(t => t.Nombre, f => f.MapFrom(c => c.Nombre))
                .ForMember(t => t.RegionID, f => f.MapFrom(c => c.RegionID));
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
            Mapper.CreateMap<ServiceODS.BEProductoDescripcion, GestionFaltantesModel>()
                .ForMember(t => t.CUV, f => f.MapFrom(c => c.CUV))
                .ForMember(t => t.Descripcion, f => f.MapFrom(c => c.Descripcion));

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
                object jsonData = null;
                string paisISO = UserData().CodigoISO;
                string CodigoUsuario = UserData().CodigoUsuario;
                string messageCodigosNoValidos = string.Empty;
                List<BEProductoFaltante> productosFaltantes = new List<BEProductoFaltante>();

                string[] zonasAValidar = codigos[0].Split(new string[] { "," }, StringSplitOptions.RemoveEmptyEntries);
                zonasAValidar = zonasAValidar.Select(z => z.Trim()).ToArray<string>();

                string[] productosAValidar = codigos[1].Split(new string[] { "," }, StringSplitOptions.RemoveEmptyEntries);
                productosAValidar = productosAValidar.Select(p => p.Trim()).ToArray<string>();

                List<BEZona> zonasValidas = new List<BEZona>();
                List<ServiceODS.BEProductoDescripcion> productosValidos = new List<ServiceODS.BEProductoDescripcion>();

                //Zonas a validar
                if (zonasAValidar.Length != 0)
                {
                    BEZona[] zonas;
                    using (ZonificacionServiceClient srv = new ZonificacionServiceClient())
                    {
                        zonas = srv.SelectAllZonas(paisID);
                    }

                    var zonasNoValidas = from item in zonasAValidar
                                         where !(zonas.Any(z => z.Codigo == item))
                                         select item;

                    if (zonasNoValidas.ToList().Count != 0)
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

                //Productos a validar
                if (productosAValidar.Length != 0)
                {
                    List<string> productosNoValidos = new List<string>();
                    List<ServiceODS.BEProductoDescripcion> productoFaltante;

                    using (ODSServiceClient srv = new ODSServiceClient())
                    {
                        foreach (string cuv in productosAValidar)
                        {
                            productoFaltante = srv.GetProductoComercialByPaisAndCampania(campaniaID, cuv, paisID, 1).ToList();

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
                    //Registro de productos faltantes
                    if (zonasValidas.Count() != 0)
                    {
                        //Por zona-producto
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
                        //Todas las zonas
                        foreach (ServiceODS.BEProductoDescripcion producto in productosValidos)
                        {
                            productosFaltantes.Add(new BEProductoFaltante() { CUV = producto.CUV, Zona = "TODAS" });
                        }
                    }

                    using (SACServiceClient sv = new SACServiceClient())
                    {
                        if (zonasValidas.Count() != 0)
                            sv.InsProductoFaltante(paisID, paisISO, CodigoUsuario, productosFaltantes.ToArray(), faltanteUltimoMin == 1 ? true : false);
                        else
                            sv.InsProductoFaltanteMasivo(paisID, paisISO, CodigoUsuario, campaniaID, productosFaltantes.ToArray(), faltanteUltimoMin == 1 ? true : false);
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
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Hubo un problema con el servicio, intente nuevamente",
                    extra = ""
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Hubo un problema con el servicio, intente nuevamente",
                    extra = ""
                });
            }
        }

        //R1957
        public JsonResult Eliminar2(FaltanteTotal data)
        {

            try
            {

                int rslt = 0;
                using (SACServiceClient SACsrv = new SACServiceClient())
                {
                    List<BEProductoFaltante> Lproducto = new List<BEProductoFaltante>();
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
                            Lproducto.Add(producto);
                        }

                        //R1957 – ECM - cambios en los parámetros
                    }

                    rslt = SACsrv.DelProductoFaltante2(UserData().PaisID, UserData().CodigoISO, UserData().CodigoUsuario, Lproducto.ToArray(), data.Flag, data.Pais, data.Campania, data.Zona, data.CUV, data.EProducto, data.Fecha);
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
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Hubo un problema con el servicio, intente nuevamente",
                    extra = ""
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
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
                bool rslt = false;
                using (SACServiceClient SACsrv = new SACServiceClient())
                {
                    BEProductoFaltante producto = new BEProductoFaltante()
                    {
                        CampaniaID = CampaniaID,
                        CUV = CUV,
                        ZonaID = ZonaID,
                        Zona = Zona,
                        FaltanteUltimoMinuto = FaltanteUM == "SI" ? true : false
                    };

                    rslt = SACsrv.DelProductoFaltante(UserData().PaisID, UserData().CodigoISO, UserData().CodigoUsuario, producto);
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
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Hubo un problema con el servicio, intente nuevamente",
                    extra = ""
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
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
            int paisID = model.PaisID;
            int campaniaID = model.CampaniaID;
            string message = string.Empty;
            try
            {
                // valida que el archivo exista
                if (uplArchivo == null)
                {
                    return message = "El archivo especificado no existe.";
                }

                // valida la extensión del archivo
                if (!Util.isFileExtension(uplArchivo.FileName, Enumeradores.TypeDocExtension.Excel))
                {
                    return message = "El archivo especificado no es un documento de tipo MS-Excel.";
                }


                //Guarda el archivo en una ruta del servidor
                string finalPath = string.Empty, httpPath = string.Empty;
                string fileextension = Path.GetExtension(uplArchivo.FileName);

                if (!fileextension.ToLower().Equals(".xlsx"))
                {
                    return message = "Sólo se permiten archivos MS-Excel versiones 2007-2012.";
                }

                string fileName = Guid.NewGuid().ToString();
                string pathfaltante = Server.MapPath("~/Content/ArchivoFaltante");
                httpPath = Url.Content("~/Content/ArchivoFaltante") + "/" + fileName;
                if (!Directory.Exists(pathfaltante))
                    Directory.CreateDirectory(pathfaltante);
                finalPath = Path.Combine(pathfaltante, fileName + fileextension);
                uplArchivo.SaveAs(finalPath);

                bool IsCorrect = false;
                GestionFaltantesModel prod = new GestionFaltantesModel();
                IList<GestionFaltantesModel> lista = Util.ReadXmlFile(finalPath, prod, false, ref IsCorrect);

                //elimina el documento, una vez que haya sido procesado
                System.IO.File.Delete(finalPath);

                if (IsCorrect && lista != null)
                {
                    Mapper.CreateMap<GestionFaltantesModel, BEProductoFaltante>()
                   .ForMember(t => t.CampaniaID, f => f.MapFrom(c => c.CampaniaID))
                   .ForMember(t => t.CUV, f => f.MapFrom(c => c.CUV))
                   .ForMember(t => t.Zona, f => f.MapFrom(c => c.Zona))
                   .ForMember(t => t.ZonaID, f => f.MapFrom(c => c.ZonaID));

                    var lst = Mapper.Map<IList<GestionFaltantesModel>, IEnumerable<BEProductoFaltante>>(lista);
                    using (SACServiceClient srv = new SACServiceClient())
                    {
                        string s = srv.InsProductoFaltanteMasivo(paisID, UserData().CodigoISO, UserData().CodigoUsuario, campaniaID, lst.ToArray(), model.FaltanteUltimoMinuto);
                    }
                    return message = "Se realizo satisfactoriamente la carga de datos.";
                }
                else
                {
                    return message = "Ocurrió un problema al cargar el documento o tal vez se encuentra vacío.";
                }
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return message = "Verifique el formato del Documento, posiblemente no sea igual al de la Plantilla.";
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return message = "Verifique el formato del Documento, posiblemente no sea igual al de la Plantilla.";
            }
        }

        public JsonResult ObtenterCampaniasPorPais(int PaisID)
        {
            //PaisID = 11;
            IEnumerable<CampaniaModel> lista = DropDownCampanias(PaisID);

            return Json(new
            {
                lista = lista
            }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult DescargaModelo()
        {
            string finalPath = string.Empty, httpPath = string.Empty;

            string fileName = "PlantillaModelFaltante.xlsx";
            string pathfaltante = Server.MapPath("~/Content/ArchivoFaltante");
            httpPath = Url.Content("~/Content/ArchivoFaltante") + "/" + fileName;
            if (!Directory.Exists(pathfaltante))
                Directory.CreateDirectory(pathfaltante);
            finalPath = Path.Combine(pathfaltante, fileName);

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
        public IEnumerable<CampaniaModel> DropDownCampanias(int PaisID)
        {
            List<BECampania> lista;
            using (ZonificacionServiceClient servicezona = new ZonificacionServiceClient())
            {
                //R1957
                if (PaisID == 0)
                {
                    lista = servicezona.SelectCampanias(UserData().PaisID).ToList();
                }
                else
                {
                    lista = servicezona.SelectCampanias(PaisID).ToList();
                }

            }
            lista.Insert(0, new BECampania() { CampaniaID = 0, Codigo = "-- Seleccionar --" });
            Mapper.CreateMap<BECampania, CampaniaModel>()
                .ForMember(x => x.CampaniaID, t => t.MapFrom(c => c.CampaniaID))
                .ForMember(x => x.NombreCorto, t => t.MapFrom(c => c.NombreCorto))
                .ForMember(x => x.Codigo, t => t.MapFrom(c => c.Codigo));

            return Mapper.Map<IList<BECampania>, IEnumerable<CampaniaModel>>(lista);
        }

        private IEnumerable<PaisModel> DropDowListPaises()
        {

            //R1957
            List<BEPais> lst = new List<BEPais>() { 
                                new BEPais() {
                                    PaisID = 0, 
                                    Nombre = "-- Seleccionar --" 
                                }
                  };
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
        #endregion

        // 1957 - Inicio
        public JsonResult EliminarTodos(string CampaniaID, string Zona,string CUV, string Fecha, string Descripcion)
        {

            try
            {

                int rslt = 0;
                using (SACServiceClient SACsrv = new SACServiceClient())
                {
                    rslt = SACsrv.DelProductoFaltanteMasivo(UserData().PaisID, Convert.ToInt32(CampaniaID), Zona, CUV, Fecha, Descripcion);
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
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Hubo un problema con el servicio, intente nuevamente",
                    extra = ""
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Hubo un problema con el servicio, intente nuevamente",
                    extra = ""
                });
            }
        }
        // 1957 - Fin
    }

    //R1957
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

    //R1957
    public class FaltanteAnunciadoDel
    {
        // data = { "lista": objetos, "flag": flag, "pais": pais, "campania": campania, "zona": zona, "cuv": cuv, "e_producto": e_producto, "fecha": fecha };
        public List<FaltanteDetalles> Items { get; set; }
    }

    //R1957
    public class FaltanteDetalles
    {
        public int CampaniaID { get; set; }
        public string CUV { get; set; }
        public int ZonaID { get; set; }
    }
}
