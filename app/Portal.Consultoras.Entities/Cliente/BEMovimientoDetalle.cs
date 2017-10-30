using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities.Cliente
{
    /// <summary>
    /// Entidad Movimiento Detalle
    /// </summary>
    [DataContract]
    public class BEMovimientoDetalle
    {
        /// <summary>
        /// Id de la tabla autogenerado
        /// </summary>
        [DataMember]
        public long PedidoWebFacturadoID { get; set; }
        /// <summary>
        /// cantidad del CUV
        /// </summary>
        [DataMember]
        public int Cantidad { get; set; }
        /// <summary>
        /// precio del CUV
        /// </summary>
        [DataMember]
        public decimal PrecioUnidad { get; set; }
        /// <summary>
        /// Importe total del CUV (Cantidad * PrecioUnidad)
        /// </summary>
        [DataMember]
        public decimal ImporteTotal { get; set; }
        /// <summary>
        /// Codigo de respuesta
        /// </summary>
        [DataMember]
        public string Code { get; set; }
        /// <summary>
        /// Descripcion respuesta
        /// </summary>
        [DataMember]
        public string Message { get; set; }
    }
}
