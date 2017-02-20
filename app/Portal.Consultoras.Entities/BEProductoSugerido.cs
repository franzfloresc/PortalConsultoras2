using OpenSource.Library.DataAccess;
using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEProductoSugerido
    {
        [DataMember]
        public int ProductoSugeridoID { get; set; }
        [DataMember]
        public int CampaniaID { get; set; }
        [DataMember]
        public string CUV { get; set; }
        [DataMember]
        public string CUVSugerido { get; set; }
        [DataMember]
        public int Orden { get; set; }
        [DataMember]
        public string ImagenProducto { get; set; }
        [DataMember]
        public int Estado { get; set; }
        [DataMember]
        public string UsuarioRegistro { get; set; }
        [DataMember]
        public DateTime FechaRegistro { get; set; }
        [DataMember]
        public string UsuarioModificacion { get; set; }
        [DataMember]
        public DateTime FechaModificacion { get; set; }

        public BEProductoSugerido(IDataRecord datarec)
        {
            if (DataRecord.HasColumn(datarec, "ProductoSugeridoID") && datarec["ProductoSugeridoID"] != DBNull.Value)
                ProductoSugeridoID = DbConvert.ToInt32(datarec["ProductoSugeridoID"]);
            if (DataRecord.HasColumn(datarec, "CampaniaID") && datarec["CampaniaID"] != DBNull.Value)
                CampaniaID = DbConvert.ToInt32(datarec["CampaniaID"]);
            if (DataRecord.HasColumn(datarec, "CUV") && datarec["CUV"] != DBNull.Value)
                CUV = DbConvert.ToString(datarec["CUV"]);
            if (DataRecord.HasColumn(datarec, "CUVSugerido") && datarec["CUVSugerido"] != DBNull.Value)
                CUVSugerido = DbConvert.ToString(datarec["CUVSugerido"]);
            if (DataRecord.HasColumn(datarec, "Orden") && datarec["Orden"] != DBNull.Value)
                Orden = DbConvert.ToInt32(datarec["Orden"]);
            if (DataRecord.HasColumn(datarec, "ImagenProducto") && datarec["ImagenProducto"] != DBNull.Value)
                ImagenProducto = DbConvert.ToString(datarec["ImagenProducto"]);

            if (DataRecord.HasColumn(datarec, "Estado") && datarec["Estado"] != DBNull.Value)
                Estado = DbConvert.ToInt32(datarec["Estado"]);

            if (DataRecord.HasColumn(datarec, "FechaRegistro") && datarec["FechaRegistro"] != DBNull.Value)
                FechaRegistro = DbConvert.ToDateTime(datarec["FechaRegistro"]);
            if (DataRecord.HasColumn(datarec, "UsuarioRegistro") && datarec["UsuarioRegistro"] != DBNull.Value)
                UsuarioRegistro = DbConvert.ToString(datarec["UsuarioRegistro"]);
            if (DataRecord.HasColumn(datarec, "FechaModificacion") && datarec["FechaModificacion"] != DBNull.Value)
                FechaModificacion = DbConvert.ToDateTime(datarec["FechaModificacion"]);
            if (DataRecord.HasColumn(datarec, "UsuarioModificacion") && datarec["UsuarioModificacion"] != DBNull.Value)
                UsuarioModificacion = DbConvert.ToString(datarec["UsuarioModificacion"]);
        }
    }
}
