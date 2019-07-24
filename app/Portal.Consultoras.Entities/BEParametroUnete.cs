using Portal.Consultoras.Common;
using System;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEParametroUnete : BaseEntidad
    {
        [DataMember]
        [Column("Nombre")]
        public string Nombre { get; set; }

    }
}
