using Portal.Consultoras.Common;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEContenidoAppDeta
    {
        [DataMember]
        public int IdContenidoDeta { get; set; }

        [DataMember]
        public string CodigoDetalle { get; set; }

        [DataMember]
        public string RutaContenido { get; set; }

        [DataMember]
        public string Accion { get; set; }

        [DataMember]
        public int Orden { get; set; }

        [DataMember]
        public string Tipo { get; set; }

        [DataMember]
        public bool Estado { get; set; }

        [DataMember]
        public bool ContenidoVisto { get; set; }

        public BEContenidoAppDeta() { }

        public BEContenidoAppDeta(IDataRecord row)
        {
            IdContenidoDeta = row.ToInt32("IdContenidoDeta");
            CodigoDetalle = row.ToString("CodigoDetalle");
            RutaContenido = row.ToString("RutaContenido");
            Accion = row.ToString("Accion");
            Orden = row.ToInt32("Orden");
            Tipo = row.ToString("Tipo");
            Estado = row.ToBoolean("Est_Cont");
            ContenidoVisto = row.ToBoolean("ContenidoVisto");
        }
    }
}