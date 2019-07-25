using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Models.CaminoBrillante;
using Portal.Consultoras.Web.ServicePedido;
using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Web;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class CaminoBrillanteAdministrarController: BaseAdmController
    {
        static List<BEConfiguracionOferta> lstConfiguracion = new List<BEConfiguracionOferta>();

        public ActionResult AdministrarBeneficios(TipoEstrategiaModel model)
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