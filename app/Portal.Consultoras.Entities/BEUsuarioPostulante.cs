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

        public BEUsuarioPostulante()
        {

        }

        public BEUsuarioPostulante(IDataRecord row)
        {
            IdPostulante = Convert.ToInt32(row["IdPostulante"]);

            if (DataRecord.HasColumn(row, "CodigoUsuario"))
                CodigoUsuario = Convert.ToString(row["CodigoUsuario"]);

            if (DataRecord.HasColumn(row, "ConsultoraID"))
                ConsultoraID = row["ConsultoraID"] == DBNull.Value ? 0 : Convert.ToInt64(row["ConsultoraID"]);

            if (DataRecord.HasColumn(row, "NumeroDocumento"))
                NombreCompleto = Convert.ToString(row["NombreCompleto"]);

            if (DataRecord.HasColumn(row, "NumeroDocumento"))
                NumeroDocumento = Convert.ToString(row["NumeroDocumento"]);

            if (DataRecord.HasColumn(row, "Zona"))
                Zona = Convert.ToString(row["Zona"]);

            if (DataRecord.HasColumn(row, "Seccion"))
                Seccion = Convert.ToString(row["Seccion"]);

            if (DataRecord.HasColumn(row, "Correo"))
                Correo = Convert.ToString(row["Correo"]);

            if (DataRecord.HasColumn(row, "EnvioCorreo"))
                EnvioCorreo = Convert.ToString(row["EnvioCorreo"]);

            if (DataRecord.HasColumn(row, "UsuarioReal"))
                UsuarioReal = Convert.ToString(row["UsuarioReal"]);

            if (DataRecord.HasColumn(row, "FechaRegistro"))
                FechaRegistro = Convert.ToDateTime(row["FechaRegistro"]);

            if (DataRecord.HasColumn(row, "Estado"))
                Estado = Convert.ToInt16(row["Estado"]);

            if (DataRecord.HasColumn(row, "ZonaID"))
                ZonaID = Convert.ToInt32(row["ZonaID"]);

            if (DataRecord.HasColumn(row, "RegionID"))
                RegionID = Convert.ToInt32(row["RegionID"]);

            if (DataRecord.HasColumn(row, "CodigoRegion"))
                Region = Convert.ToString(row["CodigoRegion"]);

            if (DataRecord.HasColumn(row, "MensajeDesktop"))
                MensajeDesktop = Convert.ToInt32(row["MensajeDesktop"]);

            if (DataRecord.HasColumn(row, "MensajeMobile"))
                MensajeMobile = Convert.ToInt32(row["MensajeMobile"]);

        }
    }
}
