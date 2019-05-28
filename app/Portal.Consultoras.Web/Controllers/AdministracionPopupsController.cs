using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Models.AdministracionPoput;
using Portal.Consultoras.Web.ServiceContenido;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class AdministracionPopupsController : BaseAdmController
    {
        #region DECLARACIÓN DE VARIABLES GLOBALES
        int NUMERO_FILAS = 20;
        int PAGINAS_MAXIMAS = 0;
        string carpeta = Constantes.CarpetasContenido.Menu.ToString();
        #endregion

        #region CONSULTAS Y CARGAR INICIALES
        public ActionResult Index()
        {
            @ViewBag.NumeroFila = NUMERO_FILAS;
            if (!UsuarioModel.HasAcces(ViewBag.Permiso, "AdministracionPopups/Index"))
                return RedirectToAction("Index", "Bienvenida");
            return View("AdministracionPopups", CargaInicial());
        }

        private ComunicadoModel CargaInicial()
        {
            var ComunicadoModel = new ComunicadoModel()
            {
                listaCampania = ObtenerCampaniasPorPaisPoput(Convert.ToInt32(userData.PaisID))
            };

            return ComunicadoModel;
        }

        public JsonResult GetCargaListadoPopup(int Estado, string Campania, int Paginas, int Filas)
        {
            List<ComunicadoModel> listaComunicadoModel;

            try
            {
                using (ContenidoServiceClient sv = new ContenidoServiceClient())
                {
                    var listContenidoService = sv.GetListaPopup(Estado, Campania, Paginas, Filas, userData.PaisID).ToList();
                    listaComunicadoModel = GetAutoMapperManualLista(listContenidoService);
                }

                if (listaComunicadoModel.Count > 0)
                {
                    PAGINAS_MAXIMAS = listaComunicadoModel.FirstOrDefault().PaginasMaximas;
                    listaComunicadoModel.Update(x => x.UrlImagen = ConfigCdn.GetUrlFileCdnMatriz(userData.CodigoISO, x.UrlImagen));
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                listaComunicadoModel = new List<ComunicadoModel>();
            }

            return Json(new { Paginamaximas = PAGINAS_MAXIMAS, listaComunicadoModel = listaComunicadoModel }, JsonRequestBehavior.AllowGet);
        }


        public JsonResult GetCargaListadoPopupValidador()
        {
            List<SegmentacionComunicadoModel> listaComunicadoSegmentacionModel;

            try
            {
                using (ContenidoServiceClient sv = new ContenidoServiceClient())
                {
                    var listComunicadoSegmentacion = sv.GetCargaListadoPopupValidador(userData.PaisID).ToList();
                    listaComunicadoSegmentacionModel = GetAutoMapperManualComunicadoSegmentacion(listComunicadoSegmentacion);
                }

            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                listaComunicadoSegmentacionModel = new List<SegmentacionComunicadoModel>();
            }

            return Json(new { Paginamaximas = PAGINAS_MAXIMAS, listaComunicadoSegmentacionModel = listaComunicadoSegmentacionModel }, JsonRequestBehavior.AllowGet);
        }

        private List<SegmentacionComunicadoModel> GetAutoMapperManualComunicadoSegmentacion(List<ServiceContenido.BEComunicadoSegmentacion> listComunicadoSegmentacion)
        {
            List<SegmentacionComunicadoModel> listComunicadoModelSegmentacion = new List<SegmentacionComunicadoModel>();

            foreach (var item in listComunicadoSegmentacion)
            {
                listComunicadoModelSegmentacion.Add(
                    new SegmentacionComunicadoModel()
                    {
                        CodigoRegion = item.CodigoRegion,
                        CodigoZona = item.CodigoRegion,
                        IdEstadoActividad = Convert.ToInt32(item.IdEstadoActividad),
                        CodigoConsultora = item.CodigoConsultora
                    }
                    );

            }
            return listComunicadoModelSegmentacion;


        }

        public JsonResult GetDetallePopup(int Comunicadoid)
        {
            ComunicadoModel objetoComunicadoModel;

            try
            {
                ServiceContenido.BEComunicado objetoContenidoService;
                using (ContenidoServiceClient sv = new ContenidoServiceClient())
                {
                    objetoContenidoService = sv.GetDetallePopup(Comunicadoid, userData.PaisID);
                }
                objetoComunicadoModel = GetAutoMapperManualObjeto(objetoContenidoService);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                objetoComunicadoModel = new ComunicadoModel();
            }

            return Json(objetoComunicadoModel, JsonRequestBehavior.AllowGet);
        }

        public JsonResult CargaEstadoValidadorDatos()
        {
            int estado = 0;

            try
            {
                using (ContenidoServiceClient sv = new ContenidoServiceClient())
                {
                    estado = sv.CargaEstadoValidadorDatos(userData.PaisID);
                }

            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            return Json(estado, JsonRequestBehavior.AllowGet);
        }


        [HttpPost]
        public JsonResult GetGuardarPopupValidador()
        {
            int result = 0;
            try
            {
                bool checkPopup = Convert.ToBoolean(Request.Form["checkPopup"]);

                using (ContenidoServiceClient svr = new ContenidoServiceClient())
                {
                    result = svr.GuardarPopupsValidador(checkPopup, Request.Form["datosCSVValidador"], userData.PaisID);
                }

            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
            return Json(result, JsonRequestBehavior.AllowGet);

        }
        #endregion

        #region ARCHIVOS
        [HttpPost]
        public ActionResult GetCargarArchivoCSV()
        {
            List<Archivo> listArchivo = new List<Archivo>();
            var filename = string.Empty;

            try
            {
                if (Request.Files.Count > 0)
                {
                    HttpPostedFileBase frmData = Request.Files[0];

                    if (frmData != null)
                    {
                        if (!frmData.FileName.EndsWith(".csv"))
                        {
                            return Json(new { dataerror = true, archivo = "Este formato de archivo no es compatible" });
                        }

                        string path = Server.MapPath("~/Uploads/");
                        if (!Directory.Exists(path))
                        {
                            Directory.CreateDirectory(path);
                        }
                        string filePath = path + Path.GetFileName(frmData.FileName);
                        filename = Path.GetFileName(frmData.FileName);
                        //string extension = Path.GetExtension(frmData.FileName);
                        frmData.SaveAs(filePath);
                        int contador = 0;
                        string csvData = System.IO.File.ReadAllText(filePath);
                        foreach (string row in csvData.Split('\n'))
                        {
                            if (contador != 0 && !string.IsNullOrEmpty(row))
                            {
                                listArchivo.Add(new Archivo()
                                {
                                    RegionId = row.Split(","[0])[0].Replace("\r", ""),
                                    ZonaId = row.Split(","[0])[1].Replace("\r", ""),
                                    Estado = row.Split(","[0])[2].Replace("\r", ""),
                                    Consultoraid = row.Split(","[0])[3].Replace("\r", "")
                                });

                            }
                            contador += 1;
                        }
                        
                    }
                }

            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                listArchivo = new List<Archivo>();
            }
            return Json(new { dataerror = false, archivo = filename, listArchivo = listArchivo }, JsonRequestBehavior.AllowGet);
        }

        public JsonResult EliminarArchivoCsv(int Comunicadoid)
        {
            int respuesta = 0;
            try
            {
                using (ContenidoServiceClient sv = new ContenidoServiceClient())
                {
                    respuesta = sv.EliminarArchivoCsv(Comunicadoid, userData.PaisID);
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            return Json(respuesta, JsonRequestBehavior.AllowGet);
        }

        public JsonResult EliminarArchivoCsvValidador()
        {
            int respuesta = 0;
            try
            {
                using (ContenidoServiceClient sv = new ContenidoServiceClient())
                {
                    respuesta = sv.EliminarArchivoCsvValidador(userData.PaisID);
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            return Json(respuesta, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public ActionResult AgregarImagenUpload(string nombreImagen)
        {
            try
            {
                if (Request.Files["imagen"] != null)
                {
                    HttpPostedFileBase frmDataImagen = Request.Files["imagen"];
                    string ffFileName = nombreImagen;
                    var path = Path.Combine(Globals.RutaTemporales, ffFileName);
                    if (!System.IO.File.Exists(Globals.RutaTemporales))
                        Directory.CreateDirectory(Globals.RutaTemporales);
                    if (System.IO.File.Exists(path))
                        System.IO.File.Delete(path);

                    var ByteDataImage = new byte[frmDataImagen.ContentLength];
                    frmDataImagen.InputStream.Read(ByteDataImage, 0, frmDataImagen.ContentLength);
                    System.IO.File.WriteAllBytes(path, ByteDataImage);

                }
                return Json(1, "text/html");
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new { success = false, message = "Hubo un error al cargar el archivo, intente nuevamente." }, "text/html");
            }
        }


        private string GetGuardarImagenServidor(string imagenActual, string imagenAnterior)
        {
            var path = Path.Combine(Globals.RutaTemporales, imagenActual);
            if (imagenAnterior != "") ConfigS3.DeleteFileS3(carpeta, imagenAnterior);
            return ConfigS3.SetFileS3URL(path, carpeta, imagenActual);
        }

        private string GetImagen(string urlImagen)
        {
            if (urlImagen != string.Empty)
            {
                string[] array = urlImagen.Split('/');
                urlImagen = array[array.Length - 1].ToString();
            }
            return urlImagen;
        }
        #endregion

        #region MAPEO DE ENTIDADES
        private List<ComunicadoModel> GetAutoMapperManualLista(List<ServiceContenido.BEComunicado> listContenidoService)
        {
            List<ComunicadoModel> listComunicadoModel = new List<ComunicadoModel>();

            foreach (var item in listContenidoService)
            {
                listComunicadoModel.Add(
                    new ComunicadoModel()
                    {
                        ComunicadoId = Convert.ToInt32(item.ComunicadoId),
                        Numero = item.Numero,
                        UrlImagen = item.UrlImagen,
                        NombreImagen = GetImagen(item.UrlImagen),
                        FechaInicio_ = item.FechaInicio,
                        FechaFin_ = item.FechaFin,
                        Titulo = item.Titulo,
                        DescripcionAccion = item.DescripcionAccion,
                        Activo = item.Activo,
                        PaginasMaximas = item.PaginasMaximas
                    }
                    );

            }
            return listComunicadoModel;
        }

        private ComunicadoModel GetAutoMapperManualObjeto(ServiceContenido.BEComunicado objetoContenidoService)
        {
            var objComunicadoModel = new ComunicadoModel()
            {
                ComunicadoId = Convert.ToInt32(objetoContenidoService.ComunicadoId),
                Descripcion = objetoContenidoService.Descripcion,
                Activo = objetoContenidoService.Activo,
                DescripcionAccion = objetoContenidoService.DescripcionAccion,
                SegmentacionID = Convert.ToInt32(objetoContenidoService.SegmentacionID),
                UrlImagen = ConfigS3.GetUrlFileS3("Menu", objetoContenidoService.UrlImagen, string.Empty),
                NombreImagen = GetImagen(objetoContenidoService.UrlImagen),
                Orden = objetoContenidoService.Orden,
                NombreArchivoCCV = objetoContenidoService.NombreArchivoCCV,
                FechaInicio_ = objetoContenidoService.FechaInicio,
                FechaFin_ = objetoContenidoService.FechaFin,
                TipoDispositivo = objetoContenidoService.TipoDispositivo,
                Comentario = objetoContenidoService.Comentario
            };
            return objComunicadoModel;
        }
        #endregion

        #region REGISTROS
        public JsonResult ActualizaOrden(string Comunicado, string Orden)
        {
            int result = 0;
            try
            {
                using (ContenidoServiceClient sv = new ContenidoServiceClient())
                {
                    result = sv.ActualizaOrden(Comunicado, Orden, userData.PaisID);
                }

            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }

            return Json(result, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public ActionResult GetGuardarPopup()
        {
            string UrlImagen = string.Empty;
            int result = 0;
            try
            {
                if (Request.Files["imagen"] != null)
                {
                    HttpPostedFileBase frmDataImagen = Request.Files["imagen"];
                    string urlNueva = GetGuardarImagenServidor(frmDataImagen.FileName, Request.Form["imagenAnterior"]);
                    UrlImagen = urlNueva;
                }
                else UrlImagen = Request.Form["imagenAnterior"];

                string comunicadoId = Request.Form["comunicadoId"];
                string tituloPrincipal = Request.Form["txtTituloPrincipal"];
                string descripcion = Request.Form["txtDescripcion"];
                string descripcionAccion = Request.Form["txtUrl"];
                string fechaMaxima = Request.Form["fechaMax"];
                string fechaMinima = Request.Form["fechaMin"];
                bool checkDesktop = Convert.ToBoolean(Request.Form["checkDesktop"]);
                bool checkMobile = Convert.ToBoolean(Request.Form["checkMobile"]);
                string nombreArchivo = Request.Form["nombreArchivo"];
                string codigoCampania = Request.Form["codigoCampania"];
                int accionID = Convert.ToInt32(Request.Form["accionID"]);

                using (ContenidoServiceClient svr = new ContenidoServiceClient())
                {
                    result = svr.GuardarPopups(tituloPrincipal, descripcion, UrlImagen, fechaMaxima, fechaMinima, checkDesktop, checkMobile, accionID, Request.Form["datosCSV"], comunicadoId, nombreArchivo, codigoCampania, descripcionAccion, userData.PaisID);
                }

            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
            return Json(result, JsonRequestBehavior.AllowGet);
        }
        #endregion
    }
}
