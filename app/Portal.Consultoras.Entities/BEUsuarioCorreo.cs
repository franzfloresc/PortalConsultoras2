using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEUsuarioCorreo
    {
        [DataMember]
        public int Cantidad { get; set; }

        [DataMember]
        public string CodigoUsuario { get; set; }

        [DataMember]
        public string CodigoISO { get; set; }

        [DataMember]
        public string Descripcion { get; set; }

        [DataMember]
        public string Nombre { get; set; }

        [DataMember]
        public string Correo { get; set; }

        [DataMember]
        public string Clave { get; set; }

        [DataMember]
        public int TipoUsuario { get; set; }

        [DataMember]
        public int RolID { get; set; }

        public BEUsuarioCorreo()
        { }

        public BEUsuarioCorreo(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "Cantidad"))
                Cantidad = Convert.ToInt32(row["Cantidad"]);
            if (DataRecord.HasColumn(row, "CodigoUsuario"))
                CodigoUsuario = Convert.ToString(row["CodigoUsuario"]);
            if (DataRecord.HasColumn(row, "CodigoISO"))
                CodigoISO = Convert.ToString(row["CodigoISO"]);
            if (DataRecord.HasColumn(row, "Descripcion"))
                Descripcion = Convert.ToString(row["Descripcion"]);
            if (DataRecord.HasColumn(row, "Nombre"))
                Nombre = Convert.ToString(row["Nombre"]);
            if (DataRecord.HasColumn(row, "Correo"))
                Correo = Convert.ToString(row["Correo"]);
            if (DataRecord.HasColumn(row, "ClaveSecreta"))
                Clave = Convert.ToString(row["ClaveSecreta"]);
        }

    }
}
