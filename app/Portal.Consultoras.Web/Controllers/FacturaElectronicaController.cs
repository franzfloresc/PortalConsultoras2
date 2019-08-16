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
            string url;
            string nroDocumento;
            string nroRuc = null;

            if (userData.CodigoISO == Constantes.CodigosISOPais.Ecuador)
            {
                using (var svc = new SACServiceClient())
                {
                    var datos = svc.GetDatosBelcorp(userData.PaisID).FirstOrDefault() ?? new BEDatosBelcorp();
                    nroRuc = datos.RUC;
                }
            }

            using (var sv = new UsuarioServiceClient())
                nroDocumento = sv.GetNroDocumentoConsultora(userData.PaisID, userData.CodigoConsultora);
            if (string.IsNullOrEmpty(nroDocumento)) return RedirectToAction("Index", "Bienvenida");

            switch (userData.CodigoISO)
            {
                case Constantes.CodigosISOPais.Peru:
                    var baseUrl = _configuracionManagerProvider.GetConfiguracionManager(Constantes.ConfiguracionManager.NeogridUrl);
                    var key = _configuracionManagerProvider.GetConfiguracionManager(Constantes.ConfiguracionManager.NeogridKey);
                    url = new NeoGridCipher(baseUrl, key).CreateUrl(nroDocumento);
                    return Redirect(url);
                case Constantes.CodigosISOPais.Ecuador:
                    url = string.Format("IdEmpresa={0}&Identificacion={1}&HoraFecha={2}", nroRuc, nroDocumento, DateTime.Now.ToString("dd-MM-yyyy HH:mm:ss"));
                    url = _configuracionManagerProvider.GetConfiguracionManager(Constantes.ConfiguracionManager.FacturaElectronica_EC) + Trancenter.IFacturaEcuador.EncriptTool.Encriptation.EncryptData("TUFIFAQTUAAECDZD", url);
                    return Redirect(url);
            }

            url = GetDatosFacturacionElectronica(userData.PaisID, Constantes.FacturacionElectronica.TablaLogicaID, Constantes.FacturacionElectronica.Url);
            if (string.IsNullOrEmpty(url)) return RedirectToAction("Index", "Bienvenida");
            var parametros = GetDatosFacturacionElectronica(userData.PaisID, Constantes.FacturacionElectronica.TablaLogicaID, Constantes.FacturacionElectronica.Parametros);
            if (string.IsNullOrEmpty(parametros)) return RedirectToAction("Index", "Bienvenida");
            parametros = string.Format(parametros, userData.CodigoISO, nroDocumento);
            return Redirect(url + parametros);
        }  
    }
}
