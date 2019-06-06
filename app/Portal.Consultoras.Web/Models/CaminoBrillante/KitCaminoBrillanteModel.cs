using Portal.Consultoras.Common;

namespace Portal.Consultoras.Web.Models.CaminoBrillante
{
    public class KitCaminoBrillanteModel
    {
        public string PaisISO { private get; set; }
        public int CampaniaID { get; set; }
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

        public string CodigoEstrategia
        {
            get
            {
                return "036";
            }
        }

        public string CUV2
        {
            get
            {
                return CUV.ToString();
            }
        }

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
        public string GananciaFormat
        {
            get
            {
                if (PaisISO != null)
                    return Util.DecimalToStringFormat(Ganancia, PaisISO);
                return Ganancia.ToString();
            }
        }
    }
}