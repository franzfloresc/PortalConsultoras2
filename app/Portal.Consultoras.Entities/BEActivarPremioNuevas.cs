using Portal.Consultoras.Common;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEActivarPremioNuevas
    {
        [DataMember]
        public string CodigoPrograma { get; set; }
        [DataMember]
        public int AnioCampana { get; set; }
        [DataMember]
        public string Nivel { get; set; }
        [DataMember]
        public bool ActiveTooltip { get; set; }
        [DataMember]
        public DateTime FechaCreate { get; set; }
        [DataMember]
        public bool ActiveMontoTooltip { get; set; }
        [DataMember]
        public bool Active { get; set; }

        public BEActivarPremioNuevas()
        {
            this.CodigoPrograma = default(string);
            this.AnioCampana = default(int);
            this.Nivel = default(string);
            this.FechaCreate = default(DateTime);
        }

        public BEActivarPremioNuevas(IDataRecord dr)
        {
            if (DataRecord.HasColumn(dr, "CodigoPrograma") && dr["CodigoPrograma"] != DBNull.Value)
                CodigoPrograma = Convert.ToString(dr["CodigoPrograma"]);

            if (DataRecord.HasColumn(dr, "AnoCampana") && dr["AnoCampana"] != DBNull.Value)
                AnioCampana = Convert.ToInt32(dr["AnoCampana"]);

            if (DataRecord.HasColumn(dr, "Nivel") && dr["Nivel"] != DBNull.Value)
                Nivel = Convert.ToString(dr["Nivel"]);

            if (DataRecord.HasColumn(dr, "ActiveTooltip") && dr["ActiveTooltip"] != DBNull.Value)
                ActiveTooltip = Convert.ToBoolean(dr["ActiveTooltip"]);

            if (DataRecord.HasColumn(dr, "ActiveTooltipMonto") && dr["ActiveTooltipMonto"] != DBNull.Value)
                ActiveMontoTooltip = Convert.ToBoolean(dr["ActiveTooltipMonto"]);

            if (DataRecord.HasColumn(dr, "Active") && dr["Active"] != DBNull.Value)
                Active = Convert.ToBoolean(dr["Active"]);

            if (DataRecord.HasColumn(dr, "FechaCreate") && dr["FechaCreate"] != DBNull.Value)
                FechaCreate = Convert.ToDateTime(dr["FechaCreate"]);

        }
    }
}
