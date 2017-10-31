using OpenSource.Library.DataAccess;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities.ShowRoom
{
    [DataContract]
    public class BEShowRoomOferta2
    {
        [DataMember]
        public int TipoOfertaSisID { get; set; }

        [DataMember]
        public int CampaniaID { get; set; }

        [DataMember]
        public string CUV { get; set; }

        [DataMember]
        public int Stock { get; set; }

        [DataMember]
        public decimal PrecioOferta { get; set; }

        [DataMember]
        public int UnidadesPermitidas { get; set; }

        [DataMember]
        public string Descripcion { get; set; }

        [DataMember]
        public string CodigoCategoria { get; set; }

        [DataMember]
        public string TipNegocio { get; set; }

        [DataMember]
        public decimal PrecioOferta2 { get; set; }

        [DataMember]
        [ViewProperty]
        public string ISOPais { get; set; }

        public BEShowRoomOferta2()
        {

        }
    }
}
