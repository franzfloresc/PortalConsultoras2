using System;

namespace Portal.Consultoras.Web.Models
{
    [Serializable]
    public class UsuarioExternoModel
    {
        public string CodigoUsuario { get; set; }
        public string Proveedor { get; set; }
        public string IdAplicacion { get; set; }
        public string Login { get; set; }
        public string Nombres { get; set; }
        public string Apellidos { get; set; }
        public string FechaNacimiento { get; set; }
        public string Correo { get; set; }
        public string Genero { get; set; }
        public string Ubicacion { get; set; }
        public string LinkPerfil { get; set; }
        public string FotoPerfil { get; set; }
        public DateTime FechaRegistro { get; set; }
        public int Estado { get; set; }
        public bool Redireccionar { get; set; }
    }
}