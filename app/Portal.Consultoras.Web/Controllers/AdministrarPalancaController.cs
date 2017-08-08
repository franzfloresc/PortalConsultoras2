using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.ServiceModel;
using System.Web;
using System.Web.Mvc;
using AutoMapper;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceSAC;
using Portal.Consultoras.Web.ServiceUsuario;
using Portal.Consultoras.Web.ServiceZonificacion;
using Portal.Consultoras.Web.ServicePedido;
using Portal.Consultoras.Common;

namespace Portal.Consultoras.Web.Controllers
{
    public class AdministrarPalancaController : BaseController
    {
        // GET: AdministrarEstrategiaPerfil
        public ActionResult Index()
        {
            AdministrarPalancaModel model = new AdministrarPalancaModel();
            try
            {
                if (!UsuarioModel.HasAcces(ViewBag.Permiso, "AdministrarCupon/Index"))
                    return RedirectToAction("Index", "Bienvenida");

                model.ListaPaises = ListarPaises();
                model.ListaConfiguracionPais = ListarConfiguracionPais();
                return View(model);
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return View(model);
            }
        }

        public ActionResult GetPalanca(int idConfiguracionPais)
        {
            AdministrarPalancaModel model = new AdministrarPalancaModel();
            using (SACServiceClient sv = new SACServiceClient())
            {
                ServiceSAC.BEConfiguracionPais beConfiguracionPais = sv.GetConfiguracionPais(UserData().PaisID, idConfiguracionPais);
                model = Mapper.Map<ServiceSAC.BEConfiguracionPais, AdministrarPalancaModel>(beConfiguracionPais);
            }
            model.ListaCampanias = ObtenerCampaniasDesdeServicio(userData.PaisID);
            model.ListaTipoEstrategia = DropDowListTipoEstrategia();
            model.ListaTipoPresentacion = ListTipoPresentacion();
            return PartialView("Partials/ManatenimientoPalanca", model);
        }

        [HttpPost]
        public JsonResult Update(AdministrarPalancaModel model)
        {
            try
            {
                using (SACServiceClient sv = new SACServiceClient())
                {
                    var entidad = Mapper.Map<AdministrarPalancaModel, ServiceSAC.BEConfiguracionPais>(model);
                    sv.UpdateConfiguracionPais(entidad);
                }
                return Json(new
                {
                    success = true,
                    message = "Se grabó con éxito.",
                });
            }
            catch (Exception e)
            {
                Console.WriteLine(e);
                return Json(new
                {
                    success = false,
                    message = e.StackTrace,
                });
            }
           
        }

        private IEnumerable<PaisModel> ListarPaises()
        {
            List<BEPais> lst;
            using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
            {
                if (UserData().RolID == 2) lst = sv.SelectPaises().ToList();
                else
                {
                    lst = new List<BEPais>();
                    lst.Add(sv.SelectPais(UserData().PaisID));
                }

            }
            Mapper.CreateMap<BEPais, PaisModel>()
                    .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID))
                    .ForMember(t => t.Nombre, f => f.MapFrom(c => c.Nombre))
                    .ForMember(t => t.NombreCorto, f => f.MapFrom(c => c.NombreCorto));

            return Mapper.Map<IList<BEPais>, IEnumerable<PaisModel>>(lst);
        }

        private IEnumerable<ConfiguracionPaisModel> ListarConfiguracionPais()
        {
            List<ServiceSAC.BEConfiguracionPais> lst;
            using (SACServiceClient sv = new SACServiceClient())
            {
                lst =  sv.ListConfiguracionPais(UserData().PaisID, true).ToList();
            }
            return Mapper.Map<IList<ServiceSAC.BEConfiguracionPais>, IEnumerable<ConfiguracionPaisModel>>(lst);
        }

        private IEnumerable<CampaniaModel> ObtenerCampaniasDesdeServicio(int PaisID)
        {
            IList<BECampania> lst;
            using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
            {
                lst = sv.SelectCampanias(PaisID);
            }
            Mapper.CreateMap<BECampania, CampaniaModel>()
                .ForMember(t => t.CampaniaID, f => f.MapFrom(c => c.CampaniaID))
                .ForMember(t => t.Codigo, f => f.MapFrom(c => c.Codigo))
                .ForMember(t => t.Anio, f => f.MapFrom(c => c.Anio))
                .ForMember(t => t.NombreCorto, f => f.MapFrom(c => c.NombreCorto))
                .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID))
                .ForMember(t => t.Activo, f => f.MapFrom(c => c.Activo));

            return Mapper.Map<IList<BECampania>, IEnumerable<CampaniaModel>>(lst);
        }

        private IEnumerable<TipoEstrategiaModel> DropDowListTipoEstrategia()
        {
            List<BETipoEstrategia> lst;
            var entidad = new BETipoEstrategia();
            entidad.PaisID = UserData().PaisID;
            using (PedidoServiceClient sv = new PedidoServiceClient())
            {
                lst = sv.GetTipoEstrategias(entidad).ToList();
            }

            if (lst != null && lst.Count > 0)
            {
                var carpetaPais = Globals.UrlMatriz + "/" + UserData().CodigoISO;
                lst.Update(x => x.ImagenEstrategia = ConfigS3.GetUrlFileS3(carpetaPais, x.ImagenEstrategia, Globals.RutaImagenesMatriz + "/" + UserData().CodigoISO));
            }

            var lista = from a in lst
                where a.FlagActivo == 1
                select a;

            Mapper.CreateMap<BETipoEstrategia, TipoEstrategiaModel>()
                .ForMember(t => t.TipoEstrategiaID, f => f.MapFrom(c => c.TipoEstrategiaID))
                .ForMember(t => t.Descripcion, f => f.MapFrom(c => c.DescripcionEstrategia))
                .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID))
                .ForMember(t => t.FlagNueva, f => f.MapFrom(c => c.FlagNueva))
                .ForMember(t => t.FlagRecoPerfil, f => f.MapFrom(c => c.FlagRecoPerfil))
                .ForMember(t => t.FlagRecoProduc, f => f.MapFrom(c => c.FlagRecoProduc))
                .ForMember(t => t.Imagen, f => f.MapFrom(c => c.ImagenEstrategia))
                .ForMember(t => t.CodigoPrograma, f => f.MapFrom(c => c.CodigoPrograma));

            return Mapper.Map<IList<BETipoEstrategia>, IEnumerable<TipoEstrategiaModel>>(lista.ToList());
        }

        private IEnumerable<TablaLogicaDatosModel> ListTipoPresentacion()
        {
            var tabla = new List<BETablaLogicaDatos>();
            using (SACServiceClient sac = new SACServiceClient())
            {
                tabla = sac.GetTablaLogicaDatos(userData.PaisID, 120).ToList();
            }
            return Mapper.Map<IList<BETablaLogicaDatos>, IEnumerable<TablaLogicaDatosModel>>(tabla);
        }

    }
}