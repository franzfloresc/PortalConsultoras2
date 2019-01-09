namespace Portal.Consultoras.Web.Models.Search.ResponseOferta.Estructura
{
    using System.Collections.Generic;

    public class Estrategia
    {
        public string _id { get; set; }
        public int EstrategiaId { get; set; }
        public int CodigoEstrategia { get; set; }
        public string CodigoCampania { get; set; }
        public bool Activo { get; set; }
        public string CUV2 { get; set; }
        public string DescripcionCUV2 { get; set; }
        public int Precio { get; set; }
        public int Precio2 { get; set; }
        public int Ganancia { get; set; }
        public string ImagenURL { get; set; }
        public int LimiteVenta { get; set; }
        public string TextoLibre { get; set; }
        public bool FlagNueva { get; set; }
        public int Orden { get; set; }
        public bool FlagEstrella { get; set; }
        public bool TieneVariedad { get; set; }
        public IList<Componente> Componentes { get; set; }
        public int TipoEstrategiaId { get; set; }
        public string DescripcionTipoEstrategia { get; set; }
        public string CodigoTipoEstrategia { get; set; }
        public string ImagenEstrategia { get; set; }
        public bool FlagActivo { get; set; }
        public bool FlagRecoPerfil { get; set; }
        public bool FlagMostrarImg { get; set; }
        public int MarcaId { get; set; }
        public string MarcaDescripcion { get; set; }
        public string CodigoProducto { get; set; }
        public bool IndicadorMontoMinimo { get; set; }
        public bool EsSubCampania { get; set; }
        public IList<EstrategiaDetalle> EstrategiaDetalle { get; set; }
        public int DiaInicio { get; set; }
        public int FlagRevista { get; set; }
        public int TipoEstrategiaImagenMostrar { get; set; }
    }
}