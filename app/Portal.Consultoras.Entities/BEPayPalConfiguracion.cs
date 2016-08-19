using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;
using Portal.Consultoras.Common;

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
            if (DataRecord.HasColumn(row, "chrCodigoParametro"))
                chrCodigoParametro = Convert.ToString(row["chrCodigoParametro"]);
            if (DataRecord.HasColumn(row, "chrDescripcion"))
                chrDescripcion = Convert.ToString(row["chrDescripcion"]);
            if (DataRecord.HasColumn(row, "chrValor"))
                chrValor = Convert.ToString(row["chrValor"]);
        }

        public BEPayPalConfiguracion(IDataRecord row, int Tipo)
        {
            if (DataRecord.HasColumn(row, "chrCodigoConsultora"))
                chrCodigoConsultora = Convert.ToString(row["chrCodigoConsultora"]);
            if (DataRecord.HasColumn(row, "vchNombreCompleto"))
                vchNombreCompleto = Convert.ToString(row["vchNombreCompleto"]);
            if (DataRecord.HasColumn(row, "datSYSFechaCreacion"))
                datSYSFechaCreacion = Convert.ToDateTime(row["datSYSFechaCreacion"]);
            if (DataRecord.HasColumn(row, "mnyMontoAbono"))
                mnyMontoAbono = Convert.ToDecimal(row["mnyMontoAbono"]);
            if (DataRecord.HasColumn(row, "chrRETCodigoTransaccion"))
                chrRETCodigoTransaccion = Convert.ToString(row["chrRETCodigoTransaccion"]);
            if (DataRecord.HasColumn(row, "chrRETCodigoAutorizacionBancaria"))
                chrRETCodigoAutorizacionBancaria = Convert.ToString(row["chrRETCodigoAutorizacionBancaria"]);
            if (DataRecord.HasColumn(row, "chrUltimosNumeroTarjeta"))
                chrUltimosNumeroTarjeta = Convert.ToString(row["chrUltimosNumeroTarjeta"]);
            if (DataRecord.HasColumn(row, "chrSYSUsuarioCreacion"))
                chrSYSUsuarioCreacion = Convert.ToString(row["chrSYSUsuarioCreacion"]);
            if (DataRecord.HasColumn(row, "chrRETResultado"))
                chrRETResultado = Convert.ToString(row["chrRETResultado"]);
        }
    }
}
