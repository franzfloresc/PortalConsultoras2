using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.GestionPasos;
using Portal.Consultoras.Web.HojaInscripcionBelcorpPais;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceUnete;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Configuration;
using System.Data;
using System.Data.OleDb;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Reflection;
using System.ServiceModel;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Mvc;
using ConsultoraBE = Portal.Consultoras.Web.HojaInscripcionBelcorpPais.ConsultoraBE;
using Pais = Portal.Consultoras.Common.Constantes.CodigosISOPais;

namespace Portal.Consultoras.Web.Controllers
{
    public class UneteController : BaseControllerUnete
    {
        public string CodigoISO
        {
            get { return UserData().CodigoISO; }
        }

        public ActionResult InscribePostulante()
        {
            var user = UserData();

            if (user != null)
            {
                ViewData["CadenaEncriptada"] =
                    new Crypto().EncryptToString(user.CodigoISO + "|Portal Consultoras|" + user.NombreConsultora +
                                                 "| ");
            }

            return View();
        }

        [HttpPost]
        public JsonResult ConsultarSolicitudesPostulantesSinValidacionTelefonica(ValidacionTelefonicaModel model)
        {
            IEnumerable<SolicitudPostulanteBE> solicitudes;

            var grid = new BEGrid
            {
                PageSize = model.rows,
                CurrentPage = model.page,
                SortColumn = model.sidx,
                SortOrder = model.sord.ToUpper()
            };

            DateTime? fechaDesde = string.IsNullOrWhiteSpace(model.FechaDesde)
                ? default(DateTime?)
                : DateTime.ParseExact(model.FechaDesde, "dd/MM/yyyy", CultureInfo.InvariantCulture);
            DateTime? fechaHasta = string.IsNullOrWhiteSpace(model.FechaHasta)
                ? default(DateTime?)
                : DateTime.ParseExact(model.FechaHasta, "dd/MM/yyyy", CultureInfo.InvariantCulture);

            using (var sv = new PortalServiceClient())
            {
                solicitudes = sv.ObtenerSolicitudesPostulanteV2(new SolicitudPostulanteParameter
                {
                    CodigoIso = CodigoISO,
                    FechaDesde = fechaDesde,
                    FechaHasta = fechaHasta,
                    CodigoZona = model.CodigoZona,
                    EstadoPostulante = EnumsEstadoPostulante.EnGestionServicioAlCliente,
                    EstadoGeo = EnumsEstadoGEO.OK,
                    DocumentoIdentidad = model.DocumentoIdentidad,
                    Aplicacion = EnumsAplicacion.HerramientaGestionSAC,
                    TipoEstadoTelefonico = EnumsTipoEstadoTelefonico.SinAsignar
                });
            }

            var pag = Paginador(grid, solicitudes.ToList());

            solicitudes = BaseUtilities.OrdenarLista(solicitudes, grid.SortColumn, grid.SortOrder);
            solicitudes = solicitudes.Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);

            var solicitudPostulanteBes = solicitudes as IList<SolicitudPostulanteBE> ?? solicitudes.ToList();

            var data = new
            {
                total = pag.PageCount,
                page = pag.CurrentPage,
                records = pag.RecordCount,
                rows = solicitudPostulanteBes.Select(i =>
                {

                    string concat = i.LugarPadre.ToUpper() + ", " + i.LugarHijo.ToUpper() + ", " + i.Direccion.Replace("|", " ").ToUpper();

                    return new
                    {
                        cell = new[] {
                            i.SolicitudPostulanteID.ToString(),
                            i.FechaCreacion.ToString(),
                            string.IsNullOrWhiteSpace(i.PrimerNombre) ? string.Empty : i.PrimerNombre.ToUpper(),
                            string.IsNullOrWhiteSpace(i.ApellidoPaterno) ? string.Empty : i.ApellidoPaterno.ToUpper(),
                            string.IsNullOrWhiteSpace(i.ApellidoMaterno) ? string.Empty : i.ApellidoMaterno.ToUpper(),
                            string.IsNullOrWhiteSpace(i.CodigoZona) ? string.Empty : i.CodigoZona.ToUpper(),
                            string.IsNullOrWhiteSpace(i.Direccion) ? string.Empty : concat,
                            string.IsNullOrWhiteSpace(i.NumeroDocumento) ? string.Empty : i.NumeroDocumento.ToUpper(),
                            string.IsNullOrWhiteSpace(i.TelefonoFijo) ? string.Empty : i.TelefonoFijo.ToUpper(),
                            string.IsNullOrWhiteSpace(i.TelefonoCelular) ? string.Empty : i.TelefonoCelular.ToUpper(),
                        }
                    };
                })
            };

            return Json(data, JsonRequestBehavior.AllowGet);
        }

        public JsonResult ConsultarParametrosConfigurables(PaginacionModel model)
        {
            var grid = new BEGrid
            {
                PageSize = model.rows,
                CurrentPage = model.page,
                SortColumn = model.sidx,
                SortOrder = model.sord.ToUpper()
            };

            using (var sv = new BelcorpPaisServiceClient())
            {
                IEnumerable<HojaInscripcionBelcorpPais.ParametroUneteBE> paremetrosUnete =
                    sv.ObtenerParametrosUnete(CodigoISO, Enumeradores.TipoParametro.Validaciones.ToInt(), 0);

                var pag = Paginador(grid, paremetrosUnete.ToList());

                var data = new
                {
                    total = pag.PageCount,
                    page = pag.CurrentPage,
                    records = pag.RecordCount,
                    rows = paremetrosUnete.Select(i => new
                    {
                        cell = new[]
                        {
                            i.IdParametroUnete.ToString(),
                            i.Nombre,
                            i.Valor.ToString()
                        }
                    })
                };

                return Json(data, JsonRequestBehavior.AllowGet);
            }
        }

        public ActionResult ConsultarValidacionTelefonica(int id)
        {
            var model = new ConsultarValidacionTelefonicaModel { SolicitudPostulanteId = id };

            using (var portalSv = new PortalServiceClient())
            {
                var estadosTelefonicos = portalSv.ObtenerParametrosUnete(CodigoISO, EnumsTipoParametro.EstadoTelefonico,
                    0);
                var motivosRechazoTelefonico = portalSv.ObtenerParametrosUnete(CodigoISO,
                    EnumsTipoParametro.MotivoRechazoTelefonico, 0);

                ViewBag.EstadosTelefonicos = new SelectList(estadosTelefonicos, "Valor", "Nombre");
                ViewBag.MotivosRechazoTelefonico = new SelectList(motivosRechazoTelefonico, "Valor", "Nombre");

                return PartialView("_ConsultarValidacionTelefonica", model);
            }
        }

        public ActionResult ConsultarAdjunto(string nombreArchivo, int tipo)
        {
            return PartialView("_ConsultarAdjunto", new Tuple<string, string, int>(CodigoISO, nombreArchivo, tipo));
        }

        [HttpPost]
        public JsonResult ConsultarValidacionTelefonica(ConsultarValidacionTelefonicaModel model)
        {
            using (var sv = new PortalServiceClient())
            {
                var solicitudPostulante = sv.ObtenerSolicitudPostulante(CodigoISO, model.SolicitudPostulanteId);
                solicitudPostulante.EstadoTelefonico = model.EstadoTelefonico;
                solicitudPostulante.MotivoRechazoTelefonico = model.MotivoRechazoTelefonico;
                solicitudPostulante.FechaRegValidacionTelefonica = DateTime.Now;
                sv.ActualizarSolicitudPostulanteSAC(CodigoISO, solicitudPostulante);
                solicitudPostulante = sv.ObtenerSolicitudPostulante(CodigoISO, model.SolicitudPostulanteId);

                if (solicitudPostulante.EstadoPostulante == EnumsEstadoPostulante.EnAprobacionFFVV.ToInt())
                {
                    HojaInscripcionODS.ZonaBE zonaActual;

                    CorreoHelper.EnviarCorreoGz(CodigoISO, solicitudPostulante, out zonaActual);
                }
            }

            return Json(true, JsonRequestBehavior.AllowGet);
        }

        public ActionResult AprobarPostulante(int id)
        {
            return PartialView("_AprobarPostulante", id);
        }

