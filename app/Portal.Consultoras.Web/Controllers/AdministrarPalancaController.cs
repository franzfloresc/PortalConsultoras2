using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Web;
using System.Web.Mvc;
using AutoMapper;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceSAC;
using Portal.Consultoras.Web.ServiceUsuario;
using Portal.Consultoras.Web.ServiceZonificacion;

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

        [HttpPost]
        public virtual ActionResult Get(int idConfiguracionPais)
        {
            AdministrarPalancaModel model = new AdministrarPalancaModel();
            using (SACServiceClient sv = new SACServiceClient())
            {
                ServiceSAC.BEConfiguracionPais beConfiguracionPais = sv.GetConfiguracionPais(UserData().PaisID, idConfiguracionPais);
                model = Mapper.Map<ServiceSAC.BEConfiguracionPais, AdministrarPalancaModel>(beConfiguracionPais);
            }
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
    }
}