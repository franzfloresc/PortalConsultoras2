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
            if (DataRecord.HasColumn(row, "LogPedidoID"))
                LogPedidoID = Convert.ToInt32(row["LogPedidoID"]);
            if (DataRecord.HasColumn(row, "CodigoConsultora"))
                CodigoConsultora = Convert.ToString(row["CodigoConsultora"]);
            if (DataRecord.HasColumn(row, "CodigoUsuario"))
                CodigoUsuario = Convert.ToString(row["CodigoUsuario"]);
            if (DataRecord.HasColumn(row, "CampaniaID"))
                CampaniaID = Convert.ToInt32(row["CampaniaID"]);
            if (DataRecord.HasColumn(row, "NombreConsultora"))
                NombreConsultora = Convert.ToString(row["NombreConsultora"]);
            if (DataRecord.HasColumn(row, "FechaRegistro"))
                FechaRegistro = Convert.ToDateTime(row["FechaRegistro"]);
            if (DataRecord.HasColumn(row, "FechaNotificacion"))
                FechaNotificacion = Convert.ToDateTime(row["FechaNotificacion"]);
            if (DataRecord.HasColumn(row, "IndicadorNotificado"))
                IndicadorNotificado = Convert.ToBoolean(row["IndicadorNotificado"]);
        }
    }
}
