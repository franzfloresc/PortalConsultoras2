using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BECatalogoIssuu
    {
        [DataMember]
        public int PaisID { get; set; }
        [DataMember]
        public int MarcaID { get; set; }
        [DataMember]
        public string CodigoIssuu { get; set; }
        [DataMember]
        public string UrlVisor { get; set; }
    }
}
