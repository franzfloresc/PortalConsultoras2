using System;

namespace Portal.Consultoras.Web.Models
{
    public class EstrategiaProductoModel
    {
        public int EstrategiaProductoID { get; set; }
        public int EstrategiaID { get; set; }
        public int Campania { get; set; }
        public string CUV { get; set; }
        public string CodigoEstrategia { get; set; }
        public string Grupo { get; set; }
        public int Orden { get; set; }
        public string CUV2 { get; set; }
        public string SAP { get; set; }
        public int Cantidad { get; set; }
        public decimal Precio { get; set; }
        public decimal PrecioValorizado { get; set; }
        public Int16 Digitable { get; set; }
        public int FactorCuadre { get; set; }
        public string NombreProducto { get; set; }
        public string Descripcion1 { get; set; }
        public string ImagenProducto { get; set; }
        public Int16 IdMarca { get; set; }
        public string NombreMarca { get; set; }
        public string UsuarioCreacion { get; set; }
        public string UsuarioModificacion { get; set; }
        public string ImagenAnterior { get; set; }
        public Int16 Activo { get; set; }
    }
}