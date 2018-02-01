namespace Portal.Consultoras.Web.Models
{
    public class BarraConsultoraEscalaDescuentoModel
    {
        public decimal MontoDesde { get; set; }
        public string MontoDesdeStr { get; set; }

        public decimal MontoHasta { get; set; }
        public string MontoHastaStr { get; set; }

        public int PorDescuento { get; set; }

    }
}