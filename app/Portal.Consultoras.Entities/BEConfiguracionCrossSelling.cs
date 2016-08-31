using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;
using OpenSource.Library.DataAccess;
using Portal.Consultoras.Common;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEConfiguracionCrossSelling
    {
        [DataMember]
        public int PaisID { get; set; }
        [DataMember]
        public string Pais { get; set; }
        [DataMember]
        public int CampaniaID { get; set; }
        [DataMember]
        public int HabilitarDiasValidacion { get; set; }


        public BEConfiguracionCrossSelling(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "CampaniaID") && row["CampaniaID"] != DBNull.Value)
                CampaniaID = Convert.ToInt32(row["CampaniaID"]);
            if (DataRecord.HasColumn(row, "HabilitarDiasValidacion") && row["HabilitarDiasValidacion"] != DBNull.Value)
                HabilitarDiasValidacion = Convert.ToInt32(row["HabilitarDiasValidacion"]);
        }
    }
}
