using AutoMapper;
using ICSharpCode.SharpZipLib.Zip;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServiceZonificacion;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlTypes;
using System.IO;
using System.Linq;
using System.ServiceModel;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;
using static System.Net.Mime.MediaTypeNames;

namespace Portal.Consultoras.Web.Controllers
{
    public class ReporteConsultoraPedidoSACController : BaseAdmController
    {
        #region HD-4327
        string fechaDefault = "1/01/0001 00:00:00";
        public async Task<ActionResult> Index()
        {
            var reporteConsultoraPedidoSACModels = new ReporteConsultoraPedidoSACModels();
            var usuario = userData ?? new UsuarioModel();

            try
            {
                reporteConsultoraPedidoSACModels.listaPaises = await DropDowListPaises(usuario.PaisID);
                reporteConsultoraPedidoSACModels.listaCampania = ObtenerListCampaniasPorPaisOUsuario(usuario.PaisID);
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, usuario.CodigoConsultora, usuario.CodigoISO);
            }

            return View(reporteConsultoraPedidoSACModels);
        }
        private async Task<IEnumerable<PaisModel>> DropDowListPaises(int paisID)
        {
            using (var sv = new ZonificacionServiceClient())
            {
                var lst = await sv.SelectPaisesAsync();
                return Mapper.Map<IEnumerable<PaisModel>>(lst.Where(x => x.PaisID == paisID));
            }
        }

        public ActionResult ObtenerUltimaDescargaExitosa()
        {
            BEPedidoDescarga ultimaDescarga;
            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                ultimaDescarga = sv.ObtenerUltimaDescargaSinMarcar(userData.PaisID);
            }

