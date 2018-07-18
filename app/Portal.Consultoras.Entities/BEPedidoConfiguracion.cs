using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEPedidoConfiguracion
    {
        [DataMember]
        public int PedidoID { get; set; }
        [DataMember]
        public byte EstadoPedido { get; set; }
        [DataMember]
        public bool ModificaPedidoReservado { get; set; }

        public BEPedidoConfiguracion()
        { }

        public BEPedidoConfiguracion(IDataRecord row)
        {
            PedidoID = row.ToInt32("PedidoID");
            EstadoPedido = row.ToByte("EstadoPedido");
            ModificaPedidoReservado = row.ToBoolean("ModificaPedidoReservado");
        }
    }
}
