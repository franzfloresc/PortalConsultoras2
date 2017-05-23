using System;

namespace Portal.Consultoras.Web.Models
{
    public class TipoEstrategiaModelo
    {
        public int TipoEstrategiaID { get; set; }
        public string DescripcionEstrategia { get; set; }
        public string ImagenEstrategia { get; set; }
        public int Orden { get; set; }
        public bool FlagActivo { get; set; }
        public string UsuarioRegistro { get; set; }
        public DateTime FechaRegistro { get; set; }
        public string UsuarioModificacion { get; set; }
        public DateTime FechaModificacion { get; set; }
        public int flagNueva { get; set; }
        public int flagRecoProduc { get; set; }
        public int flagRecoPerfil { get; set; }
        public string CodigoPrograma { get; set; }
        public int FlagMostrarImg { get; set; }
        public string Codigo { get; set; }
    }
}