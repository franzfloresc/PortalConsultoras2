using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models.AdministrarEstrategia;
using Portal.Consultoras.Web.Providers;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class EstrategiaGrupoController : BaseController
    {
        protected readonly EstrategiaGrupoProvider estrategiaGrupoProvider;

        public EstrategiaGrupoController()
        {
            estrategiaGrupoProvider = new EstrategiaGrupoProvider();
        }

        public ActionResult Index()
        {
            return View();
        }

        public JsonResult Guardar(List<EstrategiaGrupoModel> datos)
        {
            bool respuesta = false;
            if (ModelState.IsValid)
            {
                //var userData = SessionManager.GetUserData();

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
            IEnumerable<EstrategiaGrupoModel> grupos = null;
            //var userData = SessionManager.GetUserData();

            //Estrategia gruepo

            var estrategiaGrupoLista = estrategiaGrupoProvider.ObtenerEstrategiaGrupo(estrategiaId, userData.CodigoISO);

            //Estrategia y sus componentes

            //mapear campos
            if (estrategiaGrupoLista.Any())
            {
                List<ServicePedido.BEEstrategiaProducto> lstComponentes = administrarEstrategiaProvider.FiltrarEstrategia(estrategiaId.ToString(), userData.CodigoISO).ToList().Select(x => x.Componentes).FirstOrDefault();

                var distinct = (from item in lstComponentes select new { EstrategiaId = estrategiaId, Grupo = item.Grupo }).Distinct();
                grupos = (from item in distinct
                          select new EstrategiaGrupoModel
                          { _idEstrategia = estrategiaId, EstrategiaGrupoId = 0, Grupo = item.Grupo, DescripcionSingular = string.Empty, DescripcionPlural = string.Empty }).ToList();

                foreach (var item in grupos)
                {
                    int index = estrategiaGrupoLista.FindIndex(x => x.Grupo.Equals(item.Grupo));
                    if (index != -1)
                    {
                        item._id = estrategiaGrupoLista[index]._id;
                        item.DescripcionSingular = estrategiaGrupoLista[index].DescripcionSingular;
                        item.DescripcionPlural = estrategiaGrupoLista[index].DescripcionPlural;
                    }
                }
            }

            return Json(grupos, JsonRequestBehavior.AllowGet);
        }
    }
}