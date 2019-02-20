using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Models.AdministracionPoput;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServiceContenido;
using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Web.Mvc;
using Portal.Consultoras.Service;
using Portal.Consultoras.Web.ServiceSAC;
using System.Web;
using System.IO;
using System.Web.Script.Serialization;
using System.Runtime.Serialization.Json;
using System.Drawing;

namespace Portal.Consultoras.Web.Controllers
{
    public class AdministracionPopupsController : BaseAdmController
    {
        int NUMERO_FILAS = 20;
        int PAGINAS_MAXIMAS = 0;
        public ActionResult Index()
        {
            @ViewBag.NumeroFila = NUMERO_FILAS;
            //if (!UsuarioModel.HasAcces(ViewBag.Permiso, "AdministrarGuiaNegocioDigitalizada/Index"))
            //    return RedirectToAction("Index", "Bienvenida");
            return View("AdministracionPopups", CargaInicial());
        }



        [HttpPost]
        public ActionResult GetCargarArchivoCSV()
        {
            List<Archivo> listArchivo = new List<Archivo>();
            string filePath = string.Empty,filename=string.Empty;
            if (Request.Files.Count > 0)
            {
                HttpPostedFileBase frmData = Request.Files[0];
            
                if (frmData != null)
                {
                    if (frmData.FileName.EndsWith(".csv"))
                    {
                        string path = Server.MapPath("~/Uploads/");
                        if (!Directory.Exists(path))
                        {
                            Directory.CreateDirectory(path);

                        }
                        filePath = path + Path.GetFileName(frmData.FileName);
                        filename = Path.GetFileName(frmData.FileName);
                        string extension = Path.GetExtension(frmData.FileName);
                        frmData.SaveAs(filePath);
                        int contador = 0;
                        string csvData = System.IO.File.ReadAllText(filePath);
                        foreach (string row in csvData.Split('\n'))
                        {
                            if (contador != 0)
                            {
                                if (!string.IsNullOrEmpty(row))
                                {
                                    listArchivo.Add(new Archivo()
                                    {
                                        RegionId = Convert.ToInt32(row.Split(","[0])[0]),
                                        ZonaId = Convert.ToInt32(row.Split(","[0])[1]),
                                        Estado = Convert.ToInt32(row.Split(","[0])[2]),
                                        Consultoraid = Convert.ToInt32(row.Split(","[0])[3])
                                    });
                                }
                            }
                            contador += 1;
                        }
                    }
                    else
                    {
                        return Json(new { dataerror = true, archivo = "Este formato de archivo no es compatible" });
                    }
                }
            }
            return Json( new { dataerror=false, archivo= filename , listArchivo = listArchivo }, JsonRequestBehavior.AllowGet);
        }



        #region Consultas
        private ComunicadoModel CargaInicial()
        {
            var ComunicadoModel = new ComunicadoModel()
            {
                listaCampania = ObtenerCampaniasPorPaisPoput(Convert.ToInt32(userData.PaisID))
            };

            return ComunicadoModel;
        }


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


        public JsonResult GetDetallePoput(int Comunicadoid) {
            ComunicadoModel objetoComunicadoModel;

            try
            {
                using (ContenidoServiceClient sv = new ContenidoServiceClient())
                {
                    var objetoContenidoService = sv.GetDetallePoput(Comunicadoid, userData.PaisID);
                    objetoComunicadoModel = GetAutoMapperManualObjeto(objetoContenidoService);
                }

            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                objetoComunicadoModel = new ComunicadoModel();
            }

            return Json(objetoComunicadoModel, JsonRequestBehavior.AllowGet);
    }

