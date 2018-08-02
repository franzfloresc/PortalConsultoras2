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
            IdPostulante = row.ToInt32("IdPostulante");
            CodigoUsuario = row.ToString("CodigoUsuario");
            ConsultoraID = row.ToInt64("ConsultoraID");
            NombreCompleto = row.ToString("NombreCompleto");
            NumeroDocumento = row.ToString("NumeroDocumento");
            Zona = row.ToString("Zona");
            Seccion = row.ToString("Seccion");
            Correo = row.ToString("Correo");
            EnvioCorreo = row.ToString("EnvioCorreo");
            UsuarioReal = row.ToString("UsuarioReal");
            FechaRegistro = row.ToDateTime("FechaRegistro");
            Estado = row.ToInt16("Estado");
            ZonaID = row.ToInt32("ZonaID");
            CodigoZona = row.ToString("CodigoZona");
            RegionID = row.ToInt32("RegionID");
            Region = row.ToString("CodigoRegion");
            MensajeDesktop = row.ToInt32("MensajeDesktop");
            MensajeMobile = row.ToInt32("MensajeMobile");
        }
    }
}
