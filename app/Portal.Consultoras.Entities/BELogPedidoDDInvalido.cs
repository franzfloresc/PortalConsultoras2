namespace Portal.Consultoras.Entities
{
    using Common;
    using System;
    using System.Data;
    using System.Runtime.Serialization;

    [DataContract]
    public class BELogPedidoDDInvalido
    {
        [DataMember]
        public int LogPedidoID { get; set; }
        [DataMember]
        public string CodigoConsultora { get; set; }
        [DataMember]
        public string CodigoUsuario { get; set; }
        [DataMember]
        public int CampaniaID { get; set; }
        [DataMember]
        public string NombreConsultora { get; set; }
        [DataMember]
        public DateTime FechaRegistro { get; set; }
        [DataMember]
        public DateTime FechaNotificacion { get; set; }
        [DataMember]
        public bool IndicadorNotificado { get; set; }

        public BELogPedidoDDInvalido()
        {
        }

        public BELogPedidoDDInvalido(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "LogPedidoID") && row["LogPedidoID"] != DBNull.Value)
                LogPedidoID = Convert.ToInt32(row["LogPedidoID"]);
            if (DataRecord.HasColumn(row, "CodigoConsultora") && row["CodigoConsultora"] != DBNull.Value)
                CodigoConsultora = Convert.ToString(row["CodigoConsultora"]);
            if (DataRecord.HasColumn(row, "CodigoUsuario") && row["CodigoUsuario"] != DBNull.Value)
                CodigoUsuario = Convert.ToString(row["CodigoUsuario"]);
            if (DataRecord.HasColumn(row, "CampaniaID") && row["CampaniaID"] != DBNull.Value)
                CampaniaID = Convert.ToInt32(row["CampaniaID"]);
            if (DataRecord.HasColumn(row, "NombreConsultora") && row["NombreConsultora"] != DBNull.Value)
                NombreConsultora = Convert.ToString(row["NombreConsultora"]);
            if (DataRecord.HasColumn(row, "FechaRegistro") && row["FechaRegistro"] != DBNull.Value)
                FechaRegistro = Convert.ToDateTime(row["FechaRegistro"]);
            if (DataRecord.HasColumn(row, "FechaNotificacion") && row["FechaNotificacion"] != DBNull.Value)
                FechaNotificacion = Convert.ToDateTime(row["FechaNotificacion"]);
            if (DataRecord.HasColumn(row, "IndicadorNotificado") && row["IndicadorNotificado"] != DBNull.Value)
                IndicadorNotificado = Convert.ToBoolean(row["IndicadorNotificado"]);
        }
    }
}
