using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceContenido;
using Portal.Consultoras.Web.ServiceZonificacion;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web.Mvc;
using System.Web.UI.WebControls;

namespace Portal.Consultoras.Web.Controllers
{
    public class NavidadConsultoraController : BaseController
    {
        public ActionResult Administra()
        {
            NavidadConsultoraModel modelo = new NavidadConsultoraModel
            {
                ListaPaises = CargarListaPaises(),
                ListaCampania = CargarListaCampanias(UserData().PaisID)
            };
            return View(modelo);
        }

        public ActionResult Index()
        {
            NavidadConsultoraModel modelo = new NavidadConsultoraModel();
            try
            {
                List<BENavidadConsultora> resultado;
                using (ContenidoServiceClient servicio = new ContenidoServiceClient())
                {
                    BENavidadConsultora parametro = new BENavidadConsultora
                    {
                        PaisId = UserData().PaisID,
                        CampaniaId = UserData().CampaniaID
                    };
                    resultado = servicio.BuscarNavidadConsultora(parametro).ToList();
                }
                var carpetaPais = Globals.UrlNavidadConsultora;
                var registro = resultado.FirstOrDefault() ?? new BENavidadConsultora();
                modelo.UrlImagen = ConfigCdn.GetUrlFileCdn(carpetaPais, registro.NombreImg);
                var parametroComparte = Convert.ToString(registro.ImagenId) + "-" + Convert.ToString(registro.PaisId);
                if (Request.Url != null)
                    modelo.UrlComparte = Request.Url.Scheme + "://" + Request.Url.Authority +
                                         (Request.ApplicationPath != null && Request.ApplicationPath.Equals("/")
                                             ? "/"
                                             : (Request.ApplicationPath + "/")) +
                                         "WebPages/NavidadConsultora.aspx?comparte=" + parametroComparte;
                return View(modelo);
            }
            catch
            {
                return View(modelo);
            }

        }

