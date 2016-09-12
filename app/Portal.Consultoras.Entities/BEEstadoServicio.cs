using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;
using Portal.Consultoras.Common;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEEstadoServicio
    {
        [DataMember]
        public string AR { get; set; }
        [DataMember]
        public string BO { get; set; }
        [DataMember]
        public string CL { get; set; }
        [DataMember]
        public string CO { get; set; }
        [DataMember]
        public string CR { get; set; }
        [DataMember]
        public string EC { get; set; }
        [DataMember]
        public string SV { get; set; }
        [DataMember]
        public string GT { get; set; }
        [DataMember]
        public string MX { get; set; }
        [DataMember]
        public string PA { get; set; }
        [DataMember]
        public string PE { get; set; }
        [DataMember]
        public string PR { get; set; }
        [DataMember]
        public string DO { get; set; }
        [DataMember]
        public string VE { get; set; }
        [DataMember]
        public string CampaniaInicialId { get; set; }
        [DataMember]
        public string CampaniaFinalId { get; set; }
        [DataMember]
        public int ServicioId { get; set; }
        
        public BEEstadoServicio()
        {
        }

        public BEEstadoServicio(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "AR") && row["AR"] != DBNull.Value)
                AR = Convert.ToString(row["AR"]);
            if (DataRecord.HasColumn(row, "BO") && row["BO"] != DBNull.Value)
                BO = Convert.ToString(row["BO"]);
            if (DataRecord.HasColumn(row, "CL") && row["CL"] != DBNull.Value)
                CL = Convert.ToString(row["CL"]);
            if (DataRecord.HasColumn(row, "CO") && row["CO"] != DBNull.Value)
                CO = Convert.ToString(row["CO"]);
            if (DataRecord.HasColumn(row, "CR") && row["CR"] != DBNull.Value)
                CR = Convert.ToString(row["CR"]);
            if (DataRecord.HasColumn(row, "EC") && row["EC"] != DBNull.Value)
                EC = Convert.ToString(row["EC"]);
            if (DataRecord.HasColumn(row, "SV") && row["SV"] != DBNull.Value)
                SV = Convert.ToString(row["SV"]);
            if (DataRecord.HasColumn(row, "GT") && row["GT"] != DBNull.Value)
                GT = Convert.ToString(row["GT"]);
            if (DataRecord.HasColumn(row, "MX") && row["MX"] != DBNull.Value)
                MX = Convert.ToString(row["MX"]);
            if (DataRecord.HasColumn(row, "PA") && row["PA"] != DBNull.Value)
                PA = Convert.ToString(row["PA"]);
            if (DataRecord.HasColumn(row, "PE") && row["PE"] != DBNull.Value)
                PE = Convert.ToString(row["PE"]);
            if (DataRecord.HasColumn(row, "PR") && row["PR"] != DBNull.Value)
                PR = Convert.ToString(row["PR"]);
            if (DataRecord.HasColumn(row, "DO") && row["DO"] != DBNull.Value)
                DO = Convert.ToString(row["DO"]);
            if (DataRecord.HasColumn(row, "VE") && row["VE"] != DBNull.Value)
                VE = Convert.ToString(row["VE"]);
        }
    }
}
