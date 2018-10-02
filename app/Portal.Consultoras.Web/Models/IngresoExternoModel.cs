namespace Portal.Consultoras.Web.Models
{
    public class IngresoExternoModel
    {
        public string Pais { get; set; }
        public string CodigoUsuario { get; set; }
        public string Pagina { get; set; }
        public string Version { get; set; }
        public string Campania { get; set; }
        public string NumeroPedido { get; set; }
        public long ProcesoId { get; set; }
        public string AutoReservar { get; set; }
        public string TipoCatalogo { get; set; }
        public string UrlCatalogo { get; set; }
        public bool EsAppMobile { get; set; }
        public int ClienteID { get; set; }
        /// <summary>
        /// Identificador unico para App Mobile, usado como tokenPedido 
        /// </summary>
        public string Identifier { get; set; }
        public string CUV { get; set; }
        public string NombrePalanca { get; set; }
        public string PalancaID { get; set; }
        public string OrigenPedido { get; set; }
    }
}