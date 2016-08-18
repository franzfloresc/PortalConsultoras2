using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Http;
using Portal.Consultoras.Common;
using System.Configuration;
using System.Text;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceUsuario;

namespace Portal.Consultoras.Web.Controllers
{
    public class LiderController : BaseController
    {
        public ActionResult Index()
        {
            string[] parametros; string strCodigoUsuario;
            if (userData.ConsultoraAsociada.ToString().Trim().Length > 0)
            {
                UsuarioServiceClient sv = new UsuarioServiceClient();
                strCodigoUsuario = sv.GetUsuarioAsociado(userData.PaisID, userData.ConsultoraAsociada);
            }
            else
            {
                strCodigoUsuario = userData.CodigoUsuario.ToString();
            }
            parametros = new string[]
			    {
				    userData.PaisID.ToString() + "|" + strCodigoUsuario
			    };
            string str = Util.EncriptarQueryString(parametros);
            string url = ConfigurationManager.AppSettings["URL_LIDER"].ToString() + "?p=" + str.ToString();
            return Redirect(url);
        }

    }
}
