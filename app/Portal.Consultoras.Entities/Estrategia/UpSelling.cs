using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.Entities.Estrategia
{
    [DataContract]
    public class UpSelling : Auditoria
    {
        /// <summary>
        /// Prevent default instatiation
        /// </summary>
        public UpSelling()
        {
            Regalos = new List<UpSellingDetalle>();
        }

        [DataMember]
        [Column("UpSellingId")]
        public int UpSellingId { get; set; }

        [DataMember]
        [Column("CodigoCampana")]
        public int CodigoCampana { get; set; }

        [DataMember]
        [Column("MontoMeta")]
        public decimal MontoMeta { get; set; }

        [DataMember]
        [Column("TextoMeta1")]
        public string TextoMeta { get; set; }

        [DataMember]
        [Column("TextoMeta2")]
        public string TextoMetaSecundario { get; set; }

        [DataMember]
        [Column("TextoGanaste1")]
        public string TextoGanaste { get; set; }

        [DataMember]
        [Column("TextoGanaste2")]
        public string TextoGanasteSecundario { get; set; }

        [DataMember]
        [Column("Activo")]
        public bool Activo { get; set; }

        [DataMember]
        [NotMapped]
        public List<UpSellingDetalle> Regalos { get; set; }
    }
}
