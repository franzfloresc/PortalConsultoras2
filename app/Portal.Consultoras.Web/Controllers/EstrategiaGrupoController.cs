using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models.AdministrarEstrategia;
using Portal.Consultoras.Web.Models.Oferta.ResponseOfertaGenerico;
using Portal.Consultoras.Web.Providers;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class EstrategiaGrupoController : BaseAdmController
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
            OutputEstrategiaGrupo respuesta = new OutputEstrategiaGrupo();
            if (ModelState.IsValid)
            {
                respuesta = estrategiaGrupoProvider.Guardar(datos, userData.CodigoISO);
            }

            return Json(new { mensaje = respuesta.Message, estado = respuesta.Success }, JsonRequestBehavior.AllowGet);
        }

        public JsonResult ConsultarDetalleEstrategiaGrupo(string estrategiaId, string codigoTipoEstrategia)
        {
            List<ServicePedido.BEEstrategiaProducto> lstComponentes = administrarEstrategiaProvider.GetEstrategiaProductoService(userData.CodigoISO, estrategiaId, codigoTipoEstrategia);
            var estrategiaGrupoLista = administrarEstrategiaProvider.GetEstrategiaGrupoService(userData.CodigoISO, estrategiaId, codigoTipoEstrategia);

            var distinct = (from item in lstComponentes select new { EstrategiaId = estrategiaId, Grupo = item.Grupo }).Distinct();
            List<EstrategiaGrupoModel> grupos = (from item in distinct
                                                 select new EstrategiaGrupoModel
                                                 { _idEstrategia = estrategiaId, EstrategiaGrupoId = 0, Grupo = item.Grupo, DescripcionSingular = string.Empty, DescripcionPlural = string.Empty }).ToList();

            grupos = grupos.OrderBy(g => g.Grupo).ToList();

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

            return Json(grupos, JsonRequestBehavior.AllowGet);
        }
    }
}