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
        public string CodigoEntrante { get; set; }

        [DataMember]
        public string CodigoUsuario { get; set; }

        [DataMember]
        public string CodigoISO { get; set; }

        [DataMember]
        public string Descripcion { get; set; }

        [DataMember]
        public string NombreCompleto { get; set; }

        [DataMember]
        public string Correo { get; set; }

        [DataMember]
        public string Clave { get; set; }

        [DataMember]
        public int TipoUsuario { get; set; }

        [DataMember]
        public int RolID { get; set; }

        [DataMember]
        public string Celular { get; set; }

        [DataMember]
        public string PrimerNombre { get; set; }

        [DataMember]
        public string NombreCampoCodigo { get; set; }

        [DataMember]
        public string TelefonoCentral { get; set; }

        [DataMember]
        public string descripcionHorario { get; set; }

        [DataMember]
        public string ContextoBase { get; set; }

        [DataMember]
        public string OpcionCorreoActiva { get; set; }

        [DataMember]
        public string OpcionSmsActiva { get; set; }

        [DataMember]
        public int HoraRestanteCorreo { get; set; }

        [DataMember]
        public int HoraRestanteSms { get; set; }

        [DataMember]
        public int IdEstadoActividad { get; set; }

        [DataMember]
        public int OrigenID { get; set; }

        [DataMember]
        public string codigoGenerado { get; set; }

        [DataMember]
        public bool opcionHabilitar { get; set; }

        [DataMember]
        public string tipoEnvio { get; set; }

        [DataMember]
        public bool EsMobile { get; set; }

        [DataMember]
        public string resultado { get; set; }

        public BEUsuarioCorreo()
        { }

        public BEUsuarioCorreo(IDataRecord row)
        {
            if (DataRecord.HasColumn(row, "Cantidad"))
                Cantidad = Convert.ToInt32(row["Cantidad"]);
            if (DataRecord.HasColumn(row, "CodigoEntrante"))
                CodigoEntrante = Convert.ToString(row["CodigoEntrante"]);
            if (DataRecord.HasColumn(row, "CodigoUsuario"))
                CodigoUsuario = Convert.ToString(row["CodigoUsuario"]);
            if (DataRecord.HasColumn(row, "CodigoISO"))
                CodigoISO = Convert.ToString(row["CodigoISO"]);
            if (DataRecord.HasColumn(row, "Descripcion"))
                Descripcion = Convert.ToString(row["Descripcion"]);
            if (DataRecord.HasColumn(row, "NombreCompleto"))
                NombreCompleto = Convert.ToString(row["NombreCompleto"]);
            if (DataRecord.HasColumn(row, "Correo"))
                Correo = Convert.ToString(row["Correo"]);
            if (DataRecord.HasColumn(row, "ClaveSecreta"))
                Clave = Convert.ToString(row["ClaveSecreta"]);
            if (DataRecord.HasColumn(row, "TipoUsuario"))
                TipoUsuario = Convert.ToInt32(row["TipoUsuario"]);
            if (DataRecord.HasColumn(row, "Celular"))
                Celular = Convert.ToString(row["Celular"]);
            if (DataRecord.HasColumn(row, "PrimerNombre"))
                PrimerNombre = Convert.ToString(row["PrimerNombre"]);
            if (DataRecord.HasColumn(row, "IdEstadoActividad"))
                IdEstadoActividad = Convert.ToInt32(row["IdEstadoActividad"]);
        }

    }
}
