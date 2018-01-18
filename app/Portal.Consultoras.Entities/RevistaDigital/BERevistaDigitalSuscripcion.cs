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
        [DataMember]
        public int CampaniaEfectiva { get; set; }
        [DataMember]
        public string Origen { get; set; }

        public BERevistaDigitalSuscripcion() { }

        public BERevistaDigitalSuscripcion(IDataRecord row)
        {
            RevistaDigitalSuscripcionID = DataRecord.GetColumn<int>(row, "RevistaDigitalSuscripcionID");
            CampaniaID = DataRecord.GetColumn<int>(row, "CampaniaID");
            CampaniaEfectiva = DataRecord.GetColumn<int>(row, "CampaniaEfectiva");
            EstadoRegistro = DataRecord.GetColumn<int>(row, "EstadoRegistro");
            EstadoEnvio = DataRecord.GetColumn<int>(row, "EstadoEnvio");
            CodigoConsultora = DataRecord.GetColumn<string>(row, "CodigoConsultora");
            Origen = DataRecord.GetColumn<string>(row, "Origen");
            CodigoZona = DataRecord.GetColumn<string>(row, "CodigoZona");
            EMail = DataRecord.GetColumn<string>(row, "EMail");
            FechaSuscripcion = DataRecord.GetColumn<DateTime>(row, "FechaSuscripcion");
            FechaDesuscripcion = DataRecord.GetColumn<DateTime>(row, "FechaDesuscripcion");
        }
    }
}
