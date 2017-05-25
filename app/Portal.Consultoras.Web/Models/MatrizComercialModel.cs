using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Portal.Consultoras.Web.Models
{
    public class MatrizComercialModel
    {
        public int PaisID { get; set; }
        public int IdMatrizComercial { get; set; }
        public int IdMatrizComercialImagen { get; set; }
        public string CodigoSAP { get; set; }
        public string Foto { get; set; }
        public string DescripcionOriginal { get; set; }
        public string Descripcion { get; set; }
        public string UsuarioRegistro { get; set; }
        public string UsuarioModificacion { get; set; }
        public bool NemotecnicoActivo { get; set; }
        public IEnumerable<PaisModel> lstPais { get; set; }
    }

    public class MatrizComercialImagen
    {
        public int IdMatrizComercialImagen { get; set; }
        public string Foto { get; set; }
        public DateTime FechaRegistro { get; set; }
    }
}