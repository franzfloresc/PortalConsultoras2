using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BECatalogoRevista
    {
        [DataMember]
        public int MarcaID { get; set; }
        [DataMember]
        public string MarcaDescripcion { get; set; }
        [DataMember]
        public string UrlImagen { get; set; }
        [DataMember]
        public string UrlVisor { get; set; }
        [DataMember]
        public bool Mostrar { get; set; }

        public string CodigoCatalogo { get; set; }
    }
}