        public ActionResult ListaNavidadConsultora(int PaisId, int? CampaniaId)
        {
            List<BENavidadConsultora> resultado;
            BENavidadConsultora parametro = new BENavidadConsultora
            {
                PaisId = PaisId,
                CampaniaId = CampaniaId
            };
            using (ContenidoServiceClient servicio = new ContenidoServiceClient())
            {
                resultado = servicio.BuscarNavidadConsultora(parametro).ToList();
            }
            var carpetaPais = Globals.UrlNavidadConsultora;

            if (resultado.Count > 0)
                resultado.Update(x => x.NombreImg = ConfigCdn.GetUrlFileCdn(carpetaPais, x.NombreImg));

            var data = new
            {
                rows = from a in resultado
                       select new
                       {
                           id = a.ImagenId,
                           cell = new string[]
                               {
                                   a.ImagenId.ToString(),
                                   a.CampaniaId.ToString(),
                                   a.NombreImg,
                                   a.ImagenId.ToString(),
                                   a.PaisId.ToString()
                                }
                       }
            };

            return Json(data, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public ActionResult ImageMatrizUpload(string qqfile)
        {
            try
            {
                int height;
                int width;
                long contentLength;

                if (String.IsNullOrEmpty(Request["qqfile"]))
                {
                    var postedFile = Request.Files[0];
                    if (postedFile != null)
                    {
                        var fileName = Path.GetFileName(postedFile.FileName) ?? "";
                        using (var sourceimage = System.Drawing.Image.FromStream(postedFile.InputStream))
                        {
                            height = sourceimage.Height;
                            width = sourceimage.Width;
                        }
                        contentLength = postedFile.ContentLength;
                        if (TieneImagenAltoAnchoYTamanioValido(height, width, contentLength))
                            return Json(new { success = false, name = "", nameFile = "" }, "text/html");

                        if (!System.IO.File.Exists(Globals.RutaTemporales))
                            Directory.CreateDirectory(Globals.RutaTemporales);

                        var path = Path.Combine(Globals.RutaTemporales, fileName);
                        postedFile.SaveAs(path);

                        return Json(new { success = true, name = qqfile, nameFile = fileName }, "text/html");
                    }
                    return Json(new { success = false, name = qqfile, nameFile = "" }, "text/html");
                }
                else
                {
                    var inputStream = Request.InputStream;
                    var fileBytes = ReadFully(inputStream);
                    using (var sourceimage = System.Drawing.Image.FromStream(inputStream))
                    {
                        height = sourceimage.Height;
                        width = sourceimage.Width;
                    }
                    contentLength = inputStream.Length;
                    if (TieneImagenAltoAnchoYTamanioValido(height, width, contentLength))
                        return Json(new { success = false, name = "", nameFile = "" }, "text/html");

                    if (!System.IO.File.Exists(Globals.RutaTemporales))
                        Directory.CreateDirectory(Globals.RutaTemporales);

                    var path = Path.Combine(Globals.RutaTemporales, qqfile);
                    System.IO.File.WriteAllBytes(path, fileBytes);
                    return Json(new { success = true, name = qqfile, nameFile = qqfile }, "text/html");
                }
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new { success = false, message = "Hubo un error al cargar el archivo, intente nuevamente." }, "text/html");
            }
        }

        private bool TieneImagenAltoAnchoYTamanioValido(int height, int width, long contentLength)
        {
            return height != 403 || width != 403 || contentLength > 204800;
        }

        [HttpPost]
        public ActionResult GuardarImagen(string PaisId, string CampaniaID, string tipoMantenimiento, string ImagenId, string ImagenActualizar)
        {
            if (ModelState.IsValid)
            {
                if (ImagenActualizar != null)
                {
                    BENavidadConsultora parametro = new BENavidadConsultora();
                    try
                    {
                        var img = System.Drawing.Image.FromFile(Globals.RutaTemporales + @"\" + System.Net.WebUtility.UrlDecode(ImagenActualizar));
                        img.Dispose();

                        string time = DateTime.Now.Year.ToString() + DateTime.Now.Month.ToString() + DateTime.Now.Minute.ToString() + DateTime.Now.Millisecond.ToString();
                        var newfilename = time + "_" + System.Net.WebUtility.UrlDecode(ImagenActualizar);
                        var httpPath = Path.Combine(Globals.RutaTemporales, System.Net.WebUtility.UrlDecode(ImagenActualizar));
                        var carpetaPais = Globals.UrlNavidadConsultora;
                        ConfigS3.SetFileS3(httpPath, carpetaPais, newfilename);

                        parametro.PaisId = Convert.ToInt32(PaisId);
                        parametro.CampaniaId = Convert.ToInt32(CampaniaID);
                        parametro.NombreImg = newfilename;
                        using (ContenidoServiceClient servicio = new ContenidoServiceClient())
                        {
                            if (tipoMantenimiento == "Nuevo")
                            {
                                var aviso = servicio.InsertarNavidadConsultora(parametro);
                                if (aviso == 1)
                                {
                                    return Json("true", JsonRequestBehavior.AllowGet);
                                }
                                if (aviso == 0)
                                {
                                    return Json("repetido", JsonRequestBehavior.AllowGet);

                                }
                            }
                            else
                            {
                                parametro.ImagenId = Convert.ToInt32(ImagenId);
                                servicio.EditarNavidadConsultora(parametro);
                                return Json("true", JsonRequestBehavior.AllowGet);
                            }
                        }
                    }
                    catch
                    {
                        return Json("false", JsonRequestBehavior.AllowGet);
                    }
                }
                return Json("error", JsonRequestBehavior.AllowGet);
            }
            return Json("error", JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public ActionResult EliminarImagen(int ImagenId, string PaisId, string CampaniaID)
        {
            try
            {
                using (ContenidoServiceClient servicio = new ContenidoServiceClient())
                {
                    BENavidadConsultora parametro = new BENavidadConsultora
                    {
                        PaisId = Convert.ToInt32(PaisId),
                        CampaniaId = Convert.ToInt32(CampaniaID),
                        ImagenId = ImagenId
                    };
                    servicio.EliminarNavidadConsultora(parametro);
                }
                return Json(true, JsonRequestBehavior.AllowGet);
            }
            catch
            {
                return Json(false, JsonRequestBehavior.AllowGet);
            }
        }

        private IEnumerable<CampaniaModel> CargarListaCampanias(int paisId)
        {
            IList<BECampania> lista;
            using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
            {
                lista = sv.SelectCampanias(paisId);
            }

            return Mapper.Map<IList<BECampania>, IEnumerable<CampaniaModel>>(lista);
        }

        private IEnumerable<PaisModel> CargarListaPaises()
        {
            List<BEPais> lista;
            using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
            {
                lista = UserData().RolID == 2
                    ? sv.SelectPaises().ToList()
                    : new List<BEPais> { sv.SelectPais(UserData().PaisID) };
            }

            return Mapper.Map<IList<BEPais>, IEnumerable<PaisModel>>(lista);
        }

        public static byte[] ReadFully(Stream input)
        {
            byte[] buffer = new byte[input.Length];
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