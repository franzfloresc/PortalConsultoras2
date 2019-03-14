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
        [Route("Detalle/{cuv:int}")]
        public ActionResult Detalle(string cuv)
        {
            if (string.IsNullOrEmpty(cuv)) throw new ArgumentNullException("cuv", "is null or empty.");

            return View();
        }

        [HttpGet()]
        [Route("GetPackComponents/{cuv:int}")]
        public ActionResult GetPackComponents(string cuv)
        {
            if (string.IsNullOrEmpty(cuv)) throw new ArgumentNullException("cuv", "is null or empty.");

            return View();
        }
        [HttpGet()]
        [Route("Componentes/{cuv:int}")]
        public async Task<JsonResult> GetComponentes(string Cuv)
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
                var estrategia = await _estrategiaComponenteProvider.GetListaComponenteArmaTuPack(estrategiaModelo, Constantes.TipoEstrategiaCodigo.ArmaTuPack);
                //var componentes = Mapper.Map<IList<Componente>, IList<EstrategiaComponenteModel>>(estrategia.Componentes);
                var componentes = Mapper.Map<Componente, EstrategiaComponenteModel>(estrategia.Componentes.First());
                return Json(new
                {
                    success = true,
                    esMultimarca,
                    TipoEstrategiaID = estrategia.TipoEstrategiaId,
                    EstrategiaID = estrategia.EstrategiaId,
                    Cuv = estrategia.CUV2,
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
                } , JsonRequestBehavior.AllowGet);
            }
        }
    }
}