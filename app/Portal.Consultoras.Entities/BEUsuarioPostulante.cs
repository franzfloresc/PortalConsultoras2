using Portal.Consultoras.Common;
using System;
using System.Data;
using System.Runtime.Serialization;

namespace Portal.Consultoras.Entities
{
    [DataContract]
    public class BEUsuarioPostulante
    {
        [DataMember]
        public int IdPostulante { get; set; }
        [DataMember]
        public long ConsultoraID { get; set; }

        [DataMember]
        public string CodigoUsuario { get; set; }

        [DataMember]
        public string NombreCompleto { get; set; }

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

        [DataMember]
        public int ZonaID { get; set; }

        [DataMember]
        public int RegionID { get; set; }

        [DataMember]
        public string Region { get; set; }

        [DataMember]
        public int MensajeDesktop { get; set; }

        [DataMember]
        public int MensajeMobile { get; set; }

        [DataMember]
        public string CodigoZona { get; set; }

        public BEUsuarioPostulante()
        {

        }

        public BEUsuarioPostulante(IDataRecord row)
        {
            IdPostulante = Convert.ToInt32(row["IdPostulante"]);

            if (DataRecord.HasColumn(row, "CodigoUsuario") && row["CodigoUsuario"] != DBNull.Value)
                CodigoUsuario = Convert.ToString(row["CodigoUsuario"]);

            if (DataRecord.HasColumn(row, "ConsultoraID") && row["ConsultoraID"] != DBNull.Value)
                ConsultoraID = row["ConsultoraID"] == DBNull.Value ? 0 : Convert.ToInt64(row["ConsultoraID"]);

            if (DataRecord.HasColumn(row, "NumeroDocumento") && row["NumeroDocumento"] != DBNull.Value)
                NombreCompleto = Convert.ToString(row["NombreCompleto"]);

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

            if (DataRecord.HasColumn(row, "ZonaID") && row["ZonaID"] != DBNull.Value)
                ZonaID = Convert.ToInt32(row["ZonaID"]);

            if (DataRecord.HasColumn(row, "CodigoZona") && row["CodigoZona"] != DBNull.Value)
                CodigoZona  = Convert.ToString(row["CodigoZona"]);

            if (DataRecord.HasColumn(row, "RegionID") && row["RegionID"] != DBNull.Value)
                RegionID = Convert.ToInt32(row["RegionID"]);

            if (DataRecord.HasColumn(row, "CodigoRegion") && row["CodigoRegion"] != DBNull.Value)
                Region = Convert.ToString(row["CodigoRegion"]);

            if (DataRecord.HasColumn(row, "MensajeDesktop") && row["MensajeDesktop"] != DBNull.Value)
                MensajeDesktop = Convert.ToInt32(row["MensajeDesktop"]);

            if (DataRecord.HasColumn(row, "MensajeMobile") && row["MensajeMobile"] != DBNull.Value)
                MensajeMobile = Convert.ToInt32(row["MensajeMobile"]);

        }
    }
}
