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
                respuesta = estrategiaGrupoProvider.Guardar(datos, userData.CodigoISO);
            }

            return Json(new { mensaje = "ok", estado = respuesta }, JsonRequestBehavior.AllowGet);
        }

        public JsonResult ConsultarDetalleEstrategiaGrupo(string estrategiaId, string codigoTipoEstrategia)
        {
            List<ServicePedido.BEEstrategiaProducto> lstComponentes = administrarEstrategiaProvider.GetEstrategiaProductoService(userData.CodigoISO, estrategiaId, codigoTipoEstrategia);
            var estrategiaGrupoLista = administrarEstrategiaProvider.GetEstrategiaGrupoService(userData.CodigoISO, estrategiaId, codigoTipoEstrategia);

            var distinct = (from item in lstComponentes select new { EstrategiaId = estrategiaId, Grupo = item.Grupo }).Distinct();
            List<EstrategiaGrupoModel> grupos = (from item in distinct
                      select new EstrategiaGrupoModel
                      { _idEstrategia = estrategiaId, EstrategiaGrupoId = 0, Grupo = item.Grupo, DescripcionSingular = string.Empty, DescripcionPlural = string.Empty }).ToList();

            foreach (var item in grupos)
            {
                if (!estrategiaGrupoLista.Any()) continue;
                item.Grupo = Util.Trim(item.Grupo);
                if (item.Grupo == "") continue;

                var find = estrategiaGrupoLista.FirstOrDefault(x => Util.Trim(x.Grupo).Equals(item.Grupo));
                if (find != null)
                {
                    item._id = find._id;
                    item._idEstrategia = find._idEstrategia;
                    item.EstrategiaGrupoId = find.EstrategiaGrupoId;
                    item.DescripcionSingular = Util.Trim(find.DescripcionSingular);
                    item.DescripcionPlural = Util.Trim(find.DescripcionPlural);
                }
            }

            //var grupos = new List<EstrategiaGrupoModel>();

            //var estrategiaGrupoLista = estrategiaGrupoProvider.ObtenerEstrategiaGrupo(estrategiaId, userData.CodigoISO);

            ////mapear campos
            //if (estrategiaGrupoLista.Any())
            //{
            //    List<ServicePedido.BEEstrategiaProducto> lstComponentes = administrarEstrategiaProvider.FiltrarEstrategia(estrategiaId.ToString(), userData.CodigoISO).ToList().Select(x => x.Componentes).FirstOrDefault();

            //    var distinct = (from item in lstComponentes select new { EstrategiaId = estrategiaId, Grupo = item.Grupo }).Distinct();
            //    grupos = (from item in distinct
            //              select new EstrategiaGrupoModel
            //              { _idEstrategia = estrategiaId, EstrategiaGrupoId = 0, Grupo = item.Grupo, DescripcionSingular = string.Empty, DescripcionPlural = string.Empty }).ToList();

            //    foreach (var item in grupos)
            //    {
            //        int index = estrategiaGrupoLista.FindIndex(x => x.Grupo.Equals(item.Grupo));
            //        if (index != -1)
            //        {
            //            item._id = estrategiaGrupoLista[index]._id;
            //            item.DescripcionSingular = estrategiaGrupoLista[index].DescripcionSingular;
            //            item.DescripcionPlural = estrategiaGrupoLista[index].DescripcionPlural;
            //        }
            //    }
            //}

            return Json(grupos, JsonRequestBehavior.AllowGet);
        }
    }
}