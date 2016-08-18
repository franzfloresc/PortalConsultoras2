using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Portal.Consultoras.Web.ServiceZonificacion;
using Portal.Consultoras.Web.ServiceSAC;
using Portal.Consultoras.Web.ServiceContenido;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using AutoMapper;
using System.ServiceModel;
using System.Configuration;


namespace Portal.Consultoras.Web.Controllers
{
    public class AdministrarBelcorpRespondeController : BaseController
    {
        //
        // GET: /AdministrarBelcorpResponde/

        public ActionResult Index()
        {
            //if (!UsuarioModel.HasAcces(ViewBag.Permiso, "AdministrarBelcorpResponde/Index"))
            //    return RedirectToAction("Index", "Bienvenida");

            AdministrarBelcorpRespondeModel model = new AdministrarBelcorpRespondeModel();

            var paisID = UserData().PaisID;

            try
            {
                List<BEBelcorpResponde> lista = new List<BEBelcorpResponde>();
                using (ContenidoServiceClient svc = new ContenidoServiceClient())
                {
                    lista = svc.GetBelcorpRespondeAdministrador(Convert.ToInt32(paisID)).ToList();
                    
                    var belcorpResponde = lista.FirstOrDefault();

                    if (belcorpResponde != null)
	                {
                        model.Chat = belcorpResponde.Chat ?? string.Empty;
                        model.ChatURL = belcorpResponde.ChatURL ?? string.Empty;
                        model.PaisID = belcorpResponde.PaisID;
                        model.Telefono1 = belcorpResponde.Telefono1 ?? string.Empty;
                        model.Telefono2 = belcorpResponde.Telefono2 ?? string.Empty;
                        model.Escribenos = belcorpResponde.Escribenos ?? string.Empty;
                        model.EscribenosURL = belcorpResponde.EscribenosURL ?? string.Empty;
                        model.Correo = belcorpResponde.Correo ?? string.Empty;
                        model.CorreoBcc = belcorpResponde.CorreoBcc ?? string.Empty;
                        model.ParametroPais = belcorpResponde.ParametroPais;
                        model.ParametroCodigoConsultora = belcorpResponde.ParametroCodigoConsultora;
	                }
                }
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
            }

            model.lstPais = DropDowListPaises();
            return View(model);
        }

        [HttpPost]
        public JsonResult Consultar(string PaisID)
        {
            try
            {
                List<BEBelcorpResponde> lista = new List<BEBelcorpResponde>();
                using (ContenidoServiceClient svc = new ContenidoServiceClient())
                {
                    lista = svc.GetBelcorpRespondeAdministrador(Convert.ToInt32(PaisID)).ToList();
                }

                return Json(new
                {
                    success = true,
                    lista = lista,
                    cantidad = lista.Count
                });
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = ex.Message
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Ocurrió un error inesperado al Eliminar el registro, Por favor intente nuevamente."
                });
            }
        }

        [HttpPost]
        public JsonResult Registrar(AdministrarBelcorpRespondeModel model)
        {
            string message = string.Empty;
            string finalPath = string.Empty, httpPath = string.Empty;
            try
            {
                Mapper.CreateMap<AdministrarBelcorpRespondeModel, BEBelcorpResponde>()
                   .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID))
                   .ForMember(t => t.Telefono1, f => f.MapFrom(c => c.Telefono1))
                   .ForMember(t => t.Telefono2, f => f.MapFrom(c => c.Telefono2))
                   .ForMember(t => t.Escribenos, f => f.MapFrom(c => c.Escribenos))
                   .ForMember(t => t.EscribenosURL, f => f.MapFrom(c => c.EscribenosURL))
                   .ForMember(t => t.Correo, f => f.MapFrom(c => c.Correo))
                   .ForMember(t => t.CorreoBcc, f => f.MapFrom(c => c.CorreoBcc))
                   .ForMember(t => t.Chat, f => f.MapFrom(c => c.Chat))
                   .ForMember(t => t.ChatURL, f => f.MapFrom(c => c.ChatURL))
                   .ForMember(t => t.ParametroPais, f => f.MapFrom(c => c.ParametroPais))
                   .ForMember(t => t.ParametroCodigoConsultora, f => f.MapFrom(c => c.ParametroCodigoConsultora));

                BEBelcorpResponde entidad = Mapper.Map<AdministrarBelcorpRespondeModel, BEBelcorpResponde>(model);

                using (ContenidoServiceClient sv = new ContenidoServiceClient())
                {
                    sv.InsBelcorpResponde(entidad);
                }

                EliminarCacheBelcorpResponde(entidad.PaisID);

                return Json(new
                {
                    success = true,
                    message = "Se registró con éxito los datos de Belcorp Responde.",
                    extra = ""
                });
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Ocurrio un error inesperado al registrar datos de Belcorp Responde, Por favor intente nuevamente",
                    extra = ""
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, UserData().CodigoConsultora, UserData().CodigoISO);
                return Json(new
                {
                    success = false,
                    message = "Ocurrio un error inesperado al registrar datos de Belcorp Responde, Por favor intente nuevamente",
                    extra = ""
                });
            }
        }

        private IEnumerable<PaisModel> DropDowListPaises()
        {
            List<BEPais> lst;
            using (ZonificacionServiceClient sv = new ZonificacionServiceClient())
            {
                //if (UserData().RolID == 2) lst = sv.SelectPaises().ToList();
                //else
                //{
                //    lst = new List<BEPais>();
                //    lst.Add(sv.SelectPais(UserData().PaisID));
                //}

                lst = sv.SelectPaises().ToList();
            }
            Mapper.CreateMap<BEPais, PaisModel>()
                    .ForMember(t => t.PaisID, f => f.MapFrom(c => c.PaisID))
                    .ForMember(t => t.Nombre, f => f.MapFrom(c => c.Nombre))
                    .ForMember(t => t.NombreCorto, f => f.MapFrom(c => c.NombreCorto));

            return Mapper.Map<IList<BEPais>, IEnumerable<PaisModel>>(lst);
        }

        public void EliminarCacheBelcorpResponde(int PaisId)
        {
            try
            {
                        using (ContenidoServiceClient svc = new ContenidoServiceClient())
                        {
                            svc.DeleteBelcorpRespondeCache(PaisId);
                        }
                    }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, "", Util.GetPaisISO(PaisId));
            }
        }
    }
}
