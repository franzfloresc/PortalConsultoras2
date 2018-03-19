using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models
{
    public class CrossSellingProductoModel
    {
        public int PaisID { get; set; }
        public int CrossSellingProductoID { get; set; }
        public int TipoOfertaSisID { get; set; }
        public int ConfiguracionOfertaID { get; set; }
        public int NroOrden { get; set; }
        public int CampaniaID { get; set; }
        public string CUV { get; set; }
        public string Descripcion { get; set; }
        public decimal PrecioOferta { get; set; }
        public string CodigoCampania { get; set; }
        public string MensajeProducto { get; set; }
        public string ImagenProducto { get; set; }
        public string ImagenProductoAnterior { get; set; }
        public string ISOPais { get; set; }
        public int FlagHabilitarProducto { get; set; }
        public string CodigoProducto { get; set; }
        public string CodigoTipoOferta { get; set; }
        public IEnumerable<PaisModel> lstPais { get; set; }
        public IEnumerable<CampaniaModel> lstCampania { get; set; }
    }
}