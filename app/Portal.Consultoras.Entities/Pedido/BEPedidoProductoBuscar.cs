using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities.Pedido
{
    [DataContract]
    public class BEPedidoProductoBuscar
    {
        public BEPedidoProductoBuscar()
        {
            Usuario = new BEUsuario();
        }

        [DataMember]
        public int PaisID { get; set; }
        [DataMember]
        public string CodigoDescripcion { get; set; }
        [DataMember]
        public int Criterio { get; set; }
        [DataMember]
        public int RowCount { get; set; }
        [DataMember]
        public bool ValidarOpt { get; set; }

        [DataMember]
        public BEUsuario Usuario { get; set; }
    }
}
