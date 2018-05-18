using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

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
            if (DataRecord.HasColumn(row, "AR"))
                AR = Convert.ToString(row["AR"]);
            if (DataRecord.HasColumn(row, "BO"))
                BO = Convert.ToString(row["BO"]);
            if (DataRecord.HasColumn(row, "CL"))
                CL = Convert.ToString(row["CL"]);
            if (DataRecord.HasColumn(row, "CO"))
                CO = Convert.ToString(row["CO"]);
            if (DataRecord.HasColumn(row, "CR"))
                CR = Convert.ToString(row["CR"]);
            if (DataRecord.HasColumn(row, "EC"))
                EC = Convert.ToString(row["EC"]);
            if (DataRecord.HasColumn(row, "SV"))
                SV = Convert.ToString(row["SV"]);
            if (DataRecord.HasColumn(row, "GT"))
                GT = Convert.ToString(row["GT"]);
            if (DataRecord.HasColumn(row, "MX"))
                MX = Convert.ToString(row["MX"]);
            if (DataRecord.HasColumn(row, "PA"))
                PA = Convert.ToString(row["PA"]);
            if (DataRecord.HasColumn(row, "PE"))
                PE = Convert.ToString(row["PE"]);
            if (DataRecord.HasColumn(row, "PR"))
                PR = Convert.ToString(row["PR"]);
            if (DataRecord.HasColumn(row, "DO"))
                DO = Convert.ToString(row["DO"]);
            if (DataRecord.HasColumn(row, "VE"))
                VE = Convert.ToString(row["VE"]);
        }
    }
}
