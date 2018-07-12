using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceSAC;
using Portal.Consultoras.Web.ServiceZonificacion;
using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Web.Mvc;
using System.Web;
using System.IO;
using io = System.IO;
using System.Text;
using System.Threading.Tasks;
using System.Xml;
using System.IO.Compression;
using System.Globalization;
using System.Text.RegularExpressions;

namespace Portal.Consultoras.Web.Controllers
{
    public class MatrizCampaniaController : BaseController
    {
        public ActionResult ActualizarMatrizCampania()
        {
            try
            {
                if (!UsuarioModel.HasAcces(ViewBag.Permiso, "MatrizCampania/Actualizarmatrizcampania"))
                    return RedirectToAction("Index", "Bienvenida");
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
            }

            var model = new MatrizCampaniaModel
            {
                listaPaises = ObtenerPaises(),
                DropDownListCampania = ObtenerCampanias(),
                DropDownListCampaniaMasiva = CargarCampaniaMasiva()
            };
            ViewBag.HabilitarRegalo = userData.CodigoISO == Constantes.CodigosISOPais.Chile;

            return View(model);
        }

        public ActionResult ActualizarmatrizcampaniaNew()
        {
            try
            {
                if (!UsuarioModel.HasAcces(ViewBag.Permiso, "MatrizCampania/ActualizarmatrizcampaniaNew"))
                    return RedirectToAction("Index", "Bienvenida");
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
            }
            return View();
        }

        public JsonResult ObtenerDatosMatrizCampania()
        {
            var model = new MatrizCampaniaModel
            {
                listaPaises = ObtenerPaises(),
                DropDownListCampania = ObtenerCampanias(),
                DropDownListCampaniaMasiva = CargarCampaniaMasiva()
            };

            //var jsonString = JsonConvert.SerializeObject(model);

            return Json(model, JsonRequestBehavior.AllowGet);

        }



        private IEnumerable<PaisModel> ObtenerPaises()
        {
            List<BEPais> paises;
            using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
            {
                if (UserData().RolID == Constantes.Rol.Administrador)
                {
                    paises = sv.SelectPaises().ToList();
                }
                else
                {
                    paises = new List<BEPais>
                    {
                        sv.SelectPais(UserData().PaisID)
                    };
                }

            }

            return Mapper.Map<IList<BEPais>, IEnumerable<PaisModel>>(paises);
        }

        private List<BECampania> ObtenerCampanias()
        {
            var campanias = new List<BECampania>();
            campanias.Insert(0, new BECampania { CampaniaID = 0, Codigo = "-- Seleccionar --" });
            return campanias;
        }


        public JsonResult CargarCampania(string paisId)
        {
            var campanias = new List<BECampania>() {
                new BECampania { CampaniaID = 0, Codigo = "-- Seleccionar --" }
            };

            try
            {
                if (!string.IsNullOrEmpty(paisId))
                {
                    using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
                    {
                        campanias.AddRange(sv.SelectCampanias(UserData().PaisID).ToList());
                    }
                }
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
            }

            return Json(new
            {
                DropDownListCampania = campanias
            }, JsonRequestBehavior.AllowGet);
        }

        public List<BECampania> CargarCampaniaMasiva()
        {
            using (ZonificacionServiceClient servicezona = new ZonificacionServiceClient())
            {
                BECampania[] becampania = servicezona.SelectCampanias(11);
                return becampania.ToList();
            }
        }


        public List<MatrizCampaniaModel> ListaCUVs;
        public bool isError = false;