        [HttpPost]
        public JsonResult AprobarPostulante(string id)
        {
            using (var sv = new PortalServiceClient())
            {
                sv.ActualizarEstadoPostulante(CodigoISO
                    , int.Parse(id)
                    , Enumeradores.EstadoPostulante.GenerandoCodigo.ToInt()
                    , Enumeradores.TipoSubEstadoPostulanteGenerandoCodigo.PorSAC.ToInt()
                    , null
                    , null);
            }
            RegistrarLogGestionSacUnete(id.ToString(), "GESTIONA POSTULANTE", "APROBAR");
            return Json(true, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public string NivelesRiesgoInsertar(HttpPostedFileBase uplArchivo, NivelesRiesgoModel model)
        {
            model.CodigoISO = CodigoISO;
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

                string fileextension = Util.Trim(Path.GetExtension(uplArchivo.FileName));

                if (!fileextension.ToLower().Equals(".xlsx"))
                {
                    return "Sólo se permiten archivos MS-Excel versiones 2007-2012.";
                }

                string fileName = Guid.NewGuid().ToString();
                string pathfaltante = Server.MapPath("~/Content/ArchivoNivelRiesgo");
                if (!Directory.Exists(pathfaltante)) Directory.CreateDirectory(pathfaltante);

                var finalPath = Path.Combine(pathfaltante, fileName + fileextension);
                uplArchivo.SaveAs(finalPath);

                bool isCorrect = false;
                NivelesRiesgoModel prod = new NivelesRiesgoModel();

                IList<NivelesRiesgoModel> lista = Util.ReadXmlFile(finalPath, prod, false, ref isCorrect);

                foreach (var item in lista.ToList())
                {
                    if (item.NivelRiesgo == null || item.ZonaSeccion == null)
                    {
                        lista.Remove(item);
                    }
                }

                if (lista.Count == 0)
                {
                    isCorrect = false;
                }

                System.IO.File.Delete(finalPath);
                List<ParametroUnete> listafinal = new List<ParametroUnete>();
                if (isCorrect)
                {

                    foreach (var item in lista)
                    {
                        object altoOrOtro = null; object medioOrAlto = null; object bajoOrMedio = null; object finalValor = null;

                        if (CodigoISO == Pais.Peru || CodigoISO == Pais.Dominicana || CodigoISO == Pais.PuertoRico || CodigoISO == Pais.Mexico || CodigoISO == Pais.Bolivia)
                        {
                            altoOrOtro = (item.NivelRiesgo.ToUpper() == Constantes.TipoNivelesRiesgo.Alto) ? Enumeradores.TipoNivelesRiesgo.Alto.ToInt() : Enumeradores.TipoNivelesRiesgo.Otro.ToInt();
                            medioOrAlto = (item.NivelRiesgo.ToUpper() == Constantes.TipoNivelesRiesgo.Medio) ? Enumeradores.TipoNivelesRiesgo.Medio.ToInt() : altoOrOtro;
                            bajoOrMedio = (item.NivelRiesgo.ToUpper() == Constantes.TipoNivelesRiesgo.Bajo) ? Enumeradores.TipoNivelesRiesgo.Bajo.ToInt() : medioOrAlto;
                            finalValor = string.IsNullOrWhiteSpace(item.NivelRiesgo) ? Enumeradores.TipoNivelesRiesgo.Otro.ToInt() : bajoOrMedio;
                        }
                        // Type @const = (CodigoISO == Pais.Ecuador) ? typeof(Enumeradores.TipoNivelesRiesgo): typeof(Constantes.TipoNivelesRiesgo)
                        // var alto = @const 

                        if (CodigoISO == Pais.Bolivia)
                        {
                            finalValor = bajoOrMedio;
                        }

                        if (CodigoISO == Pais.Ecuador)
                        {
                            altoOrOtro = (item.NivelRiesgo.ToInt() == Enumeradores.TipoNivelesRiesgo.Alto.ToInt()) ? Enumeradores.TipoNivelesRiesgo.Alto.ToInt() : Enumeradores.TipoNivelesRiesgo.Otro.ToInt();
                            medioOrAlto = (item.NivelRiesgo.ToInt() == Enumeradores.TipoNivelesRiesgo.Medio.ToInt()) ? Enumeradores.TipoNivelesRiesgo.Medio.ToInt() : altoOrOtro;
                            bajoOrMedio = (item.NivelRiesgo.ToInt() == Enumeradores.TipoNivelesRiesgo.Bajo.ToInt()) ? Enumeradores.TipoNivelesRiesgo.Bajo.ToInt() : medioOrAlto;
                            finalValor = string.IsNullOrWhiteSpace(item.NivelRiesgo) ? Enumeradores.TipoNivelesRiesgo.Otro.ToInt() : bajoOrMedio;
                        }

                        var parametroTodos = new ParametroUnete
                        {
                            Nombre = item.ZonaSeccion,
                            Descripcion = item.NivelRiesgo,
                            Valor = finalValor.ToInt(),
                            FK_IdTipoParametro = EnumsTipoParametro.TipoNivelesRiesgo.ToInt(),
                            Estado = 1
                        };
                        listafinal.Add(parametroTodos);
                    }

                    if (listafinal.Count > 0)
                    {
                        using (var sv = new PortalServiceClient())
                        {
                            sv.InsertarNivelesRiesgo(model.CodigoISO, listafinal.ToArray());
                        }

                        return "Se realizo satisfactoriamente la carga de datos.";
                    }

                    return "No se Guardo ningun registro";

                }
                else
                {
                    return "Ocurrió un problema al cargar el documento o tal vez se encuentra vacío.";
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
                return "Verifique el formato del Documento, posiblemente no sea igual al de la Plantilla.";
            }
        }

        // hay un metodo con el mismo nombre en Util.ReadXmlFile
        // revisar si se utiliza el Util, para no duplicar codigo
        public static List<V> ReadXmlFile<V>(string filepath, V Source, bool ReadAllSheets, ref bool IsCorrect)
            where V : new()
        {
            string connectionString = string.Empty;
            List<V> list = null;

            try
            {
                string extension = Path.GetExtension(@filepath).ToLower();
                bool isExcel = (new Regex(@"^.*\.(xls|xlsx)$")).IsMatch(extension);

                // Si no es excel
                if (!isExcel) return list;

                // Si es excel
                string csXls = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source={0};Extended Properties=\"Excel 8.0;IMEX=1;HDR=YES;\"";
                string csXlsx = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source={0};Extended Properties=\"Excel 12.0;IMEX=1;HDR=YES;\"";

                connectionString = string.Format(extension.Equals(".xls") ? csXls : csXlsx, filepath);

                List<string> sheets = new List<string>();

                using (OleDbConnection con = new OleDbConnection(connectionString))
                {
                    con.Open();
                    DataTable schemas = con.GetOleDbSchemaTable(OleDbSchemaGuid.Tables, null);

                    if (schemas == null) return list;

                    if (ReadAllSheets)
                    {
                        sheets = schemas.AsEnumerable().Cast<DataRow>().Where(row => row["TABLE_NAME"].ToString().EndsWith("$"))
                                                                       .Select(name => name["TABLE_NAME"].ToString()).ToList();
                    }
                    else
                    {
                        sheets.Add((string)schemas.Rows[0]["TABLE_NAME"]);
                    }


                    foreach (string sheetName in sheets)
                    {
                        string commandText = "Select * From [" + sheetName + "]";

                        using (OleDbCommand select = new OleDbCommand(commandText, con))
                        {
                            using (OleDbDataReader reader = select.ExecuteReader())
                            {
                                if (reader == null) continue;

                                reader.GetSchemaTable();
                                if (!reader.HasRows) continue;

                                list = new List<V>();
                                while (reader.Read())
                                {
                                    var entity = new V();
                                    foreach (System.Reflection.PropertyInfo property in Source.GetType().GetProperties())
                                    {
                                        if (!reader.HasColumn(property.Name)) continue;

                                        System.Reflection.PropertyInfo prop = entity.GetType().GetProperty(property.Name);

                                        if (prop == null) continue;

                                        Type tipo = prop.PropertyType;
                                        object changed = Convert.ChangeType(reader[property.Name], tipo);
                                        prop.SetValue(entity, changed, null);
                                    }

                                    list.Add(entity);
                                }
                            }
                        }
                    }

                    IsCorrect = true;
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, "xml", "xnmkl");
                IsCorrect = false;
            }

            return list;
        }

        public static List<NivelesGeograficosModel> ReadXmlFileNG(string filepath, bool readAllSheets,
            ref bool isCorrect, string codigoPais)
        {
            string connectionString = string.Empty;
            List<NivelesGeograficosModel> list = null;

            try
            {
                var file = Path.GetExtension(@filepath);
                if (file == null) return list;

                string extension = file.ToLower();
                bool isExcel = (new Regex(@"^.*\.(xls|xlsx)$")).IsMatch(extension);

                // No es Excel
                if (!isExcel) return list;

                // Si es excel
                string csXls = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source={0};Extended Properties=\"Excel 8.0;IMEX=1;HDR=YES;\"";
                string csXlsx = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source={0};Extended Properties=\"Excel 12.0;IMEX=1;HDR=YES;\"";

                connectionString = string.Format(extension.Equals(".xls") ? csXls : csXlsx, filepath);

                List<string> sheets = new List<string>();

                using (OleDbConnection con = new OleDbConnection(connectionString))
                {
                    con.Open();
                    DataTable schemas = con.GetOleDbSchemaTable(OleDbSchemaGuid.Tables, null);

                    if (schemas == null) return list;

                    if (readAllSheets)
                    {
                        sheets = schemas.AsEnumerable().Cast<DataRow>().Where(row => row["TABLE_NAME"].ToString().EndsWith("$"))
                                                                       .Select(name => name["TABLE_NAME"].ToString()).ToList();
                    }
                    else
                    {
                        sheets.Add((string)schemas.Rows[0]["TABLE_NAME"]);
                    }

                    foreach (string sheetName in sheets)
                    {
                        string commandText = "Select * From [" + sheetName + "]";

                        using (OleDbCommand select = new OleDbCommand(commandText, con))
                        {
                            using (OleDbDataReader reader = select.ExecuteReader())
                            {
                                if (reader == null) continue;

                                reader.GetSchemaTable();
                                if (!reader.HasRows) continue;

                                list = new List<NivelesGeograficosModel>();
                                NivelesGeograficosModel entity;

                                while (reader.Read())
                                {
                                    entity = new NivelesGeograficosModel
                                    {
                                        REG = reader["REG"].ToString(),
                                        ZONA = reader["ZONA"].ToString(),
                                        SECC = reader["SECC"].ToString(),
                                        TERRITO = reader["TERRITO"].ToString(),
                                        UBIGEO = reader["UBIGEO"].ToString(),
                                    };

                                    if (codigoPais == Pais.CostaRica || codigoPais == Pais.Panama)
                                    {
                                        entity.PROVINCIA = reader["PROVINCIA"].ToString();
                                        entity.DISTRITO = reader["DISTRITO"].ToString();
                                    }
                                    if (codigoPais == Pais.CostaRica)
                                    {
                                        entity.CANTON = reader["CANTON"].ToString();
                                        entity.BARRIO_COLONIA_URBANIZACION_BARRIADAS_REFERENCIAS = reader["BARRIO_COLONIA_URBANIZACION_BARRIADAS_REFERENCIAS"].ToString();
                                    }
                                    if (codigoPais == Pais.Panama)
                                    {
                                        entity.CORREGIMIENTO = reader["CORREGIMIENTO"].ToString();
                                        entity.BARRIO_COLONIA_URBANIZACION_REFERENCIAS = reader["BARRIO_COLONIA_URBANIZACION_REFERENCIAS"].ToString();
                                    }

                                    if (codigoPais == Pais.Guatemala || codigoPais == Pais.Salvador)
                                    {
                                        entity.DEPARTAMENTO = reader["DEPARTAMENTO"].ToString();
                                        entity.MUNICIPIO = reader["MUNICIPIO"].ToString();
                                    }
                                    if (codigoPais == Pais.Guatemala)
                                    {
                                        entity.ZONA_CIUDAD = reader["ZONA_CIUDAD"].ToString();
                                        entity.CENTRO_POBLADO = reader["CENTRO_POBLADO"].ToString();
                                        entity.BARRIO_COLONIA_URBANIZACION_ALDEA_REFERENCIAS =
                                            reader["BARRIO_COLONIA_URBANIZACION_ALDEA_REFERENCIAS"].ToString();
                                    }
                                    if (codigoPais == Pais.Salvador)
                                    {
                                        entity.CANTON_CENTRO_POBLADO = reader["CANTON_CENTRO_POBLADO"].ToString();
                                        entity.BARRIO_COLONIA_URBANIZACION_REFERENCIAS = reader["BARRIO_COLONIA_URBANIZACION_REFERENCIAS"].ToString();
                                    }

                                    list.Add(entity);
                                }

                            }
                        }
                    }

                    isCorrect = true;
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, "xml", "xnmkl");
                isCorrect = false;
            }

            return list;
        }

        [HttpPost]
        public string NivelesGeograficosInsertar(HttpPostedFileBase uplArchivo, NivelesGeograficosModel model)
        {
            model.CodigoISO = CodigoISO;
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


                string finalPath = string.Empty;
                string fileextension = Util.Trim(Path.GetExtension(uplArchivo.FileName));

                if (!fileextension.ToLower().Equals(".xlsx"))
                {
                    return "Sólo se permiten archivos MS-Excel versiones 2007-2012.";
                }

                string pathfaltante = "";
                string fileName = "";
                try
                {
                    fileName = Guid.NewGuid().ToString();
                    pathfaltante = Server.MapPath("~/Content/ArchivoNivelGeografico");

                }
                catch (Exception ex)
                {
                    LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora + " File 01", UserData().CodigoISO);
                }

                try
                {
                    if (!Directory.Exists(pathfaltante)) Directory.CreateDirectory(pathfaltante);
                }
                catch (Exception ex)
                {
                    LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora + " directorio 02", UserData().CodigoISO);
                }

                try
                {
                    finalPath = Path.Combine(pathfaltante, fileName + fileextension);
                    uplArchivo.SaveAs(finalPath);
                }
                catch (Exception ex)
                {
                    LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora + " guarda archivo", UserData().CodigoISO);
                }

