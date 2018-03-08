using Portal.Consultoras.Common;
using System;

namespace Portal.Consultoras.Web.Models
{
    public class RegaloOfertaFinalModel
    {
        public string CodigoISO { get; set; }

        public int CampaniaId { get; set; }

        public int ConsultoraId { get; set; }

        public double MontoPedido { get; set; }

        public double GapMinimo { get; set; }

        public double GapMaximo { get; set; }

        public double GapAgregar { get; set; }

        public double MontoMeta { get; set; }

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