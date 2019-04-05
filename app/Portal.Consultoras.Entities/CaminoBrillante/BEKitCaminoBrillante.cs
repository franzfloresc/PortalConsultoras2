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
        public int EstrategiaID { get; set; }
        [DataMember]
        public string CodigoEstrategia { get; set; }
        [DataMember]
        public string CodigoKit { get; set; }
        [DataMember]
        public string CodigoSap { get; set; }
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
        [DataMember]
        public string CodigoNivel { get; set; }
        [DataMember]
        public string DescripcionNivel { get; set; }
        [DataMember]
        public decimal PrecioValorizado { get; set; }
        [DataMember]
        public decimal PrecioCatalogo { get; set; }
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
        [DataMember]
        public bool FlagSeleccionado { get; set; }
        [DataMember]
        public int FlagDigitable { get; set; }
        [DataMember]
        public bool FlagHabilitado { get; set; }
    }
}
