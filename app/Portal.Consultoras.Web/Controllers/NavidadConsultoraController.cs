﻿using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceContenido;
using Portal.Consultoras.Web.ServiceZonificacion;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.UI.WebControls;


namespace Portal.Consultoras.Web.Controllers
{
    public class NavidadConsultoraController : BaseController
    {
        public ActionResult Administra()
        {
            NavidadConsultoraModel modelo = new NavidadConsultoraModel();
            modelo.ListaPaises = CargarListaPaises();
            modelo.ListaCampania = CargarListaCampanias(UserData().PaisID);
            return View(modelo);
        }

        public ActionResult Index()
        {
            NavidadConsultoraModel modelo = new NavidadConsultoraModel();
            List<BENavidadConsultora> resultado = new List<BENavidadConsultora>();
            BENavidadConsultora registro = new BENavidadConsultora();
            try
            {
                using (ContenidoServiceClient servicio = new ContenidoServiceClient())
                {
                    BENavidadConsultora parametro = new BENavidadConsultora();
                    parametro.PaisId = UserData().PaisID;
                    parametro.CampaniaId = UserData().CampaniaID;
                    resultado = servicio.BuscarNavidadConsultora(parametro).ToList();
                }
                var carpetaPais = Globals.UrlNavidadConsultora;
                string parametroComparte = "";
                registro = resultado.FirstOrDefault();
                modelo.UrlImagen = ConfigS3.GetUrlFileS3(carpetaPais, registro.NombreImg, "");
                parametroComparte =  Convert.ToString(registro.ImagenId) + "-" +Convert.ToString(registro.PaisId);
                modelo.UrlComparte = Request.Url.Scheme + "://" + Request.Url.Authority + (Request.ApplicationPath.ToString().Equals("/") ? "/" : (Request.ApplicationPath + "/")) + "WebPages/NavidadConsultora.aspx?comparte=" + parametroComparte;
                return View(modelo);
            }
            catch
            {
                return View(modelo);
            }

        }

