namespace Portal.Consultoras.Web.Areas.Mobile.Models
{
    public class BienvenidaModel
    {
        public string Saludo { get; set; }
        public string NombreConsultora { get; set; }
        public string Simbolo { get; set; }
        public string NombrePais { get; set; }
        public string NumeroCampania { get; set; }
        public string CodigoZona { get; set; }
        public int DiasParaCierre { get; set; }
        public string RutaChile { get; set; }
        public string UrlChileEncriptada { get; set; }
        public string MensajeCierreCampania { get; set; }
        public int TieneFechaPromesa { get; set; }
        public int PaisID { get; set; }
        public int DiaFechaPromesa { get; set; }
        public string MensajeFechaPromesa { get; set; }
        public int IndicadorPermisoFIC { get; set; }
        public string InscritaFlexipago { get; set; }
        public string InvitacionRechazada { get; set; }
        public bool PortalLideres { get; set; }
        public int Lider { get; set; }
        public bool DiaPROL { get; set; }
        public bool PROL1 { get; set; }
        public decimal MontoAhorroCatalogo { get; set; }
        public decimal MontoAhorroRevista { get; set; }
        public decimal MontoPedido { get; set; }
        public string CodigoISO { get; set; }
        public decimal MontoDeuda { get; set; }
        public string FechaVencimiento { get; set; }
    }
}