using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Portal.Consultoras.Common;
using System.IO;
using System.Drawing;

namespace Portal.Consultoras.Web.Controllers
{
    public class FileUploadController : Controller
    {
        [HttpPost]
        public ActionResult ImageHttpUpload(HttpPostedFileBase file)
        {
            int weight = 150;
            int height = 150;

            var name = FileManager.SaveTempJpeg(Globals.RutaImagenesTemp, file.InputStream, ref weight, ref height);
            return Json(new { name, type = file.ContentType, size = file.ContentLength });
        }

        [HttpPost]
        public ActionResult ImageUpload(string qqfile)
        {
            string FileName = string.Empty;
            try
            {

                if (String.IsNullOrEmpty(Request["qqfile"]))
                {
                    HttpPostedFileBase postedFile = Request.Files[0];
                    var fileName = Path.GetFileName(postedFile.FileName);
                    var path = Path.Combine(Globals.RutaImagenesTemp, fileName);
                    postedFile.SaveAs(path);

                    path = Url.Content(Path.Combine(Globals.RutaImagenesTemp, fileName));

                    return Json(new { success = true, name = Path.GetFileName(path) }, "text/html");
                }
                else
                {
                    Stream inputStream = Request.InputStream;
                    byte[] fileBytes = ReadFully(inputStream);
                    string ffFileName = qqfile;
                    var path = Path.Combine(Globals.RutaImagenesTemp, ffFileName);
                    System.IO.File.WriteAllBytes(path, fileBytes);
                    if (!System.IO.File.Exists(Globals.RutaImagenesTemp))
                        System.IO.Directory.CreateDirectory(Globals.RutaImagenesTemp);
                    
                    return Json(new { success = true, name = Path.GetFileName(path) }, "text/html");
                }
            }
            catch (Exception ex)
            {
                return Json(new { success = false, message = ex.Message.ToString() }, "text/html");
            }
        }

        [HttpPost]
        public ActionResult ImageOfertasUpload(string qqfile)
        {
            string FileName = string.Empty;
            try
            {
                HttpPostedFileBase postedFile = Request.Files[0];
                var fileName = Path.GetFileName(postedFile.FileName);
                var path = Path.Combine(Globals.RutaImagenesTempOfertas, fileName);
                if (!System.IO.File.Exists(Globals.RutaImagenesTempOfertas))
                    System.IO.Directory.CreateDirectory(Globals.RutaImagenesTempOfertas);

                postedFile.SaveAs(path);

                path = Url.Content(Path.Combine(Globals.RutaImagenesTempOfertas, fileName));
                return Json(new { success = true, name = Path.GetFileName(path) }, "text/html");
            }
            catch (Exception ex)
            {
                return Json(new { success = false, message = ex.Message }, "text/html");
            }
        }

