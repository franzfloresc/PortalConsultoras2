using Portal.Consultoras.Common;

namespace Portal.Consultoras.Web.Models.CaminoBrillante
{
    public class KitCaminoBrillanteModel
    {        
        public string CUV { get; set; }
        public string DescripcionCUV { get; set; }
        public int MarcaID { get; set; }
        public string DescripcionMarca { get; set; }
        public string CodigoNivel { get; set; }
        public decimal PrecioValorizado { get; set; }
        public decimal PrecioCatalogo { get; set; }
        public decimal Ganancia { get; set; }
        public string FotoProductoMedium { get; set; }
        public bool FlagSeleccionado { get; set; }
        public bool FlagHabilitado { get; set; }
        public string FotoTagEnable
        {
            get
            {
                if (Constantes.CaminoBrillante.Niveles.Etiquetas.ContainsKey(CodigoNivel))
                    return Constantes.CaminoBrillante.Niveles.Etiquetas[CodigoNivel][1];
                return null;
            }
        }
        public string FotoTagDisable
        {
            get
            {
                if (Constantes.CaminoBrillante.Niveles.Etiquetas.ContainsKey(CodigoNivel))
                    return Constantes.CaminoBrillante.Niveles.Etiquetas[CodigoNivel][0];
                return null;
            }
        }
    }
}