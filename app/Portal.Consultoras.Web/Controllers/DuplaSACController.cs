﻿using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using System.Configuration;
using System.IO;
using System.Web.Mvc;

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

            string Url = GetConfiguracionManager(Constantes.ConfiguracionManager.URL_DUPLACYZONE) + texto;
            
            if (UserData().CodigoISO == "PE"
                || UserData().CodigoISO == "BO"
                || UserData().CodigoISO == "CO"
                || UserData().CodigoISO == "MX"
                || UserData().CodigoISO == "VE"
                || UserData().CodigoISO == "AR"
                || UserData().CodigoISO == "CL"
                || UserData().CodigoISO == "CR"
                || UserData().CodigoISO == "DO"
                || UserData().CodigoISO == "EC"
                || UserData().CodigoISO == "GT"
                || UserData().CodigoISO == "PR"
                || UserData().CodigoISO == "SV")
                Url = GetConfiguracionManager(Constantes.ConfiguracionManager.URL_DUPLACYZONE + UserData().CodigoISO);

            return Redirect(Url);
        }
    }
}
