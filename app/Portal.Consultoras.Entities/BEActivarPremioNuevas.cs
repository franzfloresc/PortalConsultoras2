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
            if (DataRecord.HasColumn(dr, "CodigoPrograma"))
                CodigoPrograma = Convert.ToString(dr["CodigoPrograma"]);

            if (DataRecord.HasColumn(dr, "AnoCampana"))
                AnioCampana = Convert.ToInt32(dr["AnoCampana"]);

            if (DataRecord.HasColumn(dr, "Nivel"))
                Nivel = Convert.ToString(dr["Nivel"]);

            if (DataRecord.HasColumn(dr, "ActiveTooltip"))
                ActiveTooltip = Convert.ToBoolean(dr["ActiveTooltip"]);

            if (DataRecord.HasColumn(dr, "ActiveTooltipMonto"))
                ActiveMontoTooltip = Convert.ToBoolean(dr["ActiveTooltipMonto"]);

            if (DataRecord.HasColumn(dr, "Active"))
                Active = Convert.ToBoolean(dr["Active"]);

            if (DataRecord.HasColumn(dr, "FechaCreate"))
                FechaCreate = Convert.ToDateTime(dr["FechaCreate"]);

        }
    }
}
