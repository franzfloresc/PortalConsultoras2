using OpenSource.Library.DataAccess;
using Portal.Consultoras.Common;

using System;
using System.Data;
using System.Runtime.Serialization;
using System.ComponentModel.DataAnnotations.Schema;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEConsultorasProgramaNuevas
    {
        [DataMember]
        [Column("Campania")]
        public string Campania { get; set; }
        [DataMember]
        [Column("CodigoConsultora")]
        public string CodigoConsultora { get; set; }
        [DataMember]
        [Column("CodigoPrograma")]
        public string CodigoPrograma { get; set; }
        [DataMember]
        [Column("Participa")]
        public string Participa { get; set; }
        [DataMember]
        [Column("Motivo")]
        public string Motivo { get; set; }
        [DataMember]
        [Column("MontoVentaExigido")]
        public decimal MontoVentaExigido { get; set; }

        [DataMember]
        [Column("ConsecutivoNueva")]
        public int ConsecutivoNueva { get; set; }

        [Obsolete("Use MapUtil.MapToCollection")]
        public BEConsultorasProgramaNuevas(IDataRecord datarec)
        {
            if (DataRecord.HasColumn(datarec, "Campania"))
                Campania = Convert.ToString(datarec["Campania"]);
            if (DataRecord.HasColumn(datarec, "CodigoConsultora"))
                CodigoConsultora = Convert.ToString(datarec["CodigoConsultora"]);
            if (DataRecord.HasColumn(datarec, "CodigoPrograma"))
                CodigoPrograma = Convert.ToString(datarec["CodigoPrograma"]);
            if (DataRecord.HasColumn(datarec, "Participa"))
                Participa = Convert.ToString(datarec["Participa"]);
            if (DataRecord.HasColumn(datarec, "Motivo"))
                Motivo = Convert.ToString(datarec["Motivo"]);
            if (DataRecord.HasColumn(datarec, "MontoVentaExigido"))
                MontoVentaExigido = Convert.ToDecimal(datarec["MontoVentaExigido"]);
            if (DataRecord.HasColumn(datarec, "ConsecutivoNueva"))
                ConsecutivoNueva = Convert.ToInt32(datarec["ConsecutivoNueva"]);
        }

        public BEConsultorasProgramaNuevas()
        {

        }
    }
}
