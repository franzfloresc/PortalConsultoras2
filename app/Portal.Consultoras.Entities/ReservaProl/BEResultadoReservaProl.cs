using Portal.Consultoras.Common;
using System;
using System.Collections.Generic;
using System.Runtime.Serialization;

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
        public Enumeradores.ResultadoReserva ResultadoReservaEnum { get; set; }
        [DataMember]
        public List<BEPedidoObservacion> ListPedidoObservacion { get; set; }
        [DataMember]
        public string ListaConcursosCodigos { get; set; }
        [DataMember]
        public string ListaConcursosPuntaje { get; set; }
        [DataMember]
        public string ListaConcursosPuntajeExigido { get; set; }

        public decimal MontoTotalProl { get; set; }
        public long PedidoSapId { get; set; }
        public List<BEPedidoWebDetalle> ListDetalleBackOrder { get; set; }

        #region Atributos Cargar Session
        [DataMember]
        public string Simbolo { get; set; }
        [DataMember]
        public decimal MontoMinimo { get; set; }
        [DataMember]
        public decimal MontoMaximo { get; set; }
        [DataMember]
        public DateTime FechaFacturacion { get; set; }
        [DataMember]
        public bool FacturaHoy { get; set; }
        #endregion

        public BEResultadoReservaProl()
        {
            CodigoMensaje = string.Empty;
            ListPedidoObservacion = new List<BEPedidoObservacion>();
            ListDetalleBackOrder = new List<BEPedidoWebDetalle>();
        }

        public BEResultadoReservaProl(string mensajeError)
        {
            Error = true;
            ListPedidoObservacion = new List<BEPedidoObservacion> { new BEPedidoObservacion { Descripcion = mensajeError } };
        }
    }
}
