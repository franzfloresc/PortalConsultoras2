namespace Portal.Consultoras.Web.Models.Estrategia.OfertaDelDia
{
    using System;
    using System.Collections.Generic;
    [Serializable()]
    public class DataModel
    {
        public DataModel()
        {
            //ListaDeOferta = new List<EstrategiaPedidoModel>();
            ListaOferta = new List<EstrategiaPersonalizadaProductoModel>();
            ConfiguracionContenedor = new ConfiguracionSeccionHomeModel();
        }

        public bool TieneOfertaDelDia { get; set; }
        public TimeSpan TeQuedan { get; set; }
        public string ColorFondo1 { get; set; }
        public string ColorFondo2 { get; set; }
        public string ImagenSoloHoy { get; set; }
        public bool TieneOfertas { get; set; }
        public string TextoVerDetalle { get; set; }

        #region campos de la primera estrategia
        public string ImagenBanner { get; set; }
        public string NombreOferta { get; set; }
        public string PrecioOfertaFormat { get; set; }
        #endregion

        public ConfiguracionSeccionHomeModel ConfiguracionContenedor { get; set; }
        public List<EstrategiaPersonalizadaProductoModel> ListaOferta { get; set; }
        public List<EstrategiaPedidoModel> ListaDeOferta { get; set; }
    }
}