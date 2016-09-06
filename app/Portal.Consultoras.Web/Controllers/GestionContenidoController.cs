using Portal.Consultoras.Web.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.ServiceContenido;
using Portal.Consultoras.Web.ServiceZonificacion;
using AutoMapper;
using System.Net;
using Portal.Consultoras.Web.ServiceUsuario;
using System.ServiceModel;
using Portal.Consultoras.Web.ServicePedido;

namespace Portal.Consultoras.Web.Controllers
{
    public class GestionContenidoController : BaseController
    {
        #region Actions

        public ActionResult Index()
        {
            try
            {
                if (!UsuarioModel.HasAcces(ViewBag.Permiso, "GestionContenido/Index"))
                    return RedirectToAction("Index", "Bienvenida");
            }
            catch (FaultException ex) 
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
            }
            return View();
        }

        public ActionResult ConfiguracionFormulariosInformativos()
        {
            if (!UsuarioModel.HasAcces(ViewBag.Permiso, "GestionContenido/ConfiguracionFormulariosInformativos"))
                return RedirectToAction("Index", "Bienvenida");
            var model = new FormularioInformativoModel()
            {
                listaPaises = DropDowListPaises()
            };
            return View(model);
        }


        public JsonResult GetFondoLogin()
        {
            BEFormularioDato entidad = new BEFormularioDato();
            using (ContenidoServiceClient sv = new ContenidoServiceClient())
            {
                entidad = sv.SelectFormularioDato(ETipoFormulario.Login);
            }
            return Json(new
            {
                Entidad = entidad
            }, JsonRequestBehavior.AllowGet);
              
        }

        public ActionResult FondoLogin()
        {
            if (!UsuarioModel.HasAcces(ViewBag.Permiso, "GestionContenido/FondoLogin"))
                return RedirectToAction("Index", "Bienvenida");
            BEFormularioDato entidad = new BEFormularioDato();
            FondoLoginModel model = new FondoLoginModel();

            using (ContenidoServiceClient sv = new ContenidoServiceClient())
            {
                entidad = sv.SelectFormularioDato(ETipoFormulario.Login);
            }

            if (entidad.Archivo.ToString() == string.Empty)
            {
                model.NombreImagenAnterior = Url.Content("~/Content/Images/") + "Question.png";
                model.NombreImagen = "Question.png";
            }
            else
            {
                model.NombreImagenAnterior = Url.Content("~/Content/Images/login/") + entidad.Archivo;
                model.NombreImagen = entidad.Archivo;
            }
            model.PaisID = entidad.PaisID;
            model.FormularioDatoID = entidad.FormularioDatoID;

            return View(model);
        }

