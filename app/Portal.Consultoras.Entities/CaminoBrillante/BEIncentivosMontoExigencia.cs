using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.Entities.CaminoBrillante
{
    [DataContract]
    public class BEIncentivosMontoExigencia
    {
        [DataMember]
        [Column("MontoID")]
        public int MontoID { get; set; }
        [DataMember]
        [Column("CodigoCampania")]
        public string CodigoCampania { get; set; }
        [DataMember]
        [Column("CodigoRegion")]
        public string CodigoRegion { get; set; }
        [DataMember]
        [Column("CodigoZona")]
        public string CodigoZona { get; set; }
        [DataMember]
        [Column("Monto")]
        public string Monto { get; set; }
        [DataMember]
        [Column("AlcansoIncentivo")]
        public string AlcansoIncentivo { get; set; }
        [DataMember]
        [Column("Estado")]
        public bool Estado { get; set; }
    }
}
