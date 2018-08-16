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
        [DataMember]
        public string CuvObs { get; set; }
        [DataMember]
        public int SetID { get; set; }
        [DataMember]
        public int PedidoDetalleID { get; set; }

        public BEPedidoObservacion() { }
        public BEPedidoObservacion(int tipo, int caso, string cuv, string descripcion, string cuvObs) {
            Tipo = tipo;
            Caso = caso;
            CUV = cuv;
            Descripcion = descripcion;
            CuvObs = cuvObs;
        }        
        public BEPedidoObservacion(BEPedidoObservacion pedidoObs)
        {
            Tipo = pedidoObs.Tipo;
            Caso = pedidoObs.Caso;
            CUV = pedidoObs.CUV;
            Descripcion = pedidoObs.Descripcion;
            CuvObs = pedidoObs.CuvObs;
        }
    }
}
