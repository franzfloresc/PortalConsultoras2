using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities.CaminoBrillante
{
    [DataContract]
    public class BEOfertaCaminoBrillante
    {
        [DataMember]
        public int TipoOferta { get; set; }

        [DataMember]
        public int EstrategiaID { get; set; }
        [DataMember]
        public string CodigoEstrategia { get; set; }
        [DataMember]
        public int TipoEstrategiaID { get; set; }

        [DataMember]
        public string CUV { get; set; }
        [DataMember]
        public string DescripcionCUV { get; set; }
        [DataMember]
        public string DescripcionCortaCUV { get; set; }

        [DataMember]
        public int MarcaID { get; set; }
        [DataMember]
        public string CodigoMarca { get; set; }
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
        public bool FlagSeleccionado { get; set; }
        [DataMember]
        public int FlagDigitable { get; set; }
        [DataMember]
        public bool FlagHabilitado { get; set; }
        [DataMember]
        public bool FlagHistorico { get; set; }

        [DataMember]
        public int EsCatalogo { get; set; }
    }
}
