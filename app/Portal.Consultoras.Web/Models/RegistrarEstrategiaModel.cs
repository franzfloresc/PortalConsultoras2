using System.Linq;
using Portal.Consultoras.Common;

namespace Portal.Consultoras.Web.Models
{
    public class RegistrarEstrategiaModel
    {
        public string EstrategiaID { get; set; }
        public string TipoEstrategiaID { get; set; }
        public string CampaniaID { get; set; }
        public string CampaniaIDFin { get; set; }
        public string NumeroPedido { get; set; }
        public string Activo { get; set; }
        public string ImagenURL { get; set; }
        public string LimiteVenta { get; set; }
        public string DescripcionCUV2 { get; set; }
        public string FlagDescripcion { get; set; }
        public string CUV { get; set; }
        public string EtiquetaID { get; set; }
        public string Precio { get; set; }
        public string FlagCEP { get; set; }
        public string CUV2 { get; set; }
        public string EtiquetaID2 { get; set; }
        public string Precio2 { get; set; }
        public string FlagCEP2 { get; set; }
        public string TextoLibre { get; set; }
        public string FlagTextoLibre { get; set; }
        public string Cantidad { get; set; }
        public string FlagCantidad { get; set; }
        public string Zona { get; set; }
        public string Orden { get; set; }
        public string ColorFondo { get; set; }
        public string FlagEstrella { get; set; }
        public string CodigoTipoEstrategia { get; set; }

        #region Lan
        public bool FlagIndividual { get; set; }
        public string Slogan { get; set; }

        public string ImgHomeDesktop { get; set; }
        public string ImgHomeMobile { get; set; }
        public string ImgFondoDesktop { get; set; }
        public string ImgFondoMobile { get; set; }
        public string ImgFichaDesktop { get; set; }
        public string ImgFichaFondoDesktop { get; set; }
        public string ImgFichaMobile { get; set; }
        public string ImgFichaFondoMobile { get; set; }

        public string UrlVideoDesktop { get; set; }
        public string UrlVideoMobile { get; set; }

        #endregion

        public string PrecioAnt { get; set; }
        public string Ganancia { get; set; }
        public bool EsOfertaIndependiente { get; set; }
        public string CodigoPrograma { get; set; }
        public string CodigoConcurso { get; set; }
        public string TipoConcurso { get; set; }
        public string RutaImagenCompleta { get; set; }
        public string ImagenMiniaturaURL { get; set; }
        public string ImagenMiniaturaURLAnterior { get; set; }
        public int EsSubCampania { get; set; }
        public string Niveles { get; set; }
        public int Imagen { get; set; }
    }
}