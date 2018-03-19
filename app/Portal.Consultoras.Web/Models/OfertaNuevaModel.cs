using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models
{
    public class OfertaNuevaModel
    {
        public IEnumerable<CampaniaModel> listaCampania { set; get; }
        public IEnumerable<PaisModel> listaPaises { set; get; }

        public int OfertaNuevaId { set; get; }
        public int PaisID { set; get; }
        public int MarcaID { set; get; }
        public int IndicadorMontoMinimo { set; get; }
        public string DescripcionProd { set; get; }
        public int CampaniaID { set; get; }
        public int CampaniaIDFin { set; get; }
        public string Simbolo { set; get; }
        public string PaisNombre { set; get; }
        public string NumeroPedido { set; get; }
        public string CUV { set; get; }
        public string Descripcion { set; get; }
        public decimal PrecioNormal { set; get; }
        public decimal PrecioParaTi { set; get; }
        public int UnidadesPermitidas { set; get; }
        public bool FlagHabilitarOferta { set; get; }
        public short FlagImagenActiva { set; get; }
        public string ImagenProducto01 { set; get; }
        public string ImagenProducto02 { set; get; }
        public string ImagenProducto03 { set; get; }
        public string ImagenProductoAnterior01 { set; get; }
        public string ImagenProductoAnterior02 { set; get; }
        public string ImagenProductoAnterior03 { set; get; }
        public string UsuarioRegistro { set; get; }
        public string UsuarioModificacion { set; get; }
        public string DescripcionMarca { get; set; }
        public int IndicadorPedido { get; set; }
        public decimal ganahasta { set; get; }
    }
}