using System.ComponentModel.DataAnnotations.Schema;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities.PagoEnLinea
{
    [DataContract]
    public class BEPagoEnLineaBanco
    {
        [DataMember]
        [Column("Id")]
        public int Id { get; set; }
        [DataMember]
        [Column("Banco")]
        public string Banco { get; set; }
        [DataMember]
        [Column("URlPaginaWeb")]
        public string URlPaginaWeb { get; set; }
        [DataMember]
        [Column("URLIcono")]
        public string URLIcono { get; set; }
        [DataMember]
        [Column("URIExternalApp")]
        public string URIExternalApp { get; set; }        
        [DataMember]
        [Column("Estado")]
        public bool Estado { get; set; }
    }
}
