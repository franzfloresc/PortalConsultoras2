using Portal.Consultoras.Common;
using System;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data;
using System.Runtime.Serialization;

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
        public BEConsultorasProgramaNuevas(IDataRecord row)
        {
            Campania = row.ToString("Campania");
            CodigoConsultora = row.ToString("CodigoConsultora");
            CodigoPrograma = row.ToString("CodigoPrograma");
            Participa = row.ToString("Participa");
            Motivo = row.ToString("Motivo");
            MontoVentaExigido = row.ToDecimal("MontoVentaExigido");
            ConsecutivoNueva = row.ToInt32("ConsecutivoNueva");
        }

        public BEConsultorasProgramaNuevas()
        {

        }
    }
}
