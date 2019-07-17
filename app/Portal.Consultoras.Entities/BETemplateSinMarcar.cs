using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BETemplateSinMarcar
    {
        [DataMember]
        [Column("FieldName")]
        public string FieldName { get; set; }

        [DataMember]
        [Column("Size")]
        public int Size { get; set; }
    }
}
