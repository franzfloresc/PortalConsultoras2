namespace Portal.Consultoras.Web.Models
{
    public class PartialSectionBpt
    {
        public PartialSectionBpt()
        {
            RevistaDigital = new RevistaDigitalModel();
            ConfiguracionPaisDatos = new ConfiguracionPaisDatosModel();
        }

        public RevistaDigitalModel RevistaDigital { get; set; }

        public ConfiguracionPaisDatosModel ConfiguracionPaisDatos { get; set; }

        public bool TieneGND { get; set; }
    }
}