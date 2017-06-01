using OpenSource.Library.DataAccess;
using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities.Cupon
{
    [DataContract]
    public class BECupon
    {
        [DataMember]
        public int CuponId { get; set; }
        [DataMember]
        public string Tipo { get; set; }
        [DataMember]
        public string Descripcion { get; set; }
        [DataMember]
        public int CampaniaId { get; set; }
        [DataMember]
        public bool Estado { get; set; }
        [DataMember]
        public DateTime FechaCreacion { get; set; }
        [DataMember]
        public DateTime FechaModificacion { get; set; }
        [DataMember]
        public string UsuarioCreacion { get; set; }
        [DataMember]
        public string UsuarioModificacion { get; set; }

        public BECupon(IDataRecord datarec)
        {
            if (DataRecord.HasColumn(datarec, "CuponId") && datarec["CuponId"] != DBNull.Value)
                CuponId = DbConvert.ToInt32(datarec["CuponId"]);
            if (DataRecord.HasColumn(datarec, "Tipo") && datarec["Tipo"] != DBNull.Value)
                Tipo = DbConvert.ToString(datarec["Tipo"]);
            if (DataRecord.HasColumn(datarec, "Descripcion") && datarec["Descripcion"] != DBNull.Value)
                Descripcion = DbConvert.ToString(datarec["Descripcion"]);
            if (DataRecord.HasColumn(datarec, "CampaniaId") && datarec["CampaniaId"] != DBNull.Value)
                CampaniaId = DbConvert.ToInt32(datarec["CampaniaId"]);
            if (DataRecord.HasColumn(datarec, "Estado") && datarec["Estado"] != DBNull.Value)
                Estado = DbConvert.ToBoolean(datarec["Estado"]);
            if (DataRecord.HasColumn(datarec, "FechaCreacion") && datarec["FechaCreacion"] != DBNull.Value)
                FechaCreacion = DbConvert.ToDateTime(datarec["FechaCreacion"]);
            if (DataRecord.HasColumn(datarec, "FechaModificacion") && datarec["FechaModificacion"] != DBNull.Value)
                FechaModificacion = DbConvert.ToDateTime(datarec["FechaModificacion"]);
            if (DataRecord.HasColumn(datarec, "UsuarioCreacion") && datarec["UsuarioCreacion"] != DBNull.Value)
                UsuarioCreacion = DbConvert.ToString(datarec["UsuarioCreacion"]);
            if (DataRecord.HasColumn(datarec, "UsuarioModificacion") && datarec["UsuarioModificacion"] != DBNull.Value)
                UsuarioModificacion = DbConvert.ToString(datarec["UsuarioModificacion"]);
        }
    }
}