using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.Mvc;
using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;

namespace Portal.Consultoras.Web.Controllers
{
    public class DuplaSACController : BaseController
    {
        public ActionResult Index()
        {
            if (!UsuarioModel.HasAcces(ViewBag.Permiso, "DuplaSAC/Index"))
                return RedirectToAction("Index", "Bienvenida");

            string XmlPath = Server.MapPath("~/Key");
            string KeyPath = Path.Combine(XmlPath, "KeyPublicaEnvioCadena.xml");

            string PathData = "Aplicacion=2&CodigoUsuario=" + UserData().NombreConsultora + "&Pais=4";
            string texto = System.Web.HttpUtility.UrlEncode(Util.EncriptarDuplaCyzone(KeyPath, PathData));
            //byte[] bytesToEncode = Encoding.UTF8.GetBytes(texto);

            string Url = ConfigurationManager.AppSettings["URL_DUPLACYZONE"].ToString() + texto;

            if (UserData().CodigoISO == "PE")
                Url = ConfigurationManager.AppSettings["URL_DUPLACYZONEPE"].ToString();
            else if (UserData().CodigoISO == "BO")
                Url = ConfigurationManager.AppSettings["URL_DUPLACYZONEBO"].ToString();
            else if (UserData().CodigoISO == "CO")
                Url = ConfigurationManager.AppSettings["URL_DUPLACYZONECO"].ToString();
            else if (UserData().CodigoISO == "MX")
                Url = ConfigurationManager.AppSettings["URL_DUPLACYZONEMX"].ToString();
            else if (UserData().CodigoISO == "VE")
                Url = ConfigurationManager.AppSettings["URL_DUPLACYZONEVE"].ToString();
            else if (UserData().CodigoISO == "AR")
                Url = ConfigurationManager.AppSettings["URL_DUPLACYZONEAR"].ToString();
            else if (UserData().CodigoISO == "CL")
                Url = ConfigurationManager.AppSettings["URL_DUPLACYZONECL"].ToString();
            else if (UserData().CodigoISO == "CR")
                Url = ConfigurationManager.AppSettings["URL_DUPLACYZONECR"].ToString();
            else if (UserData().CodigoISO == "DO")
                Url = ConfigurationManager.AppSettings["URL_DUPLACYZONEDO"].ToString();
            else if (UserData().CodigoISO == "EC")
                Url = ConfigurationManager.AppSettings["URL_DUPLACYZONEEC"].ToString();
            else if (UserData().CodigoISO == "GT")
                Url = ConfigurationManager.AppSettings["URL_DUPLACYZONEGT"].ToString();
            else if (UserData().CodigoISO == "PR")
                Url = ConfigurationManager.AppSettings["URL_DUPLACYZONEPR"].ToString();
            else if (UserData().CodigoISO == "SV")
                Url = ConfigurationManager.AppSettings["URL_DUPLACYZONESV"].ToString();

            return Redirect(Url);
        }
    }
}
