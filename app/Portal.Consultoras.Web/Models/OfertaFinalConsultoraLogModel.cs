using System;

namespace Portal.Consultoras.Web.Models
{
    public class OfertaFinalConsultoraLogModel
    {
        public long OfertaFinalConsultoraID { get; set; }

        public int CampaniaID { get; set; }

        public string CodigoConsultora { get; set; }

        public string CUV { get; set; }

        public int Cantidad { get; set; }

        public DateTime Fecha { get; set; }

        public string TipoOfertaFinal { get; set; }

        public decimal GAP { get; set; }

        public int TipoRegistro { get; set; }

        public string DesTipoRegistro { get; set; }
    }
}