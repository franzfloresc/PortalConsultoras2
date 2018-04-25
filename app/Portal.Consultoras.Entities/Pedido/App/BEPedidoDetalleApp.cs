using System;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities.Pedido.App
{
    [DataContract]
    public class BEPedidoDetalleApp
    {
        public BEPedidoDetalleApp()
        {
            RevistaDigital = new BERevistaDigital();
            Producto = new BEProducto();
        }

        [DataMember]
        public int PaisID { get; set; }
        [DataMember]
        public string CodigoISO { get; set; }
        [DataMember]
        public long ConsultoraID { get; set; }
        [DataMember]
        public int CampaniaID { get; set; }
        [DataMember]
        public bool UsuarioPrueba { get; set; }
        [DataMember]
        public int AceptacionConsultoraDA { get; set; }
        [DataMember]
        public bool TieneValidacionMontoMaximo { get; set; }
        [DataMember]
        public decimal MontoMaximoPedido { get; set; }
        [DataMember]
        public int Cantidad { get; set; }
        [DataMember]
        public double ZonaHoraria { get; set; }
        [DataMember]
        public DateTime FechaInicioFacturacion { get; set; }
        [DataMember]
        public DateTime FechaFinFacturacion { get; set; }
        [DataMember]
        public string Simbolo { get; set; }
        [DataMember]
        public string NombreConsultora { get; set; }
        [DataMember]
        public BERevistaDigital RevistaDigital { get; set; }
        [DataMember]
        public string CodigoPrograma { get; set; }
        [DataMember]
        public int ConsecutivoNueva { get; set; }
        [DataMember]
        public BEProducto Producto { get; set; }
        [DataMember]
        public bool EsConsultoraNueva { get; set; }
        [DataMember]
        public string CodigoRegion { get; set; }
        [DataMember]
        public string CodigoZona { get; set; }
        [DataMember]
        public int ConsultoraNueva { get; set; }
        [DataMember]
        public string IPUsuario { get; set; }
        [DataMember]
        public int PedidoID { get; set; }
        [DataMember]
        public int OrigenPedidoWeb { get; set; }
        [DataMember]
        public short ClienteID { get; set; }
        [DataMember]
        public string ClienteDescripcion { get; set; }
        [DataMember]
        public string CodigoUsuario { get; set; }
        [DataMember]
        public string Identifier { get; set; }
        [DataMember]
        public string CodigoConsultora { get; set; }
        [DataMember]
        public string CodigosConcursos { get; set; }
    }
}
