﻿using Portal.Consultoras.Common;
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
            if (DataRecord.HasColumn(row, "PedidoID"))
                PedidoID = Convert.ToInt32(row["PedidoID"]);
            if (DataRecord.HasColumn(row, "EstadoPedido"))
                EstadoPedido = Convert.ToByte(row["EstadoPedido"]);
            if (DataRecord.HasColumn(row, "ModificaPedidoReservado"))
                ModificaPedidoReservado = Convert.ToBoolean(row["ModificaPedidoReservado"]);
        }
    }
}
