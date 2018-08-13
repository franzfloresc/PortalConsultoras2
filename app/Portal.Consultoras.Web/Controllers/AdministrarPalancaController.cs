using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Web.ServiceSAC;
using Portal.Consultoras.Web.ServiceZonificacion;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.ServiceModel;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class AdministrarPalancaController : BaseController
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
            var model = new AdministrarPalancaModel();
            try
            {
                if (!UsuarioModel.HasAcces(ViewBag.Permiso, "AdministrarPalanca/Index"))
                    return RedirectToAction("Index", "Bienvenida");
                ViewBag.UrlS3 = GetUrlS3();
                model.ListaCampanias = ListCampanias(userData.PaisID);
                model.ListaConfiguracionPais = ListarConfiguracionPais();
                return View(model);
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
                return View(model);
            }
        }

        public ActionResult GetPalanca(int idConfiguracionPais)
        {
            AdministrarPalancaModel model;
            using (var sv = new SACServiceClient())
            {
                var beConfiguracionPais = sv.GetConfiguracionPais(userData.PaisID, idConfiguracionPais);
                model = Mapper.Map<ServiceSAC.BEConfiguracionPais, AdministrarPalancaModel>(beConfiguracionPais);
            }
            model.ListaCampanias = ListCampanias(userData.PaisID);
            model.ListaTipoPresentacion = ListTipoPresentacion();
            if (!string.IsNullOrEmpty(model.DesktopTituloMenu) && model.DesktopTituloMenu.Contains("|"))
            {
                model.DesktopSubTituloMenu = model.DesktopTituloMenu.SplitAndTrim('|').LastOrDefault();
                model.DesktopTituloMenu = model.DesktopTituloMenu.SplitAndTrim('|').FirstOrDefault();
            }
            if (!string.IsNullOrEmpty(model.MobileTituloMenu) && model.MobileTituloMenu.Contains("|"))
            {
                model.MobileSubTituloMenu = model.MobileTituloMenu.SplitAndTrim('|').LastOrDefault();
                model.MobileTituloMenu = model.MobileTituloMenu.SplitAndTrim('|').FirstOrDefault();
            }
            return PartialView("Partials/MantenimientoPalanca", model);
        }

        public ActionResult GetOfertasHome(int idOfertasHome)
        {
            var model = new AdministrarOfertasHomeModel();
            if (idOfertasHome > 0)
            {
                using (var sv = new SACServiceClient())
                {
                    var beConfiguracionOfertas = sv.GetConfiguracionOfertasHome(userData.PaisID, idOfertasHome);
                    model = Mapper.Map<BEConfiguracionOfertasHome, AdministrarOfertasHomeModel>(beConfiguracionOfertas);
                }
            }
            model.DesktopTipoEstrategia = model.DesktopTipoEstrategia ?? "";
            model.MobileTipoEstrategia = model.MobileTipoEstrategia ?? "";
            model.ListaCampanias = ListCampanias(userData.PaisID);
            model.ListaTipoPresentacion = ListTipoPresentacion();
            model.ListaConfiguracionPais = ListarConfiguracionPais();
            model.ListaTipoEstrategia = ListTipoEstrategia();
            return PartialView("Partials/MantenimientoOfertasHome", model);
        }

        public JsonResult ListPalanca(string sidx, string sord, int page, int rows)
        {
            try
            {
                var list = ListarConfiguracionPais();
                var data = new
                {
                    rows = from a in list
                           select new
                           {
                               id = a.ConfiguracionPaisID,
                               cell = new string[]
                               {
                                    a.ConfiguracionPaisID.ToString(),
                                    a.Orden.ToString(),
                                    a.Codigo,
                                    a.Descripcion,
                                    a.Estado.ToString()
                               }
                           }
                };
                return Json(data, JsonRequestBehavior.AllowGet);
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

        public JsonResult ListOfertasHome(string sidx, string sord, int page, int rows, int campaniaID = 0)
        {
            try
            {
                var list = ListarConfiguracionOfertasHome(campaniaID).ToList();
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
                               id = a.ConfiguracionOfertasHomeID,
                               cell = new string[]
                               {
                                    a.ConfiguracionOfertasHomeID.ToString(),
                                    a.DesktopOrden.ToString(),
                                    a.CampaniaID.ToString(),
                                    a.ConfiguracionPais.Descripcion,
                                    a.DesktopTitulo
                               }
                           }
                };
                return Json(data, JsonRequestBehavior.AllowGet);
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

        [HttpPost]
        public JsonResult Update(AdministrarPalancaModel model)
        {
            try
            {
                model.PaisID = userData.PaisID;
                model = UpdateFilesPalanca(model);
                if (!string.IsNullOrEmpty(model.DesktopSubTituloMenu)) model.DesktopTituloMenu += "|" + model.DesktopSubTituloMenu;
                if (!string.IsNullOrEmpty(model.MobileSubTituloMenu)) model.MobileTituloMenu += "|" + model.MobileSubTituloMenu;

                using (var sv = new SACServiceClient())
                {
                    var entidad = Mapper.Map<AdministrarPalancaModel, ServiceSAC.BEConfiguracionPais>(model);
                    sv.UpdateConfiguracionPais(entidad);
                }
                return Json(new
                {
                    success = true,
                    message = "Se grabó con éxito.",
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

        [HttpPost]
        public JsonResult UpdateOfertasHome(AdministrarOfertasHomeModel model)
        {
            try
            {
                model.PaisID = userData.PaisID;
                model = UpdateFilesOfertas(model);
                using (var sv = new SACServiceClient())
                {
                    var entidad = Mapper.Map<AdministrarOfertasHomeModel, BEConfiguracionOfertasHome>(model);
                    sv.UpdateConfiguracionOfertasHome(entidad);
                }
                return Json(new
                {
                    success = true,
                    message = "Se grabó con éxito.",
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

        private IEnumerable<ConfiguracionPaisModel> ListarConfiguracionPais()
        {
            List<ServiceSAC.BEConfiguracionPais> lst;
            using (var sv = new SACServiceClient())
            {
                lst = sv.ListConfiguracionPais(userData.PaisID, true).ToList();
            }
            return Mapper.Map<IList<ServiceSAC.BEConfiguracionPais>, IEnumerable<ConfiguracionPaisModel>>(lst);
        }

        private IEnumerable<AdministrarOfertasHomeModel> ListarConfiguracionOfertasHome(int campaniaId = 0)
        {
            List<BEConfiguracionOfertasHome> lst;
            using (var sv = new SACServiceClient())
            {
                lst = sv.ListConfiguracionOfertasHome(userData.PaisID, campaniaId).ToList();
            }
            return Mapper.Map<IList<BEConfiguracionOfertasHome>, IEnumerable<AdministrarOfertasHomeModel>>(lst);
        }

        private IEnumerable<CampaniaModel> ListCampanias(int paisId)
        {
            IList<BECampania> lst;
            using (var sv = new ZonificacionServiceClient())
            {
                lst = sv.SelectCampanias(paisId);
            }

            return Mapper.Map<IList<BECampania>, IEnumerable<CampaniaModel>>(lst);
        }

        private IEnumerable<TipoEstrategiaModel> ListTipoEstrategia()
        {
            var lst = _tipoEstrategiaProvider.GetTipoEstrategias(userData.PaisID);

            if (lst != null && lst.Count > 0)
            {
                var carpetaPais = Globals.UrlMatriz + "/" + userData.CodigoISO;
                lst.Update(x => x.ImagenEstrategia = ConfigCdn.GetUrlFileCdn(carpetaPais, x.ImagenEstrategia));
            }

            var lista = from a in lst
                        where a.FlagActivo == 1
                        select a;

            return Mapper.Map<IList<ServicePedido.BETipoEstrategia>, IEnumerable<TipoEstrategiaModel>>(lista.ToList());
        }

        private IEnumerable<TablaLogicaDatosModel> ListTipoPresentacion()
        {
            List<BETablaLogicaDatos> tabla;
            using (var sac = new SACServiceClient())
            {
                tabla = sac.GetTablaLogicaDatos(userData.PaisID, 120).ToList();
            }
            return Mapper.Map<IList<BETablaLogicaDatos>, IEnumerable<TablaLogicaDatosModel>>(tabla);
        }

        private string GetUrlS3()
        {
            var paisIso = Util.GetPaisISO(userData.PaisID);
            var carpetaPais = Globals.UrlMatriz + "/" + paisIso;
            return ConfigCdn.GetUrlCdn(carpetaPais);
        }

        private AdministrarPalancaModel UpdateFilesPalanca(AdministrarPalancaModel model)
        {
            if (model.ConfiguracionPaisID != 0)
            {
                ServiceSAC.BEConfiguracionPais entidad;
                using (var sv = new SACServiceClient())
                {
                    entidad = sv.GetConfiguracionPais(userData.PaisID, model.ConfiguracionPaisID);
                }

                if (!string.IsNullOrEmpty(model.DesktopFondoBanner) &&
                    (string.IsNullOrEmpty(entidad.DesktopFondoBanner) || model.DesktopFondoBanner != entidad.DesktopFondoBanner))
                    model.DesktopFondoBanner = SaveFileS3(model.DesktopFondoBanner);
                if (!string.IsNullOrEmpty(model.MobileFondoBanner) &&
                    (string.IsNullOrEmpty(entidad.MobileFondoBanner) || model.MobileFondoBanner != entidad.MobileFondoBanner))
                    model.MobileFondoBanner = SaveFileS3(model.MobileFondoBanner);
                if (!string.IsNullOrEmpty(model.DesktopLogoBanner) &&
                    (string.IsNullOrEmpty(entidad.DesktopLogoBanner) || model.DesktopLogoBanner != entidad.DesktopLogoBanner))
                    model.DesktopLogoBanner = SaveFileS3(model.DesktopLogoBanner);
                if (!string.IsNullOrEmpty(model.MobileLogoBanner) &&
                    (string.IsNullOrEmpty(entidad.MobileLogoBanner) || model.MobileLogoBanner != entidad.MobileLogoBanner))
                    model.MobileLogoBanner = SaveFileS3(model.MobileLogoBanner);
                if (!string.IsNullOrEmpty(model.Logo) &&
                    (string.IsNullOrEmpty(entidad.Logo) || model.Logo != entidad.Logo))
                    model.Logo = SaveFileS3(model.Logo);
            }
            else
            {
                model.DesktopFondoBanner = string.IsNullOrEmpty(model.DesktopFondoBanner) ? "" : SaveFileS3(model.DesktopFondoBanner);
                model.MobileFondoBanner = string.IsNullOrEmpty(model.MobileFondoBanner) ? "" : SaveFileS3(model.MobileFondoBanner);
                model.DesktopLogoBanner = string.IsNullOrEmpty(model.DesktopLogoBanner) ? "" : SaveFileS3(model.DesktopLogoBanner);
                model.MobileLogoBanner = string.IsNullOrEmpty(model.MobileLogoBanner) ? "" : SaveFileS3(model.MobileLogoBanner);
                model.Logo = string.IsNullOrEmpty(model.Logo) ? "" : SaveFileS3(model.Logo);
            }

            return model;
        }

        private AdministrarOfertasHomeModel UpdateFilesOfertas(AdministrarOfertasHomeModel model)
        {
            if (model.ConfiguracionPaisID != 0)
            {
                BEConfiguracionOfertasHome entidad;
                using (var sv = new SACServiceClient())
                {
                    entidad = sv.GetConfiguracionOfertasHome(userData.PaisID, model.ConfiguracionOfertasHomeID);
                }

                if (!string.IsNullOrEmpty(model.DesktopImagenFondo) &&
                    (string.IsNullOrEmpty(entidad.DesktopImagenFondo) || model.DesktopImagenFondo != entidad.DesktopImagenFondo))
                    model.DesktopImagenFondo = SaveFileS3(model.DesktopImagenFondo);
                if (!string.IsNullOrEmpty(model.MobileImagenFondo) &&
                    (string.IsNullOrEmpty(entidad.MobileImagenFondo) || model.MobileImagenFondo != entidad.MobileImagenFondo))
                    model.MobileImagenFondo = SaveFileS3(model.MobileImagenFondo);

            }
            else
            {
                model.DesktopImagenFondo = SaveFileS3(model.DesktopImagenFondo);
                model.MobileImagenFondo = SaveFileS3(model.MobileImagenFondo);
            }

            return model;
        }

        private string SaveFileS3(string imagenEstrategia)
        {
            imagenEstrategia = Util.Trim(imagenEstrategia);
            if (imagenEstrategia == "")
                return "";

            var path = Path.Combine(Globals.RutaTemporales, imagenEstrategia);
            var carpetaPais = Globals.UrlMatriz + "/" + userData.CodigoISO;
            var time = DateTime.Now.Year.ToString() + DateTime.Now.Month.ToString() + DateTime.Now.Minute.ToString() + DateTime.Now.Millisecond.ToString();
            var newfilename = userData.CodigoISO + "_" + time + "_" + FileManager.RandomString() + ".png";
            ConfigS3.SetFileS3(path, carpetaPais, newfilename);
            return newfilename;
        }

        #region Service

        private IEnumerable<ConfiguracionPaisComponenteModel> ComponenteListarService(ConfiguracionPaisComponenteModel paisComp)
        {
            List<ConfiguracionPaisComponenteModel> listaEntidad;

            try
            {
                paisComp = paisComp ?? new ConfiguracionPaisComponenteModel();
                var entidad = new ServiceUsuario.BEConfiguracionPaisDatos
                {
                    PaisID = userData.PaisID,
                    ConfiguracionPaisID = paisComp.ConfiguracionPaisID,
                    CampaniaID = paisComp.CampaniaID,
                    Componente = paisComp.Codigo,
                    ConfiguracionPais = new ServiceUsuario.BEConfiguracionPais
                    {
                        Codigo = paisComp.PalancaCodigo
                    }
                };

                List<ServiceUsuario.BEConfiguracionPaisDatos> listaDatos;
                using (var sv = new ServiceUsuario.UsuarioServiceClient())
                {
                    listaDatos = sv.GetConfiguracionPaisComponente(entidad).ToList();
                }

                listaEntidad = Mapper.Map<IList<ServiceUsuario.BEConfiguracionPaisDatos>, List<ConfiguracionPaisComponenteModel>>(listaDatos);
            }
            catch (Exception ex)
            {
                listaEntidad = new List<ConfiguracionPaisComponenteModel>();
                logManager.LogErrorWebServicesBusWrap(ex, userData.CodigoUsuario, userData.PaisID.ToString(),
                    "AdministrarPalancaController.ListarConfiguracionPaisDatos");
            }

            return listaEntidad;
        }

        #endregion

        #region ConfiguracionPaisComponenteDatos

        public JsonResult ComponenteListar(string sidx, string sord, int page, int rows)
        {
            try
            {
                var list = ComponenteListarService(null);
                list = list.Where(c => c.Codigo == Constantes.ConfiguracionPaisComponente.RD.PopupClubGanaMas);
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
                               id = a.ConfiguracionPaisComponenteID,
                               cell = new string[]
                                {
                                    a.ConfiguracionPaisID.ToString(),
                                    a.CampaniaID.ToString(),
                                    a.PalancaCodigo,
                                    a.Descripcion,
                                    a.Codigo,
                                    a.Nombre
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

        public JsonResult ComponenteDatosGuardar(List<AdministrarComponenteDatosModel> listaDatos)
        {
            try
            {
                var listaEntidad = ComponenteDatosFormato(listaDatos);
                if (listaEntidad == null || !listaEntidad.Any())
                {
                    return Json(new { success = false });
                }
                int valRespuesta;
                using (var sv = new ServiceUsuario.UsuarioServiceClient())
                {
                    valRespuesta = sv.ConfiguracionPaisDatosGuardar(userData.PaisID, listaEntidad.ToArray());
                }

                return Json(new { success = valRespuesta > 0 });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new { success = false });
            }
        }

        private List<ServiceUsuario.BEConfiguracionPaisDatos> ComponenteDatosFormato(List<AdministrarComponenteDatosModel> listaDatos)
        {
            var listaEntidad = new List<ServiceUsuario.BEConfiguracionPaisDatos>();
            try
            {
                if (listaDatos == null || !listaDatos.Any())
                    return listaEntidad;

                foreach (var admDato in listaDatos)
                {
                    if (admDato.TipoDato == "img" && admDato.Dato.Editado)
                    {
                        admDato.Dato.Valor1 = SaveFileS3(admDato.Dato.Valor1);
                    }

                    listaEntidad.Add(Mapper.Map<ConfiguracionPaisDatosModel, ServiceUsuario.BEConfiguracionPaisDatos>(admDato.Dato));
                }

            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                listaEntidad = new List<ServiceUsuario.BEConfiguracionPaisDatos>();
            }
            return listaEntidad;
        }

        [HttpPost]
        public JsonResult ComponentePorPalanca(ConfiguracionPaisModel model)
        {
            try
            {
                var compModel = new ConfiguracionPaisComponenteModel
                {
                    PalancaCodigo = model.Codigo,
                };
                var listaComponente = ComponenteListarService(compModel);

                return Json(new
                {
                    success = true,
                    ListaComponente = listaComponente.Where(p => p.Codigo == Constantes.ConfiguracionPaisComponente.RD.PopupClubGanaMas),
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false
                });
            }
        }

        public ActionResult ComponenteObtenerViewDatos(ConfiguracionPaisComponenteModel entidad)
        {
            AdministrarComponenteModel modelo;

            try
            {
                var beEntidad = new ServiceUsuario.BEConfiguracionPaisDatos
                {
                    PaisID = userData.PaisID,
                    ConfiguracionPaisID = entidad.ConfiguracionPaisID,
                    CampaniaID = entidad.CampaniaID,
                    Componente = entidad.Codigo,
                    ConfiguracionPais = new ServiceUsuario.BEConfiguracionPais
                    {
                        Codigo = entidad.PalancaCodigo
                    }
                };

                if (entidad.Accion == _accion.Deshabilitar)
                {
                    using (var sv = new ServiceUsuario.UsuarioServiceClient())
                    {
                        sv.ConfiguracionPaisComponenteDeshabilitar(beEntidad);
                    }

                    return PartialView("Partials/MantenimientoProximamente", new AdministrarComponenteModel());
                }

                modelo = new AdministrarComponenteModel
                {
                    PalancaCodigo = entidad.PalancaCodigo,
                    CampaniaID = entidad.CampaniaID,
                    Componente = beEntidad.Componente,
                    ListaCompomente = new List<ConfiguracionPaisComponenteModel>(),
                    Observacion = ""
                };

                List<ConfiguracionPaisDatosModel> beEntidadesMdel = new List<ConfiguracionPaisDatosModel>();
                if (entidad.Accion != _accion.Nuevo)
                {
                    using (var sv = new ServiceUsuario.UsuarioServiceClient())
                    {
                        var beEntidades = sv.GetConfiguracionPaisComponenteDatos(beEntidad).ToList();
                        if (!beEntidades.Any() && entidad.Accion == _accion.NuevoDatos)
                        {
                            beEntidad.CampaniaID = 0;
                            beEntidades = sv.GetConfiguracionPaisComponenteDatos(beEntidad).ToList();
                            beEntidades.ForEach(d =>
                            {
                                d.CampaniaID = entidad.CampaniaID;
                                d.Valor1 = "";
                                d.Valor2 = "";
                                d.Valor3 = "";
                                d.Estado = false;
                            });
                        }
                        else if (entidad.Accion == _accion.NuevoDatos && beEntidad.CampaniaID > 0)
                        {
                            modelo.Observacion = "Ya existe un registro con la misma campaña";
                        }

                        beEntidadesMdel = Mapper.Map<IList<ServiceUsuario.BEConfiguracionPaisDatos>, List<ConfiguracionPaisDatosModel>>(beEntidades);
                    }
                }

                modelo.ListaDatos = ComponenteDatosFormato(entidad, beEntidadesMdel);
                modelo.Estado = beEntidadesMdel.Any() && beEntidadesMdel.FirstOrDefault().Estado;

                if (!modelo.ListaDatos.Any() && entidad.Accion == _accion.Editar)
                {
                    return PartialView("Partials/MantenimientoProximamente", modelo);
                }

                if (entidad.Accion == _accion.NuevoDatos)
                {
                    return PartialView("Partials/MantenimientoPalancaDatos", modelo);
                }

                modelo.ListaPalanca = ListarConfiguracionPais().Where(p => p.Codigo == Constantes.ConfiguracionPais.RevistaDigital);
                modelo.ListaCampanias = ListCampanias(userData.PaisID);
                if (entidad.Accion != _accion.Nuevo)
                {
                    modelo.ListaCompomente = ComponenteListarService(entidad).Where(p => p.Codigo == Constantes.ConfiguracionPaisComponente.RD.PopupClubGanaMas);
                }

            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                modelo = new AdministrarComponenteModel
                {
                    ListaDatos = new List<AdministrarComponenteDatosModel>(),
                    ListaPalanca = new List<ConfiguracionPaisModel>(),
                    ListaCampanias = new List<CampaniaModel>(),
                    ListaCompomente = new List<ConfiguracionPaisComponenteModel>()
                };
            }

            return PartialView("Partials/MantenimientoPalancaDatosCabecera", modelo);
        }

        private List<AdministrarComponenteDatosModel> ComponenteDatosFormato(ConfiguracionPaisComponenteModel entidad, List<ConfiguracionPaisDatosModel> listaDatos)
        {
            var listaEntidad = new List<AdministrarComponenteDatosModel>();

            switch (entidad.PalancaCodigo)
            {
                case Constantes.ConfiguracionPais.RevistaDigital:
                    listaEntidad = ComponenteDatosFormatoRD(listaDatos, entidad.Accion == _accion.Nuevo);
                    break;
            }

            return listaEntidad;
        }

        private List<AdministrarComponenteDatosModel> ComponenteDatosFormatoRD(List<ConfiguracionPaisDatosModel> listaDatos, bool vacio)
        {
            var listaEntidad = new List<AdministrarComponenteDatosModel>();
            var listaComponente = listaDatos.GroupBy(d => d.Componente).Select(dr => dr.First());
            foreach (var compo in listaComponente)
            {
                switch (compo.Componente)
                {
                    case Constantes.ConfiguracionPaisComponente.RD.PopupClubGanaMas:
                        listaEntidad.AddRange(ComponenteDatosFormatoRDPopup(listaDatos, vacio));
                        break;
                }

            }
            return listaEntidad;
        }

        private List<AdministrarComponenteDatosModel> ComponenteDatosFormatoRDPopup(List<ConfiguracionPaisDatosModel> listaDatos, bool vacio)
        {
            var listaEntidad = new List<AdministrarComponenteDatosModel>();
            foreach (var iDato in listaDatos)
            {
                var admDato = new AdministrarComponenteDatosModel
                {
                    Dato = iDato,
                    TipoDato = "txt",
                    Tamanio = 800
                };

                if (vacio)
                {
                    admDato.Dato.CampaniaID = 0;
                    admDato.Dato.Valor1 = "";
                    admDato.Dato.Valor2 = "";
                    admDato.Dato.Valor3 = "";
                    admDato.Dato.Estado = false;
                }

                switch (iDato.Codigo)
                {
                    case Constantes.ConfiguracionPaisDatos.RD.PopupImagenEtiqueta:
                        admDato.TxtLabel = "Etiqueta del Club (64 x 30)";
                        admDato.TipoDato = "img";
                        admDato.Orden = 1;
                        break;

                    case Constantes.ConfiguracionPaisDatos.RD.PopupImagenPublicidad:
                        admDato.TxtLabel = "Imagen/Gif";
                        admDato.TipoDato = "img";
                        admDato.TipoFile = "imggif";
                        admDato.Orden = 2;
                        break;

                    case Constantes.ConfiguracionPaisDatos.RD.PopupFondoColorMarco:
                        admDato.TxtLabel = "Color del borde";
                        admDato.TextoAyuda = "Código hexadecimal";
                        admDato.Orden = 3;
                        break;

                    case Constantes.ConfiguracionPaisDatos.RD.PopupFondoColor:
                        admDato.TxtLabel = "Color del fondo";
                        admDato.TextoAyuda = "Código hexadecimal";
                        admDato.Orden = 4;
                        break;

                    case Constantes.ConfiguracionPaisDatos.RD.PopupMensaje1:
                        admDato.TxtLabel = "Mensaje 1";
                        admDato.TextoAyuda = "Texto en regular";
                        admDato.Orden = 5;
                        break;

                    case Constantes.ConfiguracionPaisDatos.RD.PopupMensaje2:
                        admDato.TxtLabel = "Mensaje 2";
                        admDato.TextoAyuda = "Texto en bold";
                        admDato.Orden = 6;
                        break;

                    case Constantes.ConfiguracionPaisDatos.RD.PopupMensajeColor:
                        admDato.TxtLabel = "Color de los Mensajes";
                        admDato.TextoAyuda = "Código hexadecimal";
                        admDato.Orden = 7;
                        break;

                    case Constantes.ConfiguracionPaisDatos.RD.PopupBotonTexto:
                        admDato.TxtLabel = "Texto botón";
                        admDato.TextoAyuda = "Máximo 26 caractéres";
                        admDato.Tamanio = 26;
                        admDato.Orden = 8;
                        break;

                    case Constantes.ConfiguracionPaisDatos.RD.PopupBotonColorTexto:
                        admDato.TxtLabel = "Color texto botón";
                        admDato.TextoAyuda = "Código hexadecimal";
                        admDato.Orden = 9;
                        break;

                    case Constantes.ConfiguracionPaisDatos.RD.PopupBotonColorFondo:
                        admDato.TxtLabel = "Color botón";
                        admDato.TextoAyuda = "Código hexadecimal";
                        admDato.Orden = 10;
                        break;

                }

                listaEntidad.Add(admDato);
            }
            return listaEntidad.OrderBy(d => d.Orden).ToList();
        }

        #endregion
    }
}