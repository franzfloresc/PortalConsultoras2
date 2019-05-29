using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEContenidoApp
    {
        [DataMember]

        [Column("IdContenido")]
        public int IdContenido { get; set; }

        [DataMember]
        [Column("Codigo")]
        public string Codigo { get; set; }

        [DataMember]
        [Column("UrlMiniatura")]
        public string UrlMiniatura { get; set; }

        [DataMember]
        [Column("Estado")]
        public bool Estado { get; set; }

        [DataMember]
        public int CantidadContenido { get; set; }

        [DataMember]
        [Column("DesdeCampania")]
        public int DesdeCampania { get; set; }

        [DataMember]
        public List<BEContenidoAppDetalle> DetalleContenido { get; set; }

        [DataMember]
        [Column("RutaImagen")]
        public string RutaImagen { get; set; }

        public BEContenidoApp() { }
    }
}

       
