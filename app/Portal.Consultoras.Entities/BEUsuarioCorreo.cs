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
        public string CodigoConsultora { get; set; }
        [DataMember]
        public string NombreCompleto { get; set; }
        [DataMember]
        public string PrimerNombre { get; set; }
        [DataMember]
        public string Correo { get; set; }
        [DataMember]
        public string Celular { get; set; }
        [DataMember]
        public string Clave { get; set; }
        [DataMember]
        public string Descripcion { get; set; }
        [DataMember]
        public int TipoUsuario { get; set; }
        [DataMember]
        public int IdEstadoActividad { get; set; }
        [DataMember]
        public bool TieneAutenticacion { get; set; }
        [DataMember]
        public int ZonaID { get; set; }
        [DataMember]
        public int MostrarOpcion { get; set; }
        [DataMember]
        public string DescripcionHorario { get; set; }
        [DataMember]
        public string TelefonoCentral { get; set; }
        [DataMember]
        public string CodigoISO { get; set; }

        public BEUsuarioCorreo()
        { }

        public BEUsuarioCorreo(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "Cantidad") && row["Cantidad"] != DBNull.Value)
                Cantidad = Convert.ToInt32(row["Cantidad"]);
            if (DataRecord.HasColumn(row, "CodigoUsuario") && row["CodigoUsuario"] != DBNull.Value)
                CodigoUsuario = Convert.ToString(row["CodigoUsuario"]);
            if (DataRecord.HasColumn(row, "NombreCompleto") && row["NombreCompleto"] != DBNull.Value)
                NombreCompleto = Convert.ToString(row["NombreCompleto"]);
            if (DataRecord.HasColumn(row, "PrimerNombre") && row["PrimerNombre"] != DBNull.Value)
                PrimerNombre = Convert.ToString(row["PrimerNombre"]);
            if (DataRecord.HasColumn(row, "Correo") && row["Correo"] != DBNull.Value)
                Correo = Convert.ToString(row["Correo"]);
            if (DataRecord.HasColumn(row, "Celular") && row["Celular"] != DBNull.Value)
                Celular = Convert.ToString(row["Celular"]);
            if (DataRecord.HasColumn(row, "ClaveSecreta") && row["ClaveSecreta"] != DBNull.Value)
                Clave = Convert.ToString(row["ClaveSecreta"]);
            if (DataRecord.HasColumn(row, "ClaveSecreta") && row["Descripcion"] != DBNull.Value)
                Descripcion = Convert.ToString(row["Descripcion"]);
            if (DataRecord.HasColumn(row, "CodigoISO") && row["Descripcion"] != DBNull.Value)
                CodigoISO = Convert.ToString(row["CodigoISO"]);
            if (DataRecord.HasColumn(row, "TipoUsuario") && row["TipoUsuario"] != DBNull.Value)
                TipoUsuario = Convert.ToInt32(row["TipoUsuario"]);
            if (DataRecord.HasColumn(row, "IdEstadoActividad") && row["IdEstadoActividad"] != DBNull.Value)
                IdEstadoActividad = Convert.ToInt32(row["IdEstadoActividad"]);
            if (DataRecord.HasColumn(row, "TieneAutenticacion") && row["TieneAutenticacion"] != DBNull.Value)
                TieneAutenticacion = Convert.ToBoolean(row["TieneAutenticacion"]);
            if (DataRecord.HasColumn(row, "ZonaID") && row["ZonaID"] != DBNull.Value)
                ZonaID = Convert.ToInt32(row["ZonaID"]);
        }
    }
}
