using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities.CDR
{
    public class BECDRTipoOperacion
    {
        [DataMember]
        public string CodigoOperacion { get; set; }
        [DataMember]
        public string DescripcionOperacion { get; set; }
        [DataMember]
        public decimal NumeroDiasAtrasOperacion { get; set; }

        public BECDRTipoOperacion()
        { }

        public BECDRTipoOperacion(IDataRecord row)
        {
            CodigoOperacion = row.ToString("CodigoOperacion");
            DescripcionOperacion = row.ToString("DescripcionOperacion");
            NumeroDiasAtrasOperacion = row.ToDecimal("NumeroDiasAtrasOperacion");
        }
    }
}
