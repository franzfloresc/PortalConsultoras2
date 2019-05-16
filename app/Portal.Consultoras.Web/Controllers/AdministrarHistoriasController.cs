﻿using AutoMapper;

using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceSAC;
using Portal.Consultoras.Web.ServiceUsuario;

using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.ServiceModel;
using System.Web.Mvc;
using System.Threading.Tasks;
using Portal.Consultoras.Web.ServiceContenido;
using System.Configuration;
using System.Net;

namespace Portal.Consultoras.Web.Controllers
{
    public class AdministrarHistoriasController : BaseAdmController
    {
        private static class _accion
        {
            public const int Nuevo = 1;
            public const int Editar = 2;
            public const int NuevoDatos = 3;
            public const int Deshabilitar = 4;
        }

        public ActionResult Index()
        {
            var model = new AdministrarHistorialModel();
            string[] arrUrlMiniatura;
            string[] arrHistAnchoAlto;

            try
            {
                if (!UsuarioModel.HasAcces(ViewBag.Permiso, "AdministrarHistorias/Index"))
                    return RedirectToAction("Index", "Bienvenida");
                ViewBag.UrlS3 = GetUrlS3();
                ViewBag.UrlDetalleS3 = GetUrlDetalleS3();
                model.ListaCampanias = _zonificacionProvider.GetCampanias(userData.PaisID);
              
                string HistAnchoAlto = ConfigurationManager.AppSettings["HistAnchoAlto"];
                arrHistAnchoAlto = HistAnchoAlto.Split(',');
                model.Ancho = arrHistAnchoAlto[0];
                model.Alto = arrHistAnchoAlto[1];

                BEContenidoAppHistoria entidad;
                using (var sv = new ServiceContenido.ContenidoServiceClient())
                {
                    
                    entidad = sv.GetContenidoAppHistoria(userData.PaisID, Globals.CodigoHistoriasResumen);                    

                    model.IdContenido = entidad.IdContenido;
                    model.Codigo = entidad.Codigo;
                    model.Descripcion = entidad.Descripcion;
                    model.Estado = entidad.Estado;
                    model.CantidadContenido = entidad.CantidadContenido;
                }

                if (entidad.UrlMiniatura == string.Empty)
                {
                    model.NombreImagenAnterior = Url.Content("~/Content/Images/") + "Question.png";
                    model.NombreImagen = "";
                }
                else
                {
                    arrUrlMiniatura = entidad.UrlMiniatura.Split('/');
                    model.NombreImagenAnterior = ViewBag.UrlS3 + arrUrlMiniatura[5];
                    model.NombreImagen = "";
                }
                return View(model);
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
                return View(model);
            }
        }

        private string GetUrlS3()
        {
            var paisIso = Util.GetPaisISO(userData.PaisID);
            return ConfigCdn.GetUrlCdnAppConsultora(paisIso);
        }
        private string GetUrlDetalleS3()
        {
            var paisIso = Util.GetPaisISO(userData.PaisID);
            return ConfigCdn.GetUrlCdnAppConsultoraDetalle(paisIso);
        }

