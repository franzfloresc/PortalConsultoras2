using System;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities.Pedido.App
{
    [DataContract]
    public class BEPedidoAppInsertar
    {
        [DataMember]
        public int PaisID { get; set; }
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
        public decimal PrecioUnidad { get; set; }
        [DataMember]
        public double ZonaHoraria { get; set; }
        [DataMember]
        public DateTime FechaInicioFacturacion { get; set; }
        [DataMember]
        public DateTime FechaFinFacturacion { get; set; }
        [DataMember]
        public string Simbolo { get; set; }

        //[DataMember]
        //public string CUV { get; set; }
        //[DataMember]
        //public int TipoOferta { get; set; }
        //[DataMember]
        //public string MarcaID { get; set; }
        //[DataMember]
        //public string Descripcion { get; set; }
        //[DataMember]
        //public string IndicadorMontoMinimo { get; set; }
        //[DataMember]
        //public BEUsuario Usuario { get; set; }
        //[DataMember]
        //public string NombreConsultora { get; set; }
        //[DataMember]
        //public string CodigoPrograma { get; set; }
        //[DataMember]
        //public int ConsecutivoNueva { get; set; }
        //[DataMember]
        //public BERevistaDigital RevistaDigital { get; set; }
    }
}