        [HttpPost]
        public ActionResult ImageMatrizUpload(string qqfile)
        {
            string FileName = string.Empty;
            try
            {
                if (String.IsNullOrEmpty(Request["qqfile"]))
                {
                    // req. 1664 - Unificando todo en una unica carpeta temporal
                    HttpPostedFileBase postedFile = Request.Files[0];
                    var fileName = Path.GetFileName(postedFile.FileName);
                    var path = Path.Combine(Globals.RutaTemporales, fileName);
                    if (!System.IO.File.Exists(Globals.RutaTemporales))
                        System.IO.Directory.CreateDirectory(Globals.RutaTemporales);
                    postedFile.SaveAs(path);
                    path = Url.Content(Path.Combine(Globals.RutaTemporales, fileName));
                    return Json(new { success = true, name = Path.GetFileName(path) }, "text/html");
                }
                else
                {
                    // req. 1664 - Unificando todo en una unica carpeta temporal
                    Stream inputStream = Request.InputStream;
                    byte[] fileBytes = ReadFully(inputStream);
                    string ffFileName = qqfile; // qqfile;
                    var path = Path.Combine(Globals.RutaTemporales, ffFileName);
                    System.IO.File.WriteAllBytes(path, fileBytes);
                    if (!System.IO.File.Exists(Globals.RutaTemporales))
                        System.IO.Directory.CreateDirectory(Globals.RutaTemporales);
                    return Json(new { success = true, name = Path.GetFileName(path) }, "text/html");
                }
                /*
                if (String.IsNullOrEmpty(Request["qqfile"]))
                {
                    HttpPostedFileBase postedFile = Request.Files[0];
                    var fileName = Path.GetFileName(postedFile.FileName);
                    var path = Path.Combine(Globals.RutaImagenesTempMatriz, fileName);
                    if (!System.IO.File.Exists(Globals.RutaImagenesTempMatriz))
                        System.IO.Directory.CreateDirectory(Globals.RutaImagenesTempMatriz);
                    postedFile.SaveAs(path);
                    path = Url.Content(Path.Combine(Globals.RutaImagenesTempMatriz, fileName));
                    return Json(new { success = true, name = Path.GetFileName(path) }, "text/html");
                }
                else
                {
                    Stream inputStream = Request.InputStream;
                    byte[] fileBytes = ReadFully(inputStream);
                    string ffFileName = qqfile;
                    var path = Path.Combine(Globals.RutaImagenesTempMatriz, ffFileName);
                    System.IO.File.WriteAllBytes(path, fileBytes);
                    if (!System.IO.File.Exists(Globals.RutaImagenesTempMatriz))
                        System.IO.Directory.CreateDirectory(Globals.RutaImagenesTempMatriz);
                    return Json(new { success = true, name = Path.GetFileName(path) }, "text/html");
                }
                 */
            }
            catch (Exception ex)
            {
                return Json(new { success = false, message = "Hubo un error al cargar el archivo, intente nuevamente." }, "text/html");
            }
        }

        [HttpPost]
        public ActionResult ImageOfertaNuevaUpload(string qqfile)
        {
            string FileName = string.Empty;
            try
            {
                // 1664
                if (String.IsNullOrEmpty(Request["qqfile"]))
                {
                    HttpPostedFileBase postedFile = Request.Files[0];
                    var fileName = Path.GetFileName(postedFile.FileName);
                    var path = Path.Combine(Globals.RutaTemporales, fileName);
                    if (!System.IO.File.Exists(Globals.RutaTemporales))
                        System.IO.Directory.CreateDirectory(Globals.RutaTemporales);

                    postedFile.SaveAs(path);
                    path = Url.Content(Path.Combine(Globals.RutaTemporales, fileName));
                    return Json(new { success = true, name = Path.GetFileName(path) }, "text/html");
                }
                else
                {
                    Stream inputStream = Request.InputStream;
                    byte[] fileBytes = ReadFully(inputStream);
                    string ffFileName = qqfile;
                    var path = Path.Combine(Globals.RutaTemporales, ffFileName);
                    System.IO.File.WriteAllBytes(path, fileBytes);
                    if (!System.IO.File.Exists(Globals.RutaTemporales))
                        System.IO.Directory.CreateDirectory(Globals.RutaTemporales);
                    return Json(new { success = true, name = Path.GetFileName(path) }, "text/html");
                }
                /*
                 if (String.IsNullOrEmpty(Request["qqfile"]))
                {
                    HttpPostedFileBase postedFile = Request.Files[0];
                    var fileName = Path.GetFileName(postedFile.FileName);
                    var path = Path.Combine(Globals.RutaImagenesTempOfertas, fileName);
                    if (!System.IO.File.Exists(Globals.RutaImagenesTempOfertas))
                        System.IO.Directory.CreateDirectory(Globals.RutaImagenesTempOfertas);

                    postedFile.SaveAs(path);
                    path = Url.Content(Path.Combine(Globals.RutaImagenesTempOfertas, fileName));
                    return Json(new { success = true, name = Path.GetFileName(path) }, "text/html");
                }
                else
                {
                    Stream inputStream = Request.InputStream;
                    byte[] fileBytes = ReadFully(inputStream);
                    string ffFileName = qqfile;
                    var path = Path.Combine(Globals.RutaImagenesTempOfertas, ffFileName);
                    System.IO.File.WriteAllBytes(path, fileBytes);
                    if (!System.IO.File.Exists(Globals.RutaImagenesTempOfertas))
                        System.IO.Directory.CreateDirectory(Globals.RutaImagenesTempOfertas);
                    return Json(new { success = true, name = Path.GetFileName(path) }, "text/html");
                }
                 */
            }
            catch (Exception ex)
            {
                return Json(new { success = false, message = "Hubo un error al cargar el archivo, intente nuevamente." }, "text/html");
            }
        }

