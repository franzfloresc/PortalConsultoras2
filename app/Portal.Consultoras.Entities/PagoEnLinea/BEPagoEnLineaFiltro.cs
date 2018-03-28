using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.Entities.PagoEnLinea
{
    [DataContract]
    public class BEPagoEnLineaFiltro
    {
        [DataMember]
        public int CampaniaId { get; set; }
        [DataMember]
        public int RegionId { get; set; }
        [DataMember]
        public int ZonaId { get; set; }
        [DataMember]
        public string CodigoConsultora { get; set; }
        [DataMember]
        public string Estado { get; set; }
        [DataMember]
        public DateTime FechaPagoDesde { get; set; }
        [DataMember]
        public DateTime FechaPagoHasta { get; set; }
        [DataMember]
        public DateTime FechaProcesoDesde { get; set; }
        [DataMember]
        public DateTime FechaProcesoHasta { get; set; }
    }
}
