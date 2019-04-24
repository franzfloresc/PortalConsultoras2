using Portal.Consultoras.Common;

namespace Portal.Consultoras.Web.Models.CaminoBrillante
{
    public class DemostradorCaminoBrillanteModel
    {
        public string PaisISO { private get;  set; }
        public string CUV { get; set; }
        public string DescripcionCUV { get; set; }
        public int MarcaID { get; set; }
        public string DescripcionMarca { get; set; }
        public decimal PrecioValorizado { get; set; }
        public decimal PrecioCatalogo { get; set; }
        public string FotoProductoMedium { get; set; }
        public bool FlagSeleccionado { get; set; }
        public string PrecioValorizadoFormat
        {
            get
            {
                if (PaisISO != null)
                    return Util.DecimalToStringFormat(PrecioValorizado, PaisISO);
                return PrecioValorizado.ToString();
            }
        }
        public string PrecioCatalogoFormat
        {
            get
            {
                if (PaisISO != null)
                    return Util.DecimalToStringFormat(PrecioCatalogo, PaisISO);
                return PrecioCatalogo.ToString();
            }
        }
    }
}