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

namespace Portal.Consultoras.Web.Controllers
{
    public class AdministracionPopupsController : BaseAdmController
    {
        public ActionResult Index()
        {
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
            return Json( new { dataerror=false, archivo= string.Concat( "Archivo ",filename) , listArchivo = listArchivo }, JsonRequestBehavior.AllowGet);
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



        public JsonResult GetDetallePoput(int Comunicadoid) {
            ComunicadoModel objetoComunicadoModel;

            try
            {
                using (ContenidoServiceClient sv = new ContenidoServiceClient())
                {
                    var objetoContenidoService = sv.GetDetallePoput(Comunicadoid);
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

    public JsonResult GetCargaListadoPoput(int Estado, string Campania)
        {
            List<ComunicadoModel> listaComunicadoModel;

            try
            {
                using (ContenidoServiceClient sv= new ContenidoServiceClient())
            {
                var listContenidoService = sv.GetListaPoput(Estado, Campania).ToList();
                    listaComunicadoModel = GetAutoMapperManualLista(listContenidoService);
                    //Mapper.Map<List<ServiceContenido.BEComunicado>, List<ComunicadoModel>>(listContenidoService);
                }

        }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                listaComunicadoModel = new List<ComunicadoModel>();
            }
             
              return Json(listaComunicadoModel, JsonRequestBehavior.AllowGet);
    }

        private List<ComunicadoModel> GetAutoMapperManualLista(List<ServiceContenido.BEComunicado> listContenidoService)
        {
            List<ComunicadoModel> listComunicadoModel = new List<ComunicadoModel>();

            foreach (var item in listContenidoService)
            {
                listComunicadoModel.Add(
                    new ComunicadoModel() {
                        ComunicadoId=Convert.ToInt32( item.ComunicadoId),
                        Numero=item.Numero,
                        UrlImagen=GetImagen(item.UrlImagen),
                        FechaInicio_=item.FechaInicio,
                        FechaFin_=item.FechaFin,
                        Titulo=item.Titulo,
                        DescripcionAccion=item.DescripcionAccion,
                        Activo=item.Activo
                    }
                    );

            }
            return listComunicadoModel;
        }


        private ComunicadoModel GetAutoMapperManualObjeto(ServiceContenido.BEComunicado objetoContenidoService)
        {
          //  string fullPathBridge = Server.MapPath(Path.Combine("../Images/AdministracionPoput/"));
            return  new ComunicadoModel()
            {
         
            ComunicadoId = Convert.ToInt32(objetoContenidoService.ComunicadoId),
             Descripcion = objetoContenidoService.Descripcion,
             Activo = objetoContenidoService.Activo,
             DescripcionAccion = objetoContenidoService.DescripcionAccion,
             SegmentacionID = Convert.ToInt32( objetoContenidoService.SegmentacionID),
             UrlImagen =  string.Concat("../Images/AdministracionPoput/", GetImagen( objetoContenidoService.UrlImagen)),
             NombreImagen = GetImagen(objetoContenidoService.UrlImagen),
             Orden = objetoContenidoService.Orden,
             NombreArchivoCCV = objetoContenidoService.NombreArchivoCCV,
             FechaInicio_ = objetoContenidoService.FechaInicio,
             FechaFin_ = objetoContenidoService.FechaFin,
             TipoDispositivo=objetoContenidoService.TipoDispositivo,
             

         };
            //Server.MapPath(Path.Combine(Route_DirectoryServices.ToString())) 



        }

        private string GetImagen(string urlImagen)
        {
            if (urlImagen != string.Empty) {
                string[] array = urlImagen.Split('/');
                urlImagen = array[array.Length - 1].ToString();
                    }
            return urlImagen;
        }
        #endregion

        [HttpPost]
        public ActionResult GetGuardarPoput()
        {
            int result = 0;
            if (Request.Files.Count > 0)
            {
                HttpPostedFileBase frmDataImagen = Request.Files["imagen"];
                //GetGuardarImagenServidor(frmDataImagen);

                string comunicadoId = Request.Form["comunicadoId"];
                string tituloPrincipal = Request.Form["txtTituloPrincipal"];
                string descripcion= Request.Form["txtDescripcion"];
                string Url = Request.Form["txtUrl"];
                string fechaMaxima = Request.Form["fechaMax"];
                string fechaMinima= Request.Form["fechaMin"];
                bool checkDesktop = Convert.ToBoolean(Request.Form["checkDesktop"]);
                bool checkMobile = Convert.ToBoolean( Request.Form["checkMobile"]);
                string nombreArchivo = Request.Form["nombreArchivo"];
                string codigoCampania = Request.Form["codigoCampania"];
                int accionID = Convert.ToInt32(Request.Form["accionID"]);
               
                using (ContenidoServiceClient svr = new ContenidoServiceClient())
                {
                    result = svr.GuardarPoputs(tituloPrincipal, descripcion, Url, fechaMaxima, fechaMinima, checkDesktop, checkMobile, accionID, Request.Form["datosCSV"], comunicadoId, nombreArchivo, codigoCampania);
                    if (result > 0)
                    {
                        return Json(new
                        {
                            success = false,
                            message = "La dirección de correo electrónico ingresada ya pertenece a otra Consultora.",
                            extra = ""
                        });
                    }
                }

            }

                return Json(1, JsonRequestBehavior.AllowGet);
        }

      
        private void GetGuardarImagenServidor(HttpPostedFileBase frmDataImagen)
        {
            string imagen = "imagen.jpg";
            var path = Path.Combine(Globals.RutaTemporales, imagen);
            var carpetaPais = Globals.UrlMatriz + "/" + userData.CodigoISO;
            var time = DateTime.Now.Year.ToString() + DateTime.Now.Month.ToString() + DateTime.Now.Minute.ToString() + DateTime.Now.Millisecond.ToString();
            var newfilename = userData.CodigoISO + "_" + time + "_" + "01" + "_" + FileManager.RandomString() + ".png";
            if (imagen != "") ConfigS3.DeleteFileS3(carpetaPais, imagen);
            ConfigS3.SetFileS3(path, carpetaPais, newfilename);
            throw new NotImplementedException();
        }
    }
}
