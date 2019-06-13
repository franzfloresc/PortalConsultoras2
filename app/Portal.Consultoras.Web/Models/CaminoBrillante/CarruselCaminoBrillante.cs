using System.Collections.Generic;
using Portal.Consultoras.Common;

namespace Portal.Consultoras.Web.Models.CaminoBrillante
{
    public class CarruselCaminoBrillanteModel
    {
        public List<OfertaCaminoBrillanteModel> Items { get; set; }
        public bool VerMas { get; set; }
    }

    public class OfertaCaminoBrillanteModel
    {
        public string CodigoEstrategia
        {
            get
            {
                return TipoOferta == 1 ? "036" : "035";
            }
        }

        public string CUV2
        {
            get
            {
                return CUV.ToString();
            }
        }

        public int TipoOferta { get; set; }

        public string PaisISO { private get; set; }
        public int CampaniaID { get; set; }

        public int EstrategiaID { get; set; }
        public int TipoEstrategiaID { get; set; }

        public string CUV { get; set; }
        public string DescripcionCUV { get; set; }
        public string DescripcionCortaCUV { get; set; }

        public int MarcaID { get; set; }
        public string CodigoMarca { get; set; }
        public string DescripcionMarca { get; set; }

        public string CodigoNivel { get; set; }
        public string DescripcionNivel { get; set; }

        public decimal PrecioValorizado { get; set; }
        public decimal PrecioCatalogo { get; set; }
        public decimal Ganancia { get; set; }

        public string FotoProductoSmall { get; set; }
        public string FotoProductoMedium { get; set; }

        public bool FlagSeleccionado { get; set; }
        public int FlagDigitable { get; set; }
        public bool FlagHabilitado { get; set; }
        public bool FlagHistorico { get; set; }

        public int EsCatalogo { get; set; }


        public string FotoTagEnable
        {
            get
            {
                if (CodigoNivel != null && Constantes.CaminoBrillante.Niveles.Etiquetas.ContainsKey(CodigoNivel))
                    return Constantes.CaminoBrillante.Niveles.Etiquetas[CodigoNivel][1];
                return null;
            }
        }
        public string FotoTagDisable
        {
            get
            {
                if (CodigoNivel != null &&  Constantes.CaminoBrillante.Niveles.Etiquetas.ContainsKey(CodigoNivel))
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