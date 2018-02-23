namespace Portal.Consultoras.Web.Models
{
    public class AdministrarComponenteDatosModel
    {
        public string TxtLabel { get; set; }
        public string TipoDato { get; set; }
        public int Orden { get; set; }

        public ConfiguracionPaisDatosModel Dato { get; set; }
    }
}