                IList<NivelesGeograficosModel> lista = null;
                try
                {
                    bool isCorrect = false;
                    lista = ReadXmlFileNG(finalPath, true, ref isCorrect, CodigoISO);
                }
                catch (Exception ex)
                {
                    LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora + " lee archivo", UserData().CodigoISO);
                }

                System.IO.File.Delete(finalPath);

                List<UbigeoTemplate> listaUbigeo = new List<UbigeoTemplate>();

                if (lista == null) return "Ocurrió un problema al cargar el documento o tal vez se encuentra vacío.";

                #region NuevoBucle

                // clase ubigeo segun pais
                Dictionary<string, Type> dicUbigeo = new Dictionary<string, Type> {
                    { Pais.Panama   , typeof(UbigeoPA)}, { Pais.CostaRica, typeof(UbigeoCR)},
                    { Pais.Salvador , typeof(UbigeoSV)}, { Pais.Guatemala, typeof(UbigeoGT)}
                };

                foreach (var item in lista)
                {
                    if (CodigoISO == Pais.Panama && (
                        string.IsNullOrWhiteSpace(item.PROVINCIA) ||
                        string.IsNullOrWhiteSpace(item.DISTRITO) ||
                        string.IsNullOrWhiteSpace(item.CORREGIMIENTO)
                    )) continue;

                    // Creando instancia de objeto
                    dynamic objUbigeo = Activator.CreateInstance(dicUbigeo[CodigoISO]);

                    objUbigeo.REG = item.REG;
                    objUbigeo.ZONA = item.ZONA;
                    objUbigeo.SECC = item.SECC;
                    objUbigeo.TERRITO = item.TERRITO;
                    objUbigeo.UBIGEO = item.UBIGEO;

                    if (CodigoISO == Pais.CostaRica || CodigoISO == Pais.Panama)
                    {
                        objUbigeo.PROVINCIA = item.PROVINCIA;
                        objUbigeo.DISTRITO = item.DISTRITO;
                    }
                    if (CodigoISO == Pais.CostaRica)
                    {
                        objUbigeo.CANTON = item.CANTON;
                        objUbigeo.BARRIO_COLONIA_URBANIZACION_BARRIADAS_REFERENCIAS = item.BARRIO_COLONIA_URBANIZACION_BARRIADAS_REFERENCIAS;
                    }
                    if (CodigoISO == Pais.Panama)
                    {
                        objUbigeo.CORREGIMIENTO = item.CORREGIMIENTO;
                        objUbigeo.BARRIO_COLONIA_URBANIZACION_REFERENCIAS = item.BARRIO_COLONIA_URBANIZACION_REFERENCIAS;
                    }

                    if (CodigoISO == Pais.Salvador || CodigoISO == Pais.Guatemala)
                    {
                        objUbigeo.DEPARTAMENTO = item.DEPARTAMENTO;
                        objUbigeo.MUNICIPIO = item.MUNICIPIO;
                    }
                    if (CodigoISO == Pais.Salvador)
                    {
                        objUbigeo.CANTON_CENTRO_POBLADO = item.CANTON_CENTRO_POBLADO;
                        objUbigeo.BARRIO_COLONIA_URBANIZACION_REFERENCIAS = item.BARRIO_COLONIA_URBANIZACION_REFERENCIAS;
                    }
                    if (CodigoISO == Pais.Guatemala)
                    {
                        objUbigeo.CENTRO_POBLADO = item.CENTRO_POBLADO;
                        objUbigeo.ZONA_CIUDAD = item.ZONA_CIUDAD;
                        objUbigeo.BARRIO_COLONIA_URBANIZACION_ALDEA_REFERENCIAS = item.BARRIO_COLONIA_URBANIZACION_ALDEA_REFERENCIAS;
                    }
                    listaUbigeo.Add(objUbigeo);
                }

                #endregion

                if (listaUbigeo.Count > 0)
                {
                    using (var sv = new PortalServiceClient())
                    {
                        sv.InsertarNivelesGeograficosGeneral(model.CodigoISO, listaUbigeo.ToArray());
                    }

                    return "Se realizo satisfactoriamente la carga de datos.";
                }
                return "No se Guardo ningun registro";
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return "Verifique el formato del Documento, posiblemente no sea igual al de la Plantilla.";
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);

                if (ex.GetType() == typeof(TimeoutException))
                    return "Tiempo de espera agotado. El servicio culminara el proceso por su cuenta. Revise los datos en unos minutos.";
                return "Verifique el formato del Documento, posiblemente no sea igual al de la Plantilla.";
            }
        }

        public void EnviarAFFVV(string id)
        {
            var solicitudPostulanteId = Convert.ToInt32(id);

            var user = UserData();

            using (var sv = new PortalServiceClient())
            {
                var solicitudPostulante = sv.ObtenerSolicitudPostulante(user.CodigoISO, solicitudPostulanteId);

                if (solicitudPostulante != null)
                {
                    solicitudPostulante.IndicadorActivo = true;
                    solicitudPostulante.IndicadorOptin = false;
                    sv.ActualizarSolicitudPostulanteSAC(CodigoISO, solicitudPostulante);
                    solicitudPostulante = sv.ObtenerSolicitudPostulante(user.CodigoISO, solicitudPostulanteId);

                    #region Envío de correos

                    if (solicitudPostulante.EstadoPostulante == Enumeradores.EstadoPostulante.EnAprobacionFFVV.ToInt())
                    {
                        HojaInscripcionODS.ZonaBE zonaActual;

                        CorreoHelper.EnviarCorreoGz(CodigoISO, solicitudPostulante, out zonaActual);
                    }

                    #endregion
                }
            }
        }

        public ActionResult ValidacionTelefonica()
        {
            return View("ValidacionTelefonica", new ValidacionTelefonicaModel
            {
                FechaDesde = DateTime.Now.ToString("dd/MM/yyyy"),
                FechaHasta = DateTime.Now.ToString("dd/MM/yyyy"),
            });
        }

        public JsonResult ObtenerNombreConsultora(string codigoISO, string codigoConsultora)
        {
            var codigo = codigoConsultora;
            ConsultoraBE consultora;

            using (var sv = new BelcorpPaisServiceClient())
            {
                if (codigoISO == Constantes.CodigosISOPais.Colombia)
                {
                    codigo = codigo.PadLeft(10, '0');
                    consultora = sv.ObtenerConsultoraPorDocumento(codigoISO, codigo);
                }
                else
                {
                    codigo = codigo.PadLeft(7, '0');
                    consultora = sv.ObtenerConsultoraPorCodigo(codigoISO, codigo);
                }
            }

            return Json(consultora != null ? consultora.NombreCompleto : string.Empty, JsonRequestBehavior.AllowGet);
        }

        public ActionResult ObtenerCodigoPostal(int id, string codigoIso)
        {
            var codigoPostal = string.Empty;
            using (var sv = new BelcorpPaisServiceClient())
            {
                var lugaresNivel1 = sv.ObtenerParametrosUnete(CodigoISO, EnumsTipoParametro.LugarNivel1.ToInt(), 0);
                var item = lugaresNivel1.FirstOrDefault(x => x.IdParametroUnete == id);
                if (item != null)
                {
                    codigoPostal = item.Descripcion;
                }

                var data = new { CodigoPostal = codigoPostal };

                return Json(data, JsonRequestBehavior.AllowGet);
            }
        }

        public ActionResult ObtenerNivelN(int id, string codigoIso, int nivel)
        {
            using (var sv = new BelcorpPaisServiceClient())
            {
                var lugaresNivel = sv.ObtenerParametrosUnete(codigoIso, nivel, id);

                var data = lugaresNivel.Select(l =>
                    new { Value = l.IdParametroUnete, Text = l.Nombre, CodigoPostalDO = l.Descripcion }).ToList();


                return Json(data, JsonRequestBehavior.AllowGet);
            }
        }

        public JsonResult GetConfiguracionZonasTelefonicas(int idParametroTelefonico)
        {
            using (var sv = new BelcorpPaisServiceClient())
            {
                var parametrosZonasTelefonicas =
                    sv.ObtenerParametrosUnete(CodigoISO, Enumeradores.TipoParametro.Validaciones.ToInt(),
                        idParametroTelefonico);

                return Json(new
                {
                    listaZonasActivas = parametrosZonasTelefonicas.Where(p => p.Valor == 1),
                    listaZonasInactivas = parametrosZonasTelefonicas.Where(p => p.Valor == 0)
                });
            }
        }

        #region Metodos privados

        private string AplicarFormatoNumeroDocumentoPorPais(string codigoPais, string numeroDocumento)
        {
            return Dictionaries.FormatoNumeroDocumentoBD.ContainsKey(codigoPais) &&
                   Dictionaries.FormatoNumeroDocumentoBD[codigoPais] != null &&
                   !string.IsNullOrWhiteSpace(numeroDocumento)
                ? Dictionaries.FormatoNumeroDocumentoBD[codigoPais](numeroDocumento)
                : numeroDocumento;
        }

        #endregion

        #region ReenviarCorreo

        public string RenderViewAsString(string viewName, object model)
        {
            StringWriter stringWriter = new StringWriter();

            ViewEngineResult viewResult = ViewEngines.Engines.FindView(ControllerContext, viewName, null);

            ViewContext viewContext = new ViewContext(
                ControllerContext,
                viewResult.View,
                new ViewDataDictionary(model),
                new TempDataDictionary(),
                stringWriter
            );

            viewResult.View.Render(viewContext, stringWriter);

            return stringWriter.ToString();
        }

        public string RenderViewAsString<T>(string viewName, object model)
            where T : Controller, new()
        {
            StringWriter stringWriter = new StringWriter();

            var controllerContext = this.CreateController<T>().ControllerContext;

            ViewEngineResult viewResult = ViewEngines.Engines.FindView(controllerContext, viewName, null);

            ViewContext viewContext = new ViewContext(
                controllerContext,
                viewResult.View,
                new ViewDataDictionary(model),
                new TempDataDictionary(),
                stringWriter
            );

            viewResult.View.Render(viewContext, stringWriter);

            return stringWriter.ToString();
        }

        public void ReEnviarCorreoNotificacion(int id)
        {

            SolicitudPostulante solicitudPostulante;
            var user = UserData();

            using (var sv = new PortalServiceClient())
            {
                solicitudPostulante = sv.ObtenerSolicitudPostulante(user.CodigoISO, id);
            }

            solicitudPostulante.NumeroDocumento = AplicarFormatoNumeroDocumentoPorPais(user.CodigoISO,
                solicitudPostulante.NumeroDocumento);

            var token =
                new Crypto().EncryptToString(string.Format("{0}|{1}|{2}", solicitudPostulante.NumeroDocumento,
                    solicitudPostulante.CorreoElectronico, user.CodigoISO));

            var urlConfirmacion = _configuracionManagerProvider.GetConfiguracionManager(Constantes.ConfiguracionManager.UrlUneteBelcorp) + "?id=" +
                                  token + "&p=" +
                                  user.CodigoISO +
                                  "&utm_source=Transaccional&utm_medium=email&utm_content=Completa_datos&utm_campaign=Unete_a_Belcorp";

            var mensaje = RenderViewAsString("MailOptIn", new MailOptInModel
            {
                UrlConfirmacion = urlConfirmacion,
                Telefono1 = "800-210-207",
                Telefono2 = "2-28762100 (desde un celular)",
                Nombre = solicitudPostulante.PrimerNombre
            });

            var images = ImagenesMailOptIn();

            var nombre = string.Format("{0} {1}", solicitudPostulante.PrimerNombre,
                solicitudPostulante.ApellidoPaterno);

            EnviarMailMandrillJson(new List<ToWithType>{
                new ToWithType{
                    email = solicitudPostulante.CorreoElectronico,
                    name = nombre,
                    type = "to"
                }
            }, mensaje, images);
        }

        public static dynamic EnviarMailMandrillJson(List<ToWithType> recipients, string message,
            List<Images> images = null)
        {
            var url = ConfigurationManager.AppSettings["SMPTURL"];
            var key = ConfigurationManager.AppSettings["SMPTPassword"];
            var from = ConfigurationManager.AppSettings["UneteMailFrom"];
            var subject = ConfigurationManager.AppSettings["UneteMailSubject"];

            var jsonObject = JsonConvert.SerializeObject(new
            {
                key = key,
                message = new
                {
                    from_email = from,
                    subject = subject,
                    html = message,
                    important = false,
                    to = recipients,
                    async = true,
                    images = images ?? new List<Images>()
                }
            });

            var bytes = Encoding.ASCII.GetBytes(jsonObject);

            try
            {
                var request = WebRequest.Create(string.Format("{0}{1}", url, "")) as HttpWebRequest;
                request.Method = "POST";
                request.ContentType = "application/json";
                request.ContentLength = bytes.Length;

                using (var stream = request.GetRequestStream())
                {
                    stream.Write(bytes, 0, bytes.Length);
                }

                var response = (request.GetResponse()) as HttpWebResponse;
                var result = new StreamReader(response.GetResponseStream()).ReadToEnd();

                return (JsonConvert.DeserializeObject(result) as dynamic);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, "", "", "EnviarMailMandrillJson");
                return null;
            }
        }

        private List<Images> ImagenesMailOptIn()
        {
            var images = new List<Images>
            {
                new Images
                {
                    name = "1",
                    content =
                        "/9j/4QAYRXhpZgAASUkqAAgAAAAAAAAAAAAAAP/sABFEdWNreQABAAQAAABGAAD/4QMdaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wLwA8P3hwYWNrZXQgYmVnaW49Iu+7vyIgaWQ9Ilc1TTBNcENlaGlIenJlU3pOVGN6a2M5ZCI/PiA8eDp4bXBtZXRhIHhtbG5zOng9ImFkb2JlOm5zOm1ldGEvIiB4OnhtcHRrPSJBZG9iZSBYTVAgQ29yZSA1LjMtYzAxMSA2Ni4xNDU2NjEsIDIwMTIvMDIvMDYtMTQ6NTY6MjcgICAgICAgICI+IDxyZGY6UkRGIHhtbG5zOnJkZj0iaHR0cDovL3d3dy53My5vcmcvMTk5OS8wMi8yMi1yZGYtc3ludGF4LW5zIyI+IDxyZGY6RGVzY3JpcHRpb24gcmRmOmFib3V0PSIiIHhtbG5zOnhtcE1NPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvbW0vIiB4bWxuczpzdFJlZj0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL3NUeXBlL1Jlc291cmNlUmVmIyIgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIiB4bXBNTTpEb2N1bWVudElEPSJ4bXAuZGlkOkJEMjREMDc5Q0FCRDExRTU4NDFFRkYwQUUwNEVDOTVGIiB4bXBNTTpJbnN0YW5jZUlEPSJ4bXAuaWlkOkJEMjREMDc4Q0FCRDExRTU4NDFFRkYwQUUwNEVDOTVGIiB4bXA6Q3JlYXRvclRvb2w9IkFkb2JlIFBob3Rvc2hvcCBDUzUuMSBNYWNpbnRvc2giPiA8eG1wTU06RGVyaXZlZEZyb20gc3RSZWY6aW5zdGFuY2VJRD0iMTZDRDM0RTlCNEY1OTZEQzlCMDBEOEMyM0QwMzVENzYiIHN0UmVmOmRvY3VtZW50SUQ9IjE2Q0QzNEU5QjRGNTk2REM5QjAwRDhDMjNEMDM1RDc2Ii8+IDwvcmRmOkRlc2NyaXB0aW9uPiA8L3JkZjpSREY+IDwveDp4bXBtZXRhPiA8P3hwYWNrZXQgZW5kPSJyIj8+/+4ADkFkb2JlAGTAAAAAAf/bAIQABAMDAwMDBAMDBAYEAwQGBwUEBAUHCAYGBwYGCAoICQkJ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"
                },
                new Images
                {
                    name = "1.1",
                    content =
                        "/9j/4QAYRXhpZgAASUkqAAgAAAAAAAAAAAAAAP/sABFEdWNreQABAAQAAABGAAD/4QMdaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wLwA8P3hwYWNrZXQgYmVnaW49Iu+7vyIgaWQ9Ilc1TTBNcENlaGlIenJlU3pOVGN6a2M5ZCI/PiA8eDp4bXBtZXRhIHhtbG5zOng9ImFkb2JlOm5zOm1ldGEvIiB4OnhtcHRrPSJBZG9iZSBYTVAgQ29yZSA1LjMtYzAxMSA2Ni4xNDU2NjEsIDIwMTIvMDIvMDYtMTQ6NTY6MjcgICAgICAgICI+IDxyZGY6UkRGIHhtbG5zOnJkZj0iaHR0cDovL3d3dy53My5vcmcvMTk5OS8wMi8yMi1yZGYtc3ludGF4LW5zIyI+IDxyZGY6RGVzY3JpcHRpb24gcmRmOmFib3V0PSIiIHhtbG5zOnhtcE1NPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvbW0vIiB4bWxuczpzdFJlZj0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL3NUeXBlL1Jlc291cmNlUmVmIyIgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIiB4bXBNTTpEb2N1bWVudElEPSJ4bXAuZGlkOjcyMzQ2OUM3Q0FDMDExRTVCOTJFOEFFQzNFNTk5NkQ2IiB4bXBNTTpJbnN0YW5jZUlEPSJ4bXAuaWlkOjcyMzQ2OUM2Q0FDMDExRTVCOTJFOEFFQzNFNTk5NkQ2IiB4bXA6Q3JlYXRvclRvb2w9IkFkb2JlIFBob3Rvc2hvcCBDUzUuMSBNYWNpbnRvc2giPiA8eG1wTU06RGVyaXZlZEZyb20gc3RSZWY6aW5zdGFuY2VJRD0iMTZDRDM0RTlCNEY1OTZEQzlCMDBEOEMyM0QwMzVENzYiIHN0UmVmOmRvY3VtZW50SUQ9IjE2Q0QzNEU5QjRGNTk2REM5QjAwRDhDMjNEMDM1RDc2Ii8+IDwvcmRmOkRlc2NyaXB0aW9uPiA8L3JkZjpSREY+IDwveDp4bXBtZXRhPiA8P3hwYWNrZXQgZW5kPSJyIj8+/+4ADkFkb2JlAGTAAAAAAf/bAIQABAMDAwMDBAMDBAYEAwQGBwUEBAUHCAYGBwYGCAoICQkJ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"
                },
                new Images
                {
                    name = "2",
                    content =
                        "iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAyRpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDUuMy1jMDExIDY2LjE0NTY2MSwgMjAxMi8wMi8wNi0xNDo1NjoyNyAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIiB4bWxuczp4bXBNTT0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL21tLyIgeG1sbnM6c3RSZWY9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZVJlZiMiIHhtcDpDcmVhdG9yVG9vbD0iQWRvYmUgUGhvdG9zaG9wIENTNiAoTWFjaW50b3NoKSIgeG1wTU06SW5zdGFuY2VJRD0ieG1wLmlpZDozNjM3MTREMEJFMDMxMUU1QTYwM0EzNDJEMkU3RkMzOSIgeG1wTU06RG9jdW1lbnRJRD0ieG1wLmRpZDozNjM3MTREMUJFMDMxMUU1QTYwM0EzNDJEMkU3RkMzOSI+IDx4bXBNTTpEZXJpdmVkRnJvbSBzdFJlZjppbnN0YW5jZUlEPSJ4bXAuaWlkOkEzQTc3QTA5QkRGNDExRTVBNjAzQTM0MkQyRTdGQzM5IiBzdFJlZjpkb2N1bWVudElEPSJ4bXAuZGlkOkEzQTc3QTBBQkRGNDExRTVBNjAzQTM0MkQyRTdGQzM5Ii8+IDwvcmRmOkRlc2NyaXB0aW9uPiA8L3JkZjpSREY+IDwveDp4bXBtZXRhPiA8P3hwYWNrZXQgZW5kPSJyIj8+fgRQlwAAABBJREFUeNpi+P//PwNAgAEACPwC/tuiTRYAAAAASUVORK5CYII="
                },
                new Images
                {
                    name = "2.1",
                    content =
                        "/9j/4QAYRXhpZgAASUkqAAgAAAAAAAAAAAAAAP/sABFEdWNreQABAAQAAABkAAD/4QNxaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wLwA8P3hwYWNrZXQgYmVnaW49Iu+7vyIgaWQ9Ilc1TTBNcENlaGlIenJlU3pOVGN6a2M5ZCI/PiA8eDp4bXBtZXRhIHhtbG5zOng9ImFkb2JlOm5zOm1ldGEvIiB4OnhtcHRrPSJBZG9iZSBYTVAgQ29yZSA1LjAtYzA2MSA2NC4xNDA5NDksIDIwMTAvMTIvMDctMTA6NTc6MDEgICAgICAgICI+IDxyZGY6UkRGIHhtbG5zOnJkZj0iaHR0cDovL3d3dy53My5vcmcvMTk5OS8wMi8yMi1yZGYtc3ludGF4LW5zIyI+IDxyZGY6RGVzY3JpcHRpb24gcmRmOmFib3V0PSIiIHhtbG5zOnhtcE1NPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvbW0vIiB4bWxuczpzdFJlZj0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL3NUeXBlL1Jlc291cmNlUmVmIyIgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIiB4bXBNTTpPcmlnaW5hbERvY3VtZW50SUQ9InhtcC5kaWQ6MDE4MDExNzQwNzIwNjgxMUExRTNENEZCNjVEQkEzQUEiIHhtcE1NOkRvY3VtZW50SUQ9InhtcC5kaWQ6OTMwRjBGMjJGRUE0MTFFNThDOTU5ODkxQTM1OUEwMEIiIHhtcE1NOkluc3RhbmNlSUQ9InhtcC5paWQ6OTMwRjBGMjFGRUE0MTFFNThDOTU5ODkxQTM1OUEwMEIiIHhtcDpDcmVhdG9yVG9vbD0iQWRvYmUgUGhvdG9zaG9wIENTNS4xIE1hY2ludG9zaCI+IDx4bXBNTTpEZXJpdmVkRnJvbSBzdFJlZjppbnN0YW5jZUlEPSJ4bXAuaWlkOjgxQkYzRjQxNEMyMDY4MTE5RTc4RTY5OUYzNDlCNkNFIiBzdFJlZjpkb2N1bWVudElEPSJ4bXAuZGlkOjAxODAxMTc0MDcyMDY4MTFBMUUzRDRGQjY1REJBM0FBIi8+IDwvcmRmOkRlc2NyaXB0aW9uPiA8L3JkZjpSREY+IDwv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"
                },
                new Images
                {
                    name = "3.1",
                    content =
                        "iVBORw0KGgoAAAANSUhEUgAAACEAAAAeCAIAAAAtquBAAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAA2hpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDUuMy1jMDExIDY2LjE0NTY2MSwgMjAxMi8wMi8wNi0xNDo1NjoyNyAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wTU09Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9tbS8iIHhtbG5zOnN0UmVmPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvc1R5cGUvUmVzb3VyY2VSZWYjIiB4bWxuczp4bXA9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC8iIHhtcE1NOk9yaWdpbmFsRG9jdW1lbnRJRD0ieG1wLmRpZDowMTgwMTE3NDA3MjA2ODExQTFFM0Q0RkI2NURCQTNBQSIgeG1wTU06RG9jdW1lbnRJRD0ieG1wLmRpZDo5NEQ0NDAwM0NBQzQxMUU1OEVBMkJBMEM4NjQ5QjQ4NCIgeG1wTU06SW5zdGFuY2VJRD0ieG1wLmlpZDo5NEQ0NDAwMkNBQzQxMUU1OEVBMkJBMEM4NjQ5QjQ4NCIgeG1wOkNyZWF0b3JUb29sPSJBZG9iZSBQaG90b3Nob3AgQ1M1LjEgTWFjaW50b3NoIj4gPHhtcE1NOkRlcml2ZWRGcm9tIHN0UmVmOmluc3RhbmNlSUQ9InhtcC5paWQ6RTA3NDlGRTEyRjIwNjgxMTgwQkFFMjFGRkE5QTgyQkUiIHN0UmVmOmRvY3VtZW50SUQ9InhtcC5kaWQ6MDE4MDExNzQwNzIwNjgxMUExRTNENEZCNjVEQkEzQUEiLz4gPC9yZGY6RGVzY3JpcHRpb24+IDwvcmRmOlJERj4gPC94OnhtcG1ldGE+IDw/eHBhY2tldCBlbmQ9InIiPz7qq+EhAAADK0lEQVR42pyWS0/bQBDH8Xqx8yBVUxABCXFA9FIeudMDPfCVuXDjA3CGS+FAkUJFgpqQxM7D7o+ddkX9WJKOosiJZ+c/z/+sNxyOV4okTdP5fJ4kyWw2S9NE/vQ8pbVWSvm+73neymKiC61Pjfw1ja3UfPMqieMY4wBovYqAtzQGXkdRhPu+j8ur4rWJQDBSXhHfbDYFbDqdBEEYBMESGPg+Go0wWqlUrPW3AhJ/8gq7IMVxhD6o6C+EMZlMiIDzHCDdbtdMrrTv12MjwFSr1bIKaQuAR2EYArB4MdFEn8g4yzMwpRhEPR6PKeBSAFbIG3UiB1gguLzCa8ajaIwvjmARaWK8wVz+LQkgc9IsBXFwMklSlMq6kGP39/e3t98Hg4Hv63a7vbOzk1erVKrD4RBrRJPxVdMbUsCyCO7ubi8vL5+fnzmP2u7ubiEGbcJb6sp3FoMgSGhZEJy5vr55euo2mx/39vYajQ+tVstRGEIh7ow1MFccnUoBRqMhk7e1tX16+s0R7qut125WhJthGi1jVcZX9D4PqJBlKbiQVXk3K0iAJsj2bmE70c1XV1e9XrffH4Rh0Ol0Li4u6vXa8XF7Y2OjDAMPDIem/8QhZJcXVG9uqMTPtbUGSej3fz08/NjcbB0eHi07QNqR3IODL73e9uNj5+Xlpdls7u9/Xl//1Gg0/gMjzYQmUqvVTk6+QhLn5+fdbpcIzs7O3DW3BJOxphjbwtG1+ZX622e3QPz5jlCyEhy9CwR+udUsI7A58ytS8ZPyvuugI9a3bYL1gjigAFaT8bfYOCMSRTGL710n0PSNZGsOG4LBa4pcxEIadqLUDgoRkWkt3Lse9xI4GQ24Pa8h9wdhQ8feJg30d2gk36Ja2B8lkGRXZxoxMOKIwHDaCKZCrZAy/tw5CEIpTxbAUvOFPgCyP8qaW9k5qNXqlIuQYap329TWALd4wEXHeOq340bZyRg7A+8IvOyKJlesyYT7FVuPe0zVfY/x8ndRisx5psnQPh/fItkLKg+mAGF+6y3EibiPX/aSYGQmIyhUpI2gswi7lPKuMoIhoRA75MJ3C5q28luAAQCltPeJTgXd8AAAAABJRU5ErkJggg=="
                },
                new Images
                {
                    name = "3.2",
                    content =
                        "iVBORw0KGgoAAAANSUhEUgAAAGgAAAAeCAIAAABPBcwqAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAA2hpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDUuMy1jMDExIDY2LjE0NTY2MSwgMjAxMi8wMi8wNi0xNDo1NjoyNyAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wTU09Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9tbS8iIHhtbG5zOnN0UmVmPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvc1R5cGUvUmVzb3VyY2VSZWYjIiB4bWxuczp4bXA9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC8iIHhtcE1NOk9yaWdpbmFsRG9jdW1lbnRJRD0ieG1wLmRpZDowMTgwMTE3NDA3MjA2ODExQTFFM0Q0RkI2NURCQTNBQSIgeG1wTU06RG9jdW1lbnRJRD0ieG1wLmRpZDo5NEQ0M0ZGRkNBQzQxMUU1OEVBMkJBMEM4NjQ5QjQ4NCIgeG1wTU06SW5zdGFuY2VJRD0ieG1wLmlpZDo5NEQ0M0ZGRUNBQzQxMUU1OEVBMkJBMEM4NjQ5QjQ4NCIgeG1wOkNyZWF0b3JUb29sPSJBZG9iZSBQaG90b3Nob3AgQ1M1LjEgTWFjaW50b3NoIj4gPHhtcE1NOkRlcml2ZWRGcm9tIHN0UmVmOmluc3RhbmNlSUQ9InhtcC5paWQ6RTA3NDlGRTEyRjIwNjgxMTgwQkFFMjFGRkE5QTgyQkUiIHN0UmVmOmRvY3VtZW50SUQ9InhtcC5kaWQ6MDE4MDExNzQwNzIwNjgxMUExRTNENEZCNjVEQkEzQUEiLz4gPC9yZGY6RGVzY3JpcHRpb24+IDwvcmRmOlJERj4gPC94OnhtcG1ldGE+IDw/eHBhY2tldCBlbmQ9InIiPz7wWiWkAAAENklEQVR42uyY70+TVxTHZynygkrosGSmNNhCkCXSOQrS4iTEiYtzL91795fNF/54Lc6ZiT8qSsGwYiYmIAnUhHUolWTBPiwtv/ZZTzx5vJUfXffCLPe8aO5zn+c599zv+Z7vuU8POM5fn1ir3DwWAgucBc4CZ4GzZoGzwH3UwP1ZMgtTxcDdvv3z+vq6hancDuzy5eA4DnQLBoMWJsM2Nze9WpJjY49zuRzjzs7PY7FYbW1tfX19KpVS4Lg7MzOzsDDPOBAInDzZxy/jTCbDbzgcVr9TU1ORSKSxsZHBysqKe8ne3l6Z9/l8HR0dOj8yMjI0NCTjubm558+nV1dX6+rqurq6jh3rJBjm4f74+LgEEAy2iCtDWCYnJ90zTU1N3d3dMj84OCh+Phjz/m17e3tjY8MrAd2/f+/06QGAYDw9PZ1MJmUb2ezvitrduyPxeGJgYEAW5vL8+W8J3XHyhmvACoVCMmhtbfX7/XqLZMj8s2e/NTc36851ITBdWvrjzJmvS54dgrlz55cLF77jFlHhTQNARi5e/F6xkI0UiwUyqjOKOP4BXd4tFVP+X9Nta2sL4DySKHIr9GElUnTkyGfG048ejZ49O6QpYgCIy8vLey4DagGX6T6j0S/geLk4vHgxe+7cNwIoKMfj8YMH64QgbN4IoFgsGh542L2cJgaGvn27ms1mq69TGMfPP8DhnbqYmJjAr7SC48e7jP1IebonCd1da5UalDx0qIGqdE+SiXA44iYR1t7evri4KJuHdIAo8RCA8HefdurUV0+eTPwnvQ7ovMIyim52dnZ09GGhUIhE2qLRqFs+1tbW2KRelkLPlxjh21Mmbt36yX156dIPOk4kEjdvDqOhun/c+nwmFqghUTFApKjcp0+nSDNZPHHiy/LGBSsvX/5RL3t6epQE7IhM44GSqh47rzqNl4yyBUFDPhigHcab+byztPRqT+CQJ4OqbgHq64vTf7QtfNC0HkVGMBiXySyQZtTDcA4rd/EGiCQylwtVdRApmUcYpCUjCDY0NLjPvVLLUiBSI0TQ1tamslIsrr+/1YJRbjuZUEZXb2kJGcWLUaf0BOJBTLTDEADd9vXrV5Vum9aBXhsBV3b09Xi8Xq9H9Dud/lWRAiBgMjp9LNaTTD5Q7FCK+fl5GdMcX77MqHbgp/z1Xay/v5/Dh2bo8OGAAiRJhVykilsMpEtIALRmv//TSrcNQ48eDdOCqmFcTU2N9x3LEpQnRIM+b97kuDQogzrAo+HhG2xMpITjHnuW18n/1atXKBOeATUUcyeNc4uOmz6p1JgKXzqdvn79GgvRB9FWvEkwDDg2oXFMEiSM21PjDFUV42xIpqupVoB778tBDsA7SZL7GcAykIUCwtndX9+nQW06EkuUM5dVWKs8gI/ok8ua/VvJAmeBs8BZ4KxZ4CxwFrj/nf0twABzpDtilUZLhAAAAABJRU5ErkJggg=="
                },
                new Images
                {
                    name = "3.3",
                    content =
                        "iVBORw0KGgoAAAANSUhEUgAAACEAAAAeCAIAAAAtquBAAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAA2hpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDUuMy1jMDExIDY2LjE0NTY2MSwgMjAxMi8wMi8wNi0xNDo1NjoyNyAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wTU09Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9tbS8iIHhtbG5zOnN0UmVmPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvc1R5cGUvUmVzb3VyY2VSZWYjIiB4bWxuczp4bXA9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC8iIHhtcE1NOk9yaWdpbmFsRG9jdW1lbnRJRD0ieG1wLmRpZDowMTgwMTE3NDA3MjA2ODExQTFFM0Q0RkI2NURCQTNBQSIgeG1wTU06RG9jdW1lbnRJRD0ieG1wLmRpZDo5NEVDMzU3RkNBQzQxMUU1OEVBMkJBMEM4NjQ5QjQ4NCIgeG1wTU06SW5zdGFuY2VJRD0ieG1wLmlpZDo5NEVDMzU3RUNBQzQxMUU1OEVBMkJBMEM4NjQ5QjQ4NCIgeG1wOkNyZWF0b3JUb29sPSJBZG9iZSBQaG90b3Nob3AgQ1M1LjEgTWFjaW50b3NoIj4gPHhtcE1NOkRlcml2ZWRGcm9tIHN0UmVmOmluc3RhbmNlSUQ9InhtcC5paWQ6RTA3NDlGRTEyRjIwNjgxMTgwQkFFMjFGRkE5QTgyQkUiIHN0UmVmOmRvY3VtZW50SUQ9InhtcC5kaWQ6MDE4MDExNzQwNzIwNjgxMUExRTNENEZCNjVEQkEzQUEiLz4gPC9yZGY6RGVzY3JpcHRpb24+IDwvcmRmOlJERj4gPC94OnhtcG1ldGE+IDw/eHBhY2tldCBlbmQ9InIiPz6foeb1AAADQklEQVR42pyWTW/aQBCG48VgPhqFUA4IpCZIkdL/kPz79NpcaSGJClKkKIeQQx2wSew+3inbZXGNYQ7gj9155515Z9ZeGC6OSliaph9r41qeeZ6qrM3zvP/t9ct4j+P4/f09TRP9wPaVxPEHf0p5vl+t1Wq5SDswcL1cLpIkrVRUtVojXoU/yxG0WMNPFEWr1aper/u+69MryNVyuWQnbuv1RnE24AoAi5MkASYIglI8FosFKYI+G4i9mC7wrCSOSBuQIO3AgAEA2xEVGxjNZnOpDVSzNwdDWAfajvY3IiNjOskVqY2bBF4The9XDgMQazQaKAM/onIXgxTxIgjqBRXeabo8AeEiOTdX8tRwNPb29vb8/LxaxSgVHUsbShAiZa3saqfzud1uyxZu48wi3/ElbQxT+2EY/r65+Tad/iIC8S4ZEBhMaeOi0+lcXV0PBgOhgnNKyxZlaxwSssHGmE5nk8kkDEPd6qnQ5UIpOkYZ9hR5NpuNxz+5/SsnTSDzaWMQqCZesTFeX+c8lzkh1mq1UAS9LfGKyQiYz+cGQ8hx69sYmv7GqJBhBV8BhgaRXFxc9Pv90Wj0+PgIJVsc1MuuPK/wUGomOrqgYJeXX8/Phw8PD7e3319eXiQs+XXW52i3vOGL9DgS525b9A4PL1fszsBglN3dTUajH4jNiHgNnMPjHwYlYr/ugMRIS4addZv93N/fj8djlKbrvCEQBoSBFPlt9IcoHUXbGNjJSZumpPIslv14Zw1dpnmnJnYeHh8fm70aI+OtnDzITLQfnp19GQ6HTDrZLNJkpWhdupJXRNDr9dCCwSAsQsoUbJ9RrGZssLfV+mRnmVZ/enqKotj0uWl1tbZarXp62ul2u+YApWwy7d1zkHfAHDzY7RGHK7rVzZUkAdYMBhmZhxl7STgFk+SrbaXq1DP9F2TmAAB2QQLv5rjN6UGS22g0Sbjw3ZeBBlBZGdYVVQUns6SVvJVse4qMrHFNiLb6i759YM15KacWnUidcj9QUPMqM77zsvFsVF4Kw3w4yQGsZ5GSTpQRIqeWCJoO53w1fboHhokU00jJujOOzKjVSvS3D7c9vndFBTLNdG87J4S38wvvjwADAKMvabyHbMj+AAAAAElFTkSuQmCC"
                }
            };

            images.ForEach(x => x.type = "image/png");

            return images;
        }

        #endregion

        public ActionResult MailOptIn()
        {
            return View();
        }

        [HttpPost]
        public JsonResult ConsultarAdjuntoImageSource(string nombreArchivo, int tipo)
        {
            var model = new Tuple<string, string, int>(CodigoISO, nombreArchivo, tipo);
            Dictionary<int, string> configKeys = new Dictionary<int, string> {
                {1, AppSettingsKeys.DocumentosIdentidadStorage}, {2, AppSettingsKeys.DocumentosDomicilioStorage},
                {3, AppSettingsKeys.DocumentosContratoStorage }, {4, AppSettingsKeys.DocumentosPagareStorage},
                {5, AppSettingsKeys.DocumentosAvalStorage     }, {6, AppSettingsKeys.ContenedoraReciboOtraMarca},
                {7, AppSettingsKeys.ContenedoraReciboPagoAval }, {8, AppSettingsKeys.ContenedoraCreditoAval}
            };
            string configKey = configKeys.ContainsKey(model.Item3) ? configKeys[model.Item3] : AppSettingsKeys.ContenedoraConstanciaLaboralAval;

            var result = ConfigS3.GetUrlFileS3WithAuthentication(string.Format(
                ConfigurationManager.AppSettings[configKey], model.Item1, model.Item2
            ));

            return Json(result, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult ConsultarTerritorios(decimal latitud, decimal longitud)
        {
            var model = new ConsultarUbicacionModel();

            var obtenerTerritorioPorPuntoResult = ConsultarServicio(new
            {
                punto = new
                {
                    Latitud = latitud,
                    Longitud = longitud
                },
                pais = CodigoISO,
                aplicacion = 1
            }, "ObtenerTerritorioPorPunto").SelectToken("ObtenerTerritorioPorPuntoResult");

            if (obtenerTerritorioPorPuntoResult.HasValues &&
                obtenerTerritorioPorPuntoResult.SelectToken("MensajeRespuesta").ToObject<string>() == "OK")
            {
                var resultado = obtenerTerritorioPorPuntoResult.SelectToken("Resultado").ToObject<string>();

                model.Region = resultado.Substring(0, 2);
                model.Zona = resultado.Substring(2, 4);
                model.Seccion = resultado.Substring(6, 1);
                model.Territorio = resultado.Substring(7, resultado.Length - 7);

                // 2. Buscamos los vertices por territorio
                var obtenerVerticesTerritorioPorCodigoResult = ConsultarServicio(new
                {
                    codigo = resultado,
                    pais = CodigoISO,
                    aplicacion = 1
                }, "ObtenerVerticesTerritorioPorCodigo").SelectToken("ObtenerVerticesTerritorioPorCodigoResult");

                if (obtenerVerticesTerritorioPorCodigoResult.HasValues &&
                    obtenerVerticesTerritorioPorCodigoResult.SelectToken("MensajeRespuesta").ToObject<string>() == "OK")
                {
                    model.Vertices =
                        obtenerVerticesTerritorioPorCodigoResult.SelectToken("Resultado")
                            .ToObject<JValue>()
                            .Value.ToString();
                    model.Vertices = model.Vertices.Replace("Lat", "lat").Replace("Long", "lng");
                }
            }

            return Json(model, JsonRequestBehavior.AllowGet);
        }

        public ActionResult ConsultarUbicacionCL(int id)
        {
            ViewBag.HTMLSACUnete = getHTMLSACUnete("ConsultarUbicacionCL", "&id=" + id.ToString());
            return PartialView("_ConsultarUbicacionCL");

        }

        public ActionResult NivelesRiesgo()
        {
            ViewBag.HTMLSACUnete = getHTMLSACUnete("NivelesRiesgo", null);
            return View();
        }

        [HttpPost]
        public JsonResult ConsultarNivelesRiesgo(NivelesRiesgoModelSAC model)
        {
            model.CodigoISO = CodigoISO;
            using (var sv = new PortalServiceClient())
            {
                var data = sv.ConsultarNivelesRiesgo(model);
                return Json(data, JsonRequestBehavior.AllowGet);
            }

        }

        public ActionResult ExportarExcelNivelRiesgo()
        {
            ServiceUnete.ParametroUneteCollection lstSelect;
            using (var sv = new PortalServiceClient())
            {
                lstSelect = sv.ObtenerParametrosUnete(CodigoISO, EnumsTipoParametro.TipoNivelesRiesgo, 0);
            }

            List<NivelesRiesgoModel> items = new List<NivelesRiesgoModel>();
            foreach (var item in lstSelect)
            {
                var objNivel = new NivelesRiesgoModel
                {
                    NivelRiesgo = item.Descripcion,
                    ZonaSeccion = item.Nombre
                };
                items.Add(objNivel);
            }

            Dictionary<string, string> dic =
                new Dictionary<string, string> { { "ZonaSeccion", "ZonaSeccion" }, { "NivelRiesgo", "NivelRiesgo" } };

            Util.ExportToExcel("ReporteNivelesRiesgo", items, dic);
            return View();
        }

        public ActionResult NivelesGeograficos()
        {
            ViewBag.HTMLSACUnete = getHTMLSACUnete("NivelesGeograficos", null);
            return View();
        }

        public ActionResult ExportarExcelNivelGeograficos()
        {
            UbigeoTemplateCollection lstSelect;

            using (var sv = new PortalServiceClient())
            {
                lstSelect = sv.ObtenerListaNivelesGeograficosGeneral(CodigoISO);
            }

            List<NivelesGeograficosModel> items = new List<NivelesGeograficosModel>();
            NivelesGeograficosModel objNivel;

            #region "NuevoBlucle"

            if (CodigoISO == Pais.CostaRica)
            {
                foreach (var item in lstSelect)
                {
                    var crItem = (UbigeoCR)item;

                    objNivel = new NivelesGeograficosModel
                    {

                        BARRIO_COLONIA_URBANIZACION_BARRIADAS_REFERENCIAS =
                            crItem.BARRIO_COLONIA_URBANIZACION_BARRIADAS_REFERENCIAS,
                        CANTON = crItem.CANTON,
                        DISTRITO = crItem.DISTRITO,
                        PROVINCIA = crItem.PROVINCIA,
                        REG = crItem.REG,
                        SECC = crItem.SECC,
                        TERRITO = crItem.TERRITO,
                        UBIGEO = crItem.UBIGEO,
                        ZONA = crItem.ZONA
                    };
                    items.Add(objNivel);
                }
            }
            else if (CodigoISO == Pais.Panama)
            {
                foreach (var item in lstSelect)
                {
                    var crItem = (UbigeoPA)item;

                    objNivel = new NivelesGeograficosModel
                    {

                        BARRIO_COLONIA_URBANIZACION_REFERENCIAS = crItem.BARRIO_COLONIA_URBANIZACION_REFERENCIAS,
                        CORREGIMIENTO = crItem.CORREGIMIENTO,
                        DISTRITO = crItem.DISTRITO,
                        PROVINCIA = crItem.PROVINCIA,
                        REG = crItem.REG,
                        SECC = crItem.SECC,
                        TERRITO = crItem.TERRITO,
                        UBIGEO = crItem.UBIGEO,
                        ZONA = crItem.ZONA
                    };
                    items.Add(objNivel);
                }
            }
            else if (CodigoISO == Pais.Guatemala)
            {
                foreach (var item in lstSelect)
                {
                    var crItem = (UbigeoGT)item;

                    objNivel = new NivelesGeograficosModel
                    {
                        BARRIO_COLONIA_URBANIZACION_ALDEA_REFERENCIAS =
                            crItem.BARRIO_COLONIA_URBANIZACION_ALDEA_REFERENCIAS,
                        DEPARTAMENTO = crItem.DEPARTAMENTO,
                        MUNICIPIO = crItem.MUNICIPIO,
                        CENTRO_POBLADO = crItem.CENTRO_POBLADO,
                        ZONA_CIUDAD = crItem.ZONA_CIUDAD,
                        REG = crItem.REG,
                        SECC = crItem.SECC,
                        TERRITO = crItem.TERRITO,
                        UBIGEO = crItem.UBIGEO,
                        ZONA = crItem.ZONA
                    };
                    items.Add(objNivel);
                }
            }
            else if (CodigoISO == Pais.Salvador)
            {
                foreach (var item in lstSelect)
                {
                    var crItem = (UbigeoSV)item;

                    objNivel = new NivelesGeograficosModel
                    {
                        BARRIO_COLONIA_URBANIZACION_REFERENCIAS = crItem.BARRIO_COLONIA_URBANIZACION_REFERENCIAS,
                        DEPARTAMENTO = crItem.DEPARTAMENTO,
                        MUNICIPIO = crItem.MUNICIPIO,
                        CANTON_CENTRO_POBLADO = crItem.CANTON_CENTRO_POBLADO,
                        REG = crItem.REG,
                        SECC = crItem.SECC,
                        TERRITO = crItem.TERRITO,
                        UBIGEO = crItem.UBIGEO,
                        ZONA = crItem.ZONA
                    };
                    items.Add(objNivel);
                }
            }

            #endregion

            Dictionary<string, string> dic = new Dictionary<string, string>
            {
                {"REG", "REG"},
                {"ZONA", "ZONA"},
                {"SECC", "SECC"},
                {"TERRITO", "TERRITO"},
                {"UBIGEO", "UBIGEO"},
            };

            switch (CodigoISO)
            {
                case Pais.CostaRica:
                    dic.Add("PROVINCIA", "PROVINCIA");
                    dic.Add("CANTON", "CANTON");
                    dic.Add("DISTRITO", "DISTRITO");
                    dic.Add("BARRIO_COLONIA_URBANIZACION_BARRIADAS_REFERENCIAS",
                        "BARRIO_COLONIA_URBANIZACION_BARRIADAS_REFERENCIAS");
                    break;
                case Pais.Panama:
                    dic.Add("PROVINCIA", "PROVINCIA");
                    dic.Add("CORREGIMIENTO", "CORREGIMIENTO");
                    dic.Add("DISTRITO", "DISTRITO");
                    dic.Add("BARRIO_COLONIA_URBANIZACION_REFERENCIAS", "BARRIO_COLONIA_URBANIZACION_REFERENCIAS");
                    break;
                case Pais.Guatemala:
                    dic.Add("DEPARTAMENTO", "DEPARTAMENTO");
                    dic.Add("ZONA_CIUDAD", "ZONA_CIUDAD");
                    dic.Add("MUNICIPIO", "MUNICIPIO");
                    dic.Add("CENTRO_POBLADO", "CENTRO_POBLADO");
                    dic.Add("BARRIO_COLONIA_URBANIZACION_ALDEA_REFERENCIAS",
                        "BARRIO_COLONIA_URBANIZACION_ALDEA_REFERENCIAS");
                    break;
                case Pais.Salvador:
                    dic.Add("DEPARTAMENTO", "DEPARTAMENTO");
                    dic.Add("MUNICIPIO", "MUNICIPIO");
                    dic.Add("CANTON_CENTRO_POBLADO", "CANTON_CENTRO_POBLADO");
                    dic.Add("BARRIO_COLONIA_URBANIZACION_REFERENCIAS", "BARRIO_COLONIA_URBANIZACION_REFERENCIAS");
                    break;
            }

            Util.ExportToExcel("ReporteNivelesGeograficos", items, dic);
            return View();
        }

        [HttpPost]
        public JsonResult ConsultarNivelesGeograficos(NivelesGeograficosModelSAC model)
        {
            model.CodigoISO = CodigoISO;
            using (var sv = new PortalServiceClient())
            {
                var data = sv.ConsultarNivelesGeograficos(model);
                return Json(data, JsonRequestBehavior.AllowGet);
            }
        }

        public ActionResult ExportarExcel(int PrefijoISOPais, string FechaDesde, string FechaHasta, string Nombre,
            int Estado, string DocumentoIdentidad, string codigoZona, string CodigoRegion, string FuenteIngreso,
            int MostrarPaso1y2SE = 1, int PaginaActual = 1)
        {

            using (var sv = new PortalServiceClient())
            {

                var solicitudes = sv.ObtenerReporteGestionPostulante(PrefijoISOPais, FechaDesde,
                       FechaHasta, Nombre,
                       Estado, DocumentoIdentidad, codigoZona, CodigoRegion, FuenteIngreso, CodigoISO,
                       MostrarPaso1y2SE, PaginaActual).ToList();

                Dictionary<string, string> dic = sv.GetDictionaryReporteGestionPostulantes(CodigoISO, Estado);

                MemoryStream workbook = new MemoryStream();

                workbook = ExcelExportHelper.ExportarExcel("Reporte_GestionaPostulante", "GestionaPostulante", dic, solicitudes);
                string saveAsFileName = "Reporte_GestionaPostulante" + DateTime.Now.ToString("ddMMyyyy_HHmmss") + ".xlsx";

                return File(workbook.ToArray(), "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", string.Format("{0}", saveAsFileName));
            }
         
        }                   

        public Dictionary<string, string> GetDictionaryReporteGestionPostulantes(string CodigoISO, int Estado)
        {
            using (var sv = new PortalServiceClient())
            {
                Dictionary<string, string> dic = sv.GetDictionaryReporteGestionPostulantes(CodigoISO, Estado);

                return dic;
            }
        }

        [HttpPost]
        public JsonResult ProcesarParametro(GestionValidacionesParameter model)
        {
            model.CodigoISO = CodigoISO;
            bool resultado;
            model.ListaZonasTelefonicasActivas = model.ListaZonasTelefonicasActivas ?? new List<HojaInscripcionBelcorpPais.ParametroUneteBE>();
            model.ListaZonasTelefonicasInactivas = model.ListaZonasTelefonicasInactivas ?? new List<HojaInscripcionBelcorpPais.ParametroUneteBE>();
            using (var sv = new BelcorpPaisServiceClient())
            {
                resultado = sv.ActualizarValidacionesUnete(model.CodigoISO, model);
            }
            return Json(resultado, JsonRequestBehavior.AllowGet);

        }

        public ActionResult GestionParametros()
        {
            ViewBag.HTMLSACUnete = getHTMLSACUnete("GestionParametros", null);
            return View("GestionParametros");
        }

        public ActionResult DevolverSolicitud(int id)
        {
            ViewBag.HTMLSACUnete = getHTMLSACUnete("DevolverSolicitud", "&id=" + id);
            return PartialView("_DevolverSolicitud");
        }

        public ActionResult MotivoRechazoGZ()
        {
            ViewBag.HTMLSACUnete = getHTMLSACUnete("MotivoRechazoGZ", null);
            return PartialView("_MotivoRechazo");
        }

        public ActionResult ErrorGenerandoCodigo(string NumeroDocumento)
        {
            ViewBag.HTMLSACUnete = getHTMLSACUnete("ErrorGenerandoCodigo", "&numeroDocumento=" + NumeroDocumento);
            return PartialView("_Message");
        }

        public ActionResult ErrorLog(string NumeroDocumento)
        {
            ViewBag.HTMLSACUnete = getHTMLSACUnete("ErrorLog", "&numeroDocumento=" + NumeroDocumento);
            return PartialView("_Message");
        }

        [HttpPost]
        public ActionResult DevolverSolicitud(int id, string observacion)
        {
            var response = getHTMLSACUnete("DevolverSolicitud", "&id=" + id + "&observacion=" + observacion);
            RegistrarLogGestionSacUnete(id.ToString(), "GESTIONA POSTULANTE", "DEVOLVER");
            return Json(response == "true", JsonRequestBehavior.AllowGet);
        }

        public ActionResult ReactivarPostulante(int id)
        {
            ViewBag.HTMLSACUnete = getHTMLSACUnete("ReactivarPostulante", "&id=" + id);
            return PartialView("_ReactivarPostulante");
        }

        [HttpPost]
        public JsonResult ReactivarPostulante(string id)
        {
            var response = getHTMLSACUnete("ReactivarPostulante2", "&id=" + id);
            RegistrarLogGestionSacUnete(id.ToString(), "GESTIONA POSTULANTE", "REACTIVAR");
            return Json(response == "true", JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public ActionResult RechazarPostulante(RechazoModel model)
        {
            var response = PostHTMLSACUnete("RechazarPostulante", model);
            RegistrarLogGestionSacUnete(model.SolicitudPostulanteID.ToString(), "GESTIONA POSTULANTE", "RECHAZAR");
            return Json(response == "true", JsonRequestBehavior.AllowGet);

        }

        public ActionResult RechazarPostulante(int id, string nombre)
        {
            ViewBag.HTMLSACUnete = getHTMLSACUnete("RechazarPostulante", "&id=" + id + "&nombre=" + nombre);
            return PartialView("_RechazarPostulante");
        }

        public ActionResult ResumenDiasEspera(int id, string diasEsperaTotal)
        {
            ViewBag.HTMLSACUnete = getHTMLSACUnete("ResumenDiasEspera", "&id=" + id + "&diasEsperaTotal=" + diasEsperaTotal);
            return PartialView("_ResumenDiasEspera");
        }

        [HttpPost]
        public string ValidarCelularExiste(string Celular, int SolicitudPostulanteId)
        {
            var response = getHTMLSACUnete("ValidarCelularExiste",
                "&Celular=" + Celular + "&SolicitudPostulanteId=" + SolicitudPostulanteId);
            return response;
        }

        [HttpPost]
        public string ValidarEdad(string fechaNacimiento, string codigoISO)
        {
            var response = getHTMLSACUnete("ValidarEdad",
                "&fechaNacimiento=" + fechaNacimiento + "&codigoISO=" + codigoISO);
            return response;

        }

        [HttpPost]
        public JsonResult ConsultarUbicacion(int id, decimal latitud,
            decimal longitud, string direccionCorrecta, string direccionCadena, string region, string comuna,
            string codregion, string codzona, string codseccion, string codterritorio, string direccion)
        {
            var response = getHTMLSACUnete("ConsultarUbicacion2", "&id=" + id +
                                                                  "&latitud=" + latitud +
                                                                  "&longitud=" + longitud +
                                                                  "&direccionCorrecta=" + direccionCorrecta +
                                                                  "&direccionCadena=" + direccionCadena +
                                                                  "&region=" + region +
                                                                  "&comuna=" + comuna +
                                                                  "&codregion=" + codregion +
                                                                  "&codzona=" + codzona +
                                                                  "&codseccion=" + codseccion +
                                                                  "&codterritorio=" + codterritorio +
                                                                  "&direccion=" + direccion
            );
            RegistrarLogGestionSacUnete(id.ToString(), "CONSULTAR UBICACION", "GRABAR POSICION");
            return Json(response == "true", JsonRequestBehavior.AllowGet);
        }

        public string ObtenerZonas(int regionId)
        {
            var jsonResponse = getHTMLSACUnete("ObtenerZonas", "&regionID=" + regionId);
            return jsonResponse;
        }

        public string ObtenerSecciones(int regionId, int zonaId)
        {
            var jsonResponse = getHTMLSACUnete("ObtenerSecciones", "&regionID=" + regionId + "&zonaID=" + zonaId);
            return jsonResponse;
        }

        public string ObtenerTerritorios(int regionId, int zonaId, int seccionId)
        {
            var jsonResponse = getHTMLSACUnete("ObtenerTerritorios",
                "&regionID=" + regionId + "&zonaID=" + zonaId + "&seccionID=" + seccionId);
            return jsonResponse;
        }

        public ActionResult EditarDireccionManualmente(int id)
        {
            ViewBag.HTMLSACUnete = getHTMLSACUnete("EditarDireccionManualmente", "&id=" + id);
            return PartialView("_EditarDireccionManualmente");
        }

        [HttpPost]
        public ActionResult EditarDireccionManualmente(EditarDireccionManualmenteModel model)
        {
            ViewBag.HTMLSACUnete = PostHTMLSACUnete("EditarDireccionManualmente", model);
            RegistrarLogGestionSacUnete(model.SolicitudPostulanteID.ToString(), "CONSULTAR UBICACION", "EDITAR DIRECCION MANUALMENTE");
            return PartialView("_EditarDireccionManualmente");
        }

        public ActionResult VerHistorialPostulante(int id, string nombre, string FechaRegistro)
        {
            ViewBag.HTMLSACUnete = getHTMLSACUnete("VerHistorialPostulante",
                "&id=" + id + "&nombre=" + nombre + "&FechaRegistro=" + FechaRegistro);
            return PartialView("_HistorialPostulante");
        }

        public ActionResult Detalle(int id, bool modoLectura)
        {
            ViewBag.HTMLSACUnete = getHTMLSACUnete("Detalle", "&id=" + id + "&modoLectura=" + modoLectura);
            return PartialView("_Detalle");
        }

        [HttpPost]
        public ActionResult Detalle(DetalleSolicitudPostulanteModel model)
        {
            ViewBag.HTMLSACUnete = PostHTMLSACUnete("Detalle", model);

            if (ViewBag.HTMLSACUnete == "{\"success\":true}")
            {
                RegistrarLogGestionSacUnete(model.SolicitudPostulanteID.ToString(), "EDITAR POSTULANTE", "EDITAR");
                return Json(new { success = true }, JsonRequestBehavior.AllowGet);
            }
            else
            {
                return PartialView("_Detalle");
            }
        }

        public ActionResult ConsultarEstadoCrediticia(int id)
        {
            ViewBag.HTMLSACUnete = getHTMLSACUnete("ConsultarEstadoCrediticia", "&id=" + id);
            return PartialView("_ConsultarEstadoCrediticia");
        }

        [HttpPost]
        public JsonResult ConsultarEstadoCrediticia(int id, int idEstado)
        {
            bool actualizado;
            using (var sv = new PortalServiceClient())
            {
                actualizado = sv.ActualizarEstado(CodigoISO, id, EnumsTipoParametro.EstadoBurocrediticio, idEstado);
            }
            RegistrarLogGestionSacUnete(id.ToString(), "CONSULTA CREDITICIA", "ASIGNAR");
            return Json(actualizado, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public ActionResult GrabarDatosDireccion(EditarDireccionModel model)
        {
            ViewBag.HTMLSACUnete = PostHTMLSACUnete("GrabarDatosDireccion", model);

            RegistrarLogGestionSacUnete(model.SolicitudPostulanteID.ToString(), "CONSULTAR UBICACION", "GRABAR DIRECCION");
            return PartialView("_TemplateMensaje");
        }

        public ActionResult ConfirmarPosicion(int id, decimal latitud,
            decimal longitud, string direccionCorrecta, string direccionCadena, string region, string comuna,
            string codregion, string codzona, string codseccion, string codterritorio, string direccion)
        {
            ViewBag.HTMLSACUnete = getHTMLSACUnete("ConfirmarPosicion",
                "&id=" + id +
                "&latitud=" + latitud +
                "&longitud=" + longitud +
                "&direccionCorrecta=" + direccionCorrecta +
                "&direccionCadena=" + direccionCadena +
                "&region=" + region +
                "&comuna=" + comuna +
                "&codregion=" + codregion +
                "&codzona=" + codzona +
                "&codseccion=" + codseccion +
                "&codterritorio=" + codterritorio +
                "&direccion=" + direccion);

            return PartialView("_ConfirmarPosicion");
        }

        public ActionResult EditarDireccion(int id)
        {
            ViewBag.HTMLSACUnete = getHTMLSACUnete("EditarDireccion", "&id=" + id);
            return PartialView("_EditarDireccion");
        }

        [HttpPost]
        public ActionResult EditarDireccion(EditarDireccionModel model)
        {
            ViewBag.HTMLSACUnete = PostHTMLSACUnete("EditarDireccion", model);

            return PartialView("_EditarDireccion");
        }

        private JObject ConsultarServicio(object data, string metodo)
        {
            var urlWsgeo = _configuracionManagerProvider.GetConfiguracionManager(Constantes.ConfiguracionManager.WSGEO_Url);
            var bytes = Encoding.UTF8.GetBytes(JsonConvert.SerializeObject(data));

            var url = string.Format("{0}/{1}", urlWsgeo, metodo);
            var request = WebRequest.Create(url) as HttpWebRequest;
            request.Method = "POST";
            request.ContentType = "application/json";
            request.ContentLength = bytes.Length;
            request.Proxy = null;

            using (var stream = request.GetRequestStream())
            {
                stream.Write(bytes, 0, bytes.Length);
            }

            using (var response = (HttpWebResponse)request.GetResponse())
            {
                var result = new StreamReader(response.GetResponseStream()).ReadToEnd();
                return JsonConvert.DeserializeObject(result) as JObject;
            }
        }

        public ActionResult ConsultarUbicacion(int id, string nombreCompleto, string celular,
            string pintarMalaZonificacion)
        {
            ViewBag.HTMLSACUnete = getHTMLSACUnete("ConsultarUbicacion",
                "&id=" + id + "&nombreCompleto=" + nombreCompleto + "&celular=" + celular + "&pintarMalaZonificacion=" +
                pintarMalaZonificacion);
            return PartialView("_ConsultarUbicacion");
        }

        public ActionResult GestionaPostulante()
        {
            var nombreRol = UserData().RolDescripcion;
            ViewBag.HTMLSACUnete = getHTMLSACUnete("GestionaPostulante", "&rol=" + nombreRol);
            return View();
        }

        [HttpPost]
        public JsonResult ConsultarSolicitudesPostulanteV2(GestionaPostulanteModelSAC model)
        {
            var result = new paginacionGrid();
            try
            {
                model.CodigoIso = CodigoISO;
                using (var sv = new PortalServiceClient())
                {
                    result = sv.ConsultarSolicitudesPostulanteV2(model);
                }
            }
            catch (Exception ex)
            {
                ErrorUtilities.AddLog(ex);
            }

            return Json(result, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult GetReporteFunnelSearch(string CampaniaInicio, string CampaniaFin)
        {
            var result = GetReporteFunnel(CampaniaInicio, CampaniaFin);
            return Json(result, JsonRequestBehavior.AllowGet);
        }

        public List<ReporteFunnel> GetReporteFunnel(string CampaniaInicio, string CampaniaFin)
        {
            var result = new List<ReporteFunnel>();
            try
            {
                using (var sv = new PortalServiceClient())
                {
                    result = sv.GetReporteFunnel(CampaniaInicio, CampaniaFin, CodigoISO).ToList();
                }
            }
            catch (Exception ex)
            {
                ErrorUtilities.AddLog(ex);

            }

            return result;
        }

        public ActionResult ExportarExcelFunnel(string CampaniaInicio, string CampaniaFin, string ReporteNombre)
        {
            var solicitudes = GetReporteFunnel(CampaniaInicio, CampaniaFin);

            Dictionary<string, string> dic;

            using (var sv = new PortalServiceClient())
            {
                dic = sv.GetDictionaryReporteFunnel();
            }

            Util.ExportToExcel(ReporteNombre, solicitudes, dic);
            return View();
        }

        public ActionResult ReporteFunnel()
        {
            ViewBag.ipRequest = Request.UserHostAddress;
            ViewBag.HTMLSACUnete = getHTMLSACUnete("ReporteFunnel", null);
            return View();
        }


        [HttpPost]
        public JsonResult GetReporteRolSearch(string pais, string rol, string usuario, string solicitud, string fechaInicio, string fechaFin, string lastKeyUsuario, string lastKeyFecha, int registrosPagina)
        {
            ReporteRol result = new ReporteRol();
            try
            {
                result = GetReporteRol(pais, rol, usuario, solicitud, fechaInicio, fechaFin, lastKeyUsuario, lastKeyFecha, registrosPagina);
            }
            catch (Exception ex)
            {
                ErrorUtilities.AddLog(ex);
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }

        public ReporteRol GetReporteRol(string pais, string rol, string usuario, string solicitud, string fechaInicio, string fechaFin, string lastKeyUsuario, string lastKeyFecha, int registrosPagina)
        {

            ReporteRol reporte = new ReporteRol();

            try
            {
                var result = getHTMLSACUnete("GetJsonReporteRol", String.Format("&pais={0}&rol={1}&usuario={2}&solicitud={3}&fechaInicio={4}&fechaFin={5}&lastKeyUsuario={6}&lastKeyFecha={7}&registrosPagina={8}",
                                                                                 pais, rol, usuario, solicitud, fechaInicio, fechaFin, lastKeyUsuario, lastKeyFecha, registrosPagina));
                if (result.Length > 0)
                {
                    reporte = JsonConvert.DeserializeObject<ReporteRol>(result);
                }
            }
            catch (Exception ex)
            {
                ErrorUtilities.AddLog(ex);
            }

            return reporte;
        }

        public ActionResult ExportarExcelRol(string pais, string rol, string usuario, string solicitud, string fechaInicio, string fechaFin, string lastKeyUsuario, string lastKeyFecha, int registrosPagina, string ReporteNombre)
        {
            ReporteRol result = new ReporteRol();
            try
            {
                result = GetReporteRol(pais, rol, usuario, solicitud, fechaInicio, fechaFin, lastKeyUsuario, lastKeyFecha, registrosPagina);
            }
            catch (Exception ex)
            {
                ErrorUtilities.AddLog(ex);
            }

            Dictionary<string, string> dic = new Dictionary<string, string>();

            dic.Add("Fecha de Registro", "FechaRegistro");
            dic.Add("Usuario", "Usuario");
            dic.Add("Pais", "Pais");
            dic.Add("Rol", "Rol");
            dic.Add("Solicitud Id", "SolicitudId");
            dic.Add("Pantalla", "Pantalla");
            dic.Add("Acción", "Accion");
            dic.Add("Fecha de Expiración", "FechaExpiracion");

            if (result.data.Count > 0)
            {
                Util.ExportToExcel(ReporteNombre, result.data, dic);
            }

            return View();
        }

        public JsonResult GetRoles()
        {
            var result = new List<RolLog>();
            try
            {
                using (var sv = new PortalServiceClient())
                {
                    result = sv.GetRoles(CodigoISO).ToList();
                }
            }
            catch (Exception ex)
            {
                ErrorUtilities.AddLog(ex);

            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetUsuariosPorRol(int RolId)
        {
            var result = new List<UsuarioRolLog>();
            try
            {
                using (var sv = new PortalServiceClient())
                {
                    result = sv.GetUsuariosPorRol(CodigoISO, RolId).ToList();
                }
            }
            catch (Exception ex)
            {
                ErrorUtilities.AddLog(ex);

            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }

        public ActionResult ReporteRol()
        {
            ViewBag.HTMLSACUnete = getHTMLSACUnete("ReporteRol", null);
            return View();
        }

        public ActionResult ExportarExcelReporteConsolidado(string PrefijoISOPais, string FechaDesde, string FechaHasta,
            string Region, string Zona, string Seccion, string NombreReporte)
        {
            using (var sv = new PortalServiceClient())
            {
                List<ReporteConsolidadoBE> resultado = sv.ObtenerReporteConsolidadoFiltro(
                    new ReporteConsolidadoModelSAC()
                    {
                        CodigoIso = CodigoISO,
                        FechaDesde = FechaDesde,
                        FechaHasta = FechaHasta,
                        Zona = Zona,
                        Region = Region,
                        Seccion = Seccion
                    }).ToList();

                Dictionary<string, string> dic = sv.GetDictionaryReporteConsolidado();
                Util.ExportToExcel(NombreReporte, resultado, dic);
                return null;
            }
        }

        private BEPager Paginador<T>(BEGrid item, List<T> lst)
        {
            BEPager pag = new BEPager();

            var recordCount = lst.Count;

            pag.RecordCount = recordCount;

            int pageCount = (int)(((float)recordCount / (float)item.PageSize) + 1);
            pag.PageCount = pageCount;

            int currentPage = item.CurrentPage;
            pag.CurrentPage = currentPage;

            if (currentPage > pageCount)
                pag.CurrentPage = pageCount;

            return pag;
        }

        [HttpPost]
        public JsonResult ConsultarReporteConsolidado(ReporteConsolidadoModelSAC model)
        {
            model.CodigoIso = CodigoISO;
            try
            {
                using (var sv = new PortalServiceClient())
                {
                    var data = sv.ConsultarReporteConsolidado(model);
                    return Json(data, JsonRequestBehavior.AllowGet);
                }
            }
            catch (Exception ex)
            {
                ErrorUtilities.AddLog(ex);
                return Json(new ReporteConsolidadoPag(), JsonRequestBehavior.AllowGet);
            }
        }

        public ActionResult ReporteConsolidado()
        {
            ViewBag.HTMLSACUnete = getHTMLSACUnete("ReporteConsolidado", null);
            return View(new ReporteConsolidadoModelSAC { CodigoIso = CodigoISO });
        }

        [HttpPost]
        public JsonResult GetReporteFuenteIngresoSearch(string CampaniaInicio, string CampaniaFin)
        {
            var result = GetReporteFuenteIngreso(CampaniaInicio, CampaniaFin);
            return Json(result, JsonRequestBehavior.AllowGet);
        }

        public ActionResult ReporteFuenteIngreso()
        {
            ViewBag.HTMLSACUnete = getHTMLSACUnete("ReporteFuenteIngreso", null);
            return View();
        }

        public List<ReporteFuenteIngreso> GetReporteFuenteIngreso(string campaniaInicio, string campaniaFin)
        {
            var result = new List<ReporteFuenteIngreso>();
            try
            {
                using (var sv = new PortalServiceClient())
                {
                    result = sv.GetReporteFuenteIngreso(campaniaInicio, campaniaFin, CodigoISO).ToList();
                }
            }
            catch (Exception ex)
            {
                ErrorUtilities.AddLog(ex);

            }

            return result;
        }

        public ActionResult ExportarExcelFuenteIngreso(string CampaniaInicio, string CampaniaFin, string NombreReporte)
        {

            var solicitudes = GetReporteFuenteIngreso(CampaniaInicio, CampaniaFin);

            Dictionary<string, string> dic;

            using (var sv = new PortalServiceClient())
            {
                dic = sv.GetDictionaryReporteFuenteIngreso();
            }

            Util.ExportToExcel(NombreReporte, solicitudes, dic);
            return new EmptyResult();
        }

        public string getHTMLSACUnete(string action, string urlParams)
        {
            string urlSacUente = _configuracionManagerProvider.GetConfiguracionManager(Constantes.ConfiguracionManager.UneteURL);
            string responseHtml = string.Empty;
            string url = string.Format("{0}/{1}?p={2}", urlSacUente, action, CodigoISO);

            if (urlParams != null)
            {
                url = url + urlParams;
            }

            try
            {
                var client = new HttpClient();
                responseHtml = client.GetStringAsync(url).Result;
            }
            catch (Exception ex)
            {
                ErrorUtilities.AddLog(ex);
            }

            return responseHtml;
        }

        public string PostHTMLSACUnete(string Action, object model)
        {
            var myContent = JsonConvert.SerializeObject(model);
            var buffer = System.Text.Encoding.UTF8.GetBytes(myContent);
            var byteContent = new ByteArrayContent(buffer);
            byteContent.Headers.ContentType = new System.Net.Http.Headers.MediaTypeHeaderValue("application/json");

            string urlSacUente = _configuracionManagerProvider.GetConfiguracionManager(Constantes.ConfiguracionManager.UneteURL);
            string responseHtml = string.Empty;
            string url = string.Format("{0}/{1}", urlSacUente, Action);

            try
            {
                var client = new HttpClient();
                var response = client.PostAsync(url, byteContent).Result;
                if (response.IsSuccessStatusCode)
                {
                    responseHtml = response.Content.ReadAsStringAsync().Result;
                }

            }
            catch (Exception ex)
            {

                ErrorUtilities.AddLog(ex);
            }

            return responseHtml;
        }
    }
}