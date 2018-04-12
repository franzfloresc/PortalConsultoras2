using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities.ReservaProl
{
    [DataContract]
    public class BEPedidoObservacion
    {
        [DataMember]
        public string CUV { get; set; }
        [DataMember]
        public int Tipo { get; set; }
        [DataMember]
        public string Descripcion { get; set; }
        [DataMember]
        public int Caso { get; set; }

        public BEPedidoObservacion() { }
        public BEPedidoObservacion(int caso, string descripcion)
        {
            Caso = caso;
            Descripcion = descripcion;
        }
        public BEPedidoObservacion(int caso, string cuv, string descripcion) {
            Caso = caso;
            CUV = cuv;
            Descripcion = descripcion;
        }
    }
}
