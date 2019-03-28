using System;

namespace Portal.Consultoras.Web.Areas.Mobile.Models
{
    [Serializable()]
    public class PedidoWebDetalleMobilModel
    {
        public Int16 ClienteID { set; get; }

        public string Nombre { get; set; }

        public string eMail { get; set; }

        public int CampaniaID { set; get; }

        public string CUV { get; set; }

        public string DescripcionProd { get; set; }

        public string DescripcionLarga { get; set; }

        public string DescripcionEstrategia { get; set; }

        public string Categoria { get; set; }

        public int Cantidad { get; set; }

        public decimal PrecioUnidad { get; set; }

        public decimal ImporteTotal { get; set; }

        public decimal ImporteTotalPedido { get; set; }

        public int MarcaID { get; set; }

        public string DescripcionMarca { get; set; }

        public string ObservacionPROL { get; set; }

        public bool IndicadorOfertaCUV { get; set; }

        public int SetIdentifierNumber { get; set; }
    }
}