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
            BEUsuario usuario;

            using (UsuarioServiceClient sv = new UsuarioServiceClient())
            {
                usuario = sv.Select(UserData().PaisID, UserData().CodigoUsuario);
            }

            if (usuario != null)
            {
                string paisID = usuario.PaisID.ToString();

                string codigoConsultora;
                if (UserData().UsuarioPrueba == 1)
                {
                    codigoConsultora = UserData().ConsultoraAsociada;
                }
                else
                {
                    codigoConsultora = usuario.CodigoConsultora;
                }
                string mostrarAyudaWebTracking = Convert.ToInt32(usuario.MostrarAyudaWebTraking).ToString();
                string paisISO = userData.CodigoISO.Trim();
                string campanhaID = userData.CampaniaID.ToString();

                string url = "/WebPages/WebTracking.aspx?data=" + Util.EncriptarQueryString(paisID, codigoConsultora, mostrarAyudaWebTracking, paisISO, campanhaID);

                ViewBag.URLWebTracking = url;
            }

            return View();
        }
    }
}