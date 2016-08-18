using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Portal.Consultoras.Common;
using System.Configuration;
using System.Text;
using System.IO;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceContenido;
using Portal.Consultoras.Web.ServiceUsuario;

namespace Portal.Consultoras.Web.Controllers
{
    public class FamiliaProtegidaController : BaseController
    {
        //
        // GET: /FamiliaProtegida/

        public ActionResult Index()
        {
            string nroDocumento;
            using (UsuarioServiceClient sv = new UsuarioServiceClient())
            {
                nroDocumento = sv.GetNroDocumentoConsultora(UserData().PaisID, UserData().CodigoConsultora);
            }

            string Url = DevolverURL(UserData().CodigoISO);
            string[] parametros = new string[] { UserData().CodigoISO, UserData().CodigoConsultora, "", nroDocumento, UserData().NombreConsultora, "", UserData().EMail, UserData().Celular, UserData().Telefono, UserData().CodigoZona };

            Url = Url + "?data=" + Util.EncriptarQueryString(parametros);

            return Redirect(Url);
        }

        private string DevolverURL(string ISOPais)
        {
            return ConfigurationManager.AppSettings["URL_FAMILIAPROTEGIDA_" + ISOPais].ToString(); // 2224
        }

    }
}