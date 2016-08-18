using System;
using System.Collections.Generic;
using System.ComponentModel.Design;
using System.IO;
using System.Linq;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;
using Newtonsoft.Json;
using Portal.Consultoras.Common;
using Portal.Consultoras.Common.Exceptions;
using Portal.Consultoras.Web.CustomAttributes;
using Portal.Consultoras.Web.CustomFilters;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceContenido;
using Portal.Consultoras.Web.ServiceZonificacion;

namespace Portal.Consultoras.Web.Controllers
{
    public class RevistaGanaController : BaseController
    {
        #region Variables miembro
        private const string ImageExtensionRevista = "jpg|png|gif|jpeg";
        private const string ImageSubtypes = "jpeg|png|x-png|gif|pjpeg";
        private const string PrefijoImageName = "revista-gana_";
        #endregion
        #region Actions
        // GET: /RevistaGana/
        public async Task<ActionResult> Index()
        {
            if (!UsuarioModel.HasAcces(ViewBag.Permiso, RouteData.GetRequiredString("controller") + "/" + RouteData.GetRequiredString("action")))
                return RedirectToAction("Index", "Bienvenida");

            var usuarioModel = UserData();
            using (var zonificacionServiceClient = new ZonificacionServiceClient())
            {
                 ViewBag.ListaCampania= await zonificacionServiceClient.SelectCampaniasAsync(usuarioModel.PaisID);
            }
            ViewBag.UrlImageCurrentCampania =await ObtenerRutaImagen(usuarioModel.NombreCorto, usuarioModel.PaisID);
            int currentCampania;
            Int32.TryParse(usuarioModel.NombreCorto ?? String.Empty, out currentCampania);
            ViewBag.UrlFlashpaper = (Globals.UrlFlashpapersRevista ?? String.Empty).TrimEnd('/')+"/"+Util.GetPaisISO(usuarioModel.PaisID);
            ViewBag.NamePageFlashpaper = (Globals.NamePageFlashpapers ?? String.Empty);
            ViewBag.CurrentCampania = currentCampania;
            ViewBag.NroCampanias = usuarioModel.NroCampanias;
            ViewBag.CodigoISO = usuarioModel.CodigoISO;
            return View();
        }
        public async Task<ActionResult> Insertar(int paisId,string campania,string fileNamePortada)
        {
            if (!ModelState.IsValid)
            {
                throw  new Exception("No se ha proporcionado los datos necesarios, ingrese los datos necesarios.");
            }
            if (String.IsNullOrEmpty(fileNamePortada))
            {
                throw new Exception("No ha seleccionado la imagen de la portada.");
            }
            int newId;
            using (var contenidoServiceClient = new ContenidoServiceClient())
            {
                newId = await contenidoServiceClient.CrearContenidoRevistaAsync(paisId, campania, fileNamePortada);
            }
            if (newId<=0)throw  new Exception("No se pudo grabar los datos, intente nuevamente");
            // 1664
            // var fileRevistaTemporal = String.Format("{0}/{1}",Server.MapPath(Globals.RutaFileLoadTemporal),fileNamePortada);
            // GrabarImagenDirectorio(paisId, fileRevistaTemporal, fileNamePortada);
            
            return Json(newId);
        }
        public async Task<ActionResult> AdministrarRevistaGana()
        {
            if (!UsuarioModel.HasAcces(ViewBag.Permiso, RouteData.GetRequiredString("controller") + "/" + RouteData.GetRequiredString("action")))
                return RedirectToAction("Index", "Bienvenida");

            var usuarioModel = UserData();
            var administrarRevistaViewModel = new AdministrarRevistaViewModel();
            using (var zonificacionServiceClient = new ZonificacionServiceClient())
            {
                if (usuarioModel.RolID == 2)//Todos los paises
                {
                   administrarRevistaViewModel.ListaPaises= await zonificacionServiceClient.SelectPaisesAsync();
                }
                else
                {
                    var pais = await zonificacionServiceClient.SelectPaisAsync(usuarioModel.PaisID);
                    administrarRevistaViewModel.ListaPaises=new[]{pais};
                }
                administrarRevistaViewModel.ListaCampanias = await 
                    zonificacionServiceClient.SelectCampaniasAsync(usuarioModel.PaisID);
            }
            administrarRevistaViewModel.IdPais = usuarioModel.PaisID;
            ViewBag.ExtensionImageAllow = ImageExtensionRevista;
            ViewBag.SizeLimitRevista = Globals.SizeLimitImageRevista;
            ViewBag.SizeLimitRevistaDesc = Util.ToFileSize(Globals.SizeLimitImageRevista);
            return View(administrarRevistaViewModel);
        }
        public ActionResult SaveImagePortada(HttpPostedFileBase qqfile, string prevImage)
        {
            var rutaVirtualPortada="";
            var fileName = "";
            if (ModelState.IsValid)
            {
                if ((qqfile == null ? Request.InputStream.Length : qqfile.ContentLength) >Globals.SizeLimitImageRevista)
                {
                    return JsonResult(new { error = String.Format("El archivo es demasiado grande, el máximo tamaño es {0}.", Util.ToFileSize(Globals.SizeLimitImageRevista)) });
                }
                // if (String.IsNullOrEmpty(Globals.RutaFileLoadTemporal))
                // 1664
                if (String.IsNullOrEmpty(Globals.RutaTemporales))
                {
                    return JsonResult(new { error = "Error configuración directorio carga imágenes, consulte administrador sistema." });
                }
                fileName = qqfile == null ? Request.QueryString["qqfile"] : qqfile.FileName;
                if (String.IsNullOrEmpty(fileName))
                {
                    return JsonResult(new { error = "Debe cargar la imagen de la portada." });
                }
                var mimeTypeImage = qqfile == null ?String.Empty : qqfile.ContentType;
                System.Drawing.Image imageAjax=null;
                if (Request.IsAjaxRequest())
                {
                    try
                    {
                        imageAjax = System.Drawing.Image.FromStream(Request.InputStream);
                    }
                    catch 
                    {
                        return JsonResult(new { error = "El archivo no es una imagen válido(" + ImageExtensionRevista + ")." });
                    }
                    mimeTypeImage = Util.GetMimeType(imageAjax);
                }
                if (!Util.CheckIsImage(mimeTypeImage, ImageSubtypes))
                {
                    return JsonResult(new { error = "El archivo no es una imagen válido(" + ImageExtensionRevista + ")." });
                }
                // var pathFisico = Server.MapPath(Globals.RutaFileLoadTemporal);
                // 1664
                var pathFisico = Globals.RutaTemporales;
                fileName = PrefijoImageName + Guid.NewGuid()+Path.GetExtension(fileName);
                pathFisico = Path.Combine(pathFisico, fileName);
                // var pathPrevImage = String.Format("{0}/{1}", Server.MapPath(Globals.RutaFileLoadTemporal), prevImage);
                var pathPrevImage = String.Format("{0}/{1}", Globals.RutaTemporales, prevImage); // 1664
                if (!String.IsNullOrEmpty(prevImage) && System.IO.File.Exists(pathPrevImage))//Eliminamos achivo cargado anteriormente
                {
                    try
                    {
                        System.IO.File.Delete(pathPrevImage);
                    }
                    catch (Exception ex)
                    {
                        LogManager.LogManager.LogErrorWebServicesBus(ex,"","");
                    }
                }
                if (qqfile!=null)
                {

                    qqfile.SaveAs(pathFisico);
                }
                else if (imageAjax != null)
                {
                     imageAjax.Save(pathFisico);
                     imageAjax.Dispose();
                }
                // var rutaRevista = GetPathVirtualImageRevista(Globals.RutaTemporales);
                var carpetaPais = Globals.UrlRevistaGana + "/" + UserData().CodigoISO;
                ConfigS3.SetFileS3(pathFisico, carpetaPais, fileName);
                var rutaRevista = ConfigS3.GetUrlFileS3(carpetaPais, fileName, Globals.RutaImagenesRevista + "/" + UserData().CodigoISO);
                rutaVirtualPortada = rutaRevista;
            }
            return JsonResult(new { hrefImage = rutaVirtualPortada,fileName });
        }
        public async Task<ActionResult> GetImageCampania(string campania)
        {
            var imageCampania=String.Empty;
            if (ModelState.IsValid )
            {
                var usuarioModel = UserData();
               imageCampania = await ObtenerRutaImagen(campania, usuarioModel.PaisID);
            }
            return Json(imageCampania);
        }
        private async Task<string> ObtenerRutaImagen(string campania, int paisId)
        {
            var imageCampania="";
            using (var contenidoServiceClient = new ContenidoServiceClient())
            {
                var contenidoRevista =
                    await contenidoServiceClient.ObtenerContenidoRevistaCampaniaAsync(paisId, campania);
                if (contenidoRevista != null)
                {
                    // imageCampania = GetPathImageRevistaByPais(Util.GetPaisISO(paisId)) + "/" + contenidoRevista.RutaImagenPortada;
                    var carpetaPais = Globals.UrlRevistaGana + "/" + UserData().CodigoISO; // 1664
                    imageCampania = ConfigS3.GetUrlFileS3(carpetaPais, contenidoRevista.RutaImagenPortada, Globals.RutaImagenesRevista); // 1664
                }
            }
            return imageCampania;
        }
        public async Task<JsonResult> ListadoRevistaPortadas(int page, int rows, int paisId, string campania)
        {
            BEContenidoRevista[] listadoContenidoRevista=null;
            var totalRows = 0;
            if (ModelState.IsValid)
            {
                using (var contenidoServiceClient = new ContenidoServiceClient())
                {
                    var response = await contenidoServiceClient.ContenidoRevistaPaginadoAsync(new ContenidoRevistaPaginadoRequest(paisId, campania, rows, page));
                    if (response!=null)
                    {
                        totalRows = response.totalRows;
                        listadoContenidoRevista = response.ContenidoRevistaPaginadoResult;
                    }
                }
            }
            if (listadoContenidoRevista==null) listadoContenidoRevista = new BEContenidoRevista[0];

            // 1664
            var carpetaPais = Globals.UrlRevistaGana + "/" + UserData().CodigoISO;
            listadoContenidoRevista.Update(x => x.RutaImagenPortada = ConfigS3.GetUrlFileS3(carpetaPais, x.RutaImagenPortada, Globals.RutaImagenesRevista + "/" + UserData().CodigoISO));

            var pathImageRevistaByPais = GetPathImageRevistaByPais(Util.GetPaisISO(paisId));
            return Json(new
                {
                    total = totalRows > 0 && rows > 0 ? Math.Ceiling(totalRows / (double)rows) : 0,
                    page,
                    records=totalRows,
                    rows=listadoContenidoRevista.Select(x=>new
                        {
                            id=x.Id,
                            cell=new[]
                                {
                                    paisId.ToString(),
                                    x.NroCampania,
                                    // String.Format("{0}/{1}",pathImageRevistaByPais,x.RutaImagenPortada)
                                    x.RutaImagenPortada // 1664
                                }
                        })
                },JsonRequestBehavior.AllowGet);
        }
        public async Task<JsonResult> ObtenerRevistaPortadaById(int paisId, int id)
        {
            BEContenidoRevista result = null;
            if (ModelState.IsValid)
            {
                using (var contenidoServiceClient = new ContenidoServiceClient())
                {
                    result = await contenidoServiceClient.ObtenerContenidoRevistaIdAsync(paisId, id);
                }
            }
            if (result!=null)
            {
                //  var pathImageRevistaByPais = GetPathImageRevistaByPais(Util.GetPaisISO(paisId));
                // result.RutaImagenPortada = String.Format("{0}/{1}", pathImageRevistaByPais, result.RutaImagenPortada);
                // 1664
                var carpetaPais = Globals.UrlRevistaGana + "/" + UserData().CodigoISO;
                result.RutaImagenPortada = ConfigS3.GetUrlFileS3(carpetaPais, result.RutaImagenPortada, Globals.RutaImagenesRevista + "/" + UserData().CodigoISO);

            }
            return Json(new{paisId,result}, JsonRequestBehavior.AllowGet);
        }
        public async Task<JsonResult> EliminarRevistaPortadaById(int paisId, int id,string namePortada)
        {
            var cantReg = 0;
            if (ModelState.IsValid)
            {
                using (var contenidoServiceClient = new ContenidoServiceClient())
                {
                    cantReg =await contenidoServiceClient.EliminarContenidoRevistaAsync(paisId, id);
                }
                if (cantReg > 0 && !String.IsNullOrEmpty(namePortada))
                {
                    var pathImageRevistaByPais =Server.MapPath(GetPathImageRevistaByPais(Util.GetPaisISO(paisId)))+"/"+namePortada;
                    if (System.IO.File.Exists(pathImageRevistaByPais))
                    {
                        try
                        {
                            System.IO.File.Delete(pathImageRevistaByPais);
                        }
                        catch (Exception ex)
                        {
                            LogManager.LogManager.LogErrorWebServicesBus(ex, "", "");
                        }   
                    }
                    
                }
            }
            return Json(cantReg,JsonRequestBehavior.AllowGet);
        }
        public async Task<JsonResult> ActualizarRevistaPortadaById(int paisId, int id, string fileNamePortadaPrev, string fileNamePortada)
        {
            var cantReg = 0;
            if (ModelState.IsValid)
            {
                using (var contenidoServiceClient = new ContenidoServiceClient())
                {
                    cantReg = await contenidoServiceClient.ActualizarContenidoRevistaAsync(paisId, id,fileNamePortada);
                }
                if (cantReg>0)
                {
                    // var fileRevistaTemporal = String.Format("{0}/{1}", Server.MapPath(Globals.RutaFileLoadTemporal),fileNamePortada);
                    /*
                    GrabarImagenDirectorio(paisId, fileRevistaTemporal, fileNamePortada);
                    var rutaFilePrev = Server.MapPath(GetPathImageRevistaByPais(Util.GetPaisISO(paisId))) + "/" + fileNamePortadaPrev;
                    if (!String.IsNullOrEmpty(fileNamePortadaPrev) && !fileNamePortadaPrev.Equals(fileNamePortada,StringComparison.OrdinalIgnoreCase) &&
                        !String.IsNullOrEmpty(rutaFilePrev)  && System.IO.File.Exists(rutaFilePrev))//Eliminar imagen anterior
                    {
                        try
                        {
                            System.IO.File.Delete(rutaFilePrev);
                        }
                        catch (Exception ex)
                        {
                            LogManager.LogManager.LogErrorWebServicesBus(ex,"","");
                        }
                    } */
                    // 1664
                    if (fileNamePortadaPrev.IndexOf('?') > 0)
                    {
                        fileNamePortadaPrev = fileNamePortadaPrev.Substring(0, fileNamePortadaPrev.IndexOf('?'));
                    }
                    var carpetaPais = Globals.UrlRevistaGana + "/" + UserData().CodigoISO;
                    ConfigS3.DeleteFileS3(carpetaPais, fileNamePortadaPrev);
                }
            }
            return Json(cantReg, JsonRequestBehavior.AllowGet);
        }
        #endregion
        #region Metodos privados
        private string GetPathImageRevistaByPais(string pasiIso)
        {
            var pathVirtual = Path.Combine(Globals.RutaImagenesRevista, pasiIso);
            return GetPathVirtualImageRevista(pathVirtual);
        }
        private string GetPathVirtualImageRevista(string rutaVirtual)
        {
            if (rutaVirtual.StartsWith("~"))
                return Url.Content(rutaVirtual);
            return VirtualPathUtility.IsAbsolute(rutaVirtual) ? rutaVirtual : String.Empty;
        }
        private void GrabarImagenDirectorio(int paisId, string fileRevistaTemporal, string fileName)
        {
            var pathImagePais = Server.MapPath(GetPathImageRevistaByPais(Util.GetPaisISO(paisId)));
            if (!String.IsNullOrEmpty(pathImagePais) && !Directory.Exists(pathImagePais))//Crear directorio por pais
            {
                try
                {
                    Directory.CreateDirectory(pathImagePais);
                }
                catch (Exception ex)
                {
                    LogManager.LogManager.LogErrorWebServicesBus(ex, "", "");
                    throw new Exception("Error al guardar la imagen, consulte administrador sistema.");
                }
            }

            if (System.IO.File.Exists(fileRevistaTemporal))
            {
                try
                {
                    System.IO.File.Copy(fileRevistaTemporal,pathImagePais+ "/" + fileName,
                                        true);
                }
                catch (Exception ex)
                {
                    LogManager.LogManager.LogErrorWebServicesBus(ex, "", "");
                    throw new Exception("Error al guardar la imagen, consulte administrador sistema.");
                }
                try
                {
                    System.IO.File.Delete(fileRevistaTemporal);
                }
                catch (Exception ex)
                {
                    LogManager.LogManager.LogErrorWebServicesBus(ex, "", "");
                }
            }
        }
        private ActionResult JsonResult(object data)
        {
            if (Request.IsAjaxRequest())
            {
                return Json(data);
            }
            return Content(JsonConvert.SerializeObject(data));
        }
        #endregion

    }
}
