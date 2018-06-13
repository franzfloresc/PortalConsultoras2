using Portal.Consultoras.Common;
using Portal.Consultoras.Web.ServiceSAC;
using Portal.Consultoras.Web.ServiceUsuario;
using System;
using System.Linq;
using System.Web.Mvc;

namespace Portal.Consultoras.Web.Controllers
{
    public class FacturaElectronicaController : BaseController
    {
        public ActionResult Index()
        {
            string url = string.Empty;
            string nroRuc = null;

            if (UserData().CodigoISO == Constantes.CodigosISOPais.Ecuador || UserData().CodigoISO == Constantes.CodigosISOPais.Peru)
            {
                if (UserData().CodigoISO == Constantes.CodigosISOPais.Ecuador)
                {
                    using (SACServiceClient svc = new SACServiceClient())
                    {
                        BEDatosBelcorp datos = svc.GetDatosBelcorp(UserData().PaisID).FirstOrDefault() ?? new BEDatosBelcorp();
                        nroRuc = datos.RUC;
                    }
                }

                using (UsuarioServiceClient sv = new UsuarioServiceClient())
                {
                    string nroDocumento;
                    switch (UserData().CodigoISO)
                    {
                        case Constantes.CodigosISOPais.Peru:
                            nroDocumento = sv.GetNroDocumentoConsultora(UserData().PaisID, UserData().CodigoConsultora);
                            url = NeoGridCipher.CreateProductionURL(nroDocumento);
                            break;
                        case Constantes.CodigosISOPais.Ecuador:
                            nroDocumento = sv.GetNroDocumentoConsultora(UserData().PaisID, UserData().CodigoConsultora);
                            url = string.Format("IdEmpresa={0}&Identificacion={1}&HoraFecha={2}", nroRuc, nroDocumento, DateTime.Now.ToString("dd-MM-yyyy HH:mm:ss"));
                            url = _configuracionManagerProvider.GetConfiguracionManager(Constantes.ConfiguracionManager.FacturaElectronica_EC) + Trancenter.IFacturaEcuador.EncriptTool.Encriptation.EncryptData("TUFIFAQTUAAECDZD", url);
                            break;
                    }
                }

            }
            else
            {
                return RedirectToAction("Index", "Bienvenida");
            }
            return Redirect(url);
        }
    }
}
