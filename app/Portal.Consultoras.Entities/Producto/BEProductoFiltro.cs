using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities.Producto
{
    [DataContract]
    public class BEProductoFiltro
    {
        [DataMember]
        public int paisID { get; set; }
        [DataMember]
        public int campaniaID { get; set; }
        [DataMember]
        public string codigoDescripcion { get; set; }
        [DataMember]
        public int RegionID { get; set; }
        [DataMember]
        public int ZonaID { get; set; }
        [DataMember]
        public string CodigoRegion { get; set; }
        [DataMember]
        public string CodigoZona { get; set; }
        [DataMember]
        public int criterio { get; set; }
        [DataMember]
        public int rowCount { get; set; }
        [DataMember]
        public bool validarOpt { get; set; }
    }
}
