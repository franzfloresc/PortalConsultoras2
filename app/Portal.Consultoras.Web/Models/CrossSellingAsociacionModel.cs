using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Portal.Consultoras.Web.Models
{
    public class CrossSellingAsociacionModel
    {
        public int CrossSellingAsociacionID { get; set; }
        public int PaisID { get; set; }
        public int NroOrden { get; set; }
        public string CodigoCampania { get; set; }
        public string CUV { get; set; }
        public string Descripcion { get; set; }
        public decimal PrecioOferta { get; set; }
        public string CUVAsociado { get; set; }
        public string CUVAsociado2 { get; set; }
        public string CodigoSegmento { get; set; }
        public int CampaniaID { get; set; }
		public string EtiquetaPrecio { get; set; }//1673CC
        public IEnumerable<PaisModel> lstPais { get; set; }
        public IEnumerable<CampaniaModel> lstCampania { get; set; }
        public IEnumerable<CrossSellingProductoModel> lstCrossSellingProducto { get; set; }


    }
}