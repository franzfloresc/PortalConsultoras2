using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.Entities.Pedido
{
    [DataContract]
    public class BEPedidoWebSet
    {
        [DataMember]
        [Column("SetID")]
        public int SetId { get; set; }

        [DataMember]
        [Column("PedidoID")]
        public int PedidoId { get; set; }

        [DataMember]
        [Column("CuvSet")]
        public string CuvSet { get; set; }

        [DataMember]
        [Column("EstrategiaId")]
        public int EstrategiaId { get; set; }

        [DataMember]
        [Column("NombreSet")]
        public string NombreSet { get; set; }

        [DataMember]
        [Column("Cantidad")]
        public int Cantidad { get; set; }

        [DataMember]
        [Column("PrecioUnidad")]
        public decimal PrecioUnidad { get; set; }

        [DataMember]
        [Column("ImporteTotal")]
        public decimal ImporteTotal { get; set; }

        [DataMember]
        [Column("TipoEstrategiaId")]
        public int TipoEstrategiaId { get; set; }

        [DataMember]
        [Column("Campania")]
        public int Campania { get; set; }

        [DataMember]
        [Column("ConsultoraID")]
        public long ConsultoraId { get; set; }

        [DataMember]
        [Column("OrdenPedido")]
        public int OrdenPedido { get; set; }

        //todo: usar audit
        [DataMember]
        [Column("CodigoUsuarioCreacion")]
        public string CodigoUsuarioCreacion { get; set; }

        [DataMember]
        [Column("CodigoUsuarioModificacion")]
        public string CodigoUsuarioModificacion { get; set; }

        [DataMember]
        [Column("FechaCreacion")]
        public DateTime? FechaCreacion { get; set; }

        [DataMember]
        [Column("FechaModificacion")]
        public DateTime? FechaModificacion { get; set; }

        [NotMapped]
        [DataMember]
        public IEnumerable<BEPedidoWebSetDetalle> Detalles { get; set; }

        [DataMember]
        [Column("ClienteId")]
        public int ClienteId { get; set; }

        //todo: usar audit
        [DataMember]
        [Column("ClienteNombre")]
        public string ClienteNombre { get; set; }
    }
}
