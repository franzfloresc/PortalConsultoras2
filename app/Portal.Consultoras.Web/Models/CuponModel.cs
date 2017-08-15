using System;

namespace Portal.Consultoras.Web.Models
{
    public class CuponModel
    {
        public int CuponId { get; set; }
        public string Tipo { get; set; }
        public string Descripcion { get; set; }
        public int CampaniaId { get; set; }
        public bool Estado { get; set; }
        public DateTime FechaCreacion { get; set; }
        public DateTime FechaModificacion { get; set; }
        public string UsuarioCreacion { get; set; }
        public string UsuarioModificacion { get; set; }
    }
}