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
    public class BEPedidoWebSetDetalle
    {
        [DataMember]
        [Column("SetDetalleID")]
        public int SetDetalleId { get; set; }

        [DataMember]
        [Column("SetID")]
        public int SetId { get; set; }

        [DataMember]
        [Column("CuvProducto")]
        public string CuvProducto { get; set; }

        [DataMember]
        [Column("NombreProducto")]
        public string NombreProducto { get; set; }

        [DataMember]
        [Column("Cantidad")]
        public int Cantidad { get; set; }

        [DataMember]
        [Column("CantidadOriginal")]
        public int CantidadOriginal { get; set; }

        [DataMember]
        [Column("FactorRepeticion")]
        public int FactorRepeticion { get; set; }

        [DataMember]
        [Column("PedidoDetalleID")]
        public int PedidoDetalleId { get; set; }

        [DataMember]
        [Column("PrecioUnidad")]
        public decimal PrecioUnidad { get; set; }

        [DataMember]
        [Column("TipoOfertaSisID")]
        public int TipoOfertaSisId { get; set; }

        [DataMember]
        [Column("SetIdentifierNumber")]
        public int SetIdentifierNumber { get; set; }
        
    }
}