            return Json(new
            {
                success = true,
                descarga = new
                {
                    CampaniaId = ultimaDescarga.CampaniaId == 0 ? "Ninguna" : ultimaDescarga.CampaniaId.ToString(),
                    DescripcionEstadoProcesoGeneral = ultimaDescarga.DescripcionEstadoProcesoGeneral.ToString(),
                    FechaProceso = ultimaDescarga.FechaProceso.ToString() == fechaDefault ? string.Empty : ultimaDescarga.FechaProceso.ToString(),
                }
            });
        }

        [HttpGet]
        public async Task<JsonResult> ObtenerUltimaDescargaPedidoSinMarcar(int campaniaID)
        {
            var usuario = userData ?? new UsuarioModel();
            try
            {
                var lst = new List<BEPedidoDescarga>();
                using (var srv = new PedidoServiceClient())
                {
                    var ultimaDescargaPedido = await srv.ObtenerUltimaDescargaPedidoSinMarcarAsync(usuario.PaisID, campaniaID);
                    lst.Add(ultimaDescargaPedido);
                }

                var data = new
                {
                    total = 1,
                    page = 1,
                    records = lst.Count,
                    rows = (from tbl in lst
                            select new
                            {
                                FechaHoraInicio = tbl.FechaHoraInicio.ToString() == fechaDefault ? string.Empty : tbl.FechaHoraInicio.ToString(),
                                FechaHoraFin = tbl.FechaHoraFin.ToString() == fechaDefault ? string.Empty : tbl.FechaHoraFin.ToString(),
                                Estado = tbl.Estado,
                                Mensaje = tbl.Mensaje,
                                NumeroPedidos = string.Format(" Web: {0}<br> DD: {1}", tbl.NumeroPedidosWeb, tbl.NumeroPedidosDD),
                                NroLote = tbl.NroLote,
                                estadoProcesoGeneral = tbl.EstadoProcesoGeneral
                            })
                };

                return Json(data, JsonRequestBehavior.AllowGet);
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, usuario.CodigoConsultora, usuario.CodigoISO);
            }

            return Json(null, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult DescargarArchivoClienteSinMarcar(int nroLote, int campaniaid)
        {
            BEDescargaArchivoSinMarcar objBEDescargaArchivoSinMarcar = new BEDescargaArchivoSinMarcar();
            string rutaDescargaArchivo = ConfigurationManager.AppSettings["OrderDownloadPath"];
            var usuario = userData ?? new UsuarioModel();

            try
            {
                using (var srv = new PedidoServiceClient())
                {
                    objBEDescargaArchivoSinMarcar = srv.DescargaPedidosSinMarcar(usuario.PaisID, campaniaid, nroLote, usuario.CodigoUsuario);
                }

                if (objBEDescargaArchivoSinMarcar.msnRespuesta == Constantes.MensajeProcesoDescargaregular.respuestaexito)
                {
                    var data = new
                    {
                        objPedidosCabWeb_ = FormateaPedidoCabWeb(objBEDescargaArchivoSinMarcar.headerTemplate, objBEDescargaArchivoSinMarcar.dtPedidosCabWeb, objBEDescargaArchivoSinMarcar.codigoPais, objBEDescargaArchivoSinMarcar.fechaProceso, objBEDescargaArchivoSinMarcar.fechaFacturacion, objBEDescargaArchivoSinMarcar.lote.ToString(), Constantes.MensajeProcesoDescargaregular.nombreArchivoCabWeb, Constantes.MensajeProcesoDescargaregular.origenWeb, campaniaid),
                        objPedidosDetWeb_ = FormateaPedidoDet(objBEDescargaArchivoSinMarcar.detailTemplate, objBEDescargaArchivoSinMarcar.dtPedidosDetWeb, objBEDescargaArchivoSinMarcar.codigoPais, objBEDescargaArchivoSinMarcar.fechaProceso, objBEDescargaArchivoSinMarcar.lote.ToString(), Constantes.MensajeProcesoDescargaregular.nombreArchivoDetWeb, Constantes.MensajeProcesoDescargaregular.origenWeb, campaniaid),
                        objPedidosCabDD_ = FormateaPedidoCabDD(objBEDescargaArchivoSinMarcar.headerTemplate, objBEDescargaArchivoSinMarcar.dtPedidosCabDD, objBEDescargaArchivoSinMarcar.codigoPais, objBEDescargaArchivoSinMarcar.fechaProceso, objBEDescargaArchivoSinMarcar.fechaFacturacion, objBEDescargaArchivoSinMarcar.lote.ToString(), Constantes.MensajeProcesoDescargaregular.nombreArchivoCabDD, Constantes.MensajeProcesoDescargaregular.origeDD, campaniaid),
                        objPedidosDetDD_ = FormateaPedidoDet(objBEDescargaArchivoSinMarcar.detailTemplate, objBEDescargaArchivoSinMarcar.dtPedidosDetDD, objBEDescargaArchivoSinMarcar.codigoPais, objBEDescargaArchivoSinMarcar.fechaProceso, objBEDescargaArchivoSinMarcar.lote.ToString(), Constantes.MensajeProcesoDescargaregular.nombreArchivoDetDD, Constantes.MensajeProcesoDescargaregular.origeDD, campaniaid),
                        msnRespuesta_ = objBEDescargaArchivoSinMarcar.msnRespuesta
                    };
                    return Json(data, JsonRequestBehavior.AllowGet);
                }
                else
                {
                    var data = new { msnRespuesta_ = objBEDescargaArchivoSinMarcar.msnRespuesta };
                    return Json(data, JsonRequestBehavior.AllowGet);
                }
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, usuario.CodigoConsultora, usuario.CodigoISO);

                return Json(new
                {
                    success = false,
                    mensaje = ex.Message,
                }, JsonRequestBehavior.AllowGet);
            }
        }


        public FileStreamResult CreateFile(string nameurl)
        {
            string sLine = string.Empty;
            ArrayList arrText = new ArrayList();
            BEDescargaArchivoSinMarcar objBEDescargaArchivoSinMarcar = new BEDescargaArchivoSinMarcar();

            StreamReader objReader = new StreamReader(nameurl);
            sLine = objReader.ReadToEnd();
            if (sLine != null)
                arrText.Add(sLine);
            objReader.Close();
            var byteArray = Encoding.ASCII.GetBytes(sLine);
            var stream = new MemoryStream(byteArray);
            System.IO.File.Delete(nameurl);
            return File(stream, "text/plain", string.Empty);
        }


        private string IsSICCFOX()
        {
            return "CLE;GTE;SVE;PRL;DOL;MXL;BOE";
        }

       
        private string FormateaPedidoCabWeb(BETemplateSinMarcar[] template, DataTable table, string codigoPais, string fechaProceso,string fechaFacturacion, string lote,string nombreArchivo, string origen, int campaniaid)
        {
            string headerFile = string.Empty;
            if (table.Rows.Count > 0)
            {
                Guid fileGuid = Guid.NewGuid();
                string path = System.IO.Path.Combine(AppDomain.CurrentDomain.BaseDirectory, Constantes.ConfiguracionManager.BaseDirectory);
                headerFile = FormatFileSinMarcar(codigoPais, string.Concat(nombreArchivo, ".txt"), campaniaid, fileGuid);
                if (!Directory.Exists(path))
                {
                    DirectoryInfo di = Directory.CreateDirectory(headerFile);
                }

                using (var streamWriter = new StreamWriter(headerFile))
                {
                    bool vacio = true;

                    vacio = false;
                    foreach (DataRow row in table.Rows)
                    {
                        streamWriter.WriteLine(HeaderLineSinMarcar(template, row, codigoPais, fechaProceso, fechaFacturacion, lote, origen));
                    }
                    if (vacio) streamWriter.Write(string.Empty);
                }
            }
            return headerFile;
        }

        private string FormatFileSinMarcar(string codigoPais, string fileName, int campanaId, Guid fileGuid)
        {
            return System.IO.Path.Combine(AppDomain.CurrentDomain.BaseDirectory, @"Uploads\Files\")
                + Path.GetFileNameWithoutExtension(fileName) + "-"
                + codigoPais + "-" + campanaId.ToString() + "-"
                + fileGuid.ToString() + Path.GetExtension(fileName);
        }

        private string FormateaPedidoCabDD(BETemplateSinMarcar[] template, DataTable table, string codigoPais, string fechaProceso,string fechaFacturacion, string lote, string nombreArchivo,string origen, int campaniaid)
        {
            string headerFile = string.Empty;

            if (table.Rows.Count > 0)
            {
                Guid fileGuid = Guid.NewGuid();
                string path = System.IO.Path.Combine(AppDomain.CurrentDomain.BaseDirectory, @"Uploads\Files");
                headerFile = FormatFileSinMarcar(codigoPais, string.Concat(nombreArchivo, ".txt"), campaniaid, fileGuid);
                if (!Directory.Exists(path))
                {
                    DirectoryInfo di = Directory.CreateDirectory(headerFile);
                }

                using (var streamWriter = new StreamWriter(headerFile))
                {
                    bool vacio = true;

                    vacio = false;
                    foreach (DataRow row in table.Rows)
                    {
                        streamWriter.WriteLine(HeaderLineSinMarcar(template, row, codigoPais, fechaProceso, fechaFacturacion, lote, origen));
                    }
                    if (vacio) streamWriter.Write(string.Empty);
                }
            }
            return headerFile;
        }

        private string FormateaPedidoDet(BETemplateSinMarcar[] template, DataTable table, string codigoPais, string fechaProceso, string lote,string nombreArchivo, string origen, int campaniaid)
        {
            string headerFile = string.Empty;

            if (table.Rows.Count > 0)
            {

                Guid fileGuid = Guid.NewGuid();
                string path = System.IO.Path.Combine(AppDomain.CurrentDomain.BaseDirectory, @"Uploads\Files");
                headerFile = FormatFileSinMarcar(codigoPais, string.Concat(nombreArchivo, ".txt"), campaniaid, fileGuid);
                if (!Directory.Exists(path))
                {
                    DirectoryInfo di = Directory.CreateDirectory(headerFile);
                }

                using (var streamWriter = new StreamWriter(headerFile))
                {
                    bool vacio = true;

                    vacio = false;
                    foreach (DataRow row in table.Rows)
                    {
                        streamWriter.WriteLine(DetailLineSinMarcar(template, row, codigoPais, lote));
                    }
                    if (vacio) streamWriter.Write(string.Empty);
                }
            }

            return headerFile;
        }

        [HttpPost]
        public JsonResult RealizarDescargaSinMarcar(DescargarPedidoModel model)
        {
            int tipoCronogramaID = Constantes.TipoProceso.Regular;
            try
            {
                string file = string.Empty;
                using (var pedidoService = new PedidoServiceClient())
                {
                    file = pedidoService.DescargaPedidosWebSinMarcar(model.PaisID, model.CampanaId, tipoCronogramaID, userData.NombreConsultora, model.NroLote, model.FechaFacturacion);
                }

                return Json(new
                {
                    success = file
                });
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
                return ErrorJson(ex.Message);
            }
        }

        [HttpPost]
        public JsonResult CargarLista()
        {
            try
            {
                return Json(new
                {
                    success = 1
                });
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
                return ErrorJson(ex.Message);
            }
        }





        private string HeaderLineSinMarcar(BETemplateSinMarcar[] template, DataRow row, string codigoPais, string fechaProceso, string fechaFactura, string lote,string origen)
        {
            string line = string.Empty;
            foreach (BETemplateSinMarcar field in template)
            {
                string item;
                switch (field.FieldName)
                {
                    case "PAIS": item = codigoPais; break;
                    case "CAMPANIA": item = row["CampaniaID"].ToString(); break;
                    case "CONSULTORA": item = row["CodigoConsultora"].ToString(); break;
                    case "PREIMPRESO": item = row["PedidoID"].ToString(); break;
                    case "CLIENTES": item = row["Clientes"].ToString(); break;
                    case "FECHAPROCESO": item = fechaProceso; break;
                    case "FECHAFACTURA": item = fechaFactura; break;
                    case "REGION": item = row["CodigoRegion"].ToString(); break;
                    case "ZONA":
                        item = !IsSICCFOX().Contains(codigoPais)
                            ? row["CodigoZona"].ToString()
                            : row["CodigoZona"].ToString().Substring(0, 4);
                        break;
                    case "LOTE": item = lote; break;
                    case "ORIGEN": item = origen; break;
                    case "VALIDADO": item = row["Validado"].ToString(); break;
                    case "COMPARTAMOS": item = (DataRecord.HasColumn(row, "bitAsistenciaCompartamos") ? row["bitAsistenciaCompartamos"].ToString() : string.Empty); break;
                    case "METODOENVIO": item = (DataRecord.HasColumn(row, "chrShippingMethod") ? row["chrShippingMethod"].ToString() : string.Empty); break;
                    case "IPUSUARIO": item = (DataRecord.HasColumn(row, "IPUsuario") ? row["IPUsuario"].ToString() : string.Empty); break;
                    case "TIPOCUPON": item = (DataRecord.HasColumn(row, "TipoCupon") ? row["TipoCupon"].ToString() : string.Empty); break;
                    case "VALORCUPON": item = (DataRecord.HasColumn(row, "ValorCupon") ? row["ValorCupon"].ToString() : string.Empty); break;
                    case "PEDIDOSAPID": item = (DataRecord.HasColumn(row, "PedidoSapId") ? row["PedidoSapId"].ToString() : string.Empty); break;
                    default: item = string.Empty; break;
                }
                line += item.PadRight(field.Size);
            }
            return line;
        }

        private string DetailLineSinMarcar(BETemplateSinMarcar[] template, DataRow row, string codigoPais, string lote)
        {
            string line = string.Empty;
            foreach (BETemplateSinMarcar field in template)
            {
                string item;
                switch (field.FieldName)
                {
                    case "PAIS": item = codigoPais; break;
                    case "CAMPANIA": item = row["CampaniaID"].ToString(); break;
                    case "CONSULTORA": item = row["CodigoConsultora"].ToString(); break;
                    case "PREIMPRESO": item = row["PedidoID"].ToString(); break;
                    case "CODIGOVENTA": item = row["CodigoVenta"].ToString(); break;
                    case "CANTIDAD": item = row["Cantidad"].ToString(); break;
                    case "CODIGOPRODUCTO": item = row["CodigoProducto"].ToString(); break;
                    case "LOTE": item = lote; break;
                    case "ORIGENPEDIDOWEB": item = (DataRecord.HasColumn(row, "OrigenPedidoWeb") ? row["OrigenPedidoWeb"].ToString() : "0"); break;
                    default: item = string.Empty; break;
                }
                line += item.PadRight(field.Size);
            }
            return line;
        }
        #endregion
    }
}