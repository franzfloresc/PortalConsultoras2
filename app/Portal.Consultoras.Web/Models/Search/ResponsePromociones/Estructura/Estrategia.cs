using System.Collections.Generic;

namespace Portal.Consultoras.Web.Models.Search.ResponsePromociones.Estructura
{
    public class Estrategia
    {
        public int EstrategiaId { get; set; }
        public int CodigoEstrategia { get; set; }
        public string CodigoProducto { get; set; }
        public string TipoPersonalizacion { get; set; }
        public string CodigTipoOferta { get; set; }
        public string CodigoCampania { get; set; }

        public bool Activo { get; set; }
        public bool FlagConfig { get; set; }
        public bool FlagActivo { get; set; }
        public bool FlagImagenURL { get; set; }
        public bool FlagRecoPerfil { get; set; }
        public bool FlagMostrarImg { get; set; }

        public string CUV2 { get; set; }

        public string DescripcionCUV2 { get; set; }
        public string DescripcionCompleta { get; set; }
        public string DescripcionCortada { get; set; }

        public decimal Precio { get; set; }
        public decimal Precio2 { get; set; }
        public decimal PrecioPublico { get; set; }
        public decimal Ganancia { get; set; }
        public string PrecioTachado { get; set; }
        public string PrecioVenta { get; set; }
        public string GananciaString { get; set; }

        public string FotoProducto01 { get; set; }
        public string ImagenURL { get; set; }
        public string ImagenEstrategia { get; set; }
        public string ImagenEtiqueta { get; set; }
        public int TipoEstrategiaImagenMostrar { get; set; }

        public int LimiteVenta { get; set; }
        public string TextoLibre { get; set; }
        public bool FlagNueva { get; set; }
        public int Orden { get; set; }
        public int OrdenTipoOferta { get; set; }
        public bool FlagEstrella { get; set; }
        public bool TieneVariedad { get; set; }

        public int TipoEstrategiaId { get; set; }
        public string DescripcionTipoEstrategia { get; set; }
        public string CodigoTipoEstrategia { get; set; }

        public int MarcaId { get; set; }
        public string MarcaDescripcion { get; set; }

        public bool IndicadorMontoMinimo { get; set; }
        public bool EsSubCampania { get; set; }
        public int DiaInicio { get; set; }
        public int FlagRevista { get; set; }
        public string Niveles { get; set; }

        public string ProlCodCatalogo { get; set; }
        public string ProlPagCatalogo { get; set; }
        public string ProlIndPromocion  { get; set; }
        public string ProlFactorCuadre { get; set; }

        public int CantidadPack { get; set; }

        public bool TieneStock { get; set; }
    }
}