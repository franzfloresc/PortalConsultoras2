using System.ComponentModel.DataAnnotations.Schema;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities.CaminoBrillante
{
    [DataContract]
    public class BEDesmostradoresCaminoBrillante
    {
        /*
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
        //[Column("Descripcion")]
        [Column("Descripcion")]
        public string Descripcion { get; set; }
        */

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
        [Column("EstrategiaID")]
        public int EstrategiaID { get; set; }
        [DataMember]
        [Column("CodigoEstrategia")]
        public string CodigoEstrategia { get; set; }
        [DataMember]
        [Column("CUV")]
        public string CUV { get; set; }
        [DataMember]
        [Column("DescripcionCUV")]
        public string DescripcionCUV { get; set; }
        [DataMember]
        [Column("DescripcionCortaCUV")]
        public string DescripcionCortaCUV { get; set; }
        [DataMember]
        [Column("MarcaID")]
        public int MarcaID { get; set; }
        [DataMember]
        [Column("DescripcionMarca")]
        public string DescripcionMarca { get; set; }
        [DataMember]
        [Column("PrecioValorizado")]
        public decimal PrecioValorizado { get; set; }
        [DataMember]
        [Column("PrecioCatalogo")]
        public decimal PrecioCatalogo { get; set; }
        //[DataMember]
        //[Column("PrecioFinal")]
        //public decimal PrecioFinal { get; set; }
        //[DataMember]
        //[Column("Ganancia")]
        //public decimal Ganancia { get; set; }
        [DataMember]
        [Column("FotoProductoSmall")]
        public string FotoProductoSmall { get; set; }
        [DataMember]
        [Column("FotoProductoMedium")]
        public string FotoProductoMedium { get; set; }
        [DataMember]
        [Column("TipoEstrategiaID")]
        public int TipoEstrategiaID { get; set; }
        //[DataMember]
        //[Column("OrigenPedidoWebFicha")]
        //public int OrigenPedidoWebFicha { get; set; }
        [DataMember]
        public bool FlagSeleccionado { get; set; }
    }
}
