using Portal.Consultoras.Entities.ReservaProl;
using System.Collections.Generic;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities.Pedido
{
    [DataContract]
    public class BEPedidoDetalleResult
    {
        [DataMember]
        public string CodigoRespuesta { get; set; }
        [DataMember]
        public string MensajeRespuesta { get; set; }
        [DataMember]
        public string MensajeAviso { get; set; }
        [DataMember]
        public string CUV { get; set; }
        [DataMember]
        public int ClienteID { get; set; }
        [DataMember]
        public string TituloMensaje { get; set; }
        [DataMember]
        public List<string> ListCuvEliminar { get; set; }
        [DataMember]
        public BEPedidoWebDetalle PedidoWebDetalle { get; set; }
        [DataMember]
        public bool ModificoBackOrder { get; set; }
        [DataMember]
        public List<BEMensajeProl> ListaMensajeCondicional { get; set; }
        [DataMember]
        public List<BEPedidoObservacion> ListPedidoObservacion { get; set; }
        [DataMember]
        public string MontoAhorroCatalogo { get; set; }
        [DataMember]
        public string MontoAhorroRevista { get; set; }
        [DataMember]
        public string DescuentoProl { get; set; }
        [DataMember]
        public string MontoEscala { get; set; }
        [DataMember]
        public decimal? GananciaRevista { get; set; }

        [DataMember]
        public decimal? GananciaWeb { get; set; }

        [DataMember]
        public decimal? GananciaOtros { get; set; }

        [DataMember]
        public int flagCantidadMayor { get; set; }

        [DataMember]
        public string  mensajeCantidadMayor { get; set; }

        [DataMember]
        public BEPedidoWeb PedidoWeb { get; set; }

        public BEPedidoDetalleResult()
        {
            ListaMensajeCondicional = new List<BEMensajeProl>();
        }
    }
}
