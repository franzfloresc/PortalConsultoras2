using Portal.Consultoras.Common;
using System;
using System.Collections.Generic;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEProcesoPedidoRechazado
    {
        [DataMember]
        public int IdProcesoPedidoRechazado { get; set; }
        [DataMember]
        public DateTime Fecha { get; set; }
        [DataMember]
        public string Estado { get; set; }
        [DataMember]
        public string Mensaje { get; set; }

        [DataMember]
        public List<BEPedidoRechazado> olstBEPedidoRechazado { get; set; }

        public BEProcesoPedidoRechazado()
        { }

        public BEProcesoPedidoRechazado(IDataRecord row)
        {
            IdProcesoPedidoRechazado = row.ToInt32("IdProcesoPedidoRechazado");
            Fecha = row.ToDateTime("Fecha");
            Estado = row.ToString("Estado");
            Mensaje = row.ToString("Mensaje");
            olstBEPedidoRechazado = new List<BEPedidoRechazado>();
        }
    }
}
