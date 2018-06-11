using Portal.Consultoras.Web.Models;
using Portal.Consultoras.Web.SessionManager;

namespace Portal.Consultoras.Web.Providers
{
    public class GuiaNegocioProvider
    {
        private readonly ISessionManager sessionManager = SessionManager.SessionManager.Instance;
        
        public virtual bool GNDValidarAcceso(bool esConsultoraLider, GuiaNegocioModel guiaNegocio, RevistaDigitalModel revistaDigital)
        {
            var tieneAcceso = (guiaNegocio.TieneGND && !(revistaDigital.EsSuscritaActiva() || revistaDigital.EsNoSuscritaActiva())) ||
                (esConsultoraLider && guiaNegocio.TieneGND && revistaDigital.SociaEmpresariaExperienciaGanaMas && revistaDigital.EsSuscritaActiva());
            return tieneAcceso;
        }

    }

}