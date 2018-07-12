using Portal.Consultoras.Common;
using Portal.Consultoras.Web.ServiceUsuario;
using System;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class TrackingController : BaseController
    {
        public ActionResult Index()
        {
            if (EsDispositivoMovil())
            { 
                return RedirectToAction("Index", "SeguimientoPedido", new { area = "Mobile" });
            }

            BEUsuario usuario;

            using (UsuarioServiceClient sv = new UsuarioServiceClient())
            {
                usuario = sv.Select(UserData().PaisID, UserData().CodigoUsuario);
            }

            if (usuario != null)
            {
                string paisId = usuario.PaisID.ToString();

                var codigoConsultora = UserData().UsuarioPrueba == 1
                    ? UserData().ConsultoraAsociada
                    : usuario.CodigoConsultora;
                string mostrarAyudaWebTracking = Convert.ToInt32(usuario.MostrarAyudaWebTraking).ToString();
                string paisIso = userData.CodigoISO.Trim();
                string campanhaId = userData.CampaniaID.ToString();

                string url = "/WebPages/WebTracking.aspx?data=" + Util.EncriptarQueryString(paisId, codigoConsultora, mostrarAyudaWebTracking, paisIso, campanhaId);

                ViewBag.URLWebTracking = url;
            }

            return View();
        }
    }
}