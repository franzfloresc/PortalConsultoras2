using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

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
        public bool ActivePremioAuto { get; set; }
        [DataMember]
        public bool ActivePremioElectivo { get; set; }
        [DataMember]
        public bool ActiveMonto { get; set; }
        [DataMember]
        public bool ActiveTooltip { get; set; }
        [DataMember]
        public DateTime FechaCreate { get; set; }

        public BEActivarPremioNuevas()
        {
            CodigoPrograma = default(string);
            AnioCampana = default(int);
            Nivel = default(string);
            FechaCreate = default(DateTime);
        }

        public BEActivarPremioNuevas(IDataRecord row)
        {
            CodigoPrograma = row.ToString("CodigoPrograma");
            AnioCampana = row.ToInt32("AnoCampana");
            Nivel = row.ToString("Nivel");
            ActivePremioAuto = row.ToBoolean("Active");
            ActivePremioElectivo = row.ToBoolean("IND_CUPO_ELEC");
            ActiveTooltip = row.ToBoolean("ActiveTooltip");
            ActiveMonto = row.ToBoolean("ActiveTooltipMonto");
            FechaCreate = row.ToDateTime("FechaCreate");
        }
    }
}
