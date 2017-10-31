﻿using AutoMapper;
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
        // GET: AdministrarEstrategiaPerfil
        public ActionResult Index()
        {
            AdministrarPalancaModel model = new AdministrarPalancaModel();
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
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return View(model);
            }
        }

        public ActionResult GetPalanca(int idConfiguracionPais)
        {
            AdministrarPalancaModel model = new AdministrarPalancaModel();
            using (SACServiceClient sv = new SACServiceClient())
            {
                BEConfiguracionPais beConfiguracionPais = sv.GetConfiguracionPais(UserData().PaisID, idConfiguracionPais);
                model = Mapper.Map<BEConfiguracionPais, AdministrarPalancaModel>(beConfiguracionPais);
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
            AdministrarOfertasHomeModel model = new AdministrarOfertasHomeModel();
            if (idOfertasHome > 0)
            {
                using (SACServiceClient sv = new SACServiceClient())
                {
                    BEConfiguracionOfertasHome beConfiguracionOfertas = sv.GetConfiguracionOfertasHome(UserData().PaisID, idOfertasHome);
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
                    //total = pag.PageCount,
                    //page = pag.CurrentPage,
                    //records = pag.RecordCount,
                    rows = from a in list
                           select new
                           {
                               id = a.ConfiguracionPaisID,
                               cell = new string[]
                               {
                            a.ConfiguracionPaisID.ToString(),
                            a.Orden.ToString(),
                            a.Codigo.ToString(),
                            a.Descripcion.ToString(),
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
                var list = ListarConfiguracionOfertasHome(campaniaID);
                BEGrid grid = new BEGrid();
                grid.PageSize = rows;
                grid.CurrentPage = page;
                grid.SortColumn = sidx;
                grid.SortOrder = sord;


                BEPager pag = new BEPager();

                IEnumerable<AdministrarOfertasHomeModel> items = list;
                items = items.ToList().Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);
                pag = Util.PaginadorGenerico(grid, list.ToList());
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
                if (!String.IsNullOrEmpty(model.DesktopSubTituloMenu)) model.DesktopTituloMenu += "|" + model.DesktopSubTituloMenu;
                if (!String.IsNullOrEmpty(model.MobileSubTituloMenu)) model.MobileTituloMenu += "|" + model.MobileSubTituloMenu;

                using (SACServiceClient sv = new SACServiceClient())
                {
                    var entidad = Mapper.Map<AdministrarPalancaModel, BEConfiguracionPais>(model);
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
                using (SACServiceClient sv = new SACServiceClient())
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

        private IEnumerable<PaisModel> ListarPaises()
        {
            List<BEPais> lst;
            using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
            {
                if (UserData().RolID == 2) lst = sv.SelectPaises().ToList();
                else
                {
                    lst = new List<BEPais>();
                    lst.Add(sv.SelectPais(UserData().PaisID));
                }

            }

            return Mapper.Map<IList<BEPais>, IEnumerable<PaisModel>>(lst);
        }

        private IEnumerable<ConfiguracionPaisModel> ListarConfiguracionPais()
        {
            List<ServiceSAC.BEConfiguracionPais> lst;
            using (SACServiceClient sv = new SACServiceClient())
            {
                lst = sv.ListConfiguracionPais(UserData().PaisID, true).ToList();
            }
            return Mapper.Map<IList<ServiceSAC.BEConfiguracionPais>, IEnumerable<ConfiguracionPaisModel>>(lst);
        }


        private IEnumerable<AdministrarOfertasHomeModel> ListarConfiguracionOfertasHome(int campaniaId = 0)
        {
            List<BEConfiguracionOfertasHome> lst;
            using (SACServiceClient sv = new SACServiceClient())
            {
                lst = sv.ListConfiguracionOfertasHome(UserData().PaisID, campaniaId).ToList();
            }
            return Mapper.Map<IList<BEConfiguracionOfertasHome>, IEnumerable<AdministrarOfertasHomeModel>>(lst);
        }

        private IEnumerable<CampaniaModel> ListCampanias(int PaisID)
        {
            IList<BECampania> lst;
            using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
            {
                lst = sv.SelectCampanias(PaisID);
            }

            return Mapper.Map<IList<BECampania>, IEnumerable<CampaniaModel>>(lst);
        }

        private IEnumerable<TipoEstrategiaModel> ListTipoEstrategia()
        {
            List<BETipoEstrategia> lst = GetTipoEstrategias();

            if (lst != null && lst.Count > 0)
            {
                var carpetaPais = Globals.UrlMatriz + "/" + UserData().CodigoISO;
                lst.Update(x => x.ImagenEstrategia = ConfigS3.GetUrlFileS3(carpetaPais, x.ImagenEstrategia, Globals.RutaImagenesMatriz + "/" + UserData().CodigoISO));
            }

            var lista = from a in lst
                        where a.FlagActivo == 1
                        select a;

            return Mapper.Map<IList<BETipoEstrategia>, IEnumerable<TipoEstrategiaModel>>(lista.ToList());
        }

        private IEnumerable<TablaLogicaDatosModel> ListTipoPresentacion()
        {
            var tabla = new List<BETablaLogicaDatos>();
            using (SACServiceClient sac = new SACServiceClient())
            {
                tabla = sac.GetTablaLogicaDatos(userData.PaisID, 120).ToList();
            }
            return Mapper.Map<IList<BETablaLogicaDatos>, IEnumerable<TablaLogicaDatosModel>>(tabla);
        }

        private string GetUrlS3()
        {
            string paisISO = Util.GetPaisISO(userData.PaisID);
            var carpetaPais = Globals.UrlMatriz + "/" + paisISO;
            return ConfigS3.GetUrlS3(carpetaPais);
        }

        private AdministrarPalancaModel UpdateFilesPalanca(AdministrarPalancaModel model)
        {
            if (model.ConfiguracionPaisID != 0) //update
            {
                var entidad = new BEConfiguracionPais();
                using (SACServiceClient sv = new SACServiceClient())
                {
                    entidad = sv.GetConfiguracionPais(UserData().PaisID, model.ConfiguracionPaisID);
                }

                if (!String.IsNullOrEmpty(model.DesktopFondoBanner) &&
                    (String.IsNullOrEmpty(entidad.DesktopFondoBanner) || model.DesktopFondoBanner != entidad.DesktopFondoBanner))
                    model.DesktopFondoBanner = SaveFileS3(model.DesktopFondoBanner);
                if (!String.IsNullOrEmpty(model.MobileFondoBanner) &&
                    (String.IsNullOrEmpty(entidad.MobileFondoBanner) || model.MobileFondoBanner != entidad.MobileFondoBanner))
                    model.MobileFondoBanner = SaveFileS3(model.MobileFondoBanner);
                if (!String.IsNullOrEmpty(model.DesktopLogoBanner) &&
                    (String.IsNullOrEmpty(entidad.DesktopLogoBanner) || model.DesktopLogoBanner != entidad.DesktopLogoBanner))
                    model.DesktopLogoBanner = SaveFileS3(model.DesktopLogoBanner);
                if (!String.IsNullOrEmpty(model.MobileLogoBanner) &&
                    (String.IsNullOrEmpty(entidad.MobileLogoBanner) || model.MobileLogoBanner != entidad.MobileLogoBanner))
                    model.MobileLogoBanner = SaveFileS3(model.MobileLogoBanner);
                if (!String.IsNullOrEmpty(model.Logo) &&
                    (String.IsNullOrEmpty(entidad.Logo) || model.Logo != entidad.Logo))
                    model.Logo = SaveFileS3(model.Logo);
            }
            else //create
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
            if (model.ConfiguracionPaisID != 0) //update
            {
                var entidad = new BEConfiguracionOfertasHome();
                using (SACServiceClient sv = new SACServiceClient())
                {
                    entidad = sv.GetConfiguracionOfertasHome(UserData().PaisID, model.ConfiguracionOfertasHomeID);
                }

                if (!String.IsNullOrEmpty(model.DesktopImagenFondo) &&
                    (String.IsNullOrEmpty(entidad.DesktopImagenFondo) || model.DesktopImagenFondo != entidad.DesktopImagenFondo))
                    model.DesktopImagenFondo = SaveFileS3(model.DesktopImagenFondo);
                if (!String.IsNullOrEmpty(model.MobileImagenFondo) &&
                    (String.IsNullOrEmpty(entidad.MobileImagenFondo) || model.MobileImagenFondo != entidad.MobileImagenFondo))
                    model.MobileImagenFondo = SaveFileS3(model.MobileImagenFondo);

            }
            else //create
            {
                model.DesktopImagenFondo = SaveFileS3(model.DesktopImagenFondo);
                model.MobileImagenFondo = SaveFileS3(model.MobileImagenFondo);
            }

            return model;
        }
        private string SaveFileS3(string imagenEstrategia)
        {
            var path = Path.Combine(Globals.RutaTemporales, imagenEstrategia);
            var carpetaPais = Globals.UrlMatriz + "/" + UserData().CodigoISO;
            var time = DateTime.Now.Year.ToString() + DateTime.Now.Month.ToString() + DateTime.Now.Minute.ToString() + DateTime.Now.Millisecond.ToString();
            var newfilename = UserData().CodigoISO + "_" + time + "_" + FileManager.RandomString() + ".png";
            ConfigS3.SetFileS3(path, carpetaPais, newfilename);
            return newfilename;
        }
    }
}