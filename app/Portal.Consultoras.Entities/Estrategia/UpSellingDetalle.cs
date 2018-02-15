using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.Entities.Estrategia
{
    /// <summary>
    /// Regalos
    /// </summary>
    [DataContract]
    public class UpSellingDetalle : Auditoria
    {
        [DataMember]
        [Column("UpSellingDetalleId")]
        public int UpSellingDetalleId { get; set; }

        [DataMember]
        [Column("CUV")]
        public string CUV { get; set; }

        [DataMember]
        [Column("Nombre")]
        public string Nombre { get; set; }

        [DataMember]
        [Column("Descripcion")]
        public string Descripcion { get; set; }

        [DataMember]
        [Column("Imagen")]
        public string Imagen { get; set; }

        [DataMember]
        [Column("Stock")]
        public int Stock { get; set; }

        [DataMember]
        [Column("Orden")]
        public int Orden { get; set; }

        [DataMember]
        [Column("Activo")]
        public bool Activo { get; set; }

        [DataMember]
        [Column("UpSellingId")]
        public string UpSellingId { get; set; }
    }
}
