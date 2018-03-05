using System.Collections.Generic;
using System.Runtime.Serialization;

using System.ComponentModel.DataAnnotations.Schema;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEMenuApp
    {
        [DataMember]
        [Column("MenuAppId")]
        public int MenuAppId { get; set; }
        [DataMember]
        [Column("Codigo")]
        public string Codigo { get; set; }
        [DataMember]
        [Column("Descripcion")]
        public string Descripcion { get; set; }
        [DataMember]
        [Column("Orden")]
        public int Orden { get; set; }
        [DataMember]
        [Column("CodigoMenuPadre")]
        public string CodigoMenuPadre { get; set; }
        [DataMember]
        [Column("Posicion")]
        public int Posicion { get; set; }
        [DataMember]
        public List<BEMenuApp> SubMenus { get; set; }

        [DataMember]
        public int paisId { get; set; }
        [DataMember]
        public string CodigoRegion { get; set; }
        [DataMember]
        public string CodigoZona { get; set; }
        [DataMember]
        public string CodigoSeccion { get; set; }
        [DataMember]
        public string CodigoConsultora { get; set; }
        [DataMember]
        [Column("Visible")]
        public bool Visible { get; set; }
        [DataMember]
        public short VersionMenu { get; set; }
    }
}