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

                if (datos.FindAll(x => x.EstrategiaGrupoId != 0).Count == 0)
                {
                    taskapi = Task.Run(() => EstrategiaGrupoProvide.InsertarGrupoEstrategiaApi(Constantes.PersonalizacionOfertasService.UrlInsertEstrategiaGrupo, datos, userData));                   
                }
                else
                {
                    taskapi = Task.Run(() => EstrategiaGrupoProvide.ActualizarGrupoEstrategiaApi(Constantes.PersonalizacionOfertasService.UrlUpdateEstrategiaGrupo, datos, userData));                  
                }

                Task.WhenAll(taskapi);
                respuesta = taskapi.Result;
            }

            return Json(new { mensaje = "ok", estado = respuesta }, JsonRequestBehavior.AllowGet);
        }

        //Basado en 'AdministrarShowRoomController/ConsultarOfertaShowRoomDetalleNew'
        public JsonResult ConsultarDetalleEstrategiaGrupo(int estrategiaId)
        {
            IEnumerable<Models.AdministrarEstrategia.EstrategiaGrupoModel> res = null;
            var userData = SessionManager.GetUserData();
            if (ModelState.IsValid)
            {
                List<ServicePedido.BEEstrategiaProducto> lst;
                var estrategiaX = new ServicePedido.BEEstrategia() { PaisID = userData.PaisID, EstrategiaID = estrategiaId };

                using (var sv = new ServicePedido.PedidoServiceClient())
                {
                    lst = sv.GetEstrategiaProducto(estrategiaX).ToList();
                }

                var distinct = (from item in lst select new { EstrategiaId = item.EstrategiaID, Grupo = item.Grupo, }).Distinct();

                res = (from item in distinct select new Models.AdministrarEstrategia.EstrategiaGrupoModel { EstrategiaId = item.EstrategiaId, EstrategiaGrupoId = 0, Grupo = item.Grupo, DescripcionSingular = string.Empty, DescripcionPlural = string.Empty });
            }

            //Código para setear desde mongo

            //Estrategia
            List<EstrategiaMDbAdapterModel>  lstEstrategia =administrarEstrategiaProvider.FiltrarEstrategia(estrategiaId.ToString(), userData.CodigoISO).ToList();

            //EstrategiaGrupo
            //string pathMS = string.Format(Constantes.PersonalizacionOfertasService.UrlGetEstrategiaGrupoByEstrategiaId, userData.CodigoISO, estrategiaId);

            //var taskApi = Task.Run(() => EstrategiaGrupoProvide.ObtenerEstrategiaGrupoApi(pathMS, userData));
            //Task.WhenAll(taskApi);
            //var dd = taskApi.Result;

            return Json(res, JsonRequestBehavior.AllowGet);
        }
    }
}