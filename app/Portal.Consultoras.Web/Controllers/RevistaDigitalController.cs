using System.Web.Mvc;
using Portal.Consultoras.Web.ServiceRevistaDigital;
using AutoMapper;
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

            var mensaje = "";
            if (!RevistaDigitalValidar(out mensaje))
            {
                return Json(new
                {
                    success = false,
                    message = mensaje
                }, JsonRequestBehavior.AllowGet);
            }

            var entidad = new BERevistaDigitalSuscripcion();
            entidad.PaisID = userData.PaisID;
            entidad.CodigoConsultora = userData.CodigoConsultora;
            entidad.CampaniaID = userData.CampaniaID;

            using (RevistaDigitalServiceClient sv = new RevistaDigitalServiceClient())
            {
                userData.RevistaDigital.EstadoSuscripcion = sv.Suscripcion(entidad);
                var rds = sv.GetSuscripcion(entidad);
                userData.RevistaDigital.SuscripcionModel = Mapper.Map<BERevistaDigitalSuscripcion, RevistaDigitalSuscripcionModel>(rds);
            }

            SetUserData(userData);

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
                userData.RevistaDigital.NoVolverMostrar = true;
                SetUserData(userData);

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