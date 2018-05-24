using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using System;
using System.Linq;
using System.Web.Mvc;
using Portal.Consultoras.Web.Models.PagoEnLinea;
using System.ServiceModel;
using System.Text;
using Portal.Consultoras.Common.PagoEnLinea;
using System.Net;
using System.IO;
using System.Web;
using Portal.Consultoras.Web.ServicePedido;

namespace Portal.Consultoras.Web.Areas.Mobile.Controllers
{
    public class MiPerfilController : BaseMobileController
    {

        public ActionResult Index()
        {
            return View();
        }

        public ActionResult CambiarContrasenia()
        {
            return View();
        }

        public ActionResult CambiarFotoPerfil()
        {
            return View();
        }
        
    }
}