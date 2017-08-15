using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities.RevistaDigital
{
    [DataContract]
    public class BERevistaDigitalSuscripcion : BaseEntidad
    {
        [DataMember]
        public int RevistaDigitalSuscripcionID { get; set; }
        [DataMember]
        public string CodigoConsultora { get; set; }
        [DataMember]
        public int CampaniaID { get; set; }
        [DataMember]
        public DateTime FechaSuscripcion { get; set; }
        [DataMember]
        public DateTime FechaDesuscripcion { get; set; }
        [DataMember]
        public int EstadoRegistro { get; set; }
        [DataMember]
        public int EstadoEnvio { get; set; }
        [DataMember]
        public string IsoPais { get; set; }
        [DataMember]
        public string CodigoZona { get; set; }
        [DataMember]
        public string EMail { get; set; }

        public BERevistaDigitalSuscripcion() { }

        public BERevistaDigitalSuscripcion(IDataRecord row)
        {
            if (row.HasColumn("RevistaDigitalSuscripcionID")) RevistaDigitalSuscripcionID = Convert.ToInt32(row["RevistaDigitalSuscripcionID"]);
            if (row.HasColumn("CodigoConsultora")) CodigoConsultora = Convert.ToString(row["CodigoConsultora"]);
            if (row.HasColumn("FechaSuscripcion")) FechaSuscripcion = Convert.ToDateTime(row["FechaSuscripcion"]);
            if (row.HasColumn("FechaDesuscripcion")) FechaDesuscripcion = Convert.ToDateTime(row["FechaDesuscripcion"]);
            if (row.HasColumn("EstadoRegistro")) EstadoRegistro = Convert.ToInt32(row["EstadoRegistro"]);
            if (row.HasColumn("EstadoEnvio")) EstadoEnvio = Convert.ToInt32(row["EstadoEnvio"]);
            if (row.HasColumn("IsoPais")) IsoPais = Convert.ToString(row["IsoPais"]);
            if (row.HasColumn("CampaniaID")) CampaniaID = Convert.ToInt32(row["CampaniaID"]);
            if (row.HasColumn("CodigoZona")) CodigoZona = Convert.ToString(row["CodigoZona"]);
            if (row.HasColumn("EMail")) EMail = Convert.ToString(row["EMail"]);
        }
    }
}
