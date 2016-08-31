using OpenSource.Library.DataAccess;
using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEConsultorasProgramaNuevas
    {
        [DataMember]
        public string Campania { get; set; }
        [DataMember]
        public string CodigoConsultora { get; set; }
        [DataMember]
        public string CodigoPrograma { get; set; }
        [DataMember]
        public string Participa { get; set; }
        [DataMember]
        public string Motivo { get; set; }
        [DataMember]
        public decimal MontoVentaExigido { get; set; }

        public BEConsultorasProgramaNuevas(IDataRecord datarec)
        {
            if (DataRecord.HasColumn(datarec, "Campania") && datarec["Campania"] != DBNull.Value)
                Campania = DbConvert.ToString(datarec["Campania"]);
            if (DataRecord.HasColumn(datarec, "CodigoConsultora") && datarec["CodigoConsultora"] != DBNull.Value)
                CodigoConsultora = DbConvert.ToString(datarec["CodigoConsultora"]);
            if (DataRecord.HasColumn(datarec, "CamCodigoProgramapaniaFin") && datarec["CodigoPrograma"] != DBNull.Value)
                CodigoPrograma = DbConvert.ToString(datarec["CodigoPrograma"]);
            if (DataRecord.HasColumn(datarec, "Participa") && datarec["Participa"] != DBNull.Value)
                Participa = DbConvert.ToString(datarec["Participa"]);
            if (DataRecord.HasColumn(datarec, "Motivo") && datarec["Motivo"] != DBNull.Value)
                Motivo = DbConvert.ToString(datarec["Motivo"]);
            if (DataRecord.HasColumn(datarec, "MontoVentaExigido") && datarec["MontoVentaExigido"] != DBNull.Value)
                MontoVentaExigido = DbConvert.ToDecimal(datarec["MontoVentaExigido"]);
        }
    }
}
