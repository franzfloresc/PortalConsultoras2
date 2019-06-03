﻿namespace Portal.Consultoras.Web.Models
{
    public class PedidoCrudModel
    {
        public string CuvTonos { get; set; }

        public string CUV { get; set; }

        public string Cantidad { get; set; }

        public decimal PrecioUnidad { get; set; }

        public int EstrategiaID { get; set; }

        public int TipoEstrategiaID { get; set; }

        public int OrigenPedidoWeb { get; set; }

        public int MarcaID { get; set; }

        public string DescripcionProd { get; set; }

        public int TipoOfertaSisID { get; set; }

        public string IndicadorMontoMinimo { get; set; }

        public int ConfiguracionOfertaID { get; set; }

        public string ClienteID { set; get; }

        public string ClienteID_ { get; set; }

        public string ClienteDescripcion { get; set; }

        public bool OfertaWeb { get; set; }

        public bool EsSugerido { get; set; }

        public bool EsKitNueva { get; set; }

        public int TipoEstrategiaImagen { get; set; }

        public bool EsOfertaIndependiente { get; set; }

        public string FlagNueva { get; set; }

        public int LimiteVenta { get; set; }
        
        public bool EsCuponNuevas { get; set; }

        public bool EsKitNuevaAuto { get; set; }

        public bool EsEditable { get; set; }
        public int SetId { get; set; }

        public bool EsDuoPerfecto { get; set; }
        //INI HD-4200
        public bool EsSuscripcionSE{ get; set; }
        //FIN HD-4200
    }
}