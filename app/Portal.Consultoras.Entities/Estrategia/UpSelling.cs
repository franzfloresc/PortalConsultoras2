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
        public string CodigoCampana { get; set; }

        [DataMember]
        [Column("TextoMetaPrincipal")]
        public string TextoMetaPrincipal { get; set; }

        [DataMember]
        [Column("TextoInferior")]
        public string TextoInferior { get; set; }

        [DataMember]
        [Column("TextoGanastePrincipal")]
        public string TextoGanastePrincipal { get; set; }

        [DataMember]
        [Column("TextoGanasteBoton")]
        public string TextoGanasteBoton { get; set; }

        [DataMember]
        [Column("TextoGanastePremio")]
        public string TextoGanastePremio { get; set; }

        [DataMember]
        [Column("ImagenFondoPrincipalDesktop")]
        public string ImagenFondoPrincipalDesktop { get; set; }

        [DataMember]
        [Column("ImagenFondoPrincipalMobile")]
        public string ImagenFondoPrincipalMobile { get; set; }

        [DataMember]
        [Column("ImagenFondoGanasteMobile")]
        public string ImagenFondoGanasteMobile { get; set; }

        [DataMember]
        [Column("Activo")]
        public bool Activo { get; set; }

        [DataMember]
        //[NotMapped]
        public List<UpSellingDetalle> Regalos { get; set; }
    }
}
