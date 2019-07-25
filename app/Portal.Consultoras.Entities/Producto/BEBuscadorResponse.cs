using System.Runtime.Serialization;
using System.Collections.Generic;

namespace Portal.Consultoras.Entities.Producto
{
    [DataContract]
    public class BEBuscadorResponse
    {
        public BEBuscadorResponse()
        {
            OrigenesPedidoWeb = new List<BEBuscadorResponseOrigen>();
        }
        [DataMember]
        public string CUV { get; set; }
        [DataMember]
        public string SAP { get; set; }
        [DataMember]
        public string FotoProductoSmall { get; set; }
        [DataMember]
        public string Descripcion { get; set; }
        [DataMember]
        public double PrecioValorizado { get; set; }
        [DataMember]
        public double PrecioCatalogo { get; set; }
        [DataMember]
        public int MarcaID { get; set; }
        [DataMember]
        public string TipoPersonalizacion { get; set; }
        [DataMember]
        public int CodigoEstrategia { get; set; }
        [DataMember]
        public string CodigoTipoEstrategia { get; set; }
        [DataMember]
        public int TipoEstrategiaID { get; set; }
        [DataMember]
        public int LimiteVenta { get; set; }
        [DataMember]
        public bool Stock { get; set; }
        [DataMember]
        public string DescripcionEstrategia { get; set; }
        [DataMember]
        public string OrigenPedidoWeb { get; set; }
        [DataMember]
        public int EstrategiaID { get; set; }
        [DataMember]
        public string OrigenPedidoWebFicha { get; set; }
        [DataMember]
        public bool MaterialGanancia { get; set; }
        [DataMember]
        public string CodigoTipoOferta { get; set; }
        [DataMember]
        public List<BEBuscadorResponseOrigen> OrigenesPedidoWeb { get; set; }
    }

    [DataContract]
    public class BEBuscadorResponseOrigen
    {
        [DataMember]
        public string Codigo { get; set; }
        [DataMember]
        public int Valor { get; set; }
    }
}
