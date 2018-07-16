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
        public int campaniaID { get; set; }

        [DataMember]
        public string OpcionCorreoActiva { get; set; }
        [DataMember]
        public string OpcionSmsActiva { get; set; }
        [DataMember]
        public int HoraRestanteCorreo { get; set; }
        [DataMember]
        public int HoraRestanteSms { get; set; }
        [DataMember]
        public string CorreoEnmascarado { get; set; }
        [DataMember]
        public string CelularEnmascarado { get; set; }
        [DataMember]
        public int MostrarOpcion { get; set; }
        [DataMember]
        public string DescripcionHorario { get; set; }
        [DataMember]
        public string TelefonoCentral { get; set; }
        [DataMember]
        public string CodigoISO { get; set; }
        [DataMember]
        public int OrigenID { get; set; }
        [DataMember]
        public bool opcionHabilitar { get { return true; } set { } }
        [DataMember]
        public int CantidadEnvios { get; set; }
        [DataMember]
        public bool EsMobile { get; set; }
        [DataMember]
        public string MensajeSaludo { get; set; }

        [DataMember]
        public bool HabilitarChatEmtelco { get; set; }

        public BEUsuarioCorreo()
        { }

        public BEUsuarioCorreo(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "Cantidad"))
                Cantidad = Convert.ToInt32(row["Cantidad"]);
            if (DataRecord.HasColumn(row, "CodigoUsuario"))
                CodigoUsuario = Convert.ToString(row["CodigoUsuario"]);
            if (DataRecord.HasColumn(row, "NombreCompleto"))
                NombreCompleto = Convert.ToString(row["NombreCompleto"]);
            if (DataRecord.HasColumn(row, "PrimerNombre"))
                PrimerNombre = Convert.ToString(row["PrimerNombre"]);
            if (DataRecord.HasColumn(row, "Correo"))
                Correo = Convert.ToString(row["Correo"]);
            if (DataRecord.HasColumn(row, "Celular"))
                Celular = Convert.ToString(row["Celular"]);
            if (DataRecord.HasColumn(row, "ClaveSecreta"))
                Clave = Convert.ToString(row["ClaveSecreta"]);

            if (DataRecord.HasColumn(row, "ClaveSecreta") && row["Descripcion"] != DBNull.Value)
                Descripcion = Convert.ToString(row["Descripcion"]);
            if (DataRecord.HasColumn(row, "CodigoISO") && row["Descripcion"] != DBNull.Value)
                CodigoISO = Convert.ToString(row["CodigoISO"]);

            if (DataRecord.HasColumn(row, "TipoUsuario"))
                TipoUsuario = Convert.ToInt32(row["TipoUsuario"]);
            if (DataRecord.HasColumn(row, "IdEstadoActividad"))
                IdEstadoActividad = Convert.ToInt32(row["IdEstadoActividad"]);
            if (DataRecord.HasColumn(row, "TieneAutenticacion"))
                TieneAutenticacion = Convert.ToBoolean(row["TieneAutenticacion"]);
            if (DataRecord.HasColumn(row, "ZonaID"))
                ZonaID = Convert.ToInt32(row["ZonaID"]);
        }
    }
}