        [HttpPost]
        public ActionResult ImageLugaresPagoUpload(string qqfile)
        {
            string FileName = string.Empty;
            try
            {
                // 1664
                if (String.IsNullOrEmpty(Request["qqfile"]))
                {
                    HttpPostedFileBase postedFile = Request.Files[0];
                    var fileName = Path.GetFileName(postedFile.FileName);
                    var path = Path.Combine(Globals.RutaTemporales, fileName);
                    if (!System.IO.File.Exists(Globals.RutaTemporales))
                        System.IO.Directory.CreateDirectory(Globals.RutaTemporales);

                    postedFile.SaveAs(path);
                    path = Url.Content(Path.Combine(Globals.RutaTemporales, fileName));
                    return Json(new { success = true, name = Path.GetFileName(path) }, "text/html");
                }
                else
                {
                    Stream inputStream = Request.InputStream;
                    byte[] fileBytes = ReadFully(inputStream);
                    string ffFileName = qqfile;
                    var path = Path.Combine(Globals.RutaTemporales, ffFileName);
                    System.IO.File.WriteAllBytes(path, fileBytes);
                    if (!System.IO.File.Exists(Globals.RutaTemporales))
                        System.IO.Directory.CreateDirectory(Globals.RutaTemporales);
                    return Json(new { success = true, name = Path.GetFileName(path) }, "text/html");
                }

                /*
                if (String.IsNullOrEmpty(Request["qqfile"]))
                {
                    HttpPostedFileBase postedFile = Request.Files[0];
                    var fileName = Path.GetFileName(postedFile.FileName);
                    var path = Path.Combine(Globals.RutaImagenesTempLugaresPago, fileName);
                    if (!System.IO.File.Exists(Globals.RutaImagenesTempLugaresPago))
                        System.IO.Directory.CreateDirectory(Globals.RutaImagenesTempLugaresPago);

                    postedFile.SaveAs(path);
                    path = Url.Content(Path.Combine(Globals.RutaImagenesTempLugaresPago, fileName));
                    return Json(new { success = true, name = Path.GetFileName(path) }, "text/html");
                }
                else
                {
                    Stream inputStream = Request.InputStream;
                    byte[] fileBytes = ReadFully(inputStream);
                    string ffFileName = qqfile;
                    var path = Path.Combine(Globals.RutaImagenesTempLugaresPago, ffFileName);
                    System.IO.File.WriteAllBytes(path, fileBytes);
                    if (!System.IO.File.Exists(Globals.RutaImagenesTempLugaresPago))
                        System.IO.Directory.CreateDirectory(Globals.RutaImagenesTempLugaresPago);
                    return Json(new { success = true, name = Path.GetFileName(path) }, "text/html");
                }
                 */
            }
            catch (Exception ex)
            {
                return Json(new { success = false, message = "Hubo un error al cargar el archivo, intente nuevamente." }, "text/html");
            }
        }

