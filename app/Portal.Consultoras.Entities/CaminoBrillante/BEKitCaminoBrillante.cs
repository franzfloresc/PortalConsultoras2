using System.ComponentModel.DataAnnotations.Schema;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities.CaminoBrillante
{
    [DataContract]
    public class BEKitCaminoBrillante
    {
        [DataMember]
        [Column("EstrategiaID")]
        public int EstrategiaID { get; set; }
        [DataMember]
        [Column("CodigoEstrategia")]
        public string CodigoEstrategia { get; set; }
        [DataMember]
        public string CodigoKit { get; set; }
        [DataMember]
        public string CodigoSap { get; set; }
        [DataMember]
        [Column("CUV")]
        public string CUV { get; set; }
        [DataMember]
        [Column("DescripcionCUV")]
        public string DescripcionCUV { get; set; }
        [DataMember]
        public string DescripcionCortaCUV { get; set; }
        [DataMember]
        [Column("MarcaID")]
        public int MarcaID { get; set; }
        [DataMember]
        [Column("DescripcionMarca")]
        public string DescripcionMarca { get; set; }
        [DataMember]
        public string CodigoNivel { get; set; }
        [DataMember]
        public string DescripcionNivel { get; set; }
        [DataMember]
        [Column("PrecioValorizado")]
        public decimal PrecioValorizado { get; set; }
        [DataMember]
        public decimal PrecioCatalogo { get; set; }
        [DataMember]
        public decimal Ganancia { get; set; }
        [DataMember]
        [Column("FotoProductoSmall")]
        public string FotoProductoSmall { get; set; }
        [DataMember]
        [Column("FotoProductoMedium")]
        public string FotoProductoMedium { get; set; }
        [DataMember]
        [Column("TipoEstrategiaID")]
        public int TipoEstrategiaID { get; set; }
        [DataMember]
        [Column("OrigenPedidoWebFicha")]
        public int OrigenPedidoWebFicha { get; set; }
        [DataMember]
        public bool FlagSeleccionado { get; set; }
        [DataMember]
        public int FlagDigitable { get; set; }
        [DataMember]
        public bool FlagHabilitado { get; set; }
        [DataMember]
        public bool FlagHistorico { get; set; }
      
    }
}
