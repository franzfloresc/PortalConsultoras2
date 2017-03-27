using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using System.Runtime.Serialization;
using System.Data;
using Portal.Consultoras.Common;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEUsuarioPostulante
    {
        [DataMember]
        public int IdPostulante { get; set; }

        [DataMember]
        public string CodigoUsuario { get; set; }

        [DataMember]
        public string NombreCompleto { get; set; }

        //[DataMember]
        //public string TipoDocumento { get; set;}

        [DataMember]
        public string NumeroDocumento { get; set; }

        [DataMember]
        public string Zona { get; set; }

        [DataMember]
        public string Seccion { get; set; }

        [DataMember]
        public string Correo { get; set; }

        [DataMember]
        public string EnvioCorreo { get; set; }

        [DataMember]
        public string UsuarioReal { get; set; }

        [DataMember]
        public DateTime FechaRegistro { get; set; }

        [DataMember]
        public Int16 Estado { get; set; }

        public BEUsuarioPostulante(IDataRecord row)
        {
            IdPostulante = Convert.ToInt32(row["IdPostulante"]);

            if (DataRecord.HasColumn(row, "CodigoUsuario") && row["CodigoUsuario"] != DBNull.Value)
                CodigoUsuario = Convert.ToString(row["CodigoUsuario"]);

            if (DataRecord.HasColumn(row, "NumeroDocumento") && row["NumeroDocumento"] != DBNull.Value)
                NombreCompleto = Convert.ToString(row["NombreCompleto"]);

            //if (DataRecord.HasColumn(row, "TipoDocumento") && row["TipoDocumento"] != DBNull.Value)
            //    TipoDocumento = Convert.ToString(row["TipoDocumento"]);

            if (DataRecord.HasColumn(row, "NumeroDocumento") && row["NumeroDocumento"] != DBNull.Value)
                NumeroDocumento = Convert.ToString(row["NumeroDocumento"]);

            if (DataRecord.HasColumn(row, "Zona") && row["Zona"] != DBNull.Value)
                Zona = Convert.ToString(row["Zona"]);

            if (DataRecord.HasColumn(row, "Seccion") && row["Seccion"] != DBNull.Value)
                Seccion = Convert.ToString(row["Seccion"]);

            if (DataRecord.HasColumn(row, "Correo") && row["Correo"] != DBNull.Value)
                Correo = Convert.ToString(row["Correo"]);

            if (DataRecord.HasColumn(row, "EnvioCorreo") && row["EnvioCorreo"] != DBNull.Value)
                EnvioCorreo = Convert.ToString(row["EnvioCorreo"]);

            if (DataRecord.HasColumn(row, "UsuarioReal") && row["UsuarioReal"] != DBNull.Value)
                UsuarioReal = Convert.ToString(row["UsuarioReal"]);

            if (DataRecord.HasColumn(row, "FechaRegistro") && row["FechaRegistro"] != DBNull.Value)
                FechaRegistro = Convert.ToDateTime(row["FechaRegistro"]);

            if (DataRecord.HasColumn(row, "Estado") && row["Estado"] != DBNull.Value)
                Estado = Convert.ToInt16(row["Estado"]);

        }
    }
}
