using Portal.Consultoras.Common;
using Portal.Consultoras.Web.ServiceUsuario;
using System;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class TrackingController : BaseController
    {
        //
        // GET: /Tracking/

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
                
                //Inicio ITG 1793 HFMG
                string codigoConsultora;
                if (UserData().UsuarioPrueba == 1)
                {
                    codigoConsultora = UserData().ConsultoraAsociada;
                }
                else
                {
                    codigoConsultora = usuario.CodigoConsultora;
                }
                //Fin ITG 1793 HFMG
                string mostrarAyudaWebTracking = Convert.ToInt32(usuario.MostrarAyudaWebTraking).ToString();
                string paisISO = UserData().CodigoISO.Trim();
                string campanhaID = UserData().CampaniaID.ToString();
                
                string url = "/WebPages/WebTracking.aspx?data=" + Util.EncriptarQueryString(paisID, codigoConsultora, mostrarAyudaWebTracking, paisISO, campanhaID);

                ViewBag.URLWebTracking = url;   
            }

            return View();
        }
    }
}
