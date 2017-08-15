using OpenSource.Library.DataAccess;
using Portal.Consultoras.Common;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace Portal.Consultoras.Entities.Cupon
{
    [DataContract]
    public class BECuponConsultora
    {
        [DataMember]
        public int CuponConsultoraId { get; set; }

        [DataMember]
        public string CodigoConsultora { get; set; }

        [DataMember]
        public int CampaniaId { get; set; }

        [DataMember]
        public int CuponId { get; set; }

        [DataMember]
        public decimal ValorAsociado { get; set; }

        [DataMember]
        public int EstadoCupon { get; set; }

        [DataMember]
        public bool EnvioCorreo { get; set; }

        [DataMember]
        public DateTime FechaCreacion { get; set; }

        [DataMember]
        public DateTime FechaModificacion { get; set; }

        [DataMember]
        public string UsuarioCreacion { get; set; }

        [DataMember]
        public string UsuarioModificacion { get; set; }

        [DataMember]
        public string TipoCupon { get; set; }

        public BECuponConsultora(IDataRecord datarec)
        {
            if (DataRecord.HasColumn(datarec, "CuponConsultoraId") && datarec["CuponConsultoraId"] != DBNull.Value)
                CuponConsultoraId = DbConvert.ToInt32(datarec["CuponConsultoraId"]);
            if (DataRecord.HasColumn(datarec, "CodigoConsultora") && datarec["CodigoConsultora"] != DBNull.Value)
                CodigoConsultora = DbConvert.ToString(datarec["CodigoConsultora"]);
            if (DataRecord.HasColumn(datarec, "CampaniaId") && datarec["CampaniaId"] != DBNull.Value)
                CampaniaId = DbConvert.ToInt32(datarec["CampaniaId"]);
            if (DataRecord.HasColumn(datarec, "CuponId") && datarec["CuponId"] != DBNull.Value)
                CuponId = DbConvert.ToInt32(datarec["CuponId"]);
            if (DataRecord.HasColumn(datarec, "ValorAsociado") && datarec["ValorAsociado"] != DBNull.Value)
                ValorAsociado = DbConvert.ToDecimal(datarec["ValorAsociado"]);
            if (DataRecord.HasColumn(datarec, "EstadoCupon") && datarec["EstadoCupon"] != DBNull.Value)
                EstadoCupon = DbConvert.ToInt32(datarec["EstadoCupon"]);
            if (DataRecord.HasColumn(datarec, "EnvioCorreo") && datarec["EnvioCorreo"] != DBNull.Value)
                EnvioCorreo = DbConvert.ToBoolean(datarec["EnvioCorreo"]);
            if (DataRecord.HasColumn(datarec, "FechaCreacion") && datarec["FechaCreacion"] != DBNull.Value)
                FechaCreacion = DbConvert.ToDateTime(datarec["FechaCreacion"]);
            if (DataRecord.HasColumn(datarec, "FechaModificacion") && datarec["FechaModificacion"] != DBNull.Value)
                FechaModificacion = DbConvert.ToDateTime(datarec["FechaModificacion"]);
            if (DataRecord.HasColumn(datarec, "UsuarioCreacion") && datarec["UsuarioCreacion"] != DBNull.Value)
                UsuarioCreacion = DbConvert.ToString(datarec["UsuarioCreacion"]);
            if (DataRecord.HasColumn(datarec, "UsuarioModificacion") && datarec["UsuarioModificacion"] != DBNull.Value)
                UsuarioModificacion = DbConvert.ToString(datarec["UsuarioModificacion"]);
            if (DataRecord.HasColumn(datarec, "TipoCupon") && datarec["TipoCupon"] != DBNull.Value)
                TipoCupon = DbConvert.ToString(datarec["TipoCupon"]);
        }
    }    
}
