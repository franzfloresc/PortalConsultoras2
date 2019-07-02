using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEProductoBusqueda
    {
        [DataMember]
        public int PaisID { get; set; }
        [DataMember]
        public int CampaniaID { get; set; }
        [DataMember]
        public string Marca { get; set; }
        [DataMember]
        public string Categoria { get; set; }
        [DataMember]
        public string Nombres { get; set; }
        [DataMember]
        public string CodigoDescripcion { get; set; }
        [DataMember]
        public int RegionID { get; set; }
        [DataMember]
        public int ZonaID { get; set; }
        [DataMember]
        public string CodigoRegion { get; set; }
        [DataMember]
        public string CodigoZona { get; set; }
        [DataMember]
        public int Criterio { get; set; }
        [DataMember]
        public int RowCount { get; set; }
        [DataMember]
        public bool ValidarOpt { get; set; }
        [DataMember]
        public string CodigoPrograma { get; set; }
        [DataMember]
        public int NumeroPedido { get; set; }
    }
}