        [HttpPost]
        public ActionResult Update(AdministrarHistorialModel form)
        {
            try
            {
                if (form.NombreImagen != null) {
                    BEContenidoAppHistoria beContenidoApp;
                    using (ContenidoServiceClient sv = new ServiceContenido.ContenidoServiceClient())
                    {
                        beContenidoApp = sv.GetContenidoAppHistoria(userData.PaisID, form.Codigo);
                    }

                    var entidad = new BEContenidoAppHistoria();
                    entidad.UrlMiniatura = beContenidoApp.UrlMiniatura;
                    if (form.NombreImagen != null)
                    {
                        string histUrlMiniatura = ConfigurationManager.AppSettings["HistUrlMiniatura"];
                        entidad.UrlMiniatura = SaveFileS3(form.NombreImagen, true);
                        entidad.UrlMiniatura = histUrlMiniatura + entidad.UrlMiniatura;
                    }
                    entidad.IdContenido = form.IdContenido;
                    using (ContenidoServiceClient sv = new ServiceContenido.ContenidoServiceClient())
                    {
                        sv.UpdateContenidoApp(userData.PaisID, entidad);
                    }
                    return Json(new
                    {
                        success = true,
                        message = "Se actualizó satisfactoriamente.",
                        extra = ""
                    });
                }
                else
                {
                    return Json(new
                    {
                        success = false,
                        message = "No seleccionó una imagen.",
                        extra = ""
                    });
                }

                
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "No se pudo realizar la carga de la Imagen.",
                    extra = ""
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "No se pudo realizar la carga de la Imagen.",
                    extra = ""
                });
            }
        }

        [HttpPost]
        public ActionResult InsertDet(AdministrarHistorialModel form)
        {
            try
            {
                var tempNombreImagen = form.NombreImagen;
                var entidad = new BEContenidoAppDeta
                {
                    IdContenido = form.IdContenido,
                    RutaContenido = "1.jpg",
                    Tipo = "IMAGEN"
                };

                using (ContenidoServiceClient sv = new ContenidoServiceClient())
                {
                    sv.InsertContenidoAppDeta(userData.PaisID, entidad);
                }


                return Json(new
                {
                    success = true,
                    message = "Se inserto satisfactoriamente.",
                    extra = ""
                });
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "No se pudo realizar la carga de la Imagen.",
                    extra = ""
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "No se pudo realizar la carga de la Imagen.",
                    extra = ""
                });
            }
        }

        public JsonResult ComponenteListar(string sidx, string sord, int page, int rows, int IdContenido, string Campania)
        {
            try
            {
                var list = ComponenteListarDetService(IdContenido, Campania);
                var grid = new BEGrid
                {
                    PageSize = rows,
                    CurrentPage = page,
                    SortColumn = sidx,
                    SortOrder = sord
                };
                var items = list.Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);
                var pag = Util.PaginadorGenerico(grid, list.ToList());
                var data = new
                {
                    total = pag.PageCount,
                    page = pag.CurrentPage,
                    records = pag.RecordCount,
                    rows = from a in items
                           select new
                           {
                               //id = a.IdContenidoDeta,
                               cell = new string[]
                                {
                                    a.IdContenidoDeta.ToString(),
                                    a.Tipo,
                                    a.Orden.ToString(),
                                    a.RutaContenido,
                                    a.IdContenido.ToString(),
                                    a.Campania.ToString(),
                                    a.Region,
                                    a.Zona,
                                    a.Seccion,
                                    a.Accion,
                                    a.CodigoDetalle                                    
                                }
                           }
                };
                return Json(data, JsonRequestBehavior.AllowGet);

            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new { success = false });
            }
        }

        private IEnumerable<ServiceContenido.BEContenidoAppList> ComponenteListarDetService(int IdContenido, string Campania)
        {
            List<ServiceContenido.BEContenidoAppList> listaEntidad = new List<ServiceContenido.BEContenidoAppList>();

            try
            {
                var entidad = new BEContenidoAppList
                {
                    IdContenido = IdContenido
                };

                using (var sv = new ContenidoServiceClient())
                {
                    listaEntidad = sv.ListContenidoApp(userData.PaisID, entidad).ToList();
                }
                if (Campania != "")
                {
                    var lista = from a in listaEntidad
                                where a.Campania == Convert.ToInt32(Campania)
                                select a;
                    listaEntidad = lista.ToList();
                }
               
            }
            catch (Exception ex)
            {
                logManager.LogErrorWebServicesBusWrap(ex, userData.CodigoUsuario, userData.PaisID.ToString(),
                    "AdministrarHistoriasController.ComponenteListarDetService");
            }
            return listaEntidad;
        }

        public ActionResult ComponenteObtenerViewDatos(AdministrarHistorialDetaUpdModel entidad)
        {
            AdministrarHistorialDetaUpdModel modelo;
            try
            {
                modelo = new AdministrarHistorialDetaUpdModel
                {
                    IdContenidoDeta = entidad.IdContenidoDeta,
                    IdContenido = entidad.IdContenido
                };
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                modelo = new AdministrarHistorialDetaUpdModel();
            }
            return PartialView("Partials/MantenimientoEstado", modelo);
        }

        public ActionResult ComponenteObtenerVerImagen(AdministrarHistorialDetaUpdModel entidad)
        {
            AdministrarHistorialDetaUpdModel modelo;
            try
            {
               string url = GetUrlDetalleS3();
                modelo = new AdministrarHistorialDetaUpdModel
                {
                    IdContenidoDeta = entidad.IdContenidoDeta,
                    IdContenido = entidad.IdContenido,
                    RutaImagen = url + entidad.RutaImagen,
                };
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                modelo = new AdministrarHistorialDetaUpdModel();
            }
            return PartialView("Partials/PopupImagen", modelo);
        }

        public JsonResult ComponenteDatosGuardar(AdministrarHistorialDetaUpdModel form)
        {
            int valRespuesta = 0;
            try
            {
                var entidad = new BEContenidoAppDeta
                {
                    IdContenidoDeta = form.IdContenidoDeta,
                    IdContenido = form.IdContenido

                };
                using (var sv = new ServiceContenido.ContenidoServiceClient())
                {
                    valRespuesta = sv.UpdateContenidoAppDeta(userData.PaisID, entidad);
                }

                return Json(new { success = valRespuesta > 0 });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new { success = false });
            }
        }

        public ActionResult GetDetalle(int Proc, int IdContenido)
        {
            string HistAnchoAlto = ConfigurationManager.AppSettings["HistAnchoAltoDetalle"];
            string[] arrHistAnchoAlto;
            arrHistAnchoAlto = HistAnchoAlto.Split(',');

            var model = new AdministrarHistorialDetaListModel();
            model.Proc = Proc;
            model.IdContenido = IdContenido;
            model.Ancho = arrHistAnchoAlto[0];
            model.Alto = arrHistAnchoAlto[1];

            model.ListaCampanias = _zonificacionProvider.GetCampanias(userData.PaisID, true);
            model.ListaAccion = GetContenidoAppDetaActService(0);     
            model.ListaCodigoDetalle = GetContenidoAppDetaActService(1);

            
            BEContenidoAppHistoria entidad;
            using (var sv = new ServiceContenido.ContenidoServiceClient())
            {

                entidad = sv.GetContenidoAppHistoria(userData.PaisID, Globals.CodigoHistoriasResumen);
                model.CantidadContenido = entidad.CantidadContenido;
            }

            return PartialView("Partials/MantenimientoDetalle", model);

        }

        [HttpPost]
        public JsonResult Detalle(AdministrarHistorialDetaListModel model)
        {
            try
            {

                model = UpdateFilesDetalles(model);

                using (ContenidoServiceClient sv = new ContenidoServiceClient())
                {
                    
                        var entidad = new BEContenidoAppDeta
                        {
                            Proc = model.Proc,
                            IdContenidoDeta = model.IdContenidoDeta,
                            IdContenido = model.IdContenido,
                            RutaContenido = model.RutaContenido,
                            Campania = model.Campania,
                            Accion = model.Accion,
                            CodigoDetalle = model.CodigoDetalle,
                            Tipo = "IMAGEN"

                        };

                        sv.InsertContenidoAppDeta(userData.PaisID, entidad);
                                      
                }

                return Json(new
                {
                    success = true,
                    message = "Se actualizó la información satisfactoriamente",
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.StackTrace,
                });
            }
        }

        private AdministrarHistorialDetaListModel UpdateFilesDetalles(AdministrarHistorialDetaListModel model)
        {
            var resizeImagenApp = false;


            model.RutaContenido = SaveFileDetalleS3(model.RutaContenido, true);
            if (model.RutaContenido != string.Empty) resizeImagenApp = true;


            if (resizeImagenApp)
            {
                string codeHist = ConfigurationManager.AppSettings["CodigoHist"].ToString();
                var urlImagen = ConfigS3.GetUrlFileHistDetalle(userData.CodigoISO, model.RutaContenido);               
                new Providers.RenderImgProvider().ImagenesResizeProcesoAppHistDetalle(urlImagen, userData.CodigoISO, userData.PaisID, codeHist);
            }

            return model;
        }

        private string SaveFileS3(string imagenEstrategia, bool mantenerExtension = false)
        {
            imagenEstrategia = Util.Trim(imagenEstrategia);
            if (imagenEstrategia == string.Empty)
                return string.Empty;

            var path = Path.Combine(Globals.RutaTemporales, imagenEstrategia);

            string cadena = Globals.UrlMatrizAppConsultora;
            string[] arrCadena;
            arrCadena = cadena.Split(',');
            var carpetaPais = string.Format("{0}/{1}/{2}/{3}", arrCadena[0], userData.CodigoISO, arrCadena[1], arrCadena[2]);

            var time = string.Concat(DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.Minute, DateTime.Now.Millisecond);
            var ext = !mantenerExtension ? ".png" : Path.GetExtension(path);
            var newfilename = string.Concat(userData.CodigoISO, "_", time, "_", FileManager.RandomString(), ext);
            ConfigS3.SetFileS3(path, carpetaPais, newfilename);
            return newfilename;
        }

        private string SaveFileDetalleS3(string imagenEstrategia, bool mantenerExtension = false)
        {
            imagenEstrategia = Util.Trim(imagenEstrategia);
            if (imagenEstrategia == string.Empty)
                return string.Empty;

            var path = Path.Combine(Globals.RutaTemporales, imagenEstrategia);

            string cadena = Globals.UrlMatrizAppConsultora;
            string[] arrCadena;
            arrCadena = cadena.Split(',');
            var carpetaPais = string.Format("{0}/{1}/{2}", arrCadena[0], userData.CodigoISO, arrCadena[1]);

            var time = string.Concat(DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.Minute, DateTime.Now.Millisecond);
            var ext = !mantenerExtension ? ".png" : Path.GetExtension(path);
            var newfilename = string.Concat(userData.CodigoISO, "_", time, "_", FileManager.RandomString(), ext);
            ConfigS3.SetFileS3(path, carpetaPais, newfilename);
            return newfilename;
        }
     
        private IEnumerable<AdministrarHistorialDetaActModel> GetContenidoAppDetaActService(int Parent)
        {
           
            List<AdministrarHistorialDetaActModel> listaEntidad;

            try
            {
                List<BEContenidoAppDetaAct> listaDatos;
                using (var sv = new ContenidoServiceClient())
                {
                    listaDatos = sv.GetContenidoAppDetaActList(userData.PaisID).ToList();
                }
                var lista = from a in listaDatos
                            where a.Parent == Parent
                            select a;
                listaEntidad = Mapper.Map<IList<BEContenidoAppDetaAct>, List<AdministrarHistorialDetaActModel>>(lista.ToList());

            }
            catch (Exception ex)
            {
                listaEntidad = new List<AdministrarHistorialDetaActModel>();
                logManager.LogErrorWebServicesBusWrap(ex, userData.CodigoUsuario, userData.PaisID.ToString(),
                    "AdministrarHistoriasController.GetContenidoAppDetaActService");
            }
            return listaEntidad;
            //return listaEntidad.Where(p => p.Parent == 0);



        }

        public ActionResult ComponenteDetalleEditarViewDatos(AdministrarHistorialDetaListModel entidad)
        {
            AdministrarHistorialDetaListModel model = new AdministrarHistorialDetaListModel();

            string HistAnchoAlto = ConfigurationManager.AppSettings["HistAnchoAltoDetalle"];
            string[] arrHistAnchoAlto;
            arrHistAnchoAlto = HistAnchoAlto.Split(',');
            model.Ancho = arrHistAnchoAlto[0];
            model.Alto = arrHistAnchoAlto[1];

            try
            {
                model.Proc = entidad.Proc;
                model.ListaCampanias = _zonificacionProvider.GetCampanias(userData.PaisID, true);
                model.ListaAccion = GetContenidoAppDetaActService(0);
                model.ListaCodigoDetalle = GetContenidoAppDetaActService(1);

                model.IdContenidoDeta = entidad.IdContenidoDeta;
                model.IdContenido = entidad.IdContenido;
                model.Campania = entidad.Campania;
                model.Accion = entidad.Accion;
                model.CodigoDetalle = entidad.CodigoDetalle;
                model.CUV = entidad.CodigoDetalle;             
                
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                model = new AdministrarHistorialDetaListModel();
            }
            return PartialView("Partials/MantenimientoDetalle", model);
        }
    }
}