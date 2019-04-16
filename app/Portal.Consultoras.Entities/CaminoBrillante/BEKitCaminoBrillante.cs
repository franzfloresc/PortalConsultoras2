using System.ComponentModel.DataAnnotations.Schema;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities.CaminoBrillante
{
    [DataContract]
    public class BEKitCaminoBrillante
    {
        //Quitar
        [DataMember]
        public int EstrategiaId { get; set; }
        [DataMember]
        public int TipoEstrategia { get; set; }
        [DataMember]
        public int OrigenPedido { get; set; }
        [DataMember]
        public string Cuv { get; set; }
        [DataMember]
        public string Descripcion { get; set; }
        [DataMember]
        public decimal Precio { get; set; }
        [DataMember]
        public string Marca { get; set; }
        [DataMember]
        public string DescripcionOferta { get; set; }
        [DataMember]
        public string Imagen { get; set; }


        //Ok
        //public string CodigoKit { get; set; }
        //public string CodigoSap { get; set; }
        [DataMember]
        public string Nivel { get; set; }
        [DataMember]
        public int Digitable { get; set; }


        //Nueva Estructura
        [DataMember]
        [Column("EstrategiaID")]
        public int EstrategiaID { get; set; }
        [DataMember]
        [Column("CodigoEstrategia")]
        public string CodigoEstrategia { get; set; }
        [DataMember]
        //[Column("Cuv")]
        public string CodigoKit { get; set; }
        [DataMember]
        //[Column("Cuv")]
        public string CodigoSap { get; set; }
        [DataMember]
        [Column("CUV")]
        public string CUV { get; set; }
        [DataMember]
        [Column("DescripcionCUV")]
        public string DescripcionCUV { get; set; }
        [DataMember]
        //[Column("Cuv")]
        public string DescripcionCortaCUV { get; set; }
        [DataMember]
        [Column("MarcaID")]
        public int MarcaID { get; set; }
        [DataMember]
        [Column("DescripcionMarca")]
        public string DescripcionMarca { get; set; }
        [DataMember]
        //[Column("Cuv")]
        public string CodigoNivel { get; set; }
        [DataMember]
        //[Column("Cuv")]
        public string DescripcionNivel { get; set; }
        [DataMember]
        [Column("PrecioValorizado")]
        public decimal PrecioValorizado { get; set; }
        [DataMember]
        //[Column("PrecioCatalogo")]
        public decimal PrecioCatalogo { get; set; }
        [DataMember]
        //[Column("Cuv")]
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

        //Pendiente actualizar el nombre
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
