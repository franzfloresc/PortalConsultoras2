using System.Web.Mvc;
using Portal.Consultoras.Web.ServiceRevistaDigital;
using AutoMapper;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.ServiceSAC;
using System.Collections.Generic;
using System.Linq;

namespace Portal.Consultoras.Web.Controllers
{
    public class RevistaDigitalController : BaseController
    {
        public ActionResult Index()
        {
            if (!ValidarPermiso(Constantes.MenuCodigo.RevistaDigital))
            {
                return RedirectToAction("Index", "Bienvenida");
            }
            var model = new CatalogoPersonalizadoModel();

            if (Session["ListFiltersFAV"] != null)
            {
                var lst = (List<BETablaLogicaDatos>)Session["ListFiltersFAV"] ?? new List<BETablaLogicaDatos>();
                model.FiltersBySorting = lst.Where(x => x.TablaLogicaID == 94).ToList();
                model.FiltersByCategory = lst.Where(x => x.TablaLogicaID == 95).ToList();
                model.FiltersByBrand = lst.Where(x => x.TablaLogicaID == 96).ToList();
                model.FiltersByPublished = lst.Where(x => x.TablaLogicaID == 97).ToList();
            }

            return View(model);
        }

        private bool RevistaDigitalValidar(out string respuesta)
        {
            var activo = true;

            //using (PedidoServiceClient sv = new PedidoServiceClient())
            //{
            //    listaShowRoomCPC = sv.GetProductosCompraPorCompra(userData.PaisID, eventoId, campaniaId).ToList();
            //}

            respuesta = "";

            return activo;
        }

        [HttpGet]
        public JsonResult Suscripcion()
        {
            if (userData.RevistaDigital.EstadoSuscripcion == 1)
            {
                return Json(new
                {
                    success = false,
                    message = "USTED YA ESTÁ SUSCRITO, GRACIAS."
                }, JsonRequestBehavior.AllowGet);
            }

            // Usar este metodo para validadcion extras (aun no esta en uso)
            //var mensaje = "";
            //if (!RevistaDigitalValidar(out mensaje))
            //{
            //    return Json(new
            //    {
            //        success = false,
            //        message = mensaje
            //    }, JsonRequestBehavior.AllowGet);
            //}

            var entidad = new BERevistaDigitalSuscripcion();
            entidad.PaisID = userData.PaisID;
            entidad.CodigoConsultora = userData.CodigoConsultora;
            entidad.CampaniaID = userData.CampaniaID;
            entidad.CodigoZona = userData.CodigoZona;
            entidad.EstadoRegistro = Constantes.EstadoRDSuscripcion.Activo;
            entidad.IsoPais = userData.CodigoISO;
            entidad.EMail = userData.EMail;

            using (RevistaDigitalServiceClient sv = new RevistaDigitalServiceClient())
            {
                if (sv.Suscripcion(entidad) > 0)
                {
                    var rds = sv.GetSuscripcion(entidad);
                    userData.RevistaDigital.SuscripcionModel = Mapper.Map<BERevistaDigitalSuscripcion, RevistaDigitalSuscripcionModel>(rds);
                    userData.RevistaDigital.NoVolverMostrar = true;
                    userData.RevistaDigital.EstadoSuscripcion = userData.RevistaDigital.SuscripcionModel.EstadoRegistro;
                }
            }

            SetUserData(userData);
            Session["TipoPopUpMostrar"] = null;

            return Json(new
            {
                success = userData.RevistaDigital.EstadoSuscripcion > 0,
                message = userData.RevistaDigital.EstadoSuscripcion > 0 ? "GRACIAS POR SUSCRIBIRSE." : "OCURRIÓ UN ERROR, VUELVA A INTENTARLO."
            }, JsonRequestBehavior.AllowGet);
        }

        [HttpGet]
        public JsonResult PopupNoVolverMostrar()
        {
            try
            {
                var entidad = new BERevistaDigitalSuscripcion();
                entidad.PaisID = userData.PaisID;
                entidad.CodigoConsultora = userData.CodigoConsultora;
                entidad.CampaniaID = userData.CampaniaID;
                entidad.CodigoZona = userData.CodigoZona;
                entidad.EstadoRegistro = Constantes.EstadoRDSuscripcion.NoPopUp;
                entidad.IsoPais = userData.CodigoISO;
                entidad.EMail = userData.EMail;

                using (RevistaDigitalServiceClient sv = new RevistaDigitalServiceClient())
                {
                    if (sv.Suscripcion(entidad) > 0)
                    {
                        userData.RevistaDigital.NoVolverMostrar = true;
                        userData.RevistaDigital.EstadoSuscripcion = Constantes.EstadoRDSuscripcion.NoPopUp;
                    }
                }
                SetUserData(userData);
                Session["TipoPopUpMostrar"] = null;

                return Json(new
                {
                    success = true
                }, JsonRequestBehavior.AllowGet);
            }
            catch (System.Exception)
            {
                return Json(new
                {
                    success = false,
                    message = ""
                }, JsonRequestBehavior.AllowGet);
            }
        }
    }
}