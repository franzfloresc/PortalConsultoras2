using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web.Mvc;
using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.Models.Search.ResponseOferta.Estructura;

namespace Portal.Consultoras.Web.Controllers
{
    [RoutePrefix("ArmaTuPack")]
    public class ArmaTuPackController : BaseController
    {
        public ActionResult Index()
        {
            var cuv = Request.QueryString["cuv"];

            if (String.IsNullOrEmpty(cuv))
            {
                //var estrategia = PreparListaModel(
                //    new BusquedaProductoModel()
                //    {
                //        CampaniaID = userData.CampaniaID
                //    },
                //    Constantes.TipoConsultaOfertaPersonalizadas.ATPObtenerProductos);

                return Json(new { respuesta = true }, JsonRequestBehavior.AllowGet);
            }
            else
            {
                return RedirectToAction("Detalle", "ArmaTuPack", new { cuv = cuv });
            }
        }

        [HttpGet()]
        public ActionResult Detalle()
        {

            var area = "";
            if (Request.Browser.IsMobileDevice)
            {
                area = "mobile";
            }

            var listaOfertasATP = _ofertaPersonalizadaProvider.ConsultarEstrategiasModel(IsMobile(), userData.CodigoISO, userData.CampaniaID, userData.CampaniaID, Constantes.TipoEstrategiaCodigo.ArmaTuPack).ToList();

            if (listaOfertasATP == null){ return RedirectToAction("ofertas", "ficha", new { Area = area }); };
            if (listaOfertasATP.Count() == 0){ return RedirectToAction("ofertas", "ficha", new { Area = area }); }

            var OfertaATP = listaOfertasATP.FirstOrDefault();
            var lstPedidoAgrupado = ObtenerPedidoWebSetDetalleAgrupado(false);
            var packAgregado = lstPedidoAgrupado!=null? lstPedidoAgrupado.Where(x => x.TipoEstrategiaCodigo == Constantes.TipoEstrategiaCodigo.ArmaTuPack).FirstOrDefault() : null;

            var DetalleEstrategiaFichaModel = new DetalleEstrategiaFichaModel {

                CUV2 = OfertaATP.CUV2,
                TipoEstrategiaID = OfertaATP.TipoEstrategiaID,
                EstrategiaID = OfertaATP.EstrategiaID,
                FlagNueva = OfertaATP.FlagNueva,
                CodigoVariante = OfertaATP.CodigoEstrategia,
                EsEditable = packAgregado == null ? false : true
            };

            return View(DetalleEstrategiaFichaModel);
        }

        [HttpGet()]
        [Route("GetPackComponents/{cuv:int}")]
        public ActionResult GetPackComponents(string cuv)
        {
            if (string.IsNullOrEmpty(cuv)) throw new ArgumentNullException("cuv", "is null or empty.");

            return View();
        }

        [HttpPost()]
        public JsonResult GetComponentes(string Cuv)
        {
            try
            {
                var estrategiaModelo = new EstrategiaPersonalizadaProductoModel
                {
                    CampaniaID = userData.CampaniaID,
                    CUV2 = Cuv
                };
                bool esMultimarca = false;
                string mensaje = "";

                var componentes =  _estrategiaComponenteProvider.GetListaComponentes(estrategiaModelo, 
                    Constantes.TipoEstrategiaCodigo.ArmaTuPack, out esMultimarca, out mensaje);
                //var componentes = Mapper.Map<IList<Componente>, IList<EstrategiaComponenteModel>>(estrategia.Componentes);
                //var componentes = Mapper.Map<Componente, EstrategiaComponenteModel>(estrategia);
                //var componentes = estrategia;
                return Json(new
                {
                    success = true,
                    componentes = componentes,
                    mensaje
                }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, userData.CodigoConsultora, userData.CodigoISO);
                return Json(new
                {
                    success = false
                }, JsonRequestBehavior.AllowGet);
            }
            }
        }
}