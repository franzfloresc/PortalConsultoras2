namespace Portal.Consultoras.Data.Hana.Entities
{
    public class FaltanteAnunciadoHana
    {
        public string DESPROD { get; set; }
        public string codigoRegion { get; set; }
        public string codigoVenta { get; set; }
        public string codigoZona { get; set; }
        public int estadoActivo { get; set; }
        public int idCampana { get; set; }
        public int idFaltanteAnunciado { get; set; }
        public int idPais { get; set; }
        public string indicadorCierreDiario { get; set; }
    }
}