using Portal.Consultoras.Web.Models;

namespace Portal.Consultoras.Web.Providers
{
    public class GuiaNegocioProvider
    {
        public GuiaNegocioProvider()
        {
        }

        public virtual bool GNDValidarAcceso(bool esConsultoraLider, GuiaNegocioModel guiaNegocio, RevistaDigitalModel revistaDigital)
        {
            var tieneAcceso = (guiaNegocio.TieneGND && !(revistaDigital.EsSuscritaActiva() || revistaDigital.EsNoSuscritaActiva())) ||
                (esConsultoraLider && guiaNegocio.TieneGND && revistaDigital.SociaEmpresariaExperienciaGanaMas && revistaDigital.EsSuscritaActiva());
            return tieneAcceso;
        }

    }

}