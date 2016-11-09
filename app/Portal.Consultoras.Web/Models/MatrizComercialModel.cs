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
        public string FotoProducto04 { get; set; }
        public string FotoProducto05 { get; set; }
        public string FotoProducto06 { get; set; }
        public string FotoProducto07 { get; set; }
        public string FotoProducto08 { get; set; }
        public string FotoProducto09 { get; set; }
        public string FotoProducto10 { get; set; }
        public string FotoProductoAnterior01 { get; set; }
        public string FotoProductoAnterior02 { get; set; }
        public string FotoProductoAnterior03 { get; set; }
        public string FotoProductoAnterior04 { get; set; }
        public string FotoProductoAnterior05 { get; set; }
        public string FotoProductoAnterior06 { get; set; }
        public string FotoProductoAnterior07 { get; set; }
        public string FotoProductoAnterior08 { get; set; }
        public string FotoProductoAnterior09 { get; set; }
        public string FotoProductoAnterior10 { get; set; }
        public string UsuarioRegistro { get; set; }
        public string UsuarioModificacion { get; set; }
        public IEnumerable<PaisModel> lstPais { get; set; }
    }
}