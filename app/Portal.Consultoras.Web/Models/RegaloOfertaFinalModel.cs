using System;
using Portal.Consultoras.Common;

namespace Portal.Consultoras.Web.Models
{
    public class RegaloOfertaFinalModel
    {
        public string CodigoISO { get; set; }

        public int CampaniaId { get; set; }

        public int ConsultoraId { get; set; }

        public decimal MontoPedido { get; set; }

        public decimal GapMinimo { get; set; }

        public decimal GapMaximo { get; set; }

        public decimal GapAgregar { get; set; }

        public decimal MontoMeta { get; set; }

        public string Cuv { get; set; }

        public string TipoRango { get; set; }

        public string Descripcion { get; set; }

        public string RegaloDescripcion { get; set; }
   
        public string RegaloImagenUrl { get; set; }

        public string FormatoMontoPedido
        {
            get
            {
                return Util.DecimalToStringFormat(Convert.ToDecimal(MontoPedido), CodigoISO);
            }
        }

        public string FormatoMontoMeta
        {
            get
            {
                return Util.DecimalToStringFormat(Convert.ToDecimal(MontoMeta), CodigoISO);
            }
        }
    }
}