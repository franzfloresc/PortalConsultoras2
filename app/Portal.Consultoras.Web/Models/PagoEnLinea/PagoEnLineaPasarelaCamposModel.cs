using System;

namespace Portal.Consultoras.Web.Models.PagoEnLinea
{
    [Serializable]
    public class PagoEnLineaPasarelaCamposModel
    {
        public int PagoEnLineaPasarelaCamposId { get; set; }
        public string Codigo { get; set; }
        public string Descripcion { get; set; }
        public bool EsObligatorio { get; set; }
        public bool Estado { get; set; }
    }
}