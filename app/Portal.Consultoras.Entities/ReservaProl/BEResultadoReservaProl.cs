using System.Collections.Generic;
using System.Runtime.Serialization;
using static Portal.Consultoras.Common.Enumeradores;

namespace Portal.Consultoras.Entities.ReservaProl
{
    [DataContract]
    public class BEResultadoReservaProl
    {
        [DataMember]
        public bool Restrictivas { get; set; }
        [DataMember]
        public bool Informativas { get; set; }
        [DataMember]
        public bool Error { get; set; }
        [DataMember]
        public bool Reserva { get; set; }
        [DataMember]
        public bool RefreshPedido { get; set; }
        [DataMember]
        public bool RefreshMontosProl { get; set; }
        [DataMember]
        public decimal MontoAhorroCatalogo { get; set; }
        [DataMember]
        public decimal MontoAhorroRevista { get; set; }
        [DataMember]
        public decimal MontoGanancia { get; set; }
        [DataMember]
        public decimal MontoDescuento { get; set; }
        [DataMember]
        public decimal MontoEscala { get; set; }
        [DataMember]
        public decimal MontoTotal { get; set; }
        [DataMember]
        public int UnidadesAgregadas { get; set; }
        [DataMember]
        public bool EnviarCorreo { get; set; }
        [DataMember]
        public string CodigoMensaje { get; set; }
        [DataMember]
        public int PedidoID { get; set; }
        [DataMember]
        public ResultadoReserva ResultadoReservaEnum { get; set; }
        [DataMember]
        public List<BEPedidoObservacion> ListPedidoObservacion { get; set; }

        public BEResultadoReservaProl()
        {
            CodigoMensaje = "";
            ListPedidoObservacion = new List<BEPedidoObservacion>();
        }
    }
}
