using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities.CaminoBrillante
{
    [DataContract]
    public class BEDemostradoresCaminoBrillante
    {
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
        [Column("CodigoMarca")]
        public string CodigoMarca { get; set; }
        [DataMember]
        [Column("DescripcionMarca")]
        public string DescripcionMarca { get; set; }
        [DataMember]
        [Column("PrecioValorizado")]
        public decimal PrecioValorizado { get; set; }
        [DataMember]
        [Column("PrecioCatalogo")]
        public decimal PrecioCatalogo { get; set; }
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
        [Column("EsCatalogo")]
        public int EsCatalogo { get; set; }
        [DataMember]
        public bool FlagSeleccionado { get; set; }
    }

    public class BEDemostradoresPaginado
    {
        [DataMember]
        [Column("LstDemostradores")]
        public List<BEDemostradoresCaminoBrillante> LstDemostradores { get; set; }
        [DataMember]
        [Column("Total")]
        public int Total { get; set; } 
    }
}
