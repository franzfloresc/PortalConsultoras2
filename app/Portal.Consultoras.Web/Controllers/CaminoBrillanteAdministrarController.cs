using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models.CaminoBrillante;
using Portal.Consultoras.Web.ServiceUsuario;
using Portal.Consultoras.Web.ServicePedido;
using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Web.Mvc;
using Portal.Consultoras.Web.Models;

namespace Portal.Consultoras.Web.Controllers
{
    public class CaminoBrillanteAdministrarController: BaseAdmController
    {      
        public ActionResult AdministrarBeneficios(AdministrarCaminoBrillanteModel model)

        {
            try
            {
                model.listaPaises = DropDowListPaises();
                model.listaNiveles = DropDowListNivelesCaminoBrillante();
                model.listaIconos = DropDowListIconosBeneficios();
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
            return View(model);
        }

        public ActionResult Consultar(string sidx, string sord, int page, int rows, int paisID, string CodigoNivel, string Consulta)
        {
            if (ModelState.IsValid)
            {
                var lst = Consulta == "1" ? GetListaBeneficiosByNivel(CodigoNivel) : new List<NivelCaminoBrillanteModel.BeneficioCaminoBrillanteModel>();
                lst = lst ?? new List<NivelCaminoBrillanteModel.BeneficioCaminoBrillanteModel>();

                BEGrid grid = new BEGrid
                {
                    PageSize = rows,
                    CurrentPage = page,
                    SortColumn = sidx,
                    SortOrder = sord
                };
                IEnumerable<NivelCaminoBrillanteModel.BeneficioCaminoBrillanteModel> items = lst;

                items = items.Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);

                BEPager pag = Util.PaginadorGenerico(grid, lst);

                var data = new
                {
                    total = pag.PageCount,
                    page = pag.CurrentPage,
                    records = pag.RecordCount,
                    rows = from a in items
                           select new
                           {
                               id = a.CodigoBeneficio,
                               cell = new string[]
                               {
                                   a.CodigoBeneficio,                                   
                                   a.Registro.ToString(),
                                   a.NombreBeneficio,
                                   a.Descripcion,
                                   a.Orden.ToString(),
                                   a.FlagActivo,
                                   a.UrlIcono,                                   
                                }
                           }
                };
                return Json(data, JsonRequestBehavior.AllowGet);
            }
            return RedirectToAction("AdministrarBeneficios", "CaminoBrillanteAdministrar");
        }

        [HttpPost]
        public JsonResult RegistrarBeneficio(NivelCaminoBrillanteModel.BeneficioCaminoBrillanteModel model)
        {
            string operacion = "registró";
            try
            {
                model.CodigoBeneficio = string.IsNullOrEmpty(model.CodigoBeneficio) ? "" : model.CodigoBeneficio;
                var entidad = Mapper.Map<BEBeneficioCaminoBrillante>(model) ?? new BEBeneficioCaminoBrillante();

                using (var sv = new UsuarioServiceClient())
                {
                    sv.InsBeneficioCaminoBrillante(userData.PaisID, entidad);
                }

                return Json(new
                {
                    success = true,
                    message = String.Format("Se {0} con éxito el beneficio.", operacion),
                    extra = ""
                });
            }
            catch (Exception ex)
            {
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    extra = ""
                });
            }
        }

        [HttpPost]
        public JsonResult DesactivarBeneficio(string CodigoNivel, string CodigoBeneficio)
        {
            try
            {
                using (var sv = new UsuarioServiceClient())
                {
                    sv.DelBeneficioCaminoBrillante(userData.PaisID, CodigoNivel, CodigoBeneficio);
                }

                return Json(new
                {
                    success = true,
                    message = "Se desactivó con éxito el beneficio.",
                    extra = ""
                });
            }
            catch (Exception ex)
            {
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    extra = ""
                });
            }
        }

        #region Administrar Monto Exigencia
        public ActionResult AdministrarMontoExigencia(AdministrarMontoExigenciaModel model)
        {
            try
            {
                model.listaPaises = DropDowListPaises();
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
            return View(model);
        }

        public ActionResult ConsultarMontoExigencia(string sidx, string sord, int page, int rows, AdministrarMontoExigenciaModel model)
        {
            if (ModelState.IsValid)
            {
                var lst = GetIncentivosMontoExigencia(model) ?? new List<AdministrarMontoExigenciaModel>();
                
                BEGrid grid = new BEGrid
                {
                    PageSize = rows,
                    CurrentPage = page,
                    SortColumn = sidx,
                    SortOrder = sord
                };

                IEnumerable<AdministrarMontoExigenciaModel> items = lst;
                items = items.Skip((grid.CurrentPage - 1) * grid.PageSize).Take(grid.PageSize);

                BEPager pag = Util.PaginadorGenerico(grid, lst);

                var data = new
                {
                    total = pag.PageCount,
                    page = pag.CurrentPage,
                    records = pag.RecordCount,
                    rows = from a in items
                           select new
                           {
                               id = "div" + a.MontoID,
                               cell = new string[]
                               {
                                   a.MontoID.ToString(),
                                   a.AlcansoIncentivo,
                                   a.CodigoCampania,
                                   a.CodigoRegion,
                                   a.CodigoZona,
                                   a.Monto,
                                }
                           }
                };
                return Json(data, JsonRequestBehavior.AllowGet);
            }
            return RedirectToAction("AdministrarMontoExigencia", "CaminoBrillanteAdministrar");
        }

        public JsonResult GuardarMontoExigencia(AdministrarMontoExigenciaModel model)
        {
            try
            {
                model.CodigoCampania = !string.IsNullOrEmpty(model.CodigoCampania) ? model.CodigoCampania : "0";
                model.CodigoRegion = !string.IsNullOrEmpty(model.CodigoRegion) ? model.CodigoRegion : "";
                model.CodigoZona = !string.IsNullOrEmpty(model.CodigoZona) ? model.CodigoZona : "";
                var entidad = Mapper.Map<BEIncentivosMontoExigencia>(model) ?? new BEIncentivosMontoExigencia();
                string mensaje = "";

                using (var sv = new UsuarioServiceClient())
                {
                    mensaje = sv.InsIncentivosMontoExigencia(userData.PaisID, entidad);
                }

                return Json(new
                {
                    success = true,
                    message = mensaje == "" ? "Se guardo con éxito el monto de exigencia." : mensaje,
                    extra = ""
                });
            }
            catch (Exception ex)
            {
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    extra = ""
                });
            }
        }

        public JsonResult EliminarMontoExigencia(AdministrarMontoExigenciaModel model)
        {
            try
            {
                model.CodigoCampania = !string.IsNullOrEmpty(model.CodigoCampania) ? model.CodigoCampania : "";
                model.CodigoRegion = !string.IsNullOrEmpty(model.CodigoRegion) ? model.CodigoRegion : "";
                model.CodigoZona = !string.IsNullOrEmpty(model.CodigoZona) ? model.CodigoZona : "";
                var entidad = Mapper.Map<BEIncentivosMontoExigencia>(model) ?? new BEIncentivosMontoExigencia();

                using (var sv = new UsuarioServiceClient())
                {
                    sv.DelIncentivosMontoExigencia(userData.PaisID, entidad);
                }

                return Json(new
                {
                    success = true,
                    message = "Se elimino con éxito el monto de exigencia.",
                    extra = ""
                });
            }
            catch (Exception ex)
            {
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    extra = ""
                });
            }
        }
        #endregion
    }
}