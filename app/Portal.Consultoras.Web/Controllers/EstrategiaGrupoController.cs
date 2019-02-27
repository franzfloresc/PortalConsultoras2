using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models.AdministrarEstrategia;
using Portal.Consultoras.Web.Models.Estrategia;
using Portal.Consultoras.Web.Models.Oferta.ResponseOfertaGenerico;
using Portal.Consultoras.Web.Providers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class EstrategiaGrupoController : BaseController
    {
        // tomar referencia de AdministrarEstrategiaMasivoController

        // GET: EstrategiaGrupo
        public ActionResult Index()
        {
            return View();
        }

        public JsonResult Guardar(List<EstrategiaGrupoModel> datos)
        {
            bool respuesta = false;
            if (ModelState.IsValid)
            {
                var userData = SessionManager.GetUserData();

                Task<bool> taskapi = null;
                if (datos.Count > 0)
                {
                    taskapi = Task.Run(() => estrategiaGrupoProvider.InsertarGrupoEstrategiaApi(Constantes.PersonalizacionOfertasService.UrlGuardarEstrategiaGrupo, datos, userData));
                    Task.WhenAll(taskapi);
                }
                respuesta = taskapi.Result;
            }

            return Json(new { mensaje = "ok", estado = respuesta }, JsonRequestBehavior.AllowGet);
        }

        //Basado en 'AdministrarShowRoomController/ConsultarOfertaShowRoomDetalleNew'
        public JsonResult ConsultarDetalleEstrategiaGrupo(string estrategiaId)
        {
            IEnumerable<Models.AdministrarEstrategia.EstrategiaGrupoModel> grupos = null;
            var userData = SessionManager.GetUserData();
              
            //INI AGANA 244

            //Estrategia gruepo

            var taskApi = Task.Run(() => estrategiaGrupoProvider.ObtenerEstrategiaGrupoApi(string.Format(Constantes.PersonalizacionOfertasService.UrlGetEstrategiaGrupoByEstrategiaId, userData.CodigoISO, estrategiaId), userData));
            Task.WhenAll(taskApi);
            var estrategiaGrupoLista = taskApi.Result;

            //Estrategia y sus componentes
            
            List<ServicePedido.BEEstrategiaProducto> lstComponentes = administrarEstrategiaProvider.FiltrarEstrategia(estrategiaId.ToString(), userData.CodigoISO).ToList().Select(x => x.Componentes).FirstOrDefault();
              
            var distinct = (from item in lstComponentes select new { EstrategiaId = estrategiaId, Grupo = item.Grupo }).Distinct();
            grupos = (from item in distinct
                      select new Models.AdministrarEstrategia.EstrategiaGrupoModel
                      { _idEstrategia = estrategiaId, EstrategiaGrupoId = 0, Grupo = item.Grupo, DescripcionSingular = string.Empty, DescripcionPlural = string.Empty }).ToList();

            //mapear campos
            if (estrategiaGrupoLista != null)
            {
                foreach (var item in grupos)
                {
                    int index = estrategiaGrupoLista.Result.ToList().FindIndex(x => x.Grupo.Equals(item.Grupo));
                    if (index != -1)
                    {
                        item.DescripcionSingular = estrategiaGrupoLista.Result.ToList()[index].DescripcionSingular;
                        item.DescripcionPlural = estrategiaGrupoLista.Result.ToList()[index].DescripcionPlural;
                    }
                }
            }
             
            //END AGANA 244





            return Json(grupos, JsonRequestBehavior.AllowGet);
        }
    }
}