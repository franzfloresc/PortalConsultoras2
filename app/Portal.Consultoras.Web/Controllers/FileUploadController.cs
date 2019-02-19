using Portal.Consultoras.Common;
using System;
using System.IO;
using System.Web;
using System.Web.Mvc;

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
            try
            {

                if (String.IsNullOrEmpty(Request["qqfile"]))
                {
                    HttpPostedFileBase postedFile = Request.Files[0];
                    if (postedFile == null)
                        return Json(new { success = false, message = "" }, "text/html");

                    var fileName = Path.GetFileName(postedFile.FileName) ?? "";
                    var path = Path.Combine(Globals.RutaImagenesTemp, fileName);
                    postedFile.SaveAs(path);

                    path = Url.Content(Path.Combine(Globals.RutaImagenesTemp, fileName));

                    return Json(new { success = true, name = Path.GetFileName(path) }, "text/html");
                }

                Stream inputStream = Request.InputStream;
                byte[] fileBytes = ReadFully(inputStream);
                string ffFileName = qqfile;
                var path2 = Path.Combine(Globals.RutaImagenesTemp, ffFileName);
                System.IO.File.WriteAllBytes(path2, fileBytes);
                if (!System.IO.File.Exists(Globals.RutaImagenesTemp))
                    Directory.CreateDirectory(Globals.RutaImagenesTemp);

                return Json(new { success = true, name = Path.GetFileName(path2) }, "text/html");

            }
            catch (Exception ex)
            {
                return Json(new { success = false, message = ex.Message }, "text/html");
            }
        }

        [HttpPost]
        public ActionResult ImageOfertasUpload(string qqfile)
        {
            try
            {
                HttpPostedFileBase postedFile = Request.Files[0];
                if (postedFile == null)
                    return Json(new { success = false, message = "" }, "text/html");

                var fileName = Path.GetFileName(postedFile.FileName) ?? "";
                var path = Path.Combine(Globals.RutaImagenesTempOfertas, fileName);
                if (!System.IO.File.Exists(Globals.RutaImagenesTempOfertas))
                    Directory.CreateDirectory(Globals.RutaImagenesTempOfertas);

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
            try
            {
                if (String.IsNullOrEmpty(Request["qqfile"]))
                {
                    HttpPostedFileBase postedFile = Request.Files[0];
                    if (postedFile == null)
                        return Json(new { success = false, message = "" }, "text/html");

                    var fileName = Path.GetFileName(postedFile.FileName) ?? "";
                    var path = Path.Combine(Globals.RutaTemporales, fileName);
                    if (!System.IO.File.Exists(Globals.RutaTemporales))
                        Directory.CreateDirectory(Globals.RutaTemporales);
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
                        Directory.CreateDirectory(Globals.RutaTemporales);
                    return Json(new { success = true, name = Path.GetFileName(path) }, "text/html");
                }

            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, "", "");
                return Json(new { success = false, message = "Hubo un error al cargar el archivo, intente nuevamente." }, "text/html");
            }
        }

        [HttpPost]
        public ActionResult ImageLanzamientoUpload(string qqfile, int width = 0, int height = 0, string messageSize = "")
        {
            try
            {
                var inputStream = Request.InputStream;
                var fileBytes = ReadFully(inputStream);

                if (width > 0 && height > 0)
                {
                    var image = System.Drawing.Image.FromStream(new MemoryStream(fileBytes));
                    if (image.Height != height || image.Width != width)
                        return Json(new { success = false, message = messageSize }, "text/html");
                }

                var time = string.Concat(DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.Minute, DateTime.Now.Millisecond);
                var path = Path.Combine(Globals.RutaTemporales, time + qqfile);

                if (!Directory.Exists(Globals.RutaTemporales)) Directory.CreateDirectory(Globals.RutaTemporales);

                System.IO.File.WriteAllBytes(path, fileBytes);
                
                return Json(new { success = true, name = Path.GetFileName(path) }, "text/html");
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, string.Empty, string.Empty);
                return Json(new { success = false, message = "Hubo un error al cargar el archivo, intente nuevamente." }, "text/html");
            }
        }

        [HttpPost]
        public ActionResult ImageOfertaNuevaUpload(string qqfile)
        {
            try
            {
                if (String.IsNullOrEmpty(Request["qqfile"]))
                {
                    HttpPostedFileBase postedFile = Request.Files[0];
                    if (postedFile == null)
                        return Json(new { success = false, message = "" }, "text/html");

                    var fileName = Path.GetFileName(postedFile.FileName) ?? "";
                    var path = Path.Combine(Globals.RutaTemporales, fileName);
                    if (!System.IO.File.Exists(Globals.RutaTemporales))
                        Directory.CreateDirectory(Globals.RutaTemporales);

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
                        Directory.CreateDirectory(Globals.RutaTemporales);
                    return Json(new { success = true, name = Path.GetFileName(path) }, "text/html");
                }

            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, "", "");
                return Json(new { success = false, message = "Hubo un error al cargar el archivo, intente nuevamente." }, "text/html");
            }
        }

        [HttpPost]
        public ActionResult ImageLugaresPagoUpload(string qqfile)
        {
            try
            {
                if (String.IsNullOrEmpty(Request["qqfile"]))
                {
                    HttpPostedFileBase postedFile = Request.Files[0];
                    if (postedFile == null)
                        return Json(new { success = false, message = "" }, "text/html");

                    var fileName = Path.GetFileName(postedFile.FileName) ?? "";
                    var path = Path.Combine(Globals.RutaTemporales, fileName);
                    if (!System.IO.File.Exists(Globals.RutaTemporales))
                        Directory.CreateDirectory(Globals.RutaTemporales);

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
                        Directory.CreateDirectory(Globals.RutaTemporales);
                    return Json(new { success = true, name = Path.GetFileName(path) }, "text/html");
                }

            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, "", "");
                return Json(new { success = false, message = "Hubo un error al cargar el archivo, intente nuevamente." }, "text/html");
            }
        }

        [HttpPost]
        public ActionResult ImageIncentivoUpload(string qqfile)
        {
            try
            {
                if (String.IsNullOrEmpty(Request["qqfile"]))
                {
                    HttpPostedFileBase postedFile = Request.Files[0];
                    if (postedFile == null)
                        return Json(new { success = false, message = "" }, "text/html");

                    var fileName = Path.GetFileName(postedFile.FileName) ?? "";
                    var path = Path.Combine(Globals.RutaTemporales, fileName);
                    if (!System.IO.File.Exists(Globals.RutaTemporales))
                        Directory.CreateDirectory(Globals.RutaTemporales);

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
                        Directory.CreateDirectory(Globals.RutaTemporales);
                    return Json(new { success = true, name = Path.GetFileName(path) }, "text/html");
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, "", "");
                return Json(new { success = false, message = "Hubo un error al cargar el archivo, intente nuevamente." }, "text/html");
            }
        }

        [HttpPost]
        public ActionResult ImageOfertaGratisUpload(string qqfile)
        {
            try
            {
                if (String.IsNullOrEmpty(Request["qqfile"]))
                {
                    HttpPostedFileBase postedFile = Request.Files[0];

                    if (postedFile == null)
                        return Json(new { success = false, message = "" }, "text/html");

                    var fileName = Path.GetFileName(postedFile.FileName) ?? "";
                    var path = Path.Combine(Globals.RutaImagenesTempOfertas, fileName);
                    if (!System.IO.File.Exists(Globals.RutaImagenesTempOfertas))
                        Directory.CreateDirectory(Globals.RutaImagenesTempOfertas);

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
                        Directory.CreateDirectory(Globals.RutaImagenesTempOfertas);
                    return Json(new { success = true, name = Path.GetFileName(path) }, "text/html");
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, "", "");
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
