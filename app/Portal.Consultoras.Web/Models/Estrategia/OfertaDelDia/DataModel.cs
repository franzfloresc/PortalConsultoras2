namespace Portal.Consultoras.Web.Models.Estrategia.OfertaDelDia
{
    using System;
    using System.Collections.Generic;
    [Serializable()]
    public class DataModel : ICloneable
    {
        public DataModel()
        {
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
        public int EstrategiaID { get; set; }
        public string ImagenBanner { get; set; }
        public string NombreOferta { get; set; }
        public string PrecioOfertaFormat { get; set; }
        #endregion

        public ConfiguracionSeccionHomeModel ConfiguracionContenedor { get; set; }
        public List<EstrategiaPersonalizadaProductoModel> ListaOferta { get; set; }
        public object Clone()
        {
            return this.MemberwiseClone();
        }
    }
}