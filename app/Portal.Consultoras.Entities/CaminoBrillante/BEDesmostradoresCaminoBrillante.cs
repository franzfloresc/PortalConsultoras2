using Portal.Consultoras.Common;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities.CaminoBrillante
{
    [DataContract]
    public class BEDesmostradoresCaminoBrillante
    {
        [DataMember]
        [Column("CUV")]
        public string Cuv { get; set; }

        [DataMember]
        [Column("CodigoProducto")]
        public string CodigoProducto { get; set; }

        [DataMember]
        [Column("PrecioCatalogo")]
        public string PrecioCatalogo { get; set; }

        [DataMember]
        [Column("PrecioValorizado")]
        public string PrecioValorizado { get; set; }

        [DataMember]
        [Column("Descripcion")]
        public string Descripcion { get; set; }

        public BEDesmostradoresCaminoBrillante(IDataRecord row)
        {
            Cuv = row.ToString("Cuv");
            CodigoProducto = row.ToString("CodigoProducto");
            PrecioCatalogo = row.ToString("PrecioCatalogo");
            PrecioValorizado = row.ToString("PrecioValorizado");
            Descripcion = row.ToString("Descripcion");
        }
    }
}