    public JsonResult GetCargaListadoPoput(int Estado, string Campania, int Paginas, int Filas)
        {
            List<ComunicadoModel> listaComunicadoModel;

            try
            {
                using (ContenidoServiceClient sv= new ContenidoServiceClient())
            {
                var listContenidoService = sv.GetListaPoput(Estado, Campania, Paginas, Filas, userData.PaisID).ToList();
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
             
              return Json(new { Paginamaximas= PAGINAS_MAXIMAS, listaComunicadoModel =listaComunicadoModel }, JsonRequestBehavior.AllowGet);
    }


        public JsonResult EliminarArchivoCsv( int Comunicadoid)
        {
            List<ComunicadoModel> listaComunicadoModel;
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
                listaComunicadoModel = new List<ComunicadoModel>();
            }

            return Json(respuesta, JsonRequestBehavior.AllowGet);
        }



        private List<ComunicadoModel> GetAutoMapperManualLista(List<ServiceContenido.BEComunicado> listContenidoService)
        {
            List<ComunicadoModel> listComunicadoModel = new List<ComunicadoModel>();

            foreach (var item in listContenidoService)
            {
                listComunicadoModel.Add(
                    new ComunicadoModel() {
                        ComunicadoId = Convert.ToInt32(item.ComunicadoId),
                        Numero = item.Numero,
                        UrlImagen = item.UrlImagen,
                        NombreImagen = GetImagen(item.UrlImagen),
                        FechaInicio_ =item.FechaInicio,
                        FechaFin_=item.FechaFin,
                        Titulo=item.Titulo,
                        DescripcionAccion=item.DescripcionAccion,
                        Activo=item.Activo,
                        PaginasMaximas=item.PaginasMaximas
                    }
                    );

            }
            return listComunicadoModel;
        }


        private ComunicadoModel GetAutoMapperManualObjeto(ServiceContenido.BEComunicado objetoContenidoService)
        {
            ComunicadoModel objComunicadoModel = new ComunicadoModel();

            objComunicadoModel= new ComunicadoModel()
            {

                ComunicadoId = Convert.ToInt32(objetoContenidoService.ComunicadoId),
                Descripcion = objetoContenidoService.Descripcion,
                Activo = objetoContenidoService.Activo,
                DescripcionAccion = objetoContenidoService.DescripcionAccion,
                SegmentacionID = Convert.ToInt32(objetoContenidoService.SegmentacionID),
                UrlImagen = ConfigCdn.GetUrlFileCdnMatriz(userData.CodigoISO, objetoContenidoService.UrlImagen),
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

        [HttpPost]
        public ActionResult Prueba()
        {

            return Json(1, JsonRequestBehavior.AllowGet);
        }




        [HttpPost]
        public ActionResult GetGuardarPoput()
        {
            string UrlImagen = string.Empty;
            int result = 0;
            if (Request.Files["imagen"] != null)
            if (Request.Files["imagen"] != null)
            {
               HttpPostedFileBase frmDataImagen = Request.Files["imagen"];
               string urlNueva=  GetGuardarImagenServidor(frmDataImagen.FileName, Request.Form["imagenAnterior"]);
                UrlImagen = urlNueva;
            }
            else
            {
                UrlImagen = Request.Form["imagenAnterior"];
            }
                string comunicadoId = Request.Form["comunicadoId"];
                string tituloPrincipal = Request.Form["txtTituloPrincipal"];
                string descripcion = Request.Form["txtDescripcion"];
                string descripcionAccion = Request.Form["txtUrl"];
                string fechaMaxima = Request.Form["fechaMax"];
                string fechaMinima= Request.Form["fechaMin"];
                bool checkDesktop = Convert.ToBoolean(Request.Form["checkDesktop"]);
                bool checkMobile = Convert.ToBoolean( Request.Form["checkMobile"]);
                string nombreArchivo = Request.Form["nombreArchivo"];
                string codigoCampania = Request.Form["codigoCampania"];
                int accionID = Convert.ToInt32(Request.Form["accionID"]);
               
                using (ContenidoServiceClient svr = new ContenidoServiceClient())
                {
                    result = svr.GuardarPoputs(tituloPrincipal, descripcion, UrlImagen, fechaMaxima, fechaMinima, checkDesktop, checkMobile, accionID, Request.Form["datosCSV"], comunicadoId, nombreArchivo, codigoCampania, descripcionAccion, userData.PaisID);
                }
            
            
                return Json(result, JsonRequestBehavior.AllowGet);
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


        public static byte[] ReadFully(Stream input)
        {
            byte[] buffer = new byte[16 * 1024];
            using (MemoryStream ms = new MemoryStream())
            {
                int read;
                while ((read = input.Read(buffer, 0, buffer.Length)) > 0)
                {
                    ms.Write(buffer, 0, read);
                }
                return ms.ToArray();
            }
        }

        private string GetGuardarImagenServidor(string imagenActual, string imagenAnterior)
        {
       
            var path = Path.Combine(Globals.RutaTemporales, imagenActual);
            var carpetaPais = Globals.UrlMatriz + "/" + userData.CodigoISO;
            var time = DateTime.Now.Year.ToString() + DateTime.Now.Month.ToString() + DateTime.Now.Minute.ToString() + DateTime.Now.Millisecond.ToString();
            var newfilename = userData.CodigoISO + "_" + time + "_" + "01" + "_" + FileManager.RandomString() + ".png";
            if (imagenAnterior != "") ConfigS3.DeleteFileS3(carpetaPais, imagenAnterior);
            ConfigS3.SetFileS3(path, carpetaPais, newfilename);
            return newfilename;
        }
    }
}
