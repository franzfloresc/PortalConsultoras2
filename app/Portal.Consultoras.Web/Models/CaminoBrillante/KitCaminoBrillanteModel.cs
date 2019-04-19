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
        public int OrigenPedidoWeb { get; set; }
        public string FotoTagEnable
        {
            get
            {
                if (Constantes.CaminoBrillante.EtiquetaNiveles.Iconos.ContainsKey(CodigoNivel))
                    return Constantes.CaminoBrillante.EtiquetaNiveles.Iconos[CodigoNivel][1];
                return null;
            }
        }
        public string FotoTagDisable
        {
            get
            {
                if (Constantes.CaminoBrillante.EtiquetaNiveles.Iconos.ContainsKey(CodigoNivel))
                    return Constantes.CaminoBrillante.EtiquetaNiveles.Iconos[CodigoNivel][0];
                return null;
            }
        }
    }
}