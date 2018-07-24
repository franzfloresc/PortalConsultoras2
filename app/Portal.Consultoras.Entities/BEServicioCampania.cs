using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEServicioCampania
    {
        [DataMember]
        public int ServicioId { get; set; }
        [DataMember]
        public string Descripcion { get; set; }
        [DataMember]
        public string Url { get; set; }

        [DataMember]
        public string Segmento { get; set; }

        [DataMember]
        public string ConfiguracionZona { get; set; }

        public BEServicioCampania() { }
        public BEServicioCampania(IDataRecord row)
        {
            ServicioId = row.ToInt32("ServicioId");
            Descripcion = row.ToString("Descripcion");
            Url = row.ToString("Url");
            Segmento = row.ToString("Segmento");
            ConfiguracionZona = row.ToString("ConfiguracionZona");
        }
    }
}
