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
            if (DataRecord.HasColumn(row, "EstadoSimplificacionCUV"))
                EstadoSimplificacionCUV = DbConvert.ToBoolean(row["EstadoSimplificacionCUV"]);
            if (DataRecord.HasColumn(row, "EsquemaDAConsultora"))
                EsquemaDAConsultora = DbConvert.ToBoolean(row["EsquemaDAConsultora"]);
            if (DataRecord.HasColumn(row, "TipoProcesoCarga"))
                TipoProcesoCarga = DbConvert.ToBoolean(row["TipoProcesoCarga"]);
        }

    }
}
