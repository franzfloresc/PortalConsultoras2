﻿using Portal.Consultoras.Common;
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
        public bool ActiveTooltip { get; set; }
        [DataMember]
        public DateTime FechaCreate { get; set; }
        [DataMember]
        public bool ActiveMontoTooltip { get; set; }
        [DataMember]
        public bool ActiveCuponElectivo { get; set; }
        [DataMember]
        public bool Active { get; set; }

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
            ActiveTooltip = row.ToBoolean("ActiveTooltip");
            ActiveMontoTooltip = row.ToBoolean("ActiveTooltipMonto");
            Active = row.ToBoolean("Active");
            FechaCreate = row.ToDateTime("FechaCreate");
            ActiveCuponElectivo = row.ToBoolean("IND_CUPO_ELEC");
        }
    }
}
