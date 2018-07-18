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
            AR = row.ToString("AR");
            BO = row.ToString("BO");
            CL = row.ToString("CL");
            CO = row.ToString("CO");
            CR = row.ToString("CR");
            EC = row.ToString("EC");
            SV = row.ToString("SV");
            GT = row.ToString("GT");
            MX = row.ToString("MX");
            PA = row.ToString("PA");
            PE = row.ToString("PE");
            PR = row.ToString("PR");
            DO = row.ToString("DO");
            VE = row.ToString("VE");
        }
    }
}