        [HttpPost]
        public ActionResult Update(FondoLoginModel form)
        {
            try
            {
                string tempNombreImagen = string.Empty;
                tempNombreImagen = form.NombreImagen;
                BEFormularioDato entidad = new BEFormularioDato();
                entidad.PaisID = form.PaisID;
                entidad.FormularioDatoID = form.FormularioDatoID;
                entidad.Descripcion = string.Empty;
                entidad.URL = string.Empty;
                entidad.TipoFormularioID = ETipoFormulario.Login;
                entidad.Archivo = FileManager.CopyImages(Globals.RutaImagenesFondoLogin, tempNombreImagen, Globals.RutaImagenesTemp);

                using (ContenidoServiceClient sv = new ContenidoServiceClient())
                {
                    sv.UpdateFormularioDato(entidad);
                }
                FileManager.DeleteImagesInFolder(Globals.RutaImagenesTemp);
                FileManager.DeleteFilter(Globals.RutaImagenesFondoLogin, entidad.Archivo);

                return Json(new
                {
                    success = true,
                    message = "Se actualizó satisfactoriamente el fondo de Imagen de la pantalla.",
                    extra = ""
                });
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "No se pudo realizar la carga de la Imagen.",
                    extra = ""
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "No se pudo realizar la carga de la Imagen.",
                    extra = ""
                });
            }
        }

        public JsonResult GetResumenCampania()
        {
            try
            {
                var PaisID = userData.PaisID;
                var pedidoWeb = ObtenerPedidoWeb();
                var pedidoWebDetalle = ObtenerPedidoWebDetalle();
                var ultimosTresPedidos = pedidoWebDetalle.Count > 0 ?
                                         pedidoWebDetalle.Take(3).ToList() :
                                         new List<BEPedidoWebDetalle>();
                var totalPedido = pedidoWebDetalle.Sum(p => p.ImporteTotal);
                return Json(new
                {
                    result = true,
                    montoWebAcumulado = pedidoWebDetalle.Sum(p => p.ImporteTotal),
                    cantidadProductos = pedidoWebDetalle.Sum(p => p.Cantidad),
                    ultimosTresPedidos = ultimosTresPedidos,
                    Simbolo = userData.Simbolo,
                    paisID = PaisID,
                    montoWebConDescuentoStr = Util.DecimalToStringFormat(totalPedido - pedidoWeb.DescuentoProl, userData.CodigoISO),
                    DescuentoProlStr = Util.DecimalToStringFormat(pedidoWeb.DescuentoProl, userData.CodigoISO),
                }, JsonRequestBehavior.AllowGet);

            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    result = false
                }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    result = false
                }, JsonRequestBehavior.AllowGet);
            }
        }

        public BEUsuario GetUserData(int PaisID, string Codigo)
        {
            BEUsuario oBEUsuario = null;
            using (UsuarioServiceClient sv = new UsuarioServiceClient())
            {
                oBEUsuario = sv.GetSesionUsuario(PaisID, Codigo);
            }
            return oBEUsuario;
        }

        public JsonResult ValidUrl(string url)
        {
            try
            {
                HttpWebRequest request = WebRequest.Create(url) as HttpWebRequest;
                request.Method = "HEAD";
                HttpWebResponse response = request.GetResponse() as HttpWebResponse;
                if (response.StatusCode == HttpStatusCode.OK)
                    return Json(new
                    {
                        result = true
                    }, JsonRequestBehavior.AllowGet);
                else
                    return Json(new
                    {
                        result = false
                    }, JsonRequestBehavior.AllowGet);

            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    result = false
                }, JsonRequestBehavior.AllowGet);
            }
        }

        private IEnumerable<PaisModel> DropDowListPaises()
        {
            IList<BEPais> lst;
            using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
            {
                lst = sv.SelectPaises();
            }
            Mapper.CreateMap<BEPais, PaisModel>()
                    .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID))
                    .ForMember(t => t.Nombre, f => f.MapFrom(c => c.Nombre))
                    .ForMember(t => t.NombreCorto, f => f.MapFrom(c => c.NombreCorto));

            return Mapper.Map<IList<BEPais>, IEnumerable<PaisModel>>(lst);
        }

        [HttpPost]
        public JsonResult Mantener(FormularioInformativoModel model)
        {
            if (model.FormularioDatoID == 0)
                return InsertBelCenter(model);
            else
                return UpdateBelCenter(model);
        }

        [HttpPost]
        public JsonResult MantenerPoliticas(FormularioInformativoModel model)
        {
            if (model.FormularioDatoID == 0)
                return InsertBelrPoliticas(model);
            else
                return UpdateBelPoliticas(model);
        }

        [HttpPost]
        public JsonResult MantenerContratos(FormularioInformativoModel model)
        {
            if (model.FormularioDatoID == 0)
                return InsertBelContratos(model);
            else
                return UpdateBelContratos(model);
        }

        [HttpPost]
        public JsonResult MantenerLugaresdePago(FormularioInformativoModel model)
        {
            if (model.FormularioDatoID == 0)
                return InsertLugaresPago(model);
            else
                return UpdateLugaresPago(model);
        }

        [HttpPost]
        public JsonResult InsertLugaresPago(FormularioInformativoModel model)
        {
            try
            {
                Mapper.CreateMap<FormularioInformativoModel, BEFormularioDato>()
                    .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID))
                    .ForMember(t => t.URL, f => f.MapFrom(c => c.URL))
                    .ForMember(t => t.Archivo, f => f.MapFrom(c => c.NombreArchivoPdf));

                BEFormularioDato entidad = Mapper.Map<FormularioInformativoModel, BEFormularioDato>(model);

                using (ContenidoServiceClient sv = new ContenidoServiceClient())
                {
                    entidad.Archivo = string.Empty;
                    entidad.TipoFormularioID = ETipoFormulario.LugaresPago;
                    sv.InsertFormularioDato(entidad);
                }
                return Json(new
                {
                    success = true,
                    message = "Se ha registrado satisfactoriamente los Lugares de Pago.",
                    extra = ""
                });
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    extra = ""
                });
            }
        }

        [HttpPost]
        public JsonResult UpdateLugaresPago(FormularioInformativoModel model)
        {
            try
            {
                Mapper.CreateMap<FormularioInformativoModel, BEFormularioDato>()
                    .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID))
                    .ForMember(t => t.URL, f => f.MapFrom(c => c.URL))
                    .ForMember(t => t.Archivo, f => f.MapFrom(c => c.NombreArchivoPdf));

                BEFormularioDato entidad = Mapper.Map<FormularioInformativoModel, BEFormularioDato>(model);

                using (ContenidoServiceClient sv = new ContenidoServiceClient())
                {
                    entidad.Archivo = string.Empty;
                    entidad.TipoFormularioID = ETipoFormulario.LugaresPago;
                    sv.UpdateFormularioDato(entidad);
                }
                return Json(new
                {
                    success = true,
                    message = "Se ha actualizado satisfactoriamente el Lugar de Pago.",
                    extra = ""
                });
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    extra = ""
                });
            }
        }

        [HttpPost]
        public JsonResult InsertBelContratos(FormularioInformativoModel model)
        {
            try
            {
                Mapper.CreateMap<FormularioInformativoModel, BEFormularioDato>()
                    .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID))
                    .ForMember(t => t.URL, f => f.MapFrom(c => c.URL))
                    .ForMember(t => t.Archivo, f => f.MapFrom(c => c.NombreArchivoPdf));

                BEFormularioDato entidad = Mapper.Map<FormularioInformativoModel, BEFormularioDato>(model);

                using (ContenidoServiceClient sv = new ContenidoServiceClient())
                {
                    entidad.Archivo = string.Empty;
                    entidad.Descripcion = string.Empty;
                    entidad.FormularioDatoID = 1;
                    entidad.TipoFormularioID = ETipoFormulario.Contratos;
                    sv.InsertFormularioDato(entidad);
                }
                return Json(new
                {
                    success = true,
                    message = "Se ha registrado satisfactoriamente los datos del Formulario.",
                    extra = ""
                });
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    extra = ""
                });
            }
        }

        [HttpPost]
        public JsonResult UpdateBelContratos(FormularioInformativoModel model)
        {
            try
            {
                Mapper.CreateMap<FormularioInformativoModel, BEFormularioDato>()
                    .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID))
                    .ForMember(t => t.URL, f => f.MapFrom(c => c.URL))
                    .ForMember(t => t.FormularioDatoID, f => f.MapFrom(c => c.FormularioDatoID))
                    .ForMember(t => t.Archivo, f => f.MapFrom(c => c.NombreArchivoPdf));

                BEFormularioDato entidad = Mapper.Map<FormularioInformativoModel, BEFormularioDato>(model);

                using (ContenidoServiceClient sv = new ContenidoServiceClient())
                {
                    entidad.Archivo = string.Empty;
                    entidad.Descripcion = string.Empty;
                    entidad.TipoFormularioID = ETipoFormulario.Contratos;
                    sv.UpdateFormularioDato(entidad);
                }
                return Json(new
                {
                    success = true,
                    message = "Se ha actualizado satisfactoriamente los datos del Formulario.",
                    extra = ""
                });
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    extra = ""
                });
            }
        }

        [HttpPost]
        public JsonResult InsertBelrPoliticas(FormularioInformativoModel model)
        {
            try
            {
                Mapper.CreateMap<FormularioInformativoModel, BEFormularioDato>()
                    .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID))
                    .ForMember(t => t.URL, f => f.MapFrom(c => c.URL))
                    .ForMember(t => t.Archivo, f => f.MapFrom(c => c.NombreArchivoPdf));

                BEFormularioDato entidad = Mapper.Map<FormularioInformativoModel, BEFormularioDato>(model);

                using (ContenidoServiceClient sv = new ContenidoServiceClient())
                {
                    entidad.Archivo = string.Empty;
                    entidad.Descripcion = string.Empty;
                    entidad.FormularioDatoID = 1;
                    entidad.TipoFormularioID = ETipoFormulario.Politicas;
                    sv.InsertFormularioDato(entidad);
                }
                return Json(new
                {
                    success = true,
                    message = "Se ha registrado satisfactoriamente los datos del Formulario.",
                    extra = ""
                });
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    extra = ""
                });
            }
        }

        [HttpPost]
        public JsonResult UpdateBelPoliticas(FormularioInformativoModel model)
        {
            try
            {
                Mapper.CreateMap<FormularioInformativoModel, BEFormularioDato>()
                    .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID))
                    .ForMember(t => t.URL, f => f.MapFrom(c => c.URL))
                    .ForMember(t => t.FormularioDatoID, f => f.MapFrom(c => c.FormularioDatoID))
                    .ForMember(t => t.Archivo, f => f.MapFrom(c => c.NombreArchivoPdf));

                BEFormularioDato entidad = Mapper.Map<FormularioInformativoModel, BEFormularioDato>(model);

                using (ContenidoServiceClient sv = new ContenidoServiceClient())
                {
                    entidad.Archivo = string.Empty;
                    entidad.Descripcion = string.Empty;
                    entidad.TipoFormularioID = ETipoFormulario.Politicas;
                    sv.UpdateFormularioDato(entidad);
                }
                return Json(new
                {
                    success = true,
                    message = "Se ha actualizado satisfactoriamente los datos del Formulario.",
                    extra = ""
                });
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    extra = ""
                });
            }
        }

        [HttpPost]
        public JsonResult InsertBelCenter(FormularioInformativoModel model)
        {
            try
            {
                Mapper.CreateMap<FormularioInformativoModel, BEFormularioDato>()
                    .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID))
                    .ForMember(t => t.URL, f => f.MapFrom(c => c.URL))
                    .ForMember(t => t.Archivo, f => f.MapFrom(c => c.NombreArchivoPdf));

                BEFormularioDato entidad = Mapper.Map<FormularioInformativoModel, BEFormularioDato>(model);

                using (ContenidoServiceClient sv = new ContenidoServiceClient())
                {
                    entidad.Archivo = string.Empty;
                    entidad.Descripcion = string.Empty;
                    entidad.FormularioDatoID = 1;
                    entidad.TipoFormularioID = ETipoFormulario.Belcenter;
                    sv.InsertFormularioDato(entidad);
                }
                return Json(new
                {
                    success = true,
                    message = "Se ha registrado satisfactoriamente los datos del Formulario.",
                    extra = ""
                });
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    extra = ""
                });
            }
        }

        [HttpPost]
        public JsonResult UpdateBelCenter(FormularioInformativoModel model)
        {
            try
            {
                Mapper.CreateMap<FormularioInformativoModel, BEFormularioDato>()
                    .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID))
                    .ForMember(t => t.URL, f => f.MapFrom(c => c.URL))
                    .ForMember(t => t.FormularioDatoID, f => f.MapFrom(c => c.FormularioDatoID))
                    .ForMember(t => t.Archivo, f => f.MapFrom(c => c.NombreArchivoPdf));

                BEFormularioDato entidad = Mapper.Map<FormularioInformativoModel, BEFormularioDato>(model);

                using (ContenidoServiceClient sv = new ContenidoServiceClient())
                {
                    entidad.Archivo = string.Empty;
                    entidad.Descripcion = string.Empty;
                    entidad.TipoFormularioID = ETipoFormulario.Belcenter;
                    sv.UpdateFormularioDato(entidad);
                }
                return Json(new
                {
                    success = true,
                    message = "Se ha actualizado satisfactoriamente los datos del Formulario.",
                    extra = ""
                });
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    extra = ""
                });
            }
        }

        [HttpPost]
        public JsonResult InsertBelResponde(FormularioInformativoModel model)
        {
            try
            {
                Mapper.CreateMap<FormularioInformativoModel, BEFormularioDato>()
                    .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID))
                    .ForMember(t => t.URL, f => f.MapFrom(c => c.URL))
                    .ForMember(t => t.Descripcion, f => f.MapFrom(c => c.Descripcion))
                    .ForMember(t => t.Archivo, f => f.MapFrom(c => c.NombreArchivoPdf));

                BEFormularioDato entidad = Mapper.Map<FormularioInformativoModel, BEFormularioDato>(model);

                using (ContenidoServiceClient sv = new ContenidoServiceClient())
                {
                    entidad.Archivo = string.Empty;
                    entidad.URL = string.Empty;
                    entidad.TipoFormularioID = ETipoFormulario.Telefonos;
                    sv.InsertFormularioDato(entidad);
                }
                List<BEFormularioDato> lst = new List<BEFormularioDato>();
                using (ContenidoServiceClient sv = new ContenidoServiceClient())
                {
                    lst = sv.SelectFormularioDatoByPais(model.PaisID, ETipoFormulario.Telefonos).ToList();
                }

                return Json(new
                {
                    success = true,
                    message = "Formulario BelCenter registrado satisfactoriamente.",
                    lista = lst,
                    extra = ""
                });
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    extra = ""
                });
            }
        }

        public JsonResult Eliminar(int PaisID, int FormularioDatoID)
        {
            try
            {
                using (ContenidoServiceClient sv = new ContenidoServiceClient())
                {
                    sv.DeleteFormularioDato(PaisID, ETipoFormulario.Telefonos, FormularioDatoID);
                }

                List<BEFormularioDato> lst = new List<BEFormularioDato>();
                using (ContenidoServiceClient sv = new ContenidoServiceClient())
                {
                    lst = sv.SelectFormularioDatoByPais(PaisID, ETipoFormulario.Telefonos).ToList();
                }

                return Json(new
                {
                    success = true,
                    message = "Se elimino satisfactoriamente el registro",
                    extra = "",
                    lista = lst
                });

            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    extra = ""
                });
            }
        }

        public JsonResult ObteneterFormularioDato(int PaisID)
        {
            List<BEFormularioDato> lst = new List<BEFormularioDato>();
            using (ContenidoServiceClient sv = new ContenidoServiceClient())
            {
                lst = sv.SelectFormularioDatoByPais(PaisID, ETipoFormulario.Belcenter).ToList();
            }

            return Json(new
            {
                entidad = lst
            }, JsonRequestBehavior.AllowGet);
        }

        public JsonResult ObteneterFormularioDatoTerminos(int PaisID)
        {
            List<BEFormularioDato> lst = new List<BEFormularioDato>();
            using (ContenidoServiceClient sv = new ContenidoServiceClient())
            {
                lst = sv.SelectFormularioDatoByPais(PaisID, ETipoFormulario.Politicas).ToList();
            }

            return Json(new
            {
                entidad = lst
            }, JsonRequestBehavior.AllowGet);
        }

        public JsonResult ObtenerListaFormularioDatoTelefonos(int PaisID)
        {
            List<BEFormularioDato> lst = new List<BEFormularioDato>();
            using (ContenidoServiceClient sv = new ContenidoServiceClient())
            {
                lst = sv.SelectFormularioDatoByPais(PaisID, ETipoFormulario.Telefonos).ToList();
            }

            return Json(new
            {
                lista = lst
            }, JsonRequestBehavior.AllowGet);
        }

        public JsonResult ObteneterFormularioDatoCartas(int PaisID)
        {
            List<BEFormularioDato> lst = new List<BEFormularioDato>();
            using (ContenidoServiceClient sv = new ContenidoServiceClient())
            {
                lst = sv.SelectFormularioDatoByPais(PaisID, ETipoFormulario.Contratos).ToList();
            }

            return Json(new
            {
                entidad = lst
            }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult ConsultarLugaresDePago(string sidx, string sord, int page, int rows, int PaisID)
        {
            if (ModelState.IsValid)
            {
                List<BEFormularioDato> lst = new List<BEFormularioDato>();
                using (ContenidoServiceClient sv = new ContenidoServiceClient())
                {
                    if (PaisID > 0)
                        lst = sv.SelectFormularioDatoByPais(PaisID, ETipoFormulario.LugaresPago).ToList();
                }

                // Usamos el modelo para obtener los datos
                BEGrid grid = new BEGrid();
                grid.PageSize = rows;
                grid.CurrentPage = page;
                grid.SortColumn = sidx;
                grid.SortOrder = sord;
                //int buscar = int.Parse(txtBuscar);
                BEPager pag = new BEPager();
                IEnumerable<BEFormularioDato> items = lst;

                #region Sort Section
                if (sord == "asc")
                {
                    switch (sidx)
                    {
                        case "Descripcion":
                            items = lst.OrderBy(x => x.Descripcion);
                            break;
                        case "URL":
                            items = lst.OrderBy(x => x.URL);
                            break;
                    }
                }
                else
                {
                    switch (sidx)
                    {
                        case "Descripcion":
                            items = lst.OrderByDescending(x => x.Descripcion);
                            break;
                        case "URL":
                            items = lst.OrderByDescending(x => x.URL);
                            break;
                    }
                }
                #endregion

                items = items.ToList().Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);

                pag = Util.PaginadorGenerico(grid, lst);

                // Creamos la estructura
                var data = new
                {
                    total = pag.PageCount,
                    page = pag.CurrentPage,
                    records = pag.RecordCount,
                    rows = from a in items
                           select new
                           {
                               id = a.FormularioDatoID,
                               cell = new string[] 
                               {
                                   a.Descripcion,
                                   a.URL
                                }
                           }
                };
                return Json(data, JsonRequestBehavior.AllowGet);
            }
            return RedirectToAction("ConfiguracionFormulariosInformativos");
        }

        public JsonResult EliminarLugardePago(int PaisID, int FormularioDatoID)
        {
            try
            {
                using (ContenidoServiceClient sv = new ContenidoServiceClient())
                {
                    sv.DeleteFormularioDato(PaisID, ETipoFormulario.LugaresPago, FormularioDatoID);
                }

                return Json(new
                {
                    success = true,
                    message = "Se elimino satisfactoriamente el registro",
                    extra = ""
                });

            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Hubo un problema con el servicio, intente nuevamente",
                    extra = ""
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Hubo un problema con el servicio, intente nuevamente",
                    extra = ""
                });
            }
        }

        #region Contenido Datos

        public ActionResult ContenidoDato()
        {
            var contenidoDatoModel = new ContenidoDatoModel()
            {
                listaPaises = DropDowListPaises(),
                listaCampanias = new List<CampaniaModel>()
            };
            return View(contenidoDatoModel);
        }

        public JsonResult ObtenterCampaniasPorPais(int PaisID)
        {
            PaisID = 11;
            IEnumerable<CampaniaModel> lista = DropDownCampanias(PaisID);

            return Json(new
            {
                lista = lista
            }, JsonRequestBehavior.AllowGet);
        }

        public IEnumerable<CampaniaModel> DropDownCampanias(int PaisID)
        {
            List<BECampania> lista;
            using (ZonificacionServiceClient servicezona = new ZonificacionServiceClient())
            {
                lista = servicezona.SelectCampanias(PaisID).ToList();
            }
            //lista.Insert(0, new BECampania() { CampaniaID = 0, NombreCorto = "-- Seleccionar --" });
            Mapper.CreateMap<BECampania, CampaniaModel>()
                .ForMember(x => x.CampaniaID, t => t.MapFrom(c => c.CampaniaID))
                .ForMember(x => x.NombreCorto, t => t.MapFrom(c => c.NombreCorto))
                .ForMember(x => x.Codigo, t => t.MapFrom(c => c.Codigo));

            return Mapper.Map<IList<BECampania>, IEnumerable<CampaniaModel>>(lista);
        }


        [HttpPost]
        public ActionResult MantenerFondo(ContenidoDatoModel form)
        {
            try
            {
                var lstPaises = new List<BEPais>();
                using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
                {
                    lstPaises = sv.SelectPaises().ToList().FindAll(x => x.PaisID == form.PaisID);
                }

                string tempNombreImagenFondo = form.ImagenFondo;
                string tempNombreImagenLogo = form.ImagenLogo;
                BEContenidoDato entidad = new BEContenidoDato();
                entidad.PaisID = form.PaisID;
                entidad.CampaniaID = form.CampaniaID;
                entidad.ImagenFondo = FileManager.CopyImagesFondoLogo(Globals.RutaImagenesFondoPortal + "\\" + lstPaises[0].CodigoISO, tempNombreImagenFondo, Globals.RutaImagenesTemp, lstPaises[0].CodigoISO, form.CampaniaID.ToString());
                entidad.ImagenLogo = FileManager.CopyImagesFondoLogo(Globals.RutaImagenesLogoPortal + "\\" + lstPaises[0].CodigoISO, tempNombreImagenLogo, Globals.RutaImagenesTemp, lstPaises[0].CodigoISO, form.CampaniaID.ToString());
                FileManager.DeleteImagesInFolder(Globals.RutaImagenesTemp);
                if (form.FlagTransaccion == 0)
                {
                    using (ContenidoServiceClient sv = new ContenidoServiceClient())
                    {
                        sv.InsContenidoDato(entidad);
                    }
                }
                else
                {
                    using (ContenidoServiceClient sv = new ContenidoServiceClient())
                    {
                        sv.UpdContenidoDato(entidad);
                    }
                }
                return Json(new
                {
                    success = true,
                    message = form.FlagTransaccion == 1 ? "Se actualizó satisfactoriamente el fondo y logo del Portal." : "Se registró satisfactoriamente el fondo y logo del Portal.",
                    extra = ""
                });
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "No se pudo realizar la carga de la Imagen.",
                    extra = ""
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "No se pudo realizar la carga de la Imagen",
                    extra = ""
                });
            }
        }

        public JsonResult GetFondoyLogo(int PaisID, int CampaniaID)
        {
            var lstPaises = new List<BEPais>();
            using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
            {
                lstPaises = sv.SelectPaises().ToList().FindAll(x => x.PaisID == PaisID);
            }

            List<BEContenidoDato> lista = new List<BEContenidoDato>();
            using (ContenidoServiceClient sv = new ContenidoServiceClient())
            {
                lista = sv.SelectContenidoDato(PaisID, CampaniaID).ToList();
            }
            lista.Where(x => x.PaisID == PaisID && x.CampaniaID == CampaniaID).Update(x => x.ImagenFondo = lstPaises[0].CodigoISO + "/" + x.ImagenFondo);
            lista.Where(x => x.PaisID == PaisID && x.CampaniaID == CampaniaID).Update(x => x.ImagenLogo = lstPaises[0].CodigoISO + "/" + x.ImagenLogo);

            return Json(new
            {
                count = lista.Count,
                lista = lista
            }, JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetFondoyLogoPortal()
        {
            var lstPaises = new List<BEPais>();
            using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
            {
                lstPaises = sv.SelectPaises().ToList().FindAll(x => x.PaisID == UserData().PaisID);
            }

            List<BEContenidoDato> lista = new List<BEContenidoDato>();
            using (ContenidoServiceClient sv = new ContenidoServiceClient())
            {
                lista = sv.SelectContenidoDato(UserData().PaisID, UserData().CampaniaID).ToList();
            }
            lista.Where(x => x.PaisID == UserData().PaisID && x.CampaniaID == UserData().CampaniaID).Update(x => x.ImagenFondo = lstPaises[0].CodigoISO + "/" + x.ImagenFondo);
            lista.Where(x => x.PaisID == UserData().PaisID && x.CampaniaID == UserData().CampaniaID).Update(x => x.ImagenLogo = lstPaises[0].CodigoISO + "/" + x.ImagenLogo);

            return Json(new
            {
                count = lista.Count,
                lista = lista
            }, JsonRequestBehavior.AllowGet);
        }

        #endregion

        #endregion
    }
}