        public ActionResult ListaNavidadConsultora(int PaisId, int? CampaniaId)
        {

            List<BENavidadConsultora> resultado = new List<BENavidadConsultora>();
            using (ContenidoServiceClient servicio = new ContenidoServiceClient())
            {
                BENavidadConsultora parametro = new BENavidadConsultora();
                parametro.PaisId = PaisId;
                parametro.CampaniaId = CampaniaId;
                resultado = servicio.BuscarNavidadConsultora(parametro).ToList();
            }
            var carpetaPais = Globals.UrlNavidadConsultora;

            if (resultado != null)
                if (resultado.Count > 0) resultado.Update(x => x.NombreImg = ConfigS3.GetUrlFileS3(carpetaPais, x.NombreImg, ""));

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
                                   a.NombreImg.ToString(),
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
            string FileName = string.Empty;
            System.Drawing.Image sourceimage;
            try
            {
                if (String.IsNullOrEmpty(Request["qqfile"]))
                {
                    HttpPostedFileBase postedFile = Request.Files[0];
                    var fileName = Path.GetFileName(postedFile.FileName);
                    sourceimage = System.Drawing.Image.FromStream(postedFile.InputStream);

                    if (sourceimage.Height == 403 && sourceimage.Width == 403 && postedFile.ContentLength <=204800)
                    {
                        var path = Path.Combine(Globals.RutaTemporales, fileName);
                        if (!System.IO.File.Exists(Globals.RutaTemporales))
                            System.IO.Directory.CreateDirectory(Globals.RutaTemporales);
                        postedFile.SaveAs(path);
                        path = Url.Content(Path.Combine(Globals.RutaTemporales, fileName));
                        return Json(new { success = true, name = qqfile, nameFile = fileName }, "text/html");
                    }else {
                        return Json(new { success = false, name = "", nameFile = "" }, "text/html");
                    }
                }
                else
                {
                    Stream inputStream = Request.InputStream;
                    byte[] fileBytes = ReadFully(inputStream);
                    string ffFileName = qqfile;
                    sourceimage = System.Drawing.Image.FromStream(inputStream);
                    if (sourceimage.Height == 403 && sourceimage.Width == 403 && inputStream.Length <= 204800)
                    {
                        var path = Path.Combine(Globals.RutaTemporales, ffFileName);
                        if (!System.IO.File.Exists(Globals.RutaTemporales))
                            System.IO.Directory.CreateDirectory(Globals.RutaTemporales);
                        System.IO.File.WriteAllBytes(path, fileBytes);
                        return Json(new { success = true, name = ffFileName, nameFile = ffFileName }, "text/html");
                    }
                    else
                    {
                        return Json(new { success = false, name = "", nameFile = "" }, "text/html");
                    }
                }
            }
            catch (Exception ex)
            {
                return Json(new { success = false, message = "Hubo un error al cargar el archivo, intente nuevamente." }, "text/html");
            }
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
                        string httpPath = string.Empty;
                        var img = System.Drawing.Image.FromFile(Globals.RutaTemporales + @"\" + System.Net.WebUtility.UrlDecode(ImagenActualizar));
                        img.Dispose();

                        string time = DateTime.Now.Year.ToString() + DateTime.Now.Month.ToString() + DateTime.Now.Minute.ToString() + DateTime.Now.Millisecond.ToString();
                        var newfilename = time + "_" + System.Net.WebUtility.UrlDecode(ImagenActualizar);
                        httpPath = Path.Combine(Globals.RutaTemporales, System.Net.WebUtility.UrlDecode(ImagenActualizar));
                        var carpetaPais = Globals.UrlNavidadConsultora;
                        ConfigS3.SetFileS3(httpPath, carpetaPais, newfilename);
                        httpPath = newfilename;

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
            NavidadConsultoraModel modelo = new NavidadConsultoraModel();
            List<BENavidadConsultora> resultado = new List<BENavidadConsultora>();
            BENavidadConsultora registro = new BENavidadConsultora();
            try
            {
                using (ContenidoServiceClient servicio = new ContenidoServiceClient())
                {
                    BENavidadConsultora parametro = new BENavidadConsultora();
                    parametro.PaisId = Convert.ToInt32(PaisId);
                    parametro.CampaniaId = Convert.ToInt32(CampaniaID);
                    parametro.ImagenId = ImagenId;
                    servicio.EliminarNavidadConsultora(parametro);
                }
                return Json(true, JsonRequestBehavior.AllowGet);
            }
            catch
            {
                return Json(false, JsonRequestBehavior.AllowGet);
            }
        }

        private IEnumerable<CampaniaModel> CargarListaCampanias(int PaisID)
        {
            IList<BECampania> lista;
            using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
            {
                lista = sv.SelectCampanias(PaisID);
            }
            Mapper.CreateMap<BECampania, CampaniaModel>()
                    .ForMember(t => t.CampaniaID, f => f.MapFrom(c => c.CampaniaID))
                    .ForMember(t => t.Codigo, f => f.MapFrom(c => c.Codigo));

            return Mapper.Map<IList<BECampania>, IEnumerable<CampaniaModel>>(lista);
        }

        private IEnumerable<PaisModel> CargarListaPaises()
        {
            List<BEPais> lista;
            using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
            {
                if (UserData().RolID == 2) lista = sv.SelectPaises().ToList();
                else
                {
                    lista = new List<BEPais>();
                    lista.Add(sv.SelectPais(UserData().PaisID));
                }

            }
            Mapper.CreateMap<BEPais, PaisModel>()
                    .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID))
                    .ForMember(t => t.Nombre, f => f.MapFrom(c => c.Nombre))
                    .ForMember(t => t.NombreCorto, f => f.MapFrom(c => c.NombreCorto));

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