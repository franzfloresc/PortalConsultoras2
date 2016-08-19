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
        public string CodigoSAP { get; set; }
        public string DescripcionOriginal { get; set; }
        public string Descripcion { get; set; }
        public string FotoProducto01 { get; set; }
        public string FotoProducto02 { get; set; }
        public string FotoProducto03 { get; set; }
        public string FotoProductoAnterior01 { get; set; }
        public string FotoProductoAnterior02 { get; set; }
        public string FotoProductoAnterior03 { get; set; }
        public string UsuarioRegistro { get; set; }
        public string UsuarioModificacion { get; set; }
        public IEnumerable<PaisModel> lstPais { get; set; }
    }
}