        [HttpPost]
        public ActionResult ImageIncentivoUpload(string qqfile)
        {
            string FileName = string.Empty;
            try
            {
                if (String.IsNullOrEmpty(Request["qqfile"]))
                {
                    HttpPostedFileBase postedFile = Request.Files[0];
                    var fileName = Path.GetFileName(postedFile.FileName);
                    var path = Path.Combine(Globals.RutaTemporales, fileName);
                    if (!System.IO.File.Exists(Globals.RutaTemporales))
                        System.IO.Directory.CreateDirectory(Globals.RutaTemporales);

                    postedFile.SaveAs(path);
                    path = Url.Content(Path.Combine(Globals.RutaTemporales, fileName));
                    return Json(new { success = true, name = Path.GetFileName(path) }, "text/html");
                }
                else
                {
                    Stream inputStream = Request.InputStream;
                    byte[] fileBytes = ReadFully(inputStream);
                    string ffFileName = qqfile;
                    
                    var path = Path.Combine(Globals.RutaTemporales, ffFileName);
                    System.IO.File.WriteAllBytes(path, fileBytes);
                    if (!System.IO.File.Exists(Globals.RutaTemporales))
                        System.IO.Directory.CreateDirectory(Globals.RutaTemporales);
                    return Json(new { success = true, name = Path.GetFileName(path) }, "text/html");
                }
                /*
                if (String.IsNullOrEmpty(Request["qqfile"]))
                {
                    HttpPostedFileBase postedFile = Request.Files[0];
                    var fileName = Path.GetFileName(postedFile.FileName);
                    var path = Path.Combine(Globals.RutaImagenesTempIncentivos, fileName);
                    if (!System.IO.File.Exists(Globals.RutaImagenesTempIncentivos))
                        System.IO.Directory.CreateDirectory(Globals.RutaImagenesTempIncentivos);

                    postedFile.SaveAs(path);
                    path = Url.Content(Path.Combine(Globals.RutaImagenesTempIncentivos, fileName));
                    return Json(new { success = true, name = Path.GetFileName(path) }, "text/html");
                }
                else
                {
                    Stream inputStream = Request.InputStream;
                    byte[] fileBytes = ReadFully(inputStream);
                    string ffFileName = qqfile;
                    var path = Path.Combine(Globals.RutaImagenesTempIncentivos, ffFileName);
                    System.IO.File.WriteAllBytes(path, fileBytes);
                    if (!System.IO.File.Exists(Globals.RutaImagenesTempIncentivos))
                        System.IO.Directory.CreateDirectory(Globals.RutaImagenesTempIncentivos);
                    return Json(new { success = true, name = Path.GetFileName(path) }, "text/html");
                }
                 */
            }
            catch (Exception ex)
            {
                return Json(new { success = false, message = "Hubo un error al cargar el archivo, intente nuevamente." }, "text/html");
            }
        }

        [HttpPost]
        public ActionResult ImageOfertaGratisUpload(string qqfile)
        {
            string FileName = string.Empty;
            try
            {
                if (String.IsNullOrEmpty(Request["qqfile"]))
                {
                    HttpPostedFileBase postedFile = Request.Files[0];
                    var fileName = Path.GetFileName(postedFile.FileName);
                    var path = Path.Combine(Globals.RutaImagenesTempOfertas, fileName);
                    if (!System.IO.File.Exists(Globals.RutaImagenesTempOfertas))
                        System.IO.Directory.CreateDirectory(Globals.RutaImagenesTempOfertas);

                    postedFile.SaveAs(path);
                    path = Url.Content(Path.Combine(Globals.RutaImagenesTempOfertas, fileName));
                    return Json(new { success = true, name = Path.GetFileName(path) }, "text/html");
                }
                else
                {
                    Stream inputStream = Request.InputStream;
                    byte[] fileBytes = ReadFully(inputStream);
                    string ffFileName = qqfile;
                    var path = Path.Combine(Globals.RutaImagenesTempOfertas, ffFileName);
                    System.IO.File.WriteAllBytes(path, fileBytes);
                    if (!System.IO.File.Exists(Globals.RutaImagenesTempOfertas))
                        System.IO.Directory.CreateDirectory(Globals.RutaImagenesTempOfertas);
                    return Json(new { success = true, name = Path.GetFileName(path) }, "text/html");
                }
            }
            catch (Exception ex)
            {
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
    }
}
