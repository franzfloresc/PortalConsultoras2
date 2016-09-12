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
using Portal.Consultoras.Web.ServiceUsuario;
using Portal.Consultoras.Web.ServiceSAC;
using System.Security.Cryptography;

namespace Portal.Consultoras.Web.Controllers
{
    public class FacturaElectronicaController : BaseController
    {
        //
        // GET: /FacturaElectronica/

        public ActionResult Index()
        {
            string nroDocumento, Url = string.Empty;
            string nroRUC = null;

            if (UserData().CodigoISO == "EC" || UserData().CodigoISO == "PE")
            {
                if (UserData().CodigoISO == "EC")
                {
                    using (SACServiceClient svc = new SACServiceClient())
                    {
                        BEDatosBelcorp datos = svc.GetDatosBelcorp(UserData().PaisID).FirstOrDefault();
                        nroRUC = datos.RUC;
                    }
                }

                using (UsuarioServiceClient sv = new UsuarioServiceClient())
                {
                    switch (UserData().CodigoISO)
                    {
                        case "PE":
                            nroDocumento = sv.GetNroDocumentoConsultora(UserData().PaisID, UserData().CodigoConsultora);
                            Url = Common.NeoGridCipher.CreateProductionURL(nroDocumento);
                            break;
                        case "EC":
                            nroDocumento = sv.GetNroDocumentoConsultora(UserData().PaisID, UserData().CodigoConsultora);
                            Url = string.Format("IdEmpresa={0}&Identificacion={1}&HoraFecha={2}", nroRUC, nroDocumento, DateTime.Now.ToString("dd-MM-yyyy HH:mm:ss"));
                            Url = ConfigurationManager.AppSettings.Get("FacturaElectronica_EC") + Trancenter.IFacturaEcuador.EncriptTool.Encriptation.EncryptData("TUFIFAQTUAAECDZD", Url);
                            break;
                        default:
                            break;
                    }
                }

            }
            else 
            {
                return RedirectToAction("Index", "Bienvenida");
            }                     
            //string Url = Common.NeoGridCipher.CreateProductionURL("0016718829");
            return Redirect(Url);
        }
    }
}