        [HttpPost]
        public JsonResult ConsultarDescripcion(string CUV, string IDCampania, string paisID)
        {
            try
            {
                List<BEProductoDescripcion> productos;
                using (SACServiceClient sv = new SACServiceClient())
                {
                    productos = sv.GetProductoDescripcionByCUVandCampania(Convert.ToInt32(paisID), Convert.ToInt32(IDCampania), CUV).ToList();

                }

                if (!productos.Any())
                {
                    return Json(new
                    {
                        success = false,
                        message = "El CUV ingresado no se encuentra registrado para la campaña seleccionada, verifique.",
                        extra = ""
                    });
                }

                if (productos.Count == 2)
                {
                    var producto = productos.LastOrDefault();
                    if (producto != null && !string.IsNullOrEmpty(producto.RegaloImagenUrl))
                    {
                        string carpetaPais = Globals.UrlMatriz + "/" + UserData().CodigoISO;
                        productos.LastOrDefault().RegaloImagenUrl = ConfigS3.GetUrlFileS3(carpetaPais, producto.RegaloImagenUrl, carpetaPais);


                    }
                }

                return Json(new
                {
                    success = true,
                    lstProducto = productos,
                    message = "",
                    extra = ""
                });
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Ocurrió un problema al intentar acceder al servicio, intente nuevamente.",
                    extra = ""
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Ocurrió un problema al intentar acceder al servicio, intente nuevamente.",
                    extra = ""
                });
            }
        }

        [HttpPost]
        public JsonResult InsertarProductoDescripcion(MatrizCampaniaModel model)
        {
            try
            {
                ServiceSAC.BEProductoDescripcion entidad = Mapper.Map<MatrizCampaniaModel, ServiceSAC.BEProductoDescripcion>(model);

                using (SACServiceClient sv = new SACServiceClient())
                {
                    sv.UpdProductoDescripcion(entidad, UserData().CodigoUsuario);
                }
                return Json(new
                {
                    success = true,
                    message = "El producto se actualizó satisfactoriamente.",
                    extra = ""
                });
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Ocurrió un problema al intentar acceder al servicio, intente nuevamente.",
                    extra = ""
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Ocurrió un problema al intentar acceder al servicio, intente nuevamente.",
                    extra = ""
                });
            }
        }


        [HttpPost]
        public List<MatrizCampaniaModel> ConsultarDescripcionMasivo(List<MatrizCampaniaModel> productos, string IDCampania, string paisID, ref bool isError)
        {
            try
            {
                int cant = 0;
                List<BEProductoDescripcion> productos2;
                //JsonResult result = new JsonResult();

                foreach (var producto in productos)
                {
                    cant = cant + 1;
                    producto.ErrorCargaMasiva = "Sin error.";
                    if (producto.Descripcion == null || producto.Descripcion == "")
                    {
                        isError = true;
                        producto.ErrorCargaMasiva = "Debe ingresar la nueva descripción del producto.";
                    }
                    if (producto.PrecioProducto == 0)
                    {
                        isError = true;
                        producto.ErrorCargaMasiva = "Debe ingresar el nuevo precio del producto.";
                    }
                    if (producto.FactorRepeticion == 0)
                    {
                        isError = true;
                        producto.ErrorCargaMasiva = "Debe ingresar el nuevo factor de repetición del producto.";
                    }

                    using (SACServiceClient sv = new SACServiceClient())
                    {
                        productos2 = sv.GetProductoDescripcionByCUVandCampania(Convert.ToInt32(paisID), Convert.ToInt32(IDCampania), producto.CUV).ToList();

                    }

                    if (!productos2.Any())
                    {
                        isError = true;
                        producto.ErrorCargaMasiva = "El CUV ingresado no se encuentra registrado para la campaña seleccionada, verifique.";
                    }

                };
                if (!isError)
                {
                    ViewBag.succesRow = cant;
                }
                else
                {
                    ViewBag.succesRow = 0;

                }

            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);

            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
            }

            return productos;

        }

        [HttpPost]
        public string ProcesarMasivo(HttpPostedFileBase uplArchivo, MatrizCampaniaModel model)
        {
            int paisId = model.PaisID;
            int campaniaId = Convert.ToInt32(model.CampaniaID);
            try
            {
                //List<MatrizCampaniaModel> listaErrores = Session["errores"] as List<MatrizCampaniaModel> ?? new List<MatrizCampaniaModel>();
                if (uplArchivo == null)
                {
                    return "El archivo especificado no existe.";

                }

                if (!Util.IsFileExtension(uplArchivo.FileName, Enumeradores.TypeDocExtension.Excel))
                {
                    return "El archivo especificado no es un documento de tipo MS-Excel.";

                }

                string fileextension = Path.GetExtension(uplArchivo.FileName) ?? "";

                if (!fileextension.ToLower().Equals(".xlsx"))
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
                MatrizCampaniaModel prod = new MatrizCampaniaModel();
                IList<MatrizCampaniaModel> lista = Util.ReadXmlFile(finalPath, prod, false, ref isCorrect);

                System.IO.File.Delete(finalPath);

                ListaCUVs = lista.ToList();

                ListaCUVs = ConsultarDescripcionMasivo(lista.ToList(), campaniaId.ToString(), paisId.ToString(), ref isError);
                Session["errores"] = ListaCUVs;
                if (isCorrect && lista != null && !isError)
                {
                    var lst = Mapper.Map<IList<MatrizCampaniaModel>, IEnumerable<BEProductoDescripcion>>(lista);

                    using (SACServiceClient srv = new SACServiceClient())
                    {
                        srv.UpdProductoDescripcionMasivo(paisId, campaniaId, lst.ToArray(), UserData().CodigoUsuario);
                    }
                    return "Se realizó satisfactoriamente la carga de datos.";
                }
                else
                {
                    return "Ocurrió un problema al cargar el documento, posiblemente tenga errores en su contenido..";
                }

            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return "Verifique el formato del Documento, posiblemente no sea igual al de la Plantilla.";
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return "Verifique el contenido del Documento, posiblemente tenga errores en su contenido.";
            }
        }


        [HttpGet]
        public JsonResult ConsultarErrores(string sidx, string sord, int page, int rows, int vpaisID, int vCampaniaID)
        {
            if (ModelState.IsValid)
            {
                List<MatrizCampaniaModel> listaEntradas;

                listaEntradas = (Session["errores"] as List<MatrizCampaniaModel> ?? new List<MatrizCampaniaModel>()).ToList();

                BEGrid grid = new BEGrid
                {
                    PageSize = rows,
                    CurrentPage = page,
                    SortColumn = sidx,
                    SortOrder = sord
                };

                IEnumerable<MatrizCampaniaModel> items = listaEntradas;

                items = items.Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);

                BEPager pag = Util.PaginadorGenerico(grid, listaEntradas);

                var data = new
                {
                    total = pag.PageCount,
                    page = pag.CurrentPage,
                    records = pag.RecordCount,
                    ISOPais = Util.GetPaisISO(vpaisID),
                    rows = from a in items
                           select new
                           {
                               id = a.CUV.ToString(),
                               cell = new string[]
                               {
                                   vpaisID.ToString(),
                                   vCampaniaID.ToString(),
                                   a.CUV.ToString(),
                                   a.Descripcion.ToString(),
                                   a.ErrorCargaMasiva.ToString()
                                }
                           }
                };
                return Json(data, JsonRequestBehavior.AllowGet);
            }
            return Json(new { success = false, message = "Ocurrió un error al ejecutar la operación. " }, JsonRequestBehavior.AllowGet);
        }


        [HttpPost]
        public async Task<string> leerArchivoExcel(string pais, string AnioCampania)
        {
            string rpta = "";
            HttpPostedFileBase file = Request.Files[0];
            io.Stream flujo = file.InputStream;

            try
            {
                await Task.Run(() =>
                {
                    string contenido = "";
                    //StringBuilder sb = new StringBuilder();
                    //string contenidoFila = "";
                    int nRegistros = 0;
                    List<string> hojas = new List<string>();
                    List<XmlDocument> docs = new List<XmlDocument>();
                    List<string> nombres = new List<string>();
                    List<string> valores = new List<string>();
                    List<string> columnas = new List<string>();

                    //Descomprimir el archivo Excel y guardar solo los archivos xml necesarios
                    //en una Lista de objetos de tipo XmlDocument
                    using (var zip = new ZipArchive(flujo, ZipArchiveMode.Read))
                    {
                        XmlDocument doc;
                        foreach (var archivoXml in zip.Entries)
                        {
                            if (archivoXml.Name == "workbook.xml" || archivoXml.Name == "sharedStrings.xml" || archivoXml.Name.StartsWith("sheet") && Path.GetExtension(archivoXml.Name) == ".xml")
                            {
                                using (Stream stream = archivoXml.Open())
                                {
                                    doc = new XmlDocument();
                                    doc.Load(stream);
                                    docs.Add(doc);
                                    nombres.Add(archivoXml.Name);
                                }
                            }
                        }
                    }

                    if (docs.Count > 0)
                    {
                        //Leer el archivo xml donde se guardan los datos de tipo cadena
                        int pos = nombres.IndexOf("sharedStrings.xml");
                        if (pos > -1)
                        {
                            XmlDocument xdStrings = docs[pos];
                            XmlElement nodoRaizStrings = xdStrings.DocumentElement;
                            XmlNodeList nodosValores = nodoRaizStrings.ChildNodes;
                            if (nodosValores != null)
                            {
                                foreach (XmlNode nodoValor in nodosValores)
                                {
                                    valores.Add(nodoValor.FirstChild.FirstChild.Value);
                                }
                            }
                        }

                        pos = nombres.IndexOf("workbook.xml");
                        if (pos > -1)
                        {
                            XmlDocument xdLibro = docs[pos];
                            XmlElement nodoRaizHojas = xdLibro.DocumentElement;
                            XmlNodeList nodosHojas = nodoRaizHojas.GetElementsByTagName("sheet");
                            string id;
                            string hoja;

                            if (nodosHojas != null)
                            {
                                contenido = "";
                                int ch = 0;
                                foreach (XmlNode nodoHoja in nodosHojas)
                                {
                                    id = nodoHoja.Attributes["r:id"].Value.Replace("rId", "");
                                    hoja = nodoHoja.Attributes["name"].Value;
                                    //Leer cada archivo xml con la hoja
                                    pos = nombres.IndexOf("sheet" + id + ".xml");
                                    if (pos > -1)
                                    {
                                        XmlDocument xdHoja = docs[pos];
                                        XmlElement nodoRaizHoja = xdHoja.DocumentElement;
                                        XmlNodeList nodosFilas = nodoRaizHoja.GetElementsByTagName("row");

                                        int indice;
                                        string celda, valor;
                                        XmlAttribute tipoString;
                                        contenido = "";
                                        int cf = 0; //contador de filas
                                        int cc = 0; //contador de columnas
                                        XmlNode nodoCelda = null;
                                        if (nodosFilas != null)
                                        {
                                            foreach (XmlNode nodoFila in nodosFilas)
                                            {
                                                XmlNodeList nodoCeldas = nodoFila.ChildNodes;

                                                if (nodoCeldas != null)
                                                {
                                                    if (cf == 0)
                                                    {
                                                        columnas = new List<string>();
                                                        nRegistros = nodoCeldas.Count;
                                                        for (int i = 0; i < nRegistros; i++)
                                                        {
                                                            columnas.Add(nodoCeldas[i].Attributes["r"].Value.Replace(nodoFila.Attributes["r"].Value, ""));
                                                        }
                                                    }
                                                    else
                                                    {
                                                        cc = 0;
                                                        //contenidoFila = "";
                                                        nRegistros = columnas.Count;

                                                        var contenidoFilaBuild = new StringBuilder();

                                                        for (int i = 0; i < nRegistros; i++)
                                                        {
                                                            valor = "";
                                                            nodoCelda = nodoCeldas[cc];
                                                            //if (cc > 0) contenidoFila += "¦";
                                                            if (cc > 0) contenidoFilaBuild.Append("¦");

                                                            if (nodoCelda == null)
                                                            {
                                                                continue;
                                                            }

                                                            //if (nodoCelda != null)
                                                            //{
                                                            if (columnas[i] == nodoCelda.Attributes["r"].Value.Replace(nodoFila.Attributes["r"].Value, ""))
                                                            {
                                                                celda = nodoCelda.Attributes["r"].Value;
                                                                tipoString = nodoCelda.Attributes["t"];
                                                                valor = "";
                                                                if (tipoString != null)
                                                                {
                                                                    if (valores != null && valores.Count > 0)
                                                                    {
                                                                        indice = int.Parse(nodoCelda.FirstChild.FirstChild.Value);
                                                                        valor = valores[indice];
                                                                        //contenidoFila += valor;
                                                                        contenidoFilaBuild.Append(valor);
                                                                    }
                                                                }
                                                                else
                                                                {
                                                                    if (nodoCelda.FirstChild != null && nodoCelda.FirstChild.FirstChild != null)
                                                                    {
                                                                        valor = nodoCelda.FirstChild.FirstChild.Value;
                                                                        //contenidoFila += valor;
                                                                        contenidoFilaBuild.Append(valor);
                                                                    }
                                                                }
                                                                cc++;
                                                            }
                                                            //}
                                                        }


                                                        if (cf < nodosFilas.Count - 1)
                                                        {
                                                            //contenidoFila += "¬";
                                                            contenidoFilaBuild.Append("¬");
                                                        }
                                                        contenido += contenidoFilaBuild.ToString();
                                                    }
                                                }
                                                cf++;
                                            }
                                        }
                                        hojas.Add(contenido);
                                        //sb.AppendLine(contenido);
                                    }
                                    ch++;
                                    break;
                                }
                            }

                        }
                    }

                    rpta = validarExcel(pais, hojas[0].ToString(), AnioCampania);

                });
            }
            catch (Exception)
            {
                rpta = "-1";
            }

            return rpta;
        }

        public static string validarExcel(string pais, string data, string AnioCampania)
        {
            StringBuilder rpta = new StringBuilder();
            StringBuilder CampoValidos = new StringBuilder();
            StringBuilder CamposNovalidos = new StringBuilder();

            var campo = "";
            uint numero = 0;
            decimal numerodecimal;
            bool resultado;

            var CUV = "";

            string[] registros = data.Split('¬');
            bool FlagCampoValido = true;
            var longCUV = 0;
            var longDes = 0;
            var longPrecioProducto = 0;
            var longFactorRepeticion = 0;
            var cantFilas = registros.Length;
            for (int j = 0; j < cantFilas; j++)
            {

                //if (registros[j].Split('¦').Length<=3)
                //{
                //    continue;
                //}

                if (registros[j].Split('¦').Length > 0)
                {
                    campo = registros[j].Split('¦')[0];
                    CUV += registros[j].Split('¦')[0] + '¬';
                    //CUV += '¬';
                    resultado = uint.TryParse(campo, out numero);
                    longCUV = campo.Trim().Length;
                    if (!resultado || campo.Trim().Length != 5)
                    {
                        FlagCampoValido = false;
                        rpta.Append(" CUV no válido  ");
                    }

                }

                if (registros[j].Split('¦').Length > 1)
                {
                    campo = registros[j].Split('¦')[1];
                    longDes = campo.Trim().Length;
                    if (campo.Length > 100 || longDes == 0)
                    {
                        FlagCampoValido = false;
                        rpta.Append(" -Longitud  de descripción de Producto no válido(1-100 caracteres) ");
                    }
                }

                if (registros[j].Split('¦').Length > 2)
                {


                    campo = registros[j].Split('¦')[2];
                    longPrecioProducto = campo.Trim().Length;
                    resultado = decimal.TryParse(campo, out numerodecimal);
                    if (!resultado)
                    {
                        FlagCampoValido = false;
                        rpta.Append("-Precio Producto invalido ");
                    }
                    else
                    {
                        if (decimal.Parse(campo) < 0)
                        {
                            FlagCampoValido = false;
                            rpta.Append("-Precio Producto invalido ");
                        }
                    }

                }


                if (registros[j].Split('¦').Length > 3)
                {

                    campo = registros[j].Split('¦')[3];
                    longFactorRepeticion = campo.Trim().Length;
                    resultado = uint.TryParse(campo, out numero);
                    if (!resultado)
                    {
                        FlagCampoValido = false;
                        rpta.Append(" -Factor Repetición no válido ");
                    }
                    else
                    {
                        if (numero == 0)
                        {
                            FlagCampoValido = false;
                            rpta.Append(" -Factor Repetición no válido ");
                        }
                    }
                }
                if (longCUV == 0 && longDes == 0 && longPrecioProducto == 0 && longFactorRepeticion == 0)
                {
                    FlagCampoValido = true;
                    rpta.Clear();
                    continue;
                }


                if (rpta.Length > 0)
                {
                    CamposNovalidos.Append(registros[j].Split('¦')[0]);
                    CamposNovalidos.Append('¦');
                    CamposNovalidos.Append(registros[j].Split('¦')[1]);
                    CamposNovalidos.Append('¦');
                    CamposNovalidos.Append(registros[j].Split('¦')[2]);
                    CamposNovalidos.Append('¦');
                    CamposNovalidos.Append(registros[j].Split('¦')[3]);
                    CamposNovalidos.Append('¦');
                    CamposNovalidos.Append(rpta.ToString().TrimEnd('-'));
                    CamposNovalidos.Append("¬");
                }

                if (FlagCampoValido)
                {
                    CampoValidos.Append(registros[j].Split('¦')[0]);
                    CampoValidos.Append("¬");
                }

                FlagCampoValido = true;
                rpta.Clear();
            }
            CUV = CUV.TrimEnd('¬');
            var cuvInValidados = "";
            using (SACServiceClient srv = new SACServiceClient())
            {
                cuvInValidados = srv.ValidarMatrizCampaniaMasivo(int.Parse(pais), CUV, int.Parse(AnioCampania));
            }
            var registrosTotales = data + "||" + CampoValidos.ToString().TrimEnd('¬') + "||" + CamposNovalidos.ToString().TrimEnd('¬') + "||" + cuvInValidados;
            return registrosTotales;
        }

        [HttpPost]
        public string ValidartablaInvalidosMasivo(string pais, string data, string AnioCampania)
        {
            var rpta = validarExcel(pais, data, AnioCampania);
            return rpta;
        }


        public string InsertarProductoMasivo(int paisID, string data)
        {

            try
            {

                string result = "";
                using (SACServiceClient srv = new SACServiceClient())
                {
                    result = srv.RegistrarProductoMasivo(paisID, data);
                }

                return result;
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return "Ocurrió un problema al intentar acceder al servicio, intente nuevamente.";
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return "Ocurrió un problema al intentar acceder al servicio, intente nuevamente.";
            }

        }


        //public string grabarBloque()
        //{
        //    string rpta = "";
        //    //long n = Request.InputStream.Length;
        //    long n = long.Parse(Request.InputStream.ToString().Split('~')[0]);
        //    int pais= int.Parse(Request.InputStream.ToString().Split('~')[1]);
        //    if (n > 0)
        //    {
        //        byte[] buffer = new byte[n];
        //        Request.InputStream.Read(buffer, 0, buffer.Length);
        //        string data = Encoding.UTF8.GetString(buffer);
        //        rpta=InsertarProductoMasivo(pais, data);
        //    }
        //    return rpta;
        //}



    }


}
