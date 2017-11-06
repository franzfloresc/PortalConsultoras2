﻿using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{

    [DataContract]
    public class BEConsultoraDigitales
    {
        [DataMember]
        public string IPUsuario { get; set; }
        [DataMember]
        public int CampaniaID { get; set; }
        [DataMember]
        public string CodigoConsultora { get; set; }

        public BEConsultoraDigitales(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "IPUsuario") && row["IPUsuario"] != DBNull.Value)
                IPUsuario = Convert.ToString(row["IPUsuario"]);
            if (DataRecord.HasColumn(row, "CampaniaID") && row["CampaniaID"] != DBNull.Value)
                CampaniaID = Convert.ToInt32(row["CampaniaID"]);
            if (DataRecord.HasColumn(row, "CodigoConsultora") && row["CodigoConsultora"] != DBNull.Value)
                CodigoConsultora = Convert.ToString(row["CodigoConsultora"]);

        }

    }
}
