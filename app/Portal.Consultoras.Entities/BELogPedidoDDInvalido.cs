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
            LogPedidoID = row.ToInt32("LogPedidoID");
            CodigoConsultora = row.ToString("CodigoConsultora");
            CodigoUsuario = row.ToString("CodigoUsuario");
            CampaniaID = row.ToInt32("CampaniaID");
            NombreConsultora = row.ToString("NombreConsultora");
            FechaRegistro = row.ToDateTime("FechaRegistro");
            FechaNotificacion = row.ToDateTime("FechaNotificacion");
            IndicadorNotificado = row.ToBoolean("IndicadorNotificado");
        }
    }
}
