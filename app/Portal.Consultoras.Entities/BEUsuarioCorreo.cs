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
            Cantidad = row.ToInt32("Cantidad");
            CodigoUsuario = row.ToString("CodigoUsuario");
            NombreCompleto = row.ToString("NombreCompleto");
            PrimerNombre = row.ToString("PrimerNombre");
            Correo = row.ToString("Correo");
            Celular = row.ToString("Celular");
            Clave = row.ToString("ClaveSecreta");
            Descripcion = row.ToString("Descripcion");
            CodigoISO = row.ToString("CodigoISO");
            TipoUsuario = row.ToInt32("TipoUsuario");
            IdEstadoActividad = row.ToInt32("IdEstadoActividad");
            TieneAutenticacion = row.ToBoolean("TieneAutenticacion");
            ZonaID = row.ToInt32("ZonaID");
        }
    }
}
