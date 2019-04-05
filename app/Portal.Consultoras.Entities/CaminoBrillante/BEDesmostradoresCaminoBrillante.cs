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
        //[Column("CUV")]
        [Column("Cuv")]
        public string Cuv { get; set; }

        [DataMember]
        //[Column("CodigoProducto")]
        [Column("CodigoProducto")]
        public string CodigoProducto { get; set; }

        [DataMember]
        //[Column("PrecioCatalogo")]
        [Column("PrecioCatalogo")]
        public decimal PrecioCatalogo { get; set; }

        [DataMember]
        //[Column("PrecioValorizado")]
        [Column("PrecioValorizado")]
        public decimal PrecioValorizado { get; set; }

        [DataMember]
        //[Column("Descripcion")]
        [Column("Descripcion")]
        public string Descripcion { get; set; }

        /*
        public BEDesmostradoresCaminoBrillante(IDataRecord row)
        {
            Cuv = row.ToString("Cuv");
            CodigoProducto = row.ToString("CodigoProducto");
            PrecioCatalogo = row.ToString("PrecioCatalogo");
            PrecioValorizado = row.ToString("PrecioValorizado");
            Descripcion = row.ToString("Descripcion");
        }
        */

        [DataMember]
        public int EstrategiaID { get; set; }
        [DataMember]
        public string CodigoEstrategia { get; set; }
        [DataMember]
        public string CUV { get; set; }
        [DataMember]
        public string DescripcionCUV { get; set; }
        [DataMember]
        public string DescripcionCortaCUV { get; set; }
        [DataMember]
        public int MarcaID { get; set; }
        [DataMember]
        public string DescripcionMarca { get; set; }
        //public decimal PrecioValorizado { get; set; }
        [DataMember]
        public decimal PrecioFinal { get; set; }
        [DataMember]
        public decimal Ganancia { get; set; }
        [DataMember]
        public string FotoProductoSmall { get; set; }
        [DataMember]
        public string FotoProductoMedium { get; set; }
        [DataMember]
        public string TipoEstrategiaID { get; set; }
        [DataMember]
        public int OrigenPedidoWebFicha { get; set; }

    }
}
