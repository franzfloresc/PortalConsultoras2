using Portal.Consultoras.Common;
using System.Collections.Generic;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEContenidoAppResumen
    {
        [DataMember]
        public int IdContenido { get; set; }

        [DataMember]
        public string Codigo { get; set; }

        [DataMember]
        public string UrlMiniatura { get; set; }

        [DataMember]
        public bool Estado { get; set; }

        [DataMember]
        public int CantidadContenido { get; set; }

        [DataMember]
        public int DesdeCampania { get; set; }

        [DataMember]
        public List<BEContenidoAppDeta> DetalleContenido { get; set; }

        public BEContenidoAppResumen() { }
        public BEContenidoAppResumen(IDataRecord row)
        {
            Codigo = row.ToString("Codigo");
            DesdeCampania = row.ToInt32("Codigo");
            Estado = row.ToBoolean("Est_Banner");
            UrlMiniatura = row.ToString("UrlMiniatura");
            DetalleContenido = new List<BEContenidoAppDeta>();
        }
    }
}