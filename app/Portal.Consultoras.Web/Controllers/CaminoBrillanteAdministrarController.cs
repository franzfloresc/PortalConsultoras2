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
                var lst = Consulta == "1" ? GetListaBeneficiosByNivel(paisID, CodigoNivel) : new List<NivelCaminoBrillanteModel.BeneficioCaminoBrillanteModel>();
                lst = lst ?? new List<NivelCaminoBrillanteModel.BeneficioCaminoBrillanteModel>();

                BEGrid grid = new BEGrid
                {
                    PageSize = rows,
                    CurrentPage = page,
                    SortColumn = sidx,
                    SortOrder = sord
                };
                IEnumerable<NivelCaminoBrillanteModel.BeneficioCaminoBrillanteModel> items = lst;

                #region Sort Section
                //if (sord == "asc")
                //{
                //    switch (sidx)
                //    {
                //        case "TipoEstrategiaID":
                //            items = lst.OrderBy(x => x.TipoEstrategiaID);
                //            break;
                //        case "DescripcionEstrategia":
                //            items = lst.OrderBy(x => x.DescripcionEstrategia);
                //            break;
                //    }
                //}
                //else
                //{
                //    switch (sidx)
                //    {
                //        case "TipoEstrategiaID":
                //            items = lst.OrderByDescending(x => x.TipoEstrategiaID);
                //            break;
                //        case "DescripcionEstrategia":
                //            items = lst.OrderByDescending(x => x.DescripcionEstrategia);
                //            break;
                //    }
                //}
                #endregion

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
                model.listaCampania = new List<CampaniaModel>();
                model.listaZonas = new List<ZonaModel>();
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, userData.CodigoConsultora, userData.CodigoISO);
            }
            return View(model);
        }
        public JsonResult ConsultarMontoExigencia()
        {
            return null;
        }

        public JsonResult GuardarMontoExigencia(AdministrarMontoExigenciaModel model)
        {
            return null;
        }

        //public JsonResult ObtenerCampaniasYConfiguracionPorPais(int PaisID)
        //{
        //    IEnumerable<CampaniaModel> lst = _zonificacionProvider.GetCampanias(PaisID);
        //    IEnumerable<ConfiguracionOfertaModel> lstConfig = DropDowListConfiguracion(PaisID);
        //    string habilitarNemotecnico = _tablaLogicaProvider.GetTablaLogicaDatoCodigo(PaisID, ConsTablaLogica.Plan20.TablaLogicaId, ConsTablaLogica.Plan20.BusquedaNemotecnicoOfertaLiquidacion);

        //    return Json(new
        //    {
        //        lista = lst,
        //        lstConfig = lstConfig,
        //        habilitarNemotecnico = habilitarNemotecnico == "1"
        //    }, JsonRequestBehavior.AllowGet);
        //}

        //private IEnumerable<ConfiguracionOfertaModel> DropDowListConfiguracion(int paisId)
        //{
        //    List<BEConfiguracionOferta> lst;
        //    using (PedidoServiceClient sv = new PedidoServiceClient())
        //    {
        //        lstConfiguracion = sv.GetTipoOfertasAdministracion(paisId, Constantes.ConfiguracionOferta.Liquidacion).ToList();
        //        lst = lstConfiguracion;
        //    }

        //    return Mapper.Map<IList<BEConfiguracionOferta>, IEnumerable<ConfiguracionOfertaModel>>(lst);
        //}
        #endregion
    }
}