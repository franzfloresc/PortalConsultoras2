using OpenSource.Library.DataAccess;
using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEConfiguracionPortal
    {
        [DataMember]
        public int PaisID { get; set; }
        [DataMember]
        public bool EstadoSimplificacionCUV { get; set; }
        [DataMember]
        public bool EsquemaDAConsultora { get; set; }
        [DataMember]
        public bool? TipoProcesoCarga { get; set; }

        public BEConfiguracionPortal(IDataRecord row)
        {
            EstadoSimplificacionCUV = row.ToBoolean("EstadoSimplificacionCUV");
            EsquemaDAConsultora = row.ToBoolean("EsquemaDAConsultora");
            TipoProcesoCarga = row.ToBoolean("TipoProcesoCarga");
        }

    }
}
