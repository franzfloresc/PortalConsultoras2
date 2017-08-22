using Portal.Consultoras.Web.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Web;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class AsesoraOnlineController : Controller
    {
        // GET: AsesoraOnline
        public ActionResult Index(string isoPais, string codigoConsultora)
        {
            ViewBag["IsoPais"] = isoPais;
            ViewBag["CodigoConsultora"] = codigoConsultora;
            return View();
        }

        //public JsonResult RegistrarEstrategia(RegistrarEstrategiaModel model)

        [HttpPost]
        public JsonResult EnviarFormulario(AsesoraOnlineModel model)
        {
            try
            {

                /*
                 *     var entidad = new BETallaColor();
                entidad.ID = 0;
                entidad.CUV = "0";
                entidad.Tipo = "0";
                entidad.CampaniaID = 0;
                entidad.PaisID = UserData().PaisID;
                entidad.DescripcionTallaColor = xmlTallaColor;
                entidad.UsuarioRegistro = UserData().CodigoUsuario;
                entidad.UsuarioModificacion = UserData().CodigoUsuario;

                using (PedidoServiceClient sv = new PedidoServiceClient())
                {
                    resultado = sv.InsertarTallaColorCUV(entidad);
                }

                 */
                return Json(new
                {
                    success = true,
                    message = "Se grabó con éxito el formulario.",
                    extra = ""
                });
            }
            catch (FaultException ex)
            {
                LogManager.LogManager.LogErrorWebServicesPortal(ex, "UserData().CodigoConsultora", "UserData().CodigoISO");
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    extra = ""
                });
            }
            catch (Exception ex)
            {
                LogManager.LogManager.LogErrorWebServicesBus(ex, "UserData().CodigoConsultora", "UserData().CodigoISO");
                return Json(new
                {
                    success = false,
                    message = ex.Message,
                    extra = ""
                });
            }
        }
    }
}