using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEPayPalConfiguracion
    {
        [DataMember]
        public int paisID { get; set; }
        [DataMember]
        public string chrCodigoParametro { get; set; }
        [DataMember]
        public string chrDescripcion { get; set; }
        [DataMember]
        public string chrValor { get; set; }


        [DataMember]
        public string chrCodigoConsultora { get; set; }
        [DataMember]
        public string vchNombreCompleto { get; set; }
        [DataMember]
        public DateTime datSYSFechaCreacion { get; set; }
        [DataMember]
        public decimal mnyMontoAbono { get; set; }
        [DataMember]
        public string chrRETCodigoAutorizacionBancaria { get; set; }
        [DataMember]
        public string chrRETCodigoTransaccion { get; set; }
        [DataMember]
        public string chrUltimosNumeroTarjeta { get; set; }
        [DataMember]
        public string chrSYSUsuarioCreacion { get; set; }
        [DataMember]
        public string chrRETResultado { get; set; }


        public BEPayPalConfiguracion(IDataRecord row)
        {
            chrCodigoParametro  = row.ToString("chrCodigoParametro");
            chrDescripcion  = row.ToString("chrDescripcion");
            chrValor  = row.ToString("chrValor");
        }

        public BEPayPalConfiguracion(IDataRecord row, int Tipo)
        {
            chrCodigoConsultora  = row.ToString("chrCodigoConsultora");
            vchNombreCompleto  = row.ToString("vchNombreCompleto");
            datSYSFechaCreacion  = row.ToDateTime("datSYSFechaCreacion");
            mnyMontoAbono  = row.ToDecimal("mnyMontoAbono");
            chrRETCodigoTransaccion  = row.ToString("chrRETCodigoTransaccion");
            chrRETCodigoAutorizacionBancaria  = row.ToString("chrRETCodigoAutorizacionBancaria");
            chrUltimosNumeroTarjeta  = row.ToString("chrUltimosNumeroTarjeta");
            chrSYSUsuarioCreacion  = row.ToString("chrSYSUsuarioCreacion");
            chrRETResultado  = row.ToString("chrRETResultado");
        }
    }
}
