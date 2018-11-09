using Portal.Consultoras.Common;
using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.ServiceSAC;
using System.Collections.Generic;
using System.Linq;

namespace Portal.Consultoras.Web.Providers
{
    public class ComunicadoProvider
    {
        public List<BEComunicado> ObtenerComunicadoPorConsultora(UsuarioModel userSession, bool esMobile)
        {
            using (var sac = new SACServiceClient())
            {
                var lstComunicados = sac.ObtenerComunicadoPorConsultora(userSession.PaisID, userSession.CodigoConsultora,
                        (esMobile)?Constantes.ComunicadoTipoDispositivo.Mobile:Constantes.ComunicadoTipoDispositivo.Desktop, 
                        userSession.CodigorRegion, userSession.CodigoZona, userSession.ConsultoraNueva);

                return lstComunicados.ToList();
            }
        }
    }
